# frozen_string_literal: true

require "net/http"
#require "uri"
#require "json"
#require "openssl"

module Gemini
  class Client
    ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
    READ_TIMEOUT = 30

    def self.generate(prompt)
      raise ArgumentError, "prompt must be present" if prompt.to_s.strip.empty?

      uri = URI(ENDPOINT)
      http = build_http(uri)

      request = Net::HTTP::Post.new(uri)
      request["Content-Type"]  = "application/json"
      request["x-goog-api-key"] = ENV.fetch("GEMINI_API_KEY")

      request.body = {
        "contents": [
          { 
            role: "user", 
            parts: [{ text: prompt }] 
          }
        ],
        "generationConfig": {
          "responseMimeType": "application/json",
          "responseJsonSchema": {
          "type": "object",
          "required": ["name", "description", "items"],
          "additionalProperties": false,
          "properties": {
            "name": { "type": "string", "description": "Plan name." },
            "description": { "type": "string", "description": "Plan description." },
            "items": {
              "type": "array",
              "minItems": 1,
              "items": {
                "type": "object",
                "required": ["exercise_id", "sets", "reps", "weight"],
                "additionalProperties": false,
                "properties": {
                  "exercise_id": { "type": "integer", "minimum": 1 },
                  "sets": { "type": "integer", "minimum": 1 },
                  "reps": { "type": "integer", "minimum": 1 },
                  "weight": { "type": "number", "minimum": 0 }
                }
              }
            }
          }
        }
      }

        
      }.to_json

      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "Gemini error #{response.code}: #{response.body}"
      end

      JSON.parse(response.body)
    end

    def self.build_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.read_timeout = READ_TIMEOUT

      # Workaround for OpenSSL CRL verification failures on some networks.
      store = OpenSSL::X509::Store.new
      store.set_default_paths
      store.flags = 0

      http.cert_store  = store
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      http
    end

    private_class_method :build_http
  end
end
