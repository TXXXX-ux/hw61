<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Резюме: ${resume.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<#include "navbar.ftlh">
<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <div class="card-body p-5">
            <h2 class="mb-3">${resume.title}</h2>
            <hr>
            <h6 class="text-uppercase text-muted fw-bold">Опыт работы и навыки</h6>
            <p class="mt-3" style="white-space: pre-wrap;">${resume.description!"Информация не указана"}</p>
            <div class="mt-5">
                <button class="btn btn-info text-white">Пригласить на собеседование</button>
                <a href="/resumes" class="btn btn-outline-secondary ms-2">Назад</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>