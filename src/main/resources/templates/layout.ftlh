<#macro layout>
    <!DOCTYPE html>
    <html lang="ru">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Job Portal</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

            <style>
                .profile-header { background: linear-gradient(45deg, #007bff, #0056b3); color: white; padding: 20px; border-radius: 10px 10px 0 0; }
                .admin-section { border-left: 4px solid #dc3545; padding-left: 15px; }
                .user-section { border-left: 4px solid #17a2b8; padding-left: 15px; }
                .bg-light { background-color: #f8f9fa!important; }
                /* Добавь это в блок <style> в файле layout.ftlh */
                html { scroll-behavior: smooth }
            </style>
        </head>
        <body class="bg-light">
            <#include "navbar.ftlh">

            <div class="container mt-4">
                <#nested>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
</#macro>