# For CircleCI
require 'bundler/setup'

# Style tests. Rubocop
namespace :style do
  require 'rubocop/rake_task'
  desc 'RuboCop'
  RuboCop::RakeTask.new(:ruby) do |task|
    task.options = ['--display-cop-names']
  end
end

desc 'Alias (style:ruby:auto_correct)'
task default: %w[style:ruby:auto_correct]
