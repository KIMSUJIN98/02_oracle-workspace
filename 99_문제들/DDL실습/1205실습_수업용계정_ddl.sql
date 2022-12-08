CREATE TABLE TB_VOTE(
    CONNECT_ROOT CHAR(3) CHECK(CONNECT_ROOT IN ('WEB', 'APP')),
    FAN_ID VARCHAR2(20),
    FAN_PWD VARCHAR2(20) CONSTRAINT FANPWD_NN NOT NULL,
    PLAYER_POSI VARCHAR2(20) CONSTRAINT POSITION_CHECK_OR_NN CHECK(PLAYER_POSI IN ('����', 'Ÿ��', '����')) NOT NULL,
    PLAYER_NAME VARCHAR2(20) CONSTRAINT NAME_CHECK_OR_NN CHECK(PLAYER_NAME IN('������', '�豤��', '�߽ż�', '������', '������')) NOT NULL,
    EVENT_PDT NUMBER CONSTRAINT ALREADY_SOLDDOUT UNIQUE,
    EVENT_PHONE VARCHAR2(13),
    VOTE_DATE DATE CONSTRAINT DATE_NN NOT NULL,
    CONSTRAINT DUPLICATE_ERROR PRIMARY KEY(CONNECT_ROOT, FAN_ID)
);

SELECT * FROM TB_VOTE;

INSERT INTO TB_VOTE
VALUES('WEB', 'qwer9402', 'abc123', '����', '������', 1, '010-5049-9858', SYSDATE);

INSERT INTO TB_VOTE
VALUES('APP', 'qwer9402', 'abc123', '����', '������', 1, '010-5049-9858', SYSDATE);
-- ORA-00001: unique constraint (DDL.ALREADY_SOLDDOUT) violated : �̹� ������ ��ǰ

INSERT INTO TB_VOTE
VALUES('WEB', 'qwer9402', 'abc123', '����', '������', 1, '010-5049-9858', SYSDATE);
-- ORA-00001: unique constraint (DDL.DUPLICATE_ERROR) violated : ������� ���̵� �Ѵ� �̹� ����

INSERT INTO TB_VOTE
VALUES('APP', 'qwer9402', 'abc123', '����', '������', 3, '010-5049-9858', SYSDATE);

INSERT INTO TB_VOTE
VALUES('APP', 'ksj9858', 'abc123', '����', '������', null, null, SYSDATE);

INSERT INTO TB_VOTE
VALUES('WEB', 'kkk5462', '1q2w3e4r!', 'Ÿ��', '������', 2, '010-4657-8964', '22/12/04');

INSERT INTO TB_VOTE
VALUES('WOB', 'kkk5462', '1q2w3e4r!', 'Ÿ��', '������', 2, '010-4657-8964', '22/12/04');
-- ORA-02290: check constraint (DDL.SYS_C007112) violated : �߸��� ������ ��

INSERT INTO TB_VOTE
VALUES('WEB', 'sj2785', '1q2w3e4r!', '����', '�豤��', 2, '010-4657-8964', '22/12/04');
-- ORA-00001: unique constraint (DDL.ALREADY_SOLDDOUT) violated : �̹� ������ ��ǰ

INSERT INTO TB_VOTE
VALUES('WEB', 'sj2785', '1q2w3e4r!', '����', '�豤��', 5, '010-4657-8964', '22/12/04');
