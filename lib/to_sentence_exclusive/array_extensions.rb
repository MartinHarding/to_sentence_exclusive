# frozen_string_literal: true

module ToSentenceExclusive
  module ArrayExtensions
    # Copied primarily from activesupport/lib/active_support/core_ext/array/conversions.rb, line 61
    def to_sentence_exclusive(options = {})
      valid_keys = [:words_connector, :two_words_connector, :last_word_connector, :locale]
      options.each_key do |k|
        unless valid_keys.include?(k)
          raise ArgumentError.new("Unknown key: #{k.inspect}. Valid keys are: #{valid_keys.map(&:inspect).join(', ')}")
        end
      end

      default_connectors = {
        words_connector: ", ",
        two_words_connector: " or ",
        last_word_connector: ", or "
      }
      if defined?(I18n)
        i18n_connectors = I18n.translate(:'support.array.exclusive', locale: options[:locale], default: {})
        default_connectors.merge!(i18n_connectors)
      end
      options = default_connectors.merge!(options)

      case length
      when 0
        ""
      when 1
        "#{self[0]}"
      when 2
        "#{self[0]}#{options[:two_words_connector]}#{self[1]}"
      else
        "#{self[0...-1].join(options[:words_connector])}#{options[:last_word_connector]}#{self[-1]}"
      end
    end
  end
end
