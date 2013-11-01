# NewsShark #
### NewsShark delivers news articles on topics important to you. 
<p>You can create "channels" to listen for relevant stories, and you rate the articles that you like or dislike.</p>
<p>Over time, your channel learns about your preferences and delivers customized recommendations based on article characteristics such as author, publication, word-count, keywords, readability metrics, and more.</p>
<p>Utilizing our own in-house machine learning system and content-ranking algorithm, NewsShark does for the news what Pandora does for music: <em>we filter out the noise.</em></p>

<p>We built this web application in 7 days. 2 weeks prior, we had never worked with Ruby on Rails. In addition to our custom-built machine learning algorithm and recommendation engine, the project ended with over 97% test coverage across 60+ passing tests and an average of 24 hits per line for 630 relevant lines of code.</p>

### To Launch Site on http://localhost:3000/


  1. Install gems.

  Open a Terminal window and run: 
```
    $ bundle install
```

  2. Launch servers.

  Open 3 Terminal windows. One for each of the following commands: 
```
    $ redis-server
    $ bundle exec sidekiq
    $ rails s
```
  3. Prepare database.

  Open another Terminal window for database preparation
```
    $ rake db:create && rake db:migrate && rake db:test:prepare
```

<p>That's it! You're now ready to customize the news for you. Feel free to run rspec to check out our test suite. Comments on all code are welcome.  Thanks!</p>


###### developed by Thomas Landon, George Pradhan, Ian Root & Christian Robert Joseph
