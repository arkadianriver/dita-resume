<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="2.0">

  <!--
  ===========================================================
  CONTACT LIST SECTION: Write contact list as a single line.
  ===========================================================
  -->

  <xsl:template match="*[contains(@class, ' resume/contact ')]">
    <fo:block>
      <xsl:for-each select="./*[contains(@class, ' topic/li ' )]">
        <xsl:apply-templates select="." mode="mkContacts" />
      </xsl:for-each>
    </fo:block>
  </xsl:template>

  <!--
  Foreach contact, call mkContactLink with link params
  (except phone, which has its own special formatting).
  -->
  <xsl:template match="*" mode="mkContacts">
    <xsl:choose>
      <xsl:when test="contains(@class, ' resume/phone ')">
        <xsl:call-template name="formatPhone"/>
      </xsl:when>
      <xsl:when test="contains(@class, ' resume/email ')">
        <xsl:call-template name="mkContactLink">
          <xsl:with-param name="url" select="concat('mailto:', ./text())" />
          <xsl:with-param name="linkText" select="./text()" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains(@class, ' resume/linkedin ')">
        <xsl:call-template name="mkContactLink">
          <xsl:with-param name="url" select="concat('https://linkedin.com/in/', ./text(), '/')" />
          <xsl:with-param name="linkText" select="concat('linkedin.com/in/', ./text())" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains(@class, ' resume/website ')">
        <xsl:call-template name="mkContactLink">
          <xsl:with-param name="url" select="concat('https://', ./text(), '/')" />
          <xsl:with-param name="linkText" select="./text()" />
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- 
  Create link with formatted params, prefixed by ' | ', since phone comes first.
  -->
  <xsl:template name="mkContactLink">
    <xsl:param name="url" select="@url" />
    <xsl:param name="linkText" select="@linkText" />  |  <fo:inline
      xsl:use-attribute-sets="link__content">
      <fo:basic-link>
        <xsl:attribute name="external-destination">
          <xsl:text>url('</xsl:text>
          <xsl:value-of select="$url" />
          <xsl:text>')</xsl:text>
        </xsl:attribute>
        <fo:inline>
          <xsl:value-of select="$linkText" />
        </fo:inline>
      </fo:basic-link>
    </fo:inline>
  </xsl:template>

  <!-- 
  Phone number formatting:
  (Using phPatterns "hash table" in variables.xsl to reference formatting info.)
  If a countrycode is present and if the subsequent numbers are
  of the right length, go ahead and format them; otherwise, just print numbers as is.
  -->
  <xsl:template name="formatPhone">
    <xsl:variable name="cc">
      <xsl:choose>
        <xsl:when test="./*[contains(@class, ' resume/countrycode ')]">
          <xsl:value-of select="normalize-space(./countrycode/text())" />
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="digits" select="normalize-space(./countrycode/following-sibling::*)"/>
    <fo:inline>
      <xsl:choose>
        <xsl:when
          test="$cc > 0 and string-length($digits) = key('kMap', $cc, $phPatterns)/@length">
          <xsl:text>+</xsl:text>
          <xsl:value-of select="$cc"/>
          <xsl:value-of
            select="replace($digits, key('kMap', $cc, $phPatterns)/@match, key('kMap', $cc, $phPatterns)/@subst)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$digits" />
        </xsl:otherwise>
      </xsl:choose>
    </fo:inline>
  </xsl:template>

</xsl:stylesheet>