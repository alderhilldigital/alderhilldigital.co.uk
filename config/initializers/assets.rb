# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(
bootstrap-theme.css
bootstrap.min.css
camera.css
fancybox/*
bootstrap.min.js
camera.min.js
custom.js
jquery.easing.1.3.js
jquery.min.js
jquery.mobile.customized.min.js
)
