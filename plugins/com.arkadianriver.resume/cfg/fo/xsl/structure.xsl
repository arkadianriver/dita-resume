<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  version="2.0">

  <!--
  ===========================================================
  STRUCTURE AND COMMON
  ===========================================================
  -->

  <!--
  Force a page break after each resume (topic).
  -->
  <xsl:template match="*" mode="processTopic">
    <fo:block
      xsl:use-attribute-sets="topic">
      <xsl:attribute name="page-break-after">always</xsl:attribute>
      <xsl:apply-templates select="." mode="commonTopicProcessing" />
      <fo:block id="last-page"/>
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

  <!-- 
  Footers, using last page as a parameter
  -->
  <xsl:template name="insertBodyOddFooter">
    <fo:static-content flow-name="odd-body-footer">
      <fo:block xsl:use-attribute-sets="__body__odd__footer">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Body odd footer'" />
          <xsl:with-param name="params">
            <heading>
              <fo:inline xsl:use-attribute-sets="__body__odd__footer__heading">
                <fo:retrieve-marker retrieve-class-name="current-header" />
              </fo:inline>
            </heading>
            <pagenum>
              <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenum">
                <fo:page-number />
              </fo:inline>
            </pagenum>
            <pagenumlast>
              <fo:inline xsl:use-attribute-sets="__body__odd__footer__pagenumlast">
                <fo:page-number-citation ref-id="last-page" />
              </fo:inline>
            </pagenumlast>
          </xsl:with-param>
        </xsl:call-template>
      </fo:block>
    </fo:static-content>
  </xsl:template>

  <xsl:template name="insertBodyEvenFooter">
    <fo:static-content flow-name="even-body-footer">
      <fo:block xsl:use-attribute-sets="__body__even__footer">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Body even footer'" />
          <xsl:with-param name="params">
            <heading>
              <fo:inline xsl:use-attribute-sets="__body__even__footer__heading">
                <fo:retrieve-marker retrieve-class-name="current-header" />
              </fo:inline>
            </heading>
            <pagenum>
              <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                <fo:page-number />
              </fo:inline>
            </pagenum>
            <pagenumlast>
              <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenumlast">
                <fo:page-number-citation ref-id="last-page" />
              </fo:inline>
            </pagenumlast>
          </xsl:with-param>
        </xsl:call-template>
      </fo:block>
    </fo:static-content>
  </xsl:template>

  <!-- 
  Add the trailing leader to the DITA-OT section title template
  -->
  <xsl:template
    match="*[contains(@class,' topic/section ')]
            [@spectitle != '' and not(*[contains(@class, ' topic/title ')])]"
    mode="dita2xslfo:section-heading"
    priority="10">
    <fo:block xsl:use-attribute-sets="section.title section.color">
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
      <xsl:text> </xsl:text>
      <fo:leader xsl:use-attribute-sets="section.leader section.color" />
    </fo:block>
  </xsl:template>

  <!--
  Return 3-char month from YYYY-MM date (using table in en.xml)
  -->
  <xsl:template name="getMon">
    <xsl:param name="yearmm" select="@yearmm" />
    <xsl:variable name="monNum">
      <xsl:value-of select="replace($yearmm, '.*-(\d\d)$', '$1')" />
    </xsl:variable>
    <xsl:call-template
      name="getVariable">
      <xsl:with-param name="id" select="concat('mon_', $monNum)" />
    </xsl:call-template>
  </xsl:template>

  <!--
  Return year from YYYY-MM date
  -->
  <xsl:template name="getYear">
    <xsl:param name="yearmm" select="@yearmm" />
    <xsl:value-of
      select="replace($yearmm, '^(\d\d\d\d).*', '$1')" />
  </xsl:template>

  <!--
  List prioritization
  -->
  <xsl:template name="groupByJobrole">
    <xsl:apply-templates select="*[contains(@jobrole, $jobrole)]" />
    <xsl:apply-templates select="*[not(contains(@jobrole, $jobrole))]" />
  </xsl:template>

</xsl:stylesheet>