<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

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

  <!-- light colored page string -->
  <xsl:attribute-set name="pagenum">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
  </xsl:attribute-set>

  <!-- Resume name (title) -->
  <xsl:attribute-set name="topic.title">
    <xsl:attribute name="border-after-width">0</xsl:attribute>
    <xsl:attribute name="space-before">0</xsl:attribute>
    <xsl:attribute name="space-after">12pt</xsl:attribute>
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="color">#3090f0</xsl:attribute>
    <xsl:attribute name="padding-top">0</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>