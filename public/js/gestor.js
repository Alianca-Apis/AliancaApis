const classeUsuario = sessionStorage.getItem("CLASSE");

if (classeUsuario == "gestor") {
    sidebar.innerHTML += `
        <a href="../cadastro.html"><i class="fa-solid fa-user-plus"></i>Cadastro</a>
        <a href="https://aliancaapis.atlassian.net/servicedesk/customer/portal/1"><i class="fa-solid fa-headset"></i>Central de Atendimento</a>
        <hr>   `
}
