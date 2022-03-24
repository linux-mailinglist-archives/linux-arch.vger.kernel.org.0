Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E168A4E6B2F
	for <lists+linux-arch@lfdr.de>; Fri, 25 Mar 2022 00:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiCXXVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Mar 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353127AbiCXXVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Mar 2022 19:21:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F725521D;
        Thu, 24 Mar 2022 16:19:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OJEFA0010798;
        Thu, 24 Mar 2022 23:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Y6qzjfd1jXNtwC/Gtts9PBfVnly3kKV+IIjdQ0u7DRA=;
 b=eoQP/A2cbNKMMKgjCjzbcKMvIiBVOloKwNM81vINDIwCoSx7ttcOTr/PnVoSj7Q7EUw5
 xF5uD+ZWCQWBLAeOHpj+ghw3tP+X0oxhIBUZ4EpjD0PqurodHohsYEcj+Dfzy/zpvgTT
 9moO7fNhMzYvOgzMqNblD9ZnmpS2/fckNMyLZRY6xzGX3Zjf6Tm9suF89j2zXJYtkH6u
 GTf1CQ/m0wYzhIt2uhAgRWCYHvoMEmRXmaUBnPvUO3nhVWddi1ne6pVNwn4UUQAcGowi
 MfjnyqViVC25GNyWEWByVHMDImlHPabQ6BwGvP13Bjn4ivfoiyCSPWsTUbVgYtnwUT0e Vw== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ssdxp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 23:19:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ONCk1u186692;
        Thu, 24 Mar 2022 23:19:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3ew57920as-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 23:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4W2o5TvEjv6Fkp3SCQAfvwpzphA45nbpbS8PyuRY/fRwAd4KWXqniCDidYvCzRjDa+Y1BqmPbPxUT+WzJvUGF4BTJ3TRUX1SpAWE6MYgC5qJfwMOF468bQ8aZKbhv5RX802EcL6fJHkkQCCNQeej/Vb0KSLraUFFLPFnl8KWEhcyvGOg/hY1tSgwG7S3R/yQzIGLFLr6UmHN7pIh1nDXsmktuv92TRl3HAhSZIo0nP3Buk7xnsoFCAuLyRI2XLU9XPegsXOKdisJprOL0fpK2UFeowe8eZ8lBXh32zQwdGMKI60rnrvi5644crVB6iHkTFpQGp49iOEb0HhDB15NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6qzjfd1jXNtwC/Gtts9PBfVnly3kKV+IIjdQ0u7DRA=;
 b=d6/MV7u8KcBficmCbtvQBiM3M7HKan223znbj1Y3Chfmr//l1b55kZxUGelakcwr8wWWGDhNXpYcBKqxc0kutFx3jUDO9op6LPtJvbamYD4f3zcUnkb6AWDrlZmYD04On5z50N63WCCYM3P35NNdTYdop5w/Fl6FMSdxXix3JJJuNLViaiG8k6oRafFjZvn3WlwVQaLNmEsOmt0YrIbDJV6Qjv5tIJ05mv4nCrtCnZ2HOc+jMVWJpfPXaGrSh/YTSOlT9ZNu+9KO9TC5Hyq/+JYaE7lDbjqCpnA3N1eDjQgiyBbvKN1GljpQb5aBSh/8iA9t8MJcqP8mAny51lm1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6qzjfd1jXNtwC/Gtts9PBfVnly3kKV+IIjdQ0u7DRA=;
 b=rc40LA0wrLeLIuoVqfdewiX57LRmghpvuENcD9TgmLB7TqLB9u9UUVE3OQMrTn5VCKA6rn2mDTNLyU241/yxvT1PD6KdIF4De4oEyMCCfOmRbRgQGLK+Jpt2dBnJh6OHc/7IGZUSMMpZ5339STWm/YiCouf7z77+dD2B3DRl2Is=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 23:19:08 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6530:9b91:af1f:6225]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::6530:9b91:af1f:6225%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 23:19:08 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH] lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK
