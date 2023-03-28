<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="text" indent="yes"/>
  <xsl:template match="/">
    {
      "events": [
        <xsl:for-each select="COMMAND/RESULTS/CIM/INSTANCE">
          {
            <xsl:for-each select="PROPERTY">
              <xsl:if test="position() != last()"><xsl:value-of select="translate(@NAME, '_', '-')"/>: "<xsl:value-of select="VALUE"/>", </xsl:if>
              <xsl:if test="position() = last()"><xsl:value-of select="translate(@NAME, '_', '-')"/>: "<xsl:value-of select="VALUE"/>"</xsl:if>
            </xsl:for-each>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ]
    }
  </xsl:template>
</xsl:stylesheet>
