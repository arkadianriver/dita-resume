<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="2.0">

  <!--
  ===========================================================
  EXPERIENCE SECTION @TODO
  ===========================================================
  -->

  <!--
  Don't create a ul at this level.
  -->
  <xsl:template match="*[contains(@class, ' resume/positions ')]">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- 
  Create a UL with subsection.title for each position
  -->
  <xsl:template match="*[contains(@class, ' resume/position ')]">
    <fo:block xsl:use-attribute-sets="subsection.title">
      <xsl:call-template name="commonattributes" />
      <xsl:value-of select="organization"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="jobtitle"/>
      <xsl:text> | </xsl:text>
      <xsl:call-template name="getMon">
        <xsl:with-param name="yearmm" select="datefrom"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:call-template name="getYear">
        <xsl:with-param name="yearmm" select="datefrom"/>
      </xsl:call-template>
      <xsl:text> - </xsl:text>
      <xsl:call-template name="getMon">
        <xsl:with-param name="yearmm" select="dateto"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:call-template name="getYear">
        <xsl:with-param name="yearmm" select="dateto"/>
      </xsl:call-template>
      <xsl:text> | </xsl:text>
      <xsl:value-of select="location"/>
    </fo:block>
    <xsl:apply-templates select="accomplishments" mode="resume-list-block"/>
  </xsl:template>


</xsl:stylesheet>