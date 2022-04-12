Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D484FEAAE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiDLXgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiDLXdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 19:33:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E8C8BD2;
        Tue, 12 Apr 2022 16:15:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23CKP9kc028126;
        Tue, 12 Apr 2022 23:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jUgDi9DPQFydTjslxJMosb9RPCwbPS25vDXrMlPq0hI=;
 b=bFelQIj4W1N5KhE8KD3V8IJ9a5lRAdYXIZsxDjVUXGSDhuPN0oeCPN3l7iDdY6vw7ZQM
 BV5wsqWK89/taCkMtRbLDZfxQOjXQnOmshSJ99s3mO9B/32dpuECN1ULNJb/rkk7zPH1
 9qNdTr8zJm8RXwAu51+RMX5k7qmYUuTwdbVJn9eYw1llb0AvIWZcq94S9tgDrVLAiZhp
 H+XTBupy9CuCD6tDFZjXj5YpGrEdkbRHPhmjg/qGKHAy0dtc+gakGHCFQvsOHNHPYPSu
 0RIxmkS138Re1vUTv+YfGDxUE8ccK84QMr6S0QigHYn4b97w/mQ/GPALoNJMeuGcbU9w Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a020g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 23:15:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23CMqXcd029103;
        Tue, 12 Apr 2022 23:15:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck13b1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 23:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1BxiLeHiYVIk/yfi5c/umZT5hZAX5m0otvWiPovjOD9XxqsDM0RbBSwr4fx6mWOTFmtLzCQfFv1MSePQDufvdygp7d8/nlo9rzwg5yHdKmJpSLnSt5UWu0rtQBMseGCFbOdiRRYeyUjYQLNMe+X/Z6zaIw+Sk/exPWGz0KvHro9T86oj43Yv7bIo7bhv8kBVrnm6A50ep1xLd+UOxi98zizu3LFSHAmbjKL0HZDpkmZLb28zLOU6v1Y43+a337s0NhUeIJqCozt9pVNKMYCGe+o+fL7VUKwo59K2QlIeEdKsl+b1YxGuijeJP3lMp3hNmdjOPz+mv1utCbW3yFocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUgDi9DPQFydTjslxJMosb9RPCwbPS25vDXrMlPq0hI=;
 b=mCXAAlBnZxgNpPImbAUnrsYdlO+UUi7AayfClqhoQNmGLtrSX3elBlt3XDd74XK2xn5AJiDwDJQUzInsdRCq0No1ihkxR8aRzmXtFagxsrFi603HYGE74bfedpKoyy+3oJXmtf8YwK6nZQk7T3qkKOtdOJyrXAzEk7jIVnbBhWY94xmMpPGUwYQOwihO/8l05VOT3VbonQV23pyyvYc4RJNXlzkxlUHw3Osj2rYVvMHGyYNhaBLtiY7Hf7yl8pW6b4eeJhrZyhvH/N9RE8j705t/5nELdliCyzURGym2NJn1tiBNKLR86FXWu8DDgYf3/LvYKFu3MKuGGjnr0cxNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUgDi9DPQFydTjslxJMosb9RPCwbPS25vDXrMlPq0hI=;
 b=ri58AtNlMaBV17X94o0RlAj2x5hoYVLRZfxIunvktG2u+4eWCJp2EVtXIqBGnpXjyunwB8YfD/O3M1XC1UG3Mrmi8nTrYZZB2QR6piS3Uo9NmvTmAXOUhJHT+TUYYH87qTo9cjVjIYhB11rYBiXMHnJ4d4YKvwF54UbKVzka7k4=
