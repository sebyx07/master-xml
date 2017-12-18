<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <body>
        <h2>Persons List</h2>
        <table border="1">
          <tr bgcolor="#9acd32">
            <th style="text-align:left">Name</th>
            <th style="text-align:left">Age</th>
          </tr>
          <xsl:for-each select="school/persons/person">
            <tr>
              <td><xsl:value-of select="name"/></td>
              <td><xsl:value-of select="age"/></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>