<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="2.0">

  <!--
  ===========================================================
  SUMMARY SECTION
  ===========================================================
  -->

  <!-- 
  Include heading with Specialties (and any other list that has a spectitle)
  -->
  <xsl:template match="*[contains(@class,' topic/ul ') and @spectitle != '']">
    <xsl:apply-templates select="." mode="subsection-heading" />
    <xsl:apply-templates select="."
      mode="resume-list-block" />
  </xsl:template>

  <!-- 
  Include heading with Technologies specifically
  (since it's not formatted as a table, like a topic/dl is)
  -->
  <xsl:template match="*[contains(@class,' resume/technologies ') and @spectitle != '']">
    <xsl:apply-templates select="." mode="subsection-heading" />
    <xsl:apply-templates select="."
      mode="resume-tech-block" />
  </xsl:template>

  <!-- 
  The add-heading template, based on spectitle variable for L10n
  (copied from DITA-OT 4.0.2 section-title)
  -->
  <xsl:template match="*" mode="subsection-heading">
    <fo:block xsl:use-attribute-sets="subsection.title">
      <xsl:call-template name="commonattributes" />
      <xsl:variable name="spectitleValue" as="xs:string" select="string(@spectitle)" />
      <xsl:variable name="resolvedVariable">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="$spectitleValue" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:sequence
        select="if (not(normalize-space($resolvedVariable)))
                then $spectitleValue
                else $resolvedVariable" />
    </fo:block>
  </xsl:template>

  <!-- 
  abstracted list item contents
  (copied from DITA-OT 4.0.2 topic/ul template)
  -->
  <xsl:template match="*" mode="resume-list-block">
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline" />
    <fo:list-block
      xsl:use-attribute-sets="ul">
      <xsl:call-template name="commonattributes" />
      <xsl:apply-templates />
    </fo:list-block>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template>

  <xsl:template match="*" mode="resume-tech-block">
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]"
      mode="outofline" />
    <fo:block xsl:use-attribute-sets="tech.dl">
      <xsl:call-template name="commonattributes" />
      <xsl:apply-templates />
    </fo:block>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template>

  <xsl:template match="*[contains(@class, ' resume/technology ')]">
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]"
      mode="outofline" />
    <fo:block xsl:use-attribute-sets="tech.dlentry">
      <xsl:call-template name="commonattributes" />
      <xsl:apply-templates />
    </fo:block>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template>

  <xsl:template match="*[contains(@class, ' resume/techcategory ')]">
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]"
      mode="outofline" />
    <fo:block xsl:use-attribute-sets="tech.dt">
      <xsl:call-template name="commonattributes" />
      <xsl:apply-templates />
      <xsl:text>:</xsl:text>
    </fo:block>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template>

  <xsl:template match="*[contains(@class, ' resume/techcategorylist ')]">
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]"
      mode="outofline" />
    <fo:block xsl:use-attribute-sets="tech.dd">
      <xsl:call-template name="commonattributes" />
      <xsl:apply-templates />
    </fo:block>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template>


</xsl:stylesheet>