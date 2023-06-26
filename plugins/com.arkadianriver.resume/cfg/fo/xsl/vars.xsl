<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

  <!--
  ===========================================================
  VARIABLES
  ===========================================================
  -->

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