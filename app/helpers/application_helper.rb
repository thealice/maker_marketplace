module ApplicationHelper

  def gravatar_for(user, options = { size: 200})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "border-radius-50")
  end

  def markdown_to_html(text)
      Kramdown::Document.new(text, input: "GFM").to_html
  end

  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{Rails.application.credentials.dig(:stripe)[:connect_client_id]}&scope=read_write"
  end

  def stripe_connect_button
      link_to stripe_url, class: "btn-stripe-connect" do
        content_tag :span, "Connect with Stripe"
      end
  end

end