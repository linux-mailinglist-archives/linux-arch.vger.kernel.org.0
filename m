Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88433306521
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhA0U1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:27:54 -0500
Received: from mail-bn7nam10on2119.outbound.protection.outlook.com ([40.107.92.119]:59360
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232839AbhA0U02 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:26:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eseMG1mhF1TH4YNJRYv8Pr/nTRZi6fj8RthgE0MtIx8yINaL9H6Iljs+FcsHgqXSlinI+GVpJfEjeH2QA0drmYtbEL8zeLjixUpWQOprMMdJEx4rBNEparjSynuJMO1CuV9E5SpulKJk1KpRwfuzpXG6J3Zb7lrp/Ji++VMRl6KAuBTUXmhKQuGToaHpa4aNpPLXBc2lV1sSeR5ztasd8V7uQN8hVaAColDkRIs+oiEu6ZyvM+gCw9OHf+30Ec6JygNXvxBt0fCnTWtLIMReZBgLBt9NUiIPjG8ffE9NnIIud6xdRELMcKq0SjSu6Yfp3aBuSO5dQxFbxJB4uSivog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHNvx65TNaHNTmJvXgCYt3WST8kj7CB5fpRisUa1MM=;
 b=f0n3JqLXPT32i3l1+F09VdVMfNxDuhItIpEq+vmwH1cjav35ApXHUxQ8VSIOfR864fqnFMmpZzAeW09glP+QyvzfFD8pb4UtG3GbK0hnN2+ciKybyCuclb8YQFmffMpag50k1CfhvbsMGIM6d58/g8Jvy4O50ZpMbOzQNLZpIYlJKsFZxU3t/NuHNPFVjJWNvkHFlsEZoOtMmZB8eOLSom//oWVQSMbQW8Ei4xchQJwhh8va9M5owtfKHYBQgMQvvOlymVUppoXh4R3EZG+h26gkmJwg2DhhtdWmXF+DmG1jBL1O9FbRN17tzCfJ0+8zcHzuQxQJKn1ZYCSCsQnX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgHNvx65TNaHNTmJvXgCYt3WST8kj7CB5fpRisUa1MM=;
 b=SSnTVR0026szMiETTpqJ3Gdz6mEIXiGYBMt2g+EB23uos/YONSJWj4Dlni8vGoQdAlfP8ZaWXo7jJxLVNzDQeJiampsJMzZUXdtYyd6426Gx0WOffxjSdeKHD/xDgb9mpRGZTx4u7fjIAkghl9kVHbodMm3oYd9h0dq5BfPjQRM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:26 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 06/10] Drivers: hv: vmbus: Move handling of VMbus interrupts
