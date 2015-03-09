class FacebookAccount < ActiveRecord::Base
  belongs_to :person
  validates_presence_of :uid, :person
  accepts_nested_attributes_for :person

  def self.find_or_create_for_facebook(auth)
    return nil if auth.nil?
    facebook_account = FacebookAccount.find_by_uid(auth["uid"])
    unless facebook_account
      first_name = auth["info"]["first_name"]
      last_name = auth["info"]["last_name"]
      person = Person.new(first_name: first_name, last_name: last_name)
      facebook_account = FacebookAccount.new(uid: auth["uid"], person: person)
      facebook_account.save
    end
    facebook_account
  end
end
