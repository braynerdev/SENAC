use tropicanatads042;

select date_format(ocr.dataHoraIni, '%H:%i - %d/%m/%Y' ) "DATA DE INÍCIO OCORRÊNCIA" , 
date_format(ocr.dataHoraFim, '%H:%i - %d/%m/%Y' ) "DATA DE FIM OCORRÊNCIA", ocr.obs "OBSERVAÇÃO" ,
upper(f.nome) "NOME FUNCIONÁRIO", f.cpf "CPF FUNCIONÁRIO"
FROM tropicanatads042.ocorrencia ocr
inner JOIN tropicanatads042.funcionario f on ocr.Funcionario_cpf = f.cpf;

select f.cpf "CPF FUNCIONÁRIO", upper(f.nome) "NOME", date_format(fer.dataInicio, '%d/%m/%Y') "DATA INÍCIO", 
date_format(fer.dataFim, '%d/%m/%Y') "DATA FIM", timestampdiff(day, fer.dataInicio,fer.dataFim) "QUANTIDADE DE DIAS",
concat("R$",format(fer.valor,2,"de_DE")) "VALOR RECEBIDO DAS FÉRIAS", fer.periodoAqt "PERÍODO AQUISITIVO DAS FÉRIAS", 
replace(replace(fer.addDecimal, 1, "SIM"), 0, "NÃO") "ADIANTAMENTO 13°"
FROM tropicanatads042.ferias fer inner join tropicanatads042.funcionario f on f.cpf = fer.Funcionario_cpf
order by fer.dataInicio;


select f.cpf "CPF FUNCIONÁRIO", upper(f.nome) "NOME", date_format(fer.dataInicio, '%d/%m/%Y') "DATA INÍCIO", 
date_format(fer.dataFim, '%d/%m/%Y') "DATA FIM", timestampdiff(day, fer.dataInicio,fer.dataFim) "QUANTIDADE DE DIAS",
concat("R$ ",format(fer.valor,2,"de_DE")) "VALOR RECEBIDO DAS FÉRIAS", fer.periodoAqt "PERÍODO AQUISITIVO DAS FÉRIAS", 
case fer.addDecimal 
when 1 then "SIM"
when 0 then "NÃO"
END "ADIANTAMENTO 13°"
FROM tropicanatads042.ferias fer inner join tropicanatads042.funcionario f on f.cpf = fer.Funcionario_cpf
order by fer.dataInicio;



select f.cpf "CPF FUNCIONÁRIO", 
upper(f.nome) "NOME", 
replace(replace(f.genero,"M", "MASCULINO" ),"F", " FEMININO") 
"GÊNERO",concat("R$ ",format(f.salario, 2,"de_DE" )) "SALÁRIO",
group_concat(
CASE
	when length(t.numero) = 11 then REGEXP_REPLACE(t.numero, '([0-9]{2})([0-9]{1})([0-9]{4})([0-9]{4})', '(\$1) \$2 \$3-\$4')
	when length(t.numero) = 10 then regexp_replace(t.numero, '([0-9]{2})([0-9]{4})([0-9]{4})', '(\$1) \$2-\$3')
end 
separator ' | ')"TELEFONE",
group_concat(
upper(d.nome) separator ' | ')"DEPARTAMENTO",
group_concat(
upper(c.nome) separator ' | ')"CARGO",
COALESCE(UPPER(fg.nome), 'NÃO TEM') AS "GERENTE"
from tropicanatads042.funcionario f 
	left join tropicanatads042.telefone t on  t.Funcionario_cpf = f.cpf
    inner join tropicanatads042.trabalhar tr on tr.Funcionario_cpf = f.cpf
    inner join tropicanatads042.cargo c on c.cbo = tr.Cargo_cbo
    inner join tropicanatads042.departamento d on d.idDepartamento = tr.Departamento_idDepartamento
    left join tropicanatads042.funcionario fg on fg.cpf = d.Gerente_cpf
    GROUP BY f.cpf, c.cbo, d.idDepartamento
    order by f.cpf, c.cbo, d.idDepartamento;
