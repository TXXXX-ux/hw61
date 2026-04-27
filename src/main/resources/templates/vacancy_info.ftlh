<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Вакансия: ${vacancy.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<#include "navbar.ftlh">
<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <div class="card-body p-5">
            <div class="d-flex justify-content-between align-items-start mb-3">
                <h2 class="mb-0">${vacancy.title}</h2>
                <h4 class="text-success mb-0">${vacancy.salary!0} сом</h4>
            </div>
            <hr>
            <h6 class="text-uppercase text-muted fw-bold">Описание вакансии</h6>
            <p class="mt-3" style="white-space: pre-wrap;">${vacancy.description!"Описание не указано"}</p>
            <#if Session?? && Session.SPRING_SECURITY_CONTEXT??>
                <#assign auth = Session.SPRING_SECURITY_CONTEXT.authentication>
                <#if auth.authorities?seq_contains("ROLE_EMPLOYER")>
                    <#if auth.name == vacancy.authorEmail>
                        <div class="mt-4 d-flex gap-2 pt-3 border-top">
                            <a href="/vacancies/${vacancy.id}/edit" class="btn btn-warning">Редактировать</a>
                            <form action="/vacancies/${vacancy.id}/delete" method="post">
                                <#if _csrf??><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/></#if>
                                <button type="submit" class="btn btn-danger">Удалить</button>
                            </form>
                        </div>
                    <#else>
                        <div class="mt-4 pt-3 border-top">
                            <span class="text-muted">Это вакансия другого работодателя</span>
                        </div>
                    </#if>
                <#elseif auth.authorities?seq_contains("ROLE_APPLICANT")>
                    <div class="mt-4 pt-3 border-top">
                        <button class="btn btn-primary w-100">Откликнуться на вакансию</button>
                    </div>
                </#if>
            </#if>

        </div>
    </div>
</div>
</body>
</html>