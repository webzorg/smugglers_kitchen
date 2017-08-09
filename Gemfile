source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "devise"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.1"
gem "sass-rails", "~> 5.0"
# gem "uglifier", ">= 1.3.0"

gem "bootstrap"
source "https://rails-assets.org" do
  gem "rails-assets-tether", ">= 1.1.0"
end
gem "figaro"
gem "haml"
gem "haml-rails" # rails haml:erb2haml
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kaminari"
gem "select2-rails"
gem "turbolinks", "~> 5"

gem "savon"
# gem "passenger"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rails"
  gem "capistrano-rvm"

  gem "i18n-tasks", "~> 0.9.6"
  gem "i18n_generators", "~> 2.1", ">= 2.1.1"

  gem "guard-livereload", "~> 2.5", require: false
  gem "pry"
  gem "rack-livereload" # for guard-livereload
  gem "rubocop"
  gem "scss_lint", require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
