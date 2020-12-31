class UsersController < ApplicationController
  protect_from_forgery except: [
      :login,
      :logout,
      :profile_setting_update,
      :skills_setting_update,
      :portfolios_setting_update,
      :invitations_setting_update,
      :email_setting_create,
      :email_setting_update,
      :password_setting_update,
      :sns_setting_update,
      :disconnect_twitter,
      :disconnect_github,
      :destroy,
      :invite,
      :invitations_answer,
      :twitter_post,
      :github_post,
  ]

  before_action :user_only, only: [
      :profile_setting_form,
      :profile_setting_update,
      :skills_setting_form,
      :skills_setting_update,
      :portfolios_setting_form,
      :portfolios_setting_update,
      :invitations_setting_form,
      :invitations_setting_update,
      :email_setting_form,
      :email_setting_update,
      :email_setting_create,
      :password_setting_form,
      :password_setting_update,
      :sns_setting_form,
      :sns_setting_update,
      :destroy_form,
      :destroy
  ]

  def index
    users = User.all

    if params[:q]
      users = users.reject{|user|
        r = true
        r = false if user.name.include? params[:q]
        r = false if user.description.include? params[:q]
        r
      }
    end

    if params[:roles]
      users = users.reject{|user|
        r = false
        roles = UserRole.where(user_id: user.id).pluck(:role_id)
        if params[:mode] == "and"
          params[:roles].each do |role|
            r = true unless roles.include? role.to_i
          end
        end
        if params[:mode] == "or"
          r = true
          params[:roles].each do |role|
            r = false if roles.include? role.to_i
          end
        end
        r
      }
    end

    wanted_users = []
    not_wanted_users = []

    users.each do |user|
      if user.wanted? @current_user
        wanted_users.append user
      else
        not_wanted_users.append user
      end
    end

    users = wanted_users + not_wanted_users

    page = 1
    if params[:p]
      page = params[:p].to_i
    end

    l = users.length - 1
    l = 0 if l < 0
    max_page = l / 10 + 1

    page = 1 if page < 1
    page = max_page if page > max_page

    index = 10 * page - 10

    shown_users = users[index, 10]
    @search_react_info = {
        q: params[:q] ||= "",
        roles: Role.all.order(sort_number: :asc).select(:id, :name),
        selectedRoles: params[:roles] ||= [],
        mode: params[:mode] ||= "and"
    }.as_json

    @pagination_react_info = {
        q: params[:q],
        roles: params[:roles],
        mode: params[:mode],
        page: page,
        maxPage: max_page
    }.as_json

    @info = {
        users: shown_users
    }
  end

  def show
    user = User.find_by(permalink: params[:permalink])
    @info = {
        user: {
            image: user.image.url,
            name: user.name,
            is_published_twitter: user.is_published_twitter,
            is_published_github: user.is_published_github,
            url: user.url,
            twitter_url: user.twitter_url,
            github_url: user.github_url,
            roles: user.roles,
            description: user.description,
            location: user.location,
            is_published_birth: user.is_published_birth,
            birth: user.birth.strftime("%Y年%m月%d日")
        },
        skills: Skill.where(user_id: user.id),
        portfolios: Portfolio.where(user_id: user.id),
        owner_projects: Project.where(owner_user_id: user.id),
        member_projects: [],
        positions: Position.where(id: UserPosition.where(user_id: user.id).pluck(:position_id)).order(sort_number: :asc).pluck(:name)
    }
  end

  def login_form
    raise Forbidden if @current_user
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:done] = "ようこそ、#{user.name}さん"
      redirect_to "/"
    else
      flash[:login_warning] = "メールアドレスもしくはパスワードが間違っています"
      redirect_to "/login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to "/"
  end

  def forgot_password_form

  end

  def signup_form

  end

  def signup
    permalink = params[:permalink]
    name = params[:name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password]
    agreement = params[:agreement]

    is_genuine = "true"

    if permalink == ""
      is_genuine = nil
      flash[:permalink_warning] = "入力してください"
    elsif permalink.length > 24
      is_genuine = nil
      flash[:permalink_warning] = "24字以内で入力してください"
    elsif !permalink.match(/^[0-9a-zA-Z\\-]*$/)
      is_genuine = nil
      flash[:permalink_warning] = "英数字およびハイフンのみ利用可能です"
    elsif User.find_by(permalink: permalink)
      is_genuine = nil
      flash[:permalink_warning] = "そのユーザーIDは既に使用されています"
    else
      flash[:permalink] = permalink
    end

    if name == ""
      is_genuine = nil
      flash[:name_warning] = "入力してください"
    elsif name.length > 24
      is_genuine = nil
      flash[:name_warning] = "24字以内で入力してください"
    else
      flash[:name] = name
    end

    if email == ""
      is_genuine = nil
      flash[:email_warning] = "入力してください"
    elsif !email.match(/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)
      is_genuine = nil
      flahs[:email_warning] = "メールアドレスを入力してください"
    elsif User.find_by(email: email)
      is_genuine = nil
      flash[:email_warning] = "そのメールアドレスは既に使用されています"
    else
      flash[:email] = email
    end

    if password.length < 8 || password.length > 32
      is_genuine = nil
      flash[:password_warning] = "8字以上、32字以下のパスワードを入力してください"
    else
      flash[:password] = password
    end

    if password != password_confirmation
      is_genuine = nil
      flash[:password_confirmation_warning] = "もう一度入力してください"
    else
      flash[:password_confirmation] = password_confirmation
    end

    if !agreement
      is_genuine = nil
      flash[:agreement_warning] = "利用規約に同意してください"
    else
      flash[:agreement] = true
    end

    if is_genuine
      hash_code = generate_random_token(32)
      number_1 = rand(9).to_s
      number_2 = rand(9).to_s
      number_3 = rand(9).to_s
      number_4 = rand(9).to_s
      number_5 = rand(9).to_s
      user = SignupConfirmation.new(
          hash_code: hash_code,
          permalink: permalink,
          name: name,
          email: email,
          password: password,
          confirmation_number_1: number_1,
          confirmation_number_2: number_2,
          confirmation_number_3: number_3,
          confirmation_number_4: number_4,
          confirmation_number_5: number_5
      )

      if user.save
        SignupConfirmationMailer.send_text(name, email, hash_code, number_1, number_2, number_3, number_4, number_5).deliver_now
        redirect_to("/signup/notice")
      else
        flash[:notice] = "新規登録に失敗しました"
        redirect_to("/signup")
      end
    else
      redirect_to("/signup")
    end
  end

  def signup_notice

  end

  def signup_confirmation
    @hash_code = params[:hash]
    unless SignupConfirmation.find_by(hash_code: @hash_code)
      redirect_to("/")
    end
  end

  def signup_confirm
    signup_confirmation = SignupConfirmation.find_by(hash_code: params[:hash_code])
    if signup_confirmation
      if true
        user = User.new(
            permalink: signup_confirmation.permalink,
            name: signup_confirmation.name,
            email: signup_confirmation.email,
            password: signup_confirmation.password,
            password_confirmation: signup_confirmation.password
        )
        if user.save
          signup_confirmation.destroy
          redirect_to("/")
        else
          redirect_to("/")
        end
      else
        redirect_to("/")
      end
    end

  end

  def signup_done

  end

  def confirm_exists_permalink
    if User.find_by(permalink: params[:permalink])
      render plain: "exists"
    else
      render plain: "vacant"
    end
  end

  def confirm_exists_email

    if User.find_by(email: params[:email])
      render plain: "exists"
    else
      render plain: "vacant"
    end
  end

  def profile_setting_form
    birth_year = 0
    birth_month = 0
    birth_day = 0
    image = "/NoUserImage.png"

    if @current_user.image
      image = @current_user.image.url
    end

    if @current_user.birth
      birth_year = @current_user.birth.strftime("%Y").to_i
      birth_month = @current_user.birth.strftime("%m").to_i
      birth_day = @current_user.birth.strftime("%d").to_i
    end

    @react_info = {
        permalink: flash[:permalink] ||= @current_user.permalink,
        permalinkWarning: flash[:permalink_warning],
        name: flash[:name] ||= @current_user.name,
        nameWarning: flash[:name_warning],
        image: image,
        description: flash[:description] ||= @current_user.description,
        descriptionWarning: flash[:description_warning],
        roles: Role.all.order(sort_number: :asc).select(:id, :name),
        userRoles: UserRole.where(user_id: @current_user.id).pluck(:role_id),
        location: flash[:location] ||= @current_user.location,
        locationWarning: flash[:location_warning],
        birth: {
            year: birth_year,
            month: birth_month,
            day: birth_day
        },
        isPublishedBirth: @current_user.is_published_birth ||= false,
        url: flash[:url] ||= @current_user.url,
        urlWarning: flash[:url_warning]
    }.as_json
  end

  def profile_setting_update
    user = User.find_by(id: session[:user_id])
    permalink = params[:permalink]
    image = params[:image]
    name = params[:name]
    roles = params[:roles] ||= []
    description = params[:description]
    location = params[:location]
    birth = DateTime.parse "#{params[:birth_year]}/#{params[:birth_month]}/#{params[:birth_day]}"
    is_birth_published = !params[:birth_published].nil?
    url = params[:url]

    is_accept = true

    if user.permalink != permalink
      if permalink == ""
        is_accept = false
        flash[:permalink_warning] = "入力してください"
      elsif Regexp.new("^[a-zA-Z0-9_]*$") !~ permalink
        is_accept = false
        flash[:permalink_warning] = "英数字およびハイフンのみ使用できます"
      elsif permalink.length > 100
        is_accept = false
        flash[:permalink_warning] = "ユーザーIDが長すぎます（100字以内で入力してください）"
      elsif User.find_by(permalink: permalink)
        is_accept = false
        flash[:permalink_warning] = "そのユーザーIDは既に使われています"
      else
        flash[:permalink] = permalink
      end
    end

    if name == ""
      is_accept = false
      flash[:name_warning] = "入力してください"
    elsif name.length > 100
      is_accept = false
      flash[:name_warning] = "ユーザー名が長すぎます（100字以内で入力してください）"
    else
      flash[:name] = name
    end

    if description.length > 240
      is_accept = false
      flash[:description_warning] = "240字以内で記述してください"
    else
      flash[:description] = description
    end

    if location.length > 100
      is_accept = false
      flash[:location_warning] = "所在地が長すぎます（100字以内で入力してください）"
    else
      flash[:location] = location
    end

    if url.length > 150
      is_accept = false
      flash[:url_warning] = "ホームページが長すぎます（150字以内で入力してください）"
    else
      flash[:url] = url
    end

    if is_accept
      user.permalink = permalink
      user.image = image if image
      user.name = name
      user.description = description
      user.location = location
      user.birth = birth
      user.is_published_birth = is_birth_published
      user.url = url

      user.save!

      prev_user_roles = UserRole.where(user_id: session[:user_id])
      prev_user_roles.each do |prev_user_role|
        prev_user_role.destroy!
      end

      roles.each do |role|
        new_role = UserRole.new(user_id: session[:user_id], role_id: role)
        new_role.save!
      end

      flash[:done] = "プロフィールを更新しました"
      redirect_to "/settings"
    else
      redirect_to "/settings"
    end


  end

  def skills_setting_form
    @react_info = {
        name: flash[:skills_name],
        nameWarning: flash[:skills_name_warning],
        level: flash[:skills_level],
        levelWarning: flash[:skills_level_warning],
        skills: Skill.where(user_id: session[:user_id])
    }.as_json

  end

  def skills_setting_update
    name = params[:name]
    level = params[:level]
    is_accept = true

    if name == ""
      is_accept = false
      flash[:skills_name_warning] = "入力してください"
    elsif name.length > 100
      is_accept = false
      flash[:skills_name_warning] = "スキル名が長すぎます（100字以内で入力してください）"
    else
      flash[:skills_name] = name
    end

    if level.length > 100
      is_accept = false
      flash[:skills_level_warning] = "レベルが長すぎます（100字以内で入力してください）"
    else
      flash[:skills_level] = level
    end

    if is_accept
      flash[:skills_name] = nil
      flash[:skills_name_warning] = nil
      flash[:skills_level] = nil
      flash[:skills_level_warning] = nil

      skill = Skill.find_by(name: name)
      skill = Skill.new(user_id: session[:user_id], name: name) if skill.nil?

      if level == ""
        skill.destroy!
      else
        skill.level = level
        skill.save!
      end

      flash[:done] = "スキルセットを更新しました"
      redirect_to "/settings/skills"
    else
      redirect_to "/settings/skills"
    end

  end

  def portfolios_setting_form
    @react_info = {
        portfolios: Portfolio.where(user_id: session[:user_id]).select(:id, :name, :image, :period, :description, :url),
        name: flash[:portfolio_name],
        nameWarning: flash[:portfolio_name_warning],
        period: flash[:portfolio_period],
        periodWarning: flash[:portfolio_period_warning],
        description: flash[:portfolio_description],
        descriptionWarning: flash[:portfolio_description_warning],
        url: flash[:portfolio_url],
        urlWarning: flash[:portfolio_url_warning]
    }
  end

  def portfolios_setting_update
    id = params[:id]
    name = params[:name]
    image = params[:image]
    period = params[:period]
    description = params[:description]
    url = params[:url]

    is_accept = true

    if name == "" and id == "0"
      is_accept = false
      flash[:portfolio_name_warning] = "入力してください"
    elsif name.length > 100
      is_accept = false
      flash[:portfolio_name_warning] = "ポートフォリオ名が長すぎます（100字以内で入力してください）"
    else
      flash[:portfolio_name] = name
    end

    if period.length > 100
      is_accept = false
      flash[:portfolio_period_warning] = "制作期間の入力が長すぎます（100字以内で入力してください）"
    else
      flash[:portfolio_period] = period
    end

    if true
      flash[:portfolio_description] = description
    end

    if url.length > 150
      is_accept = false
      flash[:portfolio_url_warning] = "URLが長すぎます（150字以内で入力してください）"
    else
      flash[:portfolio_url] = url
    end

    if is_accept
      if id == "0"
        portfolio = Portfolio.new(
            user_id: session[:user_id],
            name: name,
            image: image,
            period: period,
            description: description,
            url: url
        )

        portfolio.save!

        flash[:done] = "ポートフォリオを追加しました"
        redirect_to "/settings/portfolios"
      else
        if name == ""
          portfolio = Portfolio.find_by(id: id)

          portfolio.destroy!
          flash[:done] = "ポートフォリオを削除しました"
          redirect_to "/settings/portfolios"
        else
          portfolio = Portfolio.find_by(id: id)
          portfolio.name = name
          portfolio.image = image if image
          portfolio.period = period
          portfolio.description = description
          portfolio.url = url

          portfolio.save!
          flash[:done] = "ポートフォリオを更新しました"
          redirect_to "/settings/portfolios"
        end
      end
    else
      redirect_to "/settings/portfolios"
    end
  end

  def invitations_setting_form
    current_positions_ids = UserPosition.where(user_id: session[:user_id]).pluck(:position_id)
    current_positions_names = Position.where(id: current_positions_ids).order(sort_number: :asc).pluck(:name)
    current_roles = UserRole.where(user_id: session[:user_id]).pluck(:role_id)
    selectable_positions = Position.where(role_id: current_roles).order(sort_number: :asc).select(:id, :name)

    @react_info = {
        currentPositionsIds: current_positions_ids,
        currentPositionsNames: current_positions_names,
        selectablePositions: selectable_positions,
        defaultPosition: selectable_positions[0]
    }.as_json
  end

  def invitations_setting_update
    position_id = params[:position]

    position = UserPosition.find_by(user_id: session[:user_id], position_id: position_id)
    if position
      position.destroy!
      flash[:done] = "役割をリストから削除しました"
      redirect_to "/settings/invitations"
    else
      new_position = UserPosition.new(
          user_id: session[:user_id],
          position_id: position_id
      )
      new_position.save!
      flash[:done] = "役割をリストに追加しました"
      redirect_to "/settings/invitations"
    end
  end

  def email_setting_form
    if @current_user.email
      @react_info = {

      }.as_json
    else
      @react_info = {
          title: "メールアドレス設定"
      }.as_json
    end

  end

  def email_setting_update

  end

  def email_setting_create

  end

  def password_setting_form
    if @current_user.email
      @react_info = {

      }.as_json
    else
      @react_info = {
          title: "パスワード設定"
      }.as_json
    end
  end

  def password_setting_update

  end

  def sns_setting_form
    @react_info = {
        hasEmail: @current_user.email.present?,
        hasTwitter: @current_user.twitter_uid.present?,
        hasGitHub: @current_user.github_uid.present?,
        isPublishedTwitter: @current_user.is_published_twitter,
        isPublishedGitHub: @current_user.is_published_github,
        twitterWarning: flash[:sns_twitter_warning],
        githubWarning: flash[:sns_github_warning]
    }
  end

  def sns_setting_update
    user = User.find_by(id: session[:user_id])
    user.is_published_twitter = params[:is_publish_twitter].present?
    user.is_published_github = params[:is_publish_github].present?
    user.save!
    flash[:done] = "更新しました"
    redirect_to "/settings/sns"
  end

  def disconnect_twitter
    user = User.find_by(id: session[:user_id])
    if user.email || user.github_uid
      user.twitter_uid = nil
      user.twitter_url = nil
      user.is_published_twitter = nil
      user.save!
      flash[:done] = "Twitterとの連携を解除しました"
      redirect_to "/settings/sns"
    else
      flash[:sns_twitter_warning] = "Twitterとの連携を解除することはできません"
      redirect_to "/settings/sns"
    end
  end

  def disconnect_github
    user = User.find_by(id: session[:user_id])
    if user.email or user.twitter_uid
      user.github_uid = nil
      user.github_url = nil
      user.is_published_github = nil
      user.save!
      flash[:done] = "GitHubとの連携を解除しました"
      redirect_to "/settings/sns"
    else
      flash[:sns_github_warning] = "GitHubとの連携を解除することはできません"
      redirect_to "/settings/sns"
    end
  end

  def destroy_form
    @react_info = {
        isOwner: @current_user.owner?
    }
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    roles = UserRole.where(user_id: session[:user_id])
    skills = Skill.where(user_id: session[:user_id])
    portfolios = Portfolio.where(user_id: session[:user_id])
    projects = Project.where(owner_user_id: session[:user_id])

    user.destroy!

    roles.each do |role|
      role.destroy!
    end

    skills.each do |skill|
      skill.destroy!
    end

    portfolios.each do |portfolio|
      portfolio.destroy!
    end

    projects.each do |project|
      project.destroy!
    end

    session[:user_id] = nil
    flash[:done] = "アカウントを削除しました"
    redirect_to "/"
  end

  def invite_form
    @info = {
        user: User.find_by(permalink: params[:permalink]),
        projects: Project.where(owner_user_id: session[:user_id])
    }
  end

  def invite
    project_id = params[:project_id]
    user_id = params[:user_id]
    position_id = params[:position_id]

    user = User.find_by(id: user_id)

    invitation = UserInvitation.new(
        user_id: user_id,
        project_id: project_id,
        position_id: position_id,
        result_code: 1
    )

    invitation.save!

    flash[:done] = "#{user.name}を招待しました。"

    redirect_to "/users/#{user.permalink}/invite"
  end

  def invitations
    @invitations = UserInvitation.where(user_id: session[:user_id], result_code: 1)
  end

  def invitations_answer
    project_id = params[:project_id]
    user_id = params[:user_id]
    position_id = params[:position_id]
    result_code = params[:result_code]

    invitation = UserInvitation.find_by(project_id: project_id, user_id: user_id, position_id: position_id)

    invitation.result_code = result_code

    invitation.save!

    if result_code == "2"
      project_member = ProjectMember.new(
          project_id: project_id,
          user_id: user_id,
          position_id: position_id
      )

      project_member.save!

      flash[:done] = "招待を受諾しプロジェクトに加入しました"
    end

    if result_code == "3"
      flash[:done] = "招待を拒否しました"
    end

    redirect_to "/invitations"
  end

  def twitter_callback
    auth_hash = request.env["omniauth.auth"]
    @provider = auth_hash[:provider]
    @twitter_uid = auth_hash[:uid]
    @name = auth_hash[:info][:name]
    @image = auth_hash[:info][:image]
    @description = auth_hash[:info][:description]
    @url = auth_hash[:info][:urls][:Website]
    @twitter_url = auth_hash[:info][:urls][:Twitter]
    @location = auth_hash[:info][:location]
  end

  def github_callback
    auth_hash = request.env["omniauth.auth"]
    @provider = auth_hash[:provider]
    @github_uid = auth_hash[:uid]
    @name = auth_hash[:info][:name]
    @image = auth_hash[:info][:image]
    @description = auth_hash[:extra][:raw_info][:bio]
    @url = auth_hash[:info][:urls][:Blog]
    @github_url = auth_hash[:info][:urls][:GitHub]
    @location = auth_hash[:extra][:raw_info][:location]
  end

  def twitter_post
    if params[:provider] == "twitter"
      twitter_user = User.find_by(twitter_uid: params[:twitter_uid])
      if twitter_user
        if session[:user_id] # On Twitter Connection Error
          flash[:sns_twitter_warning] = "そのTwitterアカウントは既に使用されています"
          redirect_to "/settings/sns"
        else
          # On Login with Twitter
          session[:user_id] = twitter_user.id
          redirect_to "/"
        end
      else
        if session[:user_id] # On Twitter Connection
          user = User.find_by(id: session[:user_id])
          user.twitter_uid = params[:twitter_uid]
          user.twitter_url = params[:twitter_url]
          user.is_published_twitter = false

          user.save!
          flash[:done] = "Twitterと連携しました"
          redirect_to "/settings/sns"
        else
          permalink = generate_random_token(16)
          password = generate_random_token(32)
          new_user = User.new(
              permalink: permalink,
              name: params[:name],
              password: password,
              password_confirmation: password,
              remote_image_url: params[:image],
              url: params[:url],
              twitter_uid: params[:twitter_uid],
              twitter_url: params[:twitter_url],
              is_published_twitter: false,
              description: params[:description],
              location: params[:location]
          )

          new_user.save!
          flash[:done] = "GCMCへようこそ、#{new_user.name}さん"
          redirect_to "/"
        end
      end
    else
      raise StandardError
    end
  end

  def github_post
    if params[:provider] == "github"
      github_user = User.find_by(github_uid: params[:github_uid])
      if github_user # On GitHub Connection Error
        if session[:user_id]
          flash[:sns_github_warning] = "そのGitHubアカウントは既に使用されています"
          redirect_to "/settings/sns"
        else
          # On Login with GitHub
          session[:user_id] = github_user.id
          redirect_to "/"
        end
      else
        if session[:user_id]
          user = User.find_by(id: session[:user_id])
          user.github_uid = params[:github_uid]
          user.github_url = params[:github_url]
          user.is_published_github = false
          user.save!
          flash[:done] = "GitHubと連携しました"
          redirect_to "/settings/sns"
        else
          permalink = generate_random_token(16)
          password = generate_random_token(32)
          new_user = User.new(
              permalink: permalink,
              name: params[:name],
              password: password,
              password_confirmation: password,
              remote_image_url: params[:image],
              url: params[:url],
              github_uid: params[:github_uid],
              github_url: params[:github_url],
              is_published_github: false,
              description: params[:description],
              location: params[:location]
          )

          new_user.save!
          flash[:done] = "GCMCへようこそ、#{new_user.name}さん"
          redirect_to "/"
        end
      end
    else
      raise StandardError
    end
  end

  def auth_failure
    if session[:user_id]
      redirect_to "/settings/sns"
    else
      redirect_to "/"
    end
  end


  private

  def generate_random_token(length)
    r = ""
    (1..length).each do
      c = rand(36).to_s(36)
      r += c
    end
    r
  end
end
