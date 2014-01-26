# Sinatra Url Shortener With Users

## Learning Competencies

* Use Active Record Associations
* Integrate multiple code bases into one coherent application
* Implement a user authorization scheme to limit unauthorized access to specific pages in a web application 

## Summary

Let's integrate our URL shortener with our user authentication code.  This
will let people save the URLs they've shortened and open up the possibility of
"private" short URLs.

This will be the most complex web application you've worked on so far; take it
one step at a time.  If the problem seems unassailable, break it down into
simpler parts you understand.  If you don't see how to break it down, flag down
a staff member and ask: "How do I break this down into something that makes
more sense for me?"

## Releases

### Release 0: Glue together!

Start by gluing together your user authentication code and your URL shortening
code as best you can.  This means creating the relevant migrations, models, and
controller code.

The core flow of the URL shortener should remain the same, however a person
might choose to log in or create an account.  In the event that they're logged
in when they shorten a URL, this `Url` should now be associated with their user
account.  In other words, a `Url` belongs to a `User` and a `User` has many
`Urls`.

**Note**: Don't worry about implement the above user-centric logic yet.  First
get all the URL shortening and user authentication code working.  Make sure
people can log in and can shorten URLs regardless of whether they're logged in
or not.

In this case, you might want multiple controllers.  Something like this would
be reasonable:

1. `app/controllers/urls.rb`, which contains the routes related to listing, creating, and redirecting `Url` objects
2. `app/controllers/sessions.rb`, which contains the routes related to logging in and logging out
3. `app/controllers/users.rb`, which contains the routes related to creating, displaying, and editing users

### Release 1: Logged in, logged out, and current user

People should be able to create short URLs regardless of whether they're logged
in or not.  That is, the `user_id` field on the `urls` table could possible be
`NULL`.

However, if a user *is* logged in, when we create a URL it should set the
`user_id` to whatever the `user_id` of the currently logged-in user is.  This
information *should not* be a part of the form that a user submits &mdash; it
would be trivial for someone to change the content of the form and submit as
any user.

Instead, create a users helper at `app/helpers/user.rb`.  It should contain a
method that works like this:

```ruby
helpers do
  # This will return the current user, if they exist
  # Replace with code that works with your application
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end
end
```

Your controller can now call `current_user` to get the currently authenticated
user, if they exist.  This means we don't have to rely on user-submitted data
to determine what user created a short URL.

### Release 2: Profile Page

Create a profile page for each user like so:

```ruby
get '/users/:id' do
end
```

This should display all the links that a particular user has created.  If I'm
viewing my *own* profile page, show the number of clicks next to each link so I
can see how awesome my link-sharing skills are.

<!-- ## Optimize Your Learning -->

## Resources

_No resources are provided.  Be resourceful yourself!_
