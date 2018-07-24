public class MatrixcalTask extends Thread{
    static int matrixSize=0;
    public static void main(String args[]) throws Exception {
        //get the start time
        final int noThreads = Integer.parseInt(args[1]);
        double start_Time = System.nanoTime();
        matrixSize =  Integer.parseInt(args[0]);
        MatrixcalTask[] threads = new MatrixcalTask[noThreads];
        for (int me = 0; me < noThreads; me++) {
            threads[me] = new MatrixcalTask(me);
            threads[me].start();
            threads[me].join();
        }
        double end_time = System.nanoTime();

        System.out.printf("time = %.10f [sex]\n",(Math.pow(10,-9)*(end_time - start_Time)));
    }

    int me;

    public MatrixcalTask(int me) {
        this.me = me;
    }

    public void run(){

        //generate two matrices using random numbers
        int mat_a[][] = new int[matrixSize][matrixSize];
        int mat_b[][] = new int[matrixSize][matrixSize];
        CleateMatrix(mat_a);
        CleateMatrix(mat_b);

        //get the number of rows from the first matrix
        int m1rows = mat_a.length;
        //get the number of columns from the first matrix
        int m1cols = mat_a[0].length;
        //get the number of columns from the second matrix
        int m2cols = mat_b[0].length;

        //multiply the matrices and put the result in an array
        int[][] ans = new int[mat_a.length][mat_b[0].length];
        for (int i = 0; i < m1rows; i++) {
            for (int j = 0; j < m2cols; j++) {
                for (int k = 0; k < m1cols; k++) {
                    ans[i][j] += mat_a[i][k] * mat_b[k][j];
                }
            }
        }

    }

    public static void  CleateMatrix(int[][] m) {
        for (int i = 0; i < m.length; i++) { 
            for (int j = 0; j < m[i].length; j++) {
                m[i][j] = 50;
            }
        }
    }
}
