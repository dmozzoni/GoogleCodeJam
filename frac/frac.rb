# https://code.google.com/codejam/contest/6254486/dashboard#s=p3
#
# Brute force approach, seems to work for small inputs, but
# quickly runs out of memory (probably in the k>20 range) and so fails both
#
#
#

def frac (k, c, s)
  #
  ans = []
  tile = ['G', 'L']
  possible_source_sequences = tile.repeated_permutation(k).to_a
  seq = possible_source_sequences.dup
  for i in (2..c)
    seq = seq.map.with_index { |e, i| e.map { |ee| ee = (ee == 'G') ? 'G'*k : possible_source_sequences[i].join('') }}
    seq = seq.map { |e| e.join('').split('')  }
  end

  for ii in (1..s)
    ss = seq.transpose
    ssl = ss.map { |e| e.count('L') }

    fewest_lead = ssl.min
    index_fewest_lead = ssl.find_index(fewest_lead)
    ans.push(index_fewest_lead)
    break if fewest_lead == 1
    tmp = []
    ss[index_fewest_lead].each.with_index { |e, i| tmp.push(seq[i]) if e == 'L'}
    seq = tmp
    return ['IMPOSSIBLE'] if ii == s and fewest_lead != 1
  end

  return ans.collect { |e| e + 1 }
end

def drive(filename)
  require 'benchmark'
  time = Benchmark.realtime do
    fout = File.new(filename + '.out', 'w+')
    File.open(filename) do |fin|
      fin.gets # number of test cases
      loop do
        break unless line = fin.gets
        k = line.split(' ')[0].to_i
        c = line.split(' ')[1].to_i
        s = line.split(' ')[2].to_i

        ans = frac(k, c, s)
        fout.puts "Case ##{fin.lineno - 1}: " + ans.join(' ')
      end
    end
    fout.close
  end
  puts time
end

# drive('test.in')
drive('D-small-practice.in')
# drive('C-large-practice.in')
