# https://code.google.com/codejam/contest/6254486/dashboard#s=p1
# passes both

def pan(s)
  ss = s.split('').map { |e| e == '+' ? true : false }
  return 0 if ss.all?
  flips = 0
  until ss.all?
    flips += 1
    b = ss.rindex(false)
    ss[0..b] = ss[0..b].map{ |i| !i }
  end
  return flips
end


def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      fout.puts "Case ##{fin.lineno - 1}: #{pan(line.chomp)}"
    end
  end
  fout.close
end

drive('B-large-practice.in')
