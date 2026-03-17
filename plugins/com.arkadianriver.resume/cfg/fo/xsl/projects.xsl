<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  version="3.1">

  <!--
  ===========================================================
  INDEPENDENT SECTION
  ===========================================================
  -->

  <xsl:template match="*[contains(@class, ' resume/projects ')]">
    <xsl:apply-templates select="." mode="dita2xslfo:section-heading"/>
    <xsl:apply-templates />
  </xsl:template>


  <!-- <xsl:template match="*" mode="resume-projects-block">
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline" />
    <xsl:choose>
      <xsl:when test="count(project) = 1">
        <fo:block xsl:use-attribute-sets="tech.dd">
          <xsl:call-template name="commonattributes" />
          <xsl:value-of select="project"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:list-block
          xsl:use-attribute-sets="ul">
          <xsl:call-template name="commonattributes" />
          <xsl:call-template name="groupByJobrole" />
        </fo:list-block>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates
      select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline" />
  </xsl:template> -->


</xsl:stylesheet>