class ProjectsController < ApplicationController
  protect_from_forgery except: [
      :create,
      :basic_setting_update,
      :tags_setting_update,
      :environment_setting_update,
      :wants_setting_update,
      :publish_setting_update
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
    @query = params[:q]
    @tags = Tag.all.order(sort_number: :asc).as_json(only: [:id, :name])
    @selected_tags = []
    @projects = []

    projects = Project.where(publish_code: 0).order(updated_at: :asc)
    if params[:q]
      if params[:q] != ""
        projects = projects.reject do |project|
          is_reject = true
          if project.title.index(params[:q])
            is_reject = false
          end
          if project.description.index(params[:q])
            is_reject = false
          end
          is_reject
        end
      end

      tags = params[:tags]
      tags = [] if tags.nil?
      tags.each do |tag|
        @selected_tags.append tag
      end
    else
      @tags.each do |tag|
        @selected_tags.append tag[:id]
      end
    end

    min_index = 0
    max_index = 4

    projects[min_index..max_index].each do |project|
      project_tags = []
      project.tags.each do |project_tag|
        project_tags.append project_tag.tag.name
      end
      shown_project = {
          project_permalink: project.permalink,
          project_image: project.image.url,
          tags: project_tags,
          title: project.title,
          description: project.description,
          user_permalink: project.owner_user.permalink,
          user_image: project.owner_user.image.url,
          user_name: project.owner_user.name,
          accesses: project.accesses,
          likes: project.likes,
          comments: project.comments,
          is_inviting: project.is_inviting
      }
      @projects.append shown_project
    end
  end

  def show
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end
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
    @project = Project.find_by(permalink: params[:permalink])
    @tags = Tag.all.order(sort_number: :asc).as_json(only: [:id, :name])

    selected_tags = ProjectTag.where(project_id: @project.id)
    @selected_tags = []

    selected_tags.each do |selected_tag|
      @selected_tags.append selected_tag.tag_id
    end

    puts @selected_tags

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
    end
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
        permalink: project.permalink
    }
  end

  def links_setting_update

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
  end

  def join_requests_form
  end
end
