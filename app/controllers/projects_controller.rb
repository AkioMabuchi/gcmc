class ProjectsController < ApplicationController
  protect_from_forgery except: %w[create]

  def index
    projects_raw = Project.where(is_published: true)
    projects = []

    if params[:query].nil?
      projects_raw.each do |project|
        projects.append project
      end
    elsif params[:query] == ""
    end
    @projects = []

    index_min = 0
    index_max = 4
    if params[:page]

    end

    projects[index_min..index_max].each do |project|
      shown_project = {
          project_permalink: project.permalink,
          project_image: project.image.url,
          title: project.title,
          content: project.content,
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
  end

  def create_form
    raise Forbidden if @current_user.nil?

    @engines = Engine.all.as_json(only: [:id, :name])
    @platforms = Platform.all.as_json(only: [:id, :name])
    @genres = Genre.all.as_json(only: [:id, :name])
    @scales = Scale.all.as_json(only: [:id, :name])

  end

  def create
    project = Project.new(
        permalink: params[:permalink],
        owner_user_id: session[:user_id],
        title: params[:title],
        image: params[:image],
        content: params[:content],
        engine_id: params[:engine],
        platform_id: params[:platform],
        genre_id: params[:genre],
        scale_id: params[:scale],
        is_published: true
    )

    if params[:is_not_adult]
      if project.save
        permalink = project.permalink
        redirect_to "/projects/#{permalink}"
      else
        redirect_to "/new"
      end
    else
      redirect_to "/new"
    end
  end

  def attends

  end

  def settings

  end
end
