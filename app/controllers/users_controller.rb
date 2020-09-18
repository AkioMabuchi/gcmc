class UsersController < ApplicationController
  protect_from_forgery :except => ["logout", "twitter_post", "github_post"]

  before_action :forbid_login_user, only: ["login_form","login","signup_form","signup"]


  def index
  end

  def show
  end

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])

    end
    redirect_to("/")
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end
  def forgot_password_form

  end

  def signup_form

  end

  def signup

  end

  def signup_done

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
          redirect_to("/settings/sns")
        else # On Login with Twitter
          session[:user_id] = twitter_user.id
          redirect_to("/users/#{twitter_user.permalink}")
        end
      else
        if session[:user_id] # On Twitter Connection
          user = User.find_by(id: session[:user_id])
          user.twitter_uid = params[:twitter_uid]
          user.twitter_url = params[:twitter_url]
          if user.save
            redirect_to("/settings/sns/done")
          else
            flash[:notice] = "Twitterとの連携に失敗しました"
            redirect_to("/settings/sns")
          end
        else
          permalink = generate_random_token(16)
          password = generate_random_token(32)
          new_user = User.new(
              permalink: permalink,
              is_certificated: true,
              is_premium: false,
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
            redirect_to("/signup/done")
          else
            flash[:notice] = "Twitterでの新規登録に失敗しました"
            redirect_to("/signup")
          end
        end
      end
    else
      flash[:notice] = "Twitter認証に失敗しました"
      if session[:user_id]
        redirect_to("/settings/sns")
      else
        redirect_to("/")
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
          redirect_to("/users/#{github_user.permalink}")
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
              is_certificated: true,
              is_premium: false,
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
    for _ in 1..length
      c = rand(36).to_s(36)
      r += c
    end
    return r
  end
end
