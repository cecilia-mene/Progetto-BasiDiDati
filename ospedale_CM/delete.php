<?php
session_start();
$table = $_SESSION['table'];

// Connessione al database
$conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
if (!$conn) {
    die("Connessione al database fallita.");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    // Recupera la colonna chiave primaria
    $pk_query = "SELECT column_name FROM information_schema.key_column_usage WHERE table_name = '$table' AND constraint_name = (SELECT constraint_name FROM information_schema.table_constraints WHERE table_name = '$table' AND constraint_type = 'PRIMARY KEY')";
    $pk_result = pg_query($conn, $pk_query);
    if (!$pk_result) {
        die("Errore durante il recupero della chiave primaria: " . pg_last_error($conn));
    }
    $pk = pg_fetch_result($pk_result, 0, 'column_name');

    // Costruzione della query di eliminazione
    $query = "DELETE FROM $table WHERE $pk = '" . pg_escape_string($id) . "'";
    $result = pg_query($conn, $query);

    if (!$result) {
        die("Errore durante l'eliminazione: " . pg_last_error($conn));
    }

    echo "Record eliminato con successo.";
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Eliminazione Record</title>
</head>
<body>
<button><a href="select.php" style="text-decoration: none;">Torna alla visualizzazione della tabella</a></button>
</body>
</html>

<?php
// Chiusura della connessione al database
pg_close($conn);
?>