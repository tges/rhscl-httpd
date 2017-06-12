<%@ page contentType="text/html;charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
  <head><title>Session Tracking Test</title>
</head>
    <body>
    <h1>Session Tracking Test</h1>
    Session tracking with JSP is easy
    <P>
<%@ page session="true" %>
<%
        byte korean[] = new byte[4]; // { 193, 209, 177, 219 };
        korean[0] = (byte)199;
        korean[1] = (byte)209;
        korean[2] = (byte)177;
        korean[3] = (byte)219;

    String eucString = new String(korean, "EUC-KR");
    System.out.println(eucString);
    out.println(eucString);

      // Get the session data value
    Integer ival = (Integer) session.getValue ("counter");
if (ival == null) ival = new Integer (1);
else ival = new Integer (ival.intValue() + 1);
session.putValue ("counter", ival);
%>
    You have hit this page <%= ival %> times.<br>
<%
    out.println("Your Session ID is " + session.getId() +  "<br>");
    System.out.println("session=" + session.getId());
%>		

<%
/*
        long random = new Double(Math.random() * 15 * 1000).longValue();
        try {
            Thread.sleep(random);
        } catch ( Exception e ) {
            e.printStackTrace();
        }
for( int i = 0; i < 10000; i++) {

} 
	throw new Exception("Exception");
*/
int i = 0;
if( i == 0 ) {
	throw new Exception("Exception" + eucString);
}
%>

</body></html>

