/*行列の掛け算をするコード*/
public class MatrixcalSuccessively {
    static int matrixSize=0;
    public static void CleateMatrix(int[][] m){
        for(int i = 0 ; i < m.length ; i++){
            for(int j = 0 ; j < m[i].length ; j++){
                m[i][j] = 50;
            }
        }
    }
    
//行列の積を演算するメソッド
    public static void multiplication(int[][] x,  int[][] y,  int[][] z){
        for(int i = 0 ; i < z.length ; i++) {
            if ((x.length == 0 || y[0].length == 0) || (x[0].length != y.length)) {
                System.out.println("wrong matrix type");
                break;
            }
            for (int j = 0; j < z[i].length; j++) {
                z[i][j] = 0;
                for (int k = 0; k < y.length; k++) {
                    z[i][j] += x[i][k] * y[k][j];
                }
            }
        }
        //System.out.printf("%5d", z[0][0]);
        //System.out.println("");
    }
    
    public static void main(String[] args){
        matrixSize =  Integer.parseInt(args[0]);
        long start_time = System.nanoTime();
        int[][] mat_a = new int[matrixSize][matrixSize];
        int[][] mat_b = new int[matrixSize][matrixSize];
        int[][] ans = new int[mat_a.length][mat_b[0].length];
        CleateMatrix(mat_a);
        CleateMatrix(mat_b);
        multiplication(mat_a, mat_b, ans);
        long end_time = System.nanoTime();
        System.out.printf("time = %.10f [sec]\n",(Math.pow(10,-9)*(end_time - start_time)));
    }
}
