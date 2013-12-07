class User < ActiveRecord::Base
  has_many :interests
  accepts_nested_attributes_for :interests, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
