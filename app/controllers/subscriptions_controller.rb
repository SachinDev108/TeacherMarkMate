class SubscriptionsController < ApplicationController
  before_action :authenticate_teacher!, except: [:thankyou, :create] 
  before_action :set_subscription, only: [:new, :checkout]
  protect_from_forgery except: [:create]

  def index
    
  end
  def new
    @subscription = @subscription_type.subscriptions.new
  end

  def checkout
    amount, printer_amount, total_amount = get_amount_details(params[:subscription][:no_of_printer].to_i)
    subscription = @subscription_type.subscriptions.create({teacher_id: current_teacher.id, no_of_printer: params[:subscription][:no_of_printer], full_name: params[:subscription][:full_name], email: params[:subscription][:email], address: params[:subscription][:address], amount: amount, printer_amount: printer_amount, total_amount: total_amount})
    if subscription.present?
      redirect_to "#{Rails.application.secrets.paypal_url}/cgi-bin/webscr?" + @subscription_type.paypal_link(subscriptions_url, new_subscription_url, subscription)
    else
      redirect_to root_path
    end
  end

  def create
    @subscription = Subscription.find_by_id(params[:custom])
    if params[:payment_status] == "Completed" 
      @subscription.update_attributes(payment_status: params[:payment_status], payer_id: params[:payer_id], txn_id: params[:txn_id], payment_date: params[:payment_date], status: true, payment_type: 'Paypal')
      redirect_to thankyou_subscriptions_path
    else
      @subscription.update_attributes(payment_status: params[:payment_status], payer_id: params[:payer_id], txn_id: params[:txn_id], payment_date: params[:payment_date], payment_type: 'Paypal')
      redirect_to root_path
    end
  end

  def thankyou
  end

  private

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

  def set_subscription
    @subscription_type = SubscriptionType.find_by_id(params[:subscription_id])
    unless @subscription_type
      flash[:flash] = "Something went wrong"
      redirect_to teacher_subscription_teachers_path
    end
  end
end