Date:   Wed, 27 Jan 2021 12:23:41 -0800
Message-Id: <1611779025-21503-7-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62df4985-6ffe-4af8-e6fe-08d8c3018aaf
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB12154D0B8959C3038BD1D40BD7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYwWaGori/2si8NJfipUmDnelUj6oV+knrSTDR/VVJqDiU0LWchC7Blp1Lp8Zyt8g+NdnUCjASFf6LXVVHMQmDlBk+yOEPCiHoq8yl8vOuEHN5aHn9/hluDm+WmlTYXbClCEXY9pFUp8bUhHOllU9FbdBKMuKcqbqht8schRHfNvZQCilSd9onA8tlYDUS2pciyomADNca0+ZKQFsREzK+viBC5TLs+a6R6O46egpEj9/YsS1U+MXZO0g2cqO4maHvXn4JCjcNmcmVaeUQb3TTKyFxnxIwMdNjoMj/AuC/7Xq8PWOLD/K86pu7KbUeYlRlTPKgFR+qNETfempi3R9Owz04yISQ59uhWirD88twb6IPqr0TKtn0b0meHqVtJBWOtPmbNpxkT9cae3cFqQaCHtOz4nrbxDtctiz3WE4henOBzvVCL0tUvEJl+pcMRE26al7yYPen/E9XK/KGkgP/jU+oinKUy2jk4hazcsPYsDLn1ryahIN4N/aQvrUwVULKoMy1AkO54GBikP70NATqHNsDs22Aesx/cZw6O0eMQuj3bVEdQf6AIbG8sXiFbY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AlF2gly0fJjNcsI3WYbzCh03QfYdJOy2SRq4ksOakdQp88BhtBejByizOV6l?=
 =?us-ascii?Q?/Age2/vfQ6908w587mWR7NsdZ/pafjq8z2ilIvyzlquTeS/vNSVzZbnHhwfz?=
 =?us-ascii?Q?A4psBT3+zAC25m7Fikc+X44ko0RZpPMvgLsn2MA20Zwtp4gGLe7W7i3fskqa?=
 =?us-ascii?Q?eHA/Z8Nnt4sJlhvFjnm6e7soYOm5zkYbU5lulwiJWjqwziS2KGRWE8iEDTdQ?=
 =?us-ascii?Q?vqR8a+c5tvQsYGbdSqx8dFAP+zCVGAyEJkr66YuCt69z31L54zytzM2ZemGQ?=
 =?us-ascii?Q?lRvo9AWUBH0UQe9AQrZhNl3Wjn7iGvJQwSzUK6IXO8p/HtQbIyZ30BPFP9LB?=
 =?us-ascii?Q?Ejo/dsiVJg7257IN1WJXYapOb/zTQ5XoZq7+jSfgyTKUTQqPIwsLX0e7ML7h?=
 =?us-ascii?Q?I75IuAJ0GJTPr/PbDKO81AkWcOqhAKMiXOO2Yh6Dex5Dtze19S+wqtgGQXbr?=
 =?us-ascii?Q?udwOcAsIxdQQ268HCLe7jIHJdhBBVTMZAqVQov3lm1U07Z6O+thsyBfc+pQZ?=
 =?us-ascii?Q?S+QgYig4AUup5xT9n6NW1t+gAZA3E7yC5FyXcbkNplIhneY1/Y1T1r+i249P?=
 =?us-ascii?Q?+zNGerOgLiabttK3sZri8bMr+BEStriotmnc6nfxEv53JGjF08l8KmuOTOGl?=
 =?us-ascii?Q?K48I9G++ysVJPJ5M8GMnjE1SP94Itp+Ucjv2390jydBujtOeSQft7NvCNjQO?=
 =?us-ascii?Q?mbnHAxZD7jjaX/yG9Q5AhAtNif/eTZ7E9FPeJN6bN5RWqOc0Enss7hYhNy8F?=
 =?us-ascii?Q?Cjly4Rr/vXad+3Oc1wwuoDfVXRwUV9Hy/R7zaTsIGroo7SfZ3hpeDmBt8J8z?=
 =?us-ascii?Q?CAAQizth9bSI+pZlcOaeYPJHkAK80+MJj0P7HNx1cjeJrQSG7mVTjtOMoqAb?=
 =?us-ascii?Q?EyXNDX/4z2lkGpBfPUiOjQXfhgCwD7ZeF++RQQcHaNLA+EJeSky79AIeg2qT?=
 =?us-ascii?Q?nNlmdEW9PgX5VJMVHRglIZuXwZIPs3Gl4BQRvDkbhDgznOjkcmKQowdaX67S?=
 =?us-ascii?Q?gxKNfczMAAOsGoaDroMWaKRwxTw1Q1I4I4rRmVvfneCRBVhTVenIVwU+tcJg?=
 =?us-ascii?Q?tZfiqbgE?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df4985-6ffe-4af8-e6fe-08d8c3018aaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:26.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmf/lEja6MOeFCMAlp8SsiRyXJYkU0f1hanrLmgfXy3slr/ZGXuswLozgX87OoN3aefYvvWOGzU/qEsUtqwrDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VMbus interrupts are most naturally modelled as per-cpu IRQs.  But
because x86/x64 doesn't have per-cpu IRQs, the core VMbus interrupt
handling machinery is done in code under arch/x86 and Linux IRQs are
not used.  Adding support for ARM64 means adding equivalent code
using per-cpu IRQs under arch/arm64.

A better model is to treat per-cpu IRQs as the normal path (which it is
for modern architectures), and the x86/x64 path as the exception.  Do this
by incorporating standard Linux per-cpu IRQ allocation into the main VMbus
driver, and bypassing it in the x86/x64 exception case. For x86/x64,
special case code is retained under arch/x86, but no VMbus interrupt
handling code is needed under arch/arm64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  1 -
 arch/x86/kernel/cpu/mshyperv.c  | 13 +++------
 drivers/hv/hv.c                 |  8 +++++-
 drivers/hv/vmbus_drv.c          | 63 ++++++++++++++++++++++++++++++++++++-----
 include/asm-generic/mshyperv.h  |  7 ++---
 5 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index d12a188..4d3e0c5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -32,7 +32,6 @@ static inline u64 hv_get_register(unsigned int reg)
 #define hv_enable_vdso_clocksource() \
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
-#define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
 
 /*
  * Reference to pv_ops must be inline so objtool
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f628e3dc..5679100a1 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -55,23 +55,18 @@
 	set_irq_regs(old_regs);
 }
 
-int hv_setup_vmbus_irq(int irq, void (*handler)(void))
+void hv_setup_vmbus_handler(void (*handler)(void))
 {
-	/*
-	 * The 'irq' argument is ignored on x86/x64 because a hard-coded
-	 * interrupt vector is used for Hyper-V interrupts.
-	 */
 	vmbus_handler = handler;
