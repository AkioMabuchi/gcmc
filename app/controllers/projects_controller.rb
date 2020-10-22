class ProjectsController < ApplicationController
  protect_from_forgery except: %w[create]

  def index

    @projects = []

    (1..5).each do
      content = "加工するよ！"
      project = {
          project_permalink: "rpg",
          project_image: "/NoProjectImage.png",
          title: "ここにタイトルが入るよ！",
          content: content,
          user_permalink: "nil",
          user_image: "/NoUserImage.png",
          name: "username",
          accesses: 0,
          likes: 0,
          comments: 0,
          is_inviting: false
      }
      @projects.append project
    end
  end

  def show
  end

  def create_form
    raise Forbidden if @current_user.nil?
  end

  def create
    project = Project.new(
        permalink: params[:permalink],
        owner_user_id: session[:user_id],
        title: params[:title],
        image: params[:image],
        content: params[:content],
        engine: params[:engine],
        platform: params[:platform],
        genre: params[:genre],
        scale: params[:scare],
        features: params[:features],
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
