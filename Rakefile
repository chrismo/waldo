require 'rake/clean'

JASMINE_NODE = 'node_modules/jasmine-node/bin/jasmine-node'
HUBOT_ROOT = ENV['HUBOT_ROOT'] || '../hubot'

task :default => [:test]

task :test => :clean do |t|
  sh JASMINE_NODE, '--coffee', '--forceexit', '--verbose', 'spec'
end

# I prefer to output js files to the same directory for easy browsing of
# the transpiled output to troubleshoot. But jasmine-node will pick up
# both .coffee and .js files and execute both, duplicating the tests,
# so this CLEAN setup will ensure they're removed.
CLEAN.clear
CLEAN << Rake::FileList['spec/*.js']

desc "Copy .coffee scripts to #{HUBOT_ROOT}. Set HUBOT_ROOT env to override destination."
task :deploy do
  FileUtils.cp(Dir['./js/**/*.coffee'], File.join(HUBOT_ROOT, 'scripts'), verbose: true)
end
