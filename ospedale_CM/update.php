<?php
session_start();
$table = $_SESSION['table'];

// Connessione al database
$conn = pg_connect("host=localhost port=5432 dbname=ospedale_db user=postgres password=unimi");
if (!$conn) {
    die("Connessione al database fallita.");
}

$error_message = "";
$id = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['update'])) {
        $id = $_POST['id'];

        // Recupera la colonna chiave primaria
        $pk_query = "SELECT column_name FROM information_schema.key_column_usage WHERE table_name = '$table' AND constraint_name = (SELECT constraint_name FROM information_schema.table_constraints WHERE table_name = '$table' AND constraint_type = 'PRIMARY KEY')";
        $pk_result = pg_query($conn, $pk_query);
        if (!$pk_result) {
            die("Errore durante il recupero della chiave primaria: " . pg_last_error($conn));
        }
        $pk = pg_fetch_result($pk_result, 0, 'column_name');

        // Recupera il record da aggiornare
        $query = "SELECT * FROM $table WHERE $pk = '" . pg_escape_string($id) . "'";
        $result = pg_query($conn, $query);
        if (!$result) {
            die("Errore durante il recupero del record: " . pg_last_error($conn));
        }
        $row = pg_fetch_assoc($result);
    } elseif (isset($_POST['save'])) {
        $id = $_POST['id'];

        // Recupera la colonna chiave primaria
        $pk_query = "SELECT column_name FROM information_schema.key_column_usage WHERE table_name = '$table' AND constraint_name = (SELECT constraint_name FROM information_schema.table_constraints WHERE table_name = '$table' AND constraint_type = 'PRIMARY KEY')";
        $pk_result = pg_query($conn, $pk_query);
        if (!$pk_result) {
            die("Errore durante il recupero della chiave primaria: " . pg_last_error($conn));
        }
        $pk = pg_fetch_result($pk_result, 0, 'column_name');

        $columns = array_keys($_POST);
        $values = array_values($_POST);

        // Rimuove 'save' dalle colonne e dai valori
        $save_index = array_search('save', $columns);
        if ($save_index !== false) {
            unset($columns[$save_index]);
            unset($values[$save_index]);
        }

        // Rimuove 'id' dalle colonne e dai valori
        $id_index = array_search('id', $columns);
        if ($id_index !== false) {
            unset($columns[$id_index]);
            unset($values[$id_index]);
        }

        // Costruzione della query di aggiornamento
        $update_list = [];
        foreach ($columns as $index => $column) {
            $update_list[] = "$column = '" . pg_escape_string($values[$index]) . "'";
        }
        $update_list_str = implode(", ", $update_list);

        $query = "UPDATE $table SET $update_list_str WHERE $pk = '" . pg_escape_string($id) . "'";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Record aggiornato con successo.";
            // Reindirizzamento a select.php dopo aver aggiornato con successo il record
            header('Location: update2.php');
            exit; // Assicura che lo script termini qui dopo il reindirizzamento
        } else {
            $error_message = "Alcuni valori inseriti non rispettano i vincoli.";
            header('Location: update.php?id=' . urlencode($id) . '&error=' . urlencode($error_message));
            exit;
        }
    }
} else {
    // Recupera l'id e l'errore dalla query string
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
    }
    if (isset($_GET['error'])) {
        $error_message = $_GET['error'];
    }
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Aggiornamento Record</title>
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <?php
    if ($error_message) {
        echo '<script type="text/javascript">showAlert("' . htmlspecialchars($error_message) . '");</script>';
    }
    ?>
    <h2>Aggiorna il record nella tabella <?php echo htmlspecialchars($table); ?></h2>
    <form action="update.php" method="POST">
        <input type="hidden" name="id" value="<?php echo htmlspecialchars($id); ?>">
        <?php
        if (isset($row)) {
            foreach ($row as $column => $value) {
                echo '<label for="' . htmlspecialchars($column) . '">' . htmlspecialchars($column) . ':</label>';
                echo '<input type="text" name="' . htmlspecialchars($column) . '" id="' . htmlspecialchars($column) . '" value="' . htmlspecialchars($value) . '"><br>';
            }
        }
        ?>
        <input type="submit" name="save" value="Salva">
    </form>
    <button><a href="select.php" style="text-decoration: none;">Torna alla visualizzazione della tabella</a></button>
</body>
</html>

<?php
// Chiusura della connessione al database
pg_close($conn);
?>