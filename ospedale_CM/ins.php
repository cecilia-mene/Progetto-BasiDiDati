<?php
session_start();

if (isset($_POST['table'])) {
    $_SESSION['table'] = $_POST['table'];
}

$table = $_SESSION['table'];
// Disabilita la visualizzazione del warning
ini_set('display_errors', 0);
error_reporting(0);

$conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
if (!$conn) {
    echo "<script>alert('Connessione al database fallita.');</script>";
    exit();
}

$inserimento_successo = null;
$errore_inserimento = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['toinsert'])) {
    if ($table === 'Primario') {
        $cfPrimario = isset($_POST['cfPrimario']) ? pg_escape_string($conn, $_POST['cfPrimario']) : NULL;
        $nomeReparto = isset($_POST['nomeReparto']) ? pg_escape_string($conn, $_POST['nomeReparto']) : NULL;
        $codiceOspedale = isset($_POST['codiceOspedale']) ? pg_escape_string($conn, $_POST['codiceOspedale']) : NULL;

        // Controlla se esiste già una riga con lo stesso nomeReparto e codiceOspedale
        $checkQuery = "SELECT 1 FROM Primario WHERE nomeReparto = '$nomeReparto' AND codiceOspedale = '$codiceOspedale'";
        $checkResult = pg_query($conn, $checkQuery);

        if (pg_num_rows($checkResult) > 0) {
            $errore_inserimento = "Errore: Esiste già un primario con lo stesso nome reparto e codice ospedale.";
        } else {
            // Verifica se il CF inserito appartiene a un personale medico
            $checkQueryPersonale = "SELECT 1 FROM personale WHERE cf = '$cfPrimario' AND tipoPersonale = 'personale medico'";
            $checkResultPersonale = pg_query($conn, $checkQueryPersonale);

            if (!$checkResultPersonale || pg_num_rows($checkResultPersonale) == 0) {
                $errore_inserimento = "Errore: Il CF inserito non appartiene a un personale medico.";
            } else {
                // Esegue l'inserimento nella tabella Primario
                $query = "INSERT INTO Primario (cfPrimario, nomeReparto, codiceOspedale) VALUES ('$cfPrimario', '$nomeReparto', '$codiceOspedale')";
                $result = pg_query($conn, $query);

                if ($result) {
                    $inserimento_successo = true;
                } else {
                    $errore_inserimento = "Si è verificato un errore: " . pg_last_error($conn);
                }
            }
        }
    } elseif ($table === 'VicePrimario') {
        $cfVicePrimario = isset($_POST['cfVicePrimario']) ? pg_escape_string($conn, $_POST['cfVicePrimario']) : NULL;
        $dataAssunzione = isset($_POST['dataAssunzione']) ? pg_escape_string($conn, $_POST['dataAssunzione']) : NULL;
        $nomeReparto = isset($_POST['nomeReparto']) ? pg_escape_string($conn, $_POST['nomeReparto']) : NULL;
        $codiceOspedale = isset($_POST['codiceOspedale']) ? pg_escape_string($conn, $_POST['codiceOspedale']) : NULL;

        $checkQuery = "SELECT 1 FROM personale WHERE cf = '$cfVicePrimario' AND tipoPersonale = 'personale medico'";
        $checkResult = pg_query($conn, $checkQuery);

        if (!$checkResult || pg_num_rows($checkResult) == 0) {
            $errore_inserimento = "Errore: Il CF inserito non appartiene a un personale medico.";
        } else {
            $query = "INSERT INTO VicePrimario (cfVicePrimario, dataAssunzione, nomeReparto, codiceOspedale) VALUES ('$cfVicePrimario', '$dataAssunzione', '$nomeReparto', '$codiceOspedale')";
            $result = pg_query($conn, $query);

            if ($result) {
                $inserimento_successo = true;
            } else {
                $errore_inserimento = "Si è verificato un errore: " . pg_last_error($conn);
            }
        }
    } elseif ($table === 'TurniPS') {
        $CodiceOspedale = isset($_POST['CodiceOspedale']) ? pg_escape_string($conn, $_POST['CodiceOspedale']) : NULL;
        $IndirizzoPS = isset($_POST['IndirizzoPS']) ? pg_escape_string($conn, $_POST['IndirizzoPS']) : NULL;
        $CFPersonale = isset($_POST['CFPersonale']) ? pg_escape_string($conn, $_POST['CFPersonale']) : NULL;
        $oraInizio = isset($_POST['OraInizio']) ? pg_escape_string($conn, $_POST['OraInizio']) : NULL;
        $oraFine = isset($_POST['OraFine']) ? pg_escape_string($conn, $_POST['OraFine']) : NULL;

        $checkQuery = "SELECT 1 FROM personale WHERE cf = '$CFPersonale' AND (tipoPersonale = 'infermiere' OR tipoPersonale = 'personale medico')";
        $checkResult = pg_query($conn, $checkQuery);

        if (!$checkResult || pg_num_rows($checkResult) == 0) {
            $errore_inserimento = "Errore: Il CF inserito non appartiene a un infermiere o personale medico.";
        } else {
            $query = "INSERT INTO TurniPS (CodiceOspedale, IndirizzoPS, CFPersonale, OraInizio, OraFine) VALUES ('$CodiceOspedale', '$IndirizzoPS', '$CFPersonale', '$oraInizio', '$oraFine')";
            $result = pg_query($conn, $query);

            if ($result) {
                $inserimento_successo = true;
            } else {
                $errore_inserimento = "Si è verificato un errore: " . pg_last_error($conn);
            }
        }
    } elseif ($table === 'Sostituzione') {
        $cfPrimario = isset($_POST['cfPrimario']) ? pg_escape_string($conn, $_POST['cfPrimario']) : NULL;
        $cfVicePrimario = isset($_POST['cfVicePrimario']) ? pg_escape_string($conn, $_POST['cfVicePrimario']) : NULL;
        $dataInizio = isset($_POST['dataInizio']) ? pg_escape_string($conn, $_POST['dataInizio']) : NULL;
        $dataFine = isset($_POST['dataFine']) ? pg_escape_string($conn, $_POST['dataFine']) : NULL;

        // Verifica che CFPrimario esista nella tabella Primario
        $checkPrimarioQuery = "SELECT NomeReparto, CodiceOspedale FROM Primario WHERE CFPrimario = '$cfPrimario'";
        $checkPrimarioResult = pg_query($conn, $checkPrimarioQuery);

        if (!$checkPrimarioResult || pg_num_rows($checkPrimarioResult) == 0) {
            $errore_inserimento = "Errore: Il CF del Primario inserito non esiste.";
        } else {
            $primarioData = pg_fetch_assoc($checkPrimarioResult);
            $nomeRepartoPrimario = $primarioData['NomeReparto'];
            $codiceOspedalePrimario = $primarioData['CodiceOspedale'];

            // Verifica che CFVicePrimario esista nella tabella VicePrimario e appartenga allo stesso reparto e ospedale
            $checkVicePrimarioQuery = "
                SELECT NomeReparto, CodiceOspedale 
                FROM VicePrimario 
                WHERE CFVicePrimario = '$cfVicePrimario' 
                  AND NomeReparto = '$nomeRepartoPrimario' 
                  AND CodiceOspedale = '$codiceOspedalePrimario'
            ";
            $checkVicePrimarioResult = pg_query($conn, $checkVicePrimarioQuery);

            if (!$checkVicePrimarioResult || pg_num_rows($checkVicePrimarioResult) == 0) {
                $errore_inserimento = "Errore: Il CF del Vice Primario inserito non esiste o non appartiene allo stesso reparto e ospedale del Primario.";
            } else {
                // Controllo della coerenza delle date
                if (strtotime($dataInizio) >= strtotime($dataFine)) {
                    $errore_inserimento = "Errore: La data di inizio deve essere precedente alla data di fine.";
                } else {
                    // Esegue l'inserimento nella tabella Sostituzione
                    $query = "
                        INSERT INTO Sostituzione (CFPrimario, CFVicePrimario, DataInizio, DataFine) 
                        VALUES ('$cfPrimario', '$cfVicePrimario', '$dataInizio', '$dataFine')
                    ";
                    $result = pg_query($conn, $query);

                    if ($result) {
                        $inserimento_successo = true;
                    } else {
                        $errore_inserimento = "Si è verificato un errore: " . pg_last_error($conn);
                    }
                }
            }
        }
    } else {
        unset($_POST['toinsert']);
        $columns = array_keys($_POST);
        $values = array_values($_POST);

        $columns_list = implode(", ", $columns);
        $values_list = implode(", ", array_map(function ($value) use ($conn) {
            return "'" . pg_escape_string($conn, $value) . "'";
        }, $values));

        $query = "INSERT INTO $table ($columns_list) VALUES ($values_list)";
        $result = pg_query($conn, $query);

        if ($result) {
            $inserimento_successo = true;
        } else {
            $errore_inserimento = "Errore durante l'inserimento: il valore che hai provato ad inserire non è valido";
        }
    }
}

