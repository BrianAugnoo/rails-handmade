require "gemini-ai"
Gemini.configure do |config|
  config.api_key = ENV["GEMINI_API"]
end
