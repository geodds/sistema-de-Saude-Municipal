	CREATE DATABASE sistema_mario_e_geovana;
    
    USE sistema_mario_e_geovana;
    
    CREATE TABLE enderecos(
		id varchar(10) not null,
        rua varchar(45) not null,
        bairro varchar(30) not null,
        cidade varchar(60) not null,
        complemento varchar(20),
        CONSTRAINT pk_enderecos PRIMARY KEY(id)
    ); 
    
    CREATE TABLE bairros(
		id int not null,
        nome varchar(100) not null,
        CONSTRAINT pk_bairros PRIMARY KEY(id)
    );
    
    /*tabelas da UBS*/
    CREATE TABLE servicos_gerais(
		cpf char(11) not null,
        nome varchar(60) not null,
        data_de_nascimento date not null,
        setor varchar(20) not null,
        salario float not null,
        CONSTRAINT pk_servicos_gerais PRIMARY KEY(cpf)
    );
    CREATE TABLE unidade_ubs(
		id varchar(10) not null,
        endereco varchar(10) not null,
        nome varchar(100) not null,
        cnpj varchar(12) not null,
        bairro_de_atuacao varchar(30) not null,
        CONSTRAINT pk_unidade_ubs PRIMARY KEY(id),
        CONSTRAINT fk_enderecos FOREIGN KEY(endereco) REFERENCES enderecos(id)
    );
    CREATE TABLE enfermeiros(
		cpf varchar(11) not null,
		coren varchar(10) not null,
        unidade_ubs varchar(10) not null,
        nome varchar(100) not null,
        salario float not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_enfermeiros PRIMARY KEY(coren),
        CONSTRAINT fk_unidade_ubs FOREIGN KEY(unidade_ubs) REFERENCES unidade_ubs(id)
    );
    CREATE TABLE medicosUBS(
	crm varchar(20) not null,
    nome varchar(100) not null,
    cns varchar(20) not null,
    nascimento date not null,
    especializacao varchar(50) not null,
    CONSTRAINT pk_medicosUBS PRIMARY KEY(crm)
);
    CREATE TABLE farmaceuticos(
		crf varchar(10) not null,
        nome varchar(100) not null,
        unidade_da_ubs varchar(10) not null,
        salario float not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_farmaceuticos PRIMARY KEY(crf),
        CONSTRAINT fk_unidade_ubs_farmaceuticos FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id)
    );
    CREATE TABLE agente_de_saude(
		coren varchar(15) not null,
		cpf char(11) not null,
        nome varchar(100) not null,
        unidade_da_ubs varchar(10) not null,
        salario float not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_agente_de_saude PRIMARY KEY(cpf),
        CONSTRAINT fk_unidade_ubs_agente FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id)
    );
    CREATE TABLE estagiarios(
    cpf char(11) not null,
    nome varchar(100) not null,
    data_de_nascimento date not null,
    curso varchar(50) not null,
    bolsa float,
    CONSTRAINT pk_estagiario PRIMARY KEY(cpf),
    CONSTRAINT fk_unidade_ubs_agente FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id)
    );
    
    CREATE TABLE pacientes_cadastradosUSF(
		cpf char(11) not null,
        nome varchar(100) not null,
        familia varchar(10) not null,
        cartao_do_sus varchar(20) not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_pacientes_cadastradosUSF PRIMARY KEY(cpf)
    );
    CREATE TABLE ficha_medicos_consulta (
		id varchar(10) not null,
		data_e_hora datetime not null,
		cpf_paciente char(11) not null,
		cartao_do_sus varchar(20) not null,
		nome_paciente varchar(100) not null,
		cartao_da_familia varchar(20) not null,
		crm varchar(10) not null,
		data_de_nascimento date not null,
		especializacao varchar(20) not null,
		PRIMARY KEY (id, crm, data_e_hora)
);
CREATE TABLE medicamentos(
	id char(11) not null,
    nome varchar(50) not null,
    forma_farmaceutica varchar(20) not null,
    CONSTRAINT pk_medicamentos PRIMARY KEY(id)
);
CREATE TABLE medico_trabalha (
	unidade_da_ubs varchar(10) not null,
    ficha_do_medico_consulta varchar(10) not null,
    CONSTRAINT fk_unidade_ubs_do_medico FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id),
    CONSTRAINT fk_ficha_medicos_consulta FOREIGN KEY(ficha_do_medico_consulta) REFERENCES ficha_medicos_consulta(id)
);
CREATE TABLE servicos_gerais_trabalha (
	unidade_da_ubs varchar(10) not null,
    cpf char(11) not null,
    CONSTRAINT fk_unidade_ubs_dos_servicos FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id),
    CONSTRAINT fk_servicos_gerais FOREIGN KEY(cpf) REFERENCES servicos_gerais(cpf)
);
CREATE TABLE ubs_possui (
	unidade_da_ubs varchar(10) not null,
    medicamentos char(11) not null,
    CONSTRAINT fk_unidade_ubs_possui FOREIGN KEY(unidade_da_ubs) REFERENCES unidade_ubs(id),
    CONSTRAINT fk_medicamentos FOREIGN KEY(medicamentos) REFERENCES medicamentos(id)
);


