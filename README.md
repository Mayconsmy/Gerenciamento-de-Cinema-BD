
# Gerenciamento de Cinema - Banco de Dados 

Sobre o Projeto	:

O projeto tem como objetivo desenvolver um banco de dados para um Sistema de Gerenciamento de Cinema, focado em organização e controle de filmes, sessões, salas, ingressos, clientes e funcionários. 

Funcionalidades	
<details>
<summary><b></b>RF01</summary>
Cadastrar filmes: O sistema deve permitir o cadastro de filmes, incluindo informações como título, gênero, duração, classificação indicativa, sinopse e demais dados essenciais à sua exibição.
</details>

<details>
<summary><b></b>RF02</summary>
Atualizar e remover filmes - O sistema deve possibilitar a edição e exclusão de filmes previamente cadastrados, garantindo sempre a integridade dos dados relacionados às sessões.
</details>

<details>
<summary><b></b>RF03</summary>
Gerenciar salas de cinema - O sistema deve permitir o cadastro de salas, contendo dados como capacidade de assentos, tipo de sala e características estruturais.
</details> 

<details>
<summary><b></b>RF04</summary>
Atualizar e remover salas - O sistema deve oferecer a possibilidade de alterar ou excluir salas, assegurando que a operação só seja permitida quando não houver conflitos com sessões programadas.
</details>
<details>
<summary><b></b>RF05</summary>
Registrar programação das sessões - O sistema deve permitir o registro das sessões de cinema, associando filme, sala, data, horário e demais atributos necessários para o controle da programação.
</details>
<details>
<summary><b></b>RF06</summary>
Evitar conflitos na programação - O sistema deve impedir o cadastro de sessões que utilizem a mesma sala em horários sobrepostos.
</details>
<details>
<summary><b></b>RF07</summary>
Gerenciar venda de ingressos - O sistema deve registrar a venda de ingressos, vinculando cliente, sessão e quantidade adquirida.
</details>
<details>
<summary><b></b>RF08</summary>
Controlar limite de assentos - O sistema deve verificar automaticamente a disponibilidade de assentos antes de aprovar a venda, bloqueando vendas acima da capacidade da sala.
</details>
<details>
<summary><b></b>RF09</summary>
Cadastrar clientes - O sistema deve permitir o cadastro de clientes, contendo nome, documento e informações de contato, para possibilitar a emissão de ingressos e controle de vendas.
</details>
<details>
<summary><b></b>RF10</summary>
Identificar clientes nas compras - O sistema deve permitir que cada venda seja associada a um cliente cadastrado ou marcada como venda avulsa, conforme necessidade do cinema.
</details>
<details>
<summary><b></b>RF11</summary>
Gerenciar funcionários - O sistema deve permitir o cadastro e gerenciamento de funcionários, incluindo dados pessoais, função e possíveis níveis de acesso.
</details>
<details>
<summary><b></b>RF12</summary>
Registrar operações inteiras - O sistema deve registrar quais funcionários realizaram determinadas operações, contribuindo para o controle e segurança do ambiente.
</details>
<details>
<summary><b></b>RF13</summary>
Consultar dados gerais do cinema - O sistema deve permitir consultas relacionadas a filmes, sessões, ingressos vendidos, ocupação das salas, histórico de exibições e demais informações relevantes para a gestão.
</details>
<details>
<summary><b></b>RF14</summary>
Emitir relatórios gerenciados - O sistema deve gerar relatórios, como total de vendas por sessão, filmes mais assistidos, capacidade ocupada e demais indicadores úteis à administração.
</details>

