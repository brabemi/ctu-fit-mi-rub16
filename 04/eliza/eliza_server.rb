require 'gserver'

class ElizaServer < GServer

  def initialize(port)
    super(port)
    @request_cnt = 0
  end

  def serve(io)
    @request_cnt += 1
    log "request \##{@request_cnt}"
    loop do
      line = io.readline.strip
      log "recv: '#{line.strip}'"
      reply = eliza_logic(line)
      log "repl: '#{reply}'"
      io.puts reply
    end
  end

protected

  def eliza_logic(input)
    # TODO: here comes the ingelligent part
    'I\'m not sure I understand you fully.'
  end

end
