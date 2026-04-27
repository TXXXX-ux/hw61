<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4 text-center">Восстановление пароля</h3>
                    <#if error??><div class="alert alert-danger">${error}</div></#if>
                    <#if message??><div class="alert alert-success">${message}</div></#if>
                    <form action="/auth/forgot_password" method="post">
                        <#if _csrf??><input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/></#if>
                        <p>Мы отправим ссылку для сброса на вашу почту:</p>
                        <input type="email" name="email" class="form-control mb-3" placeholder="Введите ваш e-mail" required autofocus/>
                        <button type="submit" class="btn btn-primary w-100">Отправить</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@main.layout>