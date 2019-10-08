Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :google_oauth2, ENV['GL_CLIENT_ID'], ENV['GL_CLIENT_SECRET']
  provider :facebook, ENV['FB_CLIENT_KEY'], ENV['FB_CLIENT_SECRET']
end