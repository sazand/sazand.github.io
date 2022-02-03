<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
<xsl:template match="disneyworld">
    <html>
        <head>
            <title>
                Diesney World
            </title>
        </head>
        <body>
            <hl>Walt Disney World</hl>
            <p>This is a page about Disney</p>
            <xsl:apply-templates/>
        </body>
    </html>
</xsl:template>
    <xsl:template match="themepark">
    <div>
        <xsl:apply-templates/>
    </div>
    </xsl:template>
    <xsl:template match="name">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <xsl:template match="rides">
        <h3>Rides</h3>
        <ol><xsl:apply-templates/></ol>
    </xsl:template>
    
    <xsl:template match="hotels">
        
    <h3>Hotels</h3>
    <ol><xsl:apply-templates/></ol>
    </xsl:template>
    
    <xsl:template match="ride|hotel">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
</xsl:stylesheet>
