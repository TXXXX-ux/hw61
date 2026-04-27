<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">

        <div class="card shadow-sm mb-5 border-0 bg-white">
            <div class="card-body p-4">
                <div class="d-flex align-items-center mb-3">
                    <div class="bg-primary rounded text-white d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px; font-size: 24px;">
                        <i class="bi bi-building"></i>
                    </div>
                    <div>
                        <h2 class="card-title text-primary mb-0">${company.name}</h2>
                        <p class="text-muted fs-6 mb-0"><i class="bi bi-envelope"></i> ${company.email}</p>
                    </div>
                </div>
                <p class="mt-3 lead">${company.about!"Информация о компании пока не заполнена."}</p>
            </div>
        </div>

        <h4 class="mb-4 fw-bold border-bottom pb-2">Открытые вакансии (${vacanciesPage.totalElements})</h4>

        <div class="row">
            <#if vacanciesPage?? && vacanciesPage.content?size gt 0>
                <#list vacanciesPage.content as vacancy>
                    <div class="col-md-6 mb-4">
                        <div class="card h-100 shadow-sm border-start border-success border-4">
                            <div class="card-body">
                                <h5 class="card-title text-dark">${vacancy.title}</h5>
                                <p class="fw-bold text-success mb-3">${vacancy.salary!0} сом</p>
                                <a href="/vacancies/${vacancy.id}" class="btn btn-sm btn-outline-success">Подробнее о вакансии</a>
                            </div>
                        </div>
                    </div>
                </#list>
            <#else>
                <div class="col-12 text-center py-4">
                    <p class="text-muted fs-5">У этой компании пока нет открытых вакансий.</p>
                </div>
            </#if>
        </div>

        <div class="mt-4">
            <a href="/companies" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Назад к списку компаний</a>
        </div>
    </div>
</@main.layout>