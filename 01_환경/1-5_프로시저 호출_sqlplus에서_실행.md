-- Data Grip에서 실행이 안되서 sqlplus에서 실행함.

```
[root@localhost ~]# su - oracle
마지막 로그인: 일  8월 27 16:36:17 KST 2023
[oracle@localhost ~]$ sqlplus

SQL*Plus: Release 11.2.0.2.0 Production on Sun Aug 27 16:56:11 2023

Copyright (c) 1982, 2011, Oracle.  All rights reserved.

Enter user-name: /as sysdba

Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> SET TIMING ON
SQL> SET SERVEROUTPUT ON
SQL> EXEC DEV.GENERATE_ORD_BASE(15000000, 10000);

15000000?? ???????.

PL/SQL procedure successfully completed.

Elapsed: 00:38:41.76

```