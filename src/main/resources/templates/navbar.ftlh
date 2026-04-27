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
                <#if Session?? && Session.SPRING_SECURITY_CONTEXT??>
                    <#assign auth = Session.SPRING_SECURITY_CONTEXT.authentication>
                    <#if auth.authorities?seq_contains("ROLE_EMPLOYER")>
                        <li class="nav-item"><a class="nav-link" href="/resumes">База резюме</a></li>
                    </#if>
                </#if>
                <li class="nav-item"><a class="nav-link" href="/companies">Компании</a></li>
            </ul>
            <div class="navbar-nav">
                <a class="nav-link" href="/auth/profile">Мой профиль</a>
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