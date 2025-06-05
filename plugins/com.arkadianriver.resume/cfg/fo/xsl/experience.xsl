<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="3.1">

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
    <xsl:variable name="position-guts">
      <xsl:call-template name="commonattributes" />
      <xsl:value-of select="organization"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="jobtitle"/>
      <fo:inline font-weight="normal">
        <xsl:text> • </xsl:text>
        <xsl:call-template name="getMon">
          <xsl:with-param name="yearmm" select="datefrom"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="getYear">
          <xsl:with-param name="yearmm" select="datefrom"/>
        </xsl:call-template>
        <xsl:text> - </xsl:text>
        <xsl:choose>
          <xsl:when test="dateto and (dateto/text() != '' or dateto/text() != 'present')">
            <xsl:call-template name="getMon">
              <xsl:with-param name="yearmm" select="dateto"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:call-template name="getYear">
              <xsl:with-param name="yearmm" select="dateto"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="getVariable">
              <xsl:with-param name="id" select="'present'" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> • </xsl:text>
        <xsl:value-of select="location"/>
      </fo:inline>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="count(accomplishments/accomplishment) = 1">
        <fo:block xsl:use-attribute-sets="subsection.titlesmall">
          <xsl:copy-of select="$position-guts"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:block xsl:use-attribute-sets="subsection.title">
          <xsl:copy-of select="$position-guts"/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="accomplishments" mode="resume-list-block"/>
  </xsl:template>


</xsl:stylesheet>