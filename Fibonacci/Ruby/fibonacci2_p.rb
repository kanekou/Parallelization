require 'parallel'
def fib(n)
    f0 = 1
    f1 = 1
    tmp = 0
    for i in 1..100000 do
        tmp = f0 + f1
        f0, f1 = f1,tmp
    end
    #p "Ch#{n} End"
    #p f0
end

start_time = Time.now
    Parallel.each(i=1..4, in_threds: 2) do |list|
        fib(i)
      end
p "TIME #{Time.now - start_time}s"