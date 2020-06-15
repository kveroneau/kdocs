<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="kdoc//@title"/></title>
        <link rel="stylesheet" href="https://yandex.st/highlightjs/8.0/styles/default.min.css"/>
        <script src="https://yandex.st/highlightjs/8.0/highlight.min.js"></script>
        <script src="marked.min.js"></script>
        <script src="m-xml.min.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>
      </head>
      <body>
        <div style="top: 0px; width:150px; position: absolute;">
          <div class="mxml" data-xml="contents.xml" data-xslt="linklist.xsl">Loading...</div>
        </div>
        <div style="top: 0px; left: 150px; width:800px; position: absolute;">
        <h1><xsl:value-of select="kdoc//@title"/></h1>
        <xsl:for-each select="//class[@name]">
            <a href="#{@name}"><xsl:value-of select="./@name"/></a> |
        </xsl:for-each>
        <xsl:for-each select="//section[@name]">
            <a href="#{@name}"><xsl:value-of select="./@name"/></a> |
        </xsl:for-each>
        <xsl:apply-templates/>
        </div>
        <script>
        magicXML.parse(".mxml")
        var md = document.getElementsByClassName('markdown');
        for (var i=0;i&lt;md.length;i++){
          md[i].innerHTML = marked(md[i].innerHTML);
        }
        </script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="kdoc">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="example">
    <pre><code class="language-pascal">
      <xsl:value-of select="."/>
    </code></pre>
  </xsl:template>

  <xsl:template match="notes">
    <div class="markdown"><xsl:value-of select="."/></div>
  </xsl:template>

  <xsl:template match="class">
    <h2>
        <a name="{@name}"><xsl:value-of select="@name"/></a>
        <xsl:if test="@inherit">
            (<xsl:value-of select="@inherit"/>)
        </xsl:if>
        <xsl:if test="@package">
            from package <em><xsl:value-of select="@package"/></em>
        </xsl:if>
    </h2>
    <xsl:if test="@unit">
        <pre><code>uses <xsl:value-of select="@unit"/>;</code></pre>
    </xsl:if>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

  <xsl:template match="class/method">
    <p><strong><em><xsl:value-of select="../@name"/>.<xsl:value-of select="@name"/></em></strong>
    : <xsl:value-of select="."/></p>
  </xsl:template>

  <xsl:template match="wiki">
      <a href="http://wiki.lazarus.freepascal.org/{.}">Wiki:<xsl:value-of select="."/></a>
  </xsl:template>

  <xsl:template match="ref">
      <xsl:choose>
        <xsl:when test="@unit">
          <a href="https://www.freepascal.org/docs-html/{@section}/{@unit}/{.}.html">Ref:<xsl:value-of select="."/></a>
        </xsl:when>
        <xsl:otherwise>
          <a href="https://www.freepascal.org/docs-html/{@section}/{.}/index.html">Ref:<xsl:value-of select="."/></a>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  <xsl:template match="section">
    <h2><a name="{@name}"><xsl:value-of select="@name"/></a></h2>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>
  
  <xsl:template match="link">
    <a href="{@kdoc}.xml#{.}"><xsl:value-of select="."/></a>
  </xsl:template>

  <xsl:template match="python">
    <pre><code class="language-python">
      <xsl:value-of select="."/>
    </code></pre>
  </xsl:template>

</xsl:stylesheet>
