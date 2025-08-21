<?php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'root', '', 'computer_asset_management');
$dept_id = isset($_GET['department_id']) ? intval($_GET['department_id']) : 0;
$where = $dept_id ? "WHERE a.department_id = $dept_id" : "";

$sql = "
SELECT 
    a.asset_id,
    a.asset_code,
    m.model_name,
    t.type_name,
    t.type_code,
    u.first_name,
    u.last_name,
    a.purchase_date,
    s.status_name,
    s.status_code
FROM assets a
LEFT JOIN models m ON a.model_id = m.model_id
LEFT JOIN asset_types t ON m.type_id = t.type_id
LEFT JOIN asset_status s ON a.status_id = s.status_id
LEFT JOIN users u ON a.user_id = u.user_id
$where
ORDER BY a.asset_id DESC
";
$res = $conn->query($sql);
$data = [];
while($row = $res->fetch_assoc()) $data[] = $row;
echo json_encode($data);