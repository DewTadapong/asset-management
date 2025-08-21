<?php
$pdo = new PDO("mysql:host=localhost;dbname=computer_asset_management", "root", "");
$sql = "SELECT a.*, d.department_name_th AS department
        FROM assets a
        LEFT JOIN departments d ON a.department_id = d.department_id";
$stmt = $pdo->query($sql);

$grouped = [];

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $purchaseDate = new DateTime($row['purchase_date']);
    $today = new DateTime();
    $age = $today->diff($purchaseDate)->y;

    $department = $row['department']; // ได้ชื่อแผนกจาก JOIN

    // รวมกลุ่มตามอายุและแผนก
    if (!isset($grouped[$age])) {
        $grouped[$age] = [];
    }

    if (!isset($grouped[$age][$department])) {
        $grouped[$age][$department] = 0;
    }

    $grouped[$age][$department]++;
}
?>
