-- Charset MS932
-- SQL> SET LINESIZE 4000
-- SQL> SET TRIMSPOOL ON
-- SQL> SET SERVEROUTPUT ON
-- SQL> @TableInfo_forExcel.sql ${Owner} ${Table}

-- �e�[�u���̏���\�v�Z�\�t�g�p�ɏo�͂���
DECLARE
    -- �萔(�e�[�u�����)
    cOWNER VARCHAR2(30) := '&1'; -- �e�[�u�����L��
    cTABLE VARCHAR2(30) := '&2'; -- �e�[�u��

    -- �萔(������)
    cSTR_COMMA VARCHAR2(1) := ',';
    cSTR_TAB VARCHAR2(1) := CHR(9);
    cSTR_QUOT VARCHAR2(1) := CHR(39);

    -- �萔(�f�[�^�^)
    cFORMAT_DATE VARCHAR2(10) := 'YYYY/MM/DD';

    -- �s�ԍ��A��ԍ��͕\�v�Z�̌v�Z���ɕK�v�ł��B
    -- �������ʂ͂������œ\��t���Ă��������B

    -- �萔(�o�͍s)
    cSS_ROWINDEX_HEADER NUMBER(2) := 1; -- �w�b�_�[�s
    cSS_ROWINDEX_DATA_TYPE NUMBER(2) := 2; -- �f�[�^�^�s
    cSS_ROWINDEX_NULLABLE NUMBER(2) := 3; -- NULL�s
    cSS_ROWINDEX_VIRTUAL_COLUMN NUMBER(2) := 4; -- ���z��s
    cSS_ROWINDEX_DATA NUMBER(2) := 5; -- �f�[�^�J�n�s�ԍ�

    -- �萔(�o�͗�)
    cSS_IS_TITLE BOOLEAN := TRUE; -- �^�C�g����ԍ�

    -- �ϐ�
    vCOL_CNT NUMBER(3);
    vCOMMA VARCHAR2(1);
    vTAB VARCHAR2(1);

    vDATA_TYPE VARCHAR2(100);
    vNULLABLE VARCHAR2(100);
    vVIRTUAL_COLUMN VARCHAR2(100);
    vINSERT_VALUE VARCHAR2(100);

    vSS_COL_INDEX_NUM NUMBER(4);
    vSS_COL_INDEX_ABC VARCHAR2(3);

    vSS_COL_INDEX_START NUMBER(2); -- �o�͊J�n��ԍ�


    -- �ϐ�(�o��)
    vPUTLINE_HEADER VARCHAR2(4000);
    vPUTLINE_DATA_TYPE VARCHAR2(4000);
    vPUTLINE_NULLABLE VARCHAR2(4000);
    vPUTLINE_VIRTUAL_COLUMN VARCHAR2(4000);
    vPUTLINE_INSERT1 VARCHAR2(4000);
    vPUTLINE_INSERT2 VARCHAR2(4000);

BEGIN

    vCOL_CNT := 0;
    vCOMMA := '';
    vTAB := '';
    IF (cSS_IS_TITLE = TRUE) THEN
        vPUTLINE_HEADER := '�J������' || cSTR_TAB;
        vPUTLINE_DATA_TYPE := '�f�[�^�^' || cSTR_TAB;
        vPUTLINE_NULLABLE := 'NOT NULL' || cSTR_TAB;
        vPUTLINE_VIRTUAL_COLUMN := '���z��' || cSTR_TAB;
        vSS_COL_INDEX_START := 2;
    ELSE
        vPUTLINE_HEADER := '';
        vPUTLINE_DATA_TYPE := '';
        vPUTLINE_NULLABLE := '';
        vPUTLINE_VIRTUAL_COLUMN := '';
        vSS_COL_INDEX_START := 1;
    END IF;
    vPUTLINE_INSERT1 := 'INSERT INTO ' || cOWNER || '.' || cTABLE || ' (';
    vPUTLINE_INSERT2 := 'VALUES (';
    
    FOR TABLE_REC IN (
        SELECT COLUMN_NAME
             , DATA_TYPE
             , DATA_LENGTH
             , DATA_PRECISION
             , DATA_SCALE
             , CHAR_LENGTH
             , NULLABLE
             , VIRTUAL_COLUMN
        FROM ALL_TAB_COLS
        WHERE OWNER = cOWNER AND TABLE_NAME = cTABLE
        ORDER BY COLUMN_ID
    )
    LOOP

        -- �\�v�Z�̗�ݒ�
        vSS_COL_INDEX_NUM := vCOL_CNT + vSS_COL_INDEX_START - 1;
        vSS_COL_INDEX_ABC := '';
        -- 3���
        IF (vSS_COL_INDEX_NUM >= 702) THEN            
            vSS_COL_INDEX_ABC := vSS_COL_INDEX_ABC || CHR(65 + MOD(TRUNC((vSS_COL_INDEX_NUM - 702) / 676, 0), 26));
        END IF;

        -- 2���
        IF (vSS_COL_INDEX_NUM >= 26) THEN
            vSS_COL_INDEX_ABC := vSS_COL_INDEX_ABC || CHR(65 + MOD(TRUNC((vSS_COL_INDEX_NUM - 26) / 26, 0), 26));
        END IF;

        -- 1���
        vSS_COL_INDEX_ABC := vSS_COL_INDEX_ABC || CHR(65 + MOD(vSS_COL_INDEX_NUM, 26));
        
        -- VALUE�����̃Z���Q��
        vINSERT_VALUE := cSTR_QUOT || '"&' || vSS_COL_INDEX_ABC || cSS_ROWINDEX_DATA || '&"' || cSTR_QUOT;

        -- �f�[�^�^���̏���
        -- �����^
        IF (       TABLE_REC.DATA_TYPE = 'CHAR'
                OR TABLE_REC.DATA_TYPE = 'VARCHAR2'
                OR TABLE_REC.DATA_TYPE = 'NCHAR'
                OR TABLE_REC.DATA_TYPE = 'NVARCHAR2') THEN
            vDATA_TYPE := TABLE_REC.DATA_TYPE || '(' || TABLE_REC.CHAR_LENGTH || ')';

        -- ���l�^
        ELSIF (TABLE_REC.DATA_TYPE = 'NUMBER') THEN
            vDATA_TYPE := TABLE_REC.DATA_TYPE || '(' || TABLE_REC.DATA_PRECISION || ',' || TABLE_REC.DATA_SCALE || ')';

        -- ���t�^
        ELSIF (TABLE_REC.DATA_TYPE = 'DATE') THEN
            vDATA_TYPE := TABLE_REC.DATA_TYPE || '(' || TABLE_REC.DATA_LENGTH || ')';
            vINSERT_VALUE := 'TO_DATE(' || cSTR_QUOT || vSS_COL_INDEX_ABC || cSS_ROWINDEX_DATA || '&"' || cSTR_QUOT || ', ' || cSTR_QUOT || cFORMAT_DATE || cSTR_QUOT || ')';

        -- ���̑�
        ELSE
            vDATA_TYPE := TABLE_REC.DATA_TYPE || '(' || TABLE_REC.DATA_LENGTH || ')';

        END IF;

        -- NOT NULL����
        IF (TABLE_REC.NULLABLE = 'N') THEN
            vNULLABLE := '��';
        ELSE
            vNULLABLE := '';
        END IF;

        -- ���z��
        IF (TABLE_REC.VIRTUAL_COLUMN = 'YES') THEN
            vVIRTUAL_COLUMN := '��';
        ELSE
            vVIRTUAL_COLUMN := '';
        END IF;

        -- �o�͕���
        -- ��؂蕶���ݒ�
        IF (vCOL_CNT > 0) THEN
            vCOMMA := cSTR_COMMA;
            vTAB := cSTR_TAB;
        END IF;

        vPUTLINE_HEADER := vPUTLINE_HEADER || vTAB || TABLE_REC.COLUMN_NAME;
        vPUTLINE_DATA_TYPE := vPUTLINE_DATA_TYPE || vTAB || vDATA_TYPE;
        vPUTLINE_NULLABLE := vPUTLINE_NULLABLE || vTAB || vNULLABLE;
        vPUTLINE_VIRTUAL_COLUMN := vPUTLINE_VIRTUAL_COLUMN || vTAB || vVIRTUAL_COLUMN;

        -- ���z���INSERT���Ȃ�
        IF (TABLE_REC.VIRTUAL_COLUMN = 'NO') THEN
            vPUTLINE_INSERT1 := vPUTLINE_INSERT1 || vCOMMA || '"&' || vSS_COL_INDEX_ABC || '$' || cSS_ROWINDEX_HEADER || '&"';
            vPUTLINE_INSERT2 := vPUTLINE_INSERT2 || vCOMMA || vINSERT_VALUE;
        END IF;

        vCOL_CNT := vCOL_CNT + 1;

    END LOOP;

    vPUTLINE_INSERT1 := vPUTLINE_INSERT1 || ')';
    vPUTLINE_INSERT2 := vPUTLINE_INSERT2 || ');';

    -- �J������
    DBMS_OUTPUT.PUT_LINE(vPUTLINE_HEADER);
    -- �f�[�^�^
    DBMS_OUTPUT.PUT_LINE(vPUTLINE_DATA_TYPE);
    -- NOT NULL����
    DBMS_OUTPUT.PUT_LINE(vPUTLINE_NULLABLE);
    -- ���z��
    DBMS_OUTPUT.PUT_LINE(vPUTLINE_VIRTUAL_COLUMN);

    -- INSERT��
    DBMS_OUTPUT.PUT_LINE('="' || vPUTLINE_INSERT1 || ' ' || vPUTLINE_INSERT2 || '"');

END;
/