VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = Rails.root.join("spec","vcr", "fixtures")
  c.hook_into :faraday
end
