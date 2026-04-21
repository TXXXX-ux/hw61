<#import "layout.ftlh" as main>
<@main.layout>
    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/vacancies">Вакансии</a></li>
                <li class="breadcrumb-item active">${vacancy.title}</li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0 p-4">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <h2 class="text-primary">${vacancy.title}</h2>
                    <p class="text-success fw-bold fs-4">${vacancy.salary!0} сом</p>
                </div>
                <span class="badge bg-secondary">Опубликовано: ${vacancy.publishedDate!"Недавно"}</span>
            </div>
            <hr>
            <h5>Описание вакансии</h5>
            <p class="mt-3" style="white-space: pre-wrap;">${vacancy.description!"Описание отсутствует"}</p>
            <div class="mt-4">
                <button class="btn btn-primary px-5">Отправить отклик</button>
                <a href="/vacancies" class="btn btn-outline-secondary ms-2">Назад к списку</a>
            </div>
        </div>
    </div>
</@main.layout>