<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4 text-info">Редактирование резюме</h3>
                    <form action="/resumes/${resumeId}/edit" method="post">
                        <#if _csrf??>
                            <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                        </#if>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Желаемая должность</label>
                            <input type="text" name="title" class="form-control" value="${resumeDto.title}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Опыт и навыки</label>
                            <textarea name="description" class="form-control" rows="10" required>${resumeDto.description}</textarea>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-info text-white">Сохранить изменения</button>
                            <a href="/resumes/${resumeId}" class="btn btn-light">Отмена</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@main.layout>