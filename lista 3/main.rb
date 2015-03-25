def pierwsza(n)
  (2..n).to_a.keep_if { |x| (2..Math.sqrt(x)).none? {|y| x % y == 0} }
end

p pierwsza(1000)


def doskonale(n)
  (6..n).to_a.keep_if { |x| x == (1..(x/2)).to_a.keep_if {|y| x % y == 0}.inject {|suma, z| suma + z} }
end

p doskonale(10000)