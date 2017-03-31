#
# https://code.google.com/codejam/contest/6224486/dashboard
# Passed both small and large dataset as is
#

def stan(smax, people)

  peo = people.split('').map { |i| i.to_i }
  dif = [-1]
  invite = 0

  while dif.any? { |e| e < 0 }
    s = peo.map.with_index { |_e, i| peo[0..i].reduce(:+) }
    dif = s.map.with_index { |e, i| e-(i+1) }
    ii = dif.index { |e| e < 0 }
    peo[ii] = -dif[ii] if ii
    invite += peo[ii] if ii
  end
  return invite
end

def drive(filename)
  require 'benchmark'
  time = Benchmark.realtime do
    fout = File.new(filename + '.out', 'w+')
    File.open(filename) do |fin|
      fin.gets # number of test cases
      loop do
        break unless line = fin.gets
        smax = line.split(' ')[0].to_i
        people = line.split(' ')[1]
        fout.puts "Case ##{fin.lineno - 1}: " + stan(smax, people).to_s
      end
    end
    fout.close
  end
  puts time
end

# drive('test.in')
# drive('A-small-practice.in')
drive('A-large-practice.in')
