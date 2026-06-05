async function entrar() {
    console.log("entrou no entrar")
    const email = ipt_email.value;
    const senha = ipt_senha.value;


    try {
        const resposta = await fetch("http://localhost:3333/usuarios/autenticar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                emailServer: email,
                senhaServer: senha
    
            })
        });
        console.log("entrou fetch")
        
        if (resposta.ok) {
            const usuario = await resposta.json();
            console.log(`usuario é ${usuario}`)
            sessionStorage.ID_USUARIO = usuario.id;
            sessionStorage.NOME_USUARIO = usuario.nome;
            sessionStorage.EMAIL_USUARIO = usuario.email;
            sessionStorage.EMPRESA_ID = usuario.empresaId || (usuario.apiarios && usuario.apiarios[0] && usuario.apiarios[0].fk_empresa) || "";
            sessionStorage.CLASSE = usuario.classe; 
            sessionStorage.AQUARIOS = JSON.stringify(usuario.apiarios);        

            
            window.location.href = "./dashboard/dashboard.html";
            console.log(resposta)
        } else {
            const erro = await resposta.text();
            div_erro.innerHTML = erro;
        }
    } catch (err) {
        div_erro.innerHTML = "Erro de conexão: " + err.message;
    }
}

async function cadastrar() {
    let nome = ipt_nome.value.trim();
    let sobrenome = ipt_sobrenome.value.trim();
    let dataNasc = ipt_dataNasc.value;
    let cpf = ipt_cpf.value.trim();
    let email = ipt_email.value.trim();
    let senha = ipt_senha.value;
    let confirmacaoSenha = ipt_confirmacaoSenha.value;
    let confirmacaoCode = ipt_confirmacaoCodigo.value.trim();

    let condicoesErro = [
        nome == "" || cpf == "" || email == "" || senha == "" || confirmacaoSenha == "",
        nome == "" || nome.length <= 3,
        dataNasc == "",
        cpf.length != 11,
        !email.includes("@"),
        senha.length < 6,
        confirmacaoSenha != senha,
        confirmacaoCode == "" || isNaN(Number(confirmacaoCode))
    ];

    let mensagensErro = [
        "Todos campos são obrigatórios",
        "Nome inválido",
        "Preencha a data de nascimento",
        "CPF deve ter 11 dígitos",
        "E-mail deve conter @",
        "Senha muito curta (mínimo 6)",
        "Senhas não coincidem",
        "Insira o Código de ativação válido"
    ];

    for (let i = 0; i < condicoesErro.length; i++) {

        if (condicoesErro[i]) {
            div_erro.innerHTML = mensagensErro[i];

            return false;
        }
    }
    try {
        const resposta = await fetch("http://localhost:3333/usuarios/cadastrar", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                nomeServer: `${nome} ${sobrenome}`.trim(),
                emailServer: email,
                senhaServer: senha,
                fkEmpresaServer: Number(confirmacaoCode)
            })
        });

        if (resposta.ok) {
            window.location.href = "login.html";
        } else {
            const erro = await resposta.text();
            div_erro.innerHTML = erro;
        }
    } catch (erro) {
        div_erro.innerHTML = "Erro de conexão: " + erro.message;
    }
}

let enxamePreco = 450;
let custoSensor = 75;
let custoCaixas = 200;

function calculo() {

    let preco = Number(ipt_preco.value);
    let kilos = Number(ipt_kg.value);
    let qtdColmeia = Number(ipt_quantidade.value);
    let valorMan = Number(ipt_manutencao.value);
    let contrato = contrata.value;

    divMsg.innerHTML = "";
    if (
        preco <= 0 ||
        kilos <= 0 ||
        qtdColmeia <= 0 ||
        valorMan < 0 ||
        isNaN(preco) ||
        isNaN(kilos) ||
        isNaN(qtdColmeia) ||
        isNaN(valorMan)
    ) {
        divMsg.innerHTML = `<span style="color:red">Preencha todos os campos corretamente!</span>`;
        return;
    }
    let venda = preco * kilos * qtdColmeia;
    let custoManutencao = valorMan * qtdColmeia;
    let lucro = venda - custoManutencao;

    let reposicao =
        (qtdColmeia * 0.30 * custoCaixas) +
        (qtdColmeia * 0.30 * enxamePreco);

    let custoTotal = custoSensor * qtdColmeia;

    let roi = 0;
    if (custoTotal > 0) {
        roi = ((lucro * 0.3) - custoTotal) / custoTotal * 100;
    }

    if (contrato == 's') {

        divMsg.innerHTML += `Obrigado por confiar na Aliança Apis!<br><br>`;

        divMsg.innerHTML += `Você está evitando uma perda de até <b>R$ ${((lucro * 0.3) + reposicao).toFixed(2)}</b>.<br>`;

        divMsg.innerHTML += `Mantendo 100% da produção + reposição de colmeias.<br><br>`;

        divMsg.innerHTML += `ROI estimado: <b>${roi.toFixed(0)}%</b><br>`;

    }
    else {

        if (kilos < 45) {
            divMsg.innerHTML += `<span style="color:red">Produção abaixo do esperado! Pode haver problemas na colmeia.</span><br><br>`;
        }

        if (lucro < 0) {
            divMsg.innerHTML += `<span style="color:red">Você está tendo prejuízo na produção!</span><br><br>`;
        }

        divMsg.innerHTML += `Sem o serviço, você pode deixar de ganhar <b>R$ ${(lucro * 0.3).toFixed(2)}</b>.<br>`;

        divMsg.innerHTML += `Além disso, terá um custo de reposição de <b>R$ ${reposicao.toFixed(2)}</b>.<br><br>`;

        divMsg.innerHTML += `Nosso serviço custaria <b>R$ ${custoTotal.toFixed(2)}</b>.<br>`;

        divMsg.innerHTML += `ROI estimado: <b>${roi.toFixed(0)}%</b>`;
    }
}