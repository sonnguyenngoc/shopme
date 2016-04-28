class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  ## GET /carts
  ## GET /carts.json
  #def index
  #  @carts = Cart.all
  #end
  #
  ## GET /carts/1
  ## GET /carts/1.json
  #def show
  #end
  #
  ## GET /carts/new
  #def new
  #  @cart = Cart.new
  #end
  #
  ## GET /carts/1/edit
  #def edit
  #end
  #
  ## POST /carts
  ## POST /carts.json
  #def create
  #  @cart = Cart.new(cart_params)
  #
  #  respond_to do |format|
  #    if @cart.save
  #      format.html { redirect_to controller: "checkout", action: "shopping_cart" }
  #      format.json { render :show, status: :created, location: @cart }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @cart.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  
  def cart
      if @cart.save
        render "/module/_shopping_cart_items", layout: nil
        @success = true
      else
        @success = false
      end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    params[:quantities].each do |q|
      li = LineItem.find(q[0])
      li.update_attribute(:quantity, q[1])
    end
    
    redirect_to controller: 'checkout', action: 'shopping_cart'
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to controller: "checkout", action: "shopping_cart" }
      format.json { head :no_content }
    end
  end
  
  #use_voucher
  def use_voucher
    if Voucher.is_valid_code(params[:code])
      @cart.voucher_code = params[:code]
      @cart.save
      @voucher_error = false
      render "/checkout/_checkout_cart_items", layout: nil
    else
      @voucher_error = true
      render "/checkout/_checkout_cart_items", layout: nil
    end
    #redirect_to controller: "checkout", action: "checkout"
  end
  
  #use_voucher
  def shopping_cart_use_voucher
    if Voucher.is_valid_code(params[:code])
      @cart.voucher_code = params[:code]
      @cart.save
      @voucher_error = false
      render "/checkout/_total_price_carts", layout: nil
    else
      @voucher_error = true
      render "/checkout/_total_price_carts", layout: nil
    end
    #redirect_to controller: "checkout", action: "checkout"
  end
  
  #use_coupon
  def use_coupon
    if Coupon.is_valid_code(params[:code])
      @cart.coupon_code = params[:code]
      @cart.save
      @coupon_error = false
      render "/checkout/_checkout_cart_items", layout: nil
    else
      @coupon_error = true
      render "/checkout/_checkout_cart_items", layout: nil
    end
    #redirect_to controller: "checkout", action: "checkout"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end
    
    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: 'Invalid cart'
    end
end
