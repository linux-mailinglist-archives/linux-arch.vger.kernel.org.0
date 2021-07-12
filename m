Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C827B3C41C7
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 05:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhGLD3F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jul 2021 23:29:05 -0400
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:5176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232852AbhGLD3E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jul 2021 23:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjia21heboljaekphWVtAVXPS52ZukkkFNTTbd5x3EZDyw2EghlDdG5CeI8pGwEzRRElrB9Q6M3A7Uz1CeAjWJcVNRjOkBCO9ULwt3kYysxXDVv4EO0iOvQP7MxBBFYQbEGQ1UwZPK7drZRmQuvRPtRhBzlF0AfXw6ToEuPxrZFsR8g2qW80ZEwY+L2tpo/ccFIUsTCdIQGoW1CR9TSreg6gmzcXNQ420vf1fEG0OlVLuG2b617PD0p//p/RVtgmlAK4rmaw3Sq6ZPZ9OJ9JrzxeXYNfKLSa7lcdP3ncUd9kPSYttq0naHpnFuvFHtW9fIkekqguCyjeHFXb79T9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMzVogFAhikbVy6WcmcRZEwpKIwVmpIlUDIZ+s2UAQQ=;
 b=YMlOC6Qh+7EkJjcmLXPn92/QcDHb1cZ6qJvnhBCmMWrPFNny5Vk1AsaD2Jw7DULw0Zd0hn8Wxdc6RPsRJTZsS95pbw/RX4NXIIbdQ1yNJdhYC6/IvAQZYZrnqzU83TBbzlXcCL+HJUAGraMYnFxhtPuGe0PYpw7zbyYWhw5FhKDwmdN3cUeCr/cXqca224VxCzHNBTulEBtwsW+45zho0orUwmqRwt6ENbBsCvnNPR4UU9vRPntQjwbEsU8jLby67tHb8DKQv8nIK9m8BzBO52V/gQn0p6dLWoFfatR4jaqV9f8s2P1Qqh7DiJRyLu5zThE1Q5lpCVFoJ1GRdaK2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMzVogFAhikbVy6WcmcRZEwpKIwVmpIlUDIZ+s2UAQQ=;
 b=UUCVl0H1/xuJ+Fe3ciwV0BzMITAmNfJpUK4aePDDn//qxk9ezVXGF09rSEICfUgB14z8kKGgff1xCRCQW5o5DgOl83eBe7SGZsyhmRUfHgykFX/koBczn+46xzdfuEUZRVopoFpXmWmfwnbhUR3Tb8DTfPa7+C6gIe5Rlza1Q/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1402.namprd21.prod.outlook.com (2603:10b6:5:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Mon, 12 Jul
 2021 03:26:13 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%7]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 03:26:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] Drivers: hv: Make portions of Hyper-V init code be arch neutral
