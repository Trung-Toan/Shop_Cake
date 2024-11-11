document.addEventListener("DOMContentLoaded", function() {
    // Lấy tất cả các liên kết trong sidebar
    const sidebarLinks = document.querySelectorAll(".sidebar-link");
    const currentPage = window.location.pathname;

    // Duyệt qua tất cả các liên kết trong sidebar
    sidebarLinks.forEach(link => {
        // Kiểm tra xem liên kết có khớp với trang hiện tại không
        if (link.getAttribute("href") === currentPage) {
            // Thêm class 'active' vào liên kết tương ứng
            link.classList.add("active");

            // Tìm và thêm 'active' cho các sidebar-item cha
            const sidebarItem = link.closest(".sidebar-item");
            if (sidebarItem) {
                sidebarItem.classList.add("active");
            }

            // Nếu liên kết nằm trong một dropdown, mở dropdown cha
            const parentDropdown = link.closest(".collapse");
            if (parentDropdown) {
                parentDropdown.classList.add("show");

                // Đánh dấu liên kết cha (dropdown toggle) là 'active'
                const parentLink = parentDropdown.previousElementSibling;
                if (parentLink) {
                    parentLink.classList.add("active");
                    parentLink.classList.remove("collapsed"); // Đảm bảo dropdown không bị thu gọn
                }

                // Đánh dấu mục cha của dropdown là 'active'
                const sidebarItemParent = parentLink.closest(".sidebar-item");
                if (sidebarItemParent) {
                    sidebarItemParent.classList.add("active");
                }
            }
        }
    });

    // Xử lý trạng thái của dropdown sau khi tải lại trang
    const dropdownLinks = document.querySelectorAll("[data-bs-toggle='collapse']");

    // Duyệt qua tất cả các liên kết có chức năng dropdown
    dropdownLinks.forEach(link => {
        const dropdown = document.querySelector(link.getAttribute("data-bs-target"));

        // Kiểm tra xem dropdown có đang mở hay không
        if (dropdown && dropdown.classList.contains("show")) {
            link.classList.remove("collapsed");
            link.classList.add("active");
        }

        // Thêm sự kiện click để thay đổi trạng thái của dropdown
        link.addEventListener("click", function() {
            const isCollapsed = link.classList.contains("collapsed");

            // Đảm bảo chỉ một dropdown mở tại một thời điểm
            dropdownLinks.forEach(otherLink => {
                if (otherLink !== link) {
                    otherLink.classList.add("collapsed");
                    otherLink.classList.remove("active");
                }
            });

            // Toggle trạng thái 'active'
            link.classList.toggle("active", isCollapsed);
        });
    });
});