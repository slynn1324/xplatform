import com.sun.jna.*;


class FunctionsJNA{

	public interface CFunctions extends Library {
		public int add(int a, int b);
		public String getMessage();
	}

	public static void main(String[] args){
		CFunctions f = (CFunctions) Native.loadLibrary("functions", CFunctions.class);
		System.out.println("add(2,3) => " + f.add(2,3));
		System.out.println("add(3,5) => " + f.add(3,5));
		System.out.println("getMessage() => " + f.getMessage());
	}
}