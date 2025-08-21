<?php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'root', '', 'computer_asset_management');
$q = isset($_GET['q']) ? $_GET['q'] : '';
$sql = "SELECT department_id, department_name_th, department_name_en, cost_center 
        FROM departments 
        WHERE department_name_th LIKE ? OR department_name_en LIKE ? OR cost_center LIKE ? 
        ORDER BY department_name_th LIMIT 10";
$stmt = $conn->prepare($sql);
$like = "%$q%";
$stmt->bind_param('sss', $like, $like, $like);
$stmt->execute();
$res = $stmt->get_result();
$data = [];
while($row = $res->fetch_assoc()) $data[] = $row;
echo json_encode($data);