require 'parallel'
class Array
    def mul(x)
      m = self.size - 1
      n = x.size - 1
      c = Array.new(m + 1)
      c.each_index {|i| c[i] = Array.new(m + 1, 0)}
      for i in 0..m
        for j in 0..m
      for k in 0..n
        c[i][j] += self[i][k] * x[k][j]
      end
        end
      end
      c
    end
  end
  
  n =ARGV[0].to_i
  m =ARGV[0].to_i

  start_time = Time.now
  m-=1
  n-=1
  a = Array.new(m + 1)
  a.each_index {|i| a[i] = Array.new(m + 1, 0)}
  b = Array.new(m + 1)
      b.each_index {|i| b[i] = Array.new(m + 1, 0)}
  for i in 0..m
    for j in 0..n
        a[m][n]=50
        b[m][n]=50
    end
  end

  Parallel.each(1..m, in_threds: 20) do |list|
    a.mul(b) 
  end
  p "TIME #{Time.now - start_time}s"