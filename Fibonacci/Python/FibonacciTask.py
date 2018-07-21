import time
import sys
from multiprocessing import Pool

def func(n):
    if n <2:
            return n
    else:
            return func(n-2) + func(n-1)

argv = int(sys.argv[1])
stratTime = time.time()
if __name__ == "__main__":
        p = Pool(2)
        p.map(func, range(argv))
#print('第{0}項 = {1}'.format(argv,func(argv)))
func(argv)
endTime = time.time() #プログラムの終了時刻
runTime = endTime - stratTime #処理時間
print('time = {:.10f}sec'.format(runTime)) #処理時間を表示
