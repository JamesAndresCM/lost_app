class HomeController < ApplicationController
  include Shared
  before_action :authenticate_user!

  def index
    post = paginate_post(Post.lost_posts)
    render template: "posts/index", locals: { post: post, title: "Perdidos" }
  end

end
