<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of navbar-->

<nav class="navbar navbar-expand navbar-light navbar-bg">
    <a class="sidebar-toggle js-sidebar-toggle">
        <i class="hamburger align-self-center"></i>
    </a>

    <ul class="navbar-nav d-none d-lg-flex">
        <!-- <li class="nav-item px-2 dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="megaDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false">
                Mega Menu
            </a>
            <div class="dropdown-menu dropdown-menu-start dropdown-mega" aria-labelledby="megaDropdown">
                <div class="d-md-flex align-items-start justify-content-start">
                    <div class="dropdown-mega-list">
                        <div class="dropdown-header">UI Elements</div>
                        <a class="dropdown-item" href="#">Alerts</a>
                        <a class="dropdown-item" href="#">Buttons</a>
                        <a class="dropdown-item" href="#">Cards</a>
                        <a class="dropdown-item" href="#">Carousel</a>
                        <a class="dropdown-item" href="#">General</a>
                        <a class="dropdown-item" href="#">Grid</a>
                        <a class="dropdown-item" href="#">Modals</a>
                        <a class="dropdown-item" href="#">Tabs</a>
                        <a class="dropdown-item" href="#">Typography</a>
                    </div>
                    <div class="dropdown-mega-list">
                        <div class="dropdown-header">Forms</div>
                        <a class="dropdown-item" href="#">Layouts</a>
                        <a class="dropdown-item" href="#">Basic Inputs</a>
                        <a class="dropdown-item" href="#">Input Groups</a>
                        <a class="dropdown-item" href="#">Advanced Inputs</a>
                        <a class="dropdown-item" href="#">Editors</a>
                        <a class="dropdown-item" href="#">Validation</a>
                        <a class="dropdown-item" href="#">Wizard</a>
                    </div>
                    <div class="dropdown-mega-list">
                        <div class="dropdown-header">Tables</div>
                        <a class="dropdown-item" href="#">Basic Tables</a>
                        <a class="dropdown-item" href="#">Responsive Table</a>
                        <a class="dropdown-item" href="#">Table with Buttons</a>
                        <a class="dropdown-item" href="#">Column Search</a>
                        <a class="dropdown-item" href="#">Muulti Selection</a>
                        <a class="dropdown-item" href="#">Ajax Sourced Data</a>
                    </div>
                </div>
            </div>
        </li> -->

        <!-- <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="resourcesDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false">
                Resources
            </a>
            <div class="dropdown-menu" aria-labelledby="resourcesDropdown">
                <a class="dropdown-item" href="https://adminkit.io/" target="_blank"><i class="align-middle me-1" data-feather="home"></i>
                    Homepage</a>
                <a class="dropdown-item" href="https://adminkit.io/docs/" target="_blank"><i class="align-middle me-1" data-feather="book-open"></i>
                    Documentation</a>
                <a class="dropdown-item" href="https://adminkit.io/docs/getting-started/changelog/" target="_blank"><i class="align-middle me-1"
                        data-feather="edit"></i> Changelog</a>
            </div>
        </li> -->
    </ul>

    <div class="navbar-collapse collapse">
        <ul class="navbar-nav navbar-align">
            <li class="nav-item dropdown">
                <a class="nav-flag dropdown-toggle" href="#" id="languageDropdown" data-bs-toggle="dropdown">
                    <img src="../../assets/image/flags/us.png" alt="English" />
                </a>
                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="languageDropdown">
                    <a class="dropdown-item" href="#">
                        <img src="../../assets/image/flags/us.png" alt="English" width="20" class="align-middle me-1" />
                        <span class="align-middle">English</span>
                    </a>
                    <a class="dropdown-item" href="#">
                        <img src="../../assets/image/flags/es.png" alt="Spanish" width="20" class="align-middle me-1" />
                        <span class="align-middle">Spanish</span>
                    </a>
                    <a class="dropdown-item" href="#">
                        <img src="../../assets/image/flags/ru.png" alt="Russian" width="20" class="align-middle me-1" />
                        <span class="align-middle">Russian</span>
                    </a>
                    <a class="dropdown-item" href="#">
                        <img src="../../assets/image/flags/de.png" alt="German" width="20" class="align-middle me-1" />
                        <span class="align-middle">German</span>
                    </a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-icon js-fullscreen d-none d-lg-block" href="#">
                    <div class="position-relative">
                        <i class="align-middle" data-feather="maximize"></i>
                    </div>
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-icon pe-md-0 dropdown-toggle" href="#" data-bs-toggle="dropdown">
                    <img src="data:image/jpeg;base64,${loggedInUser.avatar}" class="avatar img-fluid rounded" alt="avatar" />
                </a>
                <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="/editprofile"><i class="align-middle me-1" data-feather="user"></i> Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#"><i class="align-middle me-1" data-feather="settings"></i> Change password</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="/logout">Log out</a>
                </div>
            </li>
        </ul>
    </div>
</nav>