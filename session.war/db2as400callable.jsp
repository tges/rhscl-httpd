<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="javax.naming.*,javax.sql.*,java.sql.*,java.io.*"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datasource Test</title>
</head>
<body>
	<%
	     //  	PrintWriter writer = response.getWriter();
		out.write("<h1>Results of Test</h1>");

                Class.forName("com.ibm.as400.access.AS400JDBCDriver");

                Connection conn = null;
	    	CallableStatement pstmt = null;
                Statement stmt = null;

		try {

                    conn = DriverManager.getConnection("jdbc:as400://125.7.246.41/omhlib", "webuser", "passw0rd");
				out.write("<p>Successfully connected to database.</p>");
				String query = "call omhlib.testprc3 (?) ";
				pstmt = conn.prepareCall(query);
				pstmt.setString(1, "WEBUSER");
				//pstmt.setInt(1, 2);
				out.write("<p>Attempting query \"" + query + "\"</p>");
				ResultSet results = pstmt.executeQuery();
				ResultSetMetaData rsMetaData = results.getMetaData();
			    	int numberOfColumns = rsMetaData.getColumnCount();

				out.write("<table><tr>");
				//Display the header row of column names
			    	for (int i = 1; i <= numberOfColumns; i++) {
					int columnType = rsMetaData.getColumnType(i);
				      	String columnName = rsMetaData.getColumnName(i);
					if(columnType == Types.VARCHAR) {
						out.write("<td>" + columnName + "</td>");
					}
			    	}
				out.write("</tr>");
				//Print the values (VARCHAR's only) of each result
				while(results.next()) {
					out.write("<tr>");
				    	for (int i = 1; i <= numberOfColumns; i++) {
						int columnType = rsMetaData.getColumnType(i);
					      	String columnName = rsMetaData.getColumnName(i);
						if(columnType == Types.VARCHAR) {
							out.write("<td>" + results.getString(columnName) + "</td>");
						}
				    	}
					out.write("</tr>");
				}
				out.write("</table>");
	    	} catch(Exception e) {
			out.write("An exception was thrown: " + e.getMessage() + "<br>");
	    		e.printStackTrace();
	    	} finally {
		    if(stmt != null) stmt.close();
		    if(pstmt != null) pstmt.close();
		    if(conn != null) conn.close();
                }
%>
</body>
</html>
