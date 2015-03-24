class OutputsController < ApplicationController
  include ActionController::Live


  before_action :set_output, only: [:show, :edit, :update, :destroy]

  before_action :set_device, only: [:io_sample]
  # GET /outputs
  # GET /outputs.json
  def index
    @outputs = Output.all
  end
  
  
  # GET /outputs/notify
  def notify
      # SSE expects the `text/event-stream` content type
      response.headers['Content-Type'] = 'text/event-stream'

      sse = Reloader::SSE.new(response.stream)

      begin
        # Watch the output change
        Output.on_change do |data|

          # Send a message on the "refresh" channel on every update
          sse.write({:watt => data} , :event => 'update_output')
        end

      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end

      render nothing: true
  end

  # GET /outoputs/accept
  def accept

    output = Output.new(accept_output)
    if output.save
    else
    end

    render nothing: true
  end

  def io_sample
    puts @device.panels.count
    @device.panels.each do |panel|
    	puts "panel:#{panel.source} =>#{params[panel.source]}"
	output = Output.new
	output.panel_id = panel.id
	output.watt = params[panel.source]
	if output.save
	else
	end
    end
    
    render nothing: true

  end

  # GET /outputs/1
  # GET /outputs/1.json
  def show
  end

  # GET /outputs/new
  def new
    @output = Output.new
  end

  # GET /outputs/1/edit
  def edit
  end

  # POST /outputs
  # POST /outputs.json
  def create
    @output = Output.new(output_params)

    respond_to do |format|
      if @output.save
        format.html { redirect_to @output, notice: 'Output was successfully created.' }
        format.json { render :show, status: :created, location: @output }
      else
        format.html { render :new }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outputs/1
  # PATCH/PUT /outputs/1.json
  def update
    respond_to do |format|
      if @output.update(output_params)
        format.html { redirect_to @output, notice: 'Output was successfully updated.' }
        format.json { render :show, status: :ok, location: @output }
      else
        format.html { render :edit }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outputs/1
  # DELETE /outputs/1.json
  def destroy
    @output.destroy
    respond_to do |format|
      format.html { redirect_to outputs_url, notice: 'Output was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_output
      @output = Output.find(params[:id])
    end

    def	set_device
      @device = Device.find_by_device_id(params[:device_id])
    end

  def accept_output
    params.permit(:watt, :voltage)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def output_params
      params.require(:output).permit(:watt, :voltage)
    end
end
