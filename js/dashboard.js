document.addEventListener('DOMContentLoaded', function() {
    const deptInput = document.getElementById('filterDeptInput');
    const deptSuggest = document.getElementById('deptSuggest');
    let selectedDeptId = 0;
    let allDepartments = [];
    let currentPage = 1;
    const pageSize = 10;

    // Autocomplete แผนก (ไทย/อังกฤษ/cost center)
    deptInput.addEventListener('input', function() {
        const q = this.value.trim();
        if (!q) {
            deptSuggest.classList.add('hidden');
            return;
        }
        fetch('php/search_department.php?q=' + encodeURIComponent(q))
            .then(res => res.json())
            .then(data => {
                if (data.length === 0) {
                    deptSuggest.innerHTML = '<div class="px-3 py-2 text-gray-400">ไม่พบแผนก</div>';
                } else {
                    deptSuggest.innerHTML = data.map(d =>
                        `<div class="px-3 py-2 hover:bg-indigo-100 cursor-pointer" data-id="${d.department_id}" data-name="${d.department_name_th}" data-en="${d.department_name_en}" data-cost="${d.cost_center}">
                            ${d.department_name_th} (${d.department_name_en})
                        </div>`
                    ).join('');
                }
                deptSuggest.classList.remove('hidden');
            });
    });

    deptSuggest.addEventListener('click', function(e) {
        if (e.target.dataset.id) {
            deptInput.value = `${e.target.dataset.name} (${e.target.dataset.en}) [${e.target.dataset.cost}]`;
            selectedDeptId = e.target.dataset.id;
            deptSuggest.classList.add('hidden');
            // โหลดข้อมูลเฉพาะแผนก
            fetch('php/asset_data.php')
                .then(res => res.json())
                .then(data => {
                    allDepartments = data.departments.filter(d => d.id == selectedDeptId);
                    renderDepartmentTableWithPagination(1);
                });
            document.getElementById('filterInfo').textContent = `กำลังแสดงข้อมูลแผนก: ${e.target.dataset.name}`;
        }
    });

    document.addEventListener('click', function(e) {
        if (!deptInput.contains(e.target) && !deptSuggest.contains(e.target)) {
            deptSuggest.classList.add('hidden');
        }
    });

    // โหลดข้อมูลทุกแผนก (default)
    fetch('php/asset_data.php')
        .then(res => res.json())
        .then(data => {
            allDepartments = data.departments;
            renderDepartmentTableWithPagination(1);
            // เพิ่มบรรทัดนี้!
            document.getElementById('totalAssets').textContent = data.total || 0;
        });

    function renderDepartmentTableWithPagination(page = 1) {
        currentPage = page;
        const total = allDepartments.length;
        const totalPages = Math.ceil(total / pageSize);
        const start = (page - 1) * pageSize;
        const end = Math.min(start + pageSize, total);
        const departments = allDepartments.slice(start, end);

        let html = '';
        departments.forEach(dept => {
            let typeText = [];
            if (dept.desktop > 0) typeText.push(`Desktop (${dept.desktop})`);
            if (dept.laptop > 0) typeText.push(`Laptop (${dept.laptop})`);
            if (dept.workstation > 0) typeText.push(`Workstation (${dept.workstation})`);

            html += `
            <tr class="hover:bg-gray-50">
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-10 w-10 flex items-center justify-center bg-indigo-100 rounded-lg">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z" />
                            </svg>
                        </div>
                        <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900">${dept.name_th} (${dept.name_en})</div>
                            <div class="text-sm text-gray-500">${dept.cost_center || ''}</div>
                        </div>
                    </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${dept.count}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${typeText.join(', ')}</div>
                </td>
 
                <td class="px-6 py-4 whitespace-nowrap text-center">
                    ${
                        dept.old_count > 0
                        ? `<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                หมดอายุ ${dept.old_count} เครื่อง
                           </span>`
                        : `<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                ยังไม่หมดอายุ
                           </span>`
                    }
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <button class="text-indigo-600 hover:text-indigo-900 view-details" data-dept="${dept.id}">ดูรายละเอียด</button>
                </td>
            </tr>
            `;
        });
        document.getElementById('departmentTable').innerHTML = html;

        // ข้อความแสดงจำนวน
        document.getElementById('deptTableInfo').textContent = `แสดง ${total === 0 ? 0 : start + 1} - ${end} จาก ${total} แผนก`;

        // สร้างปุ่ม pagination
        let paginationHtml = '';
        paginationHtml += `<button class="px-3 py-1 border rounded-l-lg bg-gray-100" ${page === 1 ? 'disabled' : ''} id="prevPageBtn">ก่อนหน้า</button>`;
        for (let i = 1; i <= totalPages; i++) {
            paginationHtml += `<button class="px-3 py-1 border-t border-b ${i === page ? 'bg-indigo-600 text-white' : ''}" data-page="${i}">${i}</button>`;
        }
        paginationHtml += `<button class="px-3 py-1 border rounded-r-lg bg-gray-100" ${page === totalPages ? 'disabled' : ''} id="nextPageBtn">ถัดไป</button>`;
        document.getElementById('deptTablePagination').innerHTML = paginationHtml;

        // Attach event
        document.getElementById('prevPageBtn')?.addEventListener('click', () => renderDepartmentTableWithPagination(page - 1));
        document.getElementById('nextPageBtn')?.addEventListener('click', () => renderDepartmentTableWithPagination(page + 1));
        document.querySelectorAll('[data-page]').forEach(btn => {
            btn.addEventListener('click', function() {
                renderDepartmentTableWithPagination(Number(this.dataset.page));
            });
        });

        // Attach event ปุ่มดูรายละเอียด
        attachDetailButtonListeners();
    }

    // ฟังก์ชัน render ตาราง
    function renderDepartmentTable(departments) {
        const tableBody = document.getElementById('departmentTable');
        let html = '';
        departments.forEach(dept => {
            // ประเภท
            let typeText = [];
            if (dept.desktop > 0) typeText.push(`Desktop (${dept.desktop})`);
            if (dept.laptop > 0) typeText.push(`Laptop (${dept.laptop})`);
            if (dept.workstation > 0) typeText.push(`Workstation (${dept.workstation})`);
     
            html += `
            <tr class="hover:bg-gray-50">
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-10 w-10 flex items-center justify-center bg-indigo-100 rounded-lg">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z" />
                            </svg>
                        </div>
                        <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900">${dept.name_th} (${dept.name_en}) [${dept.cost_center}]</div>
                            <div class="text-sm text-gray-500">${dept.location || ''}</div>
                        </div>
                    </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${dept.count}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${typeText.join(', ')}</div>
                </td>


                
                <td class="px-6 py-4 whitespace-nowrap text-center">
                    ${
                        dept.old_count > 0
                        ? `<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                หมดอายุ ${dept.old_count} เครื่อง
                           </span>`
                        : `<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                ยังไม่หมดอายุ
                           </span>`
                    }
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <button class="text-indigo-600 hover:text-indigo-900 view-details" data-dept="${dept.id}">ดูรายละเอียด</button>
                </td>
            </tr>
            `;
        });
        document.getElementById('departmentTable').innerHTML = html;
        attachDetailButtonListeners(); // <<-- สำคัญ!
    }

    function attachDetailButtonListeners() {
        document.querySelectorAll('.view-details').forEach(btn => {
            btn.addEventListener('click', function() {
                const deptId = this.getAttribute('data-dept');
                // ดึงข้อมูลแผนกจาก API หรือใช้ฟังก์ชัน updateDepartmentData(deptId)
                document.getElementById('modalTitle').textContent = `รายละเอียดคอมพิวเตอร์แผนก`;
                document.getElementById('detailModal').classList.remove('hidden');
                // เรียก updateDepartmentData(deptId) เพื่อแสดงข้อมูลใน modal
                if (typeof updateDepartmentData === 'function') updateDepartmentData(deptId);
            });
        });
    }

    // เรียกใช้ฟังก์ชันแนบลิสเตนเนอร์
    attachDetailButtonListeners();

    document.getElementById('clearDeptBtn').addEventListener('click', function() {
        document.getElementById('filterDeptInput').value = '';
        selectedDeptId = 0;
        document.getElementById('filterInfo').textContent = 'กำลังแสดงข้อมูลทั้งหมด';
        // โหลดข้อมูลทุกแผนกใหม่
        fetch('php/asset_data.php')
            .then(res => res.json())
            .then(data => {
                renderDepartmentTable(data.departments);
                attachDetailButtonListeners(); // <<-- สำคัญ!
            });
    });

    // ปิด modal
    document.getElementById('closeModal').addEventListener('click', function() {
        document.getElementById('detailModal').classList.add('hidden');
    });


    // ฟังก์ชันสำหรับอัพเดตข้อมูลคอมพิวเตอร์ใน modal
    function updateDepartmentData(deptId) {
        fetch('php/assets_by_department.php?department_id=' + deptId)
            .then(res => res.json())
            .then(data => {
                document.getElementById('totalComputers').textContent = data.length;
                document.getElementById('normalComputers').textContent = data.filter(a => a.status_code === 'normal').length;
                document.getElementById('timeoutdevice').textContent = data.filter(asset => {
                if (!asset.purchase_date) return false;
                const purchaseDate = new Date(asset.purchase_date);
                const age = new Date().getFullYear() - purchaseDate.getFullYear();
                return age >= 5;
                }).length;

             // document.getElementById('maintenanceComputers').textContent = data.filter(a => a.status_code === 'maintenance').length;

                let html = '';
                data.forEach(asset => {
                    const age = asset.purchase_date ? calculateAge(asset.purchase_date) : '-';
                    
                    html += `
                    <tr class="hover:bg-gray-50">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${asset.asset_code || '-'}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${asset.type_name || '-'}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${asset.model_name || '-'}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${asset.first_name ? asset.first_name + ' ' + (asset.last_name || '') : '-'}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${asset.purchase_date || '-'}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${asset.status_code === 'normal' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}">
                                ${asset.status_name || '-'}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                ${age !== '-' && age >= 5 ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">
                                ${age !== '-' ? age + ' ปี' : '-'}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <button class="text-indigo-600 hover:text-indigo-900 view-computer-details" data-id="${asset.asset_id}">รายละเอียด</button>
                        </td>
                    </tr>
                    `;
                });
                document.getElementById('computerDetailTable').innerHTML = html;
            });
    } 

    // ฟังก์ชันสำหรับคำนวณอายุของคอมพิวเตอร์ ใน modal 
    function calculateAge(purchaseDateStr) {
    const purchaseDate = new Date(purchaseDateStr);
    const now = new Date();
    let years = now.getFullYear() - purchaseDate.getFullYear();
    const hasHadBirthdayThisYear =
        now.getMonth() > purchaseDate.getMonth() ||
        (now.getMonth() === purchaseDate.getMonth() && now.getDate() >= purchaseDate.getDate());
    if (!hasHadBirthdayThisYear) years--;
    return years;
}

});

