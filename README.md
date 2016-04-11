# Ballot App

This is app is a a web service that allows you to sign up, create an election, have people vote on candidates in this election, and then view the results. You can see it in action here: http://ballot-app.herokuapp.com/

### Technologies

It uses standard Ruby on Rails technologies such as [CoffeeScript](http://coffeescript.org/), [SCSS](http://sass-lang.com/documentation/file.SASS_REFERENCE.html), and [HAML](http://haml.info/), as well as [Bootstrap](https://github.com/twbs/bootstrap-sass) for styles on the frontend.

In the backend it uses  Devise (https://github.com/plataformatec/devise) for user authentication (including sign ups, forgotten passwords etc), and [Paperclip](https://github.com/thoughtbot/paperclip) to manage file uploads. It uses [MySQL](http://dev.mysql.com/downloads/mysql/) for the database.

It also uses [Bundler](http://bundler.io/) to manage gems (the external libraries that the app uses), and [Mailcatcher]((https://mailcatcher.me/)) to handle all emails when developing locally.

### Developing on this application:
If you want to make your own changes to this application first clone the repository:

    `git clone git@github.com:nickdowse/ballot_app.git`

Then `cd` into the ballot_app folder (the app folder) and run the bundle install command to install all of the gems that this app depends on:

    `bundle install`

If that throws a `bundle: command not found` error then you first need to install bundler: `gem install bunder`. Once that's done run the `bundle install` command.

After the `bundle install` command has finished running, install mailcatcher so that the app's account confirmation emails work when we are developing locally:

    `gem install mailcatcher`

Once that has installed start mailcatcher by running the command:

    `mailcatcher`

in the app folder.

Once you've done this it's time to create a database in MySQL:

    `mysqladmin -u root create ballot_app`

(If you've set a password for your root user in mysql then you'll have to run the command with the -p option instead: `mysqladmin -u root -p create ballot_app`)

Once the database has been created we're nearly there! The final step is to get the database we just created into sync with what the app expects the database to look like. We do this by running the command:

    `rake db:migrate`

Once that has finished, run `rails server` to start the server. You can then navigate to `localhost:3000` in your web browser of choice and you will see the landing page for our Ballot App.

### Contributing

This is designed as an example Ruby on Rails app to introduce newbies to Rails to a lot of the standard concepts and actions that Rails developers undertake every day. If you'd like to contribute to it please feel free to fork it, then create a pull request to merge your changes back in.

If you have any questions or problems, please open an issue!