Date:   Sun, 11 Jul 2021 20:25:14 -0700
Message-Id: <1626060316-2398-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.16) by MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Mon, 12 Jul 2021 03:26:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94658996-aea7-4148-08d3-08d944e4ccfe
X-MS-TrafficTypeDiagnostic: DM6PR21MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB14021208EE403EB6A734BDF2D7159@DM6PR21MB1402.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwusN9KliYVOfrytakIEjZB7oIBtse/DwxAgNj9p2gG8EaEQxycUsRc+VOzXe3fvYi296zay1ut2Qa5fAL3yu0tSRpyoeE02GPzTuP2wqJ+iAd87ARB9lEg7PI6wi/I4oZ+/reYxdl4youUnDO7UerbmILjZ2SDxpwgLraXThzmN93vkJQi5i0AsRLeQVc3HFhy7Ds9G5yl8M5gpDN7BT5GEERjL2uwAPJv0UYyGjRX/qgZ99MFvXoMF1dPTpKwXjsXKjxAQcH1N6xt2bu3uofy1GW2OJHvD1U94v9Sclz3/bw1W/rsR3P/RlIPQs+Wl90wqV9LoSpSwDPisiTjGFmrluRSDNvYosgqB1GDnOpykiCilODqgPB9HGa1OZq5QGn6VGOLGTHIxOAatjz9Rjm6TrgXqGYF2X3R1S+3XTPBaOA3Isz0k5b3c5jW7lem8BNmvUYqH6p7yw6AeoRAbHXG4I+C09Uf1G65HDs3Rx/AYy5fBQMmgqpYhiQdYhQFKfFdJ/0oCWlVLu8GrJZWZxU5yStcF+R7VDezVwssMOeEXij2du2FHiqxjjJkF2pvuRvGr2TS6XqcHdtSGjiaprxsi31VEu1aR2uY5MKkE4MOKJ0VFUvDHPCEA1YF8wlj/07sE94bc6VRDIgND+A9kG+EaHF5PbAmATLzM55SMnqjuE2ZTS9vUqrIXYfNNps/ylHN6g5MHfarkk4yaTtb3q53/JCMgP+dzPFbIelbin6xVKHpS7gYSDj8R3rH7VoU6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(8936002)(7696005)(66946007)(2616005)(316002)(186003)(38100700002)(26005)(36756003)(38350700002)(83380400001)(478600001)(52116002)(8676002)(86362001)(7416002)(6486002)(66556008)(4326008)(82960400001)(82950400001)(921005)(30864003)(5660300002)(66476007)(2906002)(10290500003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfYRhNEmNz3tDbLPX8EmVwntZ7Vi/cJ3fyNgSIwcdtIWG8xNcUd9PYmU/bcM?=
 =?us-ascii?Q?8dZglbBoJ2zSSl97i5wZardWtiyhWeTBrWe7nlLCUj5pe2XGz/ALXlUF2fPD?=
 =?us-ascii?Q?t9iKnU9L171qEPIDA0jwuIz+3+jFj3LxyI9NiHXD2466P+yHC8eiqHTXC7WP?=
 =?us-ascii?Q?0DmizywJxuVYToSvhUCiy8T9/ExtWkF0OVrUgSbyaXpzdb0/5OyR6gWptHPu?=
 =?us-ascii?Q?6lBxJwQGxmZShtEcb4uFcnGk5rePzM6tZ8DMGsOFB03kUBWZOYU7y6hqkSNA?=
 =?us-ascii?Q?UuvNXMslxfT3gh8RA/XrVxofq7oA5SStT2ajpGMyhvdr5LMphWGlrk7RK3Vp?=
 =?us-ascii?Q?CrG3cfXZQ0lfW1jWwJFO7gIXdxCJ2CifAbqMVuRu/Xl6ngTeHgj4mEWDf9Vk?=
 =?us-ascii?Q?k5C8/DBWfjughscsykbTY1T5Rt4451QJqyosoRxR60b6LFyN6lK3sP9Krn7O?=
 =?us-ascii?Q?dbx8G2pAwqAfiYfU5XcLIaBxJuO5DLjURPhYYRqGGSahv2JDJ8eJ+TnvChzk?=
 =?us-ascii?Q?kl6xftKx7HCCVX6mXIjIQuhFpy7kdg82HXSlCq5XSOknOVfv15OQDXcP+y+F?=
 =?us-ascii?Q?tJMFexvT5SA4LbXZnjAMbQ6Y5UsKnVEOFa9kKkK0t9Wq33MhRN9Fm3Y85Dy8?=
 =?us-ascii?Q?s+NGO/9xxSUc2lsbFCMuhSa9SLEepAzGXEXTcX9ZXfjDD9flDcdmtVwhB30t?=
 =?us-ascii?Q?7ZUZdSoQyRm155MyCEuxqWNszuXUHVhHrRr3TyuN30ZG83/m8APq6urwuJvn?=
 =?us-ascii?Q?BSg6YYHZjn+4ppEX88Kh0R4q5HRlNaj9ZUG8Fl1BMqvQQ9OX23sOdLVFK3YE?=
 =?us-ascii?Q?/CVdP0rRuULboIMaQeqQXSi8fF4MwMEQx8tLChLHuAk/diLwuMPLpQRRPcIi?=
 =?us-ascii?Q?cOmNGVzUgOP4owXNOqXGOf/tEToFbh+JiqH7XrNxlY5fdy1Io5vWEQvEfB9q?=
 =?us-ascii?Q?8Uxx/z0FLOSnQlqhDN7bInD/pIHAsTevnMjJ+NKRmUzRPvjMpkyDCHLnvamd?=
 =?us-ascii?Q?F1QWsrgJETNO7Wd+HKBOoguMzUc6SXaDnMBvXpIxO5tX+HH2MTVke9c5nH8d?=
 =?us-ascii?Q?E4LT/dSwxQZbVxE5nl7AVguJtPiW0MmAQbteTMQZ8ZRJYjQWdbKk135Jm/7I?=
 =?us-ascii?Q?mJ+ILumPX8HmLRzzTkOahNj7cz4s1X1/reisSde27IwS9NDj0UQpCGw7imst?=
 =?us-ascii?Q?dvCh0ZwkW4a1NMYqtIlB4Igyyj1DJysfxYNQhMWQZHVLt7myuDuFN7eBRLPq?=
 =?us-ascii?Q?iAPKQikfDZV3JGa07vL/AXjn7EvCYxdVm1EGCrVsu3QLoeftOo0LzTV0HHiW?=
 =?us-ascii?Q?LQ3zHNzfSqMYvGL/1FSJxL2A?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94658996-aea7-4148-08d3-08d944e4ccfe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 03:26:13.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LMjyT/IYmQ4OXeGEPfTbwZ+78ycAp9rqZjDvgv+YkPZFYaNl/G8/2J8ippqbUEfQacourVd1PE3GUQkm3txqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1402
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code to allocate and initialize the hv_vp_index array is
architecture neutral. Similarly, the code to allocate and
populate the hypercall input and output arg pages is architecture
neutral.  Move both sets of code out from arch/x86 and into
utility functions in drivers/hv/hv_common.c that can be shared
by Hyper-V initialization on ARM64.

No functional changes. However, the allocation of the hypercall
input and output arg pages is done differently so that the
size is always the Hyper-V page size, even if not the same as
the guest page size (such as with ARM64's 64K page size).

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  91 +++-------------------------
 arch/x86/include/asm/mshyperv.h |   4 --
 arch/x86/kernel/cpu/mshyperv.c  |   7 ---
 drivers/hv/hv_common.c          | 131 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  10 +++
 5 files changed, 151 insertions(+), 92 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6952e21..5cc0c0f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -39,48 +39,17 @@
 /* Storage to save the hypercall page temporarily for hibernation */
 static void *hv_hypercall_pg_saved;
 
-u32 *hv_vp_index;
-EXPORT_SYMBOL_GPL(hv_vp_index);
-
 struct hv_vp_assist_page **hv_vp_assist_page;
 EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
-void  __percpu **hyperv_pcpu_input_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
-
-void  __percpu **hyperv_pcpu_output_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
-
-u32 hv_max_vp_index;
-EXPORT_SYMBOL_GPL(hv_max_vp_index);
-
 static int hv_cpu_init(unsigned int cpu)
 {
-	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
-	void **input_arg;
-	struct page *pg;
-
-	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
-	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
-	if (unlikely(!pg))
-		return -ENOMEM;
-
-	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(pg);
-	if (hv_root_partition) {
-		void **output_arg;
-
-		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*output_arg = page_address(pg + 1);
-	}
-
-	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
-
-	hv_vp_index[smp_processor_id()] = msr_vp_index;
+	int ret;
 
-	if (msr_vp_index > hv_max_vp_index)
-		hv_max_vp_index = msr_vp_index;
+	ret = hv_common_cpu_init(cpu);
+	if (ret)
+		return ret;
 
 	if (!hv_vp_assist_page)
 		return 0;
@@ -198,25 +167,8 @@ static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
-	unsigned long flags;
-	void **input_arg;
-	void *pg;
 
-	local_irq_save(flags);
-	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	pg = *input_arg;
-	*input_arg = NULL;
-
-	if (hv_root_partition) {
-		void **output_arg;
-
-		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*output_arg = NULL;
-	}
-
-	local_irq_restore(flags);
-
-	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
+	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -368,7 +320,7 @@ void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
-	int cpuhp, i;
+	int cpuhp;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -380,36 +332,14 @@ void __init hyperv_init(void)
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
 
-	/*
-	 * Allocate the per-CPU state for the hypercall input arg.
-	 * If this allocation fails, we will not be able to setup
-	 * (per-CPU) hypercall input page and thus this failure is
-	 * fatal on Hyper-V.
-	 */
-	hyperv_pcpu_input_arg = alloc_percpu(void  *);
-
-	BUG_ON(hyperv_pcpu_input_arg == NULL);
-
-	/* Allocate the per-CPU state for output arg for root */
-	if (hv_root_partition) {
-		hyperv_pcpu_output_arg = alloc_percpu(void *);
-		BUG_ON(hyperv_pcpu_output_arg == NULL);
-	}
-
-	/* Allocate percpu VP index */
-	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
-				    GFP_KERNEL);
-	if (!hv_vp_index)
+	if (hv_common_init())
 		return;
 
-	for (i = 0; i < num_possible_cpus(); i++)
-		hv_vp_index[i] = VP_INVAL;
-
 	hv_vp_assist_page = kcalloc(num_possible_cpus(),
 				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
 	if (!hv_vp_assist_page) {
 		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-		goto free_vp_index;
+		goto common_free;
 	}
 
 	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
@@ -507,9 +437,8 @@ void __init hyperv_init(void)
 free_vp_assist_page:
 	kfree(hv_vp_assist_page);
 	hv_vp_assist_page = NULL;
-free_vp_index:
-	kfree(hv_vp_index);
-	hv_vp_index = NULL;
+common_free:
+	hv_common_free();
 }
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 67ff0d6..adccbc20 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -36,8 +36,6 @@ static inline u64 hv_get_register(unsigned int reg)
 extern int hyperv_init_cpuhp;
 
 extern void *hv_hypercall_pg;
-extern void  __percpu  **hyperv_pcpu_input_arg;
-extern void  __percpu  **hyperv_pcpu_output_arg;
 
 extern u64 hv_current_partition_id;
 
@@ -170,8 +168,6 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 
-extern bool hv_root_partition;
-
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index cc8f177..9bcf417 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -34,13 +34,6 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
 
-/* Is Linux running as the root partition? */
-bool hv_root_partition;
-EXPORT_SYMBOL_GPL(hv_root_partition);
-
-struct ms_hyperv_info ms_hyperv;
-EXPORT_SYMBOL_GPL(ms_hyperv);
-
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7f42da9..9305850 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -15,10 +15,141 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 
+/* Is Linux running as the root partition? */
+bool hv_root_partition;
+EXPORT_SYMBOL_GPL(hv_root_partition);
+
+struct ms_hyperv_info ms_hyperv;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+u32 *hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32 hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+void  __percpu **hyperv_pcpu_input_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
+
+void  __percpu **hyperv_pcpu_output_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
+
+/*
+ * Hyper-V specific initialization and shutdown code that is
+ * common across all architectures.  Called from architecture
+ * specific initialization functions.
+ */
+
+void __init hv_common_free(void)
+{
+	kfree(hv_vp_index);
+	hv_vp_index = NULL;
+
+	free_percpu(hyperv_pcpu_output_arg);
+	hyperv_pcpu_output_arg = NULL;
+
+	free_percpu(hyperv_pcpu_input_arg);
+	hyperv_pcpu_input_arg = NULL;
+}
+
+int __init hv_common_init(void)
+{
+	int i;
+
+	/*
+	 * Allocate the per-CPU state for the hypercall input arg.
+	 * If this allocation fails, we will not be able to setup
+	 * (per-CPU) hypercall input page and thus this failure is
+	 * fatal on Hyper-V.
+	 */
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+	BUG_ON(!hyperv_pcpu_input_arg);
+
+	/* Allocate the per-CPU state for output arg for root */
+	if (hv_root_partition) {
+		hyperv_pcpu_output_arg = alloc_percpu(void *);
+		BUG_ON(!hyperv_pcpu_output_arg);
+	}
+
+	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index) {
+		hv_common_free();
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	return 0;
+}
+
+/*
+ * Hyper-V specific initialization and die code for
+ * individual CPUs that is common across all architectures.
+ * Called by the CPU hotplug mechanism.
+ */
+
+int hv_common_cpu_init(unsigned int cpu)
+{
+	void **inputarg, **outputarg;
+	u64 msr_vp_index;
+	gfp_t flags;
+	int pgcount = hv_root_partition ? 2 : 1;
+
+	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
+	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
+
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+	if (!(*inputarg))
+		return -ENOMEM;
+
+	if (hv_root_partition) {
+		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+	}
+
+	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
+
+	hv_vp_index[cpu] = msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index = msr_vp_index;
+
+	return 0;
+}
+
+int hv_common_cpu_die(unsigned int cpu)
+{
+	unsigned long flags;
+	void **inputarg, **outputarg;
+	void *mem;
+
+	local_irq_save(flags);
+
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	mem = *inputarg;
+	*inputarg = NULL;
+
+	if (hv_root_partition) {
+		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*outputarg = NULL;
+	}
+
+	local_irq_restore(flags);
+
+	kfree(mem);
+
+	return 0;
+}
+
 /* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
 bool hv_query_ext_cap(u64 cap_query)
 {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba..2a187fe 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -38,6 +38,9 @@ struct ms_hyperv_info {
 };
 extern struct ms_hyperv_info ms_hyperv;
 
+extern void  __percpu  **hyperv_pcpu_input_arg;
+extern void  __percpu  **hyperv_pcpu_output_arg;
+
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 
@@ -151,6 +154,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 extern int vmbus_interrupt;
 extern int vmbus_irq;
 
+extern bool hv_root_partition;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
@@ -164,6 +169,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
+int __init hv_common_init(void);
+void __init hv_common_free(void);
+int hv_common_cpu_init(unsigned int cpu);
+int hv_common_cpu_die(unsigned int cpu);
+
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(unsigned long addr);
-- 
1.8.3.1

