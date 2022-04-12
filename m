Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203F4FEA6C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiDLXgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiDLXdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:33:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907988EB41;
        Tue, 12 Apr 2022 16:15:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CK1x2P028053;
        Tue, 12 Apr 2022 23:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KOiKhXdDo60N+VHX326PxK5gxYZRPFmJx+a4VbXz6ds=;
 b=ni2EM3r8NjHRg65PtyJneaPk0t8jpfTkDMiNYp5KFQAtZeQY4ZIydTzttBkeeqEP2hrY
 Jh1g2OPjj8iQZHMLMJAeF+jUPtbQJDEvoLjvV0hCjziIcIHL7sbEp/yJQlE7t87nqGVX
 KtmFTpzOYMfbiSI+ZLZgeOSK8UR6DCJy64X1gIauEG/KtGr46Rg3gG+4JtzR5ENP6IlA
 p2i2suA6jsJlEAY+0fphb2VctraDePrDvAxAV3TSfey6+ehrQa+ycdFOXph6a7x2E6Aa
 bdFD9MSyB5gaHFBbo2LvhQ+cI0A+Y8kieu6+TGSWi3qcQJ6y9dp6DYeMx7OVHcLGEsUZ uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a020f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 23:15:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CMpkqq033146;
        Tue, 12 Apr 2022 23:15:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k3js11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 23:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/J0PHlnjzP9g6ck8nz/EU4mkTq9X7xZO1P0h64runXYUk+BvJpHz+qjwH+RZl9qwggfBeR94iVayLeeQIQvqnMX64NT/rNaVdW47us81xhzX4Y04inCfKiGaK5HJxocMqUxiqUSypnw2UbUbD3GCKfsYVlHSS3A9+nz2pZxn8OCEqMFSyIJSSndEa8H+CKNIQyh/9qUoh1EIyLBQEpPuvp83f0PJJM0qAPYqEHfo8oGYaIbLyS8P4PBeA/EQpL/6+DUexbP/t5x64cEIliMa80nck4iPS3QOXiad+0BHUmffSmm1mMQfpb4h6LmqwVzlHZFbs1wJeEIpmqtXoEf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOiKhXdDo60N+VHX326PxK5gxYZRPFmJx+a4VbXz6ds=;
 b=dKYk5HE15lADZUzI9NXlQGQCr2BdLMWOlu8X8QOTlh/v8SHxBMxXbeyOzztFCk/rmmXwUF9udnPWzcHdY2RBygiW2aP+7WYtX6C4jFb00T85Fcu1Yp4KL6AP4APo3Q9UK276Y3RV19JzW3sK7Wjgz59DFxC2WRBlvbr1/IB1kLQpzVBxEN8+6XGHj/Ss9dIueZprvp3+oK2HAtHc9suym7Gm3kM2tI369r0+b/YuoIUagt5aPwsMOmcUdQObdqwNqaSaz8p7Nqe/pfPJLdPoy+YXOpKwEzrr5482846n1I4dhk/AGBf75Agci//lnNpbXvNIwwgh2qdMB9GBCyJ5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOiKhXdDo60N+VHX326PxK5gxYZRPFmJx+a4VbXz6ds=;
 b=N/l+ckr/kku+oA5vzveA53a9JsLQh3fieO2m1oOPul/Ii29Ol6GcFGLGyG/6Awj/CHZM9bIybL41pP2e8kTOLRM8x3bWqhaipv59qBKPVafROsx8k6AGqh2P4z4M0eUKtd0K8bPDMEsbxymCGdXoJ4KxqdGqV0JEUNkzUQg8e0E=
