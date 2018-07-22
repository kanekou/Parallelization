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
        }

        for (int me = 0; me < noThreads; me++) {
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
        int matrix1[][] = matrixGenerator();
        int matrix2[][] = matrixGenerator();

        //get the number of rows from the first matrix
        int m1rows = matrix1.length;
        //get the number of columns from the first matrix
        int m1cols = matrix1[0].length;
        //get the number of columns from the second matrix
        int m2cols = matrix2[0].length;

        //multiply the matrices and put the result in an array
        int[][] result = new int[m1rows][m2cols];
        for (int i = 0; i < m1rows; i++) {
            for (int j = 0; j < m2cols; j++) {
                for (int k = 0; k < m1cols; k++) {
                    result[i][j] += matrix1[i][k] * matrix2[k][j];
                }
            }
        }

    }

    public static int[][] matrixGenerator() {
        //create an array
        int matrix[][] = new int[matrixSize][matrixSize];
        //create a random generator
        //and fill it with random numbers
        //Random r = new Random();
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                matrix[i][j] = 50;
            }
        }
        return matrix;
    }
}
