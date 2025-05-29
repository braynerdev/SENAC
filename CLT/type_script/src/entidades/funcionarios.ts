export class Funcionario {

    private cpf: string;
    private nome: string;
    private genero: string;
    private dt_nascimento: Date;
    private salario: number;
    private email: string;
    private telefone: string;
    private status: boolean;
    private nome_social?: string;
    private fg?: number;

    constructor(cpf: string, nome: string, genero: string, dt_nascimento: Date, salario: number, email: string, telefone: string, nome_social?: string, fg?: number) {
        this.cpf = cpf;
        this.nome = nome;
        this.genero = genero;
        this.dt_nascimento = dt_nascimento;
        this.salario = salario;
        this.email = email;
        this.nome_social = nome_social;
        this.status = true;
        this.fg = fg;
        this.telefone = telefone;
    }
    
    public getCpf(): string {
        return this.cpf;
    }
    public getNome(): string {
        return this.nome;
    }
    public getGenero(): string {
        return this.genero;
    }
    public getDt_nascimento(): Date {
        return this.dt_nascimento;
    }
    public getSalario(): number {
        return this.salario;
    }
    public getEmail(): string {
        return this.email;
    }
    public getTelefone(): string {
        return this.telefone;
    }
    public getStatus(): boolean {
        return this.status;
    }
    
    public setCpf(cpf: string): void {
        this.cpf = cpf;
    }
    public setNome(nome: string): void {
        this.nome = nome;
    }
    public setGenero(genero: string): void {
        this.genero = genero;
    }
    public setDt_nascimento(dt_nascimento: Date): void {
        this.dt_nascimento = dt_nascimento;
    }
    public setSalario(salario: number): void {
        this.salario = salario;
    }
    public setEmail(email: string): void {
        this.email = email;
    }
    public setTelefone(telefone: string): void {
        this.telefone = telefone;
    }
    public setStatus(status: boolean): void {
        this.status = status;
    }

    public toString(): string {
        return `CPF: ${this.cpf}\nNome: ${this.nome}\nGenero: ${this.genero}\nData de Nascimento: ${this.dt_nascimento}\nSalario: ${this.salario}\nEmail: ${this.email}\nTelefone: ${this.telefone} \nStatus: ${this.status}`;
    }

    public json(): string {
        return JSON.stringify(this);
    }
}