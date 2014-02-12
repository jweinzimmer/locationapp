class LocationsController < ApplicationController
def index
if
 @locations = Location.all
  @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
  marker.lat location.latitude
  marker.lng location.longitude
  end
 if params[:location].present?
   @locations =Location.near(params[:location], params[:distance] || 10, order: :distance)
 elsif
  @locations =Location.all.geocoded
 end
    #@json = @locations.to_gmaps4rails
  end
end

  #if params[:search].present?
    #@locations = Location.near(params[:search], 50, :order => :distance)
  #else
   # @locations = Location.all
  #end
  def show
        result =request.location
    puts "#{result} is a go"
  @location = Location.find(params[:id])
  @location2 = @location.nearbys(10)
  @hash2 = Gmaps4rails.build_markers(@location2) do |location, marker|
  marker.lat location.latitude
  marker.lng location.longitude
end
  @hash = Gmaps4rails.build_markers(@location) do |location, marker|
  marker.lat location.latitude
  marker.lng location.longitude
end
  end

  def new
    @location = Location.new
  end

  def create
    # result = request.location
    #
    @location = Location.new(location_params)
    #binding.pry
    if !@location[:address].empty? && !params[:latitude]
      if @location.save
        flash[:notice] = 'ADDRESS SAVED'
        redirect_to @location
      end
    elsif
      @location = Location.new(:address => request_ip)
      if @location.save
        flash[:notice] = 'NEGATIVE'
        redirect_to @location
      end
  end
end
    def address_params?
      @location[:address]
    end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to @location, :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

def request_ip
  #Rails.env.development? && params[ip]---works too
    if Rails.env.development? && params[:ip]
      params[:ip]
    else
      request.remote_ip
    end 
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_url, :notice => "Successfully destroyed location."
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_location
      @location = Location.find(params[:id])
    end
    # Never trust parameters from the qary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:address, :latitude, :longitude)
    end
end
