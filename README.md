# Windows Event Log Exporter

This batch script exports Windows System and Application event errors to JSON format files.

## Usage

1. First, place the `json.xsl` file in the same directory as the batch file.
2. Run the batch file by double-clicking it or executing it from the command prompt.
3. Upon execution, the batch file exports System and Application event errors in JSON format. The exported files are saved in the same directory as the batch file, with filenames including the computer name and date.

## Batch File Content

The batch file consists of the following content:

```batch
@echo off

setlocal

rem Exporting system event errors to json
wmic ntevent where "(logfile='system' and timegenerated >= '%DATE:/=%' and (EventType='1' or EventType='2'))" list /format:"%~dp0json.xsl" > "%~dp0%COMPUTERNAME%_%DATE:/=%_sys.json"

rem Exporting application event errors to json
wmic ntevent where "(logfile='application' and timegenerated >= '%DATE:/=%' and (EventType='1' or EventType='2'))" list /format:"%~dp0json.xsl" > "%~dp0%COMPUTERNAME%_%DATE:/=%_app.json"

echo Complete!
echo Each log is written to %~dp0%

endlocal
```

## json.xsl File

The json.xsl file is an XSLT stylesheet used to transform the XML data obtained from the WMIC command into JSON format.

```xsl
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="text" indent="yes"/>
  <xsl:template match="/">
    {
      "events": [
        <xsl:for-each select="COMMAND/RESULTS/CIM/INSTANCE">
          {
            <xsl:for-each select="PROPERTY">
              <xsl:if test="position() != last()"><xsl:value-of select="translate(@NAME, '_', '-')"/>: "<xsl:value-of select="VALUE"/>", </xsl:if>
              <xsl:if test="position() = last()"><xsl:value-of select="translate(@NAME, '_', '-')"/>: "<xsl:value-of select="VALUE"/>"</xsl:if>
            </xsl:for-each>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ]
    }
  </xsl:template>
</xsl:stylesheet>
```

## License

MIT

## Author

Kenta Goto
