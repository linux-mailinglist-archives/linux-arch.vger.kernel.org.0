Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9490232B4DF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450144AbhCCFaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:39 -0500
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:44769
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350996AbhCBVmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJFZaUzWPI8pQKHAWuvh+RYH2auoecYcBZFkSQeP7jyVYQKxL9um3mDcZiR0us9MjtFohLvF+AMqg8+YWoG0rJpKnOCYjSEYUbvRZy0dFT7o7I+1DEjqehLaRQV55p4GN5pDT/8nJE10OJ7CGGsM0R7m6RrbdDWOYhwoZQGJkumI1GPnF3n1UmphjUEFuYAYwsCVzlbrKhp0QHoda/sgYYc2UYkm3uVqoYzgWfosl+44lfr1FcS1YqFlQPTDIFgCm2Mu/rRgLL0RwuEUmFWeE89GwwNIFwGGu3MC1WRELn65O0lkBxPlknT1ebkqvriqxR9cyMsr54sv25SWubMLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP9vRqWren4EnFydfkhphU682/I+A8xv3dbsJsc9PoQ=;
 b=dNsB7LsGOtqFX8K8XXUG0rju99sU295+VXEDH2pAG4xVlrvkdqcuKMxsIzrcF17gBi4+pXq33NFHCkLWqYQvwXqIa3SBieqDpOcghs0wZ5v/+tP2Khka0EsjQUq6qELzg4Lk+qj1azANTpxqXvoYb1DFzPmBhqozCCzPAmC3lwAOBd6CEkqKlaDNhYhOSlCKwurj2vDhwAMYzjh0x6Lj6XyFU86nMnMUyHJbiKTl5jPWdHpqJcBYl1kABOytRWeP9J/cwNSEMKiqbTWPQu0XGXVKsUQ7+jf6imKqZmH3Rv6OQjT9JhkVD7poceYZm1DfSLgR+E1mAL6eqZc0i9U3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP9vRqWren4EnFydfkhphU682/I+A8xv3dbsJsc9PoQ=;
 b=AtUQmBbYeOLjYkPH8z+kfwN6yfb9RDlyDF/VqKchLoelmuAVCk7b1Vd02qY3Gdnwsv4OixCAs8tU8WJU4jjHu1dE8fuITZEoMl0ZgKcuV4ce5rLUKmshpzdxIWx0/I/40cm0BD20y35rowTABqDzRDix5O+UoV/KZUbaz1D6dqU=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:39:01 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:39:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 09/10] clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V feature
