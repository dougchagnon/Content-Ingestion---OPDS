<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
        
        <xsl:element name="metadata" xmlns="http://www.w3schools.com">
         <!--   <xsl:attribute name="xmlns"><xsl:text>http://www.w3schools.com</xsl:text></xsl:attribute>
            <xsl:attribute name="xsi"><xsl:text>http://www.w3.org/2001/XMLSchema-instance</xsl:text></xsl:attribute>
            <xsl:attribute name="ns1"><xsl:text>http://www.w3schools.com</xsl:text></xsl:attribute> -->
        <xsl:for-each select="ns1:metadata">
            <xsl:element name="booktitle">
                <xsl:value-of select="ns1:booktitle"/>
            </xsl:element>
            <xsl:element name="printisbn13">
                <xsl:value-of select="ns1:printisbn13"/>
            </xsl:element>
            <xsl:element name="author">
                <xsl:element name="authorlastname"><xsl:value-of select="ns1:author/ns1:lastname"/>
                </xsl:element>
                <xsl:element name="authorfirstname"><xsl:value-of select="ns1:author/ns1:firstname"/>
                </xsl:element>
                <xsl:element name="authorothername"><xsl:value-of select="ns1:author/ns1:othername"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="description">
                <xsl:value-of select="ns1:description">
                </xsl:value-of>
            </xsl:element>
            <xsl:element name="publishdate">
                <xsl:value-of select="ns1:publishdate"/>
            </xsl:element>
            <xsl:element name="publisher">
                <xsl:value-of select="ns1:publisher"/>
            </xsl:element>
            <xsl:element name="copyright">
                <xsl:element name="copyrightdata">
                    <xsl:value-of select="ns1:copyright/ns1:copyrightdata"/></xsl:element>
                <xsl:element name="copyrightyear">
                    <xsl:value-of select="ns1:copyright/ns1:copyrightyear"/></xsl:element>
            </xsl:element>
            <xsl:element name="buyprinturl">
                <xsl:value-of select="ns1:buyprinturl"/>
            </xsl:element>
            <xsl:element name="extrasurl">
                <xsl:value-of select="ns1:extrasurl"/>
            </xsl:element>
            <xsl:element name="previewchapter">
                <xsl:value-of select="ns1:previewchapter"/>
            </xsl:element>
            <xsl:element name="pagecount">
                <xsl:value-of select="ns1:pagecount"/>
            </xsl:element>
            <xsl:element name="msrp">
                <xsl:value-of select="ns1:msrp"/>
            </xsl:element>
            <xsl:element name="chapterdownloads">
                <xsl:value-of select="ns1:chapterdownloads"/>
            </xsl:element>
            <xsl:element name="fullbookdownloads">
                <xsl:value-of select="ns1:fullbookdownloads"/>
            </xsl:element>
            <xsl:element name="TokensChapterDownload">
                <xsl:value-of select="ns1:TokensChapterDownload"/>
            </xsl:element>
            <xsl:element name="tokensbookdownload">
                <xsl:value-of select="ns1:tokensbookdownload"/>
            </xsl:element>
        </xsl:for-each>
 
            <xsl:for-each select="safarimeta/title">
                <xsl:element name="booktitle">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/aliases/alias">
           <xsl:choose>
             <xsl:when test="attribute::type='isbn13'">
              <xsl:element name="printisbn13">
                <xsl:value-of select="attribute::name"/>
              </xsl:element>
             </xsl:when>
               <xsl:when test="attribute::type='isbn'">
                   <xsl:element name="printisbn10">
                       <xsl:value-of select="attribute::name"/>
                   </xsl:element>
               </xsl:when>
               <xsl:otherwise></xsl:otherwise>
          </xsl:choose>
         </xsl:for-each>
            <xsl:for-each select="safarimeta">
                <xsl:element name="productid">
                    <xsl:value-of select="attribute::fpi"/>
                </xsl:element>
            </xsl:for-each> 
            <xsl:for-each select="safarimeta/subjectset/subject">
                <xsl:element name="subject">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/edition">
                <xsl:element name="edition">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <!-- Need example -->
            <xsl:for-each select="safarimeta/exclusive">
                <xsl:element name="exclusive">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <!-- Need example -->
            <xsl:for-each select="safarimeta/exclusiveexpire">
                <xsl:element name="exclusiveexpire">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/authorgroup">
                <xsl:element name="author">
                    <xsl:element name="lastname">
                         <xsl:value-of select="author/surname"/>
                    </xsl:element>
                    <xsl:element name="firstname">
                        <xsl:value-of select="author/firstname"/>
                    </xsl:element>
                    <xsl:element name="othername">
                        <xsl:value-of select="author/othername"/>
                    </xsl:element>
                           <xsl:element name="authorblurburl"> 
                               <xsl:for-each select="authorblurb/@url">
                                   <xsl:value-of select="."/>
                               </xsl:for-each>
                               <xsl:for-each select="author/authorblurb/@url">
                                   <xsl:value-of select="."/>
                               </xsl:for-each>
                              </xsl:element> 
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/description-short">
                <xsl:element name="description">
                    <xsl:copy-of select="child::node()"/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/pubdate">
                <xsl:element name="publishdate">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/publisher/publishername">
                <xsl:element name="publisher">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/copyright_year">
                <xsl:element name="copyright">
                    <xsl:element name="copyrightdata"><xsl:value-of select="../rights"/>
                    </xsl:element>
                    <xsl:element name="copyrightyear">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/bibliomisc[attribute::role='buyprint']">
                <xsl:element name="buyprinturl">
                    <xsl:value-of select="attribute::url"/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/relatedfiles/filegroup">
                <xsl:element name="relatedfiles">
                    <xsl:for-each select="ulink">
                    <xsl:attribute name="type">
                        <xsl:value-of select="ulink"/>
                    </xsl:attribute>
                    </xsl:for-each>
                    <xsl:for-each select="ulink/@url">
                    <xsl:attribute name="url">
                        <xsl:value-of select="ulink/@url"/>
                    </xsl:attribute>
                    </xsl:for-each>
                    <xsl:for-each select="description">
                    <xsl:attribute name="description">
                        <xsl:value-of select="description"/>
                    </xsl:attribute>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/pagenums">
                <xsl:element name="pagecount">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/msrp">
                <xsl:element name="msrp">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="safarimeta/graphic">
                <xsl:element name="coverimages">
                    <xsl:attribute name="role">
                        <xsl:value-of select="@role"/>
                    </xsl:attribute>
                    <xsl:attribute name="fileref">
                        <xsl:value-of select="@fileref"/>
                    </xsl:attribute>
                    <xsl:attribute name="width">
                        <xsl:value-of select="@width"/>
                    </xsl:attribute>
                    <xsl:attribute name="depth">
                        <xsl:value-of select="@depth"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>

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
                                <!--               <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute> -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--         <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--        <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="../ncx:navLabel/ncx:text[starts-with(., 'Chapter')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../ncx:navLabel/ncx:text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--           <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
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
                                <!--             <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@src)=15 and @src[starts-with(., 'xhtml/ch')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--              <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="string-length(@src)=9 and @src[starts-with(., 'ch')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--           <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:when test="../navLabel/text[starts-with(., 'Chapter')]">
                            <xsl:element name="bookstructureunit">
                                <xsl:attribute name="role"><xsl:text>chapter</xsl:text></xsl:attribute>
                                <xsl:attribute name="linkid"><xsl:value-of select="../@id"/></xsl:attribute>
                                <xsl:attribute name="title"><xsl:value-of select="../navLabel/text"/></xsl:attribute>
                                <xsl:attribute name="download"><xsl:value-of select="$chapterdownload"/></xsl:attribute>
                                <xsl:attribute name="tokens"><xsl:value-of select="$chaptertokens"/></xsl:attribute>
                                <!--           <xsl:attribute name="view"><xsl:value-of select="$chapterpreview"/><xsl:text>public</xsl:text></xsl:attribute>  -->
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise> 
                    </xsl:choose>
                </xsl:for-each>
                
            </xsl:element>
        </xsl:element> 
    </xsl:template>
</xsl:stylesheet>