
public class LocalhostTest {

	public static void main(String[] args) {
		
		try (java.util.Scanner s = new java.util.Scanner(new java.net.URL("https://api.ipify.org").openStream(), "UTF-8").useDelimiter("\\A")) {
			
			String ip = s.next();
			String ip2 [] = null;
			System.out.println(ip);
			
			System.out.println("ip : " + ip.split("[.]")[0].concat("." + ip.split("[.]")[1]));
		
//			for(String ip : s.next().split("\\.")) {
//				System.out.println(ip);
//			}
		    //System.out.println("My current IP address is " + s.next());

		} catch (java.io.IOException e) {
		    e.printStackTrace();
		}
	}
}
