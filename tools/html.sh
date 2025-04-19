#!/bin/bash

# Contenuto iniziale dell'output HTML
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<title>Ericsson Activity Report</title>"
echo "</head>"


# Stile CSS per le tabelle e i tab
echo "<style>"
echo "body {"
echo "    font-family: Arial, sans-serif;"
echo "    margin: 0;"
echo "    padding: 0;"
echo "    background-color: #f5f5f5;"
echo "}"
echo "h1 {"
echo "    text-align: center;"
echo "    color: #333333;"
echo "}"
echo "p {"
echo "    text-align: center;"
echo "    color: #666666;"
echo "}"
echo "#tabs {"
echo "    padding: 20px;"
echo "    background-color: #ffffff;"
echo "    border-radius: 5px;"
echo "    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);"
echo "    text-align: center;"  # Aggiunta della proprietà per centrare il testo all'interno del container
echo "}"
echo ".tab {"
echo "    display: none;"
echo "}"
echo "table {"
echo "    width: 100%;"
echo "    border-collapse: collapse;"
echo "}"
echo "th, td {"
echo "    border: 1px solid #dddddd;"
echo "    padding: 8px;"
echo "    text-align: left;"
echo "}"
echo "tr:nth-child(even) {"
echo "    background-color: #f2f2f2;"
echo "}"
echo "th {"
echo "    background-color: #4CAF50;"
echo "    color: white;"
echo "}"
echo "tr:first-child {"
echo "    background-color: #1DA1F2;"
echo "    font-weight: bold;"
echo "}"
echo "</style>"




# Script JavaScript per gestire i tab
echo "<script>"
echo "function openTab(tabName) {"
echo "    var i, tabcontent, tablinks;"
echo "    tabcontent = document.getElementsByClassName('tab');"
echo "    for (i = 0; i < tabcontent.length; i++) {"
echo "        tabcontent[i].style.display = 'none';"
echo "    }"
echo "    document.getElementById(tabName).style.display = 'block';"
echo "}"
echo "</script>"

echo "<body>"

echo "<h1>Ericsson Activity Report</h1>"
echo "<p>Check $date_report ( User: $current_user )</p>"
#echo "<p>User $current_user</p>"

# Inizio dei tab
echo "<div id='tabs'>"
echo "<button onclick='openTab(\"tabella1\")'>EUTRANCELL</button>"
echo "<button onclick='openTab(\"tabella2\")'>NRCELL</button>"
echo "<button onclick='openTab(\"tabella3\")'>CELLS</button>"
echo "<button onclick='openTab(\"tabella4\")'>NRCELLCU</button>"
echo "<button onclick='openTab(\"tabella5\")'>CELL SLEEP FUNCTION</button>"
echo "<button onclick='openTab(\"tabella6\")'>ALARMS</button>"
echo "<button onclick='openTab(\"tabella7\")'>UPGRADE PACKAGE</button>"
echo "<button onclick='openTab(\"tabella8\")'>LAST CV</button>"
echo "<button onclick='openTab(\"tabella9\")'>KEYFILE INFORMATION</button>"
# Puoi aggiungere ulteriori pulsanti/tab qui se necessario






# Inizio della prima tabella HTML
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
done < "$1"
echo "</table>"
echo "</div>"



# Inizio della seconda tabella HTML
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
done < "$2"
echo "</table>"
echo "</div>"




# Inizio della terza tabella HTML
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
done < "$3"
echo "</table>"
echo "</div>"





# Inizio della quarta tabella HTML
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
done < "$4"
echo "</table>"
echo "</div>"






# Inizio della quinta tabella HTML
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
done < "$5"
echo "</table>"
echo "</div>"






# Inizio della sesta tabella HTML
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
done < "$6"
echo "</table>"
echo "</div>"






# Inizio della settima tabella HTML
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
done < "$7"
echo "</table>"
echo "</div>"





# Inizio della ottava tabella HTML
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
done < "$8"
echo "</table>"
echo "</div>"






# Inizio della tabella 9 HTML
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
done < "$9"
echo "</table>"
echo "</div>"










# Fine dei tab
echo "</div>"


# Fine della pagina HTML
echo "</body>"
echo "</html>"
