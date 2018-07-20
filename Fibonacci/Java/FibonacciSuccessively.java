public class FibonacciSuccessively {
    public static void main(String[] args) {
        // 計算処理
        long start_time = System.nanoTime();
        int result = func(Integer.parseInt(args[0]));


        // 出力
        System.out.println("第" + args[0] + "項" + result);
        long end_time = System.nanoTime();
        System.out.println(end_time-start_time);
        System.out.println("time = " + (Math.pow(10,-6)*(end_time - start_time)) + " [sec]");
    }
    public static int func(int n) {
        if(n < 2){
            return n;
        }
        else{
            return func(n-2) + func(n-1);
        }
    }
}
