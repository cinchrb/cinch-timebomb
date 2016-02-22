require "cinch"

module Cinch
  module Plugins
    class Timebomb
      include Cinch::Plugin

      Bomb = Struct.new(:user, :timer, :correct_wire)

      def initialize(*args)
        super

        @bombs = {}
      end
      Colors = %w{red orange yellow green blue indigo violet black
      white grey brown pink mauve beige aquamarine chartreuse bisque
      crimson fuchsia gold ivory khaki lavender lime magenta maroon
      navi olive plum silver tan teal turquoise}


      match /timebomb ([^ ]+)/, method: :plant_bomb
      match /cutwire ([^ ]+)/, method: :cut_wire
      self.react_on = :channel
      self.required_options = [:channels]

      def plant_bomb(m, whom)
        whom = User(whom)
        return unless m.channel.users[whom]
        return unless config[:channels].any? {|s| Channel(s) == m.channel}

        if whom == @bot
          m.channel.kick(m.user, "I will not tolerate this!")
          return
        end

        if @bombs[m.channel]
          m.channel.action "points at the bulge in the back of #{@bombs[m.channel].user}'s pants."
          return
        end

        min_duration = config[:min_duration] || 10
        max_duration = config[:max_duration] || 30
        num_wires    = config[:wires]        ||  6
        duration     = rand(max_duration - min_duration) + min_duration
        wires        = Colors.sample(num_wires)

        m.channel.action "stuffs the bomb into %s's pants. The display reads [%d] seconds." % [whom, duration]
        m.reply "Defuse the bomb by cutting the correct wire. There are %d wires. They are %s" % [num_wires, wires.map {|s|
                                                                                                    s.capitalize }.join(", ")]


        timer = Timer(duration, shots: 1) do
          m.channel.kick(whom, "*BOOM!*")
          @bombs[m.channel] = nil
        end

        @bombs[m.channel] = Bomb.new(whom, timer, wires.sample)
      end

      def cut_wire(m, wire)
        bomb = @bombs[m.channel]
        return unless bomb
        return unless bomb.user == m.user

        if bomb.correct_wire == wire.downcase
          m.reply "%s cut the %s wire. This has defused the bomb!" % [m.user, wire.capitalize]
        else
          m.channel.kick(m.user, "snip... *BOOM!*")
        end
        @bombs[m.channel] = nil
        bomb.timer.stop
      end
    end
  end
end
