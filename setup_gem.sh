#!/bin/bash

# Rails UI Guard Gem Setup Script
# This script helps set up the gem for GitHub and RubyGems

set -e

echo "🚀 Setting up Rails UI Guard gem..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Add all files
echo "📝 Adding files to git..."
git add .

# Build the gem
echo "🔨 Building gem..."
gem build rails_ui_guard.gemspec

echo "✅ Gem setup complete!"
echo ""
echo "Next steps:"
echo "1. Review the gem: gem install rails_ui_guard-*.gem --local"
echo "2. Add remote: git remote add origin https://github.com/KapilDevPal/Rails-Ui-Guard.git"
echo "3. Commit: git commit -m 'Initial commit: Rails UI Guard v0.1.0'"
echo "4. Push: git push -u origin main"
echo "5. Publish to RubyGems: gem push rails_ui_guard-*.gem"

