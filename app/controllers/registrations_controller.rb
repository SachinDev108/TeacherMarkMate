class RegistrationsController < Devise::RegistrationsController
  before_action :set_subscription, only: [:new, :create]
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
	    amount, printer_amount, total_amount = get_amount_details(params[:no_of_printer].to_i)

	    subscription = @subscription_type.subscriptions.find_by({teacher_id: resource.id, payment_status: "Completed"})
	    if subscription.present?
	    	flash[:notice] = "You have already a subscription plan, If we you want to change please contact to support"
	    	redirect_to new_teacher_session_path
	    else
	    	subscription = @subscription_type.subscriptions.create({teacher_id: resource.id, no_of_printer: [:no_of_printer], amount: amount, printer_amount: printer_amount, total_amount: total_amount})
		    if subscription.present?
		      redirect_to "#{Rails.application.secrets.paypal_url}/cgi-bin/webscr?" + @subscription_type.paypal_link(subscriptions_url, new_teacher_registration_url, subscription)
		    else
		      redirect_to new_teacher_registration_path
		    end
	    end
	    
	  end
  end

  def create_transaction
  end

  def update
    super
  end

  private

  def set_subscription
    @subscription_type = SubscriptionType.find_by_id(params[:subscription_id])
    unless @subscription_type
      flash[:flash] = "Something went wrong"
      redirect_to root_path
    end
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation, :address,
                                 :role)
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