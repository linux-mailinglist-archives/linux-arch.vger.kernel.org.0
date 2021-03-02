Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535C32B4DD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450138AbhCCFaf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:35 -0500
Received: from mail-bn7nam10on2111.outbound.protection.outlook.com ([40.107.92.111]:60513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351064AbhCBVmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOcTsWYdvpJ0sd9HfHOaNgjpKN6S77al2/XirvVhXCFze1lYsOj9DS4V/thLhU8E8BY7E/HScNQzY0EPLVnYN3k/pdzLBQmhOvQqJ7harJXVoS7u6UUn8z382ZA0nGTJX47qtMoaXTzYxAUx8k41d20fG0pjWP5jJFR442xB5rNnmqNkJ/qm7QFHr/FDBidxXtaDyQXXiOWRLNue+y9CAn7+W6pmi0aDy0O4eUjkrhUz4KIhor9Jz8QrgfaPdrDub0su7AXp0DLubtCkjCQS9yNhiJmrhp8eLIX1BL5O7ZqI+2/8fUFW5ZmRF98+F5luyQHutQj975rNUq0zZr2fPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOSlRrmF2a1+jZH8NlOCSQmvdLLqXAlfIC6Z1FQHh6k=;
 b=Bphm9lzvx7UoaBZW2jL4rlqXPCpJngbBmVKt8ymbiMsb9Ja4NSOF/JlCW1X/E2hIlFEgR0urKEi0CqxJZ0HfNyWR9rshoTPIy1m7GG5ggj+FXOyqkp0KYCm9SnbPUaKNoHCG9PhcChH+gCAsc9EOxTxU3PiHUQ/n5sx/M5/1GxFDa9i+4KNtXFL+XvKN9Ia9WYD+tRUgMsZA1bozIByiOzZ1WvKgPrRnuxUFHkU8z9qMsqIFMouZ5ZUoXeERbj7Df3WFRTWudWHShLQXbl4sSbrDfwL9TfzYPLPILvav9e41huEpATfFj07+SVPcjoveSz+FyEejcnZCKr8XOdYQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOSlRrmF2a1+jZH8NlOCSQmvdLLqXAlfIC6Z1FQHh6k=;
 b=WtAkHcB50G18y/ufF2GYBzpsANbIJj2FJ20e8WvPq/Z1y4DBkXlLS4ha+jm39Y/2Y9itnRHUx0dZ6NfFoDIwSM/VPahhPwcAy/bjr0BdI6xgIs5/B02SnA9ytt3PuHdplHzFTt+KM20UXwB2K5q/Qd2FotFKAaj9jHjmBCkkZJA=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:39:02 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:39:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 10/10] clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts
