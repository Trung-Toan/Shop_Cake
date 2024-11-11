<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Update Product</title>
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
        .position-relative {
            display: inline-block;
            width: fit-content;
            position: relative;
        }

        .btn-close-custom {
            position: absolute;
            top: -10px; /* Adjust positioning */
            right: -10px;
            background-color: white;
            border: 2px solid #f0f0f0;
            color: black;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-close-custom:hover {
            background-color: #f8f9fa;
            color: #000;
            border-color: #ccc;
        }

        .btn-close-custom:focus {
            outline: none;
            box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
        }
        .error-message {
            min-height: 20px;
            display: inline-block;
            vertical-align: middle;
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
        <jsp:include page="../common/navbar.jsp"/>
        <div class="">
            <%
                String mess = request.getParameter("mess");
                String type = request.getParameter("type");
                mess = request.getAttribute("mess") == null ? mess : (String) request.getAttribute("mess");
                type = request.getAttribute("type") == null ? type : (String) request.getAttribute("type");
            %>

            <div class="row mt-3">
                <div class="col-md-9"></div>
                <%
                    if (mess != null && !mess.equals("")) {
                %>
                <div class="col-md-3 alert alert-<%= "success".equals(type) ? "success" : "danger" %> alert-dismissible order-md-last">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <strong><%= "success".equals(type) ? "Success" : "Error" %>!</strong> <%= mess %>
                </div>
                <%
                    }
                %>
            </div>
            <div class="d-flex justify-content-center mt-2">
                <div class="product p-4">
                    <h3 class="text-center text-success mb-4">Update product</h3>
                    <div class="p-4 border-custom">
                        <form action="update_product" method="post" id="productForm" enctype="multipart/form-data"
                              onsubmit="validateProductForm(event)" novalidate>
                            <%--name product--%>
                            <div class="mb-3">
                                <label for="name" class="form-label">Product Name <span
                                        style="color: red">*</span></label>
                                <input type="text" class="form-control" id="name" name="productNameUpdate"
                                       placeholder="Enter product name"
                                       value="${product.name != null && !product.name.equals("") ? product.name : ""}" readonly>
                                <span class="error-message" id="nameError"></span>
                            </div>

                            <%--category--%>
                            <div class="mb-3">
                                <label for="category" class="form-label">Category <span
                                        style="color: red">*</span></label>
                                <select class="form-select" name="productCategoryUpdate" id="category" required>
                                    <option value="" disabled selected>Select a category</option>
                                    <c:forEach var="c" items="${categoryList}">
                                        <option value="${c.id}" ${(product.categoryID + "").equals(c.id+"") ? "selected" : ""} >${c.name}</option>
                                    </c:forEach>
                                </select>
                                <span class="error-message" id="categoryError"></span>
                            </div>

                            <%-- Image Section --%>
                            <div class="mb-3 border border-warning rounded p-3">
                                <label for="imageFile" class="text-warning p-2 form-label fw-bold">Choose images:<span
                                        style="color: red">*</span></label>
                                <div class="row g-3">
                                    <c:forEach items="${mediaList}" var="img" varStatus="status">
                                        <div id="image-element-${img.id}" class="col-4">
                                            <!-- Thêm thẻ div bao bọc cho position-relative -->
                                            <div class="position-relative">
                                                <img class="img-thumbnail rounded shadow-sm"
                                                     src="data:image/png;base64,${img.image}"
                                                     style="max-height: 350px; object-fit: contain" alt="Thumbnail">
                                                <button type="button" class="btn-close-custom" aria-label="Close" onclick="removeImage(${img.id})">×</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <input type="hidden" name="imageDelete" value="" id="imageDelete" />
                                </div>

                                <input type="file" name="imageFile" id="imageFile" accept="image/*" multiple
                                       class="form-control mt-2">
                                <span class="error-message text-danger mt-2 d-block" id="imageFileError"></span>
                            </div>



                            <%-- Product Detail Section --%>
                            <div class="product_detail p-3 border border-warning rounded mb-3">
                                <c:set var="pdIdUpdate" value="" />
                                <label for="pd" class="text-warning form-label fw-bold">Product Details</label>
                                <div id="pd">
                                    <c:forEach var="pd" items="${productDetailList}" varStatus="status">
                                        <div id="product-detail-element-${pd.id}" class="p-2 row mb-3 d-flex justify-content-between align-items-center">
                                            <div class="col-md mb-2">
                                                <label class="form-label">Price <span style="color: red">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" name="productPriceUpdate" value="${pd.price == null ? "" : pd.price}" step="0.01"
                                                           class="form-control" placeholder="Enter price">
                                                    <span class="input-group-text">vnd</span>
                                                </div>
                                                <span class="error-message text-danger mt-1 d-block priceError"></span>
                                            </div>
                                            <div class="col-md">
                                                <label class="form-label">Size <span style="color: red">*</span></label>
                                                <select id="size" name="productSizeUpdate" class="form-select">
                                                    <option value="" disabled selected>Select a size</option>
                                                    <option value="Small" ${pd.size != null && pd.size.equals("Small") ? "selected" : ""}>Small</option>
                                                    <option value="Medium" ${pd.size != null && pd.size.equals("Medium") ? "selected" : ""}>Medium</option>
                                                    <option value="Large" ${pd.size != null && pd.size.equals("Large") ? "selected" : ""}>Large</option>
                                                    <option value="Extra Large" ${pd.size != null && pd.size.equals("Extra Large") ? "selected" : ""}>Extra Large</option>
                                                </select>
                                                <span class="error-message text-danger mt-1 d-block sizeError"></span>
                                            </div>
                                            <div class="col-md-1 d-flex justify-content-end align-items-end">
                                                <button type="button" class="btn btn-danger mt-2" onclick="removeProductDetail(${pd.id})">X</button>
                                            </div>
                                        </div>
                                        <c:set var="pdIdUpdate" value="${pdIdUpdate}${pd.id}${status.last ? '' : '|'}"/>
                                    </c:forEach>
                                    <input type="hidden" value="" name="productDetailDelete" id="productDetailDelete" />
                                    <input type="hidden" value="${pdIdUpdate}" name="pdIdUpdate" id="pdIdUpdate" />
                                </div>
                                <div class="d-flex justify-content-center mt-2">
                                    <button type="button" class="btn btn-warning text-light fw-bold"
                                            onclick="addMoreProductDetail()">+
                                    </button>
                                </div>
                            </div>

                            <%--ingredient--%>
                            <div class="mb-3">
                                <label for="ingredient" class="form-label">Ingredient <span style="color: red">*</span></label>
                                <textarea class="form-control" id="ingredient" name="productIngredientUpdate" rows="3"
                                          placeholder="Enter ingredients">${product.ingredient == null || product.ingredient.equals("") ? "" : product.ingredient}</textarea>
                                <span class="error-message" id="ingredientError"></span>
                            </div>

                            <%--description--%>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description <span
                                        style="color: red">*</span></label>
                                <textarea class="form-control" id="description" name="productDescriptionUpdate" rows="3"
                                          placeholder="Enter description">${product.description == null || product.description.equals("") ? "" : product.description}</textarea>
                                <span class="error-message" id="descriptionError"></span>
                            </div>

                            <%--status--%>
                            <div class="mb-3">
                                <label for="status" class="form-label">Status <span style="color: red">*</span></label>
                                <select class="form-select" id="status" name="productStatusUpdate">
                                    <option value="1" ${product.status != null && !product.status.equals("") && product.status.equals("1") ? "selected" : ""} >
                                        Active
                                    </option>
                                    <option value="0" ${product.status != null && !product.status.equals("") && product.status.equals("2") ? "selected" : ""} >
                                        Inactive
                                    </option>
                                </select>
                                <span class="error-message" id="statusError"></span>
                            </div>

                            <%--action--%>
                            <div class="d-flex">
                                <div class="w-100" style="padding-right: 12px">
                                    <a href="./view_list_product" class="btn btn-danger w-100">Cancel</a>
                                </div>
                                <div class="w-100" style="padding-left: 12px">
                                    <button type="submit" class="btn btn-success w-100">Update Product</button>
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
!-- Feather Icons -->
<script src="https://unpkg.com/feather-icons"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Feather Icons
    feather.replace();
</script>
<script>
    function removeImage(imageId) {
        // Thêm ID vào thẻ hidden
        var imageDeleteInput = document.getElementById('imageDelete');
        var currentValue = imageDeleteInput.value;

        // Thêm ID vào input hidden, ngăn cách bởi dấu '|'
        if (currentValue) {
            imageDeleteInput.value = currentValue + '|' + imageId;
        } else {
            imageDeleteInput.value = imageId;
        }

        // Xóa toàn bộ thẻ chứa ảnh và nút xóa
        var imageElementContainer = document.getElementById('image-element-' + imageId);
        if (imageElementContainer) {
            imageElementContainer.remove(); // Xóa thẻ <div> chứa cả ảnh và nút
        }
    }

    function removeProductDetail(productDetailId) {
        // Thêm ID vào thẻ hidden
        var productDetailDeleteInput = document.getElementById('productDetailDelete');
        var currentValue = productDetailDeleteInput.value;

        // Thêm ID vào input hidden, ngăn cách bởi dấu '|'
        if (currentValue) {
            productDetailDeleteInput.value = currentValue + '|' + productDetailId;
        } else {
            productDetailDeleteInput.value = productDetailId;
        }

        // Xóa ID khỏi pdIdUpdate
        var pdIdUpdateInput = document.getElementById('pdIdUpdate');
        var pdIdUpdateValue = pdIdUpdateInput.value.split('|');
        pdIdUpdateValue = pdIdUpdateValue.filter(function(id) {
            return id !== productDetailId.toString();
        });
        pdIdUpdateInput.value = pdIdUpdateValue.join('|');

        // Xóa toàn bộ thẻ chứa productDetail
        var productDetailElementContainer = document.getElementById('product-detail-element-' + productDetailId);
        if (productDetailElementContainer) {
            productDetailElementContainer.remove(); // Xóa thẻ <div> chứa chi tiết sản phẩm
        }
    }

    function showError(inputElement, errorElement, message) {
        inputElement.classList.add("is-invalid");
        errorElement.textContent = message;
    }

    function clearError(inputElement, errorElement) {
        inputElement.classList.remove("is-invalid");
        errorElement.textContent = "";
    }

    function validateProductForm(event) {
        event.preventDefault();  // Chặn ngay hành vi submit mặc định

        let isValid = true;

        // Phần kiểm tra và thông báo lỗi như trước
        const nameInput = document.getElementById('name');
        const nameError = document.getElementById('nameError');
        const categoryInput = document.getElementById('category');
        const categoryError = document.getElementById('categoryError');
        const ingredientInput = document.getElementById('ingredient');
        const ingredientError = document.getElementById('ingredientError');
        const descriptionInput = document.getElementById('description');
        const descriptionError = document.getElementById('descriptionError');
        const productDetails = document.querySelectorAll('#pd > .row');

        // Reset lỗi trước đó
        clearError(nameInput, nameError);
        clearError(categoryInput, categoryError);
        clearError(ingredientInput, ingredientError);
        clearError(descriptionInput, descriptionError);

        if (!nameInput.value.trim()) {
            showError(nameInput, nameError, 'Please enter the product name');
            isValid = false;
        }
        if (!categoryInput.value.trim()) {
            showError(categoryInput, categoryError, 'Please select a category');
            isValid = false;
        }
        if (!ingredientInput.value.trim()) {
            showError(ingredientInput, ingredientError, 'Please enter the ingredients');
            isValid = false;
        }
        if (!descriptionInput.value.trim()) {
            showError(descriptionInput, descriptionError, 'Please enter the description');
            isValid = false;
        }

        const productDetailNames = [
            { price: "productPriceUpdate", size: "productSizeUpdate" },
            { price: "productPrice", size: "productSize" }
        ];

        for (const names of productDetailNames) {
            const priceInputs = document.querySelectorAll(`input[name="${names.price}"]`);
            const sizeInputs = document.querySelectorAll(`select[name="${names.size}"]`);

            priceInputs.forEach((priceInput) => {
                const priceError = priceInput.closest('.col-md').querySelector('.priceError');
                clearError(priceInput, priceError);

                const priceValue = parseFloat(priceInput.value); // Chuyển đổi giá trị input thành số

                if (!priceInput.value.trim()) {
                    showError(priceInput, priceError, `Please enter the price`);
                    isValid = false;
                } else if (isNaN(priceValue) || priceValue < 1000) { // Kiểm tra NaN
                    showError(priceInput, priceError, `Price must be >= 1000 VND`);
                    isValid = false;
                }
            });

            sizeInputs.forEach((sizeInput) => {
                const sizeError = sizeInput.closest('.col-md').querySelector('.sizeError');
                clearError(sizeInput, sizeError);

                if (!sizeInput.value) {
                    showError(sizeInput, sizeError, `Please select a size`);
                    isValid = false;
                }
            });
        }

        if (!isValid) {
            console.log("Ngăn submit do không hợp lệ");
            return false;  // Ngăn form submit
        }

        console.log("Form hợp lệ, sẽ submit");
        event.target.submit();  // Chỉ submit nếu form hợp lệ
    }

    function addMoreProductDetail() {
        const detailSection = `<div class="p-2 row mb-3 d-flex justify-content-between align-items-center">
                                            <div class="col-md mb-2">
                                                <label class="form-label">Price <span style="color: red">*</span></label>
                                                <div class="input-group">
                                                    <input type="number" name="productPrice" value="" step="0.01"
                                                           class="form-control" placeholder="Enter price">
                                                    <span class="input-group-text">vnd</span>
                                                </div>
                                                <span class="error-message text-danger mt-1 d-block priceError"></span>
                                            </div>
                                            <div class="col-md">
                                                <label class="form-label">Size <span style="color: red">*</span></label>
                                                <select id="size" name="productSize" class="form-select">
                                                    <option value="" disabled selected>Select a size</option>
                                                    <option value="Small">Small</option>
                                                    <option value="Medium"}>Medium</option>
                                                    <option value="Large">Large</option>
                                                    <option value="Extra Large">Extra Large</option>
                                                </select>
                                                <span class="error-message text-danger mt-1 d-block sizeError"></span>
                                            </div>
                                            <div class="col-md-1 d-flex justify-content-end align-items-end">
                                                <button type="button" class="btn btn-secondary mt-2">X</button>
                                            </div>
                                        </div>`;
        document.getElementById("pd").insertAdjacentHTML("beforeend", detailSection);
    }
</script>

</body>
</html>