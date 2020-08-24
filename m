Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960452503E1
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHXQwG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:52:06 -0400
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:61408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728503AbgHXQst (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDIywB8TWCyhiASfJY5MpvUQ7H5/A1oF/3asvWv12EP4cfs6rVq+Y1NNz14Pru3rNUOhrHrR74h5HK0EP3r6OkoUpmALdt6oViRncyrVv/clwoj+SgbSME/SOE2Er5Cedi7ififAawFDODx/Adnrzthpw4tQjdMPLKuBfQl/eDf/AELEY19Gb/OnZrZIBNilSS/P79OmifEIlHlfM/iO/eGwi156znm8IDkkC6jr90MsFT43Q5M5IKHOKEy78PLypGyHq10qHuF7YYb9AiMSSZ8+ysD7CqU/i4K94Gphr+26XuXsz8RH5WFYqlGygzDNIHQSFNLoccjPJER3QIQmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnkCAG9yK9xZ/Yk93n2+2+Qd0OZ1cEny3sc3nIpUFJc=;
 b=Qcq+2WE0DB0RVl+u1Ke5Dm5VD5qAOQ5r7sa8Z8pzW/Q3S2+v/buR0vz2J2MeHmaqdQKMjHW20D2oSDfLi+/HGbqySGO4EsrrMgugQqNXoYdAQ0rvsSIQ/iLgES3ah5Wsa5a4xVV4zj0DwVXUrjIcQ+UJzn0yL2mt/bJpBUv8gIjWcfyR+zyim7cFLKeuZLn1xXduPjyQc2e1dmjrb4ljy5K8a09W4wfvJx/wfh53vlZCqWgdpFkRBVgKHbORaL5kyKqFjRFjaDWtq6xwNvbHfXM03+AUgID7DctEX13PVv95GGfG2lZ4YMUzMckKZBPAF1dWuhb0391ONhLuecNVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnkCAG9yK9xZ/Yk93n2+2+Qd0OZ1cEny3sc3nIpUFJc=;
 b=KDNO0gM0Ri6520jRwPRrR/sTLNr5Wl51Fecc+5A0HKKFToJqdj6VD1kRR4J94/DJEfUzLpnW12OYiovkzlgXXSoyxfahTRcKcNsvv19LPlGWYDZdmVJq1ZDhR0skff3OHoebzGpmpmrV3kZyq05/TCq2VLkE7Aam1sN+Izqzq0E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:58 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 05/10] arm64: hyperv: Add interrupt handlers for VMbus and stimer
Date:   Mon, 24 Aug 2020 09:46:18 -0700
Message-Id: <1598287583-71762-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:48 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 456256fd-e167-4fb0-00a0-08d8484d702d
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB07533A4F7BB85A6E269F9801D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaeqHQX8NaKVxqAZt+CmX13YzOLPT1kxmVCCtp7MHJez4AE8YoHZ+lNCvREzWciB0mnvq9q3vO/hcgCy0N2Y+FWiAzdAdDjLy8nlS8CkggN5HDPW9RBaVjuCrXK4TIEik974LG0G+SfbskcNynX2JTPWKBIp+y1LohggjTlvJhcBbMy9PR6oqpH4yQmEgJy9mInxcUAQ4JMGGRy71d83307gDpC6HvYSUcPOBWE2LaClK7TthZp6G8SetOKKhqJTcslJ2ClMMxpZlUKOqb6M66JKns519fDmm0sp4XSUIN33iJ5bdvCbbuvM4uqdTsgv2JxZ94urMdpOdgz4FwShV2quT6GdhT20+R81nTu7cms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: w96bK3czhU5sSdvdG5vg9rVVpxKB6KwRzitr8nDMSq2KXHlWgNeUxr7BqZL22kC6DHdQce51joXZzj76DzWxtk2Dwr8Y1Yt/kD4Wh6PyVhdS8GhP4I3tnngOOSwd82fMo/+9kKNlxiy2Sj4fLj+hvdi0NK2EBVRxYSar1XEvu3P+T5hRuuqFUJL2IS2EK411fvWLZZ0GeZ+Af3ZbCdSn1gG4XpIruj50KJb6CDqt8qRFTBuKnB8kId8zqsoHKtjjE/lmWbZtYwqVXBZCFvUEPioxlDUkWdjBam6/gEIUHpOAYuWGxx8QZfzKLmjNpQS65Nb0birDFZWkezDxZim474lAUGn1dUsYHumCuKDxdMiRwIcK0IGq8YQ1F1hl0h9s0jduyfKVoRmLkWII4i0mGINuKXZB5Tz1J21KblKaAnoIvhXV8h0uxaSMTnOoE2NXtzdYFSw+IqraPsJVAGXfkBvjBYLpIUWEcQVUXtMrKdyamojBPfNVK6qMvVqLryGEFsiUN3XchSiM8feP1i4vszbOXfbAt9eFMmebN/gAotH5ACIHMdAXEnOnm1YPmXL55IaepJqpST2Q+2kW957rq0GX90plDl26Obc2AguOc6zis74CpqfVO9jB67uLIGymeYtrHxYusM4PagV4dOovtg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456256fd-e167-4fb0-00a0-08d8484d702d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:50.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j542S6N0qgpMnN5fORxDWunALo1aR3CgUpeiWp7BXWP7MItc+S4CZJbDnGe8y1H+MuYPirt1M2QH+TBytTtEUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ARM64-specific code to set up and handle the interrupts
generated by Hyper-V for VMbus messages and for stimer expiration.

