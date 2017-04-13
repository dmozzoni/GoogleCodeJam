#
# GoogleJam 2017 Qual A
#

def one(s,k)
  ss = s.split('').map { |e| e == '+' ? true : false }
  return 0 if ss.all?
  ss_max = ss.length
  flips = 0

  until ss.all?
    flips += 1
    b = ss.index(false)
    return 'IMPOSSIBLE' if b + k > ss_max
    ss[b..(b + k - 1)] = ss[b..(b + k - 1)].map(&:!)
  end

  return flips
end

def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      line = line.split (' ')
      fout.puts "Case ##{fin.lineno - 1}: #{one(line[0],line[1].to_i)}"
    end
  end
  fout.close
end

drive('A-large.in')
# drive('A-small-attempt0.in')
# drive('test.in')
