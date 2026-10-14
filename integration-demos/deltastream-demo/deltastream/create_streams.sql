-- 1. Account
CREATE STREAM account_stream (
  "label" STRING,
  "accountId" BIGINT,
  "createTime" STRING,
  "isBlocked" BOOLEAN,
  "accoutType" STRING,
  "nickname" STRING,
  "phonenum" STRING,
  "email" STRING,
  "freqLoginType" STRING,
  "lastLoginTime" STRING,
  "accountLevel" STRING
) WITH (
  'topic' = 'kafka-Account',
  'value.format' = 'JSON'
);

-- 2. AccountRepayLoan
CREATE STREAM accountrepayloan_stream (
  "label" STRING,
  "accountrepayloanId" BIGINT,
  "accountId" BIGINT,
  "loanId" BIGINT,
  "amount" DOUBLE,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-AccountRepayLoan',
  'value.format' = 'JSON'
);

-- 3. AccountTransferAccount
CREATE STREAM accounttransferaccount_stream (
  "label" STRING,
  "accounttransferaccountId" BIGINT,
  "fromId" BIGINT,
  "toId" BIGINT,
  "amount" DOUBLE,
  "createTime" STRING,
  "orderNum" BIGINT,
  "comment" STRING,
  "payType" STRING,
  "goodsType" STRING
) WITH (
  'topic' = 'kafka-AccountTransferAccount',
  'value.format' = 'JSON'
);

-- 4. AccountWithdrawAccount
CREATE STREAM accountwithdrawaccount_stream (
  "label" STRING,
  "accountwithdrawaccountId" BIGINT,
  "fromId" BIGINT,
  "toId" BIGINT,
  "amount" DOUBLE,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-AccountWithdrawAccount',
  'value.format' = 'JSON'
);

-- 5. Company
CREATE STREAM company_stream (
  "label" STRING,
  "companyId" BIGINT,
  "companyName" STRING,
  "isBlocked" BOOLEAN,
  "createTime" STRING,
  "country" STRING,
  "city" STRING,
  "business" STRING,
  "description" STRING,
  "url" STRING
) WITH (
  'topic' = 'kafka-Company',
  'value.format' = 'JSON'
);

-- 6. CompanyApplyLoan
CREATE STREAM companyapplyloan_stream (
  "label" STRING,
  "companyapplyloanId" BIGINT,
  "companyId" BIGINT,
  "loanId" BIGINT,
  "createTime" STRING,
  "org" STRING
) WITH (
  'topic' = 'kafka-CompanyApplyLoan',
  'value.format' = 'JSON'
);

-- 7. CompanyGuaranteeCompany
CREATE STREAM companyguaranteecompany_stream (
  "label" STRING,
  "companyguaranteecompanyId" BIGINT,
  "fromId" BIGINT,
  "toId" BIGINT,
  "createTime" STRING,
  "relation" STRING
) WITH (
  'topic' = 'kafka-CompanyGuaranteeCompany',
  'value.format' = 'JSON'
);

-- 8. CompanyInvestCompany
CREATE STREAM companyinvestcompany_stream (
  "label" STRING,
  "companyinvestcompanyId" BIGINT,
  "investorId" BIGINT,
  "companyId" BIGINT,
  "ratio" DOUBLE,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-CompanyInvestCompany',
  'value.format' = 'JSON'
);

-- 9. CompanyOwnAccount
CREATE STREAM companyownaccount_stream (
  "label" STRING,
  "companyownaccountId" BIGINT,
  "companyId" BIGINT,
  "accountId" BIGINT,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-CompanyOwnAccount',
  'value.format' = 'JSON'
);

-- 10. Loan
CREATE STREAM loan_stream (
  "label" STRING,
  "loanId" BIGINT,
  "loanAmount" DOUBLE,
  "balance" DOUBLE,
  "createTime" STRING,
  "loanUsage" STRING,
  "interestRate" DOUBLE
) WITH (
  'topic' = 'kafka-Loan',
  'value.format' = 'JSON'
);

-- 11. LoanDepositAccount
CREATE STREAM loandepositaccount_stream (
  "label" STRING,
  "loandepositaccountId" BIGINT,
  "loanId" BIGINT,
  "accountId" BIGINT,
  "amount" DOUBLE,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-LoanDepositAccount',
  'value.format' = 'JSON'
);

-- 12. Medium
CREATE STREAM medium_stream (
  "label" STRING,
  "mediumId" BIGINT,
  "mediumType" STRING,
  "isBlocked" BOOLEAN,
  "createTime" STRING,
  "lastLoginTime" STRING,
  "riskLevel" STRING
) WITH (
  'topic' = 'kafka-Medium',
  'value.format' = 'JSON'
);

-- 13. MediumSignInAccount
CREATE STREAM mediumsigninaccount_stream (
  "label" STRING,
  "mediumsigninaccountId" BIGINT,
  "mediumId" BIGINT,
  "accountId" BIGINT,
  "createTime" STRING,
  "location" STRING
) WITH (
  'topic' = 'kafka-MediumSignInAccount',
  'value.format' = 'JSON'
);

-- 14. Person
CREATE STREAM person_stream (
  "label" STRING,
  "personId" BIGINT,
  "personName" STRING,
  "isBlocked" BOOLEAN,
  "createTime" STRING,
  "gender" STRING,
  "birthday" STRING,
  "country" STRING,
  "city" STRING
) WITH (
  'topic' = 'kafka-Person',
  'value.format' = 'JSON'
);

-- 15. PersonApplyLoan
CREATE STREAM personapplyloan_stream (
  "label" STRING,
  "personapplyloanId" BIGINT,
  "personId" BIGINT,
  "loanId" BIGINT,
  "createTime" STRING,
  "org" STRING
) WITH (
  'topic' = 'kafka-PersonApplyLoan',
  'value.format' = 'JSON'
);

-- 16. PersonGuaranteePerson
CREATE STREAM personguaranteeperson_stream (
  "label" STRING,
  "personguaranteepersonId" BIGINT,
  "fromId" BIGINT,
  "toId" BIGINT,
  "createTime" STRING,
  "relation" STRING
) WITH (
  'topic' = 'kafka-PersonGuaranteePerson',
  'value.format' = 'JSON'
);

-- 17. PersonInvestCompany
CREATE STREAM personinvestcompany_stream (
  "label" STRING,
  "personinvestcompanyId" BIGINT,
  "investorId" BIGINT,
  "companyId" BIGINT,
  "ratio" DOUBLE,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-PersonInvestCompany',
  'value.format' = 'JSON'
);

-- 18. PersonOwnAccount
CREATE STREAM personownaccount_stream (
  "label" STRING,
  "personownaccountId" BIGINT,
  "personId" BIGINT,
  "accountId" BIGINT,
  "createTime" STRING
) WITH (
  'topic' = 'kafka-PersonOwnAccount',
  'value.format' = 'JSON'
);

