-- Charset MS932
-- SQL> SET LINESIZE 4000
-- SQL> SET TRIMSPOOL ON
-- SQL> SET SERVEROUTPUT ON
-- SQL> @SQLGenerator_Select_forExcel ${Owner} ${Table}

-- �������ʂ��^�u��؂�ŏo�͂���SELECT�����쐬����
DECLARE
    -- �Œ�l
    cOWNER VARCHAR2(30) := '&1'; -- �e�[�u�����L��
    cTABLE VARCHAR2(30) := '&2'; -- �e�[�u��

    cSTR_NEWLINE VARCHAR2(10) := CHR(13) || CHR(10); -- ���s����
    cSTR_END VARCHAR2(1) := '/'; -- END����

    cSTR_COLUMN_DELIM VARCHAR2(20) := ' || CHR(9) || '; -- �J������؂蕶����

    -- �ϐ�
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

        -- �f�[�^�^���̏���
        IF (TABLE_REC.DATA_TYPE = 'DATE') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ', ' || CHR(39) || 'YYYY/MM/DD' || CHR(39) || ')';
        ELSIF (TABLE_REC.DATA_TYPE = 'NUMBER') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ')';
        ELSE
            vCOLUMN := TABLE_REC.COLUMN_NAME;
        END IF;

        -- ��؂蕶���̐ݒ�
        IF (vCNT > 0) THEN
            vCOLUMN_SQL := vCOLUMN_SQL || cSTR_COLUMN_DELIM;
        END IF;
        
        -- �J�����ǉ�
        vCOLUMN_SQL := vCOLUMN_SQL || vCOLUMN || cSTR_NEWLINE;

        vCNT := vCNT + 1;

    END LOOP;

    -- SELECT��
    DBMS_OUTPUT.PUT('SELECT ' || cSTR_NEWLINE);
    DBMS_OUTPUT.PUT(vCOLUMN_SQL);

    -- FROM
    DBMS_OUTPUT.PUT_LINE('FROM ' || cOWNER || '.' || cTABLE);

    -- END
    DBMS_OUTPUT.PUT_LINE(cSTR_END);

END;
/

/*** �J����������������o�b�t�@�G���[�ɂȂ�ꍇ *******************

    vCNT := 0;

    DBMS_OUTPUT.PUT('SELECT ' || cSTR_NEWLINE);

    FOR TABLE_REC IN (
        SELECT COLUMN_NAME, DATA_TYPE
        FROM ALL_TAB_COLUMNS
        WHERE OWNER = cOWNER AND TABLE_NAME = cTABLE
        ORDER BY COLUMN_ID
    )
    LOOP
        -- �f�[�^�^���̏���
        -- DATE�^
        IF (TABLE_REC.DATA_TYPE = 'DATE') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ', ' || CHR(39) || 'YYYY/MM/DD' || CHR(39) || ')';

        -- NUMBER�^
        ELSIF (TABLE_REC.DATA_TYPE = 'NUMBER') THEN
            vCOLUMN := 'TO_CHAR(' || TABLE_REC.COLUMN_NAME || ')';

        -- ���̑�
        ELSE
            vCOLUMN := TABLE_REC.COLUMN_NAME;
        END IF;

        -- ��؂蕶���̐ݒ�
        IF (vCNT > 0) THEN
            DBMS_OUTPUT.PUT(cSTR_COLUMN_DELIM);
        END IF;

        -- �J�����ǉ�
        DBMS_OUTPUT.PUT(vCOLUMN || cSTR_NEWLINE);

        vCNT := vCNT + 1;

    END LOOP;
    
    -- FROM
    DBMS_OUTPUT.PUT_LINE('FROM ' || cOWNER || '.' || cTABLE);

    -- END
    DBMS_OUTPUT.PUT_LINE(cSTR_END);

**********************************************************************/
