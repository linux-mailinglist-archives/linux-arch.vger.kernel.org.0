Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906CC7D7811
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 00:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJYWg6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Oct 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYWg5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Oct 2023 18:36:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26897AC;
        Wed, 25 Oct 2023 15:36:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLNfSe019319;
        Wed, 25 Oct 2023 22:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=q4Q0EFRV+KTn2YAAU5CLKSRZlReky5dXzhiF6PTDZZ8=;
 b=RLAPhrBprtad4srqeHJjO7+/AwydLU8qLYiv0eq1of6UJWY7xoNzGWPio9t9o7EnLzwu
 v7UbevhHU8Nf2akar/mRgnQBBB6CLC+/PvUfInuj6rx2D5FD+f0WJ0vD6OIJlDyN/eTE
 iI46ozHo04wdLSBKEoXzYMalNdHKAh6DS0r3VSyiOUvHk6KnKowNdtFSi7j9Pv0rdxoz
 wrTvk7bLaeX8pEoDkzw+v666uHggHoDGmhTMhSisUQsj6IsKZbizqWbmktLZIe3Spf5Q
 xFhJVFR2cdRki7dAp2yINGEudncnpBPo4tweK7RIfPmjKi/Obug4KkIscVDmVNQ3xuWT 1w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68thfpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 22:36:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLeocm034561;
        Wed, 25 Oct 2023 22:36:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv537avd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 22:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZmzXDVO//rtlj4oi1VC+E/JPGuVctx6ag75bNtZcvd+RmfKYOgmwril6S50N81rSM8Zh1B6TRNRHDLSbZO1xMnvY+0R8Yqnw0F24tNaeFefpsp0zDUOvaAcPzvBsY7QKJAPsofTx3UcGH9WQKyiQwL/zlWQjaBqSRR2yoJWanRrlcY4iNQGG09xbAzuv1kJgA0Udxz6BdhY0P+wFYWKVdvl2380ga2IuHimvVMFZ+OUs3pCP7yFSUINyKfcCf96Ug7dGT4JBZgiZ0BvxeV8lklWrFfXWZTV9Yx21L3ME+VD235bKYTeTPwjzFfoOIOl7JoFvKhvhivg75KXnAaUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4Q0EFRV+KTn2YAAU5CLKSRZlReky5dXzhiF6PTDZZ8=;
 b=nSLp3BGWSNuA7GzSWuDcYoArV9IlPEz2x2PPDIKV8KnAZIWTt9ZBu7JbRwaxtOTHDVp0cdTrGmGxm+WXT7QiRYMGO7Te352+9hXiongYtkjFk/IOGjVQQYePGkTNEJpTsKkFHPOP97i8RafYLbKuMdHnSfdIippVCPgNUtSkZfZ1K81XmXhln6XrlEyxP653k/0xhU4W5HobkozjLC/2BNomP5ZP3Fyrec+++uv9IUGKmrlA7M108tGYLwx/fLELGjJUxFZxmJbt8TfBuXjkvjp3Sw4Fe2PnXSyaz3geBG5mJcdwdbliH1IfJGLhuuK7wiM41JkcztexzWeYDAnaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4Q0EFRV+KTn2YAAU5CLKSRZlReky5dXzhiF6PTDZZ8=;
 b=BrGoh65cU7bnNtAuVbuOuB4jw8Ql31lb1NAsCfWNSO3ynvRNdNGXnANVFJxBvqQqmI64c02gG7/rt2w+KlUhP2yMGGqSy39IdFHzSW493R3Q8mjLY3z+v+q8WmJLIfCYFMVraTDZSRbsIIxK0/WV7lQNqwisETTHgGPVJXsam1c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 22:36:44 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 22:36:44 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: [PATCH v2 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Wed, 25 Oct 2023 15:36:40 -0700
Message-Id: <20231025223640.1132047-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231025223640.1132047-1-stephen.s.brennan@oracle.com>
References: <20231025223640.1132047-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:5::28) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CO1PR10MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe7dbe9-0d34-46ab-5142-08dbd5aadd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4ZahiVNBZs7UUpMzrLSaicLckTqBoqIsRGyb3G5fmyA8ZvWl7iLC6Xy0+aOzhvO5FG2QkRagpU1npOVf7bdZ/o+gbEVJGakMdni11RvZwG/UfFSYSLMuvzu+iKuARP7C6EA3gpue6EHkY+HyLVgEs8yN50kOOKl2ouTUSJT33ViLJDyNWczyGBK3xT99FLisfp0AY+XuNRUpuiwXl5EmtPA5+5dDrX+lSWM5l2wsTD97NOdPXXYtvJfy78ZzgEzwSZrb9UAn2YkGD2IV92pFAafShlK74z8Dk2mfnc3Rv23OgbZBz+SN/JneKBhJSXRhrnUWng79R/RnbbQJxpyocdHLTUt6JVHYI6uSsL0exsozlCqo8mgjUDmxeS1buhtwhiWqhyKDOPLpa59oDUypx3y/m3g71pb/QZYRMc9tUPHP2qNE2sYQ4zP9Kc/Ieol4ZCsHjcukrN4RtVI/josnEUToaBi65eaC54PJWbpLue+nIddMPmvleO3GL6UxZED+Rtw8pJiW370H2l+yFyUwibT/xrj6uxyU0FS095IVRWYex/Hb0tfAD80u8pOlrFA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(1076003)(6512007)(6506007)(6666004)(83380400001)(103116003)(86362001)(36756003)(38100700002)(478600001)(6486002)(2906002)(66556008)(66476007)(66946007)(54906003)(5660300002)(41300700001)(8676002)(4326008)(8936002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?46Qp9X1ggJv38gpLzYx7y6NmgqIZNdk1yRIRa9hicV3JL5nLztmH0PXhknJl?=
 =?us-ascii?Q?sAOmHriwhOa/Ioi/8XcF/22GGo16wpr4FHv5IFtLhqjg9ySdhnAKlOGj83aI?=
 =?us-ascii?Q?V3Yn4laYFv1h/ixwHXBIaO92joW9AuOAa36YCrxhUK5dQdNLWWOZMysIUdIi?=
 =?us-ascii?Q?TrZrh8ESY/WOOGUOsxD4pn8NzO9qGvCu0iFjuqNI5LZARCX+xjOPQIuZW2zC?=
 =?us-ascii?Q?pPFhsTwbzjr0Q9lCAfU/DA3KTTnszLNfvpfqX1XVCBAQ4DGBYRyCEtHV8meR?=
 =?us-ascii?Q?65JLiAwV5IYyFgVmEj+tMXfp71u65tLUgVBzh9IwBlGIDcxTuoCJRLcWwwa7?=
 =?us-ascii?Q?0CBuQv2YMo3ioer3T3remhW349qJ32HHDMhfl/lp41YYIBuoSczVTeipw3mi?=
 =?us-ascii?Q?cjHKVixcnuTsKfuuCCmx1Xm2QkV4Vg1lkKCBwLlcOzFDH6Wg4+P38ziLB2/x?=
 =?us-ascii?Q?O63U2bQSFIGpbgTZB68MVFHMcgaigk6h1gkq3x7ds1ZyILocct+eDF23g1Ga?=
 =?us-ascii?Q?H+DFdzVlSUcmDFxqA3rnLDr25YSFDqSKSbtR+PKxqL4328aRI4JXsE8CFrR7?=
 =?us-ascii?Q?tzj2m2NOabIgChMzY9ii8frezPsjJtzaI5lJBMIiw2i83NHb+O+uZXz4DSHm?=
 =?us-ascii?Q?YIcaoIaoS6u9QICJqFwoxBs995XputB5OsgHXzPuOgqUpyVkAf3VnOEPXRal?=
 =?us-ascii?Q?yWFL5ggkxMXTiNiXHrHMAun3/URHejkmvMUXddW8fklkuFTLQ3j/pJWO3tkA?=
 =?us-ascii?Q?iDs2Hs/5+z90BxahxABSuNfzec/rVqBXD/lnkY/+hcVFcRMWcSMixZUrfToH?=
 =?us-ascii?Q?SBF9gX/Y1Ocnx1iQDTJgnHIib+whxJJCX1fxJEqr2gTXS78vScfSDSpYL+oR?=
 =?us-ascii?Q?k/0ObGZKGO8Rc6/ViD+K8SD88iWuHgyHgUYDArPDNlbGLQfHsXqzbbt2KEso?=
 =?us-ascii?Q?qljJcAs8WCl2t04wB1/GvaRBjkFJDToYoOsERfXvbhcUXpoBCt3R52XetUkU?=
 =?us-ascii?Q?RyGU0IOlrmugS7ojbRqFPMiDWQy9M3p+AFAksSSLWJ8cO9gZxBdhyzLnK4vB?=
 =?us-ascii?Q?tRTF1uxfFbIq271GugKTuZrRXalsWgB9c8Bvu8bjvC7bGTsuwhNc2h/2UbpX?=
 =?us-ascii?Q?p0aexA7CZ3f9lAyRnoEZ7bVbm6hJgrJ/v7ysZUmMvLqGXt+bnAFMroDRKtlr?=
 =?us-ascii?Q?QqHTjk9s7SB+01aQIyPbh3U/4qjMIu2vbppC8Jiz2FPWgQN2NqHOwKKgEQOT?=
 =?us-ascii?Q?U16LylUXOwvAJ/mrs/ftlNMm4uWSWYEXSnVuy7UTTgZ/vt60lRTzr+qTXAPJ?=
 =?us-ascii?Q?SUqJ6UUwf8VPw/eUpTOrdNbJsHCx6i7nN/5P3jO6qX9+556x3JxlA4Ra6E2R?=
 =?us-ascii?Q?KiZT7iozKCfBmZLtvffwq+eakgb27Tmm29rX3jBFZH8lpx/jWaN7glFIVLqY?=
 =?us-ascii?Q?4pSI3RvEkakZr9Bxz7dZYvT0L0VfzSguKhVZpqTzqAS4X9CLTGc84nGGQTcN?=
 =?us-ascii?Q?M9MNJmuL2qSFKob8eeAGv5qQ9Eze5l4HYjCMqtnO+5ceDUCKstvHRsZVsW1y?=
 =?us-ascii?Q?+x9XVSdVMewk/khlWa/c3GBy8CBufTh1HCuXu8lrJ88l6iwA91cVpYEbgJS5?=
 =?us-ascii?Q?tyv5TWIHXtTHE9JW7YNer0uOkYr/ZiJgUzGgTokhEPhc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DX9hzBcqpvXx+ebvylOa6XJpG+PRJxEkGtTTrjeaMq9FMikmzF/Z1oZQbb2aoGY7LKLzT1mXPH1NN4HGtcXzFCExAhVmo8FdtbwDXGCgO+48A72C3s1QvUrzvJCC/wss2EdxXQAQi05QQUGvMpGhJK6pceTfuFP4kxiyIR4aiopUPy6OVJwmIfDaq95ydfybeIJStOs29X2vv9yythk5fHwfmUow8E0pfTN1S7elUI9ys4A94maTKnthQ6D1443t3EZrxdhy+ubGl5tWLch0bwfaj9rm3eR1jtaS+C74FSxeWI8aLra0hVkRA8jua1lfTmc8zv3aVK+GmuNyg59rZZCpYNGK/D92uK10hBbO5tHzuku73nUAzrTga35cZcJIYXjILUTe7G0849gMeSScW2oIWGZfxzmTyLxcLROsfDNY7cSeTuq6xkEOQzOVXOrONKK6DjkG2vBOZ+cxpETVxoXMy7dY5LWou5oTOXNimKMiWxmgEPhMnpJcNopB+HBJgI0Tn8CakZHepObAJNpDZmgjRgFhRi4j4JHE7QoHidXdXdJYi/JenFahCFbph7ayShpUYflYPm/yyQy3b+HTMHZAHgQxSfnmow8pVolNFdFl3b4nm57EXcYkTxuSMVSjQTuGbaxYROCqT/F8gRG68NHfeF/D/9Z1abzK96b+59ienLrWYjZDPbm0YtYmHwbd+yFSlenSNjhlhJ4sfbr+6v4MQUM8fs3sovAGpXWQuj58YgfQm8qGmmnQYwYGXevP5UbjTMJqRKlKeubm6JUJCoWNUfi5Y/jPCutRuD9Gn0QE0EpfSGHS9ZIInnNKEdWm+HK4bJkcIAvDeyjBhKQSVQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe7dbe9-0d34-46ab-5142-08dbd5aadd7d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:36:44.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWLvKG1btQo3kz7QGhC7arDoF+Fz6O9ZQRjZ60pMR+5yuczyLy38IxhhE8X+4HwEqUj3XqNF8JO+HgeonEvBD0wDBy1FJGYV4zy43KlPrV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250194
X-Proofpoint-ORIG-GUID: WlG3LvCWg2XcF53i4pyIMLCapW3MTbgn
X-Proofpoint-GUID: WlG3LvCWg2XcF53i4pyIMLCapW3MTbgn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The option CONFIG_IKCONFIG allows the gzip compressed kernel
configuration to be included into vmlinux or a module. In these cases,
debuggers can access the config data and use it to adjust their behavior
according to the configuration. However, distributions rarely enable
this, likely because it uses a fair bit of kernel memory which cannot be
swapped out.

This means that in practice, the kernel configuration is rarely
available to debuggers.

So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
which is only available if IKCONFIG is not already built-in, adds a
section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
out of the final images, but will remain in the debuginfo files. So
debuggers which rely on vmlinux debuginfo can have access to the kernel
configuration, without incurring a cost to the kernel at runtime.

The configuration is enabled whenever DEBUG_INFO=y and IKCONFIG!=y. The
added section is not large compared to debug info sizes. It won't affect
the runtime kernel at all, and this default will ensure that
distributions intending to create useful debuginfo will get this new
addition for kernel debuggers.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  1 +
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 15 +++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 kernel/configs-debug.S

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..025b0bfe17bf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -824,7 +824,8 @@
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
-		.shstrtab 0 : { *(.shstrtab) }
+		.shstrtab 0 : { *(.shstrtab) }				\
+		.debug_linux_ikconfig 0 : { *(.debug_linux_ikconfig) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..e2f517a10f04 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -138,6 +138,7 @@ KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
+obj-$(CONFIG_DEBUG_INFO_IKCONFIG) += configs-debug.o
 
 $(obj)/configs.o: $(obj)/config_data.gz
 
diff --git a/kernel/configs-debug.S b/kernel/configs-debug.S
new file mode 100644
index 000000000000..d0dd5c2f7bd5
--- /dev/null
+++ b/kernel/configs-debug.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Inline kernel configuration for debuginfo files
+ *
+ * Copyright (c) 2023, Oracle and/or its affiliates.
+ */
+
+/*
+ * By using the same "IKCFG_ST" and "IKCFG_ED" markers found in configs.c, we
+ * can ensure that the resulting debuginfo files can be read by
+ * scripts/extract-ikconfig. Unfortunately, this means that the contents of the
+ * section cannot be directly extracted and used. Since debuggers should be able
+ * to trim these markers off trivially, this is a good tradeoff.
+ */
+	.section .debug_linux_ikconfig
+	.ascii "IKCFG_ST"
+	.incbin "kernel/config_data.gz"
+	.ascii "IKCFG_ED"
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..c43a874ea584 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -429,6 +429,21 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config DEBUG_INFO_IKCONFIG
+	bool "Embed KConfig in debuginfo, if not already present"
+	depends on IKCONFIG!=y
+	default y if IKCONFIG!=y
+	help
+	  This provides the gzip-compressed KConfig information in an ELF
+	  section called .ikconfig which will be stripped out of the final
+	  bootable image, but remain in the debuginfo. Debuggers that are aware
+	  of this can use this to customize their behavior to the kernel
+	  configuration, without requiring the configuration information to be
+	  stored in the kernel like CONFIG_IKCONFIG does. This configuration is
+	  unnecessary when CONFIG_IKCONFIG is enabled, since the data can be
+	  found in the .rodata section in that case (see
+	  scripts/extract-ikconfig).
+
 endif # DEBUG_INFO
 
 config FRAME_WARN
-- 
2.39.3

