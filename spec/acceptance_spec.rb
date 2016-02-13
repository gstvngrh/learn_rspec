require 'pty'
require 'high_card'

describe 'Acceptance' do
  def run_app(&block)
    dir = Dir.tmpdir + '/highcard_test_state'
    `rm -Rf #{dir}`
    `mkdir -p #{dir}`
    ENV['HIGHCARD_DIR'] = dir
    PTY.spawn(BIN, &block)
  end

  example 'it works' do
    run_app do |output, input, pid|
      sleep 0.5
      input.write("y\n")
      sleep 0.5

      buffer = output.read_nonblock(1024)
      expect(buffer).to include("You won").or include("You lost")
    end
  end
end
