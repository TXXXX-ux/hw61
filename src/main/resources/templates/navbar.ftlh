<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/vacancies">
            <i class="bi bi-briefcase-fill"></i> JobPortal
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/vacancies">Вакансии</a></li>

                <#if user??>
                    <#if user.accountType == "EMPLOYER">
                        <li class="nav-item"><a class="nav-link" href="/resumes">Резюме</a></li>
                    <#else>
                        <li class="nav-item"><a class="nav-link" href="/companies">Компании</a></li>
                    </#if>
                <#else>
                    <li class="nav-item"><a class="nav-link" href="/resumes">Резюме</a></li>
                    <li class="nav-item"><a class="nav-link" href="/companies">Компании</a></li>
                </#if>
            </ul>
            <div class="navbar-nav">
                <a class="nav-link" href="/profile">Мой профиль</a>
                <form action="/logout" method="post" class="ms-lg-3">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'_csrf'}" value="${(_csrf.token)!''}"/>
                    </#if>
                    <button type="submit" class="btn btn-outline-danger btn-sm">Выйти</button>
                </form>
            </div>
        </div>
    </div>
</nav>