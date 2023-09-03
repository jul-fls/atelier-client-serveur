DROP SEQUENCE "ORACLE_DEV"."SEQ_AUTOID_ARTICLE";
DROP SEQUENCE "ORACLE_DEV"."SEQ_AUTOID_CLIENT";
DROP SEQUENCE "ORACLE_DEV"."SEQ_AUTOID_FACTURE";
DROP TABLE "ORACLE_DEV"."ARTICLE";
DROP TABLE "ORACLE_DEV"."CLIENT";
DROP TABLE "ORACLE_DEV"."FACTURE";
DROP TABLE "ORACLE_DEV"."QTE_FACT";
DROP VIEW "ORACLE_DEV"."V_CLIFACT";
DROP VIEW "ORACLE_DEV"."V_VENTES";
DROP PROCEDURE "ORACLE_DEV"."SUPP_FACT";
--------------------------------------------------------
--  DDL for Sequence SEQ_AUTOID_ARTICLE
--------------------------------------------------------

   CREATE SEQUENCE  "ORACLE_DEV"."SEQ_AUTOID_ARTICLE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence SEQ_AUTOID_CLIENT
--------------------------------------------------------

   CREATE SEQUENCE  "ORACLE_DEV"."SEQ_AUTOID_CLIENT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence SEQ_AUTOID_FACTURE
--------------------------------------------------------

   CREATE SEQUENCE  "ORACLE_DEV"."SEQ_AUTOID_FACTURE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table ARTICLE
