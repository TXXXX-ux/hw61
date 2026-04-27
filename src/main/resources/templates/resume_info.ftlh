<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Резюме: ${resume.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
<#include "navbar.ftlh">
<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <div class="card-body p-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0">${resume.title}</h2>
                <span class="badge bg-info fs-6 text-white"><i class="bi bi-person-circle"></i> ${resume.authorName!"Кандидат"}</span>
            </div>
            <hr>
            <h6 class="text-uppercase text-muted fw-bold">Опыт работы и навыки</h6>
            <p class="mt-3" style="white-space: pre-wrap; line-height: 1.6;">${resume.description!"Информация не указана"}</p>

            <#if Session?? && Session.SPRING_SECURITY_CONTEXT??>
                <#assign auth = Session.SPRING_SECURITY_CONTEXT.authentication>
                <#if auth.authorities?seq_contains("ROLE_APPLICANT")>
                    <div class="mt-5 pt-4 border-top">
                        <h6 class="fw-bold mb-3 text-info">Управление резюме</h6>
                        <div class="d-flex gap-2">
                            <a href="/resumes/${resume.id}/edit" class="btn btn-warning px-4">
                                Редактировать
                            </a>
                            <form action="/resumes/${resume.id}/delete" method="post" onsubmit="return confirm('Удалить это резюме?');">
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                </#if>
                                <button type="submit" class="btn btn-danger px-4">
                                    Удалить
                                </button>
                            </form>
                            <a href="/auth/profile" class="btn btn-outline-secondary">В профиль</a>
                        </div>
                    </div>
                <#elseif auth.authorities?seq_contains("ROLE_EMPLOYER")>
                    <div class="mt-5 pt-4 border-top">
                        <button class="btn btn-info text-white btn-lg px-5">Пригласить на собеседование</button>
                        <a href="/resumes" class="btn btn-outline-secondary btn-lg ms-2">К списку резюме</a>
                    </div>
                </#if>
            <#else>
                <div class="mt-5 pt-4 border-top">
                    <a href="/resumes" class="btn btn-outline-secondary">Назад</a>
                </div>
            </#if>
        </div>
    </div>
</div>
</body>
</html>