/*tabelas USF*/
CREATE TABLE unidade_usf(
	id varchar(10) not null,
	endereco varchar(10) not null,
	nome varchar(100) not null,
    cnpj varchar(12) not null,
	CONSTRAINT pk_unidade_usf PRIMARY KEY(id),
	CONSTRAINT fk_enderecos FOREIGN KEY(endereco) REFERENCES enderecos(id)
);
CREATE TABLE enfermeiros(
	cpf varchar(11) not null,
	coren varchar(10) not null,
	unidade_usf varchar(10) not null,
	nome varchar(100) not null,
	salario float not null,
	data_de_nascimento date not null,
	CONSTRAINT pk_enfermeiros PRIMARY KEY(coren),
	CONSTRAINT fk_unidade_usf FOREIGN KEY(unidade_usf) REFERENCES unidade_usf(id)
);
CREATE TABLE medicosUSF(
	crm varchar(20) not null,
    nome varchar(100) not null,
    cns varchar(20) not null,
    nascimento date not null,
    especializacao varchar(50) not null,
    CONSTRAINT pk_medicosUSF PRIMARY KEY(crm)
);
    CREATE TABLE farmaceuticos(
		crf varchar(10) not null,
        nome varchar(100) not null,
        unidade_da_usf varchar(10) not null,
        salario float not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_farmaceuticos PRIMARY KEY(crf),
        CONSTRAINT fk_unidade_usf_farmaceuticos FOREIGN KEY(unidade_da_usf) REFERENCES unidade_usf(id)
    );
    CREATE TABLE agente_de_saude(
		cpf char(11) not null,
        nome varchar(100) not null,
        unidade_da_ubs varchar(10) not null,
        salario float not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_agente_de_saude PRIMARY KEY(cpf),
        CONSTRAINT fk_unidade_usf_agente FOREIGN KEY(unidade_da_usf) REFERENCES unidade_usf(id)
    );
    CREATE TABLE estagiarios(
    cpf char(11) not null,
    nome varchar(100) not null,
    data_de_nascimento date not null,
    curso varchar(50) not null,
    CONSTRAINT pk_estagiario PRIMARY KEY(cpf),
    CONSTRAINT fk_unidade_usf_agente FOREIGN KEY(unidade_da_usf) REFERENCES unidade_usf(id)
    );
    CREATE TABLE familias(
		id varchar(10) not null,
        telefone_celular char(15) not null,
        cpf_agente char(11) not null,
        unidade_da_usf varchar(10) not null,
        telefone_fixo char(3) null,
        CONSTRAINT pk_familias PRIMARY KEY(id),
        CONSTRAINT fk_unidade_usf_familias FOREIGN KEY(unidade_da_usf) REFERENCES unidade_usf(id),
        CONSTRAINT fk_agente_de_saude FOREIGN KEY(cpf_agente) REFERENCES agente_de_saude(cpf)
    );
    CREATE TABLE pacientes_cadastrados(
		cpf char(11) not null,
        nome varchar(100) not null,
        familia varchar(10) not null,
        cartao_do_sus varchar(20) not null,
        data_de_nascimento date not null,
        CONSTRAINT pk_cadastrados PRIMARY KEY(cpf),
        CONSTRAINT fk_familias FOREIGN KEY(familia) REFERENCES familias(id)
);
CREATE TABLE ficha_medicos_consulta (
		id varchar(10) not null,
		data_e_hora datetime not null,
		cpf_paciente char(11) not null,
		cartao_do_sus varchar(20) not null,
		nome_paciente varchar(100) not null,
		cartao_da_familia varchar(20) not null,
		crm varchar(10) not null,
		data_de_nascimento date not null,
		especializacao varchar(20) not null,
		PRIMARY KEY (id, crm, data_e_hora)
);
CREATE TABLE medicamentos(
	id char(11) not null,
    nome varchar(50) not null,
    forma_farmaceutica varchar(20) not null,
    CONSTRAINT pk_medicamentos PRIMARY KEY(id)
);
CREATE TABLE medico_trabalha (
	unidade_da_usf varchar(10) not null,
    ficha_do_medico_consulta varchar(10) not null,
    CONSTRAINT fk_unidade_usf_do_medico FOREIGN KEY(unidade_da_usf) REFERENCES unidade_usf(id),
    CONSTRAINT fk_ficha_medicos_consulta FOREIGN KEY(ficha_do_medico_consulta) REFERENCES ficha_medicos_consulta(id)
);


