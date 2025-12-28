# How to Push Rails UI Guard to GitHub

## Step 1: Navigate to the gem directory

```bash
cd rails_ui_guard_gem
```

## Step 2: Initialize Git (if not already done)

```bash
git init
git branch -M main
```

## Step 3: Add all files

```bash
git add .
```

## Step 4: Make initial commit

```bash
git commit -m "Initial commit: Rails UI Guard v0.1.0 - Feature locking and status management system for Rails"
```

## Step 5: Add GitHub remote

```bash
git remote add origin https://github.com/KapilDevPal/Rails-Ui-Guard.git
```

## Step 6: Push to GitHub

```bash
git push -u origin main
```

## Step 7: Build and test the gem locally

```bash
gem build rails_ui_guard.gemspec
gem install rails_ui_guard-0.1.0.gem --local
```

## Step 8: Publish to RubyGems (optional)

First, sign up at https://rubygems.org and get your API key.

```bash
gem push rails_ui_guard-0.1.0.gem
```

## Quick Setup Script

You can also use the provided setup script:

```bash
./setup_gem.sh
```

Then follow the instructions it prints.

## Using the Gem

### From GitHub

Add to your Gemfile:

```ruby
gem 'rails_ui_guard', git: 'https://github.com/KapilDevPal/Rails-Ui-Guard.git'
```

### From RubyGems (after publishing)

Add to your Gemfile:

```ruby
gem 'rails_ui_guard'
```

Then:

```bash
bundle install
rails generate rails_ui_guard:install
rails db:migrate
```

