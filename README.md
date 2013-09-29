# NFL draft

A rails app that simulates the NFL draft.

## Environment

This application requires the following:

* Ruby 2.0.0

* Rails 4.0

* PostgreSQL

## Setup

* download Postgre.app from http://www.postgresql.org/download/macosx/

* run the command below to create the default PostgresSQL user.

```bat
/Applications/Postgres.app/Contents/MacOS/bin/createuser -s postgres
```

* bundle install

## Rake Tasks

* run the command below to load the 3 CSV files into the database

```ruby
rake db:populate
```

* run the application to start manually walking through the draft

```ruby
bundle exec rails server
```

* run the command below to simulate the entire draft

```ruby
rake simulate
```

* to reset the database, run

```ruby
rake db:reset
rake db:populate
```

## User Stories

### The basic functionality that needs developed:

  In order to record the results of the Draft in real-time
  As a System Administrator (don't implement authorization)
  I want to assign a player to a team during the draft period
  (which is defined by the draft order)

  * completed: run the web application & click start draft to begin assigning players

  In order to get a real time update
  As a User
  I want to see the results of the draft by round and by NFL Team

  * completed: draft results (via the navbar) displays the current draft results by round and NFL team

  In order to see which players are still draftable
  As a User
  I want to be able to view all remaining players alphabetically by position

  * completed: while drafting all players are listed alphabetically, by position
  * completed: sorting by position is also available via the position select list

  In order to see only what is actively happening
  As a User
  I want to see the latest 3 picks and which team is next to pick

  * completed: the application index lists the last 3 drafts and the next team that will draft

## Notes

* if the draft is simulated, 255 players will be drafted and 141 players will remain undrafted (395 players, 255 draft orders)

* if you wish to use rails console, make sure to check out Hirb for clean output (example below)

```bat
~> bundle exec rails console
```

```bat
irb(main):001:0> Hirb.enable
```

```bat
irb(main):002:0> Player.all
  Player Load (1.7ms)  SELECT "players".* FROM "players"
irb(main):003:0> Player.first
  Player Load (0.7ms)  SELECT "players".* FROM "players" ORDER BY "players"."id" ASC LIMIT 1
+----+--------------+----------+---------+----------+
| id | name         | position | drafted | draft_id |
+----+--------------+----------+---------+----------+
| 1  | Sam Bradford | QB       | true    | 1        |
+----+--------------+----------+---------+----------+
1 row in set
```
