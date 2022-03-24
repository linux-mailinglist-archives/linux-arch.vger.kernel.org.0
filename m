Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73F84E6B2B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Mar 2022 00:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355759AbiCXXVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Mar 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355776AbiCXXVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Mar 2022 19:21:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80425DE60;
        Thu, 24 Mar 2022 16:19:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OJKMLs031408;
        Thu, 24 Mar 2022 23:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ubzSkwryaBB17og9dGXnQdBLHQ7Yh0jTkim6vcHYijQ=;
 b=Yxe2v0q5sfH1kLV5Ru1LrpgmQAZao/HAIuFMcGlZPu8XOHau26UY691bZzT4hAc9A0Ee
 IKLIzGXnYb5KiKyP3s8uUY1nLRf0bH3dFAGi4MGtGYGOBWDGtJ2Ddjn3nmGWVxoaO2sR
 gCDp/iXIk49eySZcKXRFhgrx5XPFAw84Vrfte7VSAmFHQ56lrQz5HNshe79YgajOPESC
 72JcSbsbf09L4TcjkeIh6liuLCPm0KhWmJYaAB9lTqcBdQCBagulME0+3eTXaIYbCoTa
 4MtzC7hj5xYF36xaZqTbyI18zZQ8UMXP63eSSdQrzDm7h2jeib/MYfUFXs5D0PgJNx/o tA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qte5k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 23:19:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ONCk1t186692;
        Thu, 24 Mar 2022 23:19:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3ew57920as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 23:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na8qNrVjJR5LeVxozAy8Dt1wP7CnH1dh4kLLorAfiNAy5yIzUMfgtur44zD7LbWFws8QQ9S+PvcuhmGxWyo1H6AffZMrjg04OVwbtu31q6nMSkqiF71BYmQ4qG0ZGBBcMN9Q/ivOJIC0MNe/uAYVKoplpyyOIIoYdmLIPSIADheqV0ShFAlYncpuQmQPlgAVzixxppyqJ84YRYWrxVD3hForpaF67ECjPbPw1qmvTkJinubkty/ThFR8FZhtdhkFcJtj7/uFP15vyHPTastZAZfxyuArRw7W9YRsFKjeboA6iiKVeo5CQdhqAGJjpBxX+foVuHZyq7hbCVIgMg9OGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubzSkwryaBB17og9dGXnQdBLHQ7Yh0jTkim6vcHYijQ=;
 b=afnGCxnVK6wcdovsTjaktL1TqMD8X1KYbbNqQp69u1naRKlI+ozpy06v8SLUXOBDYPJH/qKBN5QoyEr7QBTVKi3vwTxt6g6lLMkN16unFNk+BbTixYz/5Q+mOfy034UJXIcDfzbNLfe4ZIWz/8ToqDV7J3czdetf6yeTWsUOF+Lj/MLtm5UnP5cljK34J7tJ6NElCYb+/CWy6ahR/WfIe7rM6XrbdVHFj9DFKY2JjHEi00QOU1qS7t0pYCU4TRUHz6zsTev3WA42ffPSUrcb5jxO8iIW+r1SKkI6X3GzBsKH3a2N08nqZq0VFKM3xMrm5Ti3ZGYjq1iESjxVKRPlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubzSkwryaBB17og9dGXnQdBLHQ7Yh0jTkim6vcHYijQ=;
 b=Pa6ov4pXh+F8LkEUZcS8dHM1PY5f1kNSQo31P6Rav6LiGaZMBWsURHBMFgX5snp4b1NJ+mOEpM400QvwROLyXM/JWonJAfx+fEKtSafah0cdPXh1QQLrlbrP9a1zM+TGFiokg1d7ssf/SCyzhPnqTakztRcA6O3TvE8mV882ggk=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 23:19:07 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6530:9b91:af1f:6225]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6530:9b91:af1f:6225%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 23:19:07 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH 0/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK
