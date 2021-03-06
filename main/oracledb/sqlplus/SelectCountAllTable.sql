-- Charset MS932
-- SQL> SET SERVEROUTPUT ON
-- SQL> @SelectCountAllTable.sql ${Owner}

-- SELECT可能な全テーブルのレコード件数を取得する
DECLARE
    -- 定数
    cOWNER VARCHAR2(30) := '&1'; -- オーナー
    cDELIM VARCHAR2(10) := CHR(9); -- 区切り文字

    -- 変数
    vCOUNT NUMBER(12); -- テーブルの件数を格納

BEGIN

    DBMS_OUTPUT.PUT_LINE('テーブル名' || cDELIM || '件数');

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
