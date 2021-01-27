Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37738306529
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhA0U3U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:29:20 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:24673
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232854AbhA0U1v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:27:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQO48VvBVo0jjzT0xTON+SeSDaKlGcbenucB4iR/+BvYWDKC68TlsxKrLcGkl6RImfbCgZhpi25w7lDoPuTdv2GW4bCVRJxLG0AI+AO+ZMLlIfUfTIWiE9Lvnt2GMizs9hfvX9rnjBu8aeIK4ze2VekIKSNWZgdk/qyj93/4wkZCzlK+TeeXYeDFj9bLuh/iALkRIJzo5b8DwSc6o2lRyR7kavUmQladBUFo+OpXVCr6fCKfOHXy8OQXZtTK3FksPxij46ro60UMXxVNusCJKWeG39LOSWcP7J2zcf5RFxtvx2v8rvbhZBeDQd+6WMPfl606HSxjPKkt463hPAu3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFRJ+ZdZpTLnX8p2sd4bkWwkJMVtZ+p/CwvWB053yWQ=;
 b=BuPDjypd7vRLzRAuyXC+22PdLQ9JmeDiDbiHoHflfibKkce5yz0ULB1RR1WUISQ6OwbqDl9bBc2p5TGVFeXTvx5UBcDMJbySMgNZev/G4Wvp/r18sbDOcejGNukk9h3LIaEoW2hnIXiHw9vsV0r6Zywjc6aLiA7GuhH1gEB1iaZDz8IY5XB7AwAue/BnqxQpFiuoPlr1U020WkIfWtXGunWLFcbw9aVeZFzPcLM2ZEWa+bCoA0dPjjsntRTln5cVD6Wb+z27/Xrv6wQQn1rB22uUW2MmBX9WuPikPL07zXnGPHK6uN75eWHLo2n+ZOUVVEo+PqpIyI+ZSwurBxRXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFRJ+ZdZpTLnX8p2sd4bkWwkJMVtZ+p/CwvWB053yWQ=;
 b=G0BVBxRq3aSOYibfhU44aFN8U1cP6Rut0042hlPuZhMbzHQikJtrnvtys+U6gVhOoA0vD/dI1U6LEjgLWjVTspReSeZ0opyQkc9iuAo7bB/Ok+u+7dj4c4fg2NZn1cG3xt6myUurhZbbZkVsh9oGXc/GX0zYGOM3vAsuVTXBAgk=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:31 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 09/10] clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V feature
