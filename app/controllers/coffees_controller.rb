class CoffeesController < ApplicationController

    def index
      @coffees = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/coffees.json").body
    end

    def show
    @coffee = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{params[:id]}.json").body
   end

   def create
    @coffee = Unirest.post("#{ ENV['HOST_NAME'] }/api/v2/coffees.json", 
                                          headers:{ "Accept" => "application/json" }, 
                                          parameters:{ :blend => params[:blend], :origin => params[:origin], :variety => params[:variety], :notes => params[:notes]}).body

    redirect_to "/coffees/#{@coffee['id']}"
  end

  def edit
      @coffee = Unirest.get("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{params[:id]}.json").body
  end

  def update

    @coffee = Unirest.patch("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{params[:id]}.json", 
                                          headers:{ "Accept" => "application/json" }, 
                                          parameters:{ :blend => params[:blend], :origin => params[:origin], :variety => params[:variety], :notes => params[:notes]}).body

      redirect_to '/coffees'                                    
  
  end

  def destroy
      coffee = Unirest.delete("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{params[:id]}.json").body

      flash[:warning] = "Coffee Successfully Destroyed"
      redirect_to "/coffees"

  end




end
