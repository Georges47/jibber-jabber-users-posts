class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.where(replied_post_id: nil)

    posts = []

    @posts.newest_first.each do |post|
      user = User.find_by_keycloak_id(post.user.keycloak_id)
      posts << {
        id: post.id,
        text: post.deleted ? '' : post.content,
        user: {
          id: user.keycloak_id,
          displayName: user.display_name,
          username: user.username,
          avatar: user.avatar
        }
      }
    end

    render json: posts
  end

  # GET /posts/1
  def show
    replies = Post.oldest_first.where(replied_post_id: params['id']).map do |post|
      {
        id: post.id,
        text: post.deleted ? '' : post.content,
        user: {
          id: post.user.keycloak_id,
          displayName: post.user.display_name,
          username: post.user.username,
          avatar: post.user.avatar
        }
      }
    end

    post = {
      id: @post.id,
      text: @post.deleted ? '' : @post.content,
      user: {
        id: @post.user.keycloak_id,
        displayName: @post.user.display_name,
        username: @post.user.username,
        avatar: @post.user.avatar
      },
      thread: replies
    }

    render json: post
  end

  # POST /posts
  def create
    decoded_token = @decoded_token[0]
    user_keycloak_id = decoded_token['sub']
    user = User.find_by_keycloak_id(user_keycloak_id)

    @post = Post.new(
      content: params['text'],
      user: user
    )

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def reply
    decoded_token = @decoded_token[0]
    user_keycloak_id = decoded_token['sub']
    user = User.find_by_keycloak_id(user_keycloak_id)

    original_post_id = params['id']
    @post = Post.new(
      content: params['text'],
      user: user,
      replied_post_id: original_post_id
    )

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    decoded_token = @decoded_token[0]
    user_keycloak_id = decoded_token['sub']

    if @post.user.keycloak_id == user_keycloak_id
      @post.deleted = true
      @post.save
    end
  end

  def user_posts
    user_keycloak_id = params['id']
    user = User.find_by_keycloak_id(user_keycloak_id)

    posts = []
    @posts = Post
               .where(user_id: user.id)
               .where(replied_post_id: nil)
               .newest_first

    @posts.each do |post|
      posts << {
        id: post.id,
        text: post.deleted ? '' : post.content,
        user: {
          id: user.keycloak_id,
          displayName: user.display_name,
          username: user.username,
          avatar: user.avatar
        }
      }
    end

    render json: posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:text, post: [:post], user: [:id, :displayName, :username, :avatar])
    end
end
