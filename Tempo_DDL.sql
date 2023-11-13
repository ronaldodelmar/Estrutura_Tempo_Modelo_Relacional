/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     08/12/2016 14:56:45                          */
/*==============================================================*/


alter table AGE_ANOS
   drop constraint age_anos_fk01;

alter table AGE_ANOS_MESES
   drop constraint age_anos_meses_fk01;

alter table AGE_ANOS_MESES
   drop constraint age_anos_meses_fk02;

alter table AGE_ANOS_MESES
   drop constraint age_anos_meses_fk03;

alter table AGE_ANOS_MESES
   drop constraint age_anos_meses_fk04;

alter table AGE_BIMESTRES
   drop constraint age_bimestres_fk01;

alter table AGE_BIMESTRES
   drop constraint age_bimestres_fk02;

alter table AGE_DATAS
   drop constraint age_datas_fk01;

alter table AGE_DATAS
   drop constraint age_datas_fk02;

alter table AGE_DATAS
   drop constraint age_datas_fk03;

alter table AGE_DATAS
   drop constraint age_datas_fk04;

alter table AGE_DECADAS
   drop constraint age_decadas_fk01;

alter table AGE_FERIADOS
   drop constraint age_feriados_fk01;

alter table AGE_MESES
   drop constraint age_meses_fk01;

alter table AGE_MESES
   drop constraint age_meses_fk02;

alter table AGE_MESES_DIAS
   drop constraint age_meses_dias_fk01;

alter table AGE_SECULOS
   drop constraint age_seculos_fk01;

alter table AGE_TRIMESTRES
   drop constraint age_trimestres_fk01;

drop view AGE_ANUAL;

drop view AGE_DIARIA;

drop view AGE_MENSAL;

alter table AGE_ANNO_DOMINI
   drop primary key cascade;

drop table AGE_ANNO_DOMINI cascade constraints;

drop index age_anos_fk01;

alter table AGE_ANOS
   drop primary key cascade;

drop table AGE_ANOS cascade constraints;

alter table AGE_ANOS_MESES
   drop primary key cascade;

drop table AGE_ANOS_MESES cascade constraints;

drop index age_bimestres_x01;

alter table AGE_BIMESTRES
   drop primary key cascade;

drop table AGE_BIMESTRES cascade constraints;

drop index age_datas_fk04;

drop index age_datas_fk03;

drop index age_datas_fk02;

drop index age_datas_fk01;

alter table AGE_DATAS
   drop primary key cascade;

drop table AGE_DATAS cascade constraints;

alter table AGE_DECADAS
   drop primary key cascade;

drop table AGE_DECADAS cascade constraints;

alter table AGE_FERIADOS
   drop primary key cascade;

drop table AGE_FERIADOS cascade constraints;

alter table AGE_FERIADOS_TIPOS
   drop primary key cascade;

drop table AGE_FERIADOS_TIPOS cascade constraints;

alter table AGE_MESES
   drop primary key cascade;

drop table AGE_MESES cascade constraints;

alter table AGE_MESES_DIAS
   drop primary key cascade;

drop table AGE_MESES_DIAS cascade constraints;

drop index age_quadrimestres_x01;

alter table AGE_QUADRIMESTRES
   drop primary key cascade;

drop table AGE_QUADRIMESTRES cascade constraints;

alter table AGE_QUINZENAS
   drop primary key cascade;

drop table AGE_QUINZENAS cascade constraints;

alter table AGE_SECULOS
   drop primary key cascade;

drop table AGE_SECULOS cascade constraints;

alter table AGE_SEMANAS_DIAS
   drop primary key cascade;

drop table AGE_SEMANAS_DIAS cascade constraints;

drop index age_semestres_x01;

alter table AGE_SEMESTRES
   drop primary key cascade;

drop table AGE_SEMESTRES cascade constraints;

drop index age_trimestres_x01;

alter table AGE_TRIMESTRES
   drop primary key cascade;

drop table AGE_TRIMESTRES cascade constraints;

