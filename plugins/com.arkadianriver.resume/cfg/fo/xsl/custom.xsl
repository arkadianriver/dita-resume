<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  version="2.0">

  <!--
  Force a page break after each resume (topic).
  -->
  <xsl:template match="*" mode="processTopic">
    <fo:block
      xsl:use-attribute-sets="topic">
      <xsl:attribute name="page-break-after">always</xsl:attribute>
      <xsl:apply-templates select="." mode="commonTopicProcessing" />
    </fo:block>
  </xsl:template>

  <!--
  Removed page-sequence and flow from map, so that we can use it
  at the beginning of each resume (topic) to re-start numbering.
  -->
  <xsl:template match="*[contains(@class, ' map/map ')]" mode="generatePageSequences">
    <xsl:call-template name="createFrontMatter" />
    <xsl:call-template name="createToc" />
    <xsl:for-each
      select="opentopic:map/*[contains(@class, ' map/topicref ')]">
      <xsl:apply-templates select="." mode="generatePageSequenceFromTopicref" />
    </xsl:for-each>
    <xsl:call-template
      name="createIndex" />
    <xsl:call-template name="createBackCover" />
  </xsl:template>

  <!-- 
  Surround topic contents with page-sequence and flow to re-start numbering
  with each resume.
  -->
  <xsl:template match="*[contains(@class,' map/topicref ')]" mode="generatePageSequenceFromTopicref">
    <xsl:variable name="referencedTopic" select="key('topic-id', @id)" as="element()*" />
    <fo:page-sequence
      master-reference="ditamap-body-sequence" xsl:use-attribute-sets="page-sequence.body">
      <xsl:attribute name="initial-page-number">1</xsl:attribute>
      <xsl:call-template name="insertBodyStaticContents" />
      <fo:flow flow-name="xsl-region-body">
        <xsl:choose>
          <xsl:when test="empty($referencedTopic)">
            <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]" mode="#current" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="$referencedTopic">
              <xsl:apply-templates select="." mode="processTopic" />
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>


  <!-- ======================================================
  CONTACT LIST SECTION: Write contact list as a single line.
  =========================================================== -->

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
  - Using phPatterns as "hash table" to store formatting info for each country code.
  - kMap defines the key to use
  - In formatPhone, if a countrycode is present and if the subsequent numbers are
    of the right length, go ahead and format them; otherwise, just print numbers as is.
  -->
  <xsl:variable name="phPatterns">
    <codes>
      <code key="1" country="us" length="10" match="(\d\d\d)(\d\d\d)(\d\d\d\d)" subst=" ($1) $2-$3" />
      <code key="49" country="de" length="8" match="(\d\d\d\d)(\d\d\d\d)" subst=" $1.$2" />
    </codes>
  </xsl:variable>

  <xsl:key name="kMap" match="code" use="string(@key)" />

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