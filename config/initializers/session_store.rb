# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nerdtrack_session',
  :secret      => 'e7fa5b2a3b88f38217ef1a94a9d1c3b496807ef6adbf226476ef88bbd51e16b82a20ba45a77a667200ba16a16e7ae74df0e4599a689bc08560990c9ee51c267d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
