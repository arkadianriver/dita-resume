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
      <fo:leader xsl:use-attribute-sets="section.leader section.color"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>