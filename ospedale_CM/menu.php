<?php
session_start();

// Connessione al database
$conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
if (!$conn) {
    die("Connessione al database fallita.");
}

// Query per ottenere i nomi delle tabelle
$query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'";
$result = pg_query($conn, $query);
if (!$result) {
    die("Errore durante il recupero delle tabelle: " . pg_last_error($conn));
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Ospedali</title>
    <style>
        table, th, td {
            text-align: left;
            border: 1px solid;
        }
    </style>
</head>
<body>
    <h2>Seleziona una tabella</h2>
    <form action="select.php" method="POST">
        <label for="table">Tabella:</label>
        <select name="table" id="table">
            <?php
            // Popolamento del menu a discesa con i nomi delle tabelle
            while ($row = pg_fetch_assoc($result)) {
                echo '<option value="' . htmlspecialchars($row['table_name']) . '">' . htmlspecialchars($row['table_name']) . '</option>';
            }
            ?>
        </select>
        <input type="submit" value="Seleziona">
    </form>
</body>
</html>

<?php
// Chiusura della connessione al database
pg_close($conn);
?>