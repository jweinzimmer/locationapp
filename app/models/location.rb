class Location < ActiveRecord::Base
	geocoded_by :address
	#acts_as_gmappable
after_validation :geocode, :if => :address_changed?
  def gmaps4rails_address
    address
  end
end