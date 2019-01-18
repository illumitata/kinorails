class User < ApplicationRecord
  has_many :favourite_movies
  has_many :reservations

  validates_uniqueness_of :username
  validates_uniqueness_of :phone_number

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :username, \
  :length => { :in => 1..30 }, \
  allow_empty: false

  validates :name, \
  :length => { :in => 1..30 }, \
  allow_empty: false

  validates :surname, \
  :length => { :in => 1..30 }, \
  allow_empty: false

  validates :phone_number, \
  allow_empty: false, \
  format: { :with => /\A(\d{2}[ ])?\d{3}[ ]\d{2,3}[ ]\d{2,3}\z/, \
  :message => "Wrong phone number! The required format is: 'xx xxx xx[x] xx[x]'" }

  def set_default_role
    self.role ||= :user
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  # use this instead of email_changed? for Rails = 5.1.x
  def will_save_change_to_email?
    false
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end