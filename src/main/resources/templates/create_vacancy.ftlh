<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4">Новая вакансия</h3>
                    <form action="/vacancies/create" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                        </#if>
                        <div class="mb-3">
                            <label class="form-label">Название должности</label>
                            <input type="text" name="title" class="form-control" placeholder="Например: Java Developer" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Предлагаемая зарплата (сом)</label>
                            <input type="number" name="salary" class="form-control" placeholder="50000" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Полное описание</label>
                            <textarea name="description" class="form-control" rows="6" placeholder="Опишите требования и обязанности" required></textarea>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success">Опубликовать</button>
                            <a href="/profile" class="btn btn-light">Отмена</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@main.layout>