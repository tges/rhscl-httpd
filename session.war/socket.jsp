<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="javax.naming.*,javax.sql.*,java.sql.*,java.io.*,java.net.*"
%>
<html>
  <head><title>Session Tracking Test</title>
</head>
    <body>
    <h1>Session Tracking Test</h1>
    Session tracking with JSP is easy
    <P>
<%

    Socket s = new Socket();
    String host = "www.google.com";
    PrintWriter s_out = null;
    BufferedReader s_in = null;
         
        try
        {
        s.connect(new InetSocketAddress(host , 80));
        System.out.println("Connected");
             
        //writer for socket
            s_out = new PrintWriter( s.getOutputStream(), true);
            //reader for socket
            s_in = new BufferedReader(new InputStreamReader(s.getInputStream()));
        }
         
        //Host not found
        catch (UnknownHostException e) 
        {
            System.err.println("Don't know about host : " + host);
            System.exit(1);
        }
         
        //Send message to server
    String message = "GET / HTTP/1.1\r\n\r\n";
    s_out.println( message );
             
    System.out.println("Message send");
         
    //Get response from server
    String responseStr;
    while ((responseStr = s_in.readLine()) != null) 
    {
        System.out.println( responseStr );
        out.println( responseStr );
    }
    s_out.close();
    s_in.close();
    s.close();
%>

</body></html>

