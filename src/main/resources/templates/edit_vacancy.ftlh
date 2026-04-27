<#import "layout.ftlh" as main>
<#import "/spring.ftl" as spring>
<@main.layout>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4 text-warning">Редактирование вакансии</h3>
                    <form action="/vacancies/${vacancyId}/edit" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                        </#if>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Название должности</label>
                            <@spring.bind "vacancyDto.title"/>
                            <input type="text" name="title" class="form-control <#if spring.status.error>is-invalid</#if>" value="${spring.status.value!''}" required>
                            <#list spring.status.errorMessages as error><div class="invalid-feedback">${error}</div></#list>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Зарплата (сом)</label>
                            <@spring.bind "vacancyDto.salary"/>
                            <input type="number" name="salary" class="form-control <#if spring.status.error>is-invalid</#if>" value="${spring.status.value?c!''}" required>
                            <#list spring.status.errorMessages as error><div class="invalid-feedback">${error}</div></#list>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Описание обязанностей</label>
                            <@spring.bind "vacancyDto.description"/>
                            <textarea name="description" class="form-control <#if spring.status.error>is-invalid</#if>" rows="10" required>${spring.status.value!''}</textarea>
                            <#list spring.status.errorMessages as error><div class="invalid-feedback">${error}</div></#list>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-warning py-2">Сохранить изменения</button>
                            <a href="/vacancies/${vacancyId}" class="btn btn-light">Отмена</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@main.layout>