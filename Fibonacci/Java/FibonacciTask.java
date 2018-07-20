import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;
class FibonacciTask extends RecursiveTask<Integer> {
    private final int n;

    FibonacciTask(int n) {
        this.n = n;
    }

    @Override
     protected Integer compute() {
        if (n == 0) {
            return 0;
        } else if (n == 1) {
            return 1;
        } else {
            FibonacciTask f1 = new FibonacciTask(n - 1);
            FibonacciTask f2 = new FibonacciTask(n - 2);

            f2.fork();
            return f1.compute() + f2.join();
        }
    }

    public static void main(String[] args) {
        long start_time = System.nanoTime();
        ForkJoinPool pool = new ForkJoinPool();
        System.out.println("第" + args[0] + "項" +pool.invoke(new FibonacciTask(Integer.parseInt(args[0]))));
        long end_time = System.nanoTime();
        //System.out.println(end_time-start_time);
        System.out.println("time = " + (Math.pow(10,-9)*(end_time - start_time)) + " [sec]");
    }
}
