CREATE DATABASE IF NOT EXISTS smp_servicos CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smp_servicos;

CREATE TABLE IF NOT EXISTS empresas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cnpj VARCHAR(20) NOT NULL UNIQUE,
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS faturamentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  valor DECIMAL(12,2) NOT NULL,
  mes_referencia CHAR(7) NOT NULL,
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_faturamento_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE,
  CONSTRAINT uq_empresa_mes UNIQUE (empresa_id, mes_referencia)
);

CREATE TABLE IF NOT EXISTS impostos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  vencimento DATE NOT NULL,
  valor DECIMAL(12,2) NOT NULL,
  situacao ENUM('Pago','Pendente','Atrasado') NOT NULL DEFAULT 'Pendente',
  observacao VARCHAR(255),
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_imposto_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
);

-- Dados fictícios para demonstração acadêmica.
INSERT IGNORE INTO empresas (id,nome,cnpj) VALUES
(1,'Comercial Alfa Ltda','12.345.678/0001-90'),
(2,'Beta Serviços ME','98.765.432/0001-11'),
(3,'Gamma Consultoria','11.222.333/0001-44');

INSERT IGNORE INTO faturamentos (empresa_id,valor,mes_referencia) VALUES
(1,25800.00,DATE_FORMAT(CURRENT_DATE,'%Y-%m')),
(2,18450.00,DATE_FORMAT(CURRENT_DATE,'%Y-%m')),
(3,42300.00,DATE_FORMAT(CURRENT_DATE,'%Y-%m'));

INSERT INTO impostos (empresa_id,nome,vencimento,valor,situacao,observacao)
SELECT 1,'Simples Nacional',DATE_ADD(CURRENT_DATE,INTERVAL 5 DAY),2580.00,'Pago','Dado fictício'
WHERE NOT EXISTS (SELECT 1 FROM impostos WHERE empresa_id=1 AND nome='Simples Nacional');
INSERT INTO impostos (empresa_id,nome,vencimento,valor,situacao,observacao)
SELECT 1,'ISS',DATE_SUB(CURRENT_DATE,INTERVAL 2 DAY),450.00,'Atrasado','Dado fictício'
WHERE NOT EXISTS (SELECT 1 FROM impostos WHERE empresa_id=1 AND nome='ISS');
INSERT INTO impostos (empresa_id,nome,vencimento,valor,situacao,observacao)
SELECT 1,'IRPJ',DATE_ADD(CURRENT_DATE,INTERVAL 10 DAY),1200.00,'Pendente','Dado fictício'
WHERE NOT EXISTS (SELECT 1 FROM impostos WHERE empresa_id=1 AND nome='IRPJ');
