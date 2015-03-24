
require 'forecast_io'

class PanelsController < ApplicationController
  before_action :set_panel, only: [:show, :edit, :update]
  skip_filter :panel_params, only: [:register]

  # GET /panels
  # GET /panels.json
  def index
    device = Device.find(params[:id])
    @panels = device.panels
  end

  # GET /panels/1
  # GET /panels/1.json
   def show
	@output = @panel.outputs.order(:id).last
  	@current_weather = ForecastIO.forecast(@panel.latitude, @panel.longitude).currently
   end

  def query_date
    time = params[:data]
    @forecast = ForecastIO.forecast(37.8267,-122.433, time:time.to_i)

  end

  # Start The System
  def remote_command
     	@device = Device.find_by_device_id "big"
	socket = TCPSocket.new @device.ip,@device.port
	command = params[:command]
	socket.send(command,0)
      
      respond_to do |format|
      	format.js
      end
      
  end

  # GET /panels
  def new
    @panel = Panel.new
  end

  # GET /panels/1/edit
  def edit
  end

  # POST /panels/register
  def register
     respond_to do |format|
     	format.all {head 200 , content_type:"text/html"}
     end
  end
  
  # POST /panels
  # POST /panels.json
  def create
    @panel = Panel.new(panel_params)

    respond_to do |format|
      if @panel.save
        format.html { redirect_to @panel, notice: 'Panel was successfully created.' }
        format.json { render :show, status: :created, location: @panel }
      else
        format.html { render :new }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /panels/1
  # PATCH/PUT /panels/1.json
  def update
    respond_to do |format|
      if @panel.update(panel_params)
        format.html { redirect_to @panel, notice: 'Panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @panel }
      else
        format.html { render :edit }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.json
  def destroy
    @panel.destroy
    respond_to do |format|
      format.html { redirect_to panels_url, notice: 'Panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panel
      @panel = Panel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panel_params
      params.require(:panel).permit(:about,:description,:latitude, :longitude,:photos)
    end
end
