# https://code.google.com/codejam/contest/6254486/dashboard#s=p2
# passes both


def checkprime(p)
  # not a true check of primality
  # but true check using Ruby Prime class was too slow
  # Assumes enough jamcoins exist in search space
  # to allow for discarding candidates requiring lengthy checks
  return false if p.even?
  for i in (3..20001).step(2) do
    return false if (p % i).zero?
  end
  return true
end

def jam(n, num)
  # require 'prime'
  # require 'parallel'

  answer = []
  l = 0
  nextnum = -1
  d = 3

  while l < num
    nextnum += 1

    z = '0' * (n - 2) + nextnum.to_s(2)
    z = '1' + z[-(n - 2)..-1] + '1'

    b = (2..10).map { |e| z.to_i(e) }

    # next if b.any? { |i| Prime.prime?(i) }
    # next if Parallel.any?(b) { |i| Prime.prime?(i) }
    next if b.any? { |i| checkprime(i) }

    l += 1

    # f = b.map { |e| e.prime_division[0][0] }
    # f = b.map { |e| e.even? ? 2 : e.prime_division[0][0] }
    f = []
    for e in b do
      if e.even?
        f.push(2)
        next
      end
      d += 2 until (e % d).zero?
      f.push(d)
      d = 3
    end

    answer.push([z, b, f])
    break unless z.include? '0'
  end

  return answer
end

def drive(filename)
  require 'benchmark'
  time = Benchmark.realtime do
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      n = line.split(' ')[0].to_i
      j = line.split(' ')[1].to_i
      ans = jam(n, j)
      fout.puts "Case ##{fin.lineno - 1}:"
      for i in (0..j - 1) do
        fout.puts ans[i][0] + ' ' + ans[i][2].join(' ')
      end
    end
  end
  fout.close
end
puts time

end

# drive('test.in')
# drive('C-small-practice.in')
drive('C-large-practice.in')