--------------------------------------------------------

  CREATE TABLE "ORACLE_DEV"."ARTICLE" 
   (	"ID_ARTICLE" NUMBER(10,0), 
	"NOM" VARCHAR2(50 BYTE), 
	"PRIX_ACHAT" FLOAT(126), 
	"PRIX_VENTE" FLOAT(126), 
	"EAN" VARCHAR2(20 BYTE), 
	"STOCK_MIN" NUMBER(10,0), 
	"STOCK_MAX" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CLIENT
--------------------------------------------------------

  CREATE TABLE "ORACLE_DEV"."CLIENT" 
   (	"ID_CLIENT" NUMBER(10,0), 
	"NOM" VARCHAR2(50 BYTE), 
	"SOCIETE" VARCHAR2(50 BYTE), 
	"ADRESSE" VARCHAR2(100 BYTE), 
	"CODE_POSTAL" VARCHAR2(10 BYTE), 
	"VILLE" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table FACTURE
--------------------------------------------------------

  CREATE TABLE "ORACLE_DEV"."FACTURE" 
   (	"ID_FACTURE" NUMBER(10,0), 
	"DATE_FACT" DATE, 
	"ID_CLIENT" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table QTE_FACT
--------------------------------------------------------

  CREATE TABLE "ORACLE_DEV"."QTE_FACT" 
   (	"ID_ARTICLE" NUMBER(10,0), 
	"ID_FACTURE" NUMBER(10,0), 
	"QTE" NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View V_CLIFACT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORACLE_DEV"."V_CLIFACT" ("ID_FACTURE", "SOCIETE") AS 
  SELECT facture.id_facture,client.societe FROM client,facture
WHERE client.id_client = facture.id_client
;
--------------------------------------------------------
--  DDL for View V_VENTES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORACLE_DEV"."V_VENTES" ("ID_FACTURE", "QTE", "NOM", "SOCIETE") AS 
  SELECT facture.id_facture,qte_fact.qte,article.nom,client.societe FROM client,facture,qte_fact,article
WHERE facture.id_client = client.id_client
AND facture.id_facture = facture.id_facture
AND qte_fact.id_article = article.id_article
order   by ID_facture
;
REM INSERTING into ORACLE_DEV.ARTICLE
SET DEFINE OFF;
Insert into ORACLE_DEV.ARTICLE (ID_ARTICLE,NOM,PRIX_ACHAT,PRIX_VENTE,EAN,STOCK_MIN,STOCK_MAX) values ('1','T-shirt','10,99','19,99','1234567890123','10','50');
Insert into ORACLE_DEV.ARTICLE (ID_ARTICLE,NOM,PRIX_ACHAT,PRIX_VENTE,EAN,STOCK_MIN,STOCK_MAX) values ('2','Jeans','29,99','49,99','2345678901234','5','20');
Insert into ORACLE_DEV.ARTICLE (ID_ARTICLE,NOM,PRIX_ACHAT,PRIX_VENTE,EAN,STOCK_MIN,STOCK_MAX) values ('3','Chaussures','59,99','99,99','3456789012345','3','15');
REM INSERTING into ORACLE_DEV.CLIENT
SET DEFINE OFF;
Insert into ORACLE_DEV.CLIENT (ID_CLIENT,NOM,SOCIETE,ADRESSE,CODE_POSTAL,VILLE) values ('1','Dupont','ACME Inc.','10 Rue de la Paix','75001','Paris');
Insert into ORACLE_DEV.CLIENT (ID_CLIENT,NOM,SOCIETE,ADRESSE,CODE_POSTAL,VILLE) values ('2','Smith','Widgets Inc.','123 Main St','10001','New York');
Insert into ORACLE_DEV.CLIENT (ID_CLIENT,NOM,SOCIETE,ADRESSE,CODE_POSTAL,VILLE) values ('3','Garcia','Globex Corp.','456 Broadway','90210','Beverly Hills');
Insert into ORACLE_DEV.CLIENT (ID_CLIENT,NOM,SOCIETE,ADRESSE,CODE_POSTAL,VILLE) values ('4','Wang','ABC Company','789 Nanjing Rd','200001','Shanghai');
Insert into ORACLE_DEV.CLIENT (ID_CLIENT,NOM,SOCIETE,ADRESSE,CODE_POSTAL,VILLE) values ('5','Muller','XYZ GmbH','Musterstr. 1','10178','Berlin');
REM INSERTING into ORACLE_DEV.FACTURE
SET DEFINE OFF;
Insert into ORACLE_DEV.FACTURE (ID_FACTURE,DATE_FACT,ID_CLIENT) values ('1',to_date('29/08/23','DD/MM/RR'),'1');
Insert into ORACLE_DEV.FACTURE (ID_FACTURE,DATE_FACT,ID_CLIENT) values ('2',to_date('29/08/23','DD/MM/RR'),'1');
Insert into ORACLE_DEV.FACTURE (ID_FACTURE,DATE_FACT,ID_CLIENT) values ('3',to_date('29/08/23','DD/MM/RR'),'3');
Insert into ORACLE_DEV.FACTURE (ID_FACTURE,DATE_FACT,ID_CLIENT) values ('4',to_date('29/08/23','DD/MM/RR'),'2');
REM INSERTING into ORACLE_DEV.QTE_FACT
SET DEFINE OFF;
Insert into ORACLE_DEV.QTE_FACT (ID_ARTICLE,ID_FACTURE,QTE) values ('1','1','10');
Insert into ORACLE_DEV.QTE_FACT (ID_ARTICLE,ID_FACTURE,QTE) values ('1','2','15');
Insert into ORACLE_DEV.QTE_FACT (ID_ARTICLE,ID_FACTURE,QTE) values ('3','1','4');
Insert into ORACLE_DEV.QTE_FACT (ID_ARTICLE,ID_FACTURE,QTE) values ('2','1','20');
Insert into ORACLE_DEV.QTE_FACT (ID_ARTICLE,ID_FACTURE,QTE) values ('1','3','0');
REM INSERTING into ORACLE_DEV.V_CLIFACT
SET DEFINE OFF;
Insert into ORACLE_DEV.V_CLIFACT (ID_FACTURE,SOCIETE) values ('1','ACME Inc.');
Insert into ORACLE_DEV.V_CLIFACT (ID_FACTURE,SOCIETE) values ('2','ACME Inc.');
Insert into ORACLE_DEV.V_CLIFACT (ID_FACTURE,SOCIETE) values ('4','Widgets Inc.');
Insert into ORACLE_DEV.V_CLIFACT (ID_FACTURE,SOCIETE) values ('3','Globex Corp.');
REM INSERTING into ORACLE_DEV.V_VENTES
SET DEFINE OFF;
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('1','10','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('1','0','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('1','20','Jeans','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('1','4','Chaussures','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('1','15','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('2','15','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('2','10','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('2','0','T-shirt','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('2','20','Jeans','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('2','4','Chaussures','ACME Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('3','15','T-shirt','Globex Corp.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('3','10','T-shirt','Globex Corp.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('3','0','T-shirt','Globex Corp.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('3','20','Jeans','Globex Corp.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('3','4','Chaussures','Globex Corp.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('4','15','T-shirt','Widgets Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('4','0','T-shirt','Widgets Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('4','10','T-shirt','Widgets Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('4','4','Chaussures','Widgets Inc.');
Insert into ORACLE_DEV.V_VENTES (ID_FACTURE,QTE,NOM,SOCIETE) values ('4','20','Jeans','Widgets Inc.');
--------------------------------------------------------
--  DDL for Index ARTICLE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."ARTICLE_PK" ON "ORACLE_DEV"."ARTICLE" ("ID_ARTICLE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index CLIENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."CLIENT_PK" ON "ORACLE_DEV"."CLIENT" ("ID_CLIENT") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index FACTURE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."FACTURE_PK" ON "ORACLE_DEV"."FACTURE" ("ID_FACTURE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index QTE_FACT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."QTE_FACT_PK" ON "ORACLE_DEV"."QTE_FACT" ("ID_ARTICLE", "ID_FACTURE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index ARTICLE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."ARTICLE_PK" ON "ORACLE_DEV"."ARTICLE" ("ID_ARTICLE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index CLIENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."CLIENT_PK" ON "ORACLE_DEV"."CLIENT" ("ID_CLIENT") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index FACTURE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."FACTURE_PK" ON "ORACLE_DEV"."FACTURE" ("ID_FACTURE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index QTE_FACT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ORACLE_DEV"."QTE_FACT_PK" ON "ORACLE_DEV"."QTE_FACT" ("ID_ARTICLE", "ID_FACTURE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Trigger AUTOID_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_ARTICLE" 
BEFORE INSERT ON article

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_Article.NEXTVAL
    INTO :NEW.ID_ARTICLE FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_ARTICLE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUTOID_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_CLIENT" 
BEFORE INSERT ON client

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_CLIENT.NEXTVAL
    INTO :NEW.ID_CLIENT FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_CLIENT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUTOID_FACTURE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_FACTURE" 
BEFORE INSERT ON FACTURE

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_FACTURE.NEXTVAL
    INTO :NEW.ID_FACTURE FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_FACTURE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TR_DATEFACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."TR_DATEFACT" 
BEFORE INSERT ON facture

FOR EACH ROW
BEGIN
    SELECT CURRENT_DATE
    INTO :NEW.DATE_FACT FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."TR_DATEFACT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUTOID_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_ARTICLE" 
BEFORE INSERT ON article

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_Article.NEXTVAL
    INTO :NEW.ID_ARTICLE FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_ARTICLE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUTOID_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_CLIENT" 
BEFORE INSERT ON client

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_CLIENT.NEXTVAL
    INTO :NEW.ID_CLIENT FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_CLIENT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TR_DATEFACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."TR_DATEFACT" 
BEFORE INSERT ON facture

FOR EACH ROW
BEGIN
    SELECT CURRENT_DATE
    INTO :NEW.DATE_FACT FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."TR_DATEFACT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUTOID_FACTURE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ORACLE_DEV"."AUTOID_FACTURE" 
BEFORE INSERT ON FACTURE

FOR EACH ROW
BEGIN
    SELECT SEQ_AutoID_FACTURE.NEXTVAL
    INTO :NEW.ID_FACTURE FROM DUAL;
END;

/
ALTER TRIGGER "ORACLE_DEV"."AUTOID_FACTURE" ENABLE;
--------------------------------------------------------
--  DDL for Procedure SUPP_FACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ORACLE_DEV"."SUPP_FACT" 

IS
    CURSOR lst_fact IS
    SELECT f.id_facture, SUM(a.prix_vente*qf.qte) AS TOTAL FROM facture f,article a,qte_fact qf
        WHERE
        qf.id_article = a.id_article
        and
        qf.id_facture = f.id_facture
        GROUP BY f.id_facture;
BEGIN
    DBMS_OUTPUT.enable;
    FOR i IN lst_fact LOOP
    IF i.TOTAL = 0 THEN
    --DELETE FROM facture WHERE id_facture=i.id_facture;
    DBMS_OUTPUT.put_line('Facture ' || i.id_facture || 'supprimée.');    
    END IF;
    END LOOP;
    
END SUPP_FACT;

/
--------------------------------------------------------
--  Constraints for Table ARTICLE
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("ID_ARTICLE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("NOM" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("PRIX_ACHAT" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("PRIX_VENTE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("EAN" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("STOCK_MIN" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" MODIFY ("STOCK_MAX" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."ARTICLE" ADD CONSTRAINT "ARTICLE_PK" PRIMARY KEY ("ID_ARTICLE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENT
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."CLIENT" MODIFY ("ID_CLIENT" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."CLIENT" MODIFY ("NOM" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."CLIENT" MODIFY ("ADRESSE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."CLIENT" MODIFY ("CODE_POSTAL" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."CLIENT" MODIFY ("VILLE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."CLIENT" ADD CONSTRAINT "CLIENT_PK" PRIMARY KEY ("ID_CLIENT")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table FACTURE
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."FACTURE" MODIFY ("ID_FACTURE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."FACTURE" MODIFY ("DATE_FACT" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."FACTURE" MODIFY ("ID_CLIENT" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."FACTURE" ADD CONSTRAINT "FACTURE_PK" PRIMARY KEY ("ID_FACTURE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table QTE_FACT
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."QTE_FACT" MODIFY ("ID_ARTICLE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."QTE_FACT" MODIFY ("ID_FACTURE" NOT NULL ENABLE);
  ALTER TABLE "ORACLE_DEV"."QTE_FACT" ADD CONSTRAINT "QTE_FACT_PK" PRIMARY KEY ("ID_ARTICLE", "ID_FACTURE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ORACLE_DEV"."QTE_FACT" MODIFY ("QTE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table FACTURE
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."FACTURE" ADD CONSTRAINT "FACTURE_CLIENT_FK" FOREIGN KEY ("ID_CLIENT")
	  REFERENCES "ORACLE_DEV"."CLIENT" ("ID_CLIENT") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table QTE_FACT
--------------------------------------------------------

  ALTER TABLE "ORACLE_DEV"."QTE_FACT" ADD CONSTRAINT "QTE_FACT_ARTICLE_FK" FOREIGN KEY ("ID_ARTICLE")
	  REFERENCES "ORACLE_DEV"."ARTICLE" ("ID_ARTICLE") ENABLE;
  ALTER TABLE "ORACLE_DEV"."QTE_FACT" ADD CONSTRAINT "QTE_FACT_FACTURE0_FK" FOREIGN KEY ("ID_FACTURE")
	  REFERENCES "ORACLE_DEV"."FACTURE" ("ID_FACTURE") ENABLE;
