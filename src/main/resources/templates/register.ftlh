<#import "/spring.ftl" as spring>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Регистрация</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-body p-5">
                            <h2 class="text-center mb-4">Регистрация</h2>
                            <form action="/auth/register" method="post">
                                <#if errorMessage??>
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </#if>
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                                </#if>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="example@mail.com" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Пароль</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="mb-4">
                                    <label for="accountType" class="form-label">Кто вы?</label>
                                    <select class="form-select" id="accountType" name="accountType">
                                        <#list types as type>
                                            <option value="${type}">${type}</option>
                                        </#list>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Создать аккаунт</button>
                            </form>
                            <div class="mt-3 text-center">
                                <a href="/auth/login">Уже есть аккаунт? Войти</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>