Received: from SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11)
 by MN2PR10MB4030.namprd10.prod.outlook.com (2603:10b6:208:1bd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 23:15:19 +0000
Received: from SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287]) by SA2PR10MB4569.namprd10.prod.outlook.com
 ([fe80::5d9c:9b32:8395:1287%2]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 23:15:19 +0000
From:   Libo Chen <libo.chen@oracle.com>
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS dependency for CPUMASK_OFFSTACK
Date:   Tue, 12 Apr 2022 16:15:08 -0700
Message-Id: <20220412231508.32629-2-libo.chen@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412231508.32629-1-libo.chen@oracle.com>
References: <20220412231508.32629-1-libo.chen@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To SA2PR10MB4569.namprd10.prod.outlook.com
 (2603:10b6:806:111::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ae0bff5-03e6-41a7-630a-08da1cda4f84
X-MS-TrafficTypeDiagnostic: MN2PR10MB4030:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB403087E99A3B1E263A92AE9285ED9@MN2PR10MB4030.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAxjYhgCCW70RaeFH67ITa0yb8bIn4A4EvkGzJlRFNz4tLWBkNChhFsEJXXIuRAyk4anInYsOQPSbbY0dzVO5JbDXvoKXDdbUmhKEVK92XJvFsbLBFH/uziG0nx7US1KOP9YlTTkY7JEGekhg9dGT6Fp6iMDFdxkSHO8J/dZd1uctyQ3ZCe7s8+5ch/Tad3w7CRQRC0Oa9j5rwLXisfuY0C8w9zPC+IEGLB8bW5iqi7jBNXJn9n6LI/RmnJKRNCJrQNb2J5pqnwVhQS43+WVvpC5uX1zQ7juQFpx/prh4j7Tmt8hjl9fa5mV6lWlxc7PhtKqy847Qjfv0uWA14J4o+qJrMrmyyEFfdMc3JONWxC4Rl5aTK5UovP+/5mH0NruyA/wko5HJ5hQtywj2oRtkykrAiCtovxFy4hop50R7j1tq1u7ViGmglJtLSxMAD5fK/Y0WQLLTMq4MzZUO+FYu9t7eCJrurqsd/SSztx+mxMM++k3P8eu3hmmIwRFxVeBFCCSuwLyiAhNGalU7tvwtmXzCu2p1mlLxgclvVA468lhgkYTsPQR/ug4rMY7Nnfa8QGe/cWe1MKVOW7SMLGoRNWP/lC+JRuBxm/FrC+2IYk8BeQEdeKRG/3TL+upql6II2HF3tc02rGNEQDLvRloVt121NWp33OMFK7chbGzc2HR0UkreeoaYzhVWfN76NxIVWTcm7FHkhdNDdbwXbM/Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4569.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(186003)(38100700002)(86362001)(36756003)(2616005)(83380400001)(8676002)(66946007)(66556008)(4326008)(44832011)(6486002)(508600001)(7416002)(8936002)(38350700002)(66476007)(5660300002)(316002)(6512007)(6506007)(1076003)(52116002)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWTbRB+Cl6EUKpABw9DU9OxvYd9VQ18s/7jp8NfecvGPJ3DXlUsThLw1xT5q?=
 =?us-ascii?Q?JNELR/tV3KkygWJamEN/uAxMmfImCyqi+2gjS5cHkYMN1fR8fRtdHXzYRrN2?=
 =?us-ascii?Q?FTbO+IU0MorpFWfk96oP/NdSeWeREtOi49Ehpap2Vpz34SYHyjo0o2+5vIJx?=
 =?us-ascii?Q?aL4krnS1gekt0cI5drexRGzo2lzRJYF1OMQPps088oMK70uvsfIIW5ZlR+H3?=
 =?us-ascii?Q?9hjuMAPuxh7qQKr1x5wsTv5yW5X9QQQPR2M0Evcm8+0ZkCwFjszdJevXvfhg?=
 =?us-ascii?Q?ZNcfrZstDgCM1Hq9jP0H4OvTBiJ8NoFfnOBshKprRlTCBnseuF4wQEX8tEr7?=
 =?us-ascii?Q?WrUOKdXAwzBIbBaDencf9yPZ+VtlS4LHcWQM0ozCFcb0La1PbLcUoDhzTtNj?=
 =?us-ascii?Q?gjszNv2aBILaoRD6hAvuhWYnl3CIrLMQtpqLmjLID4F/hEGy1/CdqFukb3Ir?=
 =?us-ascii?Q?EvuxvuQfPH1aqpMdLLs01d/A/9k6pdqXh3+XK0NbFDTgqhkO76wJUeHJG8JU?=
 =?us-ascii?Q?ynOhMm+6Rr+KnlyGe9dqd2AlFjxrpx1oXZ4Ldr+AT3RvxWvj6GS3WDAOrpQ3?=
 =?us-ascii?Q?vt/T1aZOv3NQ7WV+89fS+3FmyLn5kZYYQ95yePKGGmjo5vPADYjcGTK25bmx?=
 =?us-ascii?Q?IZOejBFpfmYFfFN00e/F6VwfES/JeSnYc+8Oo0/5VKhQjMtl90OVWh6O4Hvs?=
 =?us-ascii?Q?KwTg5bokCTtxRNnQoAK7vzg9o9u6GgGIKzn5A4HQikE6GlJm7WNG9+ETlj8X?=
 =?us-ascii?Q?OOtggD2xq+A9Bk5dQuTq9OlHldvA0Iz6yYrtsJku7aGi3DLYtVX/N7e7tbdW?=
 =?us-ascii?Q?D7y9ioYUnjlJ2vrFbS+d6AGUlmbUYA+Xl3cv2u01ZJF9Q+VTiNVBdxvVne1z?=
 =?us-ascii?Q?t7Oi57Arm5ZMXJmowZ7EF8j1w43EvXI7Q/dUh8PpRYZPmyzWK9gkW4LvT3It?=
 =?us-ascii?Q?ar0IRqjKP9PkJFdqBt1YHSCAOqDt7nSOTS49Jtk6vis90XdSsBYGSxNOsKf6?=
 =?us-ascii?Q?BRk13EmEL5i5g0K9vyy5q4YGKRjP8fE0Co+lx0CMTE0XquxMDMGqZld2fn16?=
 =?us-ascii?Q?hIqOJ3ygDqy73Nn+TQ1EfS+xk9X/zzt1lIrrcJ7Gsar9tiUCuNA9dJVx9KDC?=
 =?us-ascii?Q?AkwEdXB40VVYcytGg+eaGJn0jygFHnBrvUulYbTePyWf9A75WCCm7MSePu9q?=
 =?us-ascii?Q?xSUvW4kGGVsfahvfRwl4t9wjR/rVi+aeBBc+n5ToQp5QmZyXgF23L9XQ152W?=
 =?us-ascii?Q?mBEVY56JeHlWWaGQRHjOQkx4G974Dug4wxfGq6AMdmCPCcAy9kF5tovoEL6Q?=
 =?us-ascii?Q?HCsFIxy6C9pR8Xo0Tr1Eod6kR5zSStGJaNYlyc4aAIEErKiVHLVXN6DJeYIL?=
 =?us-ascii?Q?8gihdQ3oHFMyTxZ1/+d4XN9HD/2WE2omH5lbCXHBD+2iks/7r11EjNNM3qtt?=
 =?us-ascii?Q?Hu2ThxenI2Z2cvvbBuciNx/FA8cF3j0D7K++V5Mnlf/N6NNDk3Kqcg56LEnO?=
 =?us-ascii?Q?vNZ4NeE1WgoRIpbg4oVPvkJeBHaGyKRDYudBTPJiDFMFd6rypBkx5HL04Xb0?=
 =?us-ascii?Q?HpdaNcnR6agmpCHZjoJ8mp6tJaN5X05woCQZanpp9wqx3EcYxbVvQz4WGSQ9?=
 =?us-ascii?Q?Cj3C2f6NQcnJRdMYAsbqUWq9YSxQZkrR2QHrz3k7K0uSP7w3PB3OTRFuCPji?=
 =?us-ascii?Q?aWmH6/UT1YUNFlIPS/pdqGqJmvoUSVNgT0WMNMl3ppGazhHHrI1Tu4mHRl8f?=
 =?us-ascii?Q?H9in6QtAGQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae0bff5-03e6-41a7-630a-08da1cda4f84
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4569.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 23:15:19.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G+gPvtE6Z7kXWjS8P0WNYfDazs0k170XBxfU5o7MQJbM8EHSyyVu/y8z5vmTl7Hi6+58/IiXXABC+vqmKhmbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-12_06:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204120103
X-Proofpoint-GUID: wTA_Ikmt80bwxRZ_z14wOJ-FPdbZD7Du
X-Proofpoint-ORIG-GUID: wTA_Ikmt80bwxRZ_z14wOJ-FPdbZD7Du
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
index 087e06b4cdfd..7209039dfb59 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -511,7 +511,7 @@ config CHECK_SIGNATURE
 	bool
 
 config CPUMASK_OFFSTACK
-	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
+	bool "Force CPU masks off stack"
 	help
 	  Use dynamic allocation for cpumask_var_t, instead of putting
 	  them on the stack.  This is a bit more expensive, but avoids
-- 
2.27.0

