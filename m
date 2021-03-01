Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591163275CB
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhCABRi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhCABR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:17:26 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3227C06178A;
        Sun, 28 Feb 2021 17:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/1DDJu7U2ELMCjyvxmQw5djdBLyCqhBsQiP0RM/tlJxopBlp9+Lv+Ae4xx+a6UyV4Y2sotpjU3/q3yJ37BETY/dNp7Dqtl5L35BhglsvqkqPNUJw2AKF2ljbn2xSRKuDgvY5z2T+8RtrHyArpx1DdQ+VoyUQEzj21sgTCKlDI6jQTSU9U3zDtxSQEzVusxEaJjdGn5Cxy9DW+Qd4X4/aXbIA/fjW/YDsmJOM/PVEI7NyasizP+xqZy3acAlmTIxIPcUr8Ba4c2Rlv4cW1Ld0KxgYUHPDvry7yvD0ewgKEEY1SE6g2Oi8oOjU9VyslsX/KfE4cYG1LVeyEwz+/tOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVWuOBcTVaBZBm63L/Cp4uf1t+T4/yVdhkF8/xZPPlI=;
 b=GX7oIMbkJX4c3TCa7Tblyxn1MSx8j/Kl4a+wURU8xfVW0yrBGw8xHGtYUcrLEBfAsI5WI7wxIjhRN8v5Y4MAcG6rXnvxqYN1psBbxOfqA6+8vcWzbwX+MjN1bl2yIk/0aBaU9eabzhEXV6K2/ZR5uwspOYAv+IEvX8qNWHbttr7Jo9/51kTGsZWIMJ6e7+q2p+oApz+wimEulWBTIfRbDd4tVOIlaejti3XxLBO2GBfwIR+rRG0O8sO5BbLPWAqdWbR/J4UxbeECp3hYa9Naz0Ciw2mwNAzWeNbt8T9u0Bq/K/6U2VXbHL6OE7nWZn4Z0oHSZ/i4HgH3BMi+mJUIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVWuOBcTVaBZBm63L/Cp4uf1t+T4/yVdhkF8/xZPPlI=;
 b=CAu5883NE3msS518bJO2UuQcETjPFbiSBYPRcL7ujNC53OXT6DTZjfC14NTYCxgSfsATXZOE4AiPfDL/74hlaWLDjlvAYIhnQBN4FwdYdngrbvzwXsmeKL5ppcw0HlWPT3QP7pb+gUKn6/c1kjqglhArNvh//UcabpbHYF1wG28=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:07 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 06/10] Drivers: hv: vmbus: Move handling of VMbus interrupts