/*==============================================================*/
/* Table: AGE_ANNO_DOMINI                                       */
/*==============================================================*/
create table AGE_ANNO_DOMINI 
(
   id_anno_domini       number(2)            not null,
   sg_anno_domini       varchar2(5)          not null,
   ds_anno_domini       varchar2(50)         not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on column AGE_ANNO_DOMINI.id_anno_domini is
'Identificador da tabela.';

comment on column AGE_ANNO_DOMINI.sg_anno_domini is
'Sigla que indica a.C. ou d.C.';

comment on column AGE_ANNO_DOMINI.ds_anno_domini is
'Descrição que indica se é "antes de CRISTO" ou  depois de CRISTO"';

comment on column AGE_ANNO_DOMINI.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_ANNO_DOMINI
   add constraint age_anno_domini_pk primary key (id_anno_domini);

/*==============================================================*/
/* Table: AGE_ANOS                                              */
/*==============================================================*/
create table AGE_ANOS 
(
   id_ano               number(6)            not null,
   ds_ano_reduzido      varchar2(3)          not null,
   ds_ano_zeros         varchar2(5)          not null,
   ds_ano               varchar2(100)        not null,
   fl_ano_bissexto      char(1)              not null,
   id_decada            number(6)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_ANOS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Corresponde a um período de 10 anos, começa sempre com um ano com final 1 e termina com o ano de final 0. Por exemplo: a década de 1990 iniciou-se  em 1991 e terminou em 2000. Outra possibilidade de escrever década   é  ANOS 90.

A tabela contém o período de 01/01/1950 até 31/12/2049';

comment on column AGE_ANOS.id_ano is
'Campo com formato AAAA do ano. Exemplo: 2015.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_ANOS.ds_ano_reduzido is
'Ano reduzido Ex: 15';

comment on column AGE_ANOS.ds_ano_zeros is
'Ano com zeros a esquerda (importante para os anos iniciais)';

comment on column AGE_ANOS.ds_ano is
'Ano por extenso Ex: Dois mil e quinze';

comment on column AGE_ANOS.fl_ano_bissexto is
'Flag que indica se esse ano é bissexto (valor "S"= sim e valor "N"=Não) ';

comment on column AGE_ANOS.id_decada is
'(Chave Migrada). Identificador  da  tabela AGE_DECADAS';

comment on column AGE_ANOS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_ANOS
   add constraint age_anos_pk primary key (id_ano);

/*==============================================================*/
/* Index: age_anos_fk01                                         */
/*==============================================================*/
create index age_anos_fk01 on AGE_ANOS (
   id_decada ASC
);

/*==============================================================*/
/* Table: AGE_ANOS_MESES                                        */
/*==============================================================*/
create table AGE_ANOS_MESES 
(
   id_ano_mes           number(6)            not null,
   ds_mes_ano1          varchar2(15)         not null,
   ds_mes_ano2          varchar2(15)         not null,
   ds_mes_ano3          varchar2(15)         not null,
   ds_mes_ano4          varchar2(50)         not null,
   ds_mes_ano5          varchar2(50)         not null,
   nr_pri_dia_util      number(2)            not null,
   nr_ult_dia_util      number(2)            not null,
   nr_pri_dia           number(2)            not null,
   nr_ult_dia           number(2)            not null,
   id_dia_sem_ini       number(2)            not null,
   id_dia_sem_fim       number(2)            not null,
   qt_seg               number(2)            not null,
   qt_ter               number(2)            not null,
   qt_qua               number(2)            not null,
   qt_qui               number(2)            not null,
   qt_sex               number(2)            not null,
   qt_sab               number(2)            not null,
   qt_dom               number(2)            not null,
   qt_feriados_seg_sex  number(2)            not null,
   qt_feriados_sab_dom  number(2)            not null,
   qt_dias_uteis        number(3)            not null,
   id_ano               number(6)            not null,
   id_mes               number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_ANOS_MESES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 
';

comment on column AGE_ANOS_MESES.id_ano_mes is
'Número do ano e mes no formato AAAAMM. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_ANOS_MESES.ds_mes_ano1 is
'Número do mês e ano no fomato 082008';

comment on column AGE_ANOS_MESES.ds_mes_ano2 is
'Número do mês e ano no fomato 08/2015';

comment on column AGE_ANOS_MESES.ds_mes_ano3 is
'Número do mês e ano no fomato AGO/2015';

comment on column AGE_ANOS_MESES.ds_mes_ano4 is
'Número do mês e ano no fomato AGOSTO/2015';

comment on column AGE_ANOS_MESES.ds_mes_ano5 is
'Número do mês e ano no fomato Agosto de 2015';

comment on column AGE_ANOS_MESES.nr_pri_dia_util is
'Primeiro dia Útil desse mês nesse ano';

comment on column AGE_ANOS_MESES.nr_ult_dia_util is
'Último dia Útil desse mês nesse ano';

comment on column AGE_ANOS_MESES.nr_pri_dia is
'Primeiro dia desse mês nesse ano';

comment on column AGE_ANOS_MESES.nr_ult_dia is
'Último dia desse mês nesse ano ';

comment on column AGE_ANOS_MESES.id_dia_sem_ini is
'Dia da semana que inicia o mês (Segunda)';

comment on column AGE_ANOS_MESES.id_dia_sem_fim is
'Dia da semana que finaliza (Sexta)';

comment on column AGE_ANOS_MESES.qt_seg is
'Quantidades de segundas nesse mês';

comment on column AGE_ANOS_MESES.qt_ter is
'Quantidades de terças nesse mês';

comment on column AGE_ANOS_MESES.qt_qua is
'Quantidades de quartas nesse mês';

comment on column AGE_ANOS_MESES.qt_qui is
'Quantidades de quintas nesse mês';

comment on column AGE_ANOS_MESES.qt_sex is
'Quantidades de sextas nesse mês';

comment on column AGE_ANOS_MESES.qt_sab is
'Quantidades de sábados nesse mês';

comment on column AGE_ANOS_MESES.qt_dom is
'Quantidades de domingos nesse mês';

comment on column AGE_ANOS_MESES.qt_feriados_seg_sex is
'Quantidades de feriados durante a semana';

comment on column AGE_ANOS_MESES.qt_feriados_sab_dom is
'Quantidades de feriados nos fins de semana';

comment on column AGE_ANOS_MESES.qt_dias_uteis is
'Quantidade de dias uteis nesse mês';

comment on column AGE_ANOS_MESES.id_ano is
'(Chave Migrada). Identificador  da  tabela AGE_ANOS';

comment on column AGE_ANOS_MESES.id_mes is
'(Chave Migrada). Identificador  da  tabela AGE_MESES';

comment on column AGE_ANOS_MESES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_ANOS_MESES
   add constraint age_anos_meses_pk primary key (id_ano_mes);

/*==============================================================*/
/* Table: AGE_BIMESTRES                                         */
/*==============================================================*/
create table AGE_BIMESTRES 
(
   id_bimestre          number(2)            not null,
   sg_bimestre          char(2)              not null,
   ds_abreviado1        varchar2(5)          not null,
   ds_abreviado2        varchar2(15)         not null,
   ds_intervalo1        varchar2(25)         not null,
   ds_intervalo2        varchar2(25)         not null,
   ds_bimestre          varchar2(25)         not null,
   id_quadrimestre      number(2)            not null,
   id_semestre          number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_BIMESTRES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_BIMESTRES.id_bimestre is
'Número do Bimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_BIMESTRES.sg_bimestre is
'Sigla do Bimestre Ex: 2B';

comment on column AGE_BIMESTRES.ds_abreviado1 is
'Abreviação do Bimestre Ex: 2 BIM';

comment on column AGE_BIMESTRES.ds_abreviado2 is
'Descrição abreviada  Ex: 2 Bimestre';

comment on column AGE_BIMESTRES.ds_intervalo1 is
'Intervalo de meses do Bimestre Abreviado';

comment on column AGE_BIMESTRES.ds_intervalo2 is
'Intervalo de meses do Bimestre Extenso';

comment on column AGE_BIMESTRES.ds_bimestre is
'Contém a descrição do Semestre Ex: Segundo  Bimestre';

comment on column AGE_BIMESTRES.id_quadrimestre is
'(Chave Migrada). Identificador  da  tabela AGE_QUADRIMESTRES';

comment on column AGE_BIMESTRES.id_semestre is
'(Chave Migrada). Identificador  da  tabela AGE_SEMESTRES';

comment on column AGE_BIMESTRES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_BIMESTRES
   add constraint age_bimestres_pk primary key (id_bimestre);

/*==============================================================*/
/* Index: age_bimestres_x01                                     */
/*==============================================================*/
create index age_bimestres_x01 on AGE_BIMESTRES (
   ds_abreviado2 ASC
);

/*==============================================================*/
/* Table: AGE_DATAS                                             */
/*==============================================================*/
create table AGE_DATAS 
(
   id_data              number               not null,
   dt_data              date                 not null,
   nr_dia_ano           number(3)            not null,
   id_dia_mes           number(2)            not null,
   id_dia_semana        number(2)            not null,
   nr_juliano           number(12)           not null,
   nr_semana_mes        number(2)            not null,
   nr_semana_ano        number(2)            not null,
   id_ano_mes           number(6)            not null,
   id_feriado           number(6)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_DATAS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. ';

comment on column AGE_DATAS.id_data is
'Composto pelo ano, mês e dia no formato AAAAMMDD. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_DATAS.dt_data is
'Valor da data no formato DD/MM/AAAA';

comment on column AGE_DATAS.nr_dia_ano is
'Número do dia no ano. Ex: 216 (de 1 a 365 dependendo se o ano é bissexto)';

comment on column AGE_DATAS.id_dia_mes is
'(Chave Migrada). Identificador  da  tabela AGE_MESES Número do dia do mês. ';

comment on column AGE_DATAS.id_dia_semana is
'(Chave Migrada). Identificador  da  tabela AGE_SEMAMAS_DIAS';

comment on column AGE_DATAS.nr_juliano is
'Data no formato Juliano';

comment on column AGE_DATAS.nr_semana_mes is
'Número da semana dentro do mês';

comment on column AGE_DATAS.nr_semana_ano is
'Número da semana dentro do ano';

comment on column AGE_DATAS.id_ano_mes is
'(Chave Migrada). Identificador  da  tabela AGE_ANOS_MESES';

comment on column AGE_DATAS.id_feriado is
'Chave artificial da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DATAS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_DATAS
   add constraint age_datas_pk primary key (id_data);

/*==============================================================*/
/* Index: age_datas_fk01                                        */
/*==============================================================*/
create index age_datas_fk01 on AGE_DATAS (
   id_feriado ASC
);

/*==============================================================*/
/* Index: age_datas_fk02                                        */
/*==============================================================*/
create index age_datas_fk02 on AGE_DATAS (
   id_ano_mes ASC
);

/*==============================================================*/
/* Index: age_datas_fk03                                        */
/*==============================================================*/
create index age_datas_fk03 on AGE_DATAS (
   id_dia_semana ASC
);

/*==============================================================*/
/* Index: age_datas_fk04                                        */
/*==============================================================*/
create index age_datas_fk04 on AGE_DATAS (
   id_dia_mes ASC
);

/*==============================================================*/
/* Table: AGE_DECADAS                                           */
/*==============================================================*/
create table AGE_DECADAS 
(
   id_decada            number(6)            not null,
   sg_decada            char(2)              not null,
   ds_decada1           varchar2(50)         not null,
   ds_decada2           varchar2(50)         not null,
   ds_decada_extenso    varchar2(100)        not null,
   id_seculo            number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_DECADAS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Corresponde a um período de 10 anos, começa sempre com um ano com final 1 e termina com o ano de final 0. Por exemplo: a década de 1990 iniciou-se  em 1991 e terminou em 2000. Outra possibilidade de escrever década   é  ANOS 90.

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_DECADAS.id_decada is
'Número da Década.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_DECADAS.sg_decada is
'Abreviação do número da Década. Exemplo:  Década de 30';

comment on column AGE_DECADAS.ds_decada1 is
'Descrição da Década ''DÉCADA DE 1990''';

comment on column AGE_DECADAS.ds_decada2 is
'Descrição da Década '' ANOS 90''';

comment on column AGE_DECADAS.ds_decada_extenso is
'Descrição por extenso';

comment on column AGE_DECADAS.id_seculo is
'(Chave Migrada). Identificador  da  tabela AGE_SECULOS';

comment on column AGE_DECADAS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_DECADAS
   add constraint age_decadas_pk primary key (id_decada);

/*==============================================================*/
/* Table: AGE_FERIADOS                                          */
/*==============================================================*/
create table AGE_FERIADOS 
(
   id_feriado         number(6)            not null,
   fl_oficial         char(1)              not null,
   ds_feriado         varchar2(100)        not null,
   dt_feriado         varchar2(5),
   ds_obs             varchar2(250),
   id_feriado_tipo    number(6)            not null,
   dt_inclusao        date                 default SYSDATE not null
);

comment on table AGE_FERIADOS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. ';

comment on column AGE_FERIADOS.id_feriado is
'Chave artificial da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_FERIADOS."fl_oficial" is
'Campo que configura se o feriado é oficial ou não, existem feriados que dependem da prática da empresa ';

comment on column AGE_FERIADOS.ds_feriado is
'Descrição do Feriado';

comment on column AGE_FERIADOS.dt_feriado is
'Dia e Mês (DD/MM) do feriado no caso de feriados móveis (Pascoa e seus dependentes) fica o label ''MOVEL''. Ver também função em pck_util';

comment on column AGE_FERIADOS.ds_obs is
'Campo para observações e notas';

comment on column AGE_FERIADOS.id_feriado_tipo is
'(Chave Migrada). Identificador  da  tabela AGE_FERIADOS_TIPOS';

comment on column AGE_FERIADOS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_FERIADOS
   add constraint age_feriados_pk primary key (id_feriado);

/*==============================================================*/
/* Table: AGE_FERIADOS_TIPOS                                    */
/*==============================================================*/
create table AGE_FERIADOS_TIPOS 
(
   id_feriado_tipo      number(6)            not null,
   ds_feriado_tipo      varchar2(100)        not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_FERIADOS_TIPOS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. ';

comment on column AGE_FERIADOS_TIPOS.id_feriado_tipo is
'Chave artificial da tabela gerada via script. ';

comment on column AGE_FERIADOS_TIPOS.ds_feriado_tipo is
'Descrição do tipo de feriado (fixo, model, estadual)';

comment on column AGE_FERIADOS_TIPOS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_FERIADOS_TIPOS
   add constraint age_feriados_tipos_pk primary key (id_feriado_tipo);

/*==============================================================*/
/* Table: AGE_MESES                                             */
/*==============================================================*/
create table AGE_MESES 
(
   id_mes               number(2)            not null,
   nr_mes_zero          char(2)              not null,
   sg_mes               varchar2(3)          not null,
   ds_mes               varchar2(15)         not null,
   nr_ult_dia_mes       number(2),
   id_bimestre          number(2)            not null,
   id_trimestre         number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_MESES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_MESES.id_mes is
'Número do Mês Ex: 8. Chave da tabela gerada via script.';

comment on column AGE_MESES.nr_mes_zero is
'Número do Mês com zero  Ex: 08';

comment on column AGE_MESES.sg_mes is
'Mês abreviado. Ex: AGO';

comment on column AGE_MESES.ds_mes is
'Descrição do Mês.  Ex: AGOSTO';

comment on column AGE_MESES.nr_ult_dia_mes is
'Numero do último dia do mês (no caso de fevereitro bissexto tratamos como exceção)';

comment on column AGE_MESES.id_bimestre is
'(Chave Migrada). Identificador  da  tabela AGE_BIMESTRES';

comment on column AGE_MESES.id_trimestre is
'(Chave Migrada). Identificador  da  tabela AGE_TRIMESTRES';

comment on column AGE_MESES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_MESES
   add constraint age_meses_pk primary key (id_mes);

/*==============================================================*/
/* Table: AGE_MESES_DIAS                                        */
/*==============================================================*/
create table AGE_MESES_DIAS 
(
   id_mes_dia           number(2)            not null,
   cd_mes_dia           char(2),
   ds_mes_dia           varchar2(25)         not null,
   id_quinzena          number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on column AGE_MESES_DIAS.id_mes_dia is
'Número do dia do mês.  Chave da tabela gerada via script. ';

comment on column AGE_MESES_DIAS.cd_mes_dia is
'Número do dia do mês com zeros a esquerda.';

comment on column AGE_MESES_DIAS.ds_mes_dia is
'Descrição do dia do mês';

comment on column AGE_MESES_DIAS.id_quinzena is
'(Chave Migrada). Identificador  da  tabela AGE_QUINZENAS';

comment on column AGE_MESES_DIAS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_MESES_DIAS
   add constraint age_meses_dias_pk primary key (id_mes_dia);

/*==============================================================*/
/* Table: AGE_QUADRIMESTRES                                     */
/*==============================================================*/
create table AGE_QUADRIMESTRES 
(
   id_quadrimestre      number(2)            not null,
   sg_quadrimestre      char(2)              not null,
   ds_abreviado1        varchar2(5)          not null,
   ds_abreviado2        varchar2(15)         not null,
   ds_intervalo1        varchar2(25)         not null,
   ds_intervalo2        varchar2(25)         not null,
   ds_quadrimestre      varchar2(25)         not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_QUADRIMESTRES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_QUADRIMESTRES.id_quadrimestre is
'Número do Quadrimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_QUADRIMESTRES.sg_quadrimestre is
'Sigla do Quadrimestre Ex: 2Q';

comment on column AGE_QUADRIMESTRES.ds_abreviado1 is
'Abreviação do Quadrimestre Ex: 2 Qua';

comment on column AGE_QUADRIMESTRES.ds_abreviado2 is
'Descrição abreviada  Ex: 2 Quadrimestre';

comment on column AGE_QUADRIMESTRES.ds_intervalo1 is
'Intervalo de meses do quadrimestre abreviado';

comment on column AGE_QUADRIMESTRES.ds_intervalo2 is
'Intervalo de meses do quadrimestre extenso';

comment on column AGE_QUADRIMESTRES.ds_quadrimestre is
'Contém a descrição do quadrimestre Ex: Segundo  Quadrimestre';

comment on column AGE_QUADRIMESTRES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_QUADRIMESTRES
   add constraint age_quadrimestres_pk primary key (id_quadrimestre);

/*==============================================================*/
/* Index: age_quadrimestres_x01                                 */
/*==============================================================*/
create index age_quadrimestres_x01 on AGE_QUADRIMESTRES (
   ds_abreviado2 ASC
);

/*==============================================================*/
/* Table: AGE_QUINZENAS                                         */
/*==============================================================*/
create table AGE_QUINZENAS 
(
   id_quinzena          number(2)            not null,
   ds_abreviado         varchar2(25),
   ds_quinzena          varchar2(25)         not null,
   ds_intervalo         varchar2(25)         not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on column AGE_QUINZENAS.id_quinzena is
'Número da quinzena.  Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_QUINZENAS.ds_abreviado is
'Descrição Abreviada';

comment on column AGE_QUINZENAS.ds_quinzena is
'Descrição da quinzena.';

comment on column AGE_QUINZENAS.ds_intervalo is
'Intervalo da quinzena.';

comment on column AGE_QUINZENAS.dt_inclusao is
'Data de inclusão do registro.';

alter table AGE_QUINZENAS
   add constraint age_quinzenas_pk primary key (id_quinzena);

/*==============================================================*/
/* Table: AGE_SECULOS                                           */
/*==============================================================*/
create table AGE_SECULOS 
(
   id_seculo            number(2)            not null,
   nr_romano            varchar2(15)         not null,
   ds_seculo            varchar2(50)         not null,
   id_anno_domini       number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_SECULOS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Crresponde a um períodos de 100 anos. O século começa em um ano que tem  final 01e termina com o ano que tem final 00. Por exemplo: século XVII  teve início em 1601 e terminou em 1700.

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_SECULOS.id_seculo is
'Número do Século. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_SECULOS.nr_romano is
'Número do Século em Romano';

comment on column AGE_SECULOS.ds_seculo is
'Descrição do Século';

comment on column AGE_SECULOS.id_anno_domini is
'Identificador da tabela.';

comment on column AGE_SECULOS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_SECULOS
   add constraint age_seculos_pk primary key (id_seculo);

/*==============================================================*/
/* Table: AGE_SEMANAS_DIAS                                      */
/*==============================================================*/
create table AGE_SEMANAS_DIAS 
(
   id_semana_dia        number(2)            not null,
   sg_semana_dia        varchar2(3)          not null,
   ds_semana_dia1       varchar2(15)         not null,
   ds_semana_dia2       varchar2(15)         not null,
   fl_fim_semana        char(1)              not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_SEMANAS_DIAS is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_SEMANAS_DIAS.id_semana_dia is
'Número do dia da semana.  Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_SEMANAS_DIAS.sg_semana_dia is
'Sigla do dia da semana ( SEG )';

comment on column AGE_SEMANAS_DIAS.ds_semana_dia1 is
'Dia da semana simplificado ( Segunda )';

comment on column AGE_SEMANAS_DIAS.ds_semana_dia2 is
'Descrição do dia da semana por extenso (Segunda-Feira)';

comment on column AGE_SEMANAS_DIAS.fl_fim_semana is
'Indica se esse dia é um fim de semana (sábado e Domingo)';

comment on column AGE_SEMANAS_DIAS.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_SEMANAS_DIAS
   add constraint age_semanas_dias_pk primary key (id_semana_dia);

/*==============================================================*/
/* Table: AGE_SEMESTRES                                         */
/*==============================================================*/
create table AGE_SEMESTRES 
(
   id_semestre          number(2)            not null,
   sg_semestre          char(2)              not null,
   ds_abreviado1        varchar2(5)          not null,
   ds_abreviado2        varchar2(15)         not null,
   ds_intervalo1        varchar2(25)         not null,
   ds_intervalo2        varchar2(25)         not null,
   ds_semestre          varchar2(25)         not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_SEMESTRES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_SEMESTRES.id_semestre is
'Número do Semestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_SEMESTRES.sg_semestre is
'Sigla do Semestre Ex: 2S';

comment on column AGE_SEMESTRES.ds_abreviado1 is
'Abreviação do Semestre Ex: 2 Sem';

comment on column AGE_SEMESTRES.ds_abreviado2 is
'Descrição abreviada  Ex: 2 Semestre';

comment on column AGE_SEMESTRES.ds_intervalo1 is
'Intervalo de meses do semestre abreviado';

comment on column AGE_SEMESTRES.ds_intervalo2 is
'Intervalo de meses do semestre extenso';

comment on column AGE_SEMESTRES.ds_semestre is
'Contém a descrição do Semestre Ex: Segundo  Semestre';

comment on column AGE_SEMESTRES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_SEMESTRES
   add constraint age_semestres_pk primary key (id_semestre);

/*==============================================================*/
/* Index: age_semestres_x01                                     */
/*==============================================================*/
create index age_semestres_x01 on AGE_SEMESTRES (
   ds_abreviado2 ASC
);

/*==============================================================*/
/* Table: AGE_TRIMESTRES                                        */
/*==============================================================*/
create table AGE_TRIMESTRES 
(
   id_trimestre         number(2)            not null,
   sg_trimestre         char(2)              not null,
   ds_abreviado1        varchar2(5)          not null,
   ds_abreviado2        varchar2(15)         not null,
   ds_intervalo         varchar2(25)         not null,
   ds_intervalo2        varchar2(25)         not null,
   ds_trimestre         varchar2(25)         not null,
   id_semestre          number(2)            not null,
   dt_inclusao          date                 default SYSDATE not null
);

comment on table AGE_TRIMESTRES is
'Tabela estática. 
Carregada com scripts "Hard Code" (não possui sequence). 
Favor consultar scripts no campo notes do modelo ou no diretório F5 - Aplicação do Modelo. 

Podemos adicionar an estrutura nomes em inglês e espanhol caso seja necessário';

comment on column AGE_TRIMESTRES.id_trimestre is
'Número do Trimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_TRIMESTRES.sg_trimestre is
'Sigla do Trimestre Ex: 2T';

comment on column AGE_TRIMESTRES.ds_abreviado1 is
'Abreviação do Trimestre Ex: 2 Tri';

comment on column AGE_TRIMESTRES.ds_abreviado2 is
'Descrição abreviada  Ex: 2 Trimestre';

comment on column AGE_TRIMESTRES.ds_intervalo is
'Intervalo de meses do trimestre abreviado';

comment on column AGE_TRIMESTRES.ds_intervalo2 is
'Intervalo de meses do trimestre extenso';

comment on column AGE_TRIMESTRES.ds_trimestre is
'Contém a descrição do Trimestre Ex: Segundo  Trimestre';

comment on column AGE_TRIMESTRES.id_semestre is
'(Chave Migrada). Identificador  da  tabela AGE_SEMESTRE';

comment on column AGE_TRIMESTRES.dt_inclusao is
'Data de inclusão do registro ';

alter table AGE_TRIMESTRES
   add constraint age_trimestres_pk primary key (id_trimestre);

/*==============================================================*/
/* Index: age_trimestres_x01                                    */
/*==============================================================*/
create index age_trimestres_x01 on AGE_TRIMESTRES (
   ds_abreviado2 ASC
);

/*==============================================================*/
/* View: AGE_ANUAL                                              */
/*==============================================================*/
create or replace view AGE_ANUAL(ID_ANO, DS_ANO_REDUZIDO, DS_ANO, FL_ANO_BISSEXTO, ID_DECADA, SG_DECADA, DS_DECADA1, DS_DECADA2, DS_DECADA_EXTENSO, ID_SECULO, NR_ROMANO, DS_SECULO) as
select
   ano.id_ano,
   ano.ds_ano_reduzido,
   ano.ds_ano,
   ano.fl_ano_bissexto,
   dez.id_decada,
   dez.sg_decada,
   dez.ds_decada1,
   dez.ds_decada2,
   dez.ds_decada_extenso,
   sec.id_seculo,
   sec.nr_romano,
   sec.ds_seculo
from
   AGE_ANOS ano,
   AGE_DECADAS dez,
   AGE_SECULOS sec
where
   1 = 1
   and ano.id_decada = dez.id_decada
   and dez.id_seculo = sec.id_seculo
with read only;

comment on column AGE_ANUAL.ID_ANO is
'Campo com formato AAAA do ano. Exemplo: 2015.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_ANUAL.DS_ANO_REDUZIDO is
'Ano reduzido Ex: 15';

comment on column AGE_ANUAL.DS_ANO is
'Ano por extenso Ex: Dois mil e quinze';

comment on column AGE_ANUAL.FL_ANO_BISSEXTO is
'Flag que indica se esse ano é bissexto (valor "S"= sim e valor "N"=Não) ';

comment on column AGE_ANUAL.ID_DECADA is
'Número da Década.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_ANUAL.SG_DECADA is
'Abreviação do número da Década. Exemplo:  Década de 30';

comment on column AGE_ANUAL.DS_DECADA1 is
'Descrição da Década ''DÉCADA DE 1990''';

comment on column AGE_ANUAL.DS_DECADA2 is
'Descrição da Década '' ANOS 90''';

comment on column AGE_ANUAL.DS_DECADA_EXTENSO is
'Descrição por extenso';

comment on column AGE_ANUAL.ID_SECULO is
'Número do Século. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_ANUAL.NR_ROMANO is
'Número do Século em Romano';

comment on column AGE_ANUAL.DS_SECULO is
'Descrição do Século';

/*==============================================================*/
/* View: AGE_DIARIA                                             */
/*==============================================================*/
create or replace view AGE_DIARIA(ID_DATA, DT_DATA, NR_DIA_ANO, NR_JULIANO, NR_SEMANA_MES, NR_SEMANA_ANO, ID_DIA_SEMANA, ID_DIA_MES, SG_SEMANA_DIA, DS_SEMANA_DIA1, DS_SEMANA_DIA2, FL_FIM_SEMANA, DS_MES_DIA, ID_QUINZENA, QUINZ_DS_ABREVIADO, DS_QUINZENA, QUINZ_DS_INTERVALO, ID_FERIADO, DS_FERIADO, DT_FERIADO, DS_OBS, ID_FERIADO_TIPO, DS_FERIADO_TIPO, ID_ANO_MES, DS_MES_ANO1, DS_MES_ANO2, DS_MES_ANO3, DS_MES_ANO4, DS_MES_ANO5, NR_PRI_DIA_UTIL, NR_ULT_DIA_UTIL, NR_PRI_DIA, NR_ULT_DIA, ID_DIA_SEM_INI, ID_DIA_SEM_FIM, QT_SEG, QT_TER, QT_QUA, QT_QUI, QT_SEX, QT_SAB, QT_DOM, QT_FERIADOS_SAB_DOM, QT_DIAS_UTEIS, ID_MES, NR_MES_ZERO, SG_MES, DS_MES, NR_ULT_DIA_MES, ID_BIMESTRE, SG_BIMESTRE, BIMES_DS_ABREVIADO1, BIMES_DS_ABREVIADO2, BIMES_DS_INTERVALO1, BIMES_DS_INTERVALO2, DS_BIMESTRE, ID_TRIMESTRE, SG_TRIMESTRE, TRIME_DS_ABREVIADO1, TRIME_DS_ABREVIADO2, TRIME_DS_INTERVALO1, TRIME_DS_INTERVALO2, DS_TRIMESTRE, ID_QUADRIMESTRE, SG_QUADRIMESTRE, QUADR_DS_ABREVIADO1, QUADR_DS_ABREVIADO2, QUADR_DS_INTERVALO1, QUADR_DS_INTERVALO2, DS_QUADRIMESTRE, ID_SEMESTRE, SG_SEMESTRE, SEMES_DS_ABREVIADO1, SEMES_DS_ABREVIADO2, SEMES_DS_INTERVALO1, SEMES_DS_INTERVALO2, DS_SEMESTRE, ID_ANO, DS_ANO_REDUZIDO, DS_ANO, FL_ANO_BISSEXTO, ID_DECADA, SG_DECADA, DS_DECADA1, DS_DECADA2, DS_DECADA_EXTENSO, ID_SECULO, NR_ROMANO, DS_SECULO) as
select
   dat.id_data,
   dat.dt_data,
   dat.nr_dia_ano,
   dat.nr_juliano,
   dat.nr_semana_mes,
   dat.nr_semana_ano,
   dat.id_dia_semana,
   dat.id_dia_mes,
   semdia.sg_semana_dia,
   semdia.ds_semana_dia1,
   semdia.ds_semana_dia2,
   semdia.fl_fim_semana,
   mesdia.ds_mes_dia,
   qui.id_quinzena,
   qui.ds_abreviado as quinz_ds_abreviado,
   qui.ds_quinzena,
   qui.ds_intervalo as quinz_ds_intervalo,
   fer.id_feriado,
   fer.ds_feriado,
   fer.dt_feriado,
   fer.ds_obs,
   fertip.id_feriado_tipo,
   fertip.ds_feriado_tipo,
   anomes.id_ano_mes,
   anomes.ds_mes_ano1,
   anomes.ds_mes_ano2,
   anomes.ds_mes_ano3,
   anomes.ds_mes_ano4,
   anomes.ds_mes_ano5,
   anomes.nr_pri_dia_util,
   anomes.nr_ult_dia_util,
   anomes.nr_pri_dia,
   anomes.nr_ult_dia,
   anomes.id_dia_sem_ini,
   anomes.id_dia_sem_fim,
   anomes.qt_seg,
   anomes.qt_ter,
   anomes.qt_qua,
   anomes.qt_qui,
   anomes.qt_sex,
   anomes.qt_sab,
   anomes.qt_dom,
   anomes.qt_feriados_sab_dom,
   anomes.qt_dias_uteis,
   mes.id_mes,
   mes.nr_mes_zero,
   mes.sg_mes,
   mes.ds_mes,
   mes.nr_ult_dia_mes,
   bim.id_bimestre,
   bim.sg_bimestre,
   bim.ds_abreviado1 as bimes_ds_abreviado1,
   bim.ds_abreviado2 as bimes_ds_abreviado2,
   bim.ds_intervalo1 as bimes_ds_intervalo1,
   bim.ds_intervalo2 as bimes_ds_intervalo2,
   bim.ds_bimestre,
   tri.id_trimestre,
   tri.sg_trimestre,
   tri.ds_abreviado1 as trime_ds_abreviado1,
   tri.ds_abreviado2 as trime_ds_abreviado2,
   tri.ds_intervalo as trime_ds_intervalo1,
   tri.ds_intervalo2 as trime_ds_intervalo2,
   tri.ds_trimestre,
   qua.id_quadrimestre,
   qua.sg_quadrimestre,
   qua.ds_abreviado1 as quadr_ds_abreviado1,
   qua.ds_abreviado2 as quadr_ds_abreviado2,
   qua.ds_intervalo1 as quadr_ds_intervalo1,
   qua.ds_intervalo2 as quadr_ds_intervalo2,
   qua.ds_quadrimestre,
   sem.id_semestre,
   sem.sg_semestre,
   sem.ds_abreviado1 as semes_ds_abreviado1,
   sem.ds_abreviado2 as semes_ds_abreviado2,
   sem.ds_intervalo1 as semes_ds_intervalo1,
   sem.ds_intervalo2 as semes_ds_intervalo2,
   sem.ds_semestre,
   ano.id_ano,
   ano.ds_ano_reduzido,
   ano.ds_ano,
   ano.fl_ano_bissexto,
   dez.id_decada,
   dez.sg_decada,
   dez.ds_decada1,
   dez.ds_decada2,
   dez.ds_decada_extenso,
   sec.id_seculo,
   sec.nr_romano,
   sec.ds_seculo
from
   AGE_DATAS dat,
   AGE_SEMANAS_DIAS semdia,
   AGE_MESES_DIAS mesdia,
   AGE_QUINZENAS qui,
   AGE_FERIADOS fer,
   AGE_FERIADOS_TIPOS fertip,
   AGE_ANOS_MESES anomes,
   AGE_MESES mes,
   AGE_BIMESTRES bim,
   AGE_TRIMESTRES tri,
   AGE_QUADRIMESTRES qua,
   AGE_SEMESTRES sem,
   AGE_ANOS ano,
   AGE_DECADAS dez,
   AGE_SECULOS sec
where
   1 = 1
   and dat.id_dia_semana = semdia.id_semana_dia
   and dat.id_dia_mes = mesdia.id_mes_dia
   and mesdia.id_quinzena = qui.id_quinzena
   and dat.id_feriado = fer.id_feriado
   and fer.id_feriado_tipo = fertip.id_feriado_tipo
   and dat.id_ano_mes = anomes.id_ano_mes
   and anomes.id_mes = mes.id_mes
   and mes.id_bimestre = bim.id_bimestre
   and mes.id_trimestre = tri.id_trimestre
   and bim.id_quadrimestre = qua.id_quadrimestre
   and bim.id_semestre = sem.id_semestre
   and anomes.id_ano = ano.id_ano
   and ano.id_decada = dez.id_decada
   and dez.id_seculo = sec.id_seculo
with read only;

comment on column AGE_DIARIA.ID_DATA is
'Composto pelo ano, mês e dia no formato AAAAMMDD. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_DIARIA.DT_DATA is
'Valor da data no formato DD/MM/AAAA';

comment on column AGE_DIARIA.NR_DIA_ANO is
'Número do dia no ano. Ex: 216 (de 1 a 365 dependendo se o ano é bissexto)';

comment on column AGE_DIARIA.NR_JULIANO is
'Data no formato Juliano';

comment on column AGE_DIARIA.NR_SEMANA_MES is
'Número da semana dentro do mês';

comment on column AGE_DIARIA.NR_SEMANA_ANO is
'Número da semana dentro do ano';

comment on column AGE_DIARIA.ID_DIA_SEMANA is
'(Chave Migrada). Identificador  da  tabela AGE_SEMAMAS_DIAS';

comment on column AGE_DIARIA.ID_DIA_MES is
'(Chave Migrada). Identificador  da  tabela AGE_MESES Número do dia do mês. ';

comment on column AGE_DIARIA.SG_SEMANA_DIA is
'Sigla do dia da semana ( SEG )';

comment on column AGE_DIARIA.DS_SEMANA_DIA1 is
'Dia da semana simplificado ( Segunda )';

comment on column AGE_DIARIA.DS_SEMANA_DIA2 is
'Descrição do dia da semana por extenso (Segunda-Feira)';

comment on column AGE_DIARIA.FL_FIM_SEMANA is
'Indica se esse dia é um fim de semana (sábado e Domingo)';

comment on column AGE_DIARIA.DS_MES_DIA is
'Descrição do dia do mês';

comment on column AGE_DIARIA.ID_QUINZENA is
'Número da quinzena.  Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_DIARIA.QUINZ_DS_ABREVIADO is
'Descrição Abreviada';

comment on column AGE_DIARIA.DS_QUINZENA is
'Descrição da quinzena.';

comment on column AGE_DIARIA.QUINZ_DS_INTERVALO is
'Intervalo da quinzena.';

comment on column AGE_DIARIA.ID_FERIADO is
'Chave artificial da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DIARIA.DS_FERIADO is
'Descrição do Feriado';

comment on column AGE_DIARIA.DT_FERIADO is
'Dia e Mês (DD/MM) do feriado no caso de feriados móveis (Pascoa e seus dependentes) fica o label ''MOVEL''. Ver também função em pck_util';

comment on column AGE_DIARIA.DS_OBS is
'Campo para observações e notas';

comment on column AGE_DIARIA.ID_FERIADO_TIPO is
'Chave artificial da tabela gerada via script. ';

comment on column AGE_DIARIA.DS_FERIADO_TIPO is
'Descrição do tipo de feriado (fixo, model, estadual)';

comment on column AGE_DIARIA.ID_ANO_MES is
'Número do ano e mes no formato AAAAMM. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_DIARIA.DS_MES_ANO1 is
'Número do mês e ano no fomato 082008';

comment on column AGE_DIARIA.DS_MES_ANO2 is
'Número do mês e ano no fomato 08/2015';

comment on column AGE_DIARIA.DS_MES_ANO3 is
'Número do mês e ano no fomato AGO/2015';

comment on column AGE_DIARIA.DS_MES_ANO4 is
'Número do mês e ano no fomato AGOSTO/2015';

comment on column AGE_DIARIA.DS_MES_ANO5 is
'Número do mês e ano no fomato Agosto de 2015';

comment on column AGE_DIARIA.NR_PRI_DIA_UTIL is
'Primeiro dia Útil desse mês nesse ano';

comment on column AGE_DIARIA.NR_ULT_DIA_UTIL is
'Último dia Útil desse mês nesse ano';

comment on column AGE_DIARIA.NR_PRI_DIA is
'Primeiro dia desse mês nesse ano';

comment on column AGE_DIARIA.NR_ULT_DIA is
'Último dia desse mês nesse ano ';

comment on column AGE_DIARIA.ID_DIA_SEM_INI is
'Dia da semana que inicia o mês (Segunda)';

comment on column AGE_DIARIA.ID_DIA_SEM_FIM is
'Dia da semana que finaliza (Sexta)';

comment on column AGE_DIARIA.QT_SEG is
'Quantidades de segundas nesse mês';

comment on column AGE_DIARIA.QT_TER is
'Quantidades de terças nesse mês';

comment on column AGE_DIARIA.QT_QUA is
'Quantidades de quartas nesse mês';

comment on column AGE_DIARIA.QT_QUI is
'Quantidades de quintas nesse mês';

comment on column AGE_DIARIA.QT_SEX is
'Quantidades de sextas nesse mês';

comment on column AGE_DIARIA.QT_SAB is
'Quantidades de sábados nesse mês';

comment on column AGE_DIARIA.QT_DOM is
'Quantidades de domingos nesse mês';

comment on column AGE_DIARIA.QT_FERIADOS_SAB_DOM is
'Quantidades de feriados nos fins de semana';

comment on column AGE_DIARIA.QT_DIAS_UTEIS is
'Quantidade de dias uteis nesse mês';

comment on column AGE_DIARIA.ID_MES is
'Número do Mês Ex: 8. Chave da tabela gerada via script.';

comment on column AGE_DIARIA.NR_MES_ZERO is
'Número do Mês com zero  Ex: 08';

comment on column AGE_DIARIA.SG_MES is
'Mês abreviado. Ex: AGO';

comment on column AGE_DIARIA.DS_MES is
'Descrição do Mês.  Ex: AGOSTO';

comment on column AGE_DIARIA.NR_ULT_DIA_MES is
'Numero do último dia do mês (no caso de fevereitro bissexto tratamos como exceção)';

comment on column AGE_DIARIA.ID_BIMESTRE is
'Número do Bimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DIARIA.SG_BIMESTRE is
'Sigla do Bimestre Ex: 2B';

comment on column AGE_DIARIA.BIMES_DS_ABREVIADO1 is
'Abreviação do Bimestre Ex: 2 BIM';

comment on column AGE_DIARIA.BIMES_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Bimestre';

comment on column AGE_DIARIA.BIMES_DS_INTERVALO1 is
'Intervalo de meses do Bimestre Abreviado';

comment on column AGE_DIARIA.BIMES_DS_INTERVALO2 is
'Intervalo de meses do Bimestre Extenso';

comment on column AGE_DIARIA.DS_BIMESTRE is
'Contém a descrição do Semestre Ex: Segundo  Bimestre';

comment on column AGE_DIARIA.ID_TRIMESTRE is
'Número do Trimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DIARIA.SG_TRIMESTRE is
'Sigla do Trimestre Ex: 2T';

comment on column AGE_DIARIA.TRIME_DS_ABREVIADO1 is
'Abreviação do Trimestre Ex: 2 Tri';

comment on column AGE_DIARIA.TRIME_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Trimestre';

comment on column AGE_DIARIA.TRIME_DS_INTERVALO1 is
'Intervalo de meses do trimestre abreviado';

comment on column AGE_DIARIA.TRIME_DS_INTERVALO2 is
'Intervalo de meses do trimestre extenso';

comment on column AGE_DIARIA.DS_TRIMESTRE is
'Contém a descrição do Trimestre Ex: Segundo  Trimestre';

comment on column AGE_DIARIA.ID_QUADRIMESTRE is
'Número do Quadrimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DIARIA.SG_QUADRIMESTRE is
'Sigla do Quadrimestre Ex: 2Q';

comment on column AGE_DIARIA.QUADR_DS_ABREVIADO1 is
'Abreviação do Quadrimestre Ex: 2 Qua';

comment on column AGE_DIARIA.QUADR_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Quadrimestre';

comment on column AGE_DIARIA.QUADR_DS_INTERVALO1 is
'Intervalo de meses do quadrimestre abreviado';

comment on column AGE_DIARIA.QUADR_DS_INTERVALO2 is
'Intervalo de meses do quadrimestre extenso';

comment on column AGE_DIARIA.DS_QUADRIMESTRE is
'Contém a descrição do quadrimestre Ex: Segundo  Quadrimestre';

comment on column AGE_DIARIA.ID_SEMESTRE is
'Número do Semestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_DIARIA.SG_SEMESTRE is
'Sigla do Semestre Ex: 2S';

comment on column AGE_DIARIA.SEMES_DS_ABREVIADO1 is
'Abreviação do Semestre Ex: 2 Sem';

comment on column AGE_DIARIA.SEMES_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Semestre';

comment on column AGE_DIARIA.SEMES_DS_INTERVALO1 is
'Intervalo de meses do semestre abreviado';

comment on column AGE_DIARIA.SEMES_DS_INTERVALO2 is
'Intervalo de meses do semestre extenso';

comment on column AGE_DIARIA.DS_SEMESTRE is
'Contém a descrição do Semestre Ex: Segundo  Semestre';

comment on column AGE_DIARIA.ID_ANO is
'Campo com formato AAAA do ano. Exemplo: 2015.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_DIARIA.DS_ANO_REDUZIDO is
'Ano reduzido Ex: 15';

comment on column AGE_DIARIA.DS_ANO is
'Ano por extenso Ex: Dois mil e quinze';

comment on column AGE_DIARIA.FL_ANO_BISSEXTO is
'Flag que indica se esse ano é bissexto (valor "S"= sim e valor "N"=Não) ';

comment on column AGE_DIARIA.ID_DECADA is
'Número da Década.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_DIARIA.SG_DECADA is
'Abreviação do número da Década. Exemplo:  Década de 30';

comment on column AGE_DIARIA.DS_DECADA1 is
'Descrição da Década ''DÉCADA DE 1990''';

comment on column AGE_DIARIA.DS_DECADA2 is
'Descrição da Década '' ANOS 90''';

comment on column AGE_DIARIA.DS_DECADA_EXTENSO is
'Descrição por extenso';

comment on column AGE_DIARIA.ID_SECULO is
'Número do Século. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_DIARIA.NR_ROMANO is
'Número do Século em Romano';

comment on column AGE_DIARIA.DS_SECULO is
'Descrição do Século';

/*==============================================================*/
/* View: AGE_MENSAL                                             */
/*==============================================================*/
create or replace view AGE_MENSAL(ID_ANO_MES, DS_MES_ANO1, DS_MES_ANO2, DS_MES_ANO3, DS_MES_ANO4, DS_MES_ANO5, NR_PRI_DIA_UTIL, NR_ULT_DIA_UTIL, NR_PRI_DIA, NR_ULT_DIA, ID_DIA_SEM_INI, ID_DIA_SEM_FIM, QT_SEG, QT_TER, QT_QUA, QT_QUI, QT_SEX, QT_SAB, QT_DOM, QT_FERIADOS_SAB_DOM, QT_DIAS_UTEIS, ID_MES, NR_MES_ZERO, SG_MES, DS_MES, NR_ULT_DIA_MES, ID_BIMESTRE, SG_BIMESTRE, BIMES_DS_ABREVIADO1, BIMES_DS_ABREVIADO2, BIMES_DS_INTERVALO1, BIMES_DS_INTERVALO2, DS_BIMESTRE, ID_TRIMESTRE, SG_TRIMESTRE, TRIME_DS_ABREVIADO1, TRIME_DS_ABREVIADO2, TRIME_DS_INTERVALO1, TRIME_DS_INTERVALO2, DS_TRIMESTRE, ID_QUADRIMESTRE, SG_QUADRIMESTRE, QUADR_DS_ABREVIADO1, QUADR_DS_ABREVIADO2, QUADR_DS_INTERVALO1, QUADR_DS_INTERVALO2, DS_QUADRIMESTRE, ID_SEMESTRE, SG_SEMESTRE, SEMES_DS_ABREVIADO1, SEMES_DS_ABREVIADO2, SEMES_DS_INTERVALO1, SEMES_DS_INTERVALO2, DS_SEMESTRE, ID_ANO, DS_ANO_REDUZIDO, DS_ANO, FL_ANO_BISSEXTO, ID_DECADA, SG_DECADA, DS_DECADA1, DS_DECADA2, DS_DECADA_EXTENSO, ID_SECULO, NR_ROMANO, DS_SECULO) as
select
   anomes.id_ano_mes,
   anomes.ds_mes_ano1,
   anomes.ds_mes_ano2,
   anomes.ds_mes_ano3,
   anomes.ds_mes_ano4,
   anomes.ds_mes_ano5,
   anomes.nr_pri_dia_util,
   anomes.nr_ult_dia_util,
   anomes.nr_pri_dia,
   anomes.nr_ult_dia,
   anomes.id_dia_sem_ini,
   anomes.id_dia_sem_fim,
   anomes.qt_seg,
   anomes.qt_ter,
   anomes.qt_qua,
   anomes.qt_qui,
   anomes.qt_sex,
   anomes.qt_sab,
   anomes.qt_dom,
   anomes.qt_feriados_sab_dom,
   anomes.qt_dias_uteis,
   mes.id_mes,
   mes.nr_mes_zero,
   mes.sg_mes,
   mes.ds_mes,
   mes.nr_ult_dia_mes,
   bim.id_bimestre,
   bim.sg_bimestre,
   bim.ds_abreviado1 as bimes_ds_abreviado1,
   bim.ds_abreviado2 as bimes_ds_abreviado2,
   bim.ds_intervalo1 as bimes_ds_intervalo1,
   bim.ds_intervalo2 as bimes_ds_intervalo2,
   bim.ds_bimestre,
   tri.id_trimestre,
   tri.sg_trimestre,
   tri.ds_abreviado1 as trime_ds_abreviado1,
   tri.ds_abreviado2 as trime_ds_abreviado2,
   tri.ds_intervalo as trime_ds_intervalo1,
   tri.ds_intervalo2 as trime_ds_intervalo2,
   tri.ds_trimestre,
   qua.id_quadrimestre,
   qua.sg_quadrimestre,
   qua.ds_abreviado1 as quadr_ds_abreviado1,
   qua.ds_abreviado2 as quadr_ds_abreviado2,
   qua.ds_intervalo1 as quadr_ds_intervalo1,
   qua.ds_intervalo2 as quadr_ds_intervalo2,
   qua.ds_quadrimestre,
   sem.id_semestre,
   sem.sg_semestre,
   sem.ds_abreviado1 as semes_ds_abreviado1,
   sem.ds_abreviado2 as semes_ds_abreviado2,
   sem.ds_intervalo1 as semes_ds_intervalo1,
   sem.ds_intervalo2 as semes_ds_intervalo2,
   sem.ds_semestre,
   ano.id_ano,
   ano.ds_ano_reduzido,
   ano.ds_ano,
   ano.fl_ano_bissexto,
   dez.id_decada,
   dez.sg_decada,
   dez.ds_decada1,
   dez.ds_decada2,
   dez.ds_decada_extenso,
   sec.id_seculo,
   sec.nr_romano,
   sec.ds_seculo
from
   AGE_ANOS_MESES anomes,
   AGE_MESES mes,
   AGE_BIMESTRES bim,
   AGE_TRIMESTRES tri,
   AGE_QUADRIMESTRES qua,
   AGE_SEMESTRES sem,
   AGE_ANOS ano,
   AGE_DECADAS dez,
   AGE_SECULOS sec
where
   1 = 1
   and anomes.id_mes = mes.id_mes
   and mes.id_bimestre = bim.id_bimestre
   and mes.id_trimestre = tri.id_trimestre
   and bim.id_quadrimestre = qua.id_quadrimestre
   and bim.id_semestre = sem.id_semestre
   and anomes.id_ano = ano.id_ano
   and ano.id_decada = dez.id_decada
   and dez.id_seculo = sec.id_seculo
with read only;

comment on column AGE_MENSAL.ID_ANO_MES is
'Número do ano e mes no formato AAAAMM. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo.';

comment on column AGE_MENSAL.DS_MES_ANO1 is
'Número do mês e ano no fomato 082008';

comment on column AGE_MENSAL.DS_MES_ANO2 is
'Número do mês e ano no fomato 08/2015';

comment on column AGE_MENSAL.DS_MES_ANO3 is
'Número do mês e ano no fomato AGO/2015';

comment on column AGE_MENSAL.DS_MES_ANO4 is
'Número do mês e ano no fomato AGOSTO/2015';

comment on column AGE_MENSAL.DS_MES_ANO5 is
'Número do mês e ano no fomato Agosto de 2015';

comment on column AGE_MENSAL.NR_PRI_DIA_UTIL is
'Primeiro dia Útil desse mês nesse ano';

comment on column AGE_MENSAL.NR_ULT_DIA_UTIL is
'Último dia Útil desse mês nesse ano';

comment on column AGE_MENSAL.NR_PRI_DIA is
'Primeiro dia desse mês nesse ano';

comment on column AGE_MENSAL.NR_ULT_DIA is
'Último dia desse mês nesse ano ';

comment on column AGE_MENSAL.ID_DIA_SEM_INI is
'Dia da semana que inicia o mês (Segunda)';

comment on column AGE_MENSAL.ID_DIA_SEM_FIM is
'Dia da semana que finaliza (Sexta)';

comment on column AGE_MENSAL.QT_SEG is
'Quantidades de segundas nesse mês';

comment on column AGE_MENSAL.QT_TER is
'Quantidades de terças nesse mês';

comment on column AGE_MENSAL.QT_QUA is
'Quantidades de quartas nesse mês';

comment on column AGE_MENSAL.QT_QUI is
'Quantidades de quintas nesse mês';

comment on column AGE_MENSAL.QT_SEX is
'Quantidades de sextas nesse mês';

comment on column AGE_MENSAL.QT_SAB is
'Quantidades de sábados nesse mês';

comment on column AGE_MENSAL.QT_DOM is
'Quantidades de domingos nesse mês';

comment on column AGE_MENSAL.QT_FERIADOS_SAB_DOM is
'Quantidades de feriados nos fins de semana';

comment on column AGE_MENSAL.QT_DIAS_UTEIS is
'Quantidade de dias uteis nesse mês';

comment on column AGE_MENSAL.ID_MES is
'Número do Mês Ex: 8. Chave da tabela gerada via script.';

comment on column AGE_MENSAL.NR_MES_ZERO is
'Número do Mês com zero  Ex: 08';

comment on column AGE_MENSAL.SG_MES is
'Mês abreviado. Ex: AGO';

comment on column AGE_MENSAL.DS_MES is
'Descrição do Mês.  Ex: AGOSTO';

comment on column AGE_MENSAL.NR_ULT_DIA_MES is
'Numero do último dia do mês (no caso de fevereitro bissexto tratamos como exceção)';

comment on column AGE_MENSAL.ID_BIMESTRE is
'Número do Bimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_MENSAL.SG_BIMESTRE is
'Sigla do Bimestre Ex: 2B';

comment on column AGE_MENSAL.BIMES_DS_ABREVIADO1 is
'Abreviação do Bimestre Ex: 2 BIM';

comment on column AGE_MENSAL.BIMES_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Bimestre';

comment on column AGE_MENSAL.BIMES_DS_INTERVALO1 is
'Intervalo de meses do Bimestre Abreviado';

comment on column AGE_MENSAL.BIMES_DS_INTERVALO2 is
'Intervalo de meses do Bimestre Extenso';

comment on column AGE_MENSAL.DS_BIMESTRE is
'Contém a descrição do Semestre Ex: Segundo  Bimestre';

comment on column AGE_MENSAL.ID_TRIMESTRE is
'Número do Trimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_MENSAL.SG_TRIMESTRE is
'Sigla do Trimestre Ex: 2T';

comment on column AGE_MENSAL.TRIME_DS_ABREVIADO1 is
'Abreviação do Trimestre Ex: 2 Tri';

comment on column AGE_MENSAL.TRIME_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Trimestre';

comment on column AGE_MENSAL.TRIME_DS_INTERVALO1 is
'Intervalo de meses do trimestre abreviado';

comment on column AGE_MENSAL.TRIME_DS_INTERVALO2 is
'Intervalo de meses do trimestre extenso';

comment on column AGE_MENSAL.DS_TRIMESTRE is
'Contém a descrição do Trimestre Ex: Segundo  Trimestre';

comment on column AGE_MENSAL.ID_QUADRIMESTRE is
'Número do Quadrimestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_MENSAL.SG_QUADRIMESTRE is
'Sigla do Quadrimestre Ex: 2Q';

comment on column AGE_MENSAL.QUADR_DS_ABREVIADO1 is
'Abreviação do Quadrimestre Ex: 2 Qua';

comment on column AGE_MENSAL.QUADR_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Quadrimestre';

comment on column AGE_MENSAL.QUADR_DS_INTERVALO1 is
'Intervalo de meses do quadrimestre abreviado';

comment on column AGE_MENSAL.QUADR_DS_INTERVALO2 is
'Intervalo de meses do quadrimestre extenso';

comment on column AGE_MENSAL.DS_QUADRIMESTRE is
'Contém a descrição do quadrimestre Ex: Segundo  Quadrimestre';

comment on column AGE_MENSAL.ID_SEMESTRE is
'Número do Semestre.Chave da tabela, Existe no banco de dados uma sequência associada a essa coluna responsável pela sua numeração automática.';

comment on column AGE_MENSAL.SG_SEMESTRE is
'Sigla do Semestre Ex: 2S';

comment on column AGE_MENSAL.SEMES_DS_ABREVIADO1 is
'Abreviação do Semestre Ex: 2 Sem';

comment on column AGE_MENSAL.SEMES_DS_ABREVIADO2 is
'Descrição abreviada  Ex: 2 Semestre';

comment on column AGE_MENSAL.SEMES_DS_INTERVALO1 is
'Intervalo de meses do semestre abreviado';

comment on column AGE_MENSAL.SEMES_DS_INTERVALO2 is
'Intervalo de meses do semestre extenso';

comment on column AGE_MENSAL.DS_SEMESTRE is
'Contém a descrição do Semestre Ex: Segundo  Semestre';

comment on column AGE_MENSAL.ID_ANO is
'Campo com formato AAAA do ano. Exemplo: 2015.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_MENSAL.DS_ANO_REDUZIDO is
'Ano reduzido Ex: 15';

comment on column AGE_MENSAL.DS_ANO is
'Ano por extenso Ex: Dois mil e quinze';

comment on column AGE_MENSAL.FL_ANO_BISSEXTO is
'Flag que indica se esse ano é bissexto (valor "S"= sim e valor "N"=Não) ';

comment on column AGE_MENSAL.ID_DECADA is
'Número da Década.Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_MENSAL.SG_DECADA is
'Abreviação do número da Década. Exemplo:  Década de 30';

comment on column AGE_MENSAL.DS_DECADA1 is
'Descrição da Década ''DÉCADA DE 1990''';

comment on column AGE_MENSAL.DS_DECADA2 is
'Descrição da Década '' ANOS 90''';

comment on column AGE_MENSAL.DS_DECADA_EXTENSO is
'Descrição por extenso';

comment on column AGE_MENSAL.ID_SECULO is
'Número do Século. Chave da tabela gerada via script. Favor ferificar no F5 - Aplicação do Modelo. ';

comment on column AGE_MENSAL.NR_ROMANO is
'Número do Século em Romano';

comment on column AGE_MENSAL.DS_SECULO is
'Descrição do Século';

alter table AGE_ANOS
   add constraint age_anos_fk01 foreign key (id_decada)
      references AGE_DECADAS (id_decada);

alter table AGE_ANOS_MESES
   add constraint age_anos_meses_fk01 foreign key (id_mes)
      references AGE_MESES (id_mes);

alter table AGE_ANOS_MESES
   add constraint age_anos_meses_fk02 foreign key (id_ano)
      references AGE_ANOS (id_ano);

alter table AGE_ANOS_MESES
   add constraint age_anos_meses_fk03 foreign key (id_dia_sem_ini)
      references AGE_SEMANAS_DIAS (id_semana_dia);

alter table AGE_ANOS_MESES
   add constraint age_anos_meses_fk04 foreign key (id_dia_sem_fim)
      references AGE_SEMANAS_DIAS (id_semana_dia);

alter table AGE_BIMESTRES
   add constraint age_bimestres_fk01 foreign key (id_quadrimestre)
      references AGE_QUADRIMESTRES (id_quadrimestre);

alter table AGE_BIMESTRES
   add constraint age_bimestres_fk02 foreign key (id_semestre)
      references AGE_SEMESTRES (id_semestre);

alter table AGE_DATAS
   add constraint age_datas_fk01 foreign key (id_feriado)
      references AGE_FERIADOS (id_feriado);

alter table AGE_DATAS
   add constraint age_datas_fk02 foreign key (id_ano_mes)
      references AGE_ANOS_MESES (id_ano_mes);

alter table AGE_DATAS
   add constraint age_datas_fk03 foreign key (id_dia_semana)
      references AGE_SEMANAS_DIAS (id_semana_dia);

alter table AGE_DATAS
   add constraint age_datas_fk04 foreign key (id_dia_mes)
      references AGE_MESES_DIAS (id_mes_dia);

alter table AGE_DECADAS
   add constraint age_decadas_fk01 foreign key (id_seculo)
      references AGE_SECULOS (id_seculo);

alter table AGE_FERIADOS
   add constraint age_feriados_fk01 foreign key (id_feriado_tipo)
      references AGE_FERIADOS_TIPOS (id_feriado_tipo);

alter table AGE_MESES
   add constraint age_meses_fk01 foreign key (id_bimestre)
      references AGE_BIMESTRES (id_bimestre);

alter table AGE_MESES
   add constraint age_meses_fk02 foreign key (id_trimestre)
      references AGE_TRIMESTRES (id_trimestre);

alter table AGE_MESES_DIAS
   add constraint age_meses_dias_fk01 foreign key (id_quinzena)
      references AGE_QUINZENAS (id_quinzena);

alter table AGE_SECULOS
   add constraint age_seculos_fk01 foreign key (id_anno_domini)
      references AGE_ANNO_DOMINI (id_anno_domini);

alter table AGE_TRIMESTRES
   add constraint age_trimestres_fk01 foreign key (id_semestre)
      references AGE_SEMESTRES (id_semestre);

