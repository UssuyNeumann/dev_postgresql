CREATE OR REPLACE function fn_backup_script(p_nm_object character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$ 
/*
--
-- criado por: Luis Neumann
-- data: 25/10/2021	
-- descrição: Função de backup de rotinas
--
*/
DECLARE 
	v_rows int;
	v_script varchar;
	
BEGIN
	-- BUSCA OBJETO
	SELECT 1 FROM pg_proc WHERE proname = p_nm_object INTO v_rows;

	-- VALIDA SE OBJETO EXISTE E SALVA NA VARIAVEL
	IF (v_rows = 1) THEN
		SELECT 
			pg_get_functiondef(oid)
		FROM pg_proc
		WHERE proname = p_nm_object INTO v_script;
	
	-- ADICIONA O PREFIXO BKP_
		v_script =  REPLACE(v_script, p_nm_object, 'BKP_'||p_nm_object);
	
	-- CRIA O BACKUP
		EXECUTE v_script;
	
		RETURN 'BACKUP CRIADO COM SUCESSO.';
	ELSE 
		RETURN 'ROTINA NÃO ENCONTRADA.'; 
	END IF;	

END;
$function$
;
