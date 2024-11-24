<!--opt_basic.php-->
<?php
session_start();
$htmlint = <<<NOW
<HTML>
  <HEAD>
    <style>
      table, th, td {
        text-align: left;
        border: 1px solid;
      }
    </style>
  </HEAD>
<BODY> 
NOW;
  $conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
  if (!$conn) {//caso connessione fallita
    echo 'Connessione al database fallita.';
    exit();
  }
  else {
     //Determinare i vice primari che non hanno mai sostituito il proprio primario 
    $query = "SELECT V.CFVicePrimario, V.DataAssunzione
        FROM VicePrimario V
        WHERE V.CFVicePrimario NOT IN (SELECT S.CFVicePrimario FROM Sostituzione S)";
    /*
    //Determinare i vice primari che hanno sostituito almeno due volte il proprio primario
    $query = "SELECT V.CFVicePrimario, COUNT(S.CFPrimario) AS NumSostituzioni
        FROM VicePrimario V
        JOIN Sostituzione S ON V.CFVicePrimario = S.CFVicePrimario
        GROUP BY V.CFVicePrimario
        HAVING COUNT(S.CFPrimario) >= 2";
    //Determinare i vice primari che hanno sostituito esattamente una volta il proprio primario 
    $query = "SELECT V.CFVicePrimario, V.DataAssunzione
        FROM VicePrimario V
        JOIN Sostituzione S ON V.CFVicePrimario = S.CFVicePrimario
        GROUP BY V.CFVicePrimario
        HAVING COUNT(S.CFPrimario) = 1";*/
    $result = pg_query($conn, $query);
    if (!$result) {//la query ha generato errori
        echo "Si è verificato un errore.<br/>";
        echo pg_last_error($conn);
        exit();
    }
    else {//la query non ha generato errori
        print ($htmlint);
        //costruisco una tabella per visualizzare i dati
        echo'<br><table>
             <tr>
                <th>Codice Fiscale Viceprimario</th>
                <th>Numero Sostituzioni</th>

             </tr>';
        while ($row = pg_fetch_array($result)) {
            echo '<tr>
                    <td>' . $row['cfviceprimario'] . '</td> 
                    <td>' . $row['numsostituzioni'] . '</td>           
                  </tr>';
        };
        echo '</table><br>';
    }
}
?>
</BODY>
</HTML>