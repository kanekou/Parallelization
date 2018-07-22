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
    fib(0)
    fib(1)
    fib(2)
    fib(3)
    fib(4)

p "TIME #{Time.now - start_time}s"