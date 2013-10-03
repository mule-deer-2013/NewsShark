module ChannelArticleMapper

  ATTRIBUTE_MAPPER = {  :preferenced_keywords => :keywords ,
                        :preferenced_publications => :publication }

  PREFERENCED_ATTRIBUTES = ATTRIBUTE_MAPPER.keys

  KARMA_SCALING_FACTOR = 10.0

  KARMA_WEIGHTS = { 'publication' => 0.70,
                    'keyword' => 0.30 }

  MINIMUM_FEEDBACK = 3

end