This code is architecture dependent and is mostly driven by
architecture independent code in the VMbus driver and the
Hyper-V timer clocksource driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/Makefile        |   2 +-
 arch/arm64/hyperv/mshyperv.c      | 133 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |  70 ++++++++++++++++++++
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 1697d30..87c31c0 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		:= hv_core.o
+obj-y		:= hv_core.o mshyperv.o
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 0000000..be2cd2f
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor,
+ * including setting up VMbus and STIMER interrupts, and handling
+ * crashes and kexecs. These interactions are through a set of
+ * static "handler" variables set by the architecture independent
+ * VMbus and STIMER drivers.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/kexec.h>
+#include <linux/acpi.h>
+#include <linux/ptrace.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static void (*vmbus_handler)(void);
+static void (*hv_stimer0_handler)(void);
+
+static int vmbus_irq;
+static long __percpu *vmbus_evt;
+static long __percpu *stimer0_evt;
+
+irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
+{
+	vmbus_handler();
+	return IRQ_HANDLED;
+}
+
+/* Must be done just once */
+int hv_setup_vmbus_irq(int irq, void (*handler)(void))
+{
+	int result;
+
+	vmbus_handler = handler;
+
+	vmbus_evt = alloc_percpu(long);
+	result = request_percpu_irq(irq, hyperv_vector_handler,
+			"Hyper-V VMbus", vmbus_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
+			irq, result);
+		free_percpu(vmbus_evt);
+		return result;
+	}
+
+	vmbus_irq = irq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
+
+/* Must be done just once */
+void hv_remove_vmbus_irq(void)
+{
+	if (vmbus_irq) {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_enable_vmbus_irq(void)
+{
+	enable_percpu_irq(vmbus_irq, 0);
+}
+EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_disable_vmbus_irq(void)
+{
+	disable_percpu_irq(vmbus_irq);
+}
+EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
+
+/* Routines to do per-architecture handling of STIMER0 when in Direct Mode */
+
+static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
+{
+	if (hv_stimer0_handler)
+		hv_stimer0_handler();
+	return IRQ_HANDLED;
+}
+
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+{
+	int localirq;
+	int result;
+
+	localirq = acpi_register_gsi(NULL, HV_STIMER0_INTID,
+			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (localirq <= 0) {
+		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
+			localirq);
+		*irq = 0;
+		return -1;
+	}
+	stimer0_evt = alloc_percpu(long);
+	result = request_percpu_irq(localirq, hv_stimer0_vector_handler,
+					 "Hyper-V stimer0", stimer0_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			localirq, result);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(localirq);
+		*irq = 0;
+		return result;
+	}
+
+	hv_stimer0_handler = handler;
+	*vector = HV_STIMER0_INTID;
+	*irq = localirq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
+
+void hv_remove_stimer0_irq(int irq)
+{
+	hv_stimer0_handler = NULL;
+	if (irq) {
+		free_percpu_irq(irq, stimer0_evt);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b17d4a1..2ea64e54 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -23,6 +23,7 @@
 #include <linux/clocksource.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
+#include <linux/sched_clock.h>
 #include <linux/arm-smccc.h>
 #include <asm/hyperv-tlfs.h>
 
@@ -80,6 +81,75 @@ static inline void hv_set_synint_state(u32 sint_num, u64 val)
 		(val = hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
 
 
+/*
+ * Define the INTID used by STIMER0 Direct Mode interrupts.  This
+ * value can't come from ACPI tables because it is needed before
+ * the Linux ACPI subsystem is initialized.
+ */
+#define	HV_STIMER0_INTID	31
+
+/*
+ * Use the Hyper-V provided stimer0 as the timer that is made
+ * available to the architecture independent Hyper-V drivers.
+ */
+static inline void hv_init_timer(u32 timer, u64 tick)
+{
+	hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick);
+}
+
+static inline void hv_init_timer_config(u32 timer, u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val);
+}
+
+#define hv_get_time_ref_count(val) \
+		(val = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
+#define hv_get_reference_tsc(val) \
+		(val = hv_get_vpreg(HV_REGISTER_REFERENCE_TSC))
+
+static inline void hv_set_reference_tsc(u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val);
+}
+
+#define hv_set_clocksource_vdso(val) \
+		((val).vdso_clock_mode = VDSO_CLOCKMODE_NONE)
+
+static inline void hv_enable_vdso_clocksource(void) {}
+
+static inline void hv_enable_stimer0_percpu_irq(int irq)
+{
+	enable_percpu_irq(irq, 0);
+}
+
+static inline void hv_disable_stimer0_percpu_irq(int irq)
+{
+	disable_percpu_irq(irq);
+}
+
+static inline u64 hv_get_raw_timer(void)
+{
+	return arch_timer_read_counter();
+}
+
+static inline void hv_setup_sched_clock(void *sched_clock)
+{
+	/*
+	 * The Hyper-V sched clock read function returns nanoseconds,
+	 * not the normal 100ns units of the Hyper-V synthetic clock,
+	 * so specify 1 GHz here as the rate.
+	 */
+	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
+}
+
+extern int vmbus_interrupt;
+
+static inline int hv_get_vector(void)
+{
+	return vmbus_interrupt;
+}
+
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
-- 
1.8.3.1

