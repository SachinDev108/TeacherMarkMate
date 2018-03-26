class SubscriptionType < ApplicationRecord

  has_many :subscriptions

  def paypal_link(return_url, cancel_return, subscription)
    if subscription.period == "monthly"
      {
        :business => Rails.application.secrets.paypal_email,
        :cmd => "_s-xclick",
        :hosted_button_id => "PAMV3FSL6Q5EY",
        :upload => 1,
        :return => return_url,
        :rm => 2,
        :cancel_return => cancel_return,
        :amount => subscription.total_amount,
        :currency_code => :GBP,
        :custom => subscription.id
      }.to_query
    else
      {
        :business => Rails.application.secrets.paypal_email,
        :cmd => "_xclick",

        :upload => 1,
        :return => return_url,
        :rm => 2,
        :cancel_return => cancel_return,
        :amount => subscription.total_amount,
        :currency_code => :GBP,
        :item_name => "Subscription Plan('#{name}' include with printer amount)",
        :custom => subscription.id
      }.to_query
    end
  end
end