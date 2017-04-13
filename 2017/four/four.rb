#
# GoogleJam 2017 Qual D
#

require 'matrix'

def p(grid)
  grid.each { |e| puts e.join(' ') }
end

def style_points(grid)
  val = 0
  grid.each { |e| val += e.count('+') + e.count('x') + 2 * e.count('o') }
  return val
end

def valid(m)
  size = m.row_count
  for i in 0..size-1
    return false if m.row(i).count('x') + m.row(i).count('o') > 1
    return false if m.column(i).count('x') + m.column(i).count('o') > 1
  end

  d = Array.new(2*(size-1) + 1) { Array.new }
  for i in 0..size - 1
    for j in 0..size - 1
      d[i+j].push(m[i, j])
    end
  end

  dd = Array.new(2 * (size - 1) + 1) { Array.new }
  for i in 0..size - 1
    for j in 0..size - 1
      dd[i - j + (size - 1)].push(m[i, j])
    end
  end

  for i in d
    return false if i.count('+') + i.count('o') > 1
  end
  for i in dd
    return false if i.count('+') + i.count('o') > 1
  end

  return true
end

def four(n, m, grid)
  a = Array.new(n) { Array.new(n, '.') }
  for i in grid
    model = i.split(' ')
    a[model[1].to_i - 1][model[2].to_i - 1] = model[0]
  end
  m = Matrix.rows(a)

  m.each_with_index do |e, row, col|
    puts "#{e} at #{row}, #{col}"
    next if m.row(row).any? { |e| e == 'o' || e == 'x' }
    next if m.column(col).any? { |e| e == 'o' || e == 'x' }

  end



  return [valid(m), style_points(m)]
end

def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      line = line.split(' ')
      n = line[0].to_i
      m = line[1].to_i
      grid = []

      for i in (1..m)
        grid.push(fin.gets)
      end

      fout.puts "Case ##{fin.lineno - 1}: #{four(n, m, grid). join(' ')}"
    end
  end
  fout.close
end

# drive('D-large.in')
# drive('D-small-attempt0.in')
drive('test.in')