Received: from SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11)
 by BN8PR10MB3588.namprd10.prod.outlook.com (2603:10b6:408:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 23:15:17 +0000
Received: from SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287]) by SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287%2]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 23:15:17 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH RESEND 0/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK
Date:   Tue, 12 Apr 2022 16:15:07 -0700
Message-Id: <20220412231508.32629-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To SA2PR10MB4569.namprd10.prod.outlook.com
 (2603:10b6:806:111::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31cee91e-dd32-4d37-f3bd-08da1cda4e7d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3588EB2FBAADAAFCC258251885ED9@BN8PR10MB3588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8C4H05Z4VbOMUl7QHB0PHXoYIOBzyBuU2nOTGU90YP1v/xctVO6Bie827Orn3gxLFU7TYLiF5CPBRNXuYrezjnCnb3Yt8Mo0tv9hKY0ePTxzfNAb/WC16DdbznByX8DgRQnovk73KIqgbipx4hQZa9tASwcg1s+9xzznH7LpRHzGC83Ri1GNnGq/c19f1Moq6RtpNoMOCguw6Xqz3eGlAjo+zhlIGvxkZS3J+DCwlbpFGzugjFmk38VjPrPQt7b9UAPidCUUd8UfE0iFww7DW9XgjlfuhkOLY1CaM9tzwdDUuWkvviSBxkzwmrmNuUw0MZy1pofN312y2AbgYFwU0ID5avkUPJX00m8bpwb35FtUJCnnzN6lkr1NcvcLxsbAV2Eopm3ow8Vc6PM3IFh+OqfXexevlgltSpsZm1jM1obPhkRurGwZqBWTeA1JBnFCg3SXKOQvKNlCTk+l4pkzCspRCGk64b771EXemmzOsJ5rO8auKIan/HfQbswY6oFMe52yCKB5FfKx77+0t2ew32TRDgHnmZaq0Krr/+IE6ImsJiWuIad9WuhmFQAExB8qNKxVtSdKXWyrkP9/2SuTfVjUh/+mJapffQDHCsf2xSfq4xQtlCtPnwxHHgWMSxh+ccRyzu+7ovu5m0Axg44+crDsCW++F0LmGUcp+zIAOttudnQtfl2caoYoL7RUMmxinL6Egu+jGGVxDlQC+YOSxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4569.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(1076003)(36756003)(6512007)(316002)(44832011)(508600001)(186003)(38100700002)(38350700002)(26005)(83380400001)(2616005)(6506007)(8936002)(52116002)(4326008)(8676002)(66556008)(66476007)(66946007)(7416002)(5660300002)(6666004)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfDV4OGmyxHwiQ7fAa206QuoI5EO62SB0QUJ2xRZVPdIb1WSfz2IjbkgswZR?=
 =?us-ascii?Q?sProak+vIOC9sMIW2/AcpLw6x6E+4vA/mv5yo5Yn85d6/Cvwg9xtScYLFac/?=
 =?us-ascii?Q?OfiIUG9zDfjJpstCEfrh9xIlK8hrkHLZvoL6b+4xJcKf7HV9mvl8uBQWDcEd?=
 =?us-ascii?Q?TM46gjGx+zYj0kLM6fNQ8I11xbgEytJm/468mGnZ9neHTqcMpJtLfmbFjk4n?=
 =?us-ascii?Q?sOOqMoXw+cxLf6kKOQ4xerlMnNIZiPHiV0k4QXaUHUwPDFKADhrzJrpAbQEi?=
 =?us-ascii?Q?f/uxBwlpxVXJ/JM7pdTo/Ktspg4ZcqYvFtqYaz9xmUaumm+6BNe2sfyNSCxx?=
 =?us-ascii?Q?s0c2fJENluUDBiTqLmsL44QvCb/ZZWwLJvFiiGU4qbglLyMe1hln+eK/09dz?=
 =?us-ascii?Q?cRZmavz3GDCxomJM9rqfJ2UPZ0bopHrGx5ek2u2qj7LReEaUVwfckvyaQr47?=
 =?us-ascii?Q?ugdg07nvpAocelcw7zBWMCQo5JajkRjfw91bxt7xQsfkp4pfm7WTNYCYgPJr?=
 =?us-ascii?Q?oIGmNOO2aX7EwU3+8otm4MJxC3GnR6ryfycaT0YIdtTIhM9ADFkD6aou93oR?=
 =?us-ascii?Q?SJYGncx3YLPS8kl4m5JmKzoZvRnbrVl/oOb4Z360M6k8ZT924cr3Oxf/A2K4?=
 =?us-ascii?Q?xQQMo2GJBTi13D/K25sH9BEMqVO2BNDN62U1ncs00/kDoaS6RA+NoNYGR/Ml?=
 =?us-ascii?Q?l60aIpv2CVG3thUlsAYDUxNNpa2EMaZS3Cq+mT7+9XWQf80usRhfYDPtfaQV?=
 =?us-ascii?Q?vO1jZ/Qr1O3tL4sVPGn1X+r2OozlJgxVgE5XkTskK0bfiwKuv5HWrNBUvUyy?=
 =?us-ascii?Q?aM4cHMNNUA80BScpdtYVx0ubnAbCrlc2ZeUknH9Zv+iycHLHrW6l+NFEYzhY?=
 =?us-ascii?Q?MN0W93NJa5NCmskQaZGpqDCX7WMLRHf5wuaIW31LCke+btOdg4eAxTZi1yBp?=
 =?us-ascii?Q?gF0szrfucBWoLL6rrmqZaXphN1ZcyPoVLxoeayiPUlY9DYHNgwAfyPIWXgMH?=
 =?us-ascii?Q?1Xx+a8qN2ek0XHmsRdiRk/yzxdjSWVJ/JXO8SWNJRtfe9J+Hfpyjr5kp0e4n?=
 =?us-ascii?Q?+YmbWwgqR7YKWJBCpEWpCPEUYS4SOnWQGYo+Kpj0AxJaY4ZPU6B9ZesHEF4g?=
 =?us-ascii?Q?61gbyjj6x3LDjMbnvlOevWr2DhgxEnZKGXWxvifIV1mfdGMD8W8Cz9uUota6?=
 =?us-ascii?Q?61CMdQNQbekng21xIQL8ecdiigGDpT8h3JwyAgIoeMNH08cEvAf68dbMiGhO?=
 =?us-ascii?Q?vK4HP6WEmzV00ZgMPoKnCtoe1+f2ezbFB2k7Q9YFZTAoU3Lyygqu0OICv+BF?=
 =?us-ascii?Q?vQE/JEFBQen1VKIJLmP075S8pZXunXe0KKpt9uahiTh9wlAYnZrzYCaTBbs5?=
 =?us-ascii?Q?wPwmbu1esJ46q94ZeXFI2mAW+SDPc985A0GhUi3JemWZpZv+Fjoabnc8Ymfp?=
 =?us-ascii?Q?vAKoA0RkZQfUWp4O6laPG+dGGwVGHJxvfENixkYge7wGyi4GYdSWd2XdWhIO?=
 =?us-ascii?Q?nQP0lDdZYnIUPG/q6ENWZP/FUrE6+d0HpLJef/Xg0iRvz9CStHK8V0Y31i2i?=
 =?us-ascii?Q?jrfQsS5rxwOi5tp4+H41HrW+uRkA/kUlbSudl+lL68Q0MrF8TJEpj8vr0oxL?=
 =?us-ascii?Q?asLRLzU6jgqItKHFaqc6ubofIm8WpMzIXgqGFSIom1zjcwCBKmG8TbeloIYs?=
 =?us-ascii?Q?Xs3AazXnKykvBOojKq44Sp8VXTtHrISZzxzw3UC3jAQ+aOHqlVUzO5S0Buz0?=
 =?us-ascii?Q?9EQMdJwRJA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cee91e-dd32-4d37-f3bd-08da1cda4e7d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4569.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 23:15:17.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtygYuE4TFjrJJe3rYW71oTvkF9Ki8OK89VFWS9IrKGmRIJWZKzOOhIxukCgRK31TM8dLyrWzVlokFxeUOmoNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3588
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=981 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120103
X-Proofpoint-GUID: jVMKXL1QEvXyvFpkytaZo9TCVTDejuGr
X-Proofpoint-ORIG-GUID: jVMKXL1QEvXyvFpkytaZo9TCVTDejuGr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We encountered an issue related to NR_CPUMASK_BITS on ARM64. It turned
out CPUMASK_OFFSTACK was not enabled and NR_CPUS is set to 4096 in our
aarch64 config, so each cpumask operation is unnecessarily expensive
esp. on small VMs. There are decent number of cpumask operations in the
scheduler. Many of them are on the hot paths. The cumulative effect is
quite siginificant. With CONFIG_CPUMASK_OFFSTACKT set, we saw ~10% gain on
ApacheBench and a few percentage on redis in a 32-core ARM64 VM with 5.16
kernel.
One may argue why not just set NR_CPUS to smaller values, the thing is,
for example, we support VMs with flexible shapes. The customer can
specify the number of CPUs ranging from 1 to 160. You cannot just prepare
160 kernel images for each release with one for each shape. And kernel
with NR_CPUS=160 doesn't perform well on a 1-CPU VM. It's important that
we can set CPUMASK_OFFSTACK=y so that the kernel can dynamically allocate
cpumasks based on the actual number of CPUs in the system.

The problem I am trying to address in this patch is currently
CPUMASK_OFFSTACK depends on DEBUG_PER_CPU_MAPS except for x86 and it
doesn't even show up in kconfig menu as well as kconfig
without DEBUG_PER_CPU_MAPS=y. We should remove such outdated,
unnecessary dependency.

Of course, I am open to other ideas. And people who are more familar with
this matter can shed a light on why this dependency has been kept for so
long. My goal here is to determine if DEBUG_PER_CPU_MAPS is absoultely
necessary for CPUMASK_OFFSTACK.

RESEND:
- Correct the subject line of cover letter
- Send to more people, esp. gkh for more attention since no one seems to
  be responsible for this part of code

Libo Chen (1):
  lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK

 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.27.0

