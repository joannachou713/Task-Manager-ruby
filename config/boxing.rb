Boxing.config do |c|
  c.build_packages = %w[nodejs]
  c.assets_precompile = true
  # If not given the `node -v` will be execute
  c.node_version = '14.18'
end
