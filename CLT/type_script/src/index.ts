import { Funcionario } from "./entidades/funcionarios";

var joao = new Funcionario("123.456.789-00", "João Brayner", "M", 
    new Date("2004-08-26"), 10000.00, "joao@gmail.com", "(81) 99999-9999", 
    undefined, undefined);

console.log(joao.toString());
joao.setStatus(false);
console.log(joao.toString());

