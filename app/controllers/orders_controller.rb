class OrdersController < ApplicationController

  def verify_google_recaptcha(secret_key,response)
    status = `curl "https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{response}"`
    logger.info "---------------status ==> #{status}"
    hash = JSON.parse(status)
    hash["success"] == true ? true : false
  end
  
  # POST /orders
  # POST /orders.json
  def create
    @secret_key = "6Le7mh8TAAAAAGKRPjxYnO9t0O1_m8dgxa-EgcOB"
    if params[:order].present?
      @order = Order.new(order_params)
    else
      @order = Order.new
    end
    @customer = Customer.new(customer_params)
    @order.customer = @customer
    if @order.different_delivery == true
      @order_delivery = OrderDelivery.new(
        first_name: @customer.first_name,
        last_name: @customer.last_name,
        email: @customer.email,
        phone: @customer.phone,
        company: @customer.company,
        zip_code: @customer.zip_code,
        address: @customer.address,
      )
    else
      @order_delivery = OrderDelivery.new(order_delivery_params)
    end
    
    @order.order_delivery = @order_delivery
    
    @order.user_id = current_user.id if current_user.present?
    
    if @cart.coupon.present?
        @order.coupon_code = @cart.coupon_code
        @order.coupon_price = @cart.coupon.price
    end
    
    if @cart.voucher.present?
        @order.voucher_code = @cart.voucher_code
        @order.voucher_price = @cart.voucher.price
    end
    
    status = verify_google_recaptcha(@secret_key, params["g-recaptcha-response"])
    
    respond_to do |format|
      if @order.save && status
        @order.save_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to controller: "checkout", action: "success" }
      else
        flash[:notice] = "Gửi đơn hàng thất bại"
        format.html { redirect_to controller: "checkout", action: "success" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:different_delivery, order_details_attributes: [:id, :order_id, :product_id, :quantity, :_destroy])
    end
    
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone, :company, :address, :city, :zip_code, :country, :province)
    end
    
    def order_delivery_params
      params.require(:order_delivery).permit(:first_name, :last_name, :company, :address, :city, :zip_code, :country, :province, :email, :phone, :delivery_method_id, :payment_method_id, :message)
    end
end
