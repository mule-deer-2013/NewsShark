module ApplicationHelper
  # def feedback_actions(article)
  #   {"Like" => 1, "Dislike" => -1, "Skip" => 0}.inject([]) do |buttons, action|
  #     buttons << button_to(action.first, user_channel_article_path(current_user, article.channel, article, :user_feedback => action.last), :method => :put)
  #   end
  # end

  # <% feedback_actions(article).each do |button| %>
  #   <%= button %>
  # <% end %>


  def like_button(article)
    action_button(article, "Like", 1, 'btn btn-primary')
  end

  def dislike_button(article)
    action_button(article, "Dislike", -1, 'btn btn-danger')
  end

  def next_button(article)
    action_button(article, "Next", 0, 'btn btn-inverse')
  end

  def action_button(article, name, feedback, html_class)
    button_to(name, user_channel_article_path(current_user, article.channel, article, :user_feedback => feedback), :method => :put, :class => html_class, :remote => true)
  end

end
