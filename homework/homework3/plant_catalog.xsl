<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="formatdate">
     <xsl:param name="datestr" />

     <xsl:variable name="mm">
         <xsl:value-of select="substring($datestr,1,2)" />
     </xsl:variable>

     <xsl:variable name="dd">
        <xsl:value-of select="substring($datestr,3,2)" />
     </xsl:variable>

     <xsl:variable name="yy">
        <xsl:value-of select="substring($datestr,5,2)" />
     </xsl:variable>

     <xsl:value-of select="concat($mm,'/', $dd, '/', $yy)" />
  </xsl:template>
<xsl:template match="/">
<html>
<head>
      <link rel="stylesheet" type="text/css" href="myCss.css" />
</head> 
<body>
  <h2>Plant Collection For Sale</h2>
  <table border="1">
    <tr class="trstyle">
      <th class="thstyle">Common Name</th>
      <th class="thstyle">Botanical Name</th>
      <th class="thstyle">Zone</th>
      <th class="thstyle">Light</th>
      <th class="thstyle">Price</th>
      <th class="thstyle">Availability</th>

    </tr>
    <xsl:for-each select="CATALOG/PLANT">
    <xsl:sort select="COMMON"/>
    <tr>
      <td><xsl:value-of select="COMMON"/></td>
      <td><xsl:value-of select="BOTANICAL"/></td>
      <td><xsl:value-of select="ZONE"/></td>
      <td><xsl:value-of select="LIGHT"/></td>
      <td class="red"><xsl:value-of select="PRICE"/></td>
      <td><xsl:call-template name="formatdate">
                    <xsl:with-param name="datestr" select="AVAILABILITY"/>
                </xsl:call-template></td>
    </tr>
    </xsl:for-each>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>