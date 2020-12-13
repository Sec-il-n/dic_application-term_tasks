I18n.config.available_locales = [:ja, :en]
I18n.default_locale = :ja
# 複数のローケルファイルを読み込む
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