$columns_query = "SELECT column_name FROM information_schema.columns WHERE table_name = '$table'";
$columns_result = pg_query($conn, $columns_query);
if (!$columns_result) {
    die("Errore durante il recupero delle colonne: " . pg_last_error($conn));
}

?>
<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <title>Inserimento Record</title>
    <script>
        <?php
        if (isset($inserimento_successo)) {
            if ($inserimento_successo === true) {
                echo "alert('Record inserito con successo.');";
            } elseif ($inserimento_successo === false) {
                echo "alert('$errore_inserimento');";
            }
        }
        ?>
    </script>
</head>

<body>
    <h2>Inserisci un nuovo record nella tabella <?php echo htmlspecialchars($table); ?></h2>
    <form action="ins.php" method="POST">
        <?php
        while ($column = pg_fetch_assoc($columns_result)) {
            echo '<label for="' . htmlspecialchars($column['column_name']) . '">' . htmlspecialchars($column['column_name']) . ':</label>';
            echo '<input type="text" name="' . htmlspecialchars($column['column_name']) . '" id="' . htmlspecialchars($column['column_name']) . '"><br>';
        }
        ?>
        <input type="submit" name="toinsert" value="Inserisci">
    </form>
    <button><a href="select.php" style="text-decoration: none;">Torna alla visualizzazione della tabella</a></button>
</body>

</html>
<?php
pg_close($conn);
?>