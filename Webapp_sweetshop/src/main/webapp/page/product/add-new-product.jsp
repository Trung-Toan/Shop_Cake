<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Add New Product</title>
    <link class="js-stylesheet" href="../../assets/css/light.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        #sidebar {
            height: 100% !important;
        }

        .product {
            width: 100%;
            max-width: 600px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: bold;
        }

        input:focus,
        textarea:focus,
        select:focus {
            box-shadow: none;
            border-color: #ffc107;
        }

        .border-custom {
            border: 1px solid #ffc107;
            border-radius: 8px;
        }

        .error-message {
            font-size: 0.875em;
            margin-top: 0.25rem;
            color: red;
        }
    </style>
</head>

<body style="display: flex; flex-direction: column">

<%--<jsp:include page="header.jsp"/>--%>

<div class="flex: 1; row">
    <div class="col-md-2">
        <jsp:include page="../common/sidebar.jsp"/>
    </div>
    <div class="col-md-10">
        <jsp:include page="../common/navbar.jsp" />
        <div class="">
            <div class="row mt-3">
                <div class="col-md-9"></div>
                <c:if test="${mess != null && !mess.equals('')}">
                    <div class="col-md-3 alert alert-${type.equals("success") ? "success" : "danger"} alert-dismissible order-md-last">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <strong>${type.equals("success") ? "Success" : "Error"}!</strong> ${mess}
                    </div>
                </c:if>
            </div>
            <div class="d-flex justify-content-center mt-2">
                <div class="product p-4">
                    <h3 class="text-center text-warning mb-4">Add New Product</h3>
                    <div class="p-4 border-custom">
                        <form action="add_new_product" method="post" id="productForm" enctype="multipart/form-data" onsubmit="return validateProductForm(event)" novalidate>
                            <div class="mb-3">
                                <label for="name" class="form-label">Product Name <span style="color: red">*</span></label>
                                <input type="text" class="form-control" id="name" name="productName" placeholder="Enter product name" value="${productName != null && !productName.equals("") ? productName : ""}">
                                <span class="error-message" id="nameError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="category" class="form-label">Category <span style="color: red">*</span></label>
                                <select class="form-select" name="productCategory" id="category" required>
                                    <option value="" disabled selected>Select a category</option>
                                    <c:forEach var="c" items="${categoryList}">
                                        <option value="${c.id}" ${productCategory != null && !productCategory.equals("") && productCategory.equals(c.id + "") ? "selected" : ""} >${c.name}</option>
                                    </c:forEach>
                                </select>
                                <span class="error-message" id="categoryError"></span>
                            </div>
                            <div class="mb-3">
                                <label for="imageFile" class="form-label">Choose images:</label>
                                <input type="file" name="imageFile" id="imageFile" accept="image/*" multiple class="form-control">
                                <span class="error-message" id="imageFileError"></span>
                            </div>

                            <div class="product_detail p-2 border-custom mb-3">
                                <h5 class="text-warning">Product Details</h5>
                                <div id="pd">
                                    <c:forEach var="i" begin="0" end="${loop == null ? 0 : loop}">
                                        <div class="p-2 row mb-3 d-flex justify-content-between align-items-center">
                                            <div class="col-md-6 col-sm-12 mb-2 mb-md-0">
                                                <label class="form-label">Price <span style="color: red">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" name="productPrice" value="${productSize != null && productPrice[i] != null && !productPrice[i].equals("") ? productPrice[i] : ""}" step="0.01" class="form-control" placeholder="Enter price">
                                                    <span class="input-group-text">vnd</span>
                                                </div>
                                                <span class="error-message priceError"></span>
                                            </div>

                                            <div class="col-md-6 col-sm-12">
                                                <label class="form-label">Size <span style="color: red">*</span></label>
                                                <select name="productSize" class="form-select">
                                                    <option value="" disabled selected>Select a size</option>
                                                    <option value="Small" ${productSize != null && productSize[i] != null && !productSize[i].equals("") && productSize[i].equals("Small") ? "selected" : ""}>Small</option>
                                                    <option value="Medium" ${productSize != null && productSize[i] != null && !productSize[i].equals("") && productSize[i].equals("Medium") ? "selected" : ""}>Medium</option>
                                                    <option value="Large" ${productSize != null && productSize[i] != null && !productSize[i].equals("") && productSize[i].equals("Large") ? "selected" : ""}>Large</option>
                                                    <option value="Extra Large" ${productSize != null && productSize[i] != null && !productSize[i].equals("") && productSize[i].equals("Extra Large") ? "selected" : ""}>Extra Large</option>
                                                </select>
                                                <span class="error-message sizeError"></span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <button type="button" class="btn btn-warning text-light" onclick="addMoreProductDetail()">+</button>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="ingredient" class="form-label">Ingredient <span style="color: red">*</span></label>
                                <textarea class="form-control" id="ingredient" name="productIngredient" rows="3" placeholder="Enter ingredients">${productIngredient == null || productIngredient.equals("") ? "" : productIngredient}</textarea>
                                <span class="error-message" id="ingredientError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description <span style="color: red">*</span></label>
                                <textarea class="form-control" id="description" name="productDescription" rows="3" placeholder="Enter description">${productDescription == null || productDescription.equals("") ? "" : productDescription}</textarea>
                                <span class="error-message" id="descriptionError"></span>
                            </div>

                            <div class="mb-3">
                                <label for="status" class="form-label">Status <span style="color: red">*</span></label>
                                <select class="form-select" id="status" name="productStatus">
                                    <option value="1" ${productStatus != null && !productStatus.equals("") && productStatus.equals("1") ? "selected" : ""} >Active</option>
                                    <option value="0" ${productStatus != null && !productStatus.equals("") && productStatus.equals("2") ? "selected" : ""} >Inactive</option>
                                </select>
                                <span class="error-message" id="statusError"></span>
                            </div>
                            <div class="d-flex">
                                <div class="w-100" style="padding-right: 12px">
                                    <a href="./view_list_product" class="btn btn-danger w-100">Cancel</a>
                                </div>
                                <div class="w-100" style="padding-left: 12px">
                                    <button type="submit" class="btn btn-warning w-100">Add Product</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="../../assets/js/user/sidebar.js"></script>

