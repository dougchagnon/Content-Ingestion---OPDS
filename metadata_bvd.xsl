<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:ns1="http://www.w3schools.com"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output indent="yes" method="xml"/>
 <xsl:template match="/">   
    <xsl:variable name="booktokens">
        <xsl:for-each select="safarimeta/offlinecontentlist/offlineunit">
            <xsl:if test="attribute::role='book'">
                <xsl:value-of select="attribute::tokens"/>
            </xsl:if>  
        </xsl:for-each>
        <xsl:for-each select="ns1:metadata/ns1:tokensbookdownload">
                <xsl:value-of select="."/>              
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="chaptertokens">
        <xsl:for-each select="safarimeta/offlinecontentlist/offlineunit">
            <xsl:if test="position() = 8">
                <xsl:value-of select="attribute::tokens"/>
            </xsl:if>  
        </xsl:for-each>
        <xsl:for-each select="ns1:metadata/ns1:tokenschapterdownload">
                <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="chapterdownload">
        <xsl:for-each select="safarimeta/offlinecontentlist/offlineunit">
            <xsl:if test="position() = 8 and attribute::tokens!='0'">
                <xsl:text>yes</xsl:text>
            </xsl:if>  
        </xsl:for-each>
        <xsl:for-each select="ns1:metadata/ns1:chapterdownloads">
            <xsl:value-of select="."/>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="chapterpreview">
        
    </xsl:variable>

