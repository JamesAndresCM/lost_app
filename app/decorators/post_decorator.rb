class PostDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def current_status
    if type_post_return?
      Post.human_enum_name(:post_returns)
    elsif type_post_wanted?
      Post.human_enum_name(:post_wanteds)
    end
  end

  def img_post
    if object.img?
      h.image_tag(object.img.url, alt: "#{object.title}" , title: "#{object.title}", id: 'post_prev', class:'img-fluid mt-2 avatar_profile')
    else 
      h.image_tag('fallback/default.jpg',  id: 'post_prev', class:'img-fluid mt-2 avatar_profile')
    end
  end

  def image_card(class_style)
    h.image_tag(object.img.url, alt: "#{object.title}" , title: "#{object.title}" , class: class_style)
  end

  def value_datetime
    if object.datetime_lost 
      datetime_lost
    else 
      DateTime.now.strftime("%d-%m-%Y %H:%M")
    end
  end

  def post_title
    object.title.capitalize
  end

  def datetime_lost
    object.datetime_lost.strftime("%d-%m-%Y %H:%M") 
  end

  def region_name
    "Región " + object.region.region_number + " " + object.region.name
  end

  def user_avatar
    object.user.avatar.url
  end

  #link_to not working https://github.com/nicolasblanco/sweet-alert2-rails/issues/8
  def delete_icon
    h.form_for object, method: :delete do
      h.button_tag class: 'btn btn-sm', 
      data: { 
        confirm: "estas seguro ?", 
        'sweet-alert-type': 'error', customClass: "Custom_Cancel" } do
        h.content_tag :i, nil, style: 'color: red', class: 'fa fa-trash'
      end
    end
  end

   def edit_icon(link_text = nil)
    delete_icon_filename = 'pencil-square-o'
    h.link_to h.fa_icon(delete_icon_filename) + link_text, 
              h.edit_post_path(object)
  end

  def time_ago
    h.timeago_tag object.created_at, nojs: true, force: true, lang: :es
  end
end
