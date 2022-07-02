Boxing.config do |c|
  c.build_packages = %w[nodejs python3]
  c.assets_precompile = true
  # If not given the `node -v` will be execute
  c.node_version = '14.17.1'
end
