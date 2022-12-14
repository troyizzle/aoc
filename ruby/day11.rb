class Monkey
  attr_reader :id, :inspected_items_count, :test

  def initialize
    @conditions = {}
    @inspected_items_count = 0
  end

  def parse_line(line)
    if line.start_with?('Monkey')
      @id = line.scan(/\d/)[0].to_i
    elsif line.start_with?('Starting')
      @starting_items = line.scan(/\d.+/)[0].split(',').map(&:to_i)
    elsif line.start_with?('Operation:')
      @operation = line.gsub('Operation: ', '').split(' ')
    elsif line.start_with?('Test:')
      @test = line.gsub('Test: ', '').split(' ')
    elsif line.start_with?('If ')
      split = line.gsub('If ', '').split(' ')
      @conditions[split[0]] = split[1..]
    end
  end

  def run(monkeys, relief)
    @monkeys = monkeys
    item = @starting_items.shift
    while item
      run_operation(item, relief)

      item = @starting_items.shift
    end
  end

  def take_item(item)
    @starting_items << item
  end

  private

  def run_operation(item, relief)
    @inspected_items_count += 1
    p "Monkey inspects an item with a worry level of #{item}"
    worry_level =  [item, second_number(item)].inject(operator(@operation[3]))
    p "Worry level is multipled by #{item} to #{worry_level}"
    # divide = (worry_level / 3).floor
    divide = worry_level
    divide %= relief
    p "Monkey gets bored with item. Worry level is divided by 3 to #{divide}"
    monkey_id_to_give_item = nil
    if test_result?(divide)
      p "Current worry level is #{@test[0]} by #{@test[-1]}"
      pretty_output_conditions(@conditions['true:'], divide)
      monkey_id_to_give_item = @conditions['true:'][-1]
    else
      p "Current worry level is not #{@test[0]} by #{@test[-1]}"
      pretty_output_conditions(@conditions['false:'], divide)
      monkey_id_to_give_item = @conditions['false:'][-1]
    end

    give_monkey_item(monkey_id_to_give_item.to_i, divide)
  end

  def pretty_output_conditions(condition, divide)
    p "Item with worry level: #{divide} #{condition.join(' ')}"
  end

  def give_monkey_item(monkey_id, item)
    other_monkey = @monkeys.find { |monkey| monkey.id == monkey_id }
    other_monkey.take_item(item)
  end

  def test_result?(divide)
    result = [divide.to_f, @test[-1].to_i].inject(operator(@test[0]))
    result2 = result.to_i
    (result2 - result) == 0
  end

  def second_number(item)
    case @operation[-1]
    when 'old' then item
    else @operation[-1].to_i
    end
  end

  def operator(opt)
    case opt
    when '*' then :*
    when '/', 'divisible' then :/
    when '+' then :+
    else
      raise "No operator for: #{opt}, self: #{inspect}"
    end
  end
end

monkeys = []

File.readlines('../inputs/day11.txt', chomp: true)
    .chunk_while { |_a, b| b != '' }
    .each do |monkey_array|
  monkey = Monkey.new
  monkey_array.each do |line|
    monkey.parse_line(line.strip)
  end
  monkeys << monkey
end

relief = monkeys.map.each do |monkey|
  monkey.test[-1].to_i
end.inject(:*)

(1..10000).each do |round|
  monkeys.each do |monkey|
    p monkey.run(monkeys, relief)
  end
end

inspected_count = monkeys.map { |monkey| monkey.inspected_items_count }
puts inspected_count.sort.reverse[0..1].inject(:*)
