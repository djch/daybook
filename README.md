# Day Book
This is a small Rails 5 project I've started to get familiar with Ruby on Rails. I'm starting slowly and small to get a strong grip on the basics — though I'm sure that won't stop me veering off on more advanced tangents. We'll see where it grows from there.

In its current iteration Day Book is a traditional blog. Authors can publish articles which readers (and the author) can comment on.

## Getting Started
Before you set the project up, I recommend setting up your Ruby on Rails development environment according to [GoRails' fine instructions](https://gorails.com/setup/), for the platform you're on.

1. **Clone this repo** — You probably already know how to do this. If not, GitHub.com's help guides are very straightforward. Make sure you're inside the root project folder for the rest of these steps.

2. **Install the project dependencies** — Ruby packages are called [Gems](https://rubygems.org). When you want to manage groups of them, like for a particular project, the `bundle` comment is used.

    ```
    bundle install
    ```

3. **Set up the database** — This will be familiar if you used other MVC frameworks. Your development DB will just be SQLite. In a production environment it'll be PostgreSQL.

   ```
   rails db:migrate
   ```

4. **Run the test suite** — If there's any problems so far, this should find them before you get as far your web browser. If it passes, you're all set to run the project server and start using it.

    ```
    rails test
    ```

5. **Start the web server** — Rail 5 uses [Puma](http://puma.io) for its development server. This runs in the foreground of your terminal so you'll probably want to open an additional tab while you work.

    ```
    rails server
    ```

All that's left to do now is to open your web browser and navigate over to http://localhost:3000/. As you work on the project, the rails server will automatically reload with your changes.
