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
    proc_in = input.downcase
    if proc_in.include? 'hello'
      'Hello. My name is Eliza. How may I help you?'
    elsif proc_in.include? 'ache'
      'Maybe you should consult a doctor of medicine.'
    elsif proc_in.include? 'problem'
      'Say, do you have any psychological problems?'
    elsif proc_in.include? 'not really'
      'Are you sure?'
    elsif proc_in.include? 'mother'
      'You mentioned your mother, how\'s your relationship?'
    elsif proc_in.include? 'i think'
      'Do you really think so?'
    elsif proc_in.include? 'do you'
      'We were discussing you, not me.'
    else
      'I\'m not sure I understand you fully.'
    end
  end

end
