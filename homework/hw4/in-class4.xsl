<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    <xsl:template match="table">
        <cat-data>
        <xsl:apply-templates/>
        </cat-data>
        </xsl:template>
    
    <xsl:template match="tbody">
            <xsl:apply-templates select="tr">
                <xsl:sort select="number(td[3])" order="descending"/>
            </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="thead"/> 
    
    <xsl:template match="tr">
        <cat-record>
            <xsl:apply-templates/>
        </cat-record>
    </xsl:template>
    
        <xsl:template match="th/img">
            <cat-image>
                <xsl:value-of select="@data-src"/>
            </cat-image>
        </xsl:template>
    
    <xsl:template match="th/sup/a">
        <name>
            <xsl:apply-templates/>
        </name>
        <wiki>
            <xsl:value-of select="concat('http://nekoatsume.fandom.com',@href)"/>
        </wiki>
        <name-in-wiki>
            <xsl:value-of select="substring-after (@href, '/wiki/')"/>
        </name-in-wiki> 
    </xsl:template>    
    
    <xsl:template match="td[1]">
        <description>
            <xsl:apply-templates/>
        </description>
    </xsl:template>
    
    <xsl:template match="td[2]">
        <personality>
            <xsl:apply-templates/>
        </personality>
    </xsl:template>
    
    <xsl:template match="td[3]">
        <power-level>
            <xsl:apply-templates/>
        </power-level>
    </xsl:template>
    
    <xsl:template match="td[4]">
        <memento>
            <xsl:apply-templates/>
        </memento>
        <memento-image>
            <xsl:value-of select="img/@data-src"/>
        </memento-image>
    </xsl:template>
       
</xsl:stylesheet>