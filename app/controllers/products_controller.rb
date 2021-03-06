class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:show]

  def index
  	@products = Product.all
  end

  def show

    # refactored code to replace @product = Product.find(params[:id])
    # see method in 'Private', below
    @product = find_product

    # from section 12 - filters code for product review
    if current_user
      @review = @product.reviews.build
    end
  end

  def new
  	@product = Product.new
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def create
  	@product = Product.new(product_params)

  	if @product.save
  		# this sends a 302 redirect
      redirect_to products_url
  	else
  		# this sends a 200 and sends a 'new' template
      render :new
  	end
  end

  def update
  	@product = Product.find(params[:id])

  	if @product.update_attributes(product_params)
  		# this sends a 302 redirect
      redirect_to product_path(@product)
  	else
  		# this sends a 200 and sends an 'edit' template
      render :edit
  	end
  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to products_path
  end

	private
	def product_params
		params.require(:product).permit(:name, :description, :price_in_cents, :picture_url)
	end

  def find_product
    Product.find(params[:id])
  end

end
