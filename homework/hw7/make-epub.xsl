<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="filepath" select="'/Users/nhomenda/Desktop/'"/>
    
    <xsl:output indent="yes"/>
    
    <xsl:strip-space elements="*"/>
    <!-- This is a really big template matching the root element. It uses 6 modes:
            1.metedata
            2.spine
            3.xhtml
            4.ncx-metadata
            5.navMap
            6.manifest                                                                  
    
    It also creates elements in 3 namespaces:
            1.ncx
            2.opf
            3.dc                                                      -->
    <xsl:template match="TEI.2">
        <xsl:result-document href="{concat($filepath, 'IMH-epub/OEBPS/content.opf')}">
            <package xmlns="http://www.idpf.org/2007/opf"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                unique-identifier="url" version="2.0">
                <metadata>
                    <xsl:apply-templates select="teiHeader//monogr" mode="metadata"/>
                    <dc:identifier id="url">https://scholarworks.iu.edu/journals/index.php/imh/issue/view/684</dc:identifier>
                    <dc:language>en-US</dc:language>
                </metadata>
                <manifest>
                    <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
                    <xsl:apply-templates mode="manifest"/>
                    <item id="cover-image" href="images/cover.png" media-type="image/png"/>
                    <item id="css" href="stylesheet.css" media-type="text/css"/>
                </manifest>
                <spine toc="ncx">
                    <xsl:apply-templates mode="spine"/>
                </spine>
                <guide>
                    <reference href="title.html" type="cover" title="Cover"/>
                </guide>
            </package>
        </xsl:result-document>
        <xsl:result-document href="{concat($filepath, 'IMH-epub/OEBPS/toc.ncx')}">
            <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
                <head xmlns="http://www.daisy.org/z3986/2005/ncx/">
                    <meta name="dtb:uid" content="https://scholarworks.iu.edu/journals/index.php/imh/issue/view/684" xmlns="http://www.daisy.org/z3986/2005/ncx/"/>
                    <meta name="cover-image" content="cover-image" xmlns="http://www.daisy.org/z3986/2005/ncx/"/>
                    <meta name="dtb:depth" content="1" xmlns="http://www.daisy.org/z3986/2005/ncx/"/>
                    <meta name="dtb:totalPageCount" content="0" xmlns="http://www.daisy.org/z3986/2005/ncx/"/>
                    <meta name="dtb:maxPageNumber" content="0" xmlns="http://www.daisy.org/z3986/2005/ncx/"/>
                </head>
                <docTitle xmlns="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:apply-templates select="teiHeader//monogr/title" mode="ncx-metadata"/>
                </docTitle>
                <navMap xmlns="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:apply-templates mode="navMap"/>
                </navMap>
            </ncx>
        </xsl:result-document>
        <xsl:apply-templates mode="xhtml"/>
    </xsl:template>
    <!-- The following 6 templates are affecting the resulting opf file. -->
    <!-- This type of template is common in XSLT because it keeps content while removing containaer. -->
    <xsl:template match="teiHeader|fileDesc|sourceDesc|biblStruct|monogr" mode="metadata">
        <xsl:apply-templates mode="metadata"/>
    </xsl:template>
    
    <xsl:template match="monogr/title" mode="metadata">
        <dc:title id="title"><xsl:apply-templates mode="metadata"/></dc:title>
    </xsl:template>
    
    <xsl:template match="imprint/date" mode="metadata">
        <dc:date><xsl:apply-templates mode="metadata"/></dc:date>
    </xsl:template>
    
    <xsl:template match="imprint/publisher" mode="metadata">
        <dc:publisher><xsl:apply-templates mode="metadata"/></dc:publisher>
    </xsl:template>
    <!-- This type of template is also common in XSLT and is an easy way to leave stuff behind. -->
    <xsl:template match="titleStmt|publicationStmt|seriesStmt|biblScope|pubPlace" mode="metadata"/>
    <!-- this template is affecting 5 modes -->
    <xsl:template match="teiHeader" mode="manifest spine navMap xhtml"/>
    <!-- manifest mode -->
    <xsl:template match="text/body/div[@id]" mode="manifest">
        <xsl:variable name="position" select="concat('0', count(preceding-sibling::div[@id])+1)"/><!-- Why am I not just using position() here? -->
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id"><xsl:value-of select="concat('article_', $position)"/></xsl:attribute>
            <xsl:attribute name="href"><xsl:value-of select="concat('article_', $position, '.xhtml')"/></xsl:attribute>
            <xsl:attribute name="media-type">application/xhtml+xml</xsl:attribute>
        </xsl:element>
    </xsl:template>
    <!-- spine mode -->
    <xsl:template match="text/body/div[@id]" mode="spine">
        <xsl:variable name="position" select="concat('0', count(preceding-sibling::div[@id])+1)"/>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="linear">yes</xsl:attribute>
            <xsl:attribute name="idref"><xsl:value-of select="concat('article_', $position)"/></xsl:attribute>
        </xsl:element>
    </xsl:template>
    <!-- ncx-metadata mode-->
    <xsl:template match="teiHeader//monogr/title" mode="ncx-metadata">
        <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/"><xsl:apply-templates mode="ncx-metadata"/></xsl:element>
    </xsl:template>
    
    <xsl:template match="text/body/div[@id]" mode="navMap">
        <xsl:variable name="position" select="concat('0', count(preceding-sibling::div[@id])+1)"/>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="class">article</xsl:attribute>
            <xsl:attribute name="id"><xsl:value-of select="concat('article_', $position)"/></xsl:attribute>
            <xsl:attribute name="playOrder"><xsl:value-of select="number($position)"/></xsl:attribute>
            <xsl:element name="navLabel" xmlns="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/"><xsl:value-of select="head" separator=";"/></xsl:element>
            </xsl:element>
            <xsl:element name="content" xmlns="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src"><xsl:value-of select="concat('article_', $position, '.xhtml')"/></xsl:attribute>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <!-- Lots of templates creating html from the source document. -->
    <xsl:template match="text/body/div[@id]" mode="xhtml">
        <xsl:variable name="position" select="concat('0', count(preceding-sibling::div[@id])+1)"/>
        <xsl:result-document href="{concat($filepath, 'IMH-epub/OEBPS/article_', $position, '.xhtml')}">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title><xsl:value-of select="head" separator=";"/></title>
                    <link rel="stylesheet" type="text/css" href="stylesheet.css"/>
                </head>
                <body>
                    <h1><xsl:value-of select="head" separator=";"/></h1>
                    <xsl:apply-templates mode="xhtml" select="* except head"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <!-- Among the below templates I add a couple classes: right and footnote, so I need to remember to treat them in the CSS.-->
    <xsl:template match="p" mode="xhtml">
        <p xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></p>
    </xsl:template>
    
    <xsl:template match="hi[@rend='b']" mode="xhtml">
        <b xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></b>
    </xsl:template>
    
    <xsl:template match="hi[@rend='i']" mode="xhtml">
        <i xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></i>
    </xsl:template>
    
    <xsl:template match="note[@place='marg']" mode="xhtml">
        <span class="right" xmlns="http://www.w3.org/1999/xhtml" ><xsl:apply-templates mode="xhtml"/></span>
    </xsl:template>
    
    <xsl:template match="pb|back" mode="xhtml"/>
    
    <xsl:template match="list[@type='ordered']" mode="xhtml">
        <ol xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></ol>
    </xsl:template>
    
    <xsl:template match="list/item" mode="xhtml">
        <li xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></li>
    </xsl:template>
    
    <xsl:template match="list[@type='footnotes']" mode="xhtml">
        <ul class="footnotes" xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></ul>
    </xsl:template>
    
    <xsl:template match="list[@type='bibliography']" mode="xhtml">
        <ul xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></ul>
    </xsl:template>
    
    <xsl:template match="text|body" mode="xhtml">
        <xsl:apply-templates mode="xhtml"/>
    </xsl:template>
    
    <xsl:template match="div[@type='diary']" mode="xhtml">
        <blockquote xmlns="http://www.w3.org/1999/xhtml"><xsl:apply-templates mode="xhtml"/></blockquote>
    </xsl:template>
    
    <!-- Include some more templates if I really want to get fancy. Ideas:
        1.
        2.
        3.
        4.
        5.                                                          -->
    
</xsl:stylesheet>