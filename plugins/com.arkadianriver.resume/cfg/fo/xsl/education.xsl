<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="2.0">

  <!--
  ===========================================================
  EDUCATION SECTION @TODO
  ===========================================================
  -->

  <xsl:template match="*[contains(@class, ' resume/program ')]">
    <fo:block xsl:use-attribute-sets="common.block">
      <fo:block xsl:use-attribute-sets="subsection.title">
        <xsl:value-of select="school"/>
      </fo:block>
      <fo:block>
        <fo:inline>
          <xsl:value-of select="degree"/>,
          <xsl:if test="field">
            <xsl:value-of select="field"/>,
          </xsl:if>
          <xsl:if test="minor">
            <xsl:value-of select="minor"/>,
          </xsl:if>
          <xsl:call-template name="getYear">
            <xsl:with-param name="yearmm" select="datefrom"/>
          </xsl:call-template> -
          <xsl:call-template name="getYear">
            <xsl:with-param name="yearmm" select="dateto"/>
          </xsl:call-template>.
        </fo:inline>
      </fo:block>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>