class Account < ActiveRecord::Base
  belongs_to :person
  attr_accessor :password, :password_confirmation

  accepts_nested_attributes_for :person

  validates_uniqueness_of :email
end
