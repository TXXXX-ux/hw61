<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Вход</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class="card shadow-sm">
                        <div class="card-body p-5">
                            <h2 class="text-center mb-4">Вход</h2>
                            <#if RequestParameters.error??>
                                <div class="alert alert-danger">Неверный email или пароль</div>
                            </#if>
                            <form action="/login" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                </#if>
                                <div class="mb-3">
                                    <label for="username" class="form-label">Email (Логин)</label>
                                        <input type="text" class="form-control" id="username" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Пароль</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Войти</button>
                            </form>
                            <div class="mt-3 text-center">
                                <a href="/auth/register">Нет аккаунта? Зарегистрироваться</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>