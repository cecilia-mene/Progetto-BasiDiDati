<?php
session_start();

if (isset($_POST['table'])) {
    $_SESSION['table'] = $_POST['table'];
}

$table = $_SESSION['table'];

// Connessione al database
$conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
if (!$conn) {
    die("Connessione al database fallita.");
}

$query = "SELECT * FROM $table";
$result = pg_query($conn, $query);
if (!$result) {
    die("Si è verificato un errore.<br>" . pg_last_error($conn));
}

echo '<!DOCTYPE html>';
echo '<html lang="it">';
echo '<head>';
echo '    <meta charset="UTF-8">';
echo '    <title>Selezione Tabella</title>';
echo '    <style>';
echo '        table, th, td {';
echo '            text-align: left;';
echo '            border: 1px solid;';
echo '        }';
echo '    </style>';
echo '</head>';
echo '<body>';

echo '<h2>Tabella ' . $table . '</h2>';
echo '<table>';
$first_row = true;
while ($row = pg_fetch_assoc($result)) {
    if ($first_row) {
        echo '<tr>';
        foreach ($row as $col => $value) {
            echo '<th>' . $col . '</th>';
        }
        echo '<th>Azioni</th>';
        echo '</tr>';
        $first_row = false;
    }
    echo '<tr>';
    foreach ($row as $value) {
        echo '<td>' . $value . '</td>';
    }
    echo '<td>';
    echo '    <form action="update.php" method="POST" style="display:inline;">';
    echo '        <input type="hidden" name="id" value="' . $row[array_keys($row)[0]] . '">';
    echo '        <input type="submit" name="update" value="Modifica">';
    echo '    </form>';
    echo '    <form action="delete.php" method="POST" style="display:inline;">';
    echo '        <input type="hidden" name="id" value="' . $row[array_keys($row)[0]] . '">';
    echo '        <input type="submit" name="delete" value="Elimina">';
    echo '    </form>';
    echo '</td>';
    echo '</tr>';
}
echo '</table>';

echo '<br>';
echo '<form action="ins.php" method="GET">';
echo '    <input type="submit" value="Inserisci un nuovo record">';
echo '</form>';

echo '<form action="menu.php" method="GET">';
echo '    <input type="submit" value="Torna alla selezione delle tabelle">';
echo '</form>';

echo '</body>';
echo '</html>';

// Chiusura della connessione al database
pg_close($conn);
?>
