<#import "layout.ftlh" as main>
<@main.layout>
    <h2 class="mb-4 text-center">Актуальные вакансии</h2>

    <form action="/vacancies" method="get" class="mb-4 d-flex justify-content-end">
        <select name="sortType" class="form-select w-auto me-2">
            <option value="date" <#if currentSort?? && currentSort == 'date'>selected</#if>>По дате публикации</option>
            <option value="responses" <#if currentSort?? && currentSort == 'responses'>selected</#if>>По количеству откликов</option>
        </select>
        <button type="submit" class="btn btn-secondary">Сортировать</button>
    </form>

    <div class="row">
        <#if vacanciesPage?? && vacanciesPage.content?size gt 0>
            <#list vacanciesPage.content as vacancy>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-primary">${vacancy.title}</h5>
                            <p class="card-text">${vacancy.description!""}</p>
                            <p class="fw-bold text-success">${vacancy.salary!0} сом</p>
                        </div>
                        <div class="card-footer bg-transparent border-top-0 pb-3">
                            <#if Session?? && Session.SPRING_SECURITY_CONTEXT??>
                                <#assign auth = Session.SPRING_SECURITY_CONTEXT.authentication>
                                <#if auth.authorities?seq_contains("ROLE_EMPLOYER")>
                                    <a href="/vacancies/${vacancy.id}" class="btn btn-outline-primary w-100">
                                        Управление
                                    </a>
                                <#elseif auth.authorities?seq_contains("ROLE_APPLICANT")>
                                    <a href="/vacancies/${vacancy.id}" class="btn btn-primary w-100">
                                        Откликнуться
                                    </a>
                                </#if>
                            <#else>
                                <a href="/vacancies/${vacancy.id}" class="btn btn-primary w-100">
                                    Подробнее
                                </a>
                            </#if>
                        </div>
                    </div>
                </div>
            </#list>
        <#else>
            <p class="text-center text-muted">Вакансий пока нет.</p>
        </#if>
    </div>

    <#if vacanciesPage?? && vacanciesPage.totalPages gt 1>
        <div class="d-flex justify-content-center mt-4">
            <ul class="pagination">
                <li class="page-item <#if !vacanciesPage.hasPrevious()>disabled</#if>">
                    <a class="page-link" href="?page=${vacanciesPage.number - 1}&sortType=${currentSort!'date'}">Назад</a>
                </li>
                <li class="page-item disabled">
                    <span class="page-link">Страница ${vacanciesPage.number + 1} из ${vacanciesPage.totalPages}</span>
                </li>
                <li class="page-item <#if !vacanciesPage.hasNext()>disabled</#if>">
                    <a class="page-link" href="?page=${vacanciesPage.number + 1}&sortType=${currentSort!'date'}">Вперед</a>
                </li>
            </ul>
        </div>
    </#if>
</@main.layout>