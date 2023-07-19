<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

<html>
<head>
<style type="text/css">
	Table{font-family: Verdana; font-size: 10pt;}
</style>
</head>

<body>
<table align="center" border="0" cellpadding="4" cellspacing="0" style="border:0px solid" width="100%">
       <tr>
          <tr><td><h2><font face="Verdana"><a>Automation Report</a></font></h2></td></tr>   
	  <td align="left"><img border="0" src="XmlReference/Odyssey.jpg" /></td>   
       </tr>
	   <tr>
	    <td style = "font-weight:bold" >Clinical Content Version : <xsl:value-of select="Root/ClinicalContentVersion"/></td>
	   </tr>
	   <tr>
	    <td style = "font-weight:bold" >Application Version : <xsl:value-of select="Root/ApplicationVersion"/></td>
	   </tr>
</table>

<tr>
<td><hr /></td>
</tr>

<table border="0" width="100%" style="color:003399">
<tr>
<td><h3><font face="Verdana">
  <a name = "StartOfPage">High Level Report Summary:</a>
</font></h3></td>
</tr>	
</table>


<xsl:variable name="x" select="count(Root/TestCase[normalize-space(Result)='PASS'])"/>
<xsl:variable name="y" select="count(Root/TestCase[normalize-space(Result)='FAIL'])"/>


<xsl:variable name="passwidth" select="$x div ($x+$y) * 100" />
<xsl:variable name="failwidth" select="$y div ($x+$y) * 100" />
<!-- Draw the horizontal bar -->

<table border="0" width="100%" cellpadding="4" cellspacing="1" style="border:1px solid;">
   <tr bgcolor="003399">
      <th style="color:white">S.No</th>
      <th style="color:white">ModuleName</th>
      <th style="color:white">StartTime(H:M:S)</th>
	  <th style="color:white">EndTime(H:M:S)</th>
	  <th style="color:white">ExecutionTime(H:M:S)</th>
    </tr>

   <xsl:for-each select="Root/ModuleName">   
    <tr>
      <td width="4%" align="center"><xsl:value-of select="position()"/></td>
		<td width="8%" align="center">
       		<a target="">
	  	  <xsl:attribute name="href">
		    <xsl:value-of select="ModuleLog"/>
		  </xsl:attribute>
		  <xsl:value-of select="ModuleLog/@Name"/>
		</a>
	    </td>
	  
      <td width="5%" align="center"><xsl:value-of select="StartTime" /></td>
	  <td width="5%" align="center"><xsl:value-of select="EndTime" /></td>
	  <td width="5%" align="center"><xsl:value-of select="TotalTimeTaken" /></td>
    </tr>
   
   </xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>