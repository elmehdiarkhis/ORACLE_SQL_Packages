CREATE TABLE clients(
    noclient NUMBER PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    telephone VARCHAR(20)  
);

INSERT INTO clients
VALUES
(1,'Stephane','jumper','5143201598');

INSERT INTO clients
VALUES
(2,'alex','browski','4389201687');

INSERT INTO clients
VALUES
(3,'simou','lefdass','5149201683');

CREATE TABLE voitures(
    code VARCHAR(20) PRIMARY KEY,
    marque VARCHAR(10)
);

CREATE OR REPLACE PACKAGE mypack AS 
PROCEDURE p_printEmps;
PROCEDURE procCode;
PROCEDURE procToutVoit;
FUNCTION opera(val1 NUMBER,val2 NUMBER,oper VARCHAR2) RETURN NUMBER;
FUNCTION factorielle(valeur NUMBER) RETURN NUMBER;

END mypack;


CREATE OR REPLACE PACKAGE BODY mypack AS 

PROCEDURE p_printEmps IS
CURSOR c_emp IS select * from clients;
 r_emp c_emp%ROWTYPE;
BEGIN
OPEN c_emp; 
 LOOP	
FETCH c_emp INTO r_emp;
EXIT WHEN c_emp%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(r_emp.nom); 
END LOOP;
CLOSE c_emp;
END;






PROCEDURE procCode IS 
vmarque VARCHAR(10):='&vmarque';
vnbrV NUMBER(5):=&vnbrV;
vcode VARCHAR(20);
j NUMBER(5);


BEGIN
FOR j IN 1..vnbrV LOOP
vcode := (vmarque || j);
DBMS_OUTPUT.PUT_LINE(vcode);
INSERT INTO voitures(code,marque)
VALUES
(vcode,vmarque);
END LOOP;
END procCode;

PROCEDURE procToutVoit IS
v_voit voitures%ROWTYPE;
        CURSOR curseur IS
        SELECT *
        FROM voitures;
BEGIN
OPEN curseur;
LOOP
FETCH curseur INTO v_voit;
EXIT WHEN curseur%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('code : '||v_voit.code||' marque : '|| v_voit.marque);
END LOOP;
CLOSE curseur;
END procToutVoit;

FUNCTION opera(val1 NUMBER,val2 NUMBER,oper VARCHAR2) RETURN NUMBER IS
res NUMBER;

BEGIN
IF (oper='+')THEN
    res := val1+val2;
    return res;
ELSIF (oper='-')THEN
    res := val1-val2;
    return res; 
ELSIF (oper='x')THEN
    res := val1*val2;
    return res;
ELSIF (oper='/') AND (val2 <>0) THEN 
    res := val1/val2;
    return res; 
END IF;
END opera;

FUNCTION factorielle(valeur NUMBER) RETURN NUMBER IS
result NUMBER:=1;
i NUMBER(5);
BEGIN
FOR i IN 1..valeur
    LOOP
    result := result * i;
    END LOOP;
RETURN result; 
END factorielle;
END mypack;

SET SERVEROUTPUT ON
BEGIN
  mypack.p_printemps();
END;


SET SERVEROUTPUT ON
DECLARE
BEGIN
mypack.procCode();
END;



    
SET SERVEROUTPUT ON;
DECLARE
BEGIN
mypack.procToutVoit;
END;



SET SERVEROUTPUT on;
DECLARE
val1 NUMBER(5):=&val1;
val2 NUMBER(5):=&val2;
oper VARCHAR(10):='&oper';
res NUMBER(5);

BEGIN
    IF (oper='/' AND val2 =0) THEN 
        dbms_output.put_line('Il n ya pas de division sur zero ');
    ELSIF (oper != '/' AND oper != '+' AND oper != '-' AND oper != '/')THEN 
        dbms_output.put_line('Entrer un de ces operateures suivant +-x/'); 
    ELSE 
        res := mypack.opera(val1,val2,oper);
        dbms_output.put_line(val1||' '||oper||' '||val2 || ' = ' || res);
    END IF;
END;    



SET SERVEROUTPUT ON;
DECLARE
valeur NUMBER(5):=&valeur;
result NUMBER(5);
BEGIN
    result := mypack.factorielle(valeur);
    dbms_output.put_line('factorielle(' || valeur || ') = '||result);    
END;


