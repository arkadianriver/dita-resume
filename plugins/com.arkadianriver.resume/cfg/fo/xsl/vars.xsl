<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="2.0">

  <!--
  ===========================================================
  VARIABLES
  ===========================================================
  -->

  <!-- Possibly passed from CLI -->
  <xsl:param name="args.jobrole"/>

  <!--
  Used to choose description and prioritize lists.
  -->
  <xsl:variable name="jobrole">
    <xsl:choose>
      <xsl:when test="not($args.jobrole)">
        <xsl:value-of select="'dev'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$args.jobrole"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- 
  Map used in phone number formatting, keyed off phone country code
  -->
  <xsl:variable name="phPatterns">
    <codes>
      <code key="1" country="us" length="10" match="(\d\d\d)(\d\d\d)(\d\d\d\d)" subst=" ($1) $2-$3" />
      <code key="49" country="de" length="8" match="(\d\d\d\d)(\d\d\d\d)" subst=" $1.$2" />
    </codes>
  </xsl:variable>

  <xsl:key name="kMap" match="code" use="string(@key)" />

</xsl:stylesheet>