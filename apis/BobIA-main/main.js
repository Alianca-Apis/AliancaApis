// importando as bibliotecas necessárias
const { GoogleGenAI } = require("@google/genai");
const express = require("express");
const path = require("path");

// carregando as variáveis de ambiente do projeto do arquivo .env
require("dotenv").config();

// configurando o servidor express
const app = express();
const PORTA_SERVIDOR = process.env.PORTA;

// configurando o gemini (IA)
const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });

// configurando o servidor para receber requisições JSON
app.use(express.json());

// configurando o servidor para servir arquivos estáticos
app.use(express.static(path.join(__dirname, "public")));

// configurando CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

// inicializando o servidor
app.listen(PORTA_SERVIDOR, () => {
    console.info(
        `
        ######                ###    #    
        #     #  ####  #####   #    # #   
        #     # #    # #    #  #   #   #  
        ######  #    # #####   #  #     # 
        #     # #    # #    #  #  ####### 
        #     # #    # #    #  #  #     # 
        ######   ####  #####  ### #     # 
        `
    );
    console.info(`A API BobIA iniciada, acesse http://localhost:${PORTA_SERVIDOR}`);
});

// rota para receber perguntas e gerar respostas
app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        console.error(error);
        res.status(503).json({ erro: 'Serviço de IA indisponível. Tente novamente.' });
    }
});

// função para gerar respostas usando o gemini
    async function gerarResposta(mensagem) {
        const tentativas = 3;

        for (let i = 0; i < tentativas; i++) {
            try {
    const modeloIA = chatIA.models.generateContent({
        model: "gemini-2.5-flash",
        contents: [
            {
                role: "user",
                parts: [{ text: mensagem }]
            }
        ],
        config: {                
            systemInstruction:`
                Você é o N3, assistente técnico interno da Aliança Apis.

                Seu papel é apoiar técnicos de suporte que estão interpretando dados do dashboard e precisam orientar ações corretivas rapidamente.

                CONTEXTO DO SISTEMA:
                - Temperatura ideal de colmeia: 34,5°C a 36°C
                - Faixa de alerta: 30°C a 34,4°C ou 36,1°C a 40°C  
                - Faixa crítica: abaixo de 30°C ou acima de 40°C
                - O dashboard monitora apiários por empresa, com sensores individuais por apiário

                VOCÊ RESPONDE SOBRE:
                - Interpretação de leituras de temperatura das colmeias
                - O que fazer diante de leituras em alerta ou críticas
                - Quando e como escalar para o apicultor responsável
                - Problemas técnicos no dashboard (KPIs não carregando, alertas não disparando, sensor sem leitura recente)
                - Variações esperadas de temperatura por condição climática ou época do ano

                VOCÊ NÃO RESPONDE SOBRE:
                - Assuntos fora do contexto de apiários e monitoramento
                - Questões administrativas, financeiras ou comerciais

                COMO SE COMPORTAR:
                - Respostas curtas e diretas — o técnico está em atendimento, sem tempo pra enrolação
                - Se a situação for crítica (temperatura fora da faixa crítica por tempo prolongado), oriente acionar o apicultor imediatamente
                - Se faltar informação, faça UMA pergunta por vez — nunca múltiplas perguntas juntas
                - Nunca invente leituras ou afirme dados que o técnico não informou
                - Para problemas no dashboard, investigue antes de descartar: sensor ativo? Há leituras recentes? O alerta foi configurado?

                TOM: técnico e direto, sem ser robótico. Você é suporte especializado, não um chatbot genérico.
            `,
            maxOutputTokens: 150,
            temperature: 0.3,
            thinkingConfig: {
                thinkingBudget: 0         
            }
        }
    });

            const resposta = (await modeloIA).text;
            const tokens = (await modeloIA).usageMetadata;

            console.log(resposta);
            console.log("Uso de Tokens:", tokens);

            return resposta;

        } catch (error) {
            const is503 = error?.message?.includes('503');

            if (is503 && i < tentativas - 1) {
                const espera = 2000 * (i + 1);
                console.log(`Tentativa ${i + 1} falhou (503). Aguardando ${espera / 1000}s...`);
                await new Promise(res => setTimeout(res, espera));
            } else {
                console.error(error);
                throw error;
            }
        }
    }
}