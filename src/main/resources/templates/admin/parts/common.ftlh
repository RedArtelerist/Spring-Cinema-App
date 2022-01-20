<#macro page>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin page</title>
        <!-- CSS -->
        <link rel="stylesheet" href="/static/admin/css/bootstrap-reboot.min.css">
        <link rel="stylesheet" href="/static/admin/css/bootstrap-grid.min.css">
        <link rel="stylesheet" href="/static/admin/css/magnific-popup.css">
        <link rel="stylesheet" href="/static/admin/css/select2.min.css">
        <link rel="stylesheet" href="/static/admin/css/admin.css">
    </head>
    <body>
    <#include "sidebar.ftlh">

    <main class="main">
        <#nested>
    </main>

    <!-- JS -->
    <script src="/static/admin/js/jquery-3.5.1.min.js"></script>
    <script src="/static/admin/js/bootstrap.bundle.min.js"></script>
    <script src="/static/admin/js/jquery.magnific-popup.min.js"></script>
    <script src="/static/admin/js/smooth-scrollbar.js"></script>
    <script src="/static/admin/js/select2.min.js"></script>
    <script src="/static/admin/js/admin.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.1.62/jquery.inputmask.bundle.js"></script>

    </body>
    </html>
</#macro>