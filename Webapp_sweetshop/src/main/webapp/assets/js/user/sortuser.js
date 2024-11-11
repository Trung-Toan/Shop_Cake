document.addEventListener("DOMContentLoaded", function () {
    // Lấy tham chiếu đến bảng và tbody
    const table = document.getElementById('userTable');
    const tbody = table.querySelector('tbody');

    // Lấy các dropdown item
    const sortNameAsc = document.querySelector('.dropdown-menu li:nth-child(1) a');
    const sortNameDesc = document.querySelector('.dropdown-menu li:nth-child(2) a');
    const sortPhoneAsc = document.querySelector('.dropdown-menu li:nth-child(3) a');
    const sortPhoneDesc = document.querySelector('.dropdown-menu li:nth-child(4) a');
    const sortDobOldest = document.querySelector('.dropdown-menu li:nth-child(5) a');
    const sortDobYoungest = document.querySelector('.dropdown-menu li:nth-child(6) a');

    // Hàm sắp xếp bảng
    function sortTable(columnIndex, isAscending, isDate = false) {
        const rowsArray = Array.from(tbody.querySelectorAll('tr'));

        rowsArray.sort((rowA, rowB) => {
            const cellA = rowA.cells[columnIndex].textContent.trim();
            const cellB = rowB.cells[columnIndex].textContent.trim();

            if (isDate) {
                // Chuyển chuỗi thành ngày để sắp xếp
                const dateA = new Date(cellA);
                const dateB = new Date(cellB);
                return isAscending ? dateA - dateB : dateB - dateA;
            } else {
                // So sánh chuỗi
                return isAscending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
            }
        });

        // Xóa các hàng cũ và thêm các hàng đã sắp xếp
        tbody.innerHTML = '';
        rowsArray.forEach(row => tbody.appendChild(row));
    }

    // Sắp xếp theo tên (A-Z)
    sortNameAsc.addEventListener('click', () => {
        sortTable(1, true);
    });

    // Sắp xếp theo tên (Z-A)
    sortNameDesc.addEventListener('click', () => {
        sortTable(1, false);
    });

    // Sắp xếp theo số điện thoại (tăng dần)
    sortPhoneAsc.addEventListener('click', () => {
        sortTable(3, true);
    });

    // Sắp xếp theo số điện thoại (giảm dần)
    sortPhoneDesc.addEventListener('click', () => {
        sortTable(3, false);
    });

    // Sắp xếp theo ngày sinh (cũ nhất trước)
    sortDobOldest.addEventListener('click', () => {
        sortTable(2, true, true);
    });

    // Sắp xếp theo ngày sinh (trẻ nhất trước)
    sortDobYoungest.addEventListener('click', () => {
        sortTable(2, false, true);
    });
});
