class PostsController < ApplicationController
  include Shared
  helper_method :post
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_post, only: %i(show edit destroy update)
  before_action :check_quota, only: %i(new create)
  before_action :check_status_post, only: %i(edit update)
  before_action :categories_post, only: %i(found lost)


  def index; end
  def show; end
  def edit; end
  def found; end
  def lost; end


  def new 
    @quantity = 5 - quantity_post
  end

  def destroy
    redirect_to posts_path, notice: 'La publicación ha sido destruída' if post.destroy
  end

  def create
    if post.save
      redirect_to posts_path, notice: 'La publicación ha sido creada correctamente'
    else
      render :new
    end
  end

  def update
    if post.update(post_params)
      redirect_to posts_path, notice: 'La publicación fue actualizada'
    else
      render :edit
    end
  end


  private

  def set_post
    begin
      @post = Post.friendly.find(params[:id]).decorate
    rescue
      redirect_to posts_path, notice: 'La publicación no ha sido encontrada'
    end
  end

  def post_params
    params.require(:post).permit(:title, 
                                  :user_id, 
                                  :district_id, 
                                  :description,
                                  :category,
                                  :img,
                                  :datetime_lost,
                                  :type_post,
                                  :img_cache,
                                  :status
                                )
  end

  def post
    @post ||=
    case action_name
    when "index"
      paginate_post(current_user.posts)
    when "new"
      Post.new
    when "create"
      current_user.posts.build(post_params)
    when "found"
      paginate_post(Post.found_posts.reorder(updated_at: :desc))
    when "lost"
      paginate_post(Post.lost_posts.reorder(updated_at: :desc))
    else
      set_post rescue nil
    end
  end

  def categories_post
    title = 
    case action_name
    when "found"
      "Encontrados"
    when "lost"
      "Perdidos"
    else
      nil
    end
    render template: "posts/index", locals: { post: post, title: title }
  end

  def quantity_post
    current_user.posts.today.size
  end

  def check_quota
    redirect_to root_path, notice: 'Límite excedido, solo 5 publicaciones por día' if quantity_post >= 5
  end

  def check_status_post
    redirect_to posts_path, notice: 'No permitido!' if (post.status_found? || post.status_received?)
  end
end
