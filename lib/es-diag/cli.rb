require 'es-diag'
require 'thor'
require 'es-diag'


class ES::Diag::CLI < Thor

  desc "status", "report back current status and recommendations."
  def status(cluster_node=nil)
    info "Checking..."
    ES::Diag::Config['es_local_node'] = cluster_node
    c = ES::Diag::Check.new(self)
    c.all_checks
  end



  no_tasks do
    def title(text)
      say "\n* #{text}"
    end

    def info(detail=nil)
      say detail, :green
    end

    def warn(detail)
      say detail, :yellow
    end

    def error(detail)
      say detail, :red
    end

    def em(text)
      shell.set_color(text, nil, true)
    end
  end

end
