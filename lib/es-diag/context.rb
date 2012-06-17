require 'hashie'

module ES
  module Diag
    class Context

      def initialize(ui)
        @ui=ui
      end
      
      def warn(text)
        @ui.warn "[#{@run_context[:title]}] #{text}"
      end

      def error(text)
        @ui.warn "[#{@run_context[:title]}] #{text}"
      end

      def title(text)
        @run_context[:title] = text
      end

      def context(k,v)
        @run_context[:context] = {:key => k, :val => v} 
      end

      def data
        unless @ohai
          @ui.info("Collecting system information...")
          Ohai::Config[:plugin_path] << File.expand_path('../ohai_plugins', File.dirname(__FILE__))
          @ohai = Ohai::System.new
          @ohai.all_plugins

          #enrich base data
          @ui.info("Collecting extra information...")
          all_contexts
        end
        @ohai
      end

      def all_contexts
        Dir[File.expand_path('../contexts/*.rb', File.dirname(__FILE__))].each do |fcheck|
          run_context(fcheck)
        end
      end

      def run_context(filename)
        @run_context = {}
        self.instance_eval(IO.read(filename), filename, 1)
        if @run_context[:context]
          data[@run_context[:context][:key]] = Hashie::Mash.new @run_context[:context][:val]
        else
          warn "No real data fetched. Watch output for errors."
        end
      end
    end
  end
end

