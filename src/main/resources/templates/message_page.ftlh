<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-5 text-center">
        <h2 class="text-success">Успешно!</h2>
        <p class="fs-5 mt-3">${message!""}</p>
        <a href="/auth/login" class="btn btn-primary mt-3">Перейти ко входу</a>
    </div>
</@main.layout>