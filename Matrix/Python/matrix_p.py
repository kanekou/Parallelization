import time
import sys
from multiprocessing import Pool

def func(n):
    a = [[50 for j in range(n)] for i in range(n)]
    b = [[50 for j in range(n)] for i in range(n)]
    c = [[0 for j in range(n)] for i in range(n)]
    for i in range(n):
        for j in range(n):
            for k in range(n):
                c[i][j] += a[i][k]*b[k][j]
    return c

argv = int(sys.argv[1])
argv2 = int(sys.argv[2])
stratTime = time.time()
if __name__ == "__main__":
    p = Pool(argv2)
    p.map(func, range(argv))
func(argv)
endTime = time.time() #プログラムの終了時刻
runTime = endTime - stratTime #処理時間
print('time = {:.10f}sec'.format(runTime)) #処理時間を表示
