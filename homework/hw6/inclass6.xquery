declare default element namespace "http://www.tei-c.org/ns/1.0";

<files>
{for $x in collection("file:///c:/Users/Sazand/Desktop/vwwp_tei?select=*.xml")
order by count($x/TEI/text//pb) descending
return
<file>

<idno>{data($x/TEI/@xml:id)}</idno>
<title>{string-join(data($x/TEI/teiHeader/fileDesc/titleStmt/title), ': ')}</title>
<title-count>{count($x/TEI/teiHeader/fileDesc/titleStmt/title)}</title-count>
<Author>{data($x/TEI/teiHeader/fileDesc/titleStmt/Author)}</Author>
<keywords>{string-join(data($x/TEI/teiHeader/profileDesc/textClass/keywords/list/item/term), ': ')}</keywords>
<keyword-count>{count($x/TEI/teiHeader/profileDesc/textClass/keywords/list/item/term)}</keyword-count>
<encoders>
{for $name in $x//respStmt/name
return
<name>{data($name)}</name>
}
</encoders>
<chapter-count>{count($x/TEI/text//div/[@type='chapter'])}</chapter-count>
<para-count>{count($x/TEI/text//div/p)}</para-count>
<pb-count>{count($x/TEI/text//pb) - number(substring-before($x/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/extent, ' p.'))}</pb-count>
</file>
}
</files>
