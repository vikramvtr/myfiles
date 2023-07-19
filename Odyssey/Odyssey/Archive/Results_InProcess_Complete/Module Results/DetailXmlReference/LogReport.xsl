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
						<tr>
							<td>
								<h2>
									<font face="Verdana">
										<a>Automation Report</a>
									</font>
								</h2>
							</td>
						</tr>   
						<td align="left">
							<img border="0" src="DetailXmlReference/Odyssey.jpg" />
						</td>   
					</tr>
				</table>

				<tr>
					<td>
						<hr />
					</td>
				</tr>

				<table border="0" width="100%" style="color:003399">
					<tr>
						<td>
							<h3>
								<font face="Verdana">
									<a name = "StartOfPage">High Level Report Summary:</a>
								</font>
							</h3>
						</td>
					</tr>	
				</table>


				<xsl:variable name="x" select="count(Root/TestCase[normalize-space(Result)='PASS'])"/>
				<xsl:variable name="y" select="count(Root/TestCase[normalize-space(Result)='FAIL'])"/>


				<xsl:variable name="passwidth" select="$x div ($x+$y) * 100" />
				<xsl:variable name="failwidth" select="$y div ($x+$y) * 100" />
				<!-- Draw the horizontal bar -->


				<table width="45%">
					<tr>
						<td>

							<table border="0" cellpadding="2" cellspacing="2" width="100%" style="border:1px solid">
								<tr>
									<td style="color:003399" width = "50%">Module </td>
									<td>:</td>
									<td  style="color:003399;font-weight:bold;">
										<xsl:value-of select="Root/Module"/>
									</td>
								</tr>
								<tr>
									<td style="color:003399" width = "50%">Execution Started on </td>
									<td>:</td>
									<td  style="color:003399;font-weight:bold;">
										<xsl:value-of select="Root/StartTime"/>
									</td>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td style="color:003399" width = "50%">Total no. of TestCases executed </td>
									<td>:</td>
									<td  style="color:003399;font-weight:bold;">
										<xsl:value-of select="count(Root/TestCase/Result)"/>
									</td>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td style="color:003399">Total no. of TestCases Passed</td>
									<td>:</td>
									<td style="color:green; font-weight:bold;">
										<xsl:value-of select="count(Root/TestCase[normalize-space(Result)='PASS'])"/>
									</td>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td style="color:003399">Total no. of TestCases Failed</td>
									<td>:</td>
									<td style="color:red; font-weight:bold;">
										<xsl:value-of select="count(Root/TestCase[normalize-space(Result)='FAIL'])"/>
									</td>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td style="color:003399">Total % of TestCases Passed</td>
									<td>:</td>
									<td align="left">
										<div style="background-color:green;width:{$passwidth}%;text-align:center">
											<font color="white">
												<b>
													<xsl:value-of select="format-number($passwidth,'0.0')" />%</b>
											</font>
										</div>
									</td> 
								</tr>    
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>	

								<tr>
									<td style="color:003399">Total % of TestCases Failed</td>
									<td>:</td>
									<td align="left">
										<div style="background-color:red;width:{$failwidth}%;text-align:center">
											<font color="white">
												<b>
													<xsl:value-of select="format-number($failwidth,'0.0')" />%</b>
											</font>
										</div>
									</td>
								</tr>     
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>
								<tr>
									<td style="color:003399" width = "50%">Execution Ended on </td>
									<td>:</td>
									<td  style="color:003399;font-weight:bold;">
										<xsl:value-of select="Root/TestCase/EndExecutionTime"/>
									</td>
								</tr>
								<tr>
									<td style="color:003399" width = "50%">Time Taken </td>
									<td>:</td>
									<td  style="color:003399;font-weight:bold;">
										<xsl:value-of select="Root/TestCase/TotalTimeTaken"/>
									</td>
								</tr>
								<tr>
									<td/>
									<td/>
									<td/>
								</tr>

							</table>

						</td>

					</tr>
				</table>

				<br/>
				<br/>

				<table rules="rows" border="0" width="100%" cellpadding="4" cellspacing="1" style="border:1px solid;">
					<tr bgcolor="003399">
						<th style="border:1px solid color:black;color:white">S.No</th>
						<th style="border:1px solid color:black;color:white">TestCase Name</th>
						<th style="border:1px solid color:black;color:white">Description</th>
						<th style="border:1px solid color:black;color:white">Result</th>
						<th style="border:1px solid color:black;color:white">StartTime(H:M:S)</th>
						<th style="border:1px solid color:black;color:white">EndTime(H:M:S)</th>
					</tr>

					<xsl:for-each select="Root/TestCase">   
						<tr>
							<td style="border:1px solid;" width="4%" align="center">
								<xsl:value-of select="position()"/>
							</td>      
							<td style="border:1px solid;" width="7%" align="left">
								<a href = "#{TestCaseName}">
									<xsl:value-of select="TestCaseName"/>
								</a>
							</td>

							<xsl:choose>
								<xsl:when test="Result ='FAIL'">
									<td width="30%" align="left" style="border:1px solid color:black;color:red;">
										<xsl:value-of select="TestCaseDescription"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td style="border:1px solid;" width="30%" align="left">
										<xsl:value-of select="TestCaseDescription"/>
									</td> 
								</xsl:otherwise>        
							</xsl:choose>    



							<xsl:choose>
								<xsl:when test="Result ='PASS'">
									<td width="8%" align="center" style="border:1px solid color:black;color:green;">
										<xsl:value-of select="Result"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td width="7%" align="center" style="border:1px solid color:black;color:red;">
										<xsl:value-of select="Result"/>
									</td> 
								</xsl:otherwise>        
							</xsl:choose>     

							<td style="border:1px solid;" width="5%" align="center">
								<xsl:value-of select="@StartTime" />
							</td>
							<td style="border:1px solid;" width="5%" align="center">
								<xsl:value-of select="EndTime" />
							</td>
						</tr>

					</xsl:for-each>
				</table>
				<hr/>
				<br/>

				<tr>
					<td>
						<h3>
							<font face="Verdana"  style="color:003399">Test Case Details:</font>
						</h3>
					</td>
				</tr>

				<xsl:for-each select="Root/TestCase"> 
					<table width="40%">
						<tr>
							<td>

								<table border="0" cellpadding="2" cellspacing="2" width="100%" style="border:1px solid">

									<tr>
										<td style="font-weight:bold;" width = "30%">TestCase Name</td>
										<td>:</td>
										<td>
											<a name ="{@ModuleName}">
												<xsl:value-of select="@ModuleName"/>
											</a>

										</td>
									</tr>
									<tr>
										<td style="font-weight:bold;" width = "20%">Start Time(H:M:S)</td>
										<td>:</td>
										<td>
											<xsl:value-of select="@StartTime"/>
										</td>
									</tr>
									<tr>
										<td style="font-weight:bold;" width = "20%">End Time(H:M:S)</td>
										<td>:</td>
										<td>
											<xsl:value-of select="EndTime"/>
										</td>
									</tr>

									<xsl:choose>
										<xsl:when test="Result ='PASS'">
											<tr>
												<td style="font-weight:bold;" width = "30%">Result</td>
												<td>:</td>
												<td style="color:green;">
													<xsl:value-of select="Result"/>
												</td>
											</tr>
										</xsl:when>
										<xsl:otherwise>
											<tr>
												<td style="font-weight:bold;" width = "30%">Result</td>
												<td>:</td>
												<td style="color:red;">
													<xsl:value-of select="Result"/>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>

								</table>
							</td>
						</tr>
					</table>
					<tr>
						<td>
							<h4>
								<font face="Verdana"  style="color:003399">Low Level Details:</font>
							</h4>
						</td>
					</tr>
					<table rules="rows" border="0" width="70%" cellpadding="4" cellspacing="1" style="border:1px solid" >
						<tr bgcolor="003399">
							<th style="border:1px solid color:black;color:white">TestStep ID</th>
							<th style="border:1px solid color:black;color:white">Description</th>
							<th style="border:1px solid color:black;color:white">ScreenShot</th>
							<th style="border:1px solid color:black;color:white">Result</th>
							<th style="border:1px solid color:black;color:white">Step Executed Time</th>
						</tr>

						<xsl:for-each select="Step/LowLevelInfo">
							<tr> 
								<td style="border:1px solid;" width="10%" align="center">
									<xsl:value-of select="StepID"/>
								</td>
								<xsl:choose>
									<xsl:when test="Result ='FAIL'">
										<td width="50%" align="left" style="border:1px solid color:black;color:red;">
											<xsl:value-of select="Description"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td style="border:1px solid;" width="50%" align="left">
											<xsl:value-of select="Description"/>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="ScreenShot ='N/A'">
										<td style="border:1px solid;" width="8%" align="center">
											<xsl:value-of select="ScreenShot"/>
										</td>
									</xsl:when>

									<xsl:otherwise>
										<td style="border:1px solid;" width="8%" align="center">
											<a target="_blank">
												<xsl:attribute name="href">
													<xsl:value-of select="ScreenShot"/>
												</xsl:attribute>
												<xsl:value-of select="ScreenShot/@Name"/>
											</a>
										</td>
									</xsl:otherwise>        
								</xsl:choose> 
								<xsl:choose>
									<xsl:when test="Result ='PASS'">
										<td width="10%" align="center" style="border:1px solid color:black;color:green;">
											<xsl:value-of select="Result"/>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<td width="10%" align="center" style="border:1px solid color:black;color:red;">
											<xsl:value-of select="Result"/>
										</td>
									</xsl:otherwise>
								</xsl:choose>
								<td style="border:1px solid;" width="10%" align="center">
									<xsl:value-of select="StepExecutedTime"/>
								</td>

							</tr>
						</xsl:for-each>
					</table>
					<h4 align="Right">
						<a href = "#StartOfPage"> Top</a>
					</h4>
					<hr/>

				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>