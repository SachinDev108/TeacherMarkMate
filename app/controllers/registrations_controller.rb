class RegistrationsController < Devise::RegistrationsController
  before_action :set_subscription, only: [:create]
  before_action :check_amount_validation, only: [:create]
  def new
    super
  end

  def create
  	resource = Teacher.find_by_email(params[:teacher][:email])
  	if resource
  		resource.update_attributes(teacher_params)
  	else
  		resource = build_resource(teacher_params)
  		resource.save
  	end
    
    if resource.try(:id)
	    subscription = @subscription_type.subscriptions.find_by({teacher_id: resource.id, payment_status: "Completed"})
	    if subscription.present?
	    	flash[:notice] = "You have already a subscription plan, If we you want to change please contact to support"
	    	redirect_to new_teacher_session_path
	    else

	    	subscription = @subscription_type.subscriptions.create({teacher_id: resource.id, no_of_printer: params[:no_of_printer], amount: @total_price, total_amount: @total_calculation, period: params[:period], no_of_users: params[:users]})
		    if subscription.present?
		      redirect_to "#{Rails.application.secrets.paypal_url}/cgi-bin/webscr?" + @subscription_type.paypal_link(subscriptions_url, new_teacher_registration_url, subscription)
		    else
		      redirect_to new_teacher_registration_path
		    end
	    end
	    
	  end
  end

  def update
    if params[:teacher][:password].blank? && params[:teacher][:password_confirmation].blank?
      params[:teacher].delete(:password)
      params[:teacher].delete(:password_confirmation)
    end
    respond_to do |format|
      if current_teacher.update_attributes(teacher_params)
        flash[:notice] = "Successfully updated"
        format.html { redirect_to edit_teacher_registration_path}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

  def set_subscription
    if ['1'].include? params[:users]
      @subscription_type = SubscriptionType.find_by_id('1')
    elsif ['2','3','4','5'].include? params[:users]
      @subscription_type = SubscriptionType.find_by_id('2')
    elsif ['6','7','8','9','10'].include? params[:users]
      @subscription_type = SubscriptionType.find_by_id('3')
    else
      @subscription_type = SubscriptionType.find_by_id('4')
    end
    unless @subscription_type
      flash[:notice] = "Something went wrong"
      redirect_to new_teacher_registration_path
    end
  end

  def check_amount_validation
    price = (@subscription_type.name == "Individual Plan") && (params[:period] == "monthly") ? @subscription_type.price : @subscription_type.yearly_price
    @total_price = '%.2f' % (params[:users].to_i*price)
    @total_calculation = '%.2f' % ((params[:users].to_i*price) + (params[:no_of_printer].to_i*@subscription_type.printer_price))
    unless ((@total_price == params[:total_price]) && (@total_calculation == params[:total_calculation]))
      flash[:notice] = "Calculation is incorrect"
      redirect_to new_teacher_registration_path
    end
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :address,:role)
  end

  def get_amount_details(printers)
    if @subscription_type.id == 1
      amount, printer_amount, total_amount = @subscription_type.yearly_price, nil, @subscription_type.yearly_price
    else
      amount = @subscription_type.yearly_price
      printer_amount = @subscription_type.yearly_price
      total_amount = amount + (39.99 * printers)
      return amount, printer_amount, total_amount.round(2)
    end
  end
end 