function entrar() {
    let email = ipt_email.value;
    let senha = ipt_senha.value;
    if (email == "usuario@aliacaapis.com" && senha == "urubu100") {
        window.location.href = "dashboardPH.html";
    } else {
        alert("Informações incorretas!");
    }
}

function cadastrar() {
    let nome = ipt_nome.value;
    let cpf = ipt_cpf.value;
    let email = ipt_email.value;
    let senha = ipt_senha.value;
    let confirmacaoSenha = ipt_confirmacaoSenha.value;

    let condicoesErro = [
        nome == "" || cpf == "" || email == "" || senha == "" || confirmacaoSenha == "",
        nome == "" || nome.length <= 1,
        cpf.length !== 11,
        !email.includes("@"),
        senha.length < 6,
        confirmacaoSenha !== senha,
    ];

    let mensagensErro = [
        "Todos campos são obrigatórios",
        "Nome inválido",
        "CPF deve ter 11 dígitos",
        "E-mail deve conter @",
        "Senha muito curta (mínimo 6)",
        "Senhas não coincidem"
    ];

    for (let i = 0; i < condicoesErro.length; i++) {

        if (condicoesErro[i]) {
            div_erro.innerHTML = mensagensErro[i];

            return false;
        }
    }
    alert('INDISPONÍVEL NO MOMENTO, TENTE NOVAMENTE MAIS TARDE')
}