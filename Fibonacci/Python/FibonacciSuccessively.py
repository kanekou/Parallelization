import time
import sys

def func(n):
    if n <2:
            return n
    else:
            return func(n-2) + func(n-1)

stratTime = time.time()            
argv = int(sys.argv[1])
print('第{0}項 = {1}'.format(argv,func(argv)))
endTime = time.time() #プログラムの終了時刻
runTime = endTime - stratTime #処理時間
print('time = {0}s'.format(runTime)) #処理時間を表示
