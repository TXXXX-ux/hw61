<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4">Создание резюме</h3>
                    <form action="/resumes/create" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                        </#if>
                        <div class="mb-3">
                            <label class="form-label">Желаемая должность</label>
                            <input type="text" name="title" class="form-control" placeholder="Например: Младший разработчик" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Расскажите о себе</label>
                            <textarea name="description" class="form-control" rows="8" placeholder="Ваш опыт, навыки, проекты..." required></textarea>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Сохранить и опубликовать</button>
                            <a href="/profile" class="btn btn-light">Отмена</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@main.layout>