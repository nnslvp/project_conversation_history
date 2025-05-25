# Project Conversation History

Simple Rails app for tracking project status changes and conversations.

## Setup

Ruby 3.4.4
SQLite database

```bash
bundle install
rails db:create db:migrate
rails db:seed
./bin/dev
```

## Using

1. Visit `http://localhost:3000`
2. Default user credentials (from seed):
   - Email: `user@example.com`
   - Password: `password123`
