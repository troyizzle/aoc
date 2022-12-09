class Directory
  attr_reader :folder_structure, :current_directory, :sizes
  FILE_SYSTEM_SIZE = 70000000

  def initialize
    @folder_structure = {}
    @current_directory = []
    @sizes = {}
  end

  def parse_line(line)
    line = line.split(' ')

    case line[0]
    when '$' then handle_command(line[1], line[2])
    when 'dir' then nil
    else
      add_file_contents(line[1], line[0])
    end
  end

  def part_a_answer
    max = 100_000
    @sizes.keys.sum do |key|
      num = @sizes[key]
      num > max ? 0 : num
    end
  end

  def part_b_answer
    unused_space = FILE_SYSTEM_SIZE - @sizes['/']
    needed_space = 30000000

    @sizes.sort_by(&:last).to_h.each_key do |key|
      value = @sizes[key]
      return value if value + unused_space >= needed_space
    end
  end

  private

  def sum_contents(contents)
    contents.sum { |hash| hash.values[0].to_i }
  end

  def add_file_contents(file_name, file_size)
    hash = @folder_structure.dig(*@current_directory)
    hash['contents'] << { file_name => file_size }
    @current_directory.each_with_index do |_dir, index|
      name = @current_directory[0..index].join('_')
      add_count(name, file_size)
    end
  end

  def add_count(directory, file_size)
    if @sizes[directory]
      @sizes[directory] += file_size.to_i
    else
      @sizes[directory] = file_size.to_i
    end
  end

  def handle_command(cmd, directory)
    case cmd
    when 'cd' then handle_cd(directory)
    when 'ls' then return
    end
  end

  def handle_cd(directory)
    if directory == '..'
      @current_directory.pop
    else
      @current_directory << directory
      initialize_folder_structure
    end
  end

  def initialize_folder_structure
    return if @folder_structure.dig(*@current_directory)

    set_folder_structure_data(@current_directory, { 'contents' => [] })
  end

  def set_folder_structure_data(path, value)
    *path, final_key = path
    to_set = path.empty? ? @folder_structure : @folder_structure.dig(*path)

    return unless to_set

    to_set[final_key] = value
  end
end

directory = Directory.new

File.readlines('../inputs/day7.txt').each do |line|
  line = line.strip
  directory.parse_line(line)
end

puts directory.part_a_answer
puts directory.part_b_answer

