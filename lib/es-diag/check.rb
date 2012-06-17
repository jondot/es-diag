class ES::Diag::Check
  def initialize(ui)
    @ui = ui
  end

  def title(text)
    @run_context[:title] = text
  end

  def data
    @data ||= ES::Diag::Context.new(@ui).data
  end

  def how_to(text)
    @run_context[:help ] = text
  end

  def warn(text)
    @run_context[:warnings] ||= []
    @run_context[:warnings] << text
  end


  def all_checks
    Dir[File.expand_path('../checks/*.rb', File.dirname(__FILE__))].each do |fcheck|
      run_check(fcheck)
    end
  end

  def run_check(filename)
    @run_context  = {}
    self.instance_eval(IO.read(filename), filename, 1)
    @ui.title @run_context[:title] || "#{filename}"
    if @run_context[:warnings] && @run_context[:warnings].length > 0
      @ui.warn "#{@run_context[:warnings].length} problem(s) found:"
      @run_context[:warnings].each do | warning |
        @ui.warn "- #{warning}"
      end
      if @run_context[:help]
        @ui.info "\n\n#{@ui.em 'Use these instructions to amend the problems:'}"
        @ui.info @run_context[:help] + "\n"
      end
    end
  end
end
