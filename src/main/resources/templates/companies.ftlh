<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">
        <h2 class="mb-4 text-center">Зарегистрированные компании</h2>
        <div class="row">
            <#if companiesPage?? && companiesPage.content?size gt 0>
                <#list companiesPage.content as company>
                    <div class="col-md-6 mb-3">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">${company.name}</h5>
                                <p class="card-text text-muted">Email: ${company.email}</p>
                                <a href="/companies/${company.id}" class="btn btn-sm btn-outline-primary">Посмотреть вакансии компании</a>
                            </div>
                        </div>
                    </div>
                </#list>
            <#else>
                <p class="text-center text-muted">Компаний пока нет.</p>
            </#if>
        </div>

        <#if companiesPage?? && companiesPage.totalPages gt 1>
            <div class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <li class="page-item <#if !companiesPage.hasPrevious()>disabled</#if>">
                        <a class="page-link" href="?page=${companiesPage.number - 1}">Назад</a>
                    </li>
                    <li class="page-item disabled">
                        <span class="page-link">Страница ${companiesPage.number + 1} из ${companiesPage.totalPages}</span>
                    </li>
                    <li class="page-item <#if !companiesPage.hasNext()>disabled</#if>">
                        <a class="page-link" href="?page=${companiesPage.number + 1}">Вперед</a>
                    </li>
                </ul>
            </div>
        </#if>
    </div>
</@main.layout>