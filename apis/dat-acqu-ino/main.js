const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');

const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 5000;
const HABILITAR_OPERACAO_INSERIR = true;

const serial = async (
    valoresSensorAnalogico,
    valoresSensorDigital,
) => {
    let poolBancoDados = mysql.createPool(
        {
            host: '10.18.32.185',
            user: 'aluno',
            password: 'Sptech#2024',
            database: 'aliancaapis',
            port: 3307
        }
    ).promise();

    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);

    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }

    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        console.log(data);
        const valores = data.split(';');
        const lm35 = parseInt(valores[0]);
        valoresSensorDigital.push(lm35);

        if (HABILITAR_OPERACAO_INSERIR) {
            await poolBancoDados.execute(
                'INSERT INTO leitura (temperatura, dataHora, fkSensor) VALUES (?, NOW(), 1)',
                [lm35]
            );
            console.log("Valores inseridos no banco: " + lm35);

            const [[{ id }]] = await poolBancoDados.execute('SELECT LAST_INSERT_ID() as id');

            if (lm35 < 33 || lm35 > 38.5) {
                const descricao = lm35 < 33
                    ? `❆ CRÍTICO: Temperatura perigosamente baixa (${lm35}°C)`
                    : `☀ CRÍTICO: Superaquecimento da colmeia (${lm35}°C)`;

                await poolBancoDados.execute(
                    'INSERT INTO alerta (descricaoAlerta, dataHora, fkSensor, fkLeitura) VALUES (?, NOW(), 1, ?)',
                    [descricao, id]
                );
                console.log("Alerta gravado: " + descricao);
            }
        }
    });

    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`);
    });
}

const servidor = (
    valoresSensorAnalogico,
    valoresSensorDigital
) => {
    const app = express();

    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    app.get('/sensores/analogico', (_, response) => {
        return response.json(valoresSensorAnalogico);
    });

    app.get('/sensores/digital', (_, response) => {
        return response.json(valoresSensorDigital);
    });
}

(async () => {
    const valoresSensorAnalogico = [];
    const valoresSensorDigital = [];

    await serial(
        valoresSensorAnalogico,
        valoresSensorDigital
    );

    servidor(
        valoresSensorAnalogico,
        valoresSensorDigital
    );
})();