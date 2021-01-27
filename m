Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749430652C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhA0U3h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:29:37 -0500
Received: from mail-bn7nam10on2133.outbound.protection.outlook.com ([40.107.92.133]:47904
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233026AbhA0U2W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:28:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyWnweMZJNBCvkiVfCdnjsKHGJmi5td8ldbyCrVT+SmjZT45oFJnbGvIaitMU17wDXAak9vrxla7v0ALp5Z7ItNPK6qjlec3LC3TMVQj1Kl0vbAr63W8Tj8c+Vd2n78Swa2cduWFaLU0aAT3SIAiIcYaRr/dap3eohSBVEGA1asMEmpwu6d75dD2chjQYW/NYlAROqCWNoaugzr0+kulii0RLVzS/09nYaWPWIDZ/J7ZAU9GHZvcOro59GHiitDpbR8S/AYfhnKy+xbmepc8PrSzjBbvYpC4sW59TNsNF6QpBJtG99zVQ4vR/O21jUOYFpH+e2567ftRYb6bwT6CYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SirG2QCuH8PnyTR0ShYBpspVaAqsGE+ZbGU6d0schas=;
 b=LBgBVMS+4nkFCRY0xJ79mM8Dd2uXcHMl3a0L76zOqoT1bYapuVtKjdLop/Dn6wm/jDDPqIDkQzKoT+PXcnylADKwLdQzndHH2LXvYNY8yFi9fWl45971wxTS1cO01oyrawh00ouzCsIGKhjYjhSY9hNdXFHTbudxFlfs7N8Y054tDA8VQbFGjsuVyPQktftGl3yEGTyHPvQfkh7xir0ZMEtmFCGhnxjWcqoZzTDUoOVgA0PbcEJNyx4tPgjdVZURnmdq+6M8I1dVBNWXi/qFKRggKb3t8zqP+6tBjCG0TAGcKVqeRww7b2LFnQ0YTR9wHSn41jiX9RysCMUkYwU+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SirG2QCuH8PnyTR0ShYBpspVaAqsGE+ZbGU6d0schas=;
 b=OMhBII3ZWRzuIOnL4dlGVRDpwbk9ar5tf4aRny7cv1heJNeJArs13O1VFVN5JmskE3Rj4/IeLtulGfTVFw06kw+lOT530TrevQWXhb/IvJlaS/CUS5U5XnMWzbY0kC9Ng7hwfR4mvpbd0fcnj9bQ0BrBpDKr4JZk0nCSLPE5K+Y=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:32 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts
Date:   Wed, 27 Jan 2021 12:23:45 -0800
Message-Id: <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a765bd70-5521-4d2b-d396-08d8c3018e65
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215114C617B877E4E8A582AD7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rA41l/7rVso6R8R/y+8MLKfiaZBeHT3s9D4Uki1vsLydkpEH+H3UlQna1NPzxEAoViePdxtd4M4GBeo3HQvlHPO3QHD4hyT9jXxMOvBz8kofIXUdJVCcrXCebQDSonwjIm9t+NO/BVTfO+NSzBOVnkUzHUMeIUnrBdueoWD1qwnmH8YnS+CK2hh2YiDa/e1EOnI7FcFsCyl7s38Ev+eGJuQRqApukoKPrlGbkxinCKgZyh3fc9fFYAPUH7UXRlzdeOstp0CMZqyHmUhiP32L28zN6PtryUGrVvEANLNDhJIIQl21ZOz+lBbj0A7c8pDzWOUANGwZD2bc03tahbMHnbW4ZEsZNBSHR8lgsn2pa89CRzE7u4fvYYBeju1+bFoo2YYe3h9ltsFEfvFYg9ya2qV3Rez5aeRJaS32zvnlI6B+5Z//KPzOmODHQQgIvOpBnWpUrtxm0WfNmXOIMTzGVjOhjgUJmk/gM+K89RIA//Omvxpcl886JqqwUVbFRT5r4BlNlEam1QPWpOBxL7YFSFmHkmCNyMNeQ8ZcTx/A95tlyQlRD1b/KK1RC7Nj3h5L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(30864003)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XGur0lHBxd0aY6YXwMqrsqZwnZUdmNVQpB7GFXtMKmu+O2IrHEpRVwU12efa?=
 =?us-ascii?Q?Ls2nLPOZK6PfrJT95YES2wUqfpJMLAaLNica9gzhGGEnDM6CoBaWHD8IPlQT?=
 =?us-ascii?Q?NelP3+Hes9tFytCiimHgSSiyiO1VAXWbqvsxcF9WIizAOtEK7Vs6PbZpGQgJ?=
 =?us-ascii?Q?L019q1im90xkW65ZBt1SWUunxzQEQOFH0snUeSHdr/nRePC4lv9d0Yt16mal?=
 =?us-ascii?Q?dVpnHkyUVY0+i49GJf187LOHKsmUtKArlB38EWWrbJAuX4I6q2//0BUdoJug?=
 =?us-ascii?Q?ybKi51VlNgF2HMhUBj+vSOaFBgV3AiWA7BYpPEnTX9QHT9+najsfjLSciCKX?=
 =?us-ascii?Q?CdL3jiZLWpKEOuhwGb+7Z1nj6/Qrq8S6XYCdhSbfE1a9bW2z/g/xmKOj3yDo?=
 =?us-ascii?Q?pVpQczZ3mpVujc0+HAUHMv89YQbgHRf+JNuN9oCTjpS4P8BFJFU1xVqfSZNG?=
 =?us-ascii?Q?kc0iVPuewCWxZCsF/m9/0kGo+mGY7SjNZpWfko7Dv88Z3aDtFYfZg+kFdg+2?=
 =?us-ascii?Q?KJ5hjrHSsC2R4PFfOkSBUG5zQqs3BGDzMP+BX87WE1rJWibFgSSpQi4F9E7w?=
 =?us-ascii?Q?wQlCOcrebmWqhE2h3vGDDCvvbiPElrjXSs1aMoQkzAy3YyejZtQ8aTqso5ys?=
 =?us-ascii?Q?IGX/SjBs5jwFJJncYgxpZJ/e3rdVDPKNfKjIwYURyeWaxeKAb8Ej8A/c2z9U?=
 =?us-ascii?Q?xYRNM2PP9zZPJNEFOBWWXZc0GC8xV+YJmL8HwosH7zl2RgTSzeK10/LLxqXH?=
 =?us-ascii?Q?mpXnQRBFkAjV/iuryLdGfVXtpPctn+/RYPxXBD4/kYRn+EVUZv5D+R4w27P+?=
 =?us-ascii?Q?G6eWa2vrY3/xRYez2sVZZAVO8shI3g0fFggcnHNZ1YKDW5G1QVZMgn0SXznX?=
 =?us-ascii?Q?VDA9goMkEcfvh3ZfIV95nKRS7TSfESPhIQ8CmySMwdzbCnP7v/u75GbQLQxK?=
 =?us-ascii?Q?ogYzoahyAp3cYJLxTCEF8ZvpLS+PFAsCY8tZxUua/l+ph8s9qSdUTuceLt/W?=
 =?us-ascii?Q?xIf950Emskay1Mpb+XueeV3ch4AnssbktwH0h3pBS7KgroTW9FfU3LNmt51t?=
 =?us-ascii?Q?rHsR0nJ/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a765bd70-5521-4d2b-d396-08d8c3018e65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:32.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gAZgkUQbjmdXxHyZue/X8wJPpMPe6UO6GpKJNIviSDj+P8ZJhhv3K74X7S9p2cMSl6/h/4XRrcFiKAgqCFftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

STIMER0 interrupts are most naturally modeled as per-cpu IRQs. But
because x86/x64 doesn't have per-cpu IRQs, the core STIMER0 interrupt
handling machinery is done in code under arch/x86 and Linux IRQs are
not used. Adding support for ARM64 means adding equivalent code
using per-cpu IRQs under arch/arm64.

A better model is to treat per-cpu IRQs as the normal path (which it is
for modern architectures), and the x86/x64 path as the exception. Do this
by incorporating standard Linux per-cpu IRQ allocation into the main
SITMER0 driver code, and bypass it in the x86/x64 exception case. For
x86/x64, special case code is retained under arch/x86, but no STIMER0
interrupt handling code is needed under arch/arm64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |   2 +-
 arch/x86/include/asm/mshyperv.h    |   4 -
 arch/x86/kernel/cpu/mshyperv.c     |  10 +--
 drivers/clocksource/hyperv_timer.c | 170 +++++++++++++++++++++++++------------
 include/asm-generic/mshyperv.h     |   5 --
 include/clocksource/hyperv_timer.h |   3 +-
 6 files changed, 123 insertions(+), 71 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 22e9557..fe37546 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -371,7 +371,7 @@ void __init hyperv_init(void)
 	 * Ignore any errors in setting up stimer clockevents
 	 * as we can run with the LAPIC timer as a fallback.
 	 */
-	(void)hv_stimer_alloc();
+	(void)hv_stimer_alloc(false);
 
 	hv_apic_init();
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5ccbba8..941dd55 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -31,10 +31,6 @@ static inline u64 hv_get_register(unsigned int reg)
 
 void hyperv_vector_handler(struct pt_regs *regs);
 
-static inline void hv_enable_stimer0_percpu_irq(int irq) {}
-static inline void hv_disable_stimer0_percpu_irq(int irq) {}
-
-
 #if IS_ENABLED(CONFIG_HYPERV)
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5679100a1..440507e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -85,21 +85,17 @@ void hv_remove_vmbus_handler(void)
 	set_irq_regs(old_regs);
 }
 