Date:   Tue,  2 Mar 2021 13:38:21 -0800
Message-Id: <1614721102-2241-10-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.16]
X-ClientProxiedBy: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:39:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e4e7159-6f8d-41a4-4bce-08d8ddc397d6
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB01537E18A7A140C1F12CB5B0D7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbWUKborayBOWAyZRnnlxjkOqDYdTnumJh7nbNDPfrBSeoju460qymVxT0VLbfmfYLfCyPQ5ZX7tgz+2rSZBZ19R84osuTfUxvlkPXxgD9TCGgTaEhzbblvzV4nDODQgCrK0Fsys5f79bgR6Pi7SCwLuy6iM2ipUxA/Jf0Aw4MCAnpLOKgWEDlGJuDEcDc5VeUejvcFYIQIQ5ADz7CVxiXdk8de0vzn8BEW+WsDvI1PUqgRc2bxegqd0X+he8HG5Ddy5v/PTEIyTTmYNwCE8ketXCk8j9lx6LR8xCinWwU31rKQDxidlljlt0du4dKOeMiu1WQ/YTap2GrKrAzTJZM9stqXeRdrXAJryBvbaMNKmOsVwVkgtr72MdyY/eCZfxwSsyfNcjHmfKTSPCJ1eZ2rsOmzLwdGMpJTf/oZd+cc0W4s3NOJ5YyHgB03/70Yk5NYxS2Xh0HLVIowMForJGbn4Rp8t27Li07brOpYMirv5sc7ZoGVS/iw2ZSSWj0zrSMxjnAaheClVU91f/g8MmKpvQrcCjY28gn7HqECJqNLTurv7STgOxrKCv4U6Zh3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tEorex67gDDXv8FMG+EYf480Vf5qwqLwQYY8enzecOOprQlsLK/r6uLSRtDA?=
 =?us-ascii?Q?mfQiedEWoQiqMeP/AkavJlufWlEtEtaKQ4bF9HWTijR7xwVUahKvOL6dQKzk?=
 =?us-ascii?Q?PaxC171UKSzY0LnAiR3Yztr21SkFkg3KtZlfNS6kxhyc6PvsJxEQV5HkAHwF?=
 =?us-ascii?Q?6AqPSmTJx/aYGQQWKc5OMpKIR4VHHMCsc4z0W4ujTgl2mYA6vr4HYzhWk+aU?=
 =?us-ascii?Q?MS+GXLAUQ3oRxXhEB2x3BMsi+eEu9D+uO5SMSbIDVkCEAXtwwqcI//yjriaY?=
 =?us-ascii?Q?Hkk7k2B5/QNi2anhr8WKCGpLCjE4xA+sFKo3JIer44qqJLK32chB55fSS/pn?=
 =?us-ascii?Q?Rpyz093xbm21uSyGpbUaokxpIaVG/VfZYag/tGUFCykq2qrn6UGpmCy+FN4x?=
 =?us-ascii?Q?Crvt91eK/qpYCjRa3iYzUuVc6E2+NTddSWjPuRmAvJ0DzHcaYS3QXEJvWqFx?=
 =?us-ascii?Q?2xmsKTSoDfAhuGSX3+YUCrO7X2wIZH19MAoJJakCfZTrmiXA5+VeAanw5HoB?=
 =?us-ascii?Q?guvk1o9vZPGAuw4kKi7q8TWjDpQguKBf/+r6XMJBny7WbpNWunD4sFZ/nkt7?=
 =?us-ascii?Q?XPxgrQipjSf/g64orDlyj32YQoroPxP3on0rCw84DCjbF1GYG/NMwSeIshaB?=
 =?us-ascii?Q?TKKVrZq4PGiPVKdjKnzMb/k+FJYneT81uu1skhL65Uo5zDa0v3flmpdB2703?=
 =?us-ascii?Q?upUA07RTShYgV5MoJEkbN5SxKAHkkJCF/XOpgcsUMjM1Vm65R1YqWU+Ssxid?=
 =?us-ascii?Q?ScWxx0NGlKMgfS48Qn6/oyl0T84gQMqp3SV898yuPgQuSVh+HnAXbXqCVUJg?=
 =?us-ascii?Q?zzcmfunV7ukLWs1YgbjhwuICr7P4iVdfiPkbpXK/h38B09ks/g20mhgFjBpx?=
 =?us-ascii?Q?x6VEqzhN1I5GbKMFR70mmUBK6rK29kp+6GF7nsSFpUyJbk7a7+VyRaPHFnxQ?=
 =?us-ascii?Q?807M4CnWxrIH2vmTK1bjnuwrD7KbBbiHe8DIY8C/LnwgBwW9h9VqISYrXsF7?=
 =?us-ascii?Q?KDpxpioSHCFbMUzx4ENcUkF4YXBJ9UQoZPgUAA5gTjGSmZn2u9ge3d7FlPby?=
 =?us-ascii?Q?FqalGnmS2QCkc7waRkF4+yIvQNnWOr8elj8YT/JAOpqpqvYhoFOwcpuAD+M8?=
 =?us-ascii?Q?SDdW2NaIg1b8h9HR75a270zdVCTjvzkwUY6OaIlL34dYGq+RKYspsV2CM+6C?=
 =?us-ascii?Q?ERisO5iZhL9lhNwH9IwQPSkHL5BZ+lgpjyh3FqtSYPs3me1ewJxcZ5q9+o0t?=
 =?us-ascii?Q?Ls0hLbQhEZi4KJojR1Mozu0SLtXNKLEFAthldAIfy50UXbYDN7IrlMdWZxni?=
 =?us-ascii?Q?KdyoIhhk9e0+ti+XtvJBVcH2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4e7159-6f8d-41a4-4bce-08d8ddc397d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:39:01.0412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whvbwOXo6b92PdJIz2e6XLgugpULiKNInGdDjEUdgqJJ4RTkXujq7bISvw+Q7UgK+8QV2FvYPRVNsfDdpCzUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On x86/x64, the TSC clocksource is available in a Hyper-V VM only if
Hyper-V provides the TSC_INVARIANT flag. The rating on the Hyper-V
Reference TSC page clocksource is currently set so that it will not
override the TSC clocksource in this case.  Alternatively, if the TSC
clocksource is not available, then the Hyper-V clocksource is used.

But on ARM64, the Hyper-V Reference TSC page clocksource should
override the ARM arch counter, since the Hyper-V clocksource provides
scaling and offsetting during live migrations that is not provided
for the ARM arch counter.

To get the needed behavior for both x86/x64 and ARM64, tweak the
logic by defaulting the Hyper-V Reference TSC page clocksource
rating to a large value that will always override.  If the Hyper-V
TSC_INVARIANT flag is set, then reduce the rating so that it will not
override the TSC.

While the logic for getting there is slightly different, the net
result in the normal cases is no functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/hyperv_timer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 10eb5c6..7a9030c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -302,14 +302,6 @@ void hv_stimer_global_cleanup(void)
  * the other that uses the TSC reference page feature as defined in the
  * TLFS.  The MSR version is for compatibility with old versions of
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
- *
- * The Hyper-V clocksource ratings of 250 are chosen to be below the
- * TSC clocksource rating of 300.  In configurations where Hyper-V offers
- * an InvariantTSC, the TSC is not marked "unstable", so the TSC clocksource
- * is available and preferred.  With the higher rating, it will be the
- * default.  On older hardware and Hyper-V versions, the TSC is marked
- * "unstable", so no TSC clocksource is created and the selected Hyper-V
- * clocksource will be the default.
  */
 
 u64 (*hv_read_reference_counter)(void);
@@ -380,7 +372,7 @@ static int hv_cs_enable(struct clocksource *cs)
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 250,
+	.rating	= 500,
 	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -417,7 +409,7 @@ static u64 notrace read_hv_sched_clock_msr(void)
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 250,
+	.rating	= 500,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -458,6 +450,17 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (hv_root_partition)
 		return false;
 
+	/*
+	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
+	 * handles frequency and offset changes due to live migration,
+	 * pause/resume, and other VM management operations.  So lower the
+	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
+	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
+	 * TSC will be preferred over the virtualized ARM64 arch counter.
+	 */
+	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
+		hyperv_cs_tsc.rating = 250;
+
 	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
-- 
1.8.3.1

