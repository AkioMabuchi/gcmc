class ProjectsController < ApplicationController
  protect_from_forgery except: [
      :create,
      :basic_setting_update,
      :tags_setting_update,
      :links_setting_update,
      :environment_setting_update,
      :wants_setting_update,
      :publish_setting_update,
      :join,
      :join_requests_answer,
      :sample_projects
  ]

  def create_form
    unless @current_user
      raise Forbidden
    end
  end

  def create
    permalink = params[:permalink]
    title = params[:title]
    image = params[:image]
    description = params[:description]

    is_recordable = true

    if permalink == ""
      is_recordable = nil
      flash[:permalink_warning] = "入力してください"
    elsif Regexp.new("^[a-zA-Z0-9_]*$") !~ permalink
      is_recordable = nil
      flash[:permalink_warning] = "英数字およびハイフンのみ使用できます"
    elsif permalink.length > 100
      is_recordable = nil
      flash[:permalink_warning] = "プロジェクトIDが長すぎます（100字以下で入力してください）"
    elsif Project.find_by(permalink: permalink)
      is_recordable = nil
      flash[:permalink_warning] = "そのプロジェクトIDは既に使用されています"
    else
      flash[:permalink] = permalink
    end

    if title == ""
      is_recordable = nil
      flash[:title_warning] = "入力してください"
    elsif title.length > 200
      is_recordable = nil
      flash[:title_warning] = "タイトルが長すぎます（200字以下で入力してください）"
    else
      flash[:title] = title
    end

    unless params[:is_not_adult]
      is_recordable = nil
      flash[:is_not_adult_warning] = "同意してください"
    end

    if is_recordable
      project = Project.new(
          permalink: permalink,
          owner_user_id: session[:user_id],
          title: title,
          image: image,
          description: description,
          publish_code: 0
      )

      if project.save
        redirect_to "/projects/#{permalink}/settings"
      else
        redirect_to "/"
      end
    else
      redirect_to "/new"
    end

  end

  def mine
  end

  def index
    projects = Project.all.order(updated_at: :desc)

    inviting_projects = []
    non_inviting_projects = []

    current_user = User.find_by(id: session[:user_id])
    if current_user
      projects.each do |project|
        if project.invitable? current_user and project.owner_user_id.to_i != current_user.id.to_i
          inviting_projects.append project
        else
          non_inviting_projects.append project
        end
      end
    else
      non_inviting_projects = projects
    end

    projects = inviting_projects + non_inviting_projects

    if params[:p]
      page = params[:p].to_i
      if page < 1
        page = 1
      end
    else
      page = 1
    end

    l = projects.length
    if l < 0
      l = 0
    end
    max_page = l / 5 + 1

    if page > max_page
      page = max_page
    end

    index = 5 * page - 5
    shown_projects = []

    projects[index, 5].each do |project|
      description = project.description
      if description.size > 100
        description = description[0, 100]
        description += "..."
      end

      owner_user = project.owner_user

      if current_user
        if project.invitable? current_user and project.owner_user_id.to_i != current_user.id.to_i
          is_inviting = true
        else
          is_inviting = false
        end
      else
        is_inviting = false
      end
      shown_project = {
          permalink: project.permalink,
          image: project.image.url,
          tags: Tag.where(id: ProjectTag.where(project_id: project.id).pluck(:tag_id)).order(sort_number: :asc).pluck(:name),
          title: project.title,
          description: description,
          owner_user: {
              permalink: owner_user.permalink,
              image: owner_user.image.url,
              name: owner_user.name
          },
          is_inviting: is_inviting
      }
      shown_projects.append shown_project
    end

    @info = {
        projects: shown_projects
    }

    @search_react_info = {
        tags: Tag.all.order(sort_number: :asc)
    }.as_json

    @pagination_react_info = {
        query: params[:q],
        page: page,
        maxPage: max_page
    }.as_json
  end

  def show
    project = Project.find_by(permalink: params[:permalink])
    owner_user = User.find_by(id: project.owner_user_id)

    @info = {
        project: {
            permalink: project.permalink,
            image: project.image.url,
            tags: ProjectTag.where(project_id: project.id),
            created_at: project.created_at.strftime("%Y年%m月%d日"),
            updated_at: project.updated_at.strftime("%Y年%m月%d日"),
            title: project.title,
            description: project.description,
            links: ProjectLink.where(project_id: project.id),
            environment: {
                using_language: project.using_language.present? ? project.using_language : "未定",
                platform: project.platform.present? ? project.platform : "未定",
                source_tool: project.source_tool.present? ? project.source_tool : "未定",
                communication_tool: project.communication_tool.present? ? project.communication_tool : "未定",
                project_tool: project.project_tool.present? ? project.project_tool : "未定",
                period: project.period.present? ? project.period : "未定",
                frequency: project.frequency.present? ? project.frequency : "未定",
                location: project.location.present? ? project.location : "未定"
            },
            wants: ProjectWant.joins(:position).where(project_id: project.id).order(sort_number: :asc).select(:name, :amount)
        },
        owner_user: {
            permalink: owner_user.permalink,
            image: owner_user.image.url,
            name: owner_user.name
        },
        member_users: ProjectMember.where(project_id: project.id)
    }
  end

  def basic_setting_form
    project = Project.find_by(permalink: params[:permalink])

    unless project
      raise ActiveRecord::RecordNotFound
    end

    unless project.owner_user.id == session[:user_id]
      raise Forbidden
    end

    @new_permalink = flash[:new_permalink] ? flash[:new_permalink] : project.permalink
    @title = flash[:title] ? flash[:title] : project.title
    @image = project.image.url
    @description = flash[:description] ? flash[:description] : project.description
  end

  def basic_setting_update
    permalink = params[:permalink]
    new_permalink = params[:new_permalink]
    title = params[:title]
    image = params[:image]
    description = params[:description]

    is_recordable = true

    unless permalink == new_permalink
      if new_permalink == ""
        is_recordable = nil
        flash[:new_permalink_warning] = "入力してください"
      elsif Regexp.new("^[a-zA-Z0-9_]*$") !~ new_permalink
        is_recordable = nil
        flash[:new_permalink_warning] = "英数字およびハイフンのみ使用できます"
      elsif new_permalink.length > 100
        is_recordable = nil
        flash[:new_permalink_warning] = "プロジェクトIDが長すぎます（100字以下で入力してください）"
      elsif Project.find_by(permalink: new_permalink)
        is_recordable = nil
        flash[:new_permalink_warning] = "そのプロジェクトIDは既に使用されています"
      else
        flash[:new_permalink] = permalink
      end
    end


    if title == ""
      is_recordable = nil
      flash[:title_warning] = "入力してください"
    elsif title.length > 200
      is_recordable = nil
      flash[:title_warning] = "タイトルが長すぎます（200字以下で入力してください）"
    else
      flash[:title] = title
    end

    if is_recordable
      project = Project.find_by(permalink: permalink)
      project.permalink = new_permalink
      project.title = title
      project.image = image if image
      project.description = description

      if project.save
        flash[:done] = "更新しました"
        redirect_to "/projects/#{new_permalink}/settings"
      else
        flash[:notice] = "更新に失敗しました"
        redirect_to "/projects/#{permalink}/settings"
      end

    else
      redirect_to "/projects/#{permalink}/settings"
    end
  end

  def tags_setting_form
    project = Project.find_by(permalink: params[:permalink])

    @react_info = {
        permalink: project.permalink,
        tags: Tag.all.order(sort_number: :asc).select(:id, :name),
        selectedTags: ProjectTag.where(project_id: project.id).pluck(:tag_id)
    }.as_json

  end

  def tags_setting_update
    project = Project.find_by(permalink: params[:permalink])
    previous_tags = ProjectTag.where(project_id: project.id)
    previous_tags.each do |previous_tag|
      previous_tag.destroy
    end

    new_tags_id = params[:tags] ? params[:tags] : []
    new_tags_id.each do |new_tag_id|
      new_tag = ProjectTag.new(project_id: project.id, tag_id: new_tag_id)
      new_tag.save
    end

    redirect_to "/projects/#{project.permalink}/settings/tags"
  end

  def links_setting_form
    project = Project.find_by(permalink: params[:permalink])

    @react_info = {
        permalink: project.permalink,
        links: ProjectLink.where(project_id: project.id),
        name: flash[:links_name],
        nameWarning: flash[:links_name_warning],
        url: flash[:links_url],
        urlWarning: flash[:links_url_warning]
    }
  end

  def links_setting_update
    permalink = params[:permalink]
    name = params[:name]
    url = params[:url]

    project = Project.find_by(permalink: permalink)
    project_link = ProjectLink.find_by(project_id: project.id, name: name)
    is_accept = true

    if name == ""
      is_accept = false
      flash[:links_name_warning] = "入力してください"
    elsif name.length > 200
      is_accept = false
      flash[:links_name_warning] = "外部リンク名の入力が長すぎます（200字以内で入力してください）"
    else
      flash[:links_name] = name
    end

    if url == "" and project_link.nil?
      is_accept = false
      flash[:links_url_warning] = "リンクを削除しない場合は入力してください"
    elsif url.length > 200
      is_accept = false
      flash[:links_url_warning] = "URLの入力が長すぎます（200字以内で入力してください）"
    else
      flash[:links_url] = url
    end

    if is_accept
      flash[:links_name] = nil
      flash[:links_name_warning] = nil
      flash[:links_url] = nil
      flash[:links_url_warning] = nil

      if project_link
        if url == ""
          project_link.destroy!
          flash[:done] = "外部リンクを削除しました"
        else
          project_link.url = url
          project_link.save!
          flash[:done] = "外部リンクを更新しました"
        end
      else
        new_project_link = ProjectLink.new(
            project_id: project.id,
            name: name,
            url: url
        )
        new_project_link.save!
        flash[:done] = "外部リンクを追加しました。"
      end
    end

    redirect_to "/projects/#{permalink}/settings/links"
  end

  def environment_setting_form
    project = Project.find_by(permalink: params[:permalink])

    @react_info = {
        permalink: project.permalink,
        usingLanguage: flash[:environment_using_language] ||= project.using_language,
        usingLanguageWarning: flash[:environment_using_language_warning],
        platform: flash[:environment_platform] ||= project.platform,
        platformWarning: flash[:environment_platform_warning],
        sourceTool: flash[:environment_source_tool] ||= project.source_tool,
        sourceToolWarning: flash[:environment_source_tool_warning],
        communicationTool: flash[:environment_communication_tool] ||= project.communication_tool,
        communicationToolWarning: flash[:environment_communication_tool_warning],
        projectTool: flash[:environment_project_tool] ||= project.project_tool,
        projectToolWarning: flash[:environment_project_tool_warning],
        period: flash[:environment_period] ||= project.period,
        periodWarning: flash[:environment_period_warning],
        frequency: flash[:environment_frequency] ||= project.frequency,
        frequencyWarning: flash[:environment_frequency_warning],
        location: flash[:environment_location] ||= project.location,
        locationWarning: flash[:environment_location_warning]
    }
  end

  def environment_setting_update
    permalink = params[:permalink]
    using_language = params[:using_language]
    platform = params[:platform]
    source_tool = params[:source_tool]
    communication_tool = params[:communication_tool]
    project_tool = params[:project_tool]
    period = params[:period]
    frequency = params[:frequency]
    location = params[:location]

    is_accept = true

    if using_language.length > 100
      is_accept = false
      flash[:environment_using_language_warning] = "使用言語が長すぎます（100字以内で入力してください）"
    else
      flash[:environment_using_language] = using_language
    end

    if platform.length > 100
      is_accept = false
      flash[:environment_platform_warning] = "プラットフォームが長すぎます（100字以内で入力してください）"
    else
      flash[:environment_platform] = platform
    end

    if source_tool.length > 100
      is_accept = false
      flash[:environment_source_tool_warning] = "ソースコード管理ツールが長すぎます（100字以内で入力してください）"
    else
      flash[:environment_source_tool] = source_tool
    end

    if communication_tool.length > 100
      is_accept = false
      flash[:environment_communication_tool_warning] = "コミュニケーションツールが長すぎます（100字以内で入力してください）"
    else
      flash[:environment_communication_tool] = communication_tool
    end

    if project_tool.length > 100
      is_accept = false
      flash[:environment_project_tool_warning] = "プロジェクト管理ツールが長すぎます（100字以内で入力してください）"
    else
      flash[:environment_project_tool] = project_tool
    end

    if period.length > 100
      is_accept = false
      flash[:environment_period_warning] = "制作期間の入力が長すぎます（100字以内で入力してください）"
    else
      flash[:environment_period] = period
    end

    if frequency.length > 100
      is_accept = false
      flash[:environment_frequency_warning] = "制作頻度の入力が長すぎます（100字以内で入力してください）"
    else
      flash[:environment_frequency] = frequency
    end

    if location.length > 100
      is_accept = false
      flash[:environment_location_warning] = "場所が長すぎます（100字以内で入力してください）"
    else
      flash[:environment_location] = location
    end

    if is_accept
      flash[:environment_using_language] = nil
      flash[:environment_using_language_warning] = nil
      flash[:environment_platform] = nil
      flash[:environment_platform_warning] = nil
      flash[:environment_source_tool] = nil
      flash[:environment_source_tool_warning] = nil
      flash[:environment_communication_tool] = nil
      flash[:environment_communication_tool_warning] = nil
      flash[:environment_project_tool] = nil
      flash[:environment_project_tool_warning] = nil
      flash[:environment_period] = nil
      flash[:environment_period_warning] = nil
      flash[:environment_frequency] = nil
      flash[:environment_frequency_warning] = nil
      flash[:environment_location] = nil
      flash[:environment_location_warning] = nil

      project = Project.find_by(permalink: permalink)
      project.using_language = using_language
      project.platform = platform
      project.source_tool = source_tool
      project.communication_tool = communication_tool
      project.project_tool = project_tool
      project.period = period
      project.frequency = frequency
      project.location = location

      project.save!
      flash[:done] = "開発環境設定を更新しました"
      redirect_to "/projects/#{permalink}/settings/environment"
    else
      redirect_to "/projects/#{permalink}/settings/environment"
    end
  end

  def wants_setting_form
    project = Project.find_by(permalink: params[:permalink])

    @react_info = {
        permalink: project.permalink,
        wants: ProjectWant.joins(:position).where(project_id: project.id).order(sort_number: :asc).select(:name, :amount),
        positions: Position.all.order(sort_number: :asc).select(:id, :name),
        amountWarning: flash[:wants_amount_warning]
    }.as_json
  end

  def wants_setting_update

    permalink = params[:permalink]
    position = params[:position]
    amount = params[:amount]

    is_accept = true

    if amount.to_i < 0 or amount.to_i >= 100
      is_accept = false
      flash[:wants_amount_warning] = "0~99の値を入力してください"
    else
      flash[:wants_amount] = amount;
    end

    if is_accept
      project = Project.find_by(permalink: permalink)
      want = ProjectWant.find_by(project_id: project.id, position_id: position)
      if want
        if amount.to_i > 0
          want.amount = amount
          want.save!
        else
          want.destroy!
        end
      elsif amount.to_i > 0
        new_want = ProjectWant.new(
            project_id: project.id,
            position_id: position,
            amount: amount
        )

        new_want.save!
      end
      flash[:done] = "募集設定を更新しました"
      redirect_to "/projects/#{permalink}/settings/wants"
    else
      redirect_to "/projects/#{permalink}/settings/wants"
    end
  end

  def publish_setting_form
    project = Project.find_by(permalink: params[:permalink])

    @react_info = {
        permalink: project.permalink,
        publishCode: project.publish_code.to_s
    }
  end

  def publish_setting_update
    permalink = params[:permalink]

    project = Project.find_by(permalink: permalink)
    publish_code = params[:publish]

    project.publish_code = publish_code
    project.save!

    flash[:done] = "公開設定を更新しました"
    redirect_to "/projects/#{permalink}/settings/publish"
  end

  def destroy_form
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
    end
  end

  def destroy

  end

  def join_form
    project = Project.find_by(permalink: params[:permalink])
    owner_user = User.find_by(id: project.owner_user_id)

    if owner_user.id == session[:user_id]
      raise Forbidden
    end

    wants = ProjectWant.where(project_id: project.id)

    @info = {
        project: {
            permalink: project.permalink,
            image: project.image.url,
            title: project.title,
            owner_user: {
                permalink: owner_user.permalink,
                image: owner_user.image.url,
                name: owner_user.name
            },
            description: project.description
        },
        has_wants: wants.length > 0,
        has_request: JoinRequest.find_by(project_id: project.id, user_id: session[:user_id])
    }
    @react_info = {
        id: project.id,
        positions: ProjectWant.joins(:position).where(project_id: project.id).order(sort_number: :asc).select(:position_id, :name, :amount),
        permalink: project.permalink
    }
  end

  def join
    project = Project.find_by(id: params[:id])
    position_id = params[:position]

    join_request = JoinRequest.new(
        project_id: project.id,
        user_id: session[:user_id],
        position_id: position_id,
        result_code: 1
    )

    join_request.save!
    flash[:done] = "加入申請を行いました"

    redirect_to "/projects/#{project.permalink}/join"
  end

  def join_requests_form
    project = Project.find_by(permalink: params[:permalink])
    @requests = JoinRequest.where(project_id: project.id, result_code: 1)
  end

  def join_requests_answer
    permalink = params[:permalink]
    id = params[:id]
    result_code = params[:answer]

    join_request = JoinRequest.find_by(id: id)

    join_request.result_code = result_code

    join_request.save!

    if result_code == "2"
      member_user = ProjectMember.new(
          project_id: join_request.project_id,
          user_id: join_request.user_id,
          position_id: join_request.position_id
      )

      member_user.save!

      flash[:done] = "#{join_request.user.name}をプロジェクトに加入しました"
    end

    if result_code == "3"
      flash[:done] = "#{join_request.user.name}の加入申請を拒否しました"
    end

    redirect_to "/projects/#{permalink}/requests"
  end

  def sample_projects
    projects = Project.all
    positions = Position.all

    projects.each do |project|
      positions.each do |position|
        if rand(4) == 0
          project_want = ProjectWant.new(
              project_id: project.id,
              position_id: position.id,
              amount: 1
          )
          project_want.save!
        end
      end
    end

    redirect_to "/"
  end

  private

  def owner_only
    project = Project.find_by(permalink: params[:permalink])

    if project
      if project.owner_user_id != session[:user_id]
        raise Forbidden
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
