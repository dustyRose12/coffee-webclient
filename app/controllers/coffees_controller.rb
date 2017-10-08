class CoffeesController < ApplicationController

    #TODO: clean up the create, update and destroy methods by putting them into the coffee model
    
    def index
      @coffees = Coffee.all
    end

    def show
    @coffee = Coffee.find(params[:id])
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
      # coffee = Unirest.delete("#{ ENV['HOST_NAME'] }/api/v2/coffees/#{params[:id]}.json").body
      coffee = Coffee.destroy(params[:id])

      flash[:warning] = "Coffee Successfully Destroyed"
      redirect_to "/coffees"

  end




end
