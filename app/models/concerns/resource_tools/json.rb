# frozen_string_literal: true

# Handle JSON parsing.
# Currently uses Hashie, but we can probably eliminate that for something
# more lightweight
module ResourceTools::Json
  extend ActiveSupport::Concern

  class_methods do
    def create_or_update_from_json(json_data, lims)
      create_or_update(json.collection_from(json_data, lims))
    end

    private

    def json(&block)
      const_set(:JsonHandler, Class.new(ResourceTools::Json::Handler)) unless const_defined?(:JsonHandler)
      const_get(:JsonHandler).tap { |json_handler| json_handler.instance_eval(&block) if block_given? }
    end
  end

  # Holds the parameters for a JSON resource
  class Handler < Hashie::Mash
    class_attribute :translations
    self.translations = {}

    class << self
      # Hashes in subkeys might as well be normal Hashie::Mash instances as we don't want to bleed
      # the key conversion further into the data.
      def subkey_class
        Hashie::Mash
      end

      # JSON attributes can be translated into the attributes on the way in.
      def translate(details)
        self.translations = Hash[details.map { |k, v| [k.to_s, v.to_s] }].reverse_merge(translations)
      end

      def convert_key(key)
        translations[key.to_s] || key.to_s
      end
      # Remove privacy due to rails delegation changes
      # private :convert_key

      def collection_from(json_data, lims)
        new(json_data.reverse_merge(lims_id: lims))
      end
    end

    delegate :convert_key, to: 'self.class'

    translate(updated_at: :last_updated, created_at: :created)
  end
end
