# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_miniWiki_session',
  :secret      => '92290c72d45d69cac84964d339ec5f15597ad08e93f2d510471b0b97079cad9d2a9f721718f9f467bc5e81acd4ca191d904320afd727f5f1a2f5b2811a3ea548'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
