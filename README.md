# Task Tracker

An Elixir/Phoenix app to track tasks.

### Design decisions

* Removed "Users" from navigation. A logged in user should only see or edit its own 
* Separated completed and non completed tasks, and put non completed above as
  they should be more relevant to users
  
* Added "manage" in the nav bar so managers can add their underlings
* An underling can add underlings below him/her
* If a manager/underling doesn't have any underlings, the ability to create tasks is disabled
* Given that a user can have tasks assigned to himself as well as tasks that he assigned, tasks are divided in two 
sections in the tasks dashboard

 

### Notes:

Duplicate names/emails are not supported, it will throw errors or the app will behave unexpectedly.

### To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Other resources used for implementing this hw

https://www.dailydrip.com/topics/elixir/drips/nested-resources-in-phoenix.html