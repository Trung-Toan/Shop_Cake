let currentPage = 1;
const rowsPerPage = 10;
const staffRows = document.querySelectorAll('.staffRow');
const totalPages = Math.ceil(staffRows.length / rowsPerPage);
const staffBody = document.getElementById('staffBody');
// const pageInfo = document.getElementById('pageInfo');
const prevButton = document.getElementById('prevButton');
const nextButton = document.getElementById('nextButton');
const pageNumbers = document.getElementById('pageNumbers');

function displayPage(page) {
    // Calculate the start and end index for the rows to display
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    // Hide all staff rows
    staffRows.forEach((row, index) => {
        row.style.display = index >= start && index < end ? '' : 'none';
    });

    // Update the page info
    // pageInfo.textContent = `${page}`;

    // Enable/disable buttons based on the current page
    prevButton.disabled = page === 1;
    nextButton.disabled = page === totalPages;

    generatePageNumbers();
}

function changePage(delta) {
    currentPage += delta;
    displayPage(currentPage);
}

function generatePageNumbers() {
    pageNumbers.innerHTML = ''; // Clear existing page numbers

    for (let i = 1; i <= totalPages; i++) {
        const pageNumber = document.createElement('button');
        pageNumber.className = 'page-link';
        pageNumber.textContent = i;
        pageNumber.onclick = () => {
            currentPage = i;
            displayPage(currentPage);
        };

        // Highlight the active page number
        if (i === currentPage) {
            pageNumber.classList.add('active');
        }

        pageNumbers.appendChild(pageNumber);
    }
}

// Initial call to display the first page
displayPage(currentPage);