Date:   Sun, 28 Feb 2021 17:15:28 -0800
Message-Id: <1614561332-2523-7-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bafc9611-6948-457f-515e-08d8dc4f9737
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981446134D1AE18C828F05BD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAaVZ4b8rgwl4uKGpAX8YyU3cGdEs35rhYH6LYrJIonlzZpJFxF0uPf41QsHAqzsE7fg6h2gArlJjEwnzy/1CnL7khlLGAmy7Esa01yWGwFVk+fjJ5alyCDwP+32OaEZQSg83VDerUOY26os02AkwjZFMQtyfADf4viQlkem8cRlb5P7Mjc7y2mlqtIrK2Qdh5YLGNmHlU0KXYakjjjeOWT3pNW/om3Gm4IBnzw5AoUYc9HvlNanMAq6IBtAuKAXZQ418LmwjQc82DZDWzUqHGY3pVyPky5NbLtlmKededaYlfMc126jHS8ihd9R2c7zYhzlD1BbvR4gQM/G4pYIt3SprxbNBE4WLD9FAgC25mBUmP+Gnh8uHTOHi9pLbbFlabxK30t7yLnFeFsnqq+j8KghZqbkzMvM2yb+bDcH178Okbg0Hqdw68bf7Ak3e2b2vp6gf5ZyHB2/bxt2YJn2+kRs0P5itWUjvfTH+W7Fx8a73UozYGL+2afn0o17VezbO+tbPgnjpBojqC2MECk1o5fiyzxN1Se3UBDYv17QfJUacOaOFq/ShKEcqUOUo04w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T3l1OA74UihWs4fdbG552XNXAMhHxD6v0PhXbMi8zMq7/ItfW90viyX1uI3T?=
 =?us-ascii?Q?ZpdpZyUtDSWuKgd0mRjyYkh9ZXQi0XK37hAvI2muCcrpz5px2Tnpa5Fgl+Vc?=
 =?us-ascii?Q?ZwtCj2weYKly55qIIubWMGKrV/6uMnSJpnL8r/ow6KG3N22pCU5Wo4Wmg0J6?=
 =?us-ascii?Q?6w/Gha4GYVmI97fqzrF0cxc7KE2ZCbslL3t0Na5PyWlSWO/xFDEyrXPg4k9y?=
 =?us-ascii?Q?WYu7+UThyfi7HEl4q7cvyy8ewGW5l6qDQJzL/Ptp08SbQHvVqeRnBPfFVEm2?=
 =?us-ascii?Q?EUyUl47FL5z2EU+4bcXvp/+Jzng/5Z24dcH+Hql/txCxbu8xpD109heU5CWv?=
 =?us-ascii?Q?TtxLXzzDSJtUCc2GQjRIpM2bP+6vqboU+TMzYAdbBngiLh5jhAKtlISEYN67?=
 =?us-ascii?Q?l+R535+5/wAcZqIoAovrJerBQowPi9cZ9n2jFHPqoSX6EUsGF196lZk/eAdv?=
 =?us-ascii?Q?0YJpm+UWJeEEuIxbN6amTgHSwwYXxMi8mVETPMVdHLI7XJxrLLTcEQQX4SAc?=
 =?us-ascii?Q?tgYUHNl5dTvC3w2iR3CkjtDoROVntN7bckaQyfDuHIlhP+JiKPgxKXLWpb1a?=
 =?us-ascii?Q?lZJMcvcowoBSoqyZJGWEKPmnA8Sq7UUA2t216Yygn0qXnsR+AI7lJWmMq1TQ?=
 =?us-ascii?Q?o/wS2x/H7EKCWhwg7sXbeDMlKUvoMXNeVdIoP0roIMQ1Udhldhb2RB+/KIax?=
 =?us-ascii?Q?1N5wJ1YLEFwPfqq5lkWKEko7WZOaeXr7y99Z1UEax1bk7MFZdi0LRDo3l6mL?=
 =?us-ascii?Q?4kKfBEfGYvtI8MYIg3JybMoeWEKxVVps3OLBb7DgrI7M2q7mx6bOpXVGi2rW?=
 =?us-ascii?Q?a24cRQIkDuMlmm7L3ljaR3byvmflrqaOLcuwm55iYflNjPJDlp3Xa3Q6zZ7B?=
 =?us-ascii?Q?Hz86J/jVOpjXp5+rN9qp7aQduG4M53QsyhjSoZan5160wwWM95VwWz2TuKmI?=
 =?us-ascii?Q?IhqFKNq5aZt22g6+cNVsGH4R499VxPccxbmmb6hf5jEeBIO50VzJV/lLc2iQ?=
 =?us-ascii?Q?6wzlnupofvlj1M3ZAeiRHXIMvNWXujLqzdQmHHH5KnEDnyDyVVccNkySnsEr?=
 =?us-ascii?Q?p60/t7pddb86xhwuR12dRCsEIFH8bfRpeL8nkevk4piLuw8/rnvXvpleBCsK?=
 =?us-ascii?Q?nwK8CBLEcHjfK6yjL0DqrUjjpFrgXnqUk/KZdTbQIrGSsPXRJaEFq5yQGQV7?=
 =?us-ascii?Q?u2OP3x7NPO0p6MaTb0aYdyz76dcBjToVhvIVc3Hy4OQ3jlwTL9hb5wuXao0q?=
 =?us-ascii?Q?bsOWlX5AMalAwZIuNkcQYKdBRk3TLnBnzr538thA3KcCnK/RKNkwkdVWi0cV?=
 =?us-ascii?Q?W7d6F5W7wXzJsvvMpWF+jPmv?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafc9611-6948-457f-515e-08d8dc4f9737
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:07.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyuDClqjcaFDZ1HD0cDj3JGwl+C1JzkXzeuvDCENSbIP8eaK2pdUs9e84s9dLuXa6Ni7LIaLDZ3w8lk2IETkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/mshyperv.h |  1 -
 arch/x86/kernel/cpu/mshyperv.c  | 13 +++------
 drivers/hv/hv.c                 |  8 +++++-
 drivers/hv/vmbus_drv.c          | 63 ++++++++++++++++++++++++++++++++++++-----
 include/asm-generic/mshyperv.h  |  7 ++---
 5 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index a6c608d..c10dd1c 100644
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
index e88bc29..41fd84a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -60,23 +60,18 @@
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
index 7524d71..51c40d5 100644
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
@@ -1381,7 +1383,13 @@ static void vmbus_isr(void)
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
@@ -1496,9 +1504,28 @@ static int vmbus_bus_init(void)
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
@@ -1559,7 +1586,12 @@ static int vmbus_bus_init(void)
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
@@ -2677,6 +2709,18 @@ static int __init hv_acpi_init(void)
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
@@ -2707,7 +2751,12 @@ static void __exit vmbus_exit(void)
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
index 70b798d..43dc371 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -92,10 +92,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
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
@@ -103,6 +101,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_remove_crash_handler(void);
 
 extern int vmbus_interrupt;
+extern int vmbus_irq;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
-- 
1.8.3.1