Date:   Thu, 24 Mar 2022 16:18:58 -0700
Message-Id: <20220324231859.1287918-1-libo.chen@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d18708-cd80-451f-2b2e-08da0decb1a6
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54398D500446B43ACC12002C85199@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXEoRc2v4D9zDgZCe5Oc6uq79uMnrRpUyqsMLaAjaIuIzx91Og8Xa4NO0OVzuEldPHTYgfQSg6CR37v1t1R01/rWubLk55BUxFDPTMcp0zMxUBmlA7/moRKUTREYvLzfcl3LA8pMGzS168XtmfJqEX7mo10ZdAvERMVffsCetlZjItohnSEwt/68i8yKV9HqQbRufCiz7LwkbJlD7VVX262Q3bGGCiVq/nWc00KSdixEaekywY/BwIcrSrHqhfMjREKULcFPA15gnebkR4/jHAEzPwam9V/Z3610+pDUNQOD6hjmhBTDZ9etdbKEFxVDDwuJGkdF5RBuxhXteGED6wmRKxkQ7x7fGSecdDsNPEBz9IFalooBM8kE+PyrxYv5sg5PrsytmrEAkP9lTbfTP1XTvnWMaUaLwqYfiyBem/hXSYDtFxcPjtJuDoZftmla3LVNd4v8vz2v2j9RytRyMMeJ4Px5DgvKFv8OaybYs9zLcnB4MkqkOzPLP3B0TPnRdj2frJju/emH3PLk32niNn4u5j2wrovICjMzrSziEl+OnrlVOkgj2CyYWVQS8s0iyTzsQ604YsfkjD3Y0+IBFfm8LhhnqRkKCkP7slire61YPcKIi3YdxJsdJe0uQBU4YVc0B6TIMsCoX1lzLvOeK1F782GKuGGXGqJaW/Z16c6WVqXgznBdqPh8ZRx4sCgdBd792quD6CAO0TFZURRl/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38350700002)(6506007)(6666004)(6512007)(38100700002)(52116002)(36756003)(83380400001)(2616005)(186003)(1076003)(2906002)(86362001)(26005)(66476007)(66556008)(8936002)(44832011)(5660300002)(4326008)(8676002)(66946007)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYCP5KLNr48EQBj/JA75kvkyzWty8BXbUHqxp0xsUU8Cf/j21Iguc65Ils6f?=
 =?us-ascii?Q?1xwVPM9yZ3o+o4gMy4njQIk8yB7baGmOaW+YeRbHyFshnQht21Vnaux1R6Vl?=
 =?us-ascii?Q?8Xc84i4Uno5f9U4NgDsmyjYd8JKgmFkRSWvkQgLxPNMj9xYBaiFVzE2kg5xs?=
 =?us-ascii?Q?7albSmFpY4qhD+ARxEB6xeI11u+fz0EsCLZFthzaI7baqSGCJFB31bXgk8fG?=
 =?us-ascii?Q?pKWzCF8qSofkyAa6xaP3YhQjcqeNZx5kgiQcWfHYlxEzjgxjt2w39cvWNvFk?=
 =?us-ascii?Q?woriVtfNhclBMw3R026bmfbB6miYbw+Jb9EspyvaHbiyronxLPIwqisUSzMM?=
 =?us-ascii?Q?hJtQdEV2ld89h2xmWIS0WU6JpEUVirl0EUvaLn46rfRZodBnC+ZcWAHFO45c?=
 =?us-ascii?Q?WTO6D4IEGpwovHn1VbQ9DFAPqTm0ppgiecG5H4Blgq5fHIlGgzt2NIP0WuhD?=
 =?us-ascii?Q?Hb0495tqFN0X4vPJtofnJWJEBhUvNkR9riYJqeDyaBGDFJULMa/EJRp3EGlI?=
 =?us-ascii?Q?mAeiUM0i66bhr9TvE41GMzgXEUGcRD/rl9QYVkDEAR1PULgDcUtnZR+vJ1eJ?=
 =?us-ascii?Q?MoNse0xXySAqjmqFMQxox31Kj6uAAEG1fJXR1kIyooCYBNS7vAvjSJW4a8Cp?=
 =?us-ascii?Q?2U9dUzcxaS1k8/k4DWRdtbN0qw6742GhHTjJoFIcA32olaItRjYd7qUbBHAt?=
 =?us-ascii?Q?uxBytfNd0/Dfs/pBshoqJvWibDqKLX0IO4w1HNOICC4OOPJrSOgi4bZRuIVM?=
 =?us-ascii?Q?X1xo8y02lW/VDxuER7wfqWMTdu27yQukkYZQHMWAee3zHVzhwh1sEJVXy6PU?=
 =?us-ascii?Q?pybfiuUz/ECGS1+7PbRy+lcAlk8pjlXjlWBdzKIl2ExGkLdmrAFGipNPp79O?=
 =?us-ascii?Q?S5ZKL9z9rscptKpRKvTgWYe/FNkahV7y300wXeeaJ7cY0UuVZa3r+To6b/Uv?=
 =?us-ascii?Q?QT4NScQGAfgSv6zPAsjV4nUmUGKEzsNx0Yxg6SM9ZsZkA7Po4YhA8pYX6CFL?=
 =?us-ascii?Q?DnzC7KmR7zqd+juebllKhmnQa5Zuv+aKmkF8r4y0YTjbZabxjc0oV3GN3Pp0?=
 =?us-ascii?Q?3apiU82Z2zaFaqhC1Od2c4DjBrAgETl4dvsmXRAxcfBEZmGZJxJdvV3Z6ilA?=
 =?us-ascii?Q?qfnJj5Wub5ukb0XmWUHjCIDIki/U/fv5ssi7zS90RpMKwux1xSQ+ACgbQAfd?=
 =?us-ascii?Q?/Ag3MgEBRcTVRNg0VApHDpxA5gehYqihhuQnfYsXbTBUeXIFp6qKd7/Gt+A5?=
 =?us-ascii?Q?5BqsuJejYBSTDP3s6+E3il0MkjOiMYg9rVGhcO5Vg7ruwUyuQCFJGKhCYdl1?=
 =?us-ascii?Q?P1MlKEEVNHwsTcSe5y+c9kWxKDOUrCqFv/9UBwZG99J+C131U024ttXfYC9V?=
 =?us-ascii?Q?f8LtFwexr086ulD/uY8sNloiqL764HngXS/454gWJqt5/NtLZB6k07aBd92v?=
 =?us-ascii?Q?X8qyC7KAxfKzoeM6bYYuRKF9vwQKIcgy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d18708-cd80-451f-2b2e-08da0decb1a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 23:19:07.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph/sw9kNWU44mFJdlOEDW0veTcMkJ//BmpVDeYpqq2fJkPxylGcYIsN5U+fAaszYrOpVvilBFrITxAXF1+j8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=928 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240123
X-Proofpoint-GUID: Xb_QoYzUSsw-gfTYv0y5QgsQ_0gfWmM4
X-Proofpoint-ORIG-GUID: Xb_QoYzUSsw-gfTYv0y5QgsQ_0gfWmM4
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

Libo Chen (1):
  lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK

 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.27.0

