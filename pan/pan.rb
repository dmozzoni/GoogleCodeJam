#
# https://code.google.com/codejam/contest/6224486/dashboard#s=p1&a=1
# Passed both small and large dataset as is
#

def pan(d, p)
  p = p.split(' ').map(&:to_i)
  minutes = []
  pmax = p.max
  start = (pmax - 1).zero? ? 1 : 2
  fin   = pmax
  for i in (start..fin)
    q = p.dup
    c = 0
    minutes.push(q.max)
    # puts 'Start: ' + p.max.to_s + '  ' + p.to_s

    while q.any? { |e| e > i }
      qmax = q.max
      ii = q.find_index(qmax)
      # p[ii] = pmax/2
      # p.push(pmax - p[ii])
      q[ii] = i
      q.push(qmax - q[ii])
      c += 1
      # puts ' Loop: ' + p.max.to_s + '  c: ' + c.to_s + '  Cost: ' + (p.max + c).to_s + '   ' + p.to_s
      minutes.push(q.max + c)
      break if c > pmax
    end
  end

  return minutes.min
end

def drive(filename)
  require 'benchmark'
  testcase = 1
  time = Benchmark.realtime do
    fout = File.new(filename + '.out', 'w+')
    File.open(filename) do |fin|
      fin.gets # number of test cases
      loop do
        break unless line = fin.gets
        num_diners = line.to_i
        line = fin.gets
        arr_pancakes = line
        fout.puts "Case ##{testcase}: " + pan(num_diners, arr_pancakes).to_s
        testcase += 1
      end
    end
    fout.close
  end
  puts time
end




# drive('B-large-practice.in')
drive('B-small-practice.in')
# drive('test.in')
