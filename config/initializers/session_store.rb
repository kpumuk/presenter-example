# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_presenter-example_session',
  :secret      => '066165c0d619be75118da583aaf278a7624586462f8f96501967607c40f4fa5984d3b713fd0dc81a3f23edc7894c0950e775ca3df441166dd87d5d01202beb23'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
