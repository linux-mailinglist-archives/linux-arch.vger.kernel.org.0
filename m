Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520BB3275D6
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCABSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCABSQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:18:16 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAABC061793;
        Sun, 28 Feb 2021 17:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjDFbOY9SsXU4w6RdJw5e4LYVCNTkPEi6gTwXEVYLT1BWfiUcmRkUIIQy84oIhKLP2ie/m8x8dh5vs0XDSTBt8bT9RyyVfVeumLk84JyVMmLvuEx9ia6kiUYUwnrFQl/mxJZWlvm1xrILffiinxJLQIiM5LkIAbMVq++girPwDvlT+XzKxwQ2hMA4q7D6RFiNBQIitdogCC4pjrahcN0ogh8L7oM1M4+t9n9MErfiChZW/eht8IIcvOHuZi8xfYwIeU+2g5aXHsSZmkqNezl5qJ76Rhb18933Pedqz4SdtzyNOGJuojSCHLovTmuZdik4wF04FzcGLGfP99Zxrjq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0ozTz048cRw8Hyea+HwzPzXDk/7LsbWPV5fDuzPtG8=;
 b=XpShUsr0MnvMG2jiVseKux7hqAFYnUYGb7G22tlp62YrxTTeDwcoo5wuan6cmYq8r6bKTt8RhkCrD2z1DcxyXc4dNqcRaYIIZrr5VGlRPDzXSNbWQMlnrd+h8LHpKAnqhZ/CB+pyViVBsYKwo+fc48dqWcAUbKkruUFP476QUZMXo1JS7VrhsclCR0+YNoDqpurSBNi31eWWRebr+dcpnv8bQKVfI37GcomUCKTW3+Myi6hNO5fFjzJhU8VmEg7lyXjSM1N5DeWHGbGg8C0ikmyyOQFu3sWFOHs2xy7akAf6+Jvi59dfCbsMSJo+3MbciNCHcSemNtEdxyf7ZOmQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0ozTz048cRw8Hyea+HwzPzXDk/7LsbWPV5fDuzPtG8=;
 b=AUNBjEEJxz9DpfsFZ9y0TvbsslL0ZT4R5ZRqkBXCADwpoM1FWpxbnlTijhW5GYqKs2qRl7NIrWoWUtkzPHcbcDySBcwJCsCUb25zKixOVRMFiQyIlxRe5evgiasS/sper62wO3kYw73zqpuHvSrSwgWUtEPLgqLu6QHPA6llGLg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 09/10] clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V feature
