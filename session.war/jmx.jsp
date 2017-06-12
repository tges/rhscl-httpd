<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="javax.management.*"%>
<%@page import="java.lang.management.*"%>
<html>
  <head><title>Session Tracking Test</title>
</head>
    <body>
    <h1>Session Tracking Test</h1>
    Session tracking with JSP is easy
    <P>
<%

        MBeanServer mbeanServer = ManagementFactory.getPlatformMBeanServer();

//        jboss.as:deployment=jolokia-war-1.2.0.war,subsystem=web
        ObjectName webSession = ObjectName.getInstance("jboss.as:deployment=*,subsystem=web");
        Set webSessions = mbeanServer.queryMBeans(webSession, null);


        if (webSessions == null || webSessions.size() == 0) {
//            LOG.debug("there is no webSessions");
        }

        for (Iterator i = webSessions.iterator(); i.hasNext(); ) {
            ObjectName mbeanName = ((ObjectInstance) i.next()).getObjectName();
            System.out.println(mbeanName.getKeyProperty("deployment"));

            Integer activeSessions = (Integer) mbeanServer.getAttribute(mbeanName, "activeSessions");
            if (activeSessions == null)
                activeSessions = 0;
            System.out.println("activeSessions=" + activeSessions);

        }


%>

</body></html>

