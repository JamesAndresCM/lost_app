class Post < ApplicationRecord
  # kaminari
  self.per_page = 10

  # relationships
  belongs_to :user, inverse_of: :posts
  belongs_to :district, inverse_of: :posts
  has_one :region, through: :district
  has_many :comments, as: :commentable, dependent: :destroy
  
  # scopes
  default_scope { order(created_at: :desc) }
  scope :lost_posts, -> { where(status: 0) }
  scope :found_posts, -> { where(status: 1) }
  scope :post_wanted, ->{ statuses.first(2).to_h }
  scope :post_return, ->{ statuses.to_a.last(2).to_h }
  scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  # delegates
  delegate :username, to: :user, prefix: true
  delegate :name, to: :district, prefix: true
  
  # friendly url
  extend FriendlyId
  friendly_id :title, use: :slugged

  # carrierwave uploader
  mount_uploader :img, ImgUploader

  # validations filters
  before_validation :capitalize_title
  before_validation :type_post_status
  validate :user_quota_posts, on: :create

  # enums
  enum category: { 
    object: 0, 
    animal: 1, 
    person: 2 
  }.freeze, _prefix: :category

  enum type_post: {
    return: 0,
    wanted: 1
  }.freeze, _prefix: :type_post

  enum status: { 
    lost: 0, 
    found: 1,
    received: 2,
    pending: 3
  }.freeze, _prefix: :status

  # validations
  validates :status, 
            inclusion: { in: post_return, 
              message: "status no valido, solo recibido y pendiente" }, 
              if: :type_post_return?, on: [:update, :create]
  
  validates :status, 
            inclusion: { in: post_wanted, 
              message: "status no valido, solo perdido y encontrado" }, 
              if: :type_post_wanted?, on: [:update, :create]

  validates :title, presence: true, uniqueness: { scope: :user_id },
            length: { in: 3..100 , message: 'mínimo 3 máximo 100 caracteres'},
            format: { with: /\A[a-zA-ZñÑáéíóúÁÉÍÓÚ0-9_ ]+\z/,
            message: 'solo números o letras' }

  validates :description, presence: true, length: { in: 3..300 , message: 'mínimo 3 máximo 100 caracteres'}
  validates :img, file_size: { less_than: 2.megabytes }
  validates :datetime_lost, presence: true
  #validate :datetime_lost_greater?

 

  validates :category, presence: true, inclusion: { in: categories.keys }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
  validates :type_post, presence: true, inclusion: { in: type_posts.keys }

  
private

  def capitalize_title
    self.title = title.capitalize if title?
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def datetime_lost_greater?
    if datetime_lost.blank?
      errors.add(:datetime_lost, "no puede estar vacio")
    elsif datetime_lost.to_date.year <= 2015
      errors.add(:datetime_lost, "el año debe ser mayor a 2015")
    end
  end

  def type_post_status
    if self.type_post_wanted?
      self.status ||= :lost
    elsif self.type_post_return?
      self.status ||= :pending
    end
  end


  def user_quota_posts
    if user.posts.today.size >= 5
      errors.add(:base, "limite excedido solo 5 publicaciones por día")
    end
  end

end