Date:   Thu, 24 Mar 2022 16:18:59 -0700
Message-Id: <20220324231859.1287918-2-libo.chen@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220324231859.1287918-1-libo.chen@oracle.com>
References: <20220324231859.1287918-1-libo.chen@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89a22866-d823-4815-07bf-08da0decb24d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5439527C3B890958AFD1F5BD85199@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8P9REJ/afb5kKJaTuKsZ5uUP1rWBLi87ZbIr5JZo2CG1yNnY2uCLfKMR4Pc5+iuXoYRqKXZMTwi/mDyoMlDdChKgaYd5NhZzcWp49yoIDPEyqr6g+aWF/AxHSiQ6Kbrb9qcCQWUrqCAe6/TTp1Ma9K9qPHeLddGCaPmUpFYKncfIXu1WcCIWD8t7/ENvQemAQCuXzhX8NZ/uaU1ecopQCEhap2Pa1dfHx/mrwDW6UlQ2dwVJiWWbEywLB2rD1WrYr8Q6zC5nF6SpxfklDmgWVEj/+gGjLhlGSU/8nuU+uWRkVjpBbtxJTcNJEp9j3SntTIe/OG0z+JLdyM39oCvmwT1Q9OKAS57OgPu+8FMkYfU5KJPd8YHd+Y7+UiHGbM2eIwq4mZTFx1xcVKqRd40Lf8vy9+sBKoow6GNYBjWlUQR29YJ3yploVVqp4KOd8pYkd1ht5OcmqnddpBb5FPpsLVZ/Jk9BGcT1Jm1H2Mfc/+txkXARApLCRjuewk9wXPuK7uOiYvOwunZ/Ooto4C25OX1uWQoKdWFi/QAIUhLkdFyMnBpfp1uZuSN49b69pPkorrlc0vgCpQho4Bk58u/IcMIionq/5O6PGsCXjpIMQj92fJypEGO55n35ijFlJPbvcrKmCWnBIHTLteM08hgWaF0G1q6OEohhFowDtG/u3gMFks40pUStRO/8NHZ7t6cZct2MDR6V9YHKSRmZL6hFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38350700002)(6506007)(6666004)(6512007)(38100700002)(52116002)(36756003)(83380400001)(2616005)(186003)(1076003)(2906002)(86362001)(26005)(66476007)(66556008)(8936002)(44832011)(5660300002)(4326008)(8676002)(66946007)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8bQeBR1yyylt4sqegF1txhl9jUCLJzuaVVsTjbPmDMaDfVJSr2BWio3ETDG?=
 =?us-ascii?Q?YYRX5AO1S5HYNpz+4GSnPzuSZP1rZR9wVboJ7rMFknHNmRVHnkWFZrsR8dnY?=
 =?us-ascii?Q?sTsGafVSPj0mvZtodPBJUKaFhWsSr1jrAp2jep+8HxOfXFOXTNdzGJIWMWBY?=
 =?us-ascii?Q?37KDfDQLnxI/qDgm2y8jj3+jBuqsJf3Q38SrWw7dTVeEETsfoL52P3b5Gg5N?=
 =?us-ascii?Q?RGpPMqFN0Kw4vi6LJI1wKaruFk6Y9oyv1GQwBIS0l0t+Oh35tA3OUMoKrVW4?=
 =?us-ascii?Q?JPvop3S6Czj+bwQzet9V7+RF/ZcnYRgEKp84LujhBZRmVFH7GVOE5/Sixqqn?=
 =?us-ascii?Q?48X+3Fws6o/vsG8FpzrXdKkBprCzxfrbwynV0JUSoKWelkVw9wLlpB/ud1Nl?=
 =?us-ascii?Q?Ssq8FMv6GHWEHacJwunMeQjuZtThJJ5lMzZCirShNTrDtuTXvQo4XYEguAnp?=
 =?us-ascii?Q?whX1+0CsRr2l4U8a0c1NBWhDMHie5FEMr7SsDw5xdHqgd0boj3CI6US13y3T?=
 =?us-ascii?Q?VvAm/NDx9Ojl8ESzaTCbEM4nnk8V4vbgUXk03bhYp2IUMwBDLsSt4xcJJfkh?=
 =?us-ascii?Q?ApWDthMPJraqH5Y/9cyBoTSGdGLXSkoKnXf4oC806eC+3jHazvpW2HOA/yGi?=
 =?us-ascii?Q?oxbVZoc0BHhy5CaeG5avgO9wqJB6BYAhxaf6l/uaNXuL9pwWqDrcxIqLEaFv?=
 =?us-ascii?Q?Whxo/ezVTaWTfg/ae4HM3bzcG9lDKsyYAGUYAp35jDOrxwCG0coZ1/lql9Em?=
 =?us-ascii?Q?BzX/BgjJh5nr/zszJmtaYXp7J4wMQUP/CqISPrV5mSgRtn9fAjIdAszLY5jT?=
 =?us-ascii?Q?He/FWE7v9yaKWdAA5mtat98sOQ5VjvvYxmEm94DvRgMsCqzFa6YoqO7rfoe2?=
 =?us-ascii?Q?DMsLVq9zftc0/8XfVa19sYP5Llzjv5QjbigQ9Os+vSaHFL9gFw4mJa5MlScs?=
 =?us-ascii?Q?HqjOEoKPtrNzgSEcJIY5eAad06x2Lrra7cga8r7FIfQ67PqY5i6lCN09Im7x?=
 =?us-ascii?Q?NwMkN6D7lDSZDRKq8Pz3iBaVOGWip7bKOBiUh9dE2be3hUKhov/kzoNBZfYU?=
 =?us-ascii?Q?Q6/FWujXteGiQ72jjcV0iTpqhQpnotggeTrFMe1tLM5+n43iLL5SmbPRo2iR?=
 =?us-ascii?Q?sjNahVl9VN0sdHnnj92tfEmEratx3HCjnMd3vQl/tDTS21UCplIsspNpY7AX?=
 =?us-ascii?Q?rwXCT/+ZT7EoGH7dWTmwEoTtd+ayRXsMZachYW1Purgn0HYMBJAe6/SKJbVm?=
 =?us-ascii?Q?jIJwxyj+KwpBRotdGi6rB8qooYexzx9eYSVR3+GqHfvEB0rHuer0Z1RW0v03?=
 =?us-ascii?Q?eoopphrHWiI+eqpP7QQ7+2C7yBvxUkAltUt07D26dCc+PHT0U1rUn9Y9zVbB?=
 =?us-ascii?Q?Lfym0h1yjHqmHaA8fq+g8cDgFWmDPvjV4W+YBcCx+j6LALM8+o++vm1ezug6?=
 =?us-ascii?Q?XjNU/7sO9OkGk07QeIb/2iQfqnL+udye?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a22866-d823-4815-07bf-08da0decb24d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 23:19:08.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzzW7/rtsNXw2e2r+BcFhIeRDYJc5/ugdtryLeIXem8VMChCgxU4eWl2QE7iFHT2czEeHu6DBu3q96ZNgO6J0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240123
X-Proofpoint-ORIG-GUID: nnr5XzACTeOVhkyYZM0qWPY1ews-7BFf
X-Proofpoint-GUID: nnr5XzACTeOVhkyYZM0qWPY1ews-7BFf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
make a lot of sense nowaday. Even the original patch dating back to 2008,
aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
rationale for such dependency.

Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
There is no reason other architectures cannot given the fact that they
have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
x86.

Signed-off-by: Libo Chen <libo.chen@oracle.com>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9b5a692ce00c..a017f5fe4e38 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -502,7 +502,7 @@ config CHECK_SIGNATURE
 	bool
 
 config CPUMASK_OFFSTACK
-	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
+	bool "Force CPU masks off stack"
 	help
 	  Use dynamic allocation for cpumask_var_t, instead of putting
 	  them on the stack.  This is a bit more expensive, but avoids
-- 
2.27.0

