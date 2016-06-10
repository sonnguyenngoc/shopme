class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:destroy]

  # POST /testimonials
  # POST /testimonials.json
  def create
    @testimonial = Testimonial.new(testimonial_params)
    
    @testimonial.user_id = current_user.id if current_user.present?

    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to testimonial_list_path, notice: 'Viết ý kiến thành công.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to controller: "product", action: "testimonial" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def testimonial_params
      params.require(:testimonial).permit(:name, :city, :email, :content, :user_id)
    end
end
