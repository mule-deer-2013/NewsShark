module ChannelArticleMapper

  ATTRIBUTE_MAPPER = {  :preferenced_keywords => :keywords ,
                        :preferenced_publications => :publication,
                        :preferenced_authors => :author,
                        :preferenced_word_counts => :word_count,
                        :preferenced_kincaids => :kincaid
                      }

  PREFERENCED_ATTRIBUTES = ATTRIBUTE_MAPPER.keys

  KARMA_SCALING_FACTOR = 10.0

  KARMA_WEIGHTS = { 'publication' => 0.25,
                    'keyword' => 0.15,
                    'author' => 0.30,
                    'kincaid' => 0.20,
                    'word_count' => 0.10
                  }

  MINIMUM_FEEDBACK = 3

end
