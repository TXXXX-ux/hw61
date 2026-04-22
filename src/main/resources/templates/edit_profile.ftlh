<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="UTF-8">
        <title>Редактирование профиля</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4 class="mb-0">Редактирование данных</h4>
                        </div>
                        <div class="card-body">
                            <form action="/profile/edit" method="post" enctype="multipart/form-data">
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                </#if>
                                <div class="mb-3">
                                    <label for="name" class="form-label">Имя / Название компании</label>
                                    <input type="text"
                                    class="form-control"
                                    id="name"
                                    name="name"
                                    value="${user.name!''}"
                                    placeholder="Введите ваше имя">
                                </div>
                                    <div class="mb-3">
                                        <label for="photo" class="form-label">Фото профиля</label>
                                        <input type="file"
                                        name="photo"
                                        id="photo"
                                        class="form-control"
                                        accept=".png, .jpg, .jpeg, .gif">
                                    </div>
                                <div class="mb-3">
                                    <label for="about" class="form-label">Информация о себе</label>
                                    <textarea class="form-control"
                                    id="about"
                                    name="about"
                                    rows="6"
                                    placeholder="Расскажите о себе...">${user.about!''}</textarea>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <a href="/profile" class="btn btn-secondary">Отмена</a>
                                    <button type="submit" class="btn btn-success">Сохранить изменения</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