Date:   Sun, 28 Feb 2021 17:15:31 -0800
Message-Id: <1614561332-2523-10-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24043296-5622-4af4-e79b-08d8dc4f990c
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981242CF012BAFF02E2B9ACD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYMt6GGmz60Tu3bUrL6RCqfn2uf9TpYuPMGPEPuHvw2fv+GZaeu0BCyPuqmINVdieV0yDUPB7SbdZ9J5Mqo9Uoa/SP8ZNO0p/StXO+xXbznqIWRGkXfX7/eSWOJpNRpLGGOX17UwFj/X4fcyw7CovfYJRlhnGucxwf6WwfhJPqKeJh7L1xKycoLGSJuWHT8++DemKehOYUdUQPJcRWXxKsswgdicVvxnCeJ81YcVWCEC5K9mqQGmBQig/MEWBRm+CoO14Dny3kg/ji/9LhPEbWeXVgSqIKItq8vy/QID1tuKoeu/Qs+8kzxVGepQFTCqw4VZxEDIOCYengoC+npmSUxlILGr/p7A1ByXwm8Ta87lDkkdM8Ebus3hqvr65G41Znxq6LfAp0pFWskQ4QwDYj5o+R6plf8vNL6XThSMZosx6gIh4Cp88oDaQoLhSEHpsfYUUqgrKHTqDo9G6s6sfLb49lMBLjq7dMq5r7xkxrFE9X4rCUswtYEbSoVCqYTiT1X8+Kw5RuHftYKHsBvw7zIATTO7bZFYKjFFa17e1LtL3Ot/ch6StIHt+jE0nMiO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kKeLy9TBXp1hENUZZuk/Q/OMOUKcT1c76cBsEwHo/LmXQT+eYpa/336LFwto?=
 =?us-ascii?Q?Wm8eGVlhWFVE4SiQAvoHekb7PhBcc5Ud36PtE6Grs0VFGnW4HN+FE3l3Xq0L?=
 =?us-ascii?Q?a0sunf3B1ffjmaJKk5ogPQ5VPIfQ994Pru7QSUuRFu5pNed0b5z3tRy2aatI?=
 =?us-ascii?Q?3Dv2OTmMYTU4KAlbDiyR03PThxBgp0IgsJjDRHDY9axYo3qoRQ5mRxQiMCpe?=
 =?us-ascii?Q?Dde6dwv2BNNX/Ztm69pvNrmZYJo/FSEFjxDnDVK85VDdWwqGua3Ab0beMQh5?=
 =?us-ascii?Q?SY7w0C1j4843AdfMfS6jXF8JMoQQuyAYAPB+8Jl4I851qFVYiWmnWl81NUsi?=
 =?us-ascii?Q?0kcW3o5zAy16Rs/nLZ/JS+Do2iWVGQYerOs18ZfQg7mcRGKXJaVSlGJvVVAP?=
 =?us-ascii?Q?t81V8jFLsd70jhXLjZYrFoWpesYLAEjKYtDevhh2cScNukHk6u8JAm6wHKeH?=
 =?us-ascii?Q?TTWaxa3aRHkzbuKk22EAfcYZi+3c7h2PmPfCpOXvnAcfTtfs6DMAx98WOWiY?=
 =?us-ascii?Q?V/3vaUr0eHrS+3wtHj6uYYoKlvWEcbJ6qvQ0Ug7Ww4o172rS2Ly0RyYEDrbj?=
 =?us-ascii?Q?OSgVLsSc3d1MD0zJvFHGf3VFYv1Ycu7rHha4dOK8YNvhk24CHQeP7nBpZkFD?=
 =?us-ascii?Q?C227HDY2WkEbUFE2WOaknbfhMPI9G4rzXJJe7yJHwx8vgTBMkSpqR9DEytSh?=
 =?us-ascii?Q?MjWtGwpN+c88gkj2IyN0BWfSz+hYW64Rcg6ylnGy87LaN46dDX/QdXSfMuhp?=
 =?us-ascii?Q?LMYTjnLsueeMlNNBj09JIZ6NQyNxeXnsYLw8yFLLdv2wgFROMUV7MXdy4hgu?=
 =?us-ascii?Q?H/O7Fv6BUjD4awk1nGvZkTbftg6cWnIZ0QDuPpN3KJjk+2M9Zz0GPF4PnTRS?=
 =?us-ascii?Q?hat/JYdhysx2b6mW5voM37H0sbzytWcsZyXEJXOctVAYoCog11G/8dYPoYCq?=
 =?us-ascii?Q?YC5GRqJMdRkwZFwUYUL5Bz+Qw1yE+XnE76zTSwGfTNtNFK8SbRZwbY9jxdIi?=
 =?us-ascii?Q?f+0To6gupnU93P9l2qfOUJctEV4nRdWQSTBAVr3xVYX6min93Gka2569EovW?=
 =?us-ascii?Q?1Ii1GhMOb+5lyLl6SBf0/eyjxs2KXsJ7fCrTAMYnVMfmqsXy4Uvl599PHfj/?=
 =?us-ascii?Q?OFLW5383X1ABNym6guERnkFQnPnZcS60G11SxgR8o3s8Vf5ohv/d3dI+8PQu?=
 =?us-ascii?Q?hrDTpcU6KJw6AZ114oE4inplnNjMZ8UXBWQS24Q8xGNPpKucH/ayX6doetxU?=
 =?us-ascii?Q?aKwaLDGm8DdvbM+yjKRQBQvRAyJzcVxVVsH4bS3cZkCUcjrC06TL9Xd3PYcp?=
 =?us-ascii?Q?Kx/+xRhIpA6T8nM7OWBVmVYt?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24043296-5622-4af4-e79b-08d8dc4f990c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:10.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFzXbVyQFLl3P/q6Ddg5zzMMR3UfV+1oReFG5Mv3eFOs8dt/l5bkyiE9dxvQNNPLTDN0r/JiQSTsQLYFnbXXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 38fb396..cdb8e0c 100644
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
@@ -455,6 +447,17 @@ static bool __init hv_init_tsc_clocksource(void)
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

