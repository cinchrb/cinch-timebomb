# Timebomb plugin

This plugin provides dice for your channel.

## Installation
First install the gem by running:
    [sudo] gem install cinch-timebomb

Then load it in your bot:
    require "cinch"
    require "cinch/plugins/timebomb"

    bot = Cinch::Bot.new do
      configure do |c|
        # add all required options here
        c.plugins.plugins = [Cinch::Plugins::Timebomb] # optionally add more plugins
      end
    end

    bot.start

## Commands
- timebomb <nick>
- cutwire <color>

### Examples
    timebomb dominikh

## Options
### :min_duration & :max_duration

These options determine how long a user has time to defuse the bomb.
The actual duration is a random value between `:min_duration` and
`:max_duration`. Defaults to 10 and 30, respectively.

### :wires

How many wires the user has to pick from. Defaults to 6.

### :channels

This option is an array of channels the timebomb plugin should be
enabled in. This is a required option with no default value.

### Example configuration
    configure do |c|
      c.plugins.options[Cinch::Plugins::Timebomb] = {min_duration: 5,
                                                 max_duration: 20,
                                                 wires: 5,
                                                 channels: ["#cinch-bots"]
    end
