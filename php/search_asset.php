<?php
header('Content-Type: application/json');
require_once 'db_connect.php'; // สร้างไฟล์นี้แยกไว้สำหรับเชื่อมต่อ DB

$q = isset($_GET['q']) ? trim($_GET['q']) : '';
if ($q === '') {
    echo json_encode(['success' => false, 'message' => 'No query']);
    exit;
}

// ตัวอย่าง query (ปรับตามโครงสร้างตารางจริง)
$sql = "SELECT * FROM assets 
        WHERE asset_no LIKE ? 
           OR com_name LIKE ? 
           OR st LIKE ? 
           OR sn LIKE ? 
        LIMIT 1";
$stmt = $conn->prepare($sql);
$like = "%$q%";
$stmt->bind_param("ssss", $like, $like, $like, $like);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    echo json_encode(['success' => true, 'data' => $row]);
} else {
    echo json_encode(['success' => false, 'message' => 'ไม่พบข้อมูล']);
}
?>
