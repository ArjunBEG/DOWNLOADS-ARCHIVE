import java.util.Scanner;

public class AntiPalindrome {
	static int n;
	static int len;
	static String s;
	public static boolean ifpalindrome(char[] str) {
		for ( int  i=0,j=n-1;i<=j;i++,j--){  
		    if (str[i]!= str[j]) return true ;   
		}
		  return false ;  
	}
	public static void main(String []args) {
		Scanner scan = new Scanner(System.in);
		s= scan.nextLine();
		char[] str = s.toCharArray();
		scan.close();
		len = s.length();  
		n = len;
		while (true){  
		    if (ifpalindrome(str)){  
		      break ;  
		    }  
		    if (n == 0) break ;  
		    n--;  
		  }  
		System.out.println(n);
	}
}