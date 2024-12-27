<?php
header('Content-Type: application/json');
// Allow CORS for all domains
header('Access-Control-Allow-Origin: *'); // Mengizinkan permintaan dari semua domain
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Metode HTTP yang diperbolehkan
header('Access-Control-Allow-Headers: Content-Type'); // Header yang diperbolehkan

require_once('../inc/config.php'); // Sesuaikan dengan path file konfigurasi database Anda

$statement = $pdo->prepare("SELECT id, photo, heading, content, button_text, button_url, position FROM tbl_slider");
$statement->execute();
$result = $statement->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>