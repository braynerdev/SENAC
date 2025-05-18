
-- 1
select upper(e.nome) "NOME EMPREGADO", e.cpf "CPF EMPREGADO", date_format(e.dataAdm, "%d/%m/%Y") 
	"DATA ADMISSÃO", concat("R$ ", format(e.salario,2,"de_DE")) "SALÁRIO",
	upper(d.nome) "DEPARTAMENTO", coalesce(t.numero,"NÃO TEM" )"NÚMERO DE TELEFONE" from petshop.empregado e 
		inner join petshop.departamento d on d.idDepartamento = e.Departamento_idDepartamento
		left join petshop.telefone t on t.Empregado_cpf = e.cpf
        WHERE e.dataAdm BETWEEN '2023-01-01' AND '2023-12-31'
        order by e.dataAdm desc;
        
        
-- 2
select upper(e.nome) "NOME EMPREGADO", e.cpf "CPF EMPREGADO", date_format(e.dataAdm, "%d/%m/%Y") 
	"DATA ADMISSÃO", concat("R$ ", format(e.salario,2,"de_DE")) "SALÁRIO",
	upper(d.nome) "DEPARTAMENTO", coalesce(t.numero,"NÃO TEM" )"NÚMERO DE TELEFONE" from petshop.empregado e 
		inner join petshop.departamento d on d.idDepartamento = e.Departamento_idDepartamento
		left join petshop.telefone t on t.Empregado_cpf = e.cpf
        WHERE e.salario < (select avg(salario) from petshop.empregado)
        group by e.nome, e.cpf, e.dataAdm, e.salario, d.nome, t.numero
        order by e.nome;
        
-- 3
select upper(d.nome) "DEPARTAMENTO", count(e.Departamento_idDepartamento) "QUANTIDADE DE EMPREGADOS", 
	concat("R$ ", format(avg(e.salario),2,"de_DE")) "MÉDIA SALÁRIAL", concat("R$ ", format(avg(e.comissao),2,"de_DE")) 
    "MÉDIA DA COMISSÃO" from petshop.departamento d
    inner join petshop.empregado e on e.Departamento_idDepartamento = d.idDepartamento
    group by d.nome
    order by d.nome;
        
-- 4
select upper(e.nome) "NOME EMPREGADO", e.cpf "CPF EMPREGADO", replace(replace(e.sexo,'M',"MASCULINO"),'F',"FEMININO") "SEXO",
	concat("R$ ", format(e.salario,2,"de_DE")) "SALÁRIO", count(v.idvenda) "QUANTIDADE VENDAS", 
    concat("R$ ", format(sum(v.valor),2,"de_DE")) "TOTAL VALOR VENDIDO",
    concat("R$ ", format(sum(v.comissao),2,"de_DE")) "TOTAL COMISSAO DE VENDAS" from petshop.empregado e 
    inner join petshop.venda v on v.Empregado_cpf = e.cpf
    group by e.nome, e.cpf
    order by count(v.idvenda) desc;


-- 5 
select upper(e.nome) "NOME EMPREGADO", e.cpf "CPF EMPREGADO", replace(replace(e.sexo,'M',"MASCULINO"),'F',"FEMININO") "SEXO",
	concat("R$ ", format(e.salario,2,"de_DE")) "SALÁRIO", count(vs.Servico_idServico) "QTD VENDAS COM SERVIÇO",
    concat("R$ ", format(sum(v.valor - v.desconto + vs.valor - vs.desconto),2,"de_DE")) "TOTAL VALOR VENDIDO COM SERVIÇO",
    concat("R$ ", format(sum(v.comissao),2,"de_DE")) "TOTAL COMISSÃO DAS VENDAS COM SERVIÇO"
    from petshop.empregado e 
    inner join petshop.venda v on v.Empregado_cpf = e.cpf
    inner join petshop.itensservico vs on vs.Venda_idVenda = v.idVenda
    group by e.nome, e.cpf
    order by count(v.idvenda) desc;
    

