class Profile < ActiveRecord::Base
  belongs_to :user
  validate :first_last_name

  validates :gender, inclusion: { in: %w(male female),
    message: "Gender must be either male or female" }

  validate :sue_restriction

  def self.get_all_profiles(min_birth_year, max_birth_year)
    where("birth_year BETWEEN ? and ?", min_birth_year, max_birth_year).order(:birth_year)
  end

  private 
  def first_last_name
    if first_name.nil? && last_name.nil?
      errors.add(:first_name, 'Both first and last name cannot be null')
    end
  end

  def sue_restriction
    if first_name == "Sue" && gender == 'male'
      errors.add(:first_name, 'Sue cannot be a male')
    end
  end
end
