function entrar() {
    let email = ipt_email.value;
    let senha = ipt_senha.value;
    if (email == "usuario@aliacaapis.com" && senha == "urubu100") {
        window.location.href = "dashboard.html";
    } else {
        alert("Informações incorretas!");
    }
    console.log(senha)
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

// CALCULADORA / SIMULADOR FINANCEIRO
    let enxamePreco = 450;
    let custoSensor = 75;
    let custoCaixas = 200;

    function calculo(){
        let preco = Number(ipt_preco.value);
        let kilos = Number(ipt_kg.value);
        let qtdColmeia = Number(ipt_quantidade.value);
        let valorMan = Number(ipt_manutencao.value)
        let venda = preco * kilos * qtdColmeia;
        let custoManutencao = valorMan * qtdColmeia;
        let lucro = (venda * 0.30) - custoManutencao;
        let reposicao = ((qtdColmeia * 0.30) * custoCaixas) + ((qtdColmeia * 0.30) * enxamePreco);
        let custoTotal = custoSensor * qtdColmeia;
        let roi = ((lucro - custoTotal) / custoTotal) * 100
        let contrato = contrata.value

        divMsg.innerHTML = " ";

        if(contrato == 's'){

        divMsg.innerHTML += `Obrigado por confiar em nós da Aliança Apis<br>`

        divMsg.innerHTML += `Com o nosso serviço contratado você está evitando uma perda de até R$${(lucro + reposicao).toFixed(2)}.<br>Contando com a receita da produção de mel em 100% e com reposição de colmeias<br>`

        divMsg.innerHTML += `Assim obtendo um ROI de ${roi.toFixed(0)}%`

    } else {

        if(kilos < 45){
            divMsg.innerHTML += `<span style="color: red">Suas abelhas produzem abaixo do nível esperado pode haver algo de errado!!</span><br>`
        }

        divMsg.innerHTML += `Caso você não adquira nosso serviço você pode deixar de ter um faturamento de R$${lucro.toFixed(2)}, considerando que 36% da população geral de abelhas é afetada pelo DCC!<br>`

        divMsg.innerHTML += `Além do faturamento perdido você terá um prejuizo de R$${reposicao.toFixed(2)} de reposição.<br> Com os gastos de novos enxames e aquisição de novas caixas colmeia.<br>`

        divMsg.innerHTML += `Caso adquira o nosso serviço que custaria R$${custoTotal.toFixed(2)} você terá um ROI estimado de ${roi.toFixed(0)}%`
    }
    
}