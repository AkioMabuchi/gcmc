class UsersController < ApplicationController
  protect_from_forgery except: %w[login logout signup twitter_post github_post]

  def index
  end

  def show
  end

  def login_form
    raise Forbidden if @current_user
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/"
    else
      redirect_to "/"
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

  def sns_form

  end

  def sns_done

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
          flash[:twitter_connection_error] = "そのTwitterアカウントは既に使用されています"
          redirect_to "/settings/sns"
        else # On Login with Twitter
          session[:user_id] = twitter_user.id
          redirect_to "/"
        end
      else
        if session[:user_id] # On Twitter Connection
          user = User.find_by(id: session[:user_id])
          user.twitter_uid = params[:twitter_uid]
          user.twitter_url = params[:twitter_url]
          if user.save
            redirect_to "/settings/sns"
          else
            flash[:notice] = "Twitterとの連携に失敗しました"
            redirect_to "/settings/sns"
          end
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
              description: params[:description],
              location: params[:location]
          )

          if new_user.save
            redirect_to "/"
          else
            flash[:notice] = "Twitterでの新規登録に失敗しました"
            redirect_to "/signup"
          end
        end
      end
    else
      flash[:notice] = "Twitter認証に失敗しました"
      if session[:user_id]
        redirect_to "/settings/sns"
      else
        redirect_to "/sns"
      end
    end
  end

  def github_post
    if params[:provider] == "github"
      github_user = User.find_by(github_uid: params[:github_uid])
      if github_user # On GitHub Connection Error
        if session[:user_id]
          session[:github_connection_error] = "そのGitHubアカウントは既に使用されています"
          redirect_to("/settings/sns")
        else # On Login with GitHub
          session[:user_id] = github_user.id
          redirect_to("/users/user/#{github_user.permalink}")
        end
      else
        if session[:user_id]
          user = User.find_by(id: session[:user_id])
          user.github_uid = params[:github_uid]
          user.github_url = params[:github_url]
          if user.save
            redirect_to("/settings/sns/done")
          else
            redirect_to("/settings/sns")
          end
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
              description: params[:description],
              location: params[:location]
          )

          if new_user.save
            redirect_to("/signup/done")
          else
            flash[:notice] = "GitHubでの新規登録に失敗しました"
            redirect_to("/signup")
          end
        end
      end
    else
      flash[:notice] = "GitHub認証に失敗しました"
      if session[:user_id]
        redirect_to("/settings/sns")
      else
        redirect_to("/")
      end
    end
  end

  def auth_failure
    if session[:user_id]
      redirect_to("/settings/sns")
    else
      redirect_to("/")
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
