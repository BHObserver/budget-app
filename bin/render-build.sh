#!/usr/bin/env bash
# Exit on error
set -o errexit

# Ensure Bundler is installed
if ! command -v bundle &> /dev/null; then
  echo "Bundler not found. Installing Bundler..."
  gem install bundler
fi

# Install dependencies
echo "Installing Ruby dependencies..."
bundle install --deployment --without development:test

# Precompile assets
echo "Precompiling assets..."
./bin/rails assets:precompile

# Clean up assets (optional)
# echo "Cleaning up assets..."
# ./bin/rails assets:clean

echo "Deployment script completed successfully."
