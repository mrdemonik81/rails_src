# frozen_string_literal: true

require 'cucumber/rails'

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :transaction

Cucumber::Rails::Database.javascript_strategy = :truncation

# Before('@no-txn or @selenium or @culerity or @celerity or @javascript') do
#   DatabaseCleaner.strategy = :truncation
# end
