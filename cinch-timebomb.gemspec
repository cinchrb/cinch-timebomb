# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'cinch-timebomb'
  s.version = '0.0.2'
  s.description = "Timebomb is a game where one person asks the Eggdrop bot to plant a timebomb in another user's pants. The target user then needs to diffuse the bomb by cutting the correct wire, or be kicked from the channel"
  s.summary = "Plant a timebomb in someone's pants and see if he can defuse it."
  s.authors = ['Dominik Honnef']
  s.email = ['dominikh@fork-bomb.org']
  s.homepage = 'http://rubydoc.info/github/cinchrb/cinch-timebomb'
  s.required_ruby_version = '>= 1.9.1'
  s.files = Dir['LICENSE', 'README.md', '{lib,examples}/**/*']
  s.add_dependency("cinch", "~> 2.0")
  s.license = "MIT"
end
