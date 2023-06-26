<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

  <!--
  ===========================================================
  FORMATTING VARIABLES AND ATTRIBUTES
  ===========================================================
  -->

  <!-- US letter -->
  <xsl:variable name="page-width">215.9mm</xsl:variable>
  <xsl:variable name="page-height">279.4mm</xsl:variable>

  <!-- Less white space overall but with more at bottom for pagenum -->
  <xsl:variable name="page-margins">12mm</xsl:variable>
  <xsl:variable name="page-margin-bottom">16mm</xsl:variable>

  <!-- Only print resumes, nothing else -->
  <xsl:variable name="generate-front-cover" select="false()" />
  <xsl:variable name="generate-back-cover" select="false()" />
  <xsl:variable name="generate-toc" select="false()" />

  <!-- change base font to serif -->
  <xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
    <xsl:attribute name="font-family">sans-serif</xsl:attribute>
    <xsl:attribute name="xml:lang" select="translate($locale, '_', '-')" />
    <xsl:attribute name="writing-mode" select="$writing-mode" />
  </xsl:attribute-set>

  <!-- left-justify child block borders -->
  <xsl:variable name="side-col-width">0</xsl:variable>

  <!-- page not bold -->
  <xsl:attribute-set name="pagenum">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <!-- footers light colored, smaller, and brought in from margin -->
  <xsl:attribute-set name="odd__footer">
    <xsl:attribute name="font-size">0.8em</xsl:attribute>
    <xsl:attribute name="color">#6a6a6a</xsl:attribute>
    <xsl:attribute name="text-align">end</xsl:attribute>
    <xsl:attribute name="end-indent">12mm</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="even__footer">
    <xsl:attribute name="font-size">0.8em</xsl:attribute>
    <xsl:attribute name="color">#6a6a6a</xsl:attribute>
    <xsl:attribute name="start-indent">12mm</xsl:attribute>
    <xsl:attribute name="space-after">10pt</xsl:attribute>
    <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Resume name (title) -->
  <xsl:attribute-set name="topic.title">
    <xsl:attribute name="border-after-width">0</xsl:attribute>
    <xsl:attribute name="space-before">0</xsl:attribute>
    <xsl:attribute name="space-after">12pt</xsl:attribute>
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">#3090f0</xsl:attribute>
    <xsl:attribute name="padding-top">0</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <!-- section titles blue with line -->
  <xsl:attribute-set name="section.title" use-attribute-sets="common.title">
    <xsl:attribute name="text-align-last">justify</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="space-before">14pt</xsl:attribute>
    <xsl:attribute name="space-after">8pt</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="section.color">
    <xsl:attribute name="color">#3090f0</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.leader">
    <xsl:attribute name="leader-pattern">rule</xsl:attribute>
    <xsl:attribute name="vertical-align">center</xsl:attribute>
    <xsl:attribute name="rule-style">solid</xsl:attribute>
    <xsl:attribute name="rule-thickness">1pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- paragraph-like blocks -->
  <xsl:attribute-set name="common.block">
    <xsl:attribute name="space-before">0.2em</xsl:attribute>
    <xsl:attribute name="space-after">0.6em</xsl:attribute>
  </xsl:attribute-set>

  <!-- ul - shorten distance from bullet -->
  <xsl:attribute-set name="ul" use-attribute-sets="common.block">
    <xsl:attribute name="start-indent">4mm</xsl:attribute>
    <xsl:attribute name="provisional-distance-between-starts">4mm</xsl:attribute>
    <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
  </xsl:attribute-set>

  <!-- subsection titles (resume-only) -->
  <xsl:attribute-set name="subsection.title" use-attribute-sets="common.title">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="space-before">10pt</xsl:attribute>
    <xsl:attribute name="space-after">0</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <!-- tech-list (resume-only (dl equiv)) -->
  <xsl:attribute-set name="tech.dl">
    <xsl:attribute name="start-indent">0</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="tech.dlentry">
    <xsl:attribute name="start-indent">0</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="tech.dt">
    <xsl:attribute name="start-indent">0</xsl:attribute>
    <xsl:attribute name="space-before">2pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tech.dd">
    <xsl:attribute name="start-indent">4mm</xsl:attribute>
  </xsl:attribute-set>


</xsl:stylesheet>