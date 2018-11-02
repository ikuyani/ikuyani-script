-- Charset MS932
-- SQL> SET LINESIZE 4000
-- SQL> SET TRIMSPOOL ON
-- SQL> SET SERVEROUTPUT ON
-- SQL> @SQLGenerator_Select_forExcel ${Owner} ${Table}

-- 検索結果をタブ区切りで出力するSELECT文を作成する
DECLARE
    -- 固定値
    cOWNER VARCHAR2(30) := '&1'; -- テーブル所有者
    cTABLE VARCHAR2(30) := '&2'; -- テーブル

    cSTR_NEWLINE VARCHAR2(10) := CHR(13) || CHR(10); -- 改行文字
    cSTR_END VARCHAR2(1) := '/'; -- END文字

    cSTR_COLUMN_DELIM VARCHAR2(20) := ' || CHR(9) || '; -- カラム区切り文字列

    -- 変数
    vCOLUMN_SQL VARCHAR2(4000); 
    vCOLUMN VARCHAR2(100);
    vCNT NUMBER(4);

BEGIN

    vCNT := 0;
    vCOLUMN_SQL := '';

    FOR TABLE_REC IN (
        SELECT COLUMN_NAME, DATA_TYPE
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = cOWNER AND TABLE_NAME = cTABLE
        ORDER BY COLUMN_ID
    )
    LOOP

        -- データ型毎の処理
        IF (TABLE_REC.DATA_TYPE = 'DATE') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ', ' || CHR(39) || 'YYYY/MM/DD' || CHR(39) || ')';
        ELSIF (TABLE_REC.DATA_TYPE = 'NUMBER') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ')';
        ELSE
            vCOLUMN := TABLE_REC.COLUMN_NAME;
        END IF;

        -- 区切り文字の設定
        IF (vCNT > 0) THEN
            vCOLUMN_SQL := vCOLUMN_SQL || cSTR_COLUMN_DELIM;
        END IF;
        
        -- カラム追加
        vCOLUMN_SQL := vCOLUMN_SQL || vCOLUMN || cSTR_NEWLINE;

        vCNT := vCNT + 1;

    END LOOP;

    -- SELECT区
    DBMS_OUTPUT.PUT('SELECT ' || cSTR_NEWLINE);
    DBMS_OUTPUT.PUT(vCOLUMN_SQL);

    -- FROM
    DBMS_OUTPUT.PUT_LINE('FROM ' || cOWNER || '.' || cTABLE);

    -- END
    DBMS_OUTPUT.PUT_LINE(cSTR_END);

END;
/

/*** カラムが多く文字列バッファエラーになる場合 *******************

    vCNT := 0;

    DBMS_OUTPUT.PUT('SELECT ' || cSTR_NEWLINE);

    FOR TABLE_REC IN (
        SELECT COLUMN_NAME, DATA_TYPE
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = cOWNER AND TABLE_NAME = cTABLE
        ORDER BY COLUMN_ID
    )
    LOOP
        -- データ型毎の処理
        -- DATE型
        IF (TABLE_REC.DATA_TYPE = 'DATE') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ', ' || CHR(39) || 'YYYY/MM/DD' || CHR(39) || ')';

        -- NUMBER型
        ELSIF (TABLE_REC.DATA_TYPE = 'NUMBER') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ')';

        -- その他
        ELSE
            vCOLUMN := TABLE_REC.COLUMN_NAME;
        END IF;

        -- 区切り文字の設定
        IF (vCNT > 0) THEN
            DBMS_OUTPUT.PUT(cSTR_COLUMN_DELIM);
        END IF;

        -- カラム追加
        DBMS_OUTPUT.PUT(vCOLUMN || cSTR_NEWLINE);

        vCNT := vCNT + 1;

    END LOOP;
    
    -- FROM
    DBMS_OUTPUT.PUT_LINE('FROM ' || cOWNER || '.' || cTABLE);

    -- END
    DBMS_OUTPUT.PUT_LINE(cSTR_END);

**********************************************************************/
