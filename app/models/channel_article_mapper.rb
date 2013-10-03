module ChannelArticleMapper

  ATTRIBUTE_MAPPER = {  :preferenced_keywords => :keywords ,
                        :preferenced_publications => :publication,
                        :preferenced_authors => :author,
                        :preferenced_word_counts => :word_count,
                        :preferenced_kincaids => :kincaid
                      }

  PREFERENCED_ATTRIBUTES = ATTRIBUTE_MAPPER.keys

  KARMA_SCALING_FACTOR = 10.0

  KARMA_WEIGHTS = { 'publication' => 0.25 * KARMA_SCALING_FACTOR,
                    'keyword' => 0.15 * KARMA_SCALING_FACTOR,
                    'author' => 0.30 * KARMA_SCALING_FACTOR,
                    'kincaid' => 0.20 * KARMA_SCALING_FACTOR,
                    'word_count' => 0.10 * KARMA_SCALING_FACTOR
                  }

  MINIMUM_FEEDBACK = 3

  DELETABLES = ['nil', nil, '', 0, '0']

end
