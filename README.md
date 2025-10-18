# 📊 Projeto ERP & Análise de Vendas com MySQL

Este projeto contém a **estrutura completa (DDL)** e o **processo de carga de dados (DML)** para um banco de dados transacional que simula as operações de vendas de uma empresa. Além disso, ele inclui um conjunto de **15 desafios estratégicos** de consultas SQL para fins de análise de dados e geração de relatórios de negócios.

## 🎯 Objetivo da Atividade

O principal objetivo desta atividade é **desenvolver proficiência na linguagem SQL** (Structured Query Language) usando o ambiente MySQL. O foco está na habilidade de:

1. Juntar dados de múltiplas tabelas (JOINs).
2. Aplicar funções de agregação (`COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`) para calcular métricas de negócios.
3. Gerar relatórios de negócios significativos.

## 💻 Estrutura e Instalação do Banco de Dados

O banco de dados principal chama-se `erp_db`.

### 1. Criação do Banco de Dados e Tabelas

O script SQL fornecido (que deve estar no repositório) executa a criação do banco de dados e de todas as tabelas necessárias.

**Tabelas Principais:**

| Tabela | Conteúdo Principal | Colunas Chave para Relações |
| :--- | :--- | :--- |
| **Customers** | Detalhes dos clientes (Nome, País, Cidade). | `CustomerID` |
| **Employees** | Informações sobre a equipe de vendas (Nome, Sobrenome, Notas). | `EmployeeID` |
| **Orders** | Informações de cabeçalho dos pedidos (Data, Cliente, Vendedor). | `OrderID`, `CustomerID`, `EmployeeID`, `ShipperID` |
| **Products** | Itens vendidos (Nome, Preço, Fornecedor, Categoria). | `ProductID`, `SupplierID`, `CategoryID` |
| **OrderDetails** | Detalhes de cada item dentro de um pedido (Quantidade vendida). | `OrderID`, `ProductID` |
| **Categories** | Classificação dos produtos (Ex: Beverages, Seafood). | `CategoryID` |
| **Suppliers** | Detalhes dos fornecedores. | `SupplierID` |
| **Shippers** | Empresas de transporte. | `ShipperID` |

### 2. Relacionamentos (Chaves Estrangeiras)

As relações garantem a integridade referencial do banco de dados:

*   **`Orders`**: Faz referência a `Customers`, `Employees` e `Shippers`.
*   **`OrderDetails`**: Faz referência a `Orders` e `Products`.
*   **`Products`**: Faz referência a `Suppliers` e `Categories`.

### 3. Carga de Dados

Para carregar os dados nas tabelas (usando comandos `LOAD DATA INFILE`), é fundamental que os arquivos CSV estejam no diretório especificado pelo script SQL:

`C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/`

**Formato dos Arquivos CSV:**

*   **Delimitador de Campos:** Ponto e vírgula (`;`).
*   **Terminador de Linha:** Quebra de linha (`\n`).
*   **Linhas Ignoradas:** A primeira linha (cabeçalho) deve ser ignorada (`IGNORE 1 ROWS`).

**Observações sobre a Transformação de Dados:**

A carga de dados inclui transformação de formato para garantir a integridade:

1.  **Datas**: As colunas de data (`BirthDate` em `Employees` e `OrderDate` em `Orders`) são convertidas usando `STR_TO_DATE` com o formato `'%d/%m/%Y'`.
2.  **Preço**: A coluna `Price` em `Products` utiliza a função `REPLACE` para trocar a vírgula (`,`) por ponto (`.`) antes de ser inserida como `DECIMAL(10,2)`.

## 🧠 Foco da Aprendizagem SQL (Conceitos Chave)

Ao resolver os desafios de relatórios, o usuário praticará os seguintes conceitos:

| Conceito | Descrição |
| :--- | :--- |
| **Consultas Fundamentais** | Uso de `SELECT`, `FROM` e `WHERE`. |
| **Junções (JOINs)** | Conectar múltiplas tabelas (Ex: Juntar `Products` e `Categories` para buscar por `CategoryName`). |
| **Agregação** | Utilização de funções como `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()` para calcular métricas de negócios. |
| **Agrupamento e Filtragem** | Uso de `GROUP BY` e `HAVING` para gerar resumos e filtrar resultados agregados. |
| **Manipulação de Texto e Datas** | Uso de funções de string (como `LIKE`) e funções de data (para filtrar por mês ou ano). |

## 📝 Perguntas de Relatórios Estratégicos

O desafio é escrever consultas MySQL (`SELECT`) para responder a estas 15 perguntas estratégicas.

### Nível Básico (SELECT, WHERE, ORDER BY)

1. Quais são os nomes dos clientes (`CustomerName`) e os contatos (`ContactName`) localizados no país 'Germany'?
2. Liste o nome do produto (`ProductName`) e o preço (`Price`) de todos os produtos que pertencem à categoria 'Beverages' (`CategoryID 1`). Ordene a lista pelo preço, do mais caro para o mais barato.
3. Qual é o sobrenome (`LastName`), primeiro nome (`FirstName`) e data de nascimento (`BirthDate`) do funcionário com o `EmployeeID 4`? Inclua também as notas (`Notes`) sobre a formação dele.

### Nível Intermediário (Agregação, GROUP BY, JOINs Simples)

4. Liste todos os países (`Country`) e o número total de clientes em cada país. Apresente a contagem em ordem decrescente.
5. Quais são os nomes dos fornecedores (`SupplierName`) que fornecem produtos classificados como 'Seafood' (`CategoryID 8`)?
6. Qual é o nome do produto (`ProductName`) e o preço (`Price`) do produto mais caro e do produto mais barato no banco de dados?
7. Calcule o número total de pedidos (`OrderID`) processados por cada transportadora (`ShipperName`).
8. Calcule a quantidade média (`Quantity`) de produtos vendidos por pedido (`OrderID`).
9. Liste o nome completo do funcionário (`FirstName`, `LastName`) e o número total de pedidos que cada um processou.
10. Quantos pedidos foram realizados no mês de julho de 1996? (Dica: Use a coluna `OrderDate`).

### Nível Avançado (Múltiplas Junções, HAVING, Cálculos Complexos)

11. Identifique os nomes dos clientes (`CustomerName`) que fizeram mais de 3 pedidos em dezembro de 1997.
12. Liste os nomes dos produtos (`ProductName`) onde a quantidade total vendida (`Quantity`) em todos os pedidos é inferior a 50.
13. Quais são os nomes dos fornecedores (`SupplierName`) localizados no 'Japan' e que fornecem produtos na categoria 'Seafood' (`CategoryID 8`)?
14. Calcule o valor total da receita (`Preço * Quantidade`) para o `OrderID 10248`.
15. Encontre os nomes dos funcionários (`FirstName`, `LastName`) que são fluentes em Francês (conforme registrado nas `Notes`) e que trabalharam em pedidos que ocorreram em Londres (`City` do cliente).
