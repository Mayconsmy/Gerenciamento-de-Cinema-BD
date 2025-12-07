Com certeza. Baseado no conteúdo do PDF **"Projeto final - Banco de Dados"**  e nos scripts desenvolvidos na nossa conversa, criei um arquivo `README.md` estruturado.

Este arquivo é ideal para colocar no repositório do projeto, pois explica o contexto (resumindo Introdução e Requisitos), instrui como rodar (seguindo a ordem dos scripts) e mostra como testar.

-----

# Sistema de Gerenciamento de Cinema (SGC)

Este repositório contém os scripts de banco de dados para o projeto final da disciplina de Banco de Dados (UFERSA, 2025).

## 📋 Sobre o Projeto

O SGC foi modelado para otimizar as rotinas operacionais de um cinema, garantindo a integridade das vendas e o controle de lotação das salas. O banco de dados está normalizado na 3ª Forma Normal (3FN).

**Funcionalidades Principais:**

  * Cadastro de Filmes, Salas e Funcionários.
  * Programação de Sessões com controle de horários.
  * Venda de Ingressos com bloqueio automático de lotação (Trigger).
  * Relatórios Gerenciais de faturamento e ocupação.



## Execução


### 1\. Criação da Estrutura (DDL)

Execute o script `1_create_tables.sql` para criar as tabelas com os tipos e chaves corretas (`SERIAL`, `VARCHAR`, `NUMERIC`) .

  * **Tabelas:** `filme`, `sala`, `cliente`, `funcionario`, `sessao`, `ingresso`.

### 2\. Carga de Dados (DML)

Execute o script `2_insert_data.sql` para popular o banco com dados iniciais de teste (Filmes, Salas 2D/3D, Clientes e Sessões).

### 3\. Lógica de Negócio (Triggers & Functions)

Execute o script `3_functions_triggers.sql`.

  * **Função:** `verificar_capacidade()` - Conta assentos ocupados.
  * **Trigger:** `trg_verificar_lotacao` - Impede vendas que excedam a capacidade da sala.

### 4\. Relatórios (Views)

Execute o script `4_create_views.sql` para criar as visões de relatório:

  * `view_relatorio_vendas`: Faturamento por sessão.
  * `view_ocupacao_salas`: Porcentagem de ocupação em tempo real.

-----

## Testes

Após rodar os scripts acima, execute os comandos abaixo para validar os requisitos:

### Teste 1: Venda de Ingresso (Caminho Feliz)

```sql
INSERT INTO ingresso (quantidade, id_sessao, id_cliente, id_funcionario) 
VALUES (1, 1, 1, 1);
-- Resultado: Sucesso. Ingresso registrado.
```

### Teste 2: Bloqueio de Lotação (Regra de Negócio)

Tente vender mais ingressos do que a capacidade da sala suporta.

```sql
-- Supondo uma sala com capacidade 50, tente inserir 51
INSERT INTO ingresso (quantidade, id_sessao, id_cliente, id_funcionario) 
VALUES (100, 1, 1, 1);
-- Resultado: ERRO! "Venda não autorizada: Capacidade da sala excedida."
```

### Teste 3: Relatórios Gerenciais

Consulte as Views para ver os indicadores atualizados.

```sql
SELECT * FROM view_relatorio_vendas;
SELECT * FROM view_ocupacao_salas WHERE porcentagem_ocupacao > 0;
```


## 👥 Autores

  * Caio Fontes Soares
  * Isabel de Paiva Freire
  * Ítallo Vicente de Mesquita
  * Maycon Soares Maia
  * Pedro Henrique Pereira de Sousa

