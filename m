Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768E932B4D0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354235AbhCCF3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:29:08 -0500
Received: from mail-dm6nam12on2119.outbound.protection.outlook.com ([40.107.243.119]:25542
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350904AbhCBVkT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:40:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVZ05//obebY5ax/rXbyu5Rf0ntN6Q8HHuvhCxMGa3osArD1GunT0+j9nLUj9YsGe9rP3Gbt+kXVWYgt3OwCZeijzAP2poMbBPZk0QTLb5u3KRuhrk89LfrfjO9SkRsl/auDkvLPWWdY4+oewgz/tJl7I/hPq1/oYASIXwM9zO4N16hqeN+x8We1rIKMCxHbvAXIldL4SpX4XIwXB/a9qoaMQPS7yTsrwDr/npY6hN+F4dHbX93kAU5VtcvEh8/9NmXXmqeuSmX8Bv5zHabnYnmbC8kVzEe8C3LrsrbkimCkg5mC8MSDckdTBEDnC9I+Nnv+kQNXzhc65A27n+6zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVWuOBcTVaBZBm63L/Cp4uf1t+T4/yVdhkF8/xZPPlI=;
 b=CUhX8VE0Jn4IPe+pipV0tz8434FC8fVj5n4lIk3Wd7rSpzswwJPDA0golD6XIuV5DnVcIYDp42qNrIvIhpyREROWp6UTSV1FvgV/dWwhd4PCz5nrT/DiCIw4tjvRo3Qnz2uVVwrzVvhpg77Vd+M6IzZ3Vt0nFjVYNDkMpRcil3D1agG6DQgg6PVaEwS1Y3Jbq++Vjrzh6YPL/BTHub2bRzjXKWdpUqOMm6qsMxPrHs3c324M8IWSR8HFJ0x06hnxcg96PXJNJyjyEUsosuwENQ0YZzWRTuJ58bvTXqYoH62XIWMm833kpv0EyjX6OfGGQxt7vy77cWk68adCv+JqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVWuOBcTVaBZBm63L/Cp4uf1t+T4/yVdhkF8/xZPPlI=;
 b=Z5ZP4m8O+y1XYf7eR0Elxl6xmHv26uhj/ftkqVNtukIdT1XMjMWqJva9BCl7xFjYrlvHJLoztVjxfFmygjC389CL32WjsBbt09bxvGLceCTbldG8I8OuTWvRn1ThVGtVh3hs+PIxxK+8qehl4HcyTuUyhrIZPYAcdusr2cpQLVo=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:38:58 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:54 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 06/10] Drivers: hv: vmbus: Move handling of VMbus interrupts
