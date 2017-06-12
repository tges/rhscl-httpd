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
//	if(request.getParameter("jndiName") != null) {
	     //  	PrintWriter writer = response.getWriter();
		out.write("<h1>Results of Test</h1>");
		//String jndiName = request.getParameter("jndiName");
		String jndiName = "java:jboss/datasources/db2DS"; 
                String tableName = "PRODUCT";
		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup(jndiName);
			out.write("<p>Successfully looked up DataSource named " + jndiName + "</p>");

				Connection conn = null;
			    	Statement stmt = null;
			    	PreparedStatement pstmt = null;

//for(int count=0; count < 5000; count++) {
				conn = ds.getConnection();
				out.write("<p>Successfully connected to database.</p>");
				out.write("<p>URL=" + conn.getMetaData().getURL() + "</p>");
				String query = "SELECT * FROM " + tableName + " where PID like ?";
				//String query = "SELECT * FROM " + tableName + " where PID=?";
				//String query = "SELECT * FROM " + tableName + " where PID=? and ID=? and ID2=? ";
				pstmt = conn.prepareStatement(query);
	//			pstmt.setInt(2, 11);
	//			pstmt.setDouble(3, 11.1);
	//			pstmt.setBlob(3, new java.io.ByteArrayInputStream("test".getBytes()));
				//pstmt.setString(1, "100-100-01");
				pstmt.setString(1, "%1%");
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
//Thread.sleep(1000);
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
//				pstmt.close();
// db connection leak test
				conn.close();
//} // end for
	    	}catch(Exception e) {
			out.write("An exception was thrown: " + e.getMessage() + "<br>");
	    		e.printStackTrace();
	    	}
//	} else {

	%>
<!--	
	<h1>Test an EAP Datasource</h1>
	<form method="post">
		<table>
			<tr>
				<td>JNDI Name of Datasource:</td>
				<td><input type="text" width="60" name="jndiName"/></td>
			</tr>
			<tr>
				<td>Table Name to Query (optional):</td>
				<td><input type="text" width="60" name="tableName"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Submit" name="submit"/></td>
			</tr>
		</table>
	</form>
-->
	<% // } %>
</body>
</html>
