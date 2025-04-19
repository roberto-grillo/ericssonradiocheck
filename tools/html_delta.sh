#!/bin/bash



echo "<div id='tabellaD1' class='tab'>"
echo "<h2>Diff EUtranCell</h2>"

#echo "<select id=\"filterDropdown7\" class=\"filter-dropdown\" onchange=\"filterTable(7)\">"
#echo "    <option value=\"\">Administrative State</option>"
#echo "    <option value=\"UNLOCKED\">UNLOCKED</option>"
#echo "    <option value=\"LOCKED\">LOCKED</option>"
#echo "</select>"
echo "<select id=\"filterDropdown8\" class=\"filter-dropdown\" onchange=\"filterTable(8)\">"
echo "    <option value=\"\">Operational State</option>"
echo "    <option value=\"ENABLED\">ENABLED</option>"
echo "    <option value=\"DISABLED\">DISABLED</option>"
echo "</select>"


echo "<table id='tabellaD1'>"
# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$1"
echo "</table>"


echo "<script>"
echo "function filterTable(columnIndex) {"
echo "  var dropdown, filter, table, tr, td, i, txtValue;"
echo "  dropdown = document.getElementById('filterDropdown' + columnIndex);"
echo "  filter = dropdown.value.toUpperCase();"
echo "  table = document.getElementById('tabellaD1');"
echo "  tr = table.getElementsByTagName('tr');"
echo "  for (i = 0; i < tr.length; i++) {"
echo "    td = tr[i].getElementsByTagName('td')[columnIndex];"
echo "    if (td) {"
echo "      txtValue = td.textContent || td.innerText;"
echo "      if (txtValue.toUpperCase().indexOf(filter) > -1 || filter === '') {"
echo "        tr[i].style.display = '';"
echo "      } else {"
echo "        tr[i].style.display = 'none';"
echo "      }"
echo "    }"
echo "  }"
echo "}"
echo "</script>"



echo "</div>"




echo "<div id='tabellaD2' class='tab'>"
echo "<h2>Diff NRCell</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$2"
echo "</table>"
echo "</div>"




echo "<div id='tabellaD3' class='tab'>"
echo "<h2>Diff Cells</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$3"
echo "</table>"
echo "</div>"




echo "<div id='tabellaD4' class='tab'>"
echo "<h2>Diff Alarms</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$4"
echo "</table>"
echo "</div>"




echo "<div id='tabellaD5' class='tab'>"
echo "<div id='chartdiv2'></div>"
echo "<h2>Diff Alarms Problem Type</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$5"
echo "</table>"
echo "</div>"






echo "<div id='tabellaD6' class='tab'>"
echo "<div id='chartdiv3'></div>"
echo "<h2>Diff Alarms Managed Object</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$6"
echo "</table>"
echo "</div>"




echo "<div id='tabellaD7' class='tab'>"
echo "<h2>Diff Upgrade Package</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$7"
echo "</table>"
echo "</div>"



#####################
#####################


echo "<div id='tabella1' class='tab'>"
echo "<h2>EUTRANCELL</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la prima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$8"
echo "</table>"
echo "</div>"




echo "<div id='tabella2' class='tab'>"
echo "<h2>NRCELL</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la seconda tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "$9"
echo "</table>"
echo "</div>"





echo "<div id='tabella3' class='tab'>"
echo "<h2>All Cells</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la terza tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${10}"
echo "</table>"
echo "</div>"






echo "<div id='tabella4' class='tab'>"
echo "<h2>NRCellCU</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la quarta tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${11}"
echo "</table>"
echo "</div>"







echo "<div id='tabella5' class='tab'>"
echo "<h2>Cell Sleep Function</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la quinta tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${12}"
echo "</table>"
echo "</div>"







echo "<div id='tabella6' class='tab'>"
echo "<h2>Alarms</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la sesta tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${13}"
echo "</table>"
echo "</div>"







echo "<div id='tabella7' class='tab'>"
echo "<h2>Upgrade Package</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la settima tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${14}"
echo "</table>"
echo "</div>"






echo "<div id='tabella8' class='tab'>"
echo "<h2>Last CV</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la 8 tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${15}"
echo "</table>"
echo "</div>"







echo "<div id='tabella9' class='tab'>"
echo "<h2>KeyFile Information</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la 9 tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${16}"
echo "</table>"
echo "</div>"



echo "<div id='tabella10' class='tab'>"
echo "<h2>Emergency Unlock</h2>"
echo "<table>"

# Leggi il file CSV linea per linea e costruisci la 10 tabella HTML
while IFS=';' read -r -a row; do
    echo "<tr>"
    for cell in "${row[@]}"; do
        echo "<td>$cell</td>"
    done
    echo "</tr>"
done < "${17}"
echo "</table>"
echo "</div>"