<script>
    function showError(inputElement, errorElement, message) {
        inputElement.classList.add("is-invalid");
        errorElement.textContent = message;
    }

    function clearError(inputElement, errorElement) {
        inputElement.classList.remove("is-invalid");
        errorElement.textContent = "";
    }

    function validateProductForm(event) {
        let isValid = true;

        // Lấy các phần tử input và thẻ span chứa lỗi
        const nameInput = document.getElementById('name');
        const nameError = document.getElementById('nameError');
        const categoryInput = document.getElementById('category');
        const categoryError = document.getElementById('categoryError');
        const ingredientInput = document.getElementById('ingredient');
        const ingredientError = document.getElementById('ingredientError');
        const descriptionInput = document.getElementById('description');
        const descriptionError = document.getElementById('descriptionError');
        const imageFileInput = document.getElementById('imageFile'); // Thêm biến này
        const imageFileError = document.getElementById('imageFileError'); // Thêm thẻ để hiển thị lỗi cho file

        // Lấy tất cả các phần tử chi tiết sản phẩm
        const productDetails = document.querySelectorAll('#pd > .row');

        // Reset lại lỗi trước đó
        clearError(nameInput, nameError);
        clearError(categoryInput, categoryError);
        clearError(ingredientInput, ingredientError);
        clearError(descriptionInput, descriptionError);
        clearError(imageFileInput, imageFileError); // Xóa lỗi cho file

        // Kiểm tra từng trường
        if (!nameInput.value.trim()) {
            nameInput.innerHTML = "";
            showError(nameInput, nameError, 'Please enter the product name');
            isValid = false;
        }
        if (!categoryInput.value.trim()) {
            showError(categoryInput, categoryError, 'Please select a category');
            isValid = false;
        }
        if (!ingredientInput.value.trim()) {
            ingredientInput.innerHTML = "";
            showError(ingredientInput, ingredientError, 'Please enter the ingredients');
            isValid = false;
        }
        if (!descriptionInput.value.trim()) {
            descriptionInput.innerHTML = "";
            showError(descriptionInput, descriptionError, 'Please enter the description');
            isValid = false;
        }

        // Kiểm tra xem đã chọn ít nhất một tệp hình ảnh hay chưa
        if (imageFileInput.files.length === 0) {
            showError(imageFileInput, imageFileError, 'Please choose at least one image file');
            isValid = false;
        }

        // Kiểm tra từng chi tiết sản phẩm
        productDetails.forEach((detail, index) => {
            const priceInput = detail.querySelector('input[name="productPrice"]');
            const priceError = detail.querySelector('.priceError');
            const sizeInput = detail.querySelector('select[name="productSize"]');
            const sizeError = detail.querySelector('.sizeError');

            // Reset lại lỗi trước đó
            clearError(priceInput, priceError);
            clearError(sizeInput, sizeError);

            if (!priceInput.value.trim()) {
                priceInput.innerHTML="";
                showError(priceInput, priceError, `Please enter the price`);
                isValid = false;
            } else if (priceInput.value < 1000) {
                showError(priceInput, priceError, `Price must be greater than 1000 VND`);
                isValid = false;
            }
            if (!sizeInput.value) {
                showError(sizeInput, sizeError, `Please select a size`);
                isValid = false;
            }
        });

        // Ngăn không cho submit form nếu không hợp lệ
        if (!isValid) {
            event.preventDefault();
        }

        return isValid;
    }

    function addMoreProductDetail() {
        const detailSection = `<div class="p-2 row mb-3 d-flex justify-content-between align-items-center">
                                <div class="col-md-6 col-sm-12 mb-2 mb-md-0">
                                    <label class="form-label">Price <span style="color: red">*</span></label>
                                    <div class="input-group">
                                        <input type="number" name="productPrice" value="" step="0.01" class="form-control" placeholder="Enter price">
                                        <span class="input-group-text">vnd</span>
                                    </div>
                                    <span class="error-message priceError"></span>
                                </div>

                                <div class="col-md-6 col-sm-12">
                                    <label class="form-label">Size <span style="color: red">*</span></label>
                                    <select name="productSize" class="form-select">
                                        <option value="" disabled selected>Select a size</option>
                                        <option value="Small">Small</option>
                                        <option value="Medium">Medium</option>
                                        <option value="Large">Large</option>
                                        <option value="Extra Large">Extra Large</option>
                                    </select>
                                    <span class="error-message sizeError"></span>
                                </div>
                            </div>`;

        document.getElementById("pd").insertAdjacentHTML("beforeend", detailSection);
    }

</script>

</body>
</html>