class ProjectsController < ApplicationController
  protect_from_forgery except: [:create]
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

    is_recordable = "true"

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
    @tags = Tag.all.order(sort_number: :asc).as_json(only: [:id, :name])
    @selected_tags = []
    @projects = []

    projects = Project.where(publish_code: 0).order(updated_at: :asc)
    if params[:query]
      if params[:query] != ""
        projects = projects.reject do |project|
          is_reject = true
          if project.title.index(params[:query])
            is_reject = false
          end
          if project.description.index(params[:query])
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
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
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

  def environment_setting_form
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
    end
  end

  def wants_setting_form
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
    end
  end

  def publish_setting_form
    @project = Project.find_by(permalink: params[:permalink])

    unless @project
      raise ActiveRecord::RecordNotFound
    end

    unless @project.owner_user.id == session[:user_id]
      raise Forbidden
    end
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

  def join_form
  end

  def join_requests_form
  end
end
