require 'es-diag'
require 'thor'
require 'es-diag'


class ES::Diag::CLI < Thor

  desc "status", "report back current status and recommendations."
  def status
    say "Checking..."
    c = ES::Diag::Check.new(self)
    c.all_checks

  end



  no_tasks do
    def title(text)
      say "* #{text}"
    end

    def info(detail=nil)
      say detail, :green
    end

    def warn(detail)
      say detail, :yellow
    end
  end

end
