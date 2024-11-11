<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 9/28/2024
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Cart | E-Shopper</title>
    <script src="../assets/js/html5shiv.js"></script>
    <style>
        a{
            text-decoration: none;
        }
        td{
            text-align: center;
            vertical-align: middle;
        }
        /* Cart Css */
        .cart_menu {
            background-color: #f4f4f4;
            color: #555;
            font-weight: bold;
            text-align: center;
        }
        .cart_product{
            align-items: center;
        }
        .cart_product img {
            width: 100px;
            height: 100px;
        }

        .cart_quantity_button {
            display: flex;
            align-items: center;
            justify-content: center;
        }


        .cart_quantity_button button {
            background-color: #bebebf;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            width: 30px;
            height: 30px;
            font-size: 16px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cart_quantity_button button:hover {
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.5);
        }

        .cart_quantity_input {
            text-align: center;
            width: 40px;
            margin: 0 5px;
            border: 1px solid black;
            border-radius: 4px;
        }

        .cart_quantity_input:hover {
            border-color: blue;
            border-width: 2px;
        }

        .cart_delete a {
            color: #d9534f;
            text-decoration: none;
        }

        .cart_delete a:hover {
            color: #c9302c;
        }

        .bold-price {
            font-weight: bold;
        }

        .cart-checkbox {
            width: 18px;
            height: 18px;
            border: 1px solid gray;
            margin: 0 auto;
        }

        .cart_actions .cart_quantity_delete {
            display: inline-flex;
            align-items: center;
        }
        .cart_edit{
            background-color: #FFFFFF;
            border: black solid 1px;
            border-radius: 4px;
            cursor: pointer;
            width: 30px;
            height: 30px;

        }
        .cart_quantity_delete{
            background-color: #a10718;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }


        /*Popup Screen Css*/
        .modal-content {
            background-color: white;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 600px;
            max-width: 600px;
            height: 85vh;
            max-height: 85vh;
            padding: 20px;
            border: 1px solid #888;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-sizing: border-box;
            overflow-y: auto;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .product-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .product-info img {
            margin-right: 15px;
        }

        .form-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .form-row label {
            width: 30%;
        }

        .form-row select,
        .form-row input {
            width: 65%;
        }
        /* Section do_action */
        #do_action {
            margin-top: 20px;
        }

        .total_area {
            border: 1px solid #ccc; /* Viền khung */
            border-radius: 10px; /* Bo góc khung */
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
        }

        .total_area ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .total_area li {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }


        .btn-checkout {
            background-color: #ff7f50;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-checkout:hover {
            background-color: #ff5733;
            transition: background-color 0.3s ease;
        }
        .candle-selection {
            border-radius: 3px;
            border: 1px solid black;
            width: 200px;
            min-width: 150px;
            padding: 5px;
            font-size: 14px;
        }
        .candle-number-input{
            border-radius: 3px;
            border: 1px solid black;
            width: 200px;
            padding: 5px;
        }
         .birthday-flare {
             display: flex;
             align-items: center;
         }
        .birthday-flare input[type="checkbox"] {
            transform: scale(1.5);
            margin-right: 10px;
        }
        button.save-btn {
            background-color: #8BC34A; /* Light green */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            box-shadow: none;
        }

        button.save-btn:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        button.cancel-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            box-shadow: none;
            margin-left: 10px;
        }

        button.cancel-btn:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

    </style>
</head>

<body>
<jsp:include page="header.jsp"/>
<section id="cart_items">
    <div class="container">
        <div class="table-responsive cart_info">
            <form action="cartcontroller?action=update" method="post" id="cart_form">
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="empty-cart-message">
                            <p>Oops! Empty cart!</p>
                            <a href="home.jsp" class="go-shopping-button">Go Shopping</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-condensed cart-table">
                            <thead>
                            <tr class="cart_menu">
                                <td class="checkbox">Select</td>
                                <td class="image">Item</td>
                                <td class="description">Description</td>
                                <td class="price">Price</td>
                                <td class="quantity">Quantity</td>
                                <td class="actions">Actions</td>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td class="cart_select">
                                        <input type="checkbox" name="selectedItems" value="${item.productDetailID}" class="cart-checkbox"
                                               data-price="${item.productDetail.price}" data-quantity="${item.quantity}" data-size="${item.productDetail.size}">
                                    </td>
                                    <td class="cart_product">
                                        <a href="viewdetail?id=${item.productDetailID}"><img src="../assets/image/cart/one.png" alt="Product_image"></a>
                                    </td>
                                    <td class="cart_description">
                                        <h4><a href="viewdetail?id=${item.productDetailID}">${item.product.name}</a></h4>
                                        <p>${item.product.description} | Type: ${item.productDetail.size}</p>
                                    </td>
                                    <td class="cart_price">
                                        <p class="bold-price">${item.productDetail.price}$</p>
                                    </td>
                                    <td class="cart_quantity">
                                        <div class="cart_quantity_button">
                                            <button type="button" class="quantity_minus"> - </button>
                                            <input class="cart_quantity_input" type="text" name="quantity_${item.productDetailID}" value="${item.quantity}" autocomplete="off" size="2">
                                            <button type="button" class="quantity_plus"> + </button>
                                        </div>
                                    </td>
                                    <td class="cart_actions">
                                        <button class="cart_edit" type="button" data-name="${item.product.name}" data-price="${item.productDetail.price}">
                                            <i class="fa fa-pencil"></i>
                                        </button>

                                        <button class="cart_quantity_delete" href="cartcontroller?action=remove&productDetailID=${item.productDetailID}">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>
    </div>
