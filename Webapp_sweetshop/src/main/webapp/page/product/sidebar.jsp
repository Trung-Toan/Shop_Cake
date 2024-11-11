<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of sidebar-->
<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
					<span class="sidebar-brand-text align-middle">
						Sweet Shop
                    </span>
            <svg class="sidebar-brand-icon align-middle" width="32px" height="32px" viewBox="0 0 24 24" fill="none" stroke="#FFFFFF" stroke-width="1.5"
                 stroke-linecap="square" stroke-linejoin="miter" color="#FFFFFF" style="margin-left: -3px">
                <path d="M12 4L20 8.00004L12 12L4 8.00004L12 4Z"></path>
                <path d="M20 12L12 16L4 12"></path>
                <path d="M20 16L12 20L4 16"></path>
            </svg>
        </a>

        <div class="sidebar-user">
            <div class="d-flex justify-content-center">
                <div class="flex-shrink-0">
                    <img src="../../assets/image/avatars/avatar.jpg" class="avatar img-fluid rounded me-1" alt="Charles Hall" />
                </div>
                <div class="flex-grow-1 ps-2">
                    <a class="sidebar-user-title dropdown-toggle" href="#" data-bs-toggle="dropdown">
                        Charles Hall
                    </a>
                    <div class="dropdown-menu dropdown-menu-start">
                        <a class="dropdown-item" href="pages-profile.html"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                        <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="pie-chart"></i> Analytics</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="pages-settings.html"><i class="align-middle me-1" data-feather="settings"></i> Settings &
                            Privacy</a>
                        <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="help-circle"></i> Help Center</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Log out</a>
                    </div>

                    <div class="sidebar-user-subtitle">Designer</div>
                </div>
            </div>
        </div>

        <ul class="sidebar-nav">
            <li class="sidebar-item pa">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboards</span>
                </a>
            </li>

            <li class="sidebar-item pa">
                <a data-bs-target="#icons" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="layout"></i> <span class="align-middle">Manager Products</span>
                </a>
                <ul id="icons" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="#">List Products</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Products</a></li>
                </ul>
            </li>

            <li class="sidebar-item pa">
                <a data-bs-target="#order" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="list"></i> <span class="align-middle">Manager Orders</span>
                </a>
                <ul id="order" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="#">List Orders</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Orders</a></li>
                </ul>
            </li>

            <li class="sidebar-item pa">
                <a data-bs-target="#form-plugins" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="check-square"></i> <span class="align-middle">Manager Customers</span>
                </a>
                <ul id="form-plugins" class="sidebar-dropdown list-unstyled collapse  " data-bs-parent="#sidebar">
                    <li class="sidebar-item "><a class="sidebar-link" href="/getcustomer">List Customers</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="/addcustomer">Add New Customer</a></li>
                </ul>
            </li>

            <li class="sidebar-item pa">
                <a data-bs-target="#pages" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="users"></i> <span class="align-middle">Manager Product</span>
                </a>
                <ul id="pages" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="/view_list_product">List Product</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="/add_new_product">Add New Product</a></li>
                </ul>
            </li>
            <li class="sidebar-item pa">
                <a data-bs-target="#shipper" data-bs-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="user"></i> <span class="align-middle">Manager Shippers</span>
                </a>
                <ul id="shipper" class="sidebar-dropdown list-unstyled collapse " data-bs-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="#">List Shippers</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="#">Add New Shipper</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
