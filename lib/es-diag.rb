require "es-diag/version"
require 'ohai'


module ES
  module Diag
    module Context
      def self.data
        unless @ohai
          Ohai::Config[:plugin_path] << File.expand_path('ohai_plugins', File.dirname(__FILE__))
          @ohai= Ohai::System.new
          @ohai.all_plugins
        end
        @ohai
      end
    end
  end
end

require 'es-diag/check'

