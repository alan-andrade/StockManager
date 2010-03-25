# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_StockManager_session',
  :secret      => 'f8fdb6327d2b6f0a6486cd42ce990279b6af3202c45ca14a32a1ae5f7a5e41e927ad251b3bb27b50091b1b7068197544422ff97c6a3ecec1947670407f00cbdd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
