require 'zendesk_api'
class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
    @customer = Customer.all
    @building = Building.all
    @batterie = Battery.all
    @column = Column.all
    @elevator = Elevator.all
    @employee = Employee.all
  
  
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
  end

  

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions
  # POST /interventions.json
  def create
    
    respond_to do |format|
      if @interventions.save
        format.html { redirect_to @intervention, notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interventions/1
  # PATCH/PUT /interventions/1.json
  def update
    respond_to do |format|
      if @interventions.update(intervention_params)
        format.html { redirect_to @intervention, notice: 'Intervention was successfully updated.' }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @interventions.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: 'Intervention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
   
  def new_interventions
        interventions = Intervention.new(interventions_params)
        interventions.author_id = current_user.id
        interventions.begin_date = ''
        interventions.finish_date = ''
        interventions.result = 'incomplete'
        interventions.status = 'pending'
        current_user = @employee
        
        if interventions.save!
          ZendeskAPI::Ticket.create!($client, :type => "task", :priority => "normal",
            :subject => "#{interventions.employee_id} from #{interventions.employee_id}",
            :comment => { :value => "#{interventions.customer.business_name} for building #{interventions.building.building_name} in battery #{interventions.battery_id} and column #{interventions.column_id} and elevator #{interventions.elevator_id}\n with technician #{interventions.employee_id} report #{interventions.report} by #{interventions.author_id}"}, 
            :submitter_id => current_user,
          )
          redirect_to root_path
           

        else
          interventions.errors
        end
        

  end

  def interventions_params
        params.require(:interventions).permit(:customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :report, :author_id )
        
  end


  def update_buildings
    @buildings = Building.where("customer_id = ?", params[:customers])
    puts  @buildings.size

    respond_to do |format|
      format.js
    end
    pp 'Allo building'
  end


  def update_batteries
    @batteries = Battery.where("building_id = ?", params[:buildings])
    puts  @batteries.size
    respond_to do |format|
      format.js
    end
    pp 'Allo building'
  end

  def update_columns
    @columns = Column.where("battery_id = ?", params[:batteries])
    puts  @columns.size
    respond_to do |format|
      format.js
    end
    pp 'Allo building'
  end

  def update_elevators
    @elevators = Elevator.where("column_id = ?", params[:columns])
    puts  @elevators.size
    respond_to do |format|
      format.js
    end
    pp 'Allo building'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end
    
    include ZendeskAPI 

end

 


