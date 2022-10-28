DO $$
BEGIN
	
    DECLARE 
        i INT = 1; 
        inicio DATE = '2022-01-01'; 
        random_date DATE; 
  
    -- bloco automatizado 
    BEGIN 	
 
        DROP TABLE IF EXISTS tmp_vendas;
        CREATE TEMP TABLE IF NOT EXISTS tmp_vendas(
    	    cod_venda INT UNIQUE,
    	    dt_venda TIMESTAMP NOT NULL
	    ); 

     	WHILE i <= 100 LOOP

            -- gera data de periodo aleatorio até 90 dias da data inicio
            SELECT (inicio + random() * interval '90 days')::DATE INTO random_date;
            
            -- insere registros
            INSERT INTO tmp_vendas(cod_venda,dt_venda) values(i,random_date);
            
            -- contador 
  		    i = i + 1;
	
	    END LOOP;      
    END;  

END
$$ 