-int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+/* For x86/x64, override weak placeholders in hyperv_timer.c */
+void hv_setup_stimer0_handler(void (*handler)(void))
 {
-	*vector = HYPERV_STIMER0_VECTOR;
-	*irq = -1;   /* Unused on x86/x64 */
 	hv_stimer0_handler = handler;
-	return 0;
 }
-EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
 
-void hv_remove_stimer0_irq(int irq)
+void hv_remove_stimer0_handler(void)
 {
 	/* We have no way to deallocate the interrupt gate */
 	hv_stimer0_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
 
 void hv_setup_kexec_handler(void (*handler)(void))
 {
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index edf2d43..c553b8c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -18,6 +18,9 @@
 #include <linux/sched_clock.h>
 #include <linux/mm.h>
 #include <linux/cpuhotplug.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/acpi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -43,14 +46,13 @@
  */
 static bool direct_mode_enabled;
 
-static int stimer0_irq;
-static int stimer0_vector;
+static int stimer0_irq = -1;
+static long __percpu *stimer0_evt;
 static int stimer0_message_sint;
 
 /*
- * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
- * does not use VMbus or any VMbus messages, so process here and not
- * in the VMbus driver code.
+ * Common code for stimer0 interrupts coming via Direct Mode or
+ * as a VMbus message.
  */
 void hv_stimer0_isr(void)
 {
@@ -61,6 +63,16 @@ void hv_stimer0_isr(void)
 }
 EXPORT_SYMBOL_GPL(hv_stimer0_isr);
 
+/*
+ * stimer0 interrupt handler for architectures that support
+ * per-cpu interrupts, which also implies Direct Mode.
+ */
+static irqreturn_t hv_stimer0_percpu_isr(int irq, void *dev_id)
+{
+	hv_stimer0_isr();
+	return IRQ_HANDLED;
+}
+
 static int hv_ce_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
@@ -76,8 +88,8 @@ static int hv_ce_shutdown(struct clock_event_device *evt)
 {
 	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
 	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
-	if (direct_mode_enabled)
-		hv_disable_stimer0_percpu_irq(stimer0_irq);
+	if (direct_mode_enabled && stimer0_irq >= 0)
+		disable_percpu_irq(stimer0_irq);
 
 	return 0;
 }
@@ -95,8 +107,9 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		 * on the specified hardware vector/IRQ.
 		 */
 		timer_cfg.direct_mode = 1;
-		timer_cfg.apic_vector = stimer0_vector;
-		hv_enable_stimer0_percpu_irq(stimer0_irq);
+		timer_cfg.apic_vector = HYPERV_STIMER0_VECTOR;
+		if (stimer0_irq >= 0)
+			enable_percpu_irq(stimer0_irq, IRQ_TYPE_NONE);
 	} else {
 		/*
 		 * When it expires, the timer will generate a VMbus message,
@@ -169,10 +182,67 @@ int hv_stimer_cleanup(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
 
+/*
+ * These placeholders are overridden by arch specific code on
+ * architectures that need special setup of the stimer0 IRQ because
+ * they don't support per-cpu IRQs (such as x86/x64).
+ */
+void __weak hv_setup_stimer0_handler(void (*handler)(void))
+{
+};
+
+void __weak hv_remove_stimer0_handler(void)
+{
+};
+
+static int hv_setup_stimer0_irq(void)
+{
+	int ret;
+
+	ret = acpi_register_gsi(NULL, HYPERV_STIMER0_VECTOR,
+			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (ret < 0) {
+		pr_err("Can't register Hyper-V stimer0 GSI. Error %d", ret);
+		return ret;
+	}
+	stimer0_irq = ret;
+
+	stimer0_evt = alloc_percpu(long);
+	if (!stimer0_evt) {
+		ret = -ENOMEM;
+		goto unregister_gsi;
+	}
+	ret = request_percpu_irq(stimer0_irq, hv_stimer0_percpu_isr,
+		"Hyper-V stimer0", stimer0_evt);
+	if (ret) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			stimer0_irq, ret);
+		goto free_stimer0_evt;
+	}
+	return ret;
+
+free_stimer0_evt:
+	free_percpu(stimer0_evt);
+unregister_gsi:
+	acpi_unregister_gsi(stimer0_irq);
+	stimer0_irq = -1;
+	return ret;
+}
+
+static void hv_remove_stimer0_irq(void)
+{
+	if (stimer0_irq != -1) {
+		free_percpu_irq(stimer0_irq, stimer0_evt);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(stimer0_irq);
+		stimer0_irq = -1;
+	}
+}
+
 /* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
-int hv_stimer_alloc(void)
+int hv_stimer_alloc(bool have_percpu_irqs)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Synthetic timers are always available except on old versions of
@@ -188,29 +258,37 @@ int hv_stimer_alloc(void)
 
 	direct_mode_enabled = ms_hyperv.misc_features &
 			HV_STIMER_DIRECT_MODE_AVAILABLE;
-	if (direct_mode_enabled) {
-		ret = hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
-				hv_stimer0_isr);
+
+	/*
+	 * If Direct Mode isn't enabled, the remainder of the initialization
+	 * is done later by hv_stimer_legacy_init()
+	 */
+	if (!direct_mode_enabled)
+		return 0;
+
+	if (have_percpu_irqs) {
+		ret = hv_setup_stimer0_irq();
 		if (ret)
-			goto free_percpu;
+			goto free_clock_event;
+	} else {
+		hv_setup_stimer0_handler(hv_stimer0_isr);
+	}
 
-		/*
-		 * Since we are in Direct Mode, stimer initialization
-		 * can be done now with a CPUHP value in the same range
-		 * as other clockevent devices.
-		 */
-		ret = cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
-				"clockevents/hyperv/stimer:starting",
-				hv_stimer_init, hv_stimer_cleanup);
-		if (ret < 0)
-			goto free_stimer0_irq;
+	/*
+	 * Since we are in Direct Mode, stimer initialization
+	 * can be done now with a CPUHP value in the same range
+	 * as other clockevent devices.
+	 */
+	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
+			"clockevents/hyperv/stimer:starting",
+			hv_stimer_init, hv_stimer_cleanup);
+	if (ret < 0) {
+		hv_remove_stimer0_irq();
+		goto free_clock_event;
 	}
 	return ret;
 
