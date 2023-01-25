class DrawingsController < ApplicationController
  before_action :set_drawing, only: %i[show edit update destroy]

  # GET /drawings or /drawings.json
  def index
    @drawings = Drawing.all
  end

  # GET /drawings/1 or /drawings/1.json
  def show; end

  # GET /drawings/new
  def new
    @drawing = Drawing.new
  end

  # GET /drawings/1/edit
  def edit; end

  # POST /drawings or /drawings.json
  def create
    @drawing = Drawing.new(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to drawing_url(@drawing), notice: 'Drawing was successfully created.' }
        format.json { render :show, status: :created, location: @drawing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drawings/1 or /drawings/1.json
  def update
    respond_to do |format|
      if @drawing.update(drawing_params)
        format.html { redirect_to drawing_url(@drawing), notice: 'Drawing was successfully updated.' }
        format.json { render :show, status: :ok, location: @drawing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drawings/1 or /drawings/1.json
  def destroy
    @drawing.destroy

    respond_to do |format|
      format.html { redirect_to drawings_url, notice: 'Drawing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def drawable
    data = drawing_params[:drawable]
    data = data.split(',')[1]
    data = Base64.decode64(data)

    file = Tempfile.new(['image', '.png'])
    file.binmode
    file.write(data)
    file.rewind

    @drawing = Drawing.find(params[:id])
    @drawing.image.attach(io: file, filename: 'image.png')
    file.unlink
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_drawing
    @drawing = Drawing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def drawing_params
    params.require(:drawing).permit(:title, :image, :drawable)
  end
end