Date:   Tue,  2 Mar 2021 13:38:18 -0800
Message-Id: <1614721102-2241-7-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd1a31d9-f3d5-4aeb-76ec-08d8ddc3942e
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB015378F3DCC6A5C9AAB93546D7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DV8SWhGxMDW5/xhP+9Oib6tAe1t/3ktspAX3PfW8Sz39R9vT06hfxXEFPMbiGJ+l3AbjJyr/ytZfXmk78oWjWcfbi6yM8tnS8ycI0/M8bj0NmApqqbOZbZKotyakA1mm5v2y3RtrGG+c5iHSDkUv/VhN0u5mw+jhYo6q/Mq0VtN+1R1aYx1QwGzz56AbkRRmvvYPLSYyd+bQrhnvqQVVgV/HsETK5sNaYMhXG0kRbrfVufkzhD6BGlAUlueAvgBEXKQ1NW6Q+pc1PNxIoO9cPQnQYSNWfI/7OdtuQfd8IsfOGKugt6SxtpCAV+JgrHfeCdVrZVn6IHe4ljjR/3YqjR8II16qCC0fPnKdsJvOWzeWGrL6y0Ek/3ysVhIxanrTHhBBIfsQ8FsrLNTdPOMPJ9TBUIPgv0fmNuJk2iguPWIvE1ta1DLnIoRQ5amVH1vCTZVgvudHjSLPOI2+IjxQer7IRPD0WSMX/2UAiKZaTJzDiqXvi65bVpk/QzsR9cO3yJbKgwJblpIdNzUJq7ERvnS6IPVbjrdbK0CcnzGj4XGs+S2R+YbvV+GYPo665l+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J+vnhAb1ALHlHvCQLxXgMme2FnYRHTbIZRjP0d+vK4ZLAKNQQ5Mz6N5ro1qJ?=
 =?us-ascii?Q?Z4XqxllMk1vtqfXtWMBeGKDJWP8yXLEEXyGiPN3LxzGJ8NrJikXlCl+0kHp+?=
 =?us-ascii?Q?S+/IpkI+awqvsnaQ/tP30BaStgI0/OyiX+SJTA2IikwJRT4guwH7KkLuVedu?=
 =?us-ascii?Q?e0A6rnaUVvIFc9Sfryl+QhzHT89vhohWqpkByj/QF66jwbdC15xUbzw4fd8I?=
 =?us-ascii?Q?snDNw5wXm3PF+lCWt5Km2f/xvbWQ65y5Een6Qs5YPx0Gvs3tvExj1mW495cE?=
 =?us-ascii?Q?+a2Nx6SUThi0jtueO9pwa0SFOGoGPz+NtWJzROd71CN4IFnufLM4UPPP6LrD?=
 =?us-ascii?Q?fT/Tk0dWrZ3QkDOgXWVwXaRSVHtySW8wvrM3oWmBxiQAj4eYtoEqV37wMbcv?=
 =?us-ascii?Q?KJpUY687MRy8Sa6oBLE2ZPNhFaXqJ6iZy3P5QNxPeE37wOyzgPP6/EWYhQrY?=
 =?us-ascii?Q?h+iU85X+IQXnSCc4CRO2AsDHtD2p1qQdGyvCQIEHVpz3KtVIeYJg8+OX69AI?=
 =?us-ascii?Q?nzg1vR4JNkRPBu0mWDHaBktXX9hmWDFCInkZ6+K+JfR5KILJnWoKPKvUKvNS?=
 =?us-ascii?Q?pyKR1QahnoKp5zOVSs7uMIH99oHUvh2rrwRC67nxPpIWZRM6VHRcPIrVIK7X?=
 =?us-ascii?Q?43teokpyLw0231Q139uEqKTDWs2SHapLOXcMDPxjYxYeoCnJtA7f4wniDWVC?=
 =?us-ascii?Q?Almha4kO7NlPHiUnG0/FGkd4SDFZtvF6SYek9say8U51+mKjS0H27uJJ+VjR?=
 =?us-ascii?Q?kQwduuTlGY3CgfEhmuhrVDInoGvDxYIeIfH7NlM4pE4ejqs/1XgUyXiLo/BO?=
 =?us-ascii?Q?FEN0EnkmCtvKV5/tt6kJlBmFIYCjDS0TrV1c1NxncjdhOKvp0isR9hPedVAY?=
 =?us-ascii?Q?l8iOgidTnM4GR4/Y8mKQRpahlDGSf9g+a/sDKf34NtzmFOQ1MWBltqn+YfW2?=
 =?us-ascii?Q?MUcqv6bo3oeTDXAe277xzh8iNq9Dm8irNg3tovQEXVu3++mrMwrLHiWdoQf3?=
 =?us-ascii?Q?fHkCJiRZT4n3/u4/pYBJXJqQ4t5m/GkhaGdq7AitBMvk4sdzKCMFX4EEq7aO?=
 =?us-ascii?Q?9j0QwaJPS7erC6l4ZIuh93yab/SDIwEcMCe5nZcp0ZRbS86BtTnuKigG1H01?=
 =?us-ascii?Q?QI0VQKD3wFYB3E02+DHfVang8czzWf0FCmBnPgJLYiFb1yx9hyYHkFGs2ipH?=
 =?us-ascii?Q?WU2wbFbOu4ucDedJ2PD3iBixXK9TneRsFbGtbn8tEFSB95CUX8Bv1Oos8ytZ?=
 =?us-ascii?Q?36nCHJNTvtIW/yF4ZSsK/KRZsYe6Y2QSG/7SmbNbMqUJKbT7na/vRSj2Goap?=
 =?us-ascii?Q?Cmoy+PI8/Ka5BiPAi5/rLnZs?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1a31d9-f3d5-4aeb-76ec-08d8ddc3942e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:54.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfGGAiBheq6741TeD6N1FhI4ItVjugPK+ICtmMqVFLEbel7wNU8wjP/U+Mrt1YBIMSdJzOq+50jY3hqaNNM4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
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

