<#import "layout.ftlh" as main>
<@main.layout>
    <div class="text-center py-5">
        <h1 class="display-1 fw-bold text-danger">${status}</h1>
        <h2 class="mb-4">Упс! Что-то пошло не так</h2>
        <p class="lead text-muted">${reason}</p>

        <#if details??>
            <div class="card d-inline-block text-start p-3 shadow-sm bg-white mb-4">
                <ul class="list-unstyled mb-0">
                    <li><strong>URL:</strong> <code>${details.requestURL!''}</code></li>
                    <li><strong>Время:</strong> <code>${.now?string('HH:mm:ss')}</code></li>
                </ul>
            </div>
        </#if>

        <div>
            <a href="/vacancies" class="btn btn-primary px-4">Вернуться к вакансиям</a>
        </div>
    </div>
</@main.layout>