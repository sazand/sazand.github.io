declare default element namespace "urn:isbn:1-931666-22-9";
<files>
<!-- I have ordered the volume of collections per the number of files for each collection and my strong guess is that this approach is correct for one can see that the physical extent or the covering years of each collection increases in conformity with the number of files. -->
{for $x in collection("file:///c:/Users/sazand/Desktop/xquery-assignment?select=*.xml")
order by count($x//*[@level='file']) descending
return
      <file>
            <aid>
                <id>{data($x//eadid/@identifier)}</id>
                <title>{data($x//filedesc//titleproper)}</title>
                <noYears>{number(substring-after($x/ead/eadheader/filedesc/titlestmt/titleproper/date, '-')) - number(substring-before($x/ead/eadheader/filedesc/titlestmt/titleproper/date, '-'))}</noYears>
                <encoder>{data($x/ead/eadheader/filedesc/titlestmt/author)}</encoder>
                <change-count>{count($x/ead/eadheader/revisiondesc/change)}</change-count>
                <physical-extent>{data($x/ead/archdesc/did/physdesc/extent)}</physical-extent>
                <accessrestrict>{string-join(data($x/ead/archdesc/accessrestrict/p), '| ')}</accessrestrict>
                <indices>
                {for $head in $x/ead/archdesc/controlaccess/controlaccess/head
                return
                <index-content>{data($head)}</index-content>
                }
                {for $corpname in $x/ead/archdesc/controlaccess/controlaccess/list/item/extref/corpname
                return
                <institution>{data($corpname)}</institution>
                }
                 {for $persname in $x/ead/archdesc/controlaccess/controlaccess/list/item/extref/persname
                return
                <people>{data($persname)}</people>
                }
                 {for $subject in $x/ead/archdesc/controlaccess/controlaccess/list/item/extref/subject
                return
                <topic>{data($subject)}</topic>
                }
                {for $title in $x/ead/archdesc/controlaccess/controlaccess/list/item/extref/title
                return
                <doc-title>{data($title)}</doc-title>
                }
                {for $geogname in $x/ead/archdesc/controlaccess/controlaccess/list/item/extref/geogname
                return
                <place>{data($geogname)}</place>
                }
                </indices>

                <file-count>{count($x//*[@level='file'])}</file-count>
            </aid>
        </file>
}(
</files>

