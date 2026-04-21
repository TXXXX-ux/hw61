<#import "layout.ftlh" as main>
<@main.layout>
    <div class="card shadow-sm border-0 mb-4">
        <div class="profile-header d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Личный кабинет: ${user.name}</h4>
            <div class="d-flex gap-2">
                <a href="/profile/edit" class="btn btn-light btn-sm">Редактировать</a>
            </div>
        </div>
        <div class="card-body p-4">
            <div class="row align-items-center mb-4">
                <div class="col-auto">
                    <#if user.avatar??>
                        <img src="/static/images/${user.avatar}"
                             class="rounded-circle shadow-sm"
                             style="width: 100px; height: 100px; object-fit: cover;"
                             alt="Avatar">
                    <#else>
                        <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center text-white"
                             style="width: 100px; height: 100px; font-size: 40px;">
                            ${user.name?substring(0,1)}
                        </div>
                    </#if>
                </div>
                <div class="col">
                    <h3 class="mb-1">${user.name}</h3>
                    <p class="text-muted mb-0"><i class="bi bi-envelope"></i> ${user.email}</p>
                    <span class="badge bg-primary mt-2">${user.accountType}</span>
                </div>
            </div>

            <#if user.accountType == "EMPLOYER">
                <div class="admin-section mb-4">
                    <h5 class="fw-bold">Панель работодателя</h5>
                    <div class="row g-2 mt-2">
                        <div class="col-md-6">
                            <a href="/vacancies" class="btn btn-outline-danger w-100 text-start">Мои вакансии</a>
                        </div>
                        <div class="col-md-6">
                            <a href="/resumes/create" class="btn btn-info w-100 text-start text-white">Опубликовать резюме</a>
                        </div>
                        <div class="col-md-6">
                            <a href="/resumes" class="btn btn-outline-secondary w-100 text-start">Базовые резюме</a>
                        </div>
                    </div>
                </div>
            <#else>
                <div class="user-section mb-4">
                    <h5 class="fw-bold">Моя карьера</h5>
                    <div class="row g-2 mt-2">
                        <div class="col-md-6">
                            <a href="/resumes" class="btn btn-outline-info w-100 text-start">Мои резюме</a>
                        </div>
                        <div class="col-md-6">
                            <a href="/resumes/create" class="btn btn-info w-100 text-start text-white">Опубликовать резюме</a>
                        </div>
                        <div class="col-md-6">
                            <a href="/vacancies" class="btn btn-outline-dark w-100 text-start">Искать вакансии</a>
                        </div>
                    </div>
                </div>
            </#if>

            <hr>
            <div class="about-section mb-4">
                <h6 class="fw-bold">О себе:</h6>
                <div class="p-3 bg-light rounded">
                    ${user.about!"Тут пока пусто..."}
                </div>
            </div>

            <div class="mt-5">
                <#if user.accountType == "EMPLOYER">
                    <h5 class="fw-bold mb-3">Опубликованные вакансии (список)</h5>
                    <#if vacanciesPage?? && vacanciesPage.content?size gt 0>
                        <div class="list-group mb-3">
                            <#list vacanciesPage.content as vacancy>
                                <a href="/vacancies/${vacancy.id}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-0">${vacancy.title}</h6>
                                        <small class="text-muted">Зарплата: ${vacancy.salary!0} сом</small>
                                    </div>
                                </a>
                            </#list>
                        </div>

                        <#if vacanciesPage.totalPages gt 1>
                            <ul class="pagination pagination-sm">
                                <li class="page-item <#if !vacanciesPage.hasPrevious()>disabled</#if>">
                                    <a class="page-link" href="?page=${vacanciesPage.number - 1}">Назад</a>
                                </li>
                                <li class="page-item disabled">
                                    <span class="page-link">Стр. ${vacanciesPage.number + 1} из ${vacanciesPage.totalPages}</span>
                                </li>
                                <li class="page-item <#if !vacanciesPage.hasNext()>disabled</#if>">
                                    <a class="page-link" href="?page=${vacanciesPage.number + 1}">Вперед</a>
                                </li>
                            </ul>
                        </#if>
                    <#else>
                        <p class="text-muted">У вас пока нет активных вакансий.</p>
                    </#if>

                <#else>
                    <h5 class="fw-bold mb-3">Мои резюме (список)</h5>
                    <#if resumesPage?? && resumesPage.content?size gt 0>
                        <div class="list-group mb-3">
                            <#list resumesPage.content as resume>
                                <a href="/resumes/${resume.id}" class="list-group-item list-group-item-action">
                                    <h6 class="mb-0">${resume.title}</h6>
                                </a>
                            </#list>
                        </div>

                        <#if resumesPage.totalPages gt 1>
                            <ul class="pagination pagination-sm">
                                <li class="page-item <#if !resumesPage.hasPrevious()>disabled</#if>">
                                    <a class="page-link" href="?page=${resumesPage.number - 1}">Назад</a>
                                </li>
                                <li class="page-item disabled">
                                    <span class="page-link">Стр. ${resumesPage.number + 1} из ${resumesPage.totalPages}</span>
                                </li>
                                <li class="page-item <#if !resumesPage.hasNext()>disabled</#if>">
                                    <a class="page-link" href="?page=${resumesPage.number + 1}">Вперед</a>
                                </li>
                            </ul>
                        </#if>
                    <#else>
                        <p class="text-muted">Вы еще не создали ни одного резюме.</p>
                    </#if>
                </#if>
            </div>
        </div>
    </div>
</@main.layout>