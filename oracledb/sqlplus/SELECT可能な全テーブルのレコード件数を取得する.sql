-- SQL> SET SERVEROUTPUT ON

-- SELECT�\�ȑS�e�[�u���̃��R�[�h�������擾����
DECLARE
    -- �萔
    cOWNER VARCHAR2(30) := 'IKUYANI'; -- �I�[�i�[
    cDELIM VARCHAR2(10) := CHR(9); -- ��؂蕶��

    -- �ϐ�
    vCOUNT NUMBER(12); -- �e�[�u���̌������i�[

BEGIN

    DBMS_OUTPUT.PUT_LINE('�e�[�u����' || cDELIM || '����');

    FOR TABLE_REC IN (
        SELECT OWNER, OBJECT_NAME FROM ALL_OBJECTS
        WHERE OWNER LIKE cOWNER AND OBJECT_TYPE IN ('TABLE')
        ORDER BY OBJECT_NAME
    )
    LOOP
        EXECUTE IMMEDIATE
            'SELECT COUNT(1) FROM ' || TABLE_REC.OWNER || '.' || TABLE_REC.OBJECT_NAME
            INTO vCOUNT;
        DBMS_OUTPUT.PUT_LINE(TABLE_REC.OBJECT_NAME || cDELIM || vCOUNT);
    END LOOP;
END;
/