-free_stimer0_irq:
-	hv_remove_stimer0_irq(stimer0_irq);
-	stimer0_irq = 0;
-free_percpu:
+free_clock_event:
 	free_percpu(hv_clock_event);
 	hv_clock_event = NULL;
 	return ret;
@@ -254,23 +332,6 @@ void hv_stimer_legacy_cleanup(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(hv_stimer_legacy_cleanup);
 
-
-/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
-void hv_stimer_free(void)
-{
-	if (!hv_clock_event)
-		return;
-
-	if (direct_mode_enabled) {
-		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
-		hv_remove_stimer0_irq(stimer0_irq);
-		stimer0_irq = 0;
-	}
-	free_percpu(hv_clock_event);
-	hv_clock_event = NULL;
-}
-EXPORT_SYMBOL_GPL(hv_stimer_free);
-
 /*
  * Do a global cleanup of clockevents for the cases of kexec and
  * vmbus exit
@@ -287,12 +348,17 @@ void hv_stimer_global_cleanup(void)
 		hv_stimer_legacy_cleanup(cpu);
 	}
 
-	/*
-	 * If Direct Mode is enabled, the cpuhp teardown callback
-	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
-	 * stimers.
-	 */
-	hv_stimer_free();
+	if (!hv_clock_event)
+		return;
+
+	if (direct_mode_enabled) {
+		cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
+		hv_remove_stimer0_irq();
+		stimer0_irq = -1;
+	}
+	free_percpu(hv_clock_event);
+	hv_clock_event = NULL;
+
 }
 EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9f4089b..c271870 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -178,9 +178,4 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 static inline void hyperv_cleanup(void) {}
 #endif /* CONFIG_HYPERV */
 
-#if IS_ENABLED(CONFIG_HYPERV)
-extern int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void));
-extern void hv_remove_stimer0_irq(int irq);
-#endif
-
 #endif
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 34eef083..b6774aa 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -21,8 +21,7 @@
 #define HV_MIN_DELTA_TICKS 1
 
 /* Routines called by the VMbus driver */
-extern int hv_stimer_alloc(void);
-extern void hv_stimer_free(void);
+extern int hv_stimer_alloc(bool have_percpu_irqs);
 extern int hv_stimer_cleanup(unsigned int cpu);
 extern void hv_stimer_legacy_init(unsigned int cpu, int sint);
 extern void hv_stimer_legacy_cleanup(unsigned int cpu);
-- 
1.8.3.1

