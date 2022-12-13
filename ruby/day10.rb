class Scanner
  def initialize
    @signal_strengths = []
    @x = 1
    @cycle = 1
    @crt = 0
    @calculate_signal_cycles = 20
    @crt_pos = []
  end

  def handle_command(command, arg)
    @command = command
    arg = arg.to_i
    run
    run(arg) if command != 'noop'
  end

  def part_a_answer
    @signal_strengths.sum
  end

  def part_b_answer
    @crt_pos.each do |pos|
      p pos.join('')
    end
  end


  private

  def calculate_signal_strengths
    return unless @cycle == @calculate_signal_cycles

    @signal_strengths.push @x * @calculate_signal_cycles
    @calculate_signal_cycles += 40
  end

  def sprite_position
    [@x - 1, @x, @x + 1]
  end


  def draw_crt_raw
    if @crt_pos.empty? || @crt_pos[-1].length == 40
      @crt_pos << [sprite_position.include?(@crt) ? '#' : '_']
    else
      @crt_pos[-1].push sprite_position.include?(@crt) ? '#' : '_'
    end
  end

  def crt_pos_length
    @crt_pos.length
  end

  def run(arg = nil)
    draw_crt_raw
    calculate_signal_strengths
    @cycle += 1
    @crt += 1
    @crt = 0 if @crt == 40
    return if arg.nil?

    @x += arg
  end

end

scanner = Scanner.new

File.readlines('../inputs/day10.txt', chomp: true).each do |line|
  command, arg = line.split(' ')
  scanner.handle_command(command, arg)
end

p scanner.part_a_answer
scanner.part_b_answer