-- 6
select upper(p.nome) "NOME DO PET", date_format(v.data, "%d/%m/%Y") "DATA DO SERVIÇO", upper(s.nome) "SERVIÇO", i.quantidade "QUANTIDADE", 
concat("R$ ", format(sum(i.valor),2,"de_DE")) "VALOR", e.nome "NOME EMPREGADO" from petshop.itensservico i
inner join petshop.venda v on v.idVenda = i.Venda_idVenda
inner join petshop.pet p on p.idPET = i.PET_idPET
inner join petshop.servico s on s.idServico = i.Servico_idServico
inner join petshop.empregado e on e.cpf = i.Empregado_cpf
where p.nome = "SHELLY"
group by p.nome, v.data, s.nome, i.quantidade, i.valor, e.nome
order by v.data desc;


-- 7 
select date_format(v.data, "%d/%m/%Y") "DATA DA VENDA", concat("R$ ", format(sum(v.valor),2,"de_DE")) "VALOR", 
concat("R$ ", format(sum(v.desconto),2,"de_DE")) "DESCONTO", concat("R$ ", format(sum(v.valor - v.desconto),2,"de_DE")) "TOTAL FINAL",
upper(e.nome) "NOME EMPREGADO" from petshop.venda v 
inner join petshop.empregado e on e.cpf = v.Empregado_cpf
where v.Cliente_cpf = "614.784.393-19"
group by v.data, v.valor, v.desconto, e.nome, v.Cliente_cpf
order by v.data desc;

-- 8
select upper(s.nome) "NOME", count(isr.Servico_idServico) "QTD DE VENDA POR SERVIÇO", concat("R$ ", 
format(sum(s.valorVenda),2,"de_DE")) "VALOR TOTAL POR SERVICO"
from petshop.itensservico isr
inner join petshop.servico s on s.idServico = isr.Servico_idServico
group by s.nome
order by count(isr.Servico_idServico) desc limit 10;


-- 9
select  UPPER(CASE WHEN fp.tipo IN ('DINHEIRO', 'DINHERIO') THEN 'DINHEIRO' ELSE fp.tipo END) "FORMA DE PAGAMENTO", 
count(fp.idFormaPgVenda) "QTD VENDAS", 
concat("R$ ",format(sum(v.valor),2, "de_DE"))"VALOR TOTAL VENDIDO"
from petshop.venda v
inner join petshop.formapgvenda fp on fp.Venda_idVenda = v.idVenda
group by UPPER(CASE WHEN fp.tipo IN ('DINHEIRO', 'DINHERIO') THEN 'DINHEIRO' ELSE fp.tipo END)
order by count(fp.idFormaPgVenda) desc;

-- 10
select date_format(data, "%d/%m/%Y") "DATA DA VENDA", count(idVenda) "QTD VENDA",
concat("R$ ",format(sum(valor),2, "de_DE"))"VALOR TOTAL" from petshop.venda
group by data;

-- 11 
select upper(p.nome) "NOME PRODUTO", concat("R$ ",format(sum(p.valorVenda),2, "de_DE"))"VALOR TOTAL VENDIDO",
coalesce(upper(f.nome),"NÃO TEM" )"NOME DO FORNECEDOR", coalesce(upper(f.email),"NÃO TEM" )"EMAIL FORNECEDOR", coalesce(t.numero,"NÃO TEM" )"TELEFONE FORNECEDOR"
from petshop.produtos p 
left join petshop.itenscompra i on i.Produtos_idProduto = p.idProduto
left join petshop.compras c on c.idCompra = i.Compras_idCompra
left join petshop.fornecedor f on f.cpf_cnpj = c.Fornecedor_cpf_cnpj
left join petshop.telefone t on t.Fornecedor_cpf_cnpj = f.cpf_cnpj
group by p.nome, p.valorVenda, f.nome, f.email, t.numero
order by p.nome;

-- 12
select upper(p.nome) "NOME DO PRODUTO", count(itv.Venda_idVenda) "QUANTIDADE TOTAL DE VENDAS", 
concat("R$ ",format(sum(itv.valor),2, "de_DE"))"VALOR TOTAL RECEBIDO PELA VENDA DO PRODUTO" 
from petshop.itensvendaprod itv 
inner join petshop.produtos p on p.idProduto = itv.Produto_idProduto
group by p.nome
order by count(itv.Venda_idVenda) desc;




