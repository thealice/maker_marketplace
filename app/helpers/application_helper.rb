module ApplicationHelper
    def stripe_url
      "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe)[:connect_client_id]}&scope=read_write"
    end

    def stripe_connect_button
        link_to stripe_url, class: "btn-stripe-connect" do
          content_tag :span, "Connect with Stripe"
        end
    end

end