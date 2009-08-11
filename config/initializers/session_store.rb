# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_solr2_session',
  :secret      => 'b4ac48776130a39a4983dfc45499581561735381a46ddaa2a99a8fc848b5659f8919803b5650852452ce3e673883224d77ecf31091ddfc705e594681e35e7d4c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
