require "active_support/core_ext/hash"

module ToSentenceExclusive
  module ArrayExtensions
    def to_sentence_exclusive(options = {})
      options.assert_valid_keys(:words_connector, :two_words_connector, :last_word_connector, :locale)

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
