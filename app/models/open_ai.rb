# app/models/open_ai.rb
require "openai"

class OpenAiService
  def self.embedding(query)
    # 1) Créez le client avec la bonne option :api_key
    client = OpenAI::Client.new(api_key: ENV["OPENAI_API_KEY"])

    # 2) Appelez l’API embeddings
    response = client.embeddings.create(
      model: "text-embedding-3-small",
      input: query
    )

    # 3) Récupérez le vecteur (Array de floats)
    vector = response.dig("data", 0, "embedding")
    puts "Embedding généré : #{vector&.size} dimensions"
    vector

  rescue OpenAI::Errors::APIError => e
    warn "Erreur OpenAI (APIError) : #{e.message}"
    nil

  rescue StandardError => e
    warn "Erreur inattendue : #{e.class} – #{e.message}"
    nil
  end
end
