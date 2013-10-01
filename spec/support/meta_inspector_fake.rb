module MetaInspector
  extend self
  def new(url)
    return Page.new
  end

  private

  class Page
    def meta_news_keywords
      "hi,im,a,string"
    end
  end
end
