#
# GoogleJam 2017 Qual C
#

def three(n, k)
  return [0,0] if n == k
  t = [n]

  while k > 0
    m = t.max
    ii = t.index(m)
    t.delete_at(ii)
    v = m / 2
    if m.odd?
      t.push(v).push(v)
    else
      t.push(v).push(v - 1)
    end
    break if t[-1] == 0 and t[-2] == 0
    k -= 1
  end

  return t.last(2)
end



def three3(n, k)
  return [0,0] if n == k

  p2 = (0..60).map{|i| 2**i }
  kii = p2.index{|e| e > n }

  tmp = p2[kii-1] + p2[kii-2]

  return [0,0] if n >= tmp and k >= p2[kii-1]
  return [0,0] if k + p2[kii-2] -1 > n

  t = [n]
  while k > 0
    m = t.max
    ii = t.index(m)
    t.delete_at(ii)
    v = m / 2
    if m.odd?
      t.push(v).push(v)
    else
      t.push(v).push(v - 1)
    end
    break if t[-1] == 0 and t[-2] == 0
    k -= 1
  end

  return t.last(2)
end

def tt(n, k)
  return [0, 0] if n == k

  p2 = (0..60).map { |i| 2**i }
  kii = p2.index { |e| e > k }

  kiii = p2.index { |e| e > n }
  tmpi = p2[kiii - 1] + p2[kiii - 2]
  return [0, 0] if n >= tmpi && k >= p2[kiii - 1]
  return [0, 0] if (k + p2[kiii - 2] - 1) > n

  return three3(n, k) if k < 1000

  p = n / p2[kii]
  q = p * p2[kii]
  w = n - q
  t = w - (p2[kii] - 1)

  tmp = Array.new(p2[kii], p)
  tmp[0..(-t - 1)] = [p - 1] * (0..(-t - 1)).to_a.length
  tmp = tmp.reverse

  return [tmp[k % p2[kii - 1]], tmp[k % p2[kii - 1] + p2[kii - 1]]]
end

def tt2(n ,k)
  return [0, 0] if n == k

  p2 = (0..60).map { |i| 2**i }
  kii = p2.index { |e| e > k }

  kiii = p2.index { |e| e > n }
  tmpi = p2[kiii - 1] + p2[kiii - 2]
  return [0, 0] if n >= tmpi && k >= p2[kiii - 1]
  return [0, 0] if (k + p2[kiii - 2] - 1) > n

  return three3(n, k) if k < 1000

  p = n / p2[kii]
  q = p * p2[kii]
  w = n - q
  t = w - (p2[kii] - 1)

  o = [p, p]
  o[0] = p - 1 if k % p2[kii - 1] >= t + p2[kii]
  o[1] = p - 1 if k % p2[kii - 1] + p2[kii - 1] >= t + p2[kii]

  return o
end




def drive(filename)
  fout = File.new(filename + '.out', 'w+')
  File.open(filename) do |fin|
    fin.gets
    loop do
      break unless line = fin.gets
      line = line.split(' ')
      fout.puts "Case ##{fin.lineno - 1}: #{tt2(line[0].to_i,line[1].to_i).join(' ')}"
    end
  end
  fout.close
end

drive('C-large.in')
# drive('C-small-2-attempt1.in')
# drive('C-small-1-attempt0.in')
# drive('test.in')
