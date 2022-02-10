<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    <xsl:template match="//div[@class='interior-content']/ul">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="myCss.css" />
            </head> 
            <body>
        <table border="1">
            <tr class="trstyle">
                <th class="thstyle">Name</th>
                <th class="thstyle">URL</th>
                <th class="thstyle">Institution</th>
            </tr>
            <xsl:apply-templates/>
        </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="//div[@class='interior-content']/ul/li">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="//div[@class='interior-content']/ul/li/p/a">
        <td>
            <xsl:value-of select="text()"/>
        </td> 
        <td>
            <xsl:value-of select="@href"/>
        </td> 
    </xsl:template>
    <xsl:template match="//div[@class='interior-content']/ul/li/p/span">
        <td>
            <xsl:value-of select="substring-after(text(), ' - ')"/>
        </td> 
    </xsl:template>
   
    <xsl:template match="//div[@class='interior-content']/ul/li/p[2]"/>
    <xsl:template match="head"/>
    <xsl:template match="script"/>
    <xsl:template match="//header[@id='site-header']"/>
    <xsl:template match="//div[@class='breadcrumbs']"/>
    
    <xsl:template match="//div[@class='page-heading']"/>
    <xsl:template match="//div[@class='interior-rail']"/>
    <xsl:template match="//div[@class='block']"/>
    <xsl:template match="//div[@id='tb_external']"/>
    

 
</xsl:stylesheet>