-	return 0;
 }
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
 
-void hv_remove_vmbus_irq(void)
+void hv_remove_vmbus_handler(void)
 {
 	/* We have no way to deallocate the interrupt gate */
 	vmbus_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
-EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
 /*
  * Routines to do per-architecture handling of stimer0
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index afe7a62..917b29e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -16,6 +16,7 @@
 #include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
+#include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -214,10 +215,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	if (vmbus_irq != -1)
+		enable_percpu_irq(vmbus_irq, 0);
 	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
 					VMBUS_MESSAGE_SINT);
 
-	shared_sint.vector = hv_get_vector();
+	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
 
 	/*
@@ -285,6 +288,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 0;
 	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+
+	if (vmbus_irq != -1)
+		disable_percpu_irq(vmbus_irq);
 }
 
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8affe68..62721a7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,8 +48,10 @@ struct vmbus_dynid {
 
 static void *hv_panic_page;
 
+static long __percpu *vmbus_evt;
+
 /* Values parsed from ACPI DSDT */
-static int vmbus_irq;
+int vmbus_irq;
 int vmbus_interrupt;
 
 /*
@@ -1354,7 +1356,13 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
-	add_interrupt_randomness(hv_get_vector(), 0);
+	add_interrupt_randomness(vmbus_interrupt, 0);
+}
+
+static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
+{
+	vmbus_isr();
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1469,9 +1477,28 @@ static int vmbus_bus_init(void)
 	if (ret)
 		return ret;
 
-	ret = hv_setup_vmbus_irq(vmbus_irq, vmbus_isr);
-	if (ret)
-		goto err_setup;
+	/*
+	 * VMbus interrupts are best modeled as per-cpu interrupts. If
+	 * on an architecture with support for per-cpu IRQs (e.g. ARM64),
+	 * allocate a per-cpu IRQ using standard Linux kernel functionality.
+	 * If not on such an architecture (e.g., x86/x64), then rely on
+	 * code in the arch-specific portion of the code tree to connect
+	 * the VMbus interrupt handler.
+	 */
+
+	if (vmbus_irq == -1) {
+		hv_setup_vmbus_handler(vmbus_isr);
+	} else {
+		vmbus_evt = alloc_percpu(long);
+		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
+				"Hyper-V VMbus", vmbus_evt);
+		if (ret) {
+			pr_err("Can't request Hyper-V VMbus IRQ %d, Err %d",
+					vmbus_irq, ret);
+			free_percpu(vmbus_evt);
+			goto err_setup;
+		}
+	}
 
 	ret = hv_synic_alloc();
 	if (ret)
@@ -1532,7 +1559,12 @@ static int vmbus_bus_init(void)
 err_cpuhp:
 	hv_synic_free();
 err_alloc:
-	hv_remove_vmbus_irq();
+	if (vmbus_irq == -1) {
+		hv_remove_vmbus_handler();
+	} else {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+	}
 err_setup:
 	bus_unregister(&hv_bus);
 	unregister_sysctl_table(hv_ctl_table_hdr);
@@ -2649,6 +2681,18 @@ static int __init hv_acpi_init(void)
 		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
+
+	/*
+	 * If we're on an architecture with a hardcoded hypervisor
+	 * vector (i.e. x86/x64), override the VMbus interrupt found
+	 * in the ACPI tables. Ensure vmbus_irq is not set since the
+	 * normal Linux IRQ mechanism is not used in this case.
+	 */
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+	vmbus_interrupt = HYPERVISOR_CALLBACK_VECTOR;
+	vmbus_irq = -1;
+#endif
+
 	hv_debug_init();
 
 	ret = vmbus_bus_init();
@@ -2679,7 +2723,12 @@ static void __exit vmbus_exit(void)
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
-	hv_remove_vmbus_irq();
+	if (vmbus_irq == -1) {
+		hv_remove_vmbus_handler();
+	} else {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+	}
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 6a8072f..9f4089b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -89,10 +89,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
-int hv_setup_vmbus_irq(int irq, void (*handler)(void));
-void hv_remove_vmbus_irq(void);
-void hv_enable_vmbus_irq(void);
-void hv_disable_vmbus_irq(void);
+void hv_setup_vmbus_handler(void (*handler)(void));
+void hv_remove_vmbus_handler(void);
 
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
@@ -100,6 +98,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_remove_crash_handler(void);
 
 extern int vmbus_interrupt;
+extern int vmbus_irq;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
-- 
1.8.3.1

