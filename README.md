# SMP Serviços — MVP de Gestão Contábil

Projeto acadêmico para organizar o cadastro de empresas, registrar faturamento mensal e acompanhar manualmente a situação de impostos.

## Funcionalidades
- Painel inicial com indicadores.
- Cadastro e consulta de empresas.
- Registro de faturamento por mês de referência.
- Registro e consulta de impostos: Pago, Pendente ou Atrasado.
- Histórico de faturamento e impostos por empresa.

## Tecnologias
Python, Flask, HTML/CSS, MySQL 8 e Docker Compose.

## Como executar no Windows
1. Instale Python 3.11+ e Docker Desktop.
2. Extraia os arquivos e abra o terminal nessa pasta.
3. Inicie o banco: `docker compose up -d`
4. Crie ambiente virtual: `py -m venv .venv`
5. Ative: `.venv\\Scripts\\activate`
6. Instale dependências: `pip install -r requirements.txt`
7. Execute: `py app.py`
8. Acesse `http://127.0.0.1:5000`.

## Banco de dados
Host `127.0.0.1`, porta `3307`, banco `smp_servicos`, usuário `smp_user`, senha local `smp_dev_password`.

## Limites
Os dados são inseridos manualmente; não há integração automática com sistemas governamentais ou SAP. Use apenas dados fictícios. As credenciais do Docker são apenas para desenvolvimento local, não para produção.
