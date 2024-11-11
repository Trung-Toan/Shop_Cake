document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('form');
    const imageInput = document.getElementById('file-upload'); // Sử dụng input file có sẵn đã ẩn

    // Thêm sự kiện cho việc tải ảnh
    imageInput.addEventListener('change', handleImageUpload);

    // Khi nhấn vào nút Upload sẽ mở hộp thoại chọn file
    form.querySelector('.btn-primary').addEventListener('click', function () {
        imageInput.click(); // Kích hoạt hộp thoại chọn file
    });

    // Kiểm tra và gửi form
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        if (validateForm()) {
            form.submit(); // Gửi form nếu tất cả các điều kiện đều hợp lệ
        }
    });

    // Kiểm tra và hiển thị thông báo lỗi khi người dùng nhập từng giá trị
    const fields = ['fullname', 'dob', 'address', 'mobno', 'email', 'uname'];
    fields.forEach(field => {
        const input = document.getElementById(field);
        input.addEventListener('input', function () {
            validateField(field);
        });
    });
});

function handleImageUpload(event) {
    const file = event.target.files[0]; // Lấy tệp người dùng đã chọn
    const fileError = document.getElementById('fileError'); // Vùng hiển thị lỗi
    const imgPreview = document.getElementById('previewImage'); // Ảnh xem trước

    if (file) {
        // Kiểm tra xem tệp có phải định dạng JPG hay không
        if (file.type === 'image/jpeg' || file.type === 'image/jpg') {
            const reader = new FileReader(); // Đối tượng FileReader để đọc tệp

            reader.onload = function (e) {
                imgPreview.src = e.target.result; // Cập nhật hình ảnh xem trước với tệp mới
                fileError.style.display = 'none'; // Xóa thông báo lỗi nếu tệp hợp lệ
            };

            reader.readAsDataURL(file); // Đọc tệp dưới dạng URL dữ liệu
        } else {
            // Hiển thị thông báo lỗi nếu định dạng tệp không đúng
            fileError.textContent = 'Please upload a valid JPG image.';
            fileError.style.display = 'block';
        }
    } else {
        // Xóa thông báo lỗi nếu không có tệp được chọn
        fileError.style.display = 'none';
    }
}

function validateForm() {
    let isValid = true;
    const fields = ['fullname', 'dob', 'address', 'mobno', 'email', 'uname'];

    fields.forEach(field => {
        const fieldValid = validateField(field);
        if (!fieldValid) {
            isValid = false;
        }
    });

    return isValid;
}

function validateField(field) {
    let isValid = true;

    // Lấy phần tử và thông báo lỗi tương ứng
    const input = document.getElementById(field);
    const errorDisplay = document.getElementById(`${field}Error`);

    // Trim giá trị nhập vào
    const value = input.value.trim();

    switch (field) {
        case 'fullname':
            const fullnameRegex = /^[a-zA-Z\s]*$/;
            if (!value || !fullnameRegex.test(value) || value.length > 30) {
                errorDisplay.textContent = 'Full name must contain only letters and be up to 30 characters.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;

        case 'dob':
            const selectedDate = new Date(value);
            const today = new Date();
            if (!value || selectedDate >= today) {
                errorDisplay.textContent = 'Date of birth must be before today.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;

        case 'address':
            if (value.length > 200) {
                errorDisplay.textContent = 'Address cannot exceed 200 characters.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;

        case 'mobno':
            const mobnoRegex = /^0\d{9}$/; // Định dạng: 10 chữ số bắt đầu bằng 0
            if (!value || !mobnoRegex.test(value)) {
                errorDisplay.textContent = 'Mobile number must be 10 digits starting with 0.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;

        case 'email':
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!value || !emailRegex.test(value)) {
                errorDisplay.textContent = 'Please enter a valid email address.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;

        case 'uname':
            if (!value || value.length > 15 || /\s/.test(value)) {
                errorDisplay.textContent = 'Username must be up to 15 characters and contain no spaces.';
                errorDisplay.style.display = 'block';
                isValid = false;
            } else {
                errorDisplay.style.display = 'none';
            }
            break;
        //
        // case 'pass':
        //     // Kiểm tra độ dài và bắt đầu bằng space
        //     if (value.length < 6 || value.startsWith(' ')) {
        //         errorDisplay.textContent = 'Password must be at least 6 characters and not start with a space.';
        //         errorDisplay.style.display = 'block';
        //         isValid = false;
        //     } else {
        //         errorDisplay.style.display = 'none';
        //     }
        //     break;
        //
        // case 'rpass':
        //     // Kiểm tra xem mật khẩu xác nhận có khớp với mật khẩu không
        //     const pass = document.getElementById('pass').value.trim();
        //     if (value !== pass) {
        //         errorDisplay.textContent = 'Repeat password must match the password.';
        //         errorDisplay.style.display = 'block';
        //         isValid = false;
        //     } else {
        //         errorDisplay.style.display = 'none';
        //     }
        //     break;
    }

    return isValid;
}