Date:   Wed, 27 Jan 2021 12:23:44 -0800
Message-Id: <1611779025-21503-10-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To MN2PR21MB1213.namprd21.prod.outlook.com
 (2603:10b6:208:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d071e2c-4c8e-443e-62d7-08d8c3018d6f
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215B3CEB8B1900DBF89CD62D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1zGc1iUxnvfLTxQdHsYWjRdqa8laFDYnIIJZxExEnR99RYzQG9F9/V+ndV20o+RA9Wxin4myxEI/OqZv6aO1A8jjp8Zzu4gytiwvFc4UGRUsGLKap4w+tQPEIGXrHy3y5EfM0ZNOwlfACJzPpZxdsQjXfRTlpurQNO8Wj3iXJEejnfjBdseR7K2Y6eNkVqO9D+EBabrojvjrymoXcG42FHYk+I4JMWyy736Sz8E1CRE+4MeEpfVBtY3CUqt/Q7OgKvLJ3Qr4+jynfAeRIOHOGwr49k+ISwcqFqOGue2Jelinmsu207EQO9/o1FMaQjPYFTfl5rkhSxpPt+wlRBpKMbJ7oGGRjsq/m5IW5S6FEMB9yd9L+MHVWxYjp4oNPgub7xUdH6P/c77Io6hkNw0ZoQO+8FoMu/9UEMAuyX03cBecAxLRxnM7ZZvACnEQsrjHgQYx1P5amHudvNXDCXhH5WC+2OOjHMKZHCLhZzAvw4sckZhUHmlOvlCIqj3lL6/D++1fTSvLrZzFwweHmWj4lKost+lqDkElxMr5URb4isH1hg39AsKnRlH2/QPh9dk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g9dQK/td+HQdx2wJpUmPWpg5EKzzlrAXOI5nC/Y/8rKCxVLw84sVtLHMFpD3?=
 =?us-ascii?Q?BwSPcuNr6Kqs35x4Uy3iOmVW+0NHf8X8wA29t3AEQScaZTI+g0M8dg5IPHMG?=
 =?us-ascii?Q?+OXrFK8bBASdwKYuvFyiLI08Wmf5I1oj2J8LY+Stc/VS2WhNcHUuOGTG1+Oc?=
 =?us-ascii?Q?0QUqghfnB0BWQB+3jogtlt20XK3f7eJeqae6URXduAhh6pUJmoOFgDSxM2ph?=
 =?us-ascii?Q?ql54c/8shQvTTVwmlFnYsaW2iOuWMY8eVB8jrhC6CsYb8ZvVUAmaUSOHeIEO?=
 =?us-ascii?Q?rtlov31OCWTMx+elRAQ3XFEt+kjpB/sKuMAfE6OQ5FP89935w4izShkuZA2T?=
 =?us-ascii?Q?iMyRnfssE1xE6DsAWXqsAnbyGA5ETtutAuGMZrZu6nqBW+kYuWQ5mwf1Jnka?=
 =?us-ascii?Q?s7xjQFysU6U2rP2MncGmfi8+pBXvjC2zoXUNHTWICWxnryH+CCO9gb3g8iUz?=
 =?us-ascii?Q?PqOljeNGjtvrrnE3EmaXKpPp9cp0vUTL/MfM9GOjvGKf9xPGR6EKUYhR/xd1?=
 =?us-ascii?Q?BlVHKHuXG1/HaQwsmh/xT2tGBCX6tJnHRKA0UH60L+UtN2k3fOeKZGkPhBE7?=
 =?us-ascii?Q?sWBxCQISiCmepq3tV6Nyjx616MOKEbkxbGw4A2YPvw0MWUwahWkNv5/NmSdm?=
 =?us-ascii?Q?qyp/jgxuhWLB7ZWZS46ctCyamezLXbNXWdScCHPgb33bZauhoZTSIBF3ZEd7?=
 =?us-ascii?Q?buoE0Sq/jpDzw4BfeIAdEQ83HJVA/UsvnQZG16ZqdkDvj5vfZYTB8eFpQ5Yb?=
 =?us-ascii?Q?HpGcuAuuc1w5It1/bd/7RVT6Jugq9lHBN5BjtHwYCFXSloGjF6Gu+fJvH6Ph?=
 =?us-ascii?Q?SoPEN/H+XKZGFmp/KmHn05B4pyQAunHttDdSYd6tFkti5J+kP61AlGfv7kVz?=
 =?us-ascii?Q?aKqjHdp4PAc5T7nA4YAS8NgHxZE78ubidEtzQ7T/nav3rMbIUYY7hbDW4K3A?=
 =?us-ascii?Q?uMkEI5AbssASQiBrjHPC75AltmhMPIeDfqV/ohenIMwYHrnATMGa0cNQptQX?=
 =?us-ascii?Q?gIXxEKo67pA+vXrUvqHEVeIcOCBv99A0Ly1JmoZiFX/Uzp5Ea0hNDVmJIqNr?=
 =?us-ascii?Q?sKZGBxZC?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d071e2c-4c8e-443e-62d7-08d8c3018d6f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:31.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSBHdYK5kkWOQuXoRXLhO/IzO2UAraLq13+G5RECy4ZFz6740O+hdTz5rSRIQ79WCqmCGZ2+RWkTG3fuatg0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
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
---
 drivers/clocksource/hyperv_timer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index a2bee50..edf2d43 100644
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
@@ -452,6 +444,17 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
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

