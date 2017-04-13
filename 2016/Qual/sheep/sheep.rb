# https://code.google.com/codejam/contest/6254486/dashboard#s=p0
# passes both


def sheep(n)
  return 'INSOMNIA' if n.zero?
  h = Array.new(10).fill(false)
  num, loop = n, 1

  while h.any? { |i| i == false }
    num.to_s.split('').each { |i| h[i.to_i] = true }
    loop += 1
    num = loop * n if h.any? { |i| i == false }
  end

  return num
end

def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      fout.puts "Case ##{fin.lineno - 1}: #{sheep(line.to_i)}"
    end
  end
  fout.close
end