</section>

<section id="do_action">
    <div class="container">
        <c:if test="${not empty cartItems}">
            <div class="total_area">
                <ul>
                    <li>Total: <span id="total_price">0.00$</span></li>
                </ul>
                <button type="submit" class="btn-checkout" form="cart_form" formaction="cartcontroller?action=checkout">Check Out</button>
            </div>
        </c:if>
    </div>
</section>


<!--Popup Edit Screen-->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h4>Edit Product</h4>
        <div class="product-info">
            <img src="../assets/image/cart/one.png" alt="Product Image">
            <div class="product-details">
                <p>Product: ${item.product.name}</p>
                <p>Price: ${item.productDetail.price}$</p>
            </div>
        </div>

        <div class="form-row">
            <table>
                <tr>
                    <td><label for="candle">Candle:</label></td><td><select id="candle" class="candle-selection">
                                                                        <option value="small">Small (Height: 3-5cm)</option>
                                                                        <option value="big">Big (Height: 5-7cm)</option>
                                                                        <option value="number">Number</option>
                                                                    </select>
                                                                    </td>
                    <td><div class="birthday-flare">
                        <input type="checkbox" id="birthday-flare-checkbox">
                    </div></td>
                </tr>
                <tr>
                    <td></td><td><input type="number" class="candle-number-input" placeholder="Enter you number!"/></td><td><label for="birthday-flare-checkbox">Birthday Flare</label></td>
                </tr>
            </table>
        </div>



        <div class="form-row">
            <label for="messageOption">Message Option:</label>
            <select id="messageOption">
                <option value="cake">Write on cake</option>
                <option value="card">Write on card</option>
            </select>
        </div>

        <textarea id="message" placeholder="Write your message here"></textarea>

        <label for="note">Your note:</label>
        <textarea id="note" placeholder="Any special instructions"></textarea>

        <div class="form-row">
            <button class="save-btn" id="saveEdit">Save</button>
            <button class="cancel-btn" id="cancelEdit">Cancel</button>
        </div>
    </div>
</div>


<jsp:include page="footer.jsp" flush="true" />

<script>
    document.querySelectorAll('.quantity_plus').forEach(button => {
        button.addEventListener('click', function() {
            let quantityInput = this.previousElementSibling;
            quantityInput.value = parseInt(quantityInput.value) + 1;
        });
    });

    document.querySelectorAll('.quantity_minus').forEach(button => {
        button.addEventListener('click', function() {
            let quantityInput = this.nextElementSibling;
            if (parseInt(quantityInput.value) > 1) {
                quantityInput.value = parseInt(quantityInput.value) - 1;
            }
        });
    });

    // Handle the edit popup modal
    let editModal = document.getElementById("editModal");
    let closeModalButton = document.getElementsByClassName("close")[0];

    // When the edit button is clicked
    document.querySelectorAll('.cart_edit').forEach(button => {
        button.addEventListener('click', function() {
            const productName = this.dataset.name;
            const productPrice = this.dataset.price;

            // Set the modal fields with product information
            document.querySelector('#editModal .product-details p:first-of-type').textContent = `Product: ${productName}`;
            document.querySelector('#editModal .product-details p:last-of-type').textContent = `Price: ${productPrice}$`;

            // Show the modal
            editModal.style.display = 'block';
        });
    });

    // Close the modal
    closeModalButton.onclick = function() {
        if (confirm("You did not save your option! Do you want to exit?")) {
            editModal.style.display = "none";
        }
    };

    // Cancel button action
    document.getElementById("cancelEdit").onclick = function() {
        editModal.style.display = "none";
    };

    // Close modal when clicking outside of it
    window.onclick = function(event) {
        if (event.target === editModal) {
            if (confirm("You did not save your option! Do you want to exit?")) {
                editModal.style.display = "none";
            }
        }
    };

    document.querySelectorAll('.cart-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            updateTotalPrice();
        });
    });

    function updateTotalPrice() {
        let totalPrice = 0;
        document.querySelectorAll('.cart-checkbox:checked').forEach(checkbox => {
            let price = parseFloat(checkbox.getAttribute('data-price'));
            let quantity = parseInt(checkbox.closest('tr').querySelector('.cart_quantity_input').value);
            totalPrice += price * quantity;
        });
        document.getElementById('total_price').textContent = totalPrice.toFixed(2) + "$";
    }
</script>
<script src="../assets/js/jquery.js"></script>
<script src="../assets/js/bootstrap.min.js"></script>
<script src="../assets/js/jquery.scrollUp.min.js"></script>
<script src="../assets/js/jquery.prettyPhoto.js"></script>
</body>
</html>