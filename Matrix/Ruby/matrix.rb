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
   a.mul(b)  #=>[[-1, -3, 5], [-4, 6, -4], [5, -3, -1]]
  p "TIME #{Time.now - start_time}s"