<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="2.0">

  <!--
  ===========================================================
  AWARDS SECTION @TODO
  ===========================================================
  -->

  <xsl:template match="*[contains(@class, ' resume/award ')]">
    <xsl:variable name="issuedByLine">
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="'issued_by_x'"/>
        <xsl:with-param name="params" select="issuedby"/>
      </xsl:call-template>
    </xsl:variable>
    <fo:block xsl:use-attribute-sets="common.block">
      <fo:block xsl:use-attribute-sets="subsection.title">
        <xsl:value-of select="title"/>
      </fo:block>
      <fo:block>
        <fo:inline>
          <xsl:value-of select="$issuedByLine"/> -
          <xsl:call-template name="getMon">
            <xsl:with-param name="yearmm" select="dateissued"/>
          </xsl:call-template>
          <xsl:text> </xsl:text>
          <xsl:call-template name="getYear">
            <xsl:with-param name="yearmm" select="dateissued"/>
          </xsl:call-template>,
          <xsl:value-of select="achievement"/>
        </fo:inline>
      </fo:block>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>