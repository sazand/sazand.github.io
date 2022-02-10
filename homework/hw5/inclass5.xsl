<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <xsl:variable name="apostrophe">'</xsl:variable>
    
    <!-- Matches data set's root element, turn into an HTML page that lists all cats. -->
    <xsl:template match="cat-data">
        <html>
            <head>
                <title>Neko Cats Remix</title>
                <link href="https://nhomenda.github.io/css/main.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <h1>Neko Cats Remix</h1>
                <ul>
                    <xsl:apply-templates select="cat-record">
                    <xsl:sort select="name" order="ascending"/>
                </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="cat-record">
        <li>
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="concat('cats/', name, '.html')"/>
                </xsl:attribute>
                <xsl:value-of select="name"/>
            </xsl:element>
        </li>
        <xsl:result-document href="{concat('cats/', name, '.html')}">
            <html>
                <head>
                    <title><xsl:value-of select="concat(name, $apostrophe, 's Page')"/></title>
                    <link href="https://nhomenda.github.io/css/main.css" rel="stylesheet" type="text/css"/>
                </head>
                <body>
                    <xsl:apply-templates select="name"/>
                    <xsl:apply-templates select="cat-image"/>
                    <xsl:apply-templates select="description"/>  
                    <xsl:apply-templates select="personality"/> 
                    <xsl:apply-templates select="power-level"/>
                    <xsl:apply-templates select="memento"/>
                    <xsl:apply-templates select="memento-image"/><a href="../neko_html.html">Back to list</a>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="name"><xsl:element name="h1"><xsl:apply-templates/></xsl:element>
    </xsl:template>
            
    <xsl:template match="cat-image">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:apply-templates/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="description">
    <xsl:element name="p"><xsl:text>I'm a </xsl:text><xsl:apply-templates/><xsl:text> cat.</xsl:text></xsl:element>
    </xsl:template>
    
    <xsl:template match="personality">
        <xsl:element name="p"><xsl:text>People say I have a </xsl:text><xsl:apply-templates/><xsl:text> personality.</xsl:text></xsl:element>
    </xsl:template>
    
    <xsl:template match="power-level">
        <xsl:element name="p"><xsl:text>Wow my power level is </xsl:text><xsl:apply-templates/><xsl:text>.</xsl:text></xsl:element>
    </xsl:template>
    
    <xsl:template match="memento">
        <xsl:element name="p"><xsl:text>If I like you, I'll bring you a </xsl:text><xsl:apply-templates/><xsl:text>.</xsl:text></xsl:element>
    </xsl:template>
    
    <xsl:template match="memento-image">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:apply-templates/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>