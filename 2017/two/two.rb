#
# GoogleJam 2017 Qual B
#

def tidy?(n)
  x = n.digits.reverse
  for i in 0..(x.length - 2)
    return false if x[i] > x[i + 1]
  end
  return true
end


def large(n)
  return n if n < 10
  return 9 if n == 10
  t = true
  nn = n
  while t
    x = nn.digits
    for i in (0..x.length - 2)
      if x[i] < x[i + 1]
        nn = nn.floor(-(i + 1)) - 1
        break
      end
      t = false if i == x.length - 2
    end
  end

  return nn
end

def two(n)
  counter = n
  while counter > 0
    return counter if tidy?(counter)
    counter -= 1
  end

  return nil
end

def twotest()
  for i in (1..100000)
    a = two(i)
    b = large(i)
    puts "#{i} Mismatch #{a} vs #{b}" if a != b
  end
  return nil
end



def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      fout.puts "Case ##{fin.lineno - 1}: #{large(line.to_i)}"
    end
  end
  fout.close
end

drive('B-large.in')
# drive('B-small-attempt0.in')
# drive('test.in')
