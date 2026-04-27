<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm p-4">
                    <h3 class="mb-4 text-center">Создайте новый пароль</h3>
                    <#if error??>
                        <div class="alert alert-danger">${error}</div>
                    <#else>
                        <form action="/auth/reset_password" method="post">
                            <#if _csrf??><input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/></#if>
                            <input type="hidden" name="token" value="${token!}">
                            <input type="password" name="password" class="form-control mb-3" placeholder="Введите новый пароль" required autofocus/>
                            <button type="submit" class="btn btn-success w-100">Сменить пароль</button>
                        </form>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</@main.layout>