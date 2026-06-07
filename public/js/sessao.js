function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var b_usuario = document.getElementById("b_usuario");

    if (email != null && nome != null) {
        b_usuario.innerHTML = nome;
    } else {
        window.location = "../login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

const classeUsuario = sessionStorage.getItem("CLASSE");

if (classeUsuario == "gestor") {
    sidebar.innerHTML += `
        <a href="../cadastro.html"><i class="fa-solid fa-user-plus"></i>Cadastro</a>
        <a href="https://aliancaapis.atlassian.net/servicedesk/customer/portal/1"><i class="fa-solid fa-headset"></i>Central de Atendimento</a>
        <hr>   
        <a onclick="limparSessao()" href="../login.html" id="btn-sair"><i class="fa-solid fa-right-from-bracket"></i>Sair</a>
        `
} else if (classeUsuario == "n3") {
    sidebar.innerHTML += `
        <a href="../cadastro.html"><i class="fa-solid fa-user-plus"></i>Cadastro</a>
        <a href="https://aliancaapis.atlassian.net/servicedesk/customer/portal/1"><i class="fa-solid fa-headset"></i>Central de Atendimento</a>
        <hr>   
        <a href="http://localhost:3000" id=""><i class="fa-solid fa-right fa-microchip"></i>Bob IA</a>
        <hr>   
        <a href="../n3.html" id=""><i class="fa-solid fa-right-from-bracket"></i>Sair</a>
        `
} else {
    sidebar.innerHTML += `
        <a onclick="limparSessao()" href="../login.html" id="btn-sair"><i class="fa-solid fa-right-from-bracket"></i>Sair</a>
        `
}


