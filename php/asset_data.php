<?php
// filepath: c:\xampp\htdocs\asset\dashboard_data.php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'root', '', 'computer_asset_management');

// จำนวน assets ทั้งหมด
$total = $conn->query("SELECT COUNT(*) AS total FROM assets")->fetch_assoc()['total'];

// ข้อมูลคอมพิวเตอร์ตามแผนก + จำนวนเครื่องอายุ >= 5 ปี
$sql = "
SELECT 
    d.department_id AS id,
    d.department_name_th AS name_th,
    d.department_name_en AS name_en,
    d.cost_center,
    COUNT(a.asset_id) AS count,
    SUM(CASE WHEN t.type_name = 'Desktop' THEN 1 ELSE 0 END) AS desktop,
    SUM(CASE WHEN t.type_name = 'Laptop' THEN 1 ELSE 0 END) AS laptop,
    SUM(CASE WHEN t.type_name = 'Workstation' THEN 1 ELSE 0 END) AS workstation,
    SUM(CASE WHEN s.status_code = 'maintenance' THEN 1 ELSE 0 END) AS maintenance,
    SUM(CASE WHEN a.purchase_date IS NOT NULL AND TIMESTAMPDIFF(YEAR, a.purchase_date, CURDATE()) >= 5 THEN 1 ELSE 0 END) AS old_count
FROM departments d
LEFT JOIN assets a ON a.department_id = d.department_id
LEFT JOIN models m ON a.model_id = m.model_id
LEFT JOIN asset_types t ON m.type_id = t.type_id
LEFT JOIN asset_status s ON a.status_id = s.status_id
GROUP BY d.department_id
ORDER BY count DESC
";
$res = $conn->query($sql);
$departments = [];
while($row = $res->fetch_assoc()) {
    $row['count'] = (int)$row['count'];
    $row['desktop'] = (int)$row['desktop'];
    $row['laptop'] = (int)$row['laptop'];
    $row['workstation'] = (int)$row['workstation'];
    $row['maintenance'] = (int)$row['maintenance'];
    $row['old_count'] = (int)$row['old_count'];
    $departments[] = $row;
}

echo json_encode([
    'total' => $total,
    'departments' => $departments
]);