/*tabelas UPA*/
CREATE TABLE unidade_upa(
	id varchar(10) not null,
	endereco varchar(10) not null,
	nome varchar(100) not null,
    cnpj varchar(12) not null,
    gerente varchar(100) not null,
	CONSTRAINT pk_unidade_upa PRIMARY KEY(id),
	CONSTRAINT fk_enderecos FOREIGN KEY(endereco) REFERENCES enderecos(id)
);
CREATE TABLE servicos_gerais(
	cpf char(11) not null,
	nome varchar(60) not null,
	data_de_nascimento date not null,
	cns varchar(20) not null,
	CONSTRAINT pk_servicos_gerais PRIMARY KEY(cpf)
);
CREATE TABLE auxiliar_administrativo(
	cpf char(11) not null,
	nome varchar(60) not null,
	data_de_nascimento date not null,
	cns varchar(20) not null,
	CONSTRAINT pk_auxiliar_administrativo PRIMARY KEY(cpf)
);
CREATE TABLE medicosUPA(
	crm varchar(20) not null,
    nome varchar(100) not null,
    cns varchar(20) not null,
    nascimento date not null,
    especializacao varchar(50) not null,
    CONSTRAINT pk_medicosUPA PRIMARY KEY(crm)
);
CREATE TABLE farmaceutico(
	cpf char(11) not null,
	nome varchar(60) not null,
	data_de_nascimento date not null,
	cns varchar(20) not null,
	CONSTRAINT pk_farmaceutico PRIMARY KEY(cpf)
);    
    CREATE TABLE estagiarios(
    cpf char(11) not null,
    nome varchar(100) not null,
    curso varchar(50) not null,
    cargo varchar(100) not null,
    CONSTRAINT pk_estagiario PRIMARY KEY(cpf),
    CONSTRAINT fk_unidade_upa_agente FOREIGN KEY(unidade_da_upa) REFERENCES unidade_upa(id)
    );
CREATE TABLE paciente(
	cpf varchar(11) not null,
    nome varchar(100) not null,
    nascimento date not null,
    CONSTRAINT pk_paciente PRIMARY KEY(cpf)
);
CREATE TABLE medicamentos(
	id char(11) not null,
    nome varchar(50) not null,
    forma_farmaceutica varchar(20) not null,
    CONSTRAINT pk_medicamentos PRIMARY KEY(id)
);
CREATE TABLE atendimento_upa(
	id int not null,
    data_hota datetime not null,
    nome_medico varchar (50) not null,
    sintomas varchar(100) not null,
    diagnostico_inicial varchar (100) not null,
    descricao varchar(200) not null,
    CONSTRAINT pk_atendimento_upa PRIMARY KEY(id),
    CONSTRAINT fk_medico FOREIGN KEY(medico) REFERENCES medicos(id),
    CONSTRAINT fk_paciente FOREIGN KEY(paciente) REFERENCES paciente(cpf),
    CONSTRAINT fk_clssificacao_risco FOREIGN KEY(classificacao_risco) REFERENCES classificacao_risco(id)
);
CREATE TABLE classificacao_risco(
	id varchar(10) not null,
    nome varchar(20) not null,
     CONSTRAINT pk_classificacao_risco PRIMARY KEY(id)
);
CREATE TABLE exames(
	id varchar(10) not null,
    nome varchar(100) not null,
    CONSTRAINT pk_exames PRIMARY KEY(id) 
);