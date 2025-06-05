class OpenAi
  def self.embedding(query)
    client = OpenAI::Client.new

    response = client.embeddings(
      parameters: {
        model: "text-embedding-3-small",
        input: query
      }
    )

    embedding = response.dig("data", 0, "embedding")
    puts embedding.inspect
  end
end