Date:   Tue,  2 Mar 2021 13:38:22 -0800
Message-Id: <1614721102-2241-11-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:39:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afabff8b-56db-4b39-cd1e-08d8ddc3987c
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0153F87CB15B166FF5B773A7D7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fer4qunjxLeQ9mSI0IqU65d+b2IwKElkfQwqQSkHryARJMs96L7FEAnRzeFuPMQnvlgbI5BEFIfW8nMAzKD7Cmw0buiRHKKiXdPDIHTC49TKfpCeVh/8NduyChjGvJS90Oq/VjtiOIIgmLN0NpCk4hX7mBZszFHhEMTja45/h5TBK7JKxouzZT457B29H+nb35eEUteLw9NvDG9q9y+bY4zukUGxmaK0qJoFX6Z6Dve2myDl0qRfmDK22hZhpodDckEpBk3Ucg3QE4iJZDMr4Z0qEKB0WaJKSf/BDwfeJlZdxOuzw32qoOUPKELsy9SYqmH10YdMxgavaqP32GOJLmECxejwVGNswBoGqL6XuMrRq87j6J6S3aqKYWVhKXQqopm9F9qMMeLCO8sx3NgNrTzDxeJ0p+pP3zcamCPoCpkW6t5WTNSJGrc6RSLmpOr26lGTAhmXYytrF92jsiPVxNzPwfLyG920b/FcfnQrnqVDEdK//Lr0yH2592Le0vA27sndgEokh2DxW7mjWsBbNWl5E4KAKtoLYYsBg+I0T6J066IcIw4EiwQuPIwhBLV8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(30864003)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sMnS3KT05SdrezEVxFPCJU8WFvz/KipqhqKuQRbZwa/uGVdUD08t/f4PJ9fW?=
 =?us-ascii?Q?Jij3tclGUGX78Y5hFBrFJjtO0mbIav7wCzUMk5klkLv4nwOzaWQCcbUrg9BL?=
 =?us-ascii?Q?CMw3qBc4PUn5ji+2vhZk3sc1BhPxMRh7OXehXQJk7NL3i5Vy323p7Rej5z0C?=
 =?us-ascii?Q?9WgUwKvXpvthZFjOg//K+bTxD3IHBlVfKywII8fobe9pdqzvhv9uSF2/t6Mu?=
 =?us-ascii?Q?WTsq55DIS1tRjZy9XIkLkDyXrwIIlzIxHNkiiyOiLr5k6eH1TQ/sH1JRghVp?=
 =?us-ascii?Q?zPK/3YYO0xPiFsFvH4OlWxMfKBVJDV/W0GByMxzFnp6u40S8G5E1/c8haX5t?=
 =?us-ascii?Q?5jdV+20s8GT/8/Y0cHGV87ygSS9i9XuUAaFBmjGbXnpcI4p3+fldcefj5keg?=
 =?us-ascii?Q?xBRTkgfXouPMc7takiaWEp67EdEx/M9XN4520n0I1xIMBcBM5qJPJ0rMnCCU?=
 =?us-ascii?Q?BKt4hnAuR4zM9dvaUX8ZMbhrUghiM+sa4lauZ0GPlZpfrzbm/jX1UIXNgP0R?=
 =?us-ascii?Q?qzbR+hCO0d6c8SB7QhDNt+fqsNt0vgCw9NAxUSHDRXZPv+z8dH/adgWyvSWQ?=
 =?us-ascii?Q?5J/8gtdEIwQM8IwsU2GX7cMRNNVl6FYCVTqX1XTqmWY21IiNd/WeZV9eDLMP?=
 =?us-ascii?Q?iLIxwkrSabIMmUSyaVa+dsR8JrP4b3zCBQAKqCsRdhz3OljOnkL+R7+Kf5u3?=
 =?us-ascii?Q?7Ps9YJv6Ys+EHmIVDnxKfMtmEsKuENuP0ilErPKBMh354gLrYDF3YUHMjyal?=
 =?us-ascii?Q?TqlkzNXbsr//LKOcWE8BKaqyKrURB9Gi7hBo2auPCPN5cOwLa1KWJr9Zjk18?=
 =?us-ascii?Q?jIKe56jGaVL2s32dxhWH5BV69kmT6gzQQggHpfkN5IfsBykpcWgROlx/xycv?=
 =?us-ascii?Q?sBPzo1bMYdOYHEdF3vAxYiiGGSzBGRa+LTSkcaEp8QeUjn/B6jNoAn5xPs3q?=
 =?us-ascii?Q?Le+XMSyVeVHv+vMN+k+o9ZrU3aYsZp25adhRuloYsa5nYamCF7jEc3FffT88?=
 =?us-ascii?Q?LCRgzN6vgn33sb94fK58u1l9NesM6tybheMGhrmQJUfZNUiyTGsa+1FbQf1t?=
 =?us-ascii?Q?7YP6GmzFZjq4MiJidkWMxye+oSQ6qMjvR7TTgGlWrbU6uz63JqZ71D72q/GC?=
 =?us-ascii?Q?ab3popGcva8oEYBqUA4PEfZYCvJFGCIMvxUeuEHF9Cc5DprISFBYopUaAnh+?=
 =?us-ascii?Q?6HlKXwalDd4K74asz2JosENV1rj4Tc7ONIoH5dDP09M5H/QpXPjISUECSkY9?=
 =?us-ascii?Q?OrI/zRhkRIuDhfALlcEcbdtCZ8X45/JvicdpT63RGys0s+SBL5c0LqqDpAW3?=
 =?us-ascii?Q?rWAUJcMk2TRz68dcsLWfiQY4?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afabff8b-56db-4b39-cd1e-08d8ddc3987c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:39:02.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GDNCeMn67gEM/bLTZySkU47i3oQCaOupJSsNZU8Jj8w9a4+jWwVuSZjZeTXjzWnk5r53KmVKm8y6UxxKW3LeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
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
 drivers/clocksource/hyperv_timer.c | 168 +++++++++++++++++++++++++------------
 include/asm-generic/mshyperv.h     |   5 --
 include/clocksource/hyperv_timer.h |   3 +-
 6 files changed, 120 insertions(+), 72 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9af4f8a..9d10025 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -327,7 +327,7 @@ static void __init hv_stimer_setup_percpu_clockev(void)
 	 * Ignore any errors in setting up stimer clockevents
 	 * as we can run with the LAPIC timer as a fallback.
 	 */
-	(void)hv_stimer_alloc();
+	(void)hv_stimer_alloc(false);
 
 	/*
 	 * Still register the LAPIC timer, because the direct-mode STIMER is
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5433312..6d4891b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -31,10 +31,6 @@ static inline u64 hv_get_register(unsigned int reg)
 
 void hyperv_vector_handler(struct pt_regs *regs);
 
-static inline void hv_enable_stimer0_percpu_irq(int irq) {}
-static inline void hv_disable_stimer0_percpu_irq(int irq) {}
-
-
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 41fd84a..cebed53 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -90,21 +90,17 @@ void hv_remove_vmbus_handler(void)
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
index 7a9030c..ce94f78 100644
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
 static int stimer0_message_sint;
+static DEFINE_PER_CPU(long, stimer0_evt);
 
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
@@ -169,10 +182,58 @@ int hv_stimer_cleanup(unsigned int cpu)
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
+/* Called only on architectures with per-cpu IRQs (i.e., not x86/x64) */
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
+	ret = request_percpu_irq(stimer0_irq, hv_stimer0_percpu_isr,
+		"Hyper-V stimer0", &stimer0_evt);
+	if (ret) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			stimer0_irq, ret);
+		acpi_unregister_gsi(stimer0_irq);
+		stimer0_irq = -1;
+	}
+	return ret;
+}
+
+static void hv_remove_stimer0_irq(void)
+{
+	if (stimer0_irq == -1) {
+		hv_remove_stimer0_handler();
+	} else {
+		free_percpu_irq(stimer0_irq, &stimer0_evt);
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
@@ -188,29 +249,37 @@ int hv_stimer_alloc(void)
 
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
@@ -254,23 +323,6 @@ void hv_stimer_legacy_cleanup(unsigned int cpu)
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
@@ -287,12 +339,17 @@ void hv_stimer_global_cleanup(void)
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
 
@@ -457,9 +514,14 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
 	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
 	 * TSC will be preferred over the virtualized ARM64 arch counter.
+	 * While the Hyper-V MSR clocksource won't be used since the
+	 * Reference TSC clocksource is present, change its rating as
+	 * well for consistency.
 	 */
-	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
+	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		hyperv_cs_tsc.rating = 250;
+		hyperv_cs_msr.rating = 250;
+	}
 
 	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 43dc371..69e7fe0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -183,9 +183,4 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
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