<!-- adding the bookstructurelist to existing metadata for BVD upload -->
            <xsl:for-each select="safarimeta">
                <xsl:element name="safarimeta">
                    <xsl:attribute name="fpi">
                        <xsl:value-of select="attribute::fpi"/>
                    </xsl:attribute>
                    <xsl:copy-of select="title"/>
                    <xsl:copy-of select="isbn"/>
                    <xsl:copy-of select="aliases"/>
                    <xsl:copy-of select="edition"/>
                    <xsl:copy-of select="rights"/>
                    <xsl:copy-of select="authorgroup"/>
                    <xsl:copy-of select="pagenums"/>
                    <xsl:copy-of select="pubdate"/>
                    <xsl:copy-of select="subjectset"/>
                    <xsl:copy-of select="publisher"/>
                    <xsl:copy-of select="description-short"/>
                    <xsl:copy-of select="msrp"/>
                    <xsl:copy-of select="points"/>
                    <xsl:copy-of select="prevedition"/>
                    <xsl:copy-of select="graphic"/>
                    <xsl:copy-of select="relatedfiles"/>
 
     
     <xsl:element name="bookstructurelist" xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/">
         <xsl:element name="bookstructureunit">
             <xsl:attribute name="role"><xsl:text>book</xsl:text></xsl:attribute>
             <xsl:attribute name="tokens"><xsl:value-of select="$booktokens"/></xsl:attribute>
         </xsl:element>
         <xsl:for-each select="document('toc.ncx')//ncx:content">
             <xsl:choose> 
                 <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <!-- for German books -->
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                </xsl:when>
                 <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'Chapter ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'CHAPTER ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <!-- extra BSL units being pulled in -->     
             <!--    <xsl:when test="../../ncx:navPoint">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:if test="../../ncx:navPoint[@id]"><xsl:value-of select="."/></xsl:if></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                             </xsl:when> -->
                 <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'Text/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'xhtml/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'Text/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=18 and @src[starts-with(., 'xhtml/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=12 and @src[starts-with(., 'part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'Part ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'PART ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:otherwise>
                 </xsl:otherwise> 
             </xsl:choose>
         </xsl:for-each> 
         
         <xsl:for-each select="document('toc.ncx')//content">
             <xsl:choose> 
                 <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <!-- for German books -->
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'ch')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when> 
                 <xsl:when test="../navLabel/text[starts-with(., 'Chapter ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="../navLabel/text[starts-with(., 'CHAPTER ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <!-- extra BSL units being pulled in -->
              <!--   <xsl:when test="../../navPoint[string-length(@id)=4 and @id[starts-with(., 'ch')]]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when> -->
                 <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'Text/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'xhtml/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'pt')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'Text/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=18 and @src[starts-with(., 'xhtml/part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=12 and @src[starts-with(., 'part')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>                
                 <xsl:when test="../navLabel/text[starts-with(., 'Part ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="../navLabel/text[starts-with(., 'PART ')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:otherwise>
                 </xsl:otherwise> 
             </xsl:choose>
         </xsl:for-each>
         
         <!-- Handling the NAV file in EPUB 3.0 -->
                 
                 <xsl:for-each select="document('nav001.xhtml')//xhtml:a">
                           <xsl:choose> 
                        <xsl:when test="string-length(@href)=17 and @href[starts-with(., '../Text/ch')]">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                        
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'xhtml/ch')]">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="starts-with(., 'Chapter')">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                       
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="starts-with(., 'CHAPTER')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                                      
                                   </xsl:element>
                        </xsl:when>
                               <xsl:when test="string-length(@href)=14 and @href[starts-with(., 'Text/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <!-- for German books -->
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'kap')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=11 and @href[starts-with(., 'kap')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=9 and @href[starts-with(., 'ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'Text/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'xhtml/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=14 and @href[starts-with(., 'Text/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'xhtml/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=9 and @href[starts-with(., 'pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'Text/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=17 and @href[starts-with(., 'xhtml/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=11 and @href[starts-with(., 'part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'Text/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'xhtml/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=17 and @href[starts-with(., 'Text/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=18 and @href[starts-with(., 'xhtml/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=12 and @href[starts-with(., 'part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="starts-with(., 'Part ')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="starts-with(., 'PART ')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise> 
                        </xsl:choose>
                </xsl:for-each>
         
     </xsl:element>

                </xsl:element>
            </xsl:for-each>
     
     <!-- Transforming new schema-based metadata to BVD-ready style xml for BVD upload -->
     
     <xsl:for-each select="ns1:metadata">
         <xsl:element name="safarimeta">
             <xsl:attribute name="fpi">
                 <xsl:value-of select="ns1:fpid"/>
             </xsl:attribute>
         <xsl:element name="title">
             <xsl:value-of select="ns1:booktitle"/>
         </xsl:element>
             <xsl:element name="isbn">
                 <xsl:value-of select="ns1:isbn"/>
             </xsl:element>
             <xsl:element name="aliases">
                 <xsl:for-each select="ns1:printisbn13">
                     <xsl:element name="alias">
                         <xsl:attribute name="type"><xsl:text>isbn13</xsl:text></xsl:attribute>
                         <xsl:attribute name="label"><xsl:text>Print ISBN-13</xsl:text></xsl:attribute>
                         <xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute> 
                         <xsl:attribute name="display"><xsl:value-of select="."/></xsl:attribute>
                     </xsl:element>
                 </xsl:for-each>
                 <xsl:for-each select="ns1:printisbn10">
                     <xsl:element name="alias">
                         <xsl:attribute name="type"><xsl:text>isbn10</xsl:text></xsl:attribute>
                         <xsl:attribute name="label"><xsl:text>Print ISBN-10</xsl:text></xsl:attribute>
                         <xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute> 
                         <xsl:attribute name="display"><xsl:value-of select="."/></xsl:attribute>
                     </xsl:element>
                 </xsl:for-each>
             </xsl:element>
             <xsl:element name="edition">
                 <xsl:value-of select="ns1:edition"/>
             </xsl:element>
             <xsl:element name="rights">
                 <xsl:value-of select="ns1:copyright/ns1:copyrightdata"/>
             </xsl:element>
             <xsl:element name="authorgroup">
                 <xsl:for-each select="ns1:author">
                     <xsl:element name="author">
                         <xsl:element name="surname"><xsl:value-of select="ns1:lastname"/></xsl:element>
                         <xsl:element name="firstname"><xsl:value-of select="ns1:firstname"/></xsl:element>
                         <xsl:element name="othername"><xsl:value-of select="ns1:othername"/></xsl:element>
                         <xsl:element name="authorblurb">
                             <xsl:attribute name="url"><xsl:value-of select="ns1:authorblurburl"/>
                             </xsl:attribute>
                             </xsl:element>
                     </xsl:element>
                 </xsl:for-each>
             </xsl:element>
             <xsl:element name="pagenums">
                 <xsl:value-of select="ns1:pagecount"/>
             </xsl:element>
             <xsl:element name="pubdate">
                 <xsl:value-of select="ns1:publishdate"/>
             </xsl:element>
             <xsl:for-each select="ns1:subject">
             <xsl:element name="subjectset">
                 <xsl:for-each select="ns1:subject">
                 <xsl:element name="subject">
                 <xsl:value-of select="."/>
                 </xsl:element>
                 </xsl:for-each>
             </xsl:element>
             </xsl:for-each>
             <xsl:element name="publisher">
                 <xsl:for-each select="ns1:publisher">
                     <xsl:element name="publishername"><xsl:value-of select="."/>
                     </xsl:element>
                     <xsl:element name="imprintname"><xsl:value-of select="."/>
                     </xsl:element>
                 </xsl:for-each>
             </xsl:element>
             <xsl:element name="description-short">
                 <xsl:copy-of select="ns1:description/child::node()">
                 </xsl:copy-of>
             </xsl:element>
             <xsl:element name="msrp">
                 <xsl:value-of select="ns1:msrp"/>
             </xsl:element>
             <xsl:for-each select="ns1:coverimages">
             <xsl:element name="graphic">
                 <xsl:attribute name="role">
                     <xsl:value-of select="attribute::role"/>
                 </xsl:attribute>
                 <xsl:attribute name="fileref">
                     <xsl:value-of select="attribute::fileref"/>
                 </xsl:attribute>
                 <xsl:attribute name="width">
                     <xsl:value-of select="attribute::width"/>
                 </xsl:attribute>
                 <xsl:attribute name="depth">
                     <xsl:value-of select="attribute::depth"/>
                 </xsl:attribute>
             </xsl:element>
             </xsl:for-each>
             <xsl:for-each select="ns1:aliases">
                 <xsl:copy-of select="."/>
             </xsl:for-each>
             <xsl:element name="bibliomisc">
                 <xsl:for-each select="ns1:buyprinturl">
                     <xsl:attribute name="role"><xsl:text>buyprint</xsl:text></xsl:attribute>
                     <xsl:attribute name="url"><xsl:value-of select="."/></xsl:attribute>
                 </xsl:for-each>
             </xsl:element>
             <xsl:element name="relatedfiles">  
                 <xsl:for-each select="ns1:extras/ns1:extras_files">
                     <xsl:if test="child::ns1:description and not(child::ns1:file)">
                         <xsl:for-each select="ns1:description">
                             <xsl:copy-of select="."/>               
                         </xsl:for-each>
                     </xsl:if>
                     <xsl:if test="child::ns1:file and not(child::ns1:description)">
                         <xsl:element name="filegroup">
                         <xsl:for-each select="ns1:file">
                                     <xsl:element name="file">
                                         <xsl:for-each select="@role">
                                             <xsl:attribute name="role">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@platform">
                                             <xsl:attribute name="platform">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@segmented">
                                             <xsl:attribute name="segmented">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="ns1:description">
                                             <xsl:copy-of select="."/>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@id">
                                             <xsl:attribute name="id">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@url">
                                             <xsl:attribute name="url">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@format">
                                             <xsl:attribute name="format">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@size">
                                             <xsl:attribute name="size">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                      <!--   <xsl:if test=". !=''">
                                             <xsl:value-of select="."/>
                                         </xsl:if>
                                         <xsl:if test=". =''">
                                             <xsl:value-of select="."/>
                                         </xsl:if> -->
                                     </xsl:element>
                         </xsl:for-each>
                             </xsl:element>
                     </xsl:if>
                     <xsl:if test="child::ns1:description and child::ns1:file">
                     <xsl:element name="filegroup">
                         <xsl:for-each select="ns1:description">
                             <xsl:copy-of select="."/>               
                         </xsl:for-each>
                         <xsl:for-each select="ns1:file">
                                     <xsl:element name="ulink">
                                         <xsl:for-each select="@role">
                                             <xsl:attribute name="role">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@platform">
                                             <xsl:attribute name="platform">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@segmented">
                                             <xsl:attribute name="segmented">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>               
                                         </xsl:for-each>
                                         <xsl:for-each select="ns1:description">
                                             <xsl:copy-of select="."/>               
                                         </xsl:for-each>
                                         <xsl:for-each select="@id">
                                             <xsl:attribute name="id">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@url">
                                             <xsl:attribute name="url">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@format">
                                             <xsl:attribute name="format">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:for-each select="@size">
                                             <xsl:attribute name="size">
                                                 <xsl:value-of select="."/>
                                             </xsl:attribute>
                                         </xsl:for-each>
                                         <xsl:if test=". !=''">
                                             <xsl:value-of select="."/>
                                         </xsl:if>
                                         <xsl:if test=". =''">
                                             <xsl:value-of select="."/>
                                         </xsl:if>
                                     </xsl:element>
                                 </xsl:for-each> 
                     </xsl:element>
                     </xsl:if>
                 </xsl:for-each>
       </xsl:element>

             <xsl:element name="bookstructurelist" xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/">
                 <xsl:element name="bookstructureunit">
                     <xsl:attribute name="role"><xsl:text>book</xsl:text></xsl:attribute>
                     <xsl:attribute name="tokens"><xsl:value-of select="$booktokens"/></xsl:attribute>
                 </xsl:element>
                 <xsl:for-each select="document('toc.ncx')//ncx:content">
                     <xsl:choose> 
                         <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <!-- for German books -->
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'Chapter ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'CHAPTER ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <!-- extra BSL units being pulled in -->
           <!--      <xsl:when test="../../ncx:navPoint[string-length(@id)=4 and @id[starts-with(., 'ch')]]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when> -->
                         <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'Text/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'xhtml/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'Text/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=18 and @src[starts-with(., 'xhtml/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=12 and @src[starts-with(., 'part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'Part ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'PART ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:otherwise>
                         </xsl:otherwise> 
                     </xsl:choose>
                 </xsl:for-each> 
                 
                 <xsl:for-each select="document('toc.ncx')//content">
                     <xsl:choose> 
                         <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <!-- for German books -->
                 <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                 <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'kap')]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'ch')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../navLabel/text[starts-with(., 'Chapter ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../navLabel/text[starts-with(., 'CHAPTER ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <!-- extra BSL units being pulled in -->
            <!--     <xsl:when test="../../navPoint[string-length(@id)=4 and @id[starts-with(., 'ch')]]">
                     <xsl:element name="bookstructureunit">
                         <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                         <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                         <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                         <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                         <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                     </xsl:element>
                 </xsl:when> -->
                         <xsl:when test="string-length(@src)=14 and @src[starts-with(., 'Text/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'Text/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'xhtml/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=11 and @src[starts-with(., 'part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'Text/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=16 and @src[starts-with(., 'xhtml/pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=10 and @src[starts-with(., 'pt')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=17 and @src[starts-with(., 'Text/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=18 and @src[starts-with(., 'xhtml/part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="string-length(@src)=12 and @src[starts-with(., 'part')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../navLabel/text[starts-with(., 'Part ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:when test="../navLabel/text[starts-with(., 'PART ')]">
                             <xsl:element name="bookstructureunit">
                                 <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                 <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                 <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                 <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                 <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                             </xsl:element>
                         </xsl:when>
                         <xsl:otherwise>
                         </xsl:otherwise> 
                     </xsl:choose>
                 </xsl:for-each>
                 
                 <!-- Handling the NAV file in EPUB 3.0 -->
                 
                 <xsl:for-each select="document('nav001.xhtml')//xhtml:a">
                           <xsl:choose> 
                        <xsl:when test="string-length(@href)=17 and @href[starts-with(., '../Text/ch')]">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                        
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'xhtml/ch')]">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="starts-with(., 'Chapter')">
                        <xsl:element name="bookstructureunit">
                        <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                        <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                        <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                        <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                        <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                       
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="starts-with(., 'CHAPTER')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>                                      
                                   </xsl:element>
                        </xsl:when>
                               <xsl:when test="string-length(@href)=14 and @href[starts-with(., 'Text/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <!-- for German books -->
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'kap')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=11 and @href[starts-with(., 'kap')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=9 and @href[starts-with(., 'ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'Text/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'xhtml/ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'ch')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=14 and @href[starts-with(., 'Text/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'xhtml/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=9 and @href[starts-with(., 'pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'Text/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=17 and @href[starts-with(., 'xhtml/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=11 and @href[starts-with(., 'part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="string-length(@href)=15 and @href[starts-with(., 'Text/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=16 and @href[starts-with(., 'xhtml/pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=10 and @href[starts-with(., 'pt')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=17 and @href[starts-with(., 'Text/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=18 and @href[starts-with(., 'xhtml/part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="string-length(@href)=12 and @href[starts-with(., 'part')]">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>                        
                               <xsl:when test="starts-with(., 'Part ')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                               <xsl:when test="starts-with(., 'PART ')">
                                   <xsl:element name="bookstructureunit">
                                       <xsl:attribute name="role"><xsl:text>part</xsl:text></xsl:attribute>
                                       <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                       <xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
                                       <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                       <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                   </xsl:element>
                               </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise> 
                        </xsl:choose>
                </xsl:for-each>
                 
             </xsl:element>


         </xsl:element>
     </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>