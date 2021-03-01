Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79693275D3
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCABSX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhCABSP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:18:15 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84785C061794;
        Sun, 28 Feb 2021 17:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXAyK/ct+NYPwgcooyL6oZbbM4Aq9Oti5RnwMTapHmg3rvN7hKhP7H+8eZc1h5QZBbNSzgBTBvEP72/06uuwSA3r/h9EapxjM/poO/NhARd3q1gQKnE5mxLGaBbuRWE1+gqEcfo+ImZ/bF8Drf2DTzXTvj3zQ/EbHOXxMCRXaTwsnwNz0MJmIm8LkY/7sZAMXIUMsm1M52GTC3YqKkK2h553tm/asJpeDMTsAG4q5fOfNjqxlWe0mlPajv6EY1JZQAelQ/VlmzyzNijnDFOBBkc2BPlTtWNm1NNbtu7aeWY7Et7FGL5UAHwgi+0N8UZo4OQfq0ThjE8LUJoEB482Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULO+QYtcsebUvBDTMCD70czNMdhcUsWza55xHHtuzIg=;
 b=KHb7peB5/ikF9vAiNxvnlp0QZidFt5xyU3z/cJ/7eNS8HJyMd22tM/wjObqHT7YkJ7fbcuiZYMCGujyUzmlqAnfvhLsb82VN0c3vym+rgyul0lFLmZh+44s3hgoi2OLZ8Y3mwrSK/X6vE1nthm2YNmVbTpu9D1IhZHHmO8K8UxTzgY/BRSdCV3OHVAZn/gIaFGSi+joulxVB9QP/GPT24d/Zzk0dqS9GL7mZ6f42ofBtpIJb3WNIPaQ4qC2OdElTJuwpo802TBpzPOzwt4XhaVB9lJqapZV6Au8svrxKq+f3hd15RtR1Spn8W7zkn2wBpQSagA8UeBiBxaCzKvtilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULO+QYtcsebUvBDTMCD70czNMdhcUsWza55xHHtuzIg=;
 b=MP3z8xtN7OOo68Y11IR1T4+LTMU3L60rsv7DQhmgc7hITO/8o+DEZYkgZPc8WBMwG8GgsV280X8ndl6acLoFfOEttLwhvbpSU0DhA7VFqfa0dMl3CZoTb5WLCfP87KpHsR8x72487obm+T/HegqYbSdaKEhQOTDOkRuI2M1NjJI=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:11 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 10/10] clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts
Date:   Sun, 28 Feb 2021 17:15:32 -0800
Message-Id: <1614561332-2523-11-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c788e6fb-e877-44a9-8c65-08d8dc4f99ae
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098194A84A7092E599639933D79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80lLdD7Kh+Rn2oozAJ19t5FoYRLfQDN6RFKFCl0hXX7rv+WbT48U5pzRhi7ej9WqqmAUr9lOW1pCTg1l3dlOejL1P2iJAyDQEX/2KRWgf3phCLgZ9/sR+y897teoWwoyNBgz90sUt690rJsl2xWLkaBD6GKxqinaliQb1fjKyvsM+kq9ANv0VKb+2C9B9X/O8norIIctA+E8sbIoK9nLpO8ww7Xz8HitF9/A1KWCyGAudI4dyT1zHdFPMQ8oI9qKq9xnTzUCxarhSYegiyUvke2pKh+L3VGzr/6yepzNw4jkO5DUb5rSdnO6ILtxei3fjYGlajMeZSLdXHI0PIvhHbpo/DmtuCCFkkpLCVNKIFYNcsB20m0QrssuW2L5ykdf/IFgBDEAYRrAgAyqXjRDLs68bfBefrD/qPBUgKvojyAw1clM6w0TqqJE1pctXOO7xu/mdJrFwGPlEXvS9Y5/4qby6fkWyopmibs3X0DyQ5dLc1Bspp+Qn66OMIEkMY5yq3Qa3wQ+gBMEVpCVLmu94SbC8ipcY0eCX2shPM9VsG2jB8r9C2uwJSrN3nUsST0J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(30864003)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PzqIEc2/6WVRmXm8/b88PYjTnjUpN4+6LquLNA9wwJr6OC2+xxT4yFbi3VNt?=
 =?us-ascii?Q?JnKcG1YOY1qEY0GQPd16zf05BtMcPDL0fDsJbsa0TQnWPk32XXn4Hr//Tvvp?=
 =?us-ascii?Q?5O91qTroi6CG207jdBIupYkLl4nhIqBgpTGwUr0IYF82uBOjB/p5W11IIdMF?=
 =?us-ascii?Q?MvZwtl02j9V20sdo+N3PQNmvBgqdH3TcYZ7iqjzShxaONIWgOPcq2N8yCqe+?=
 =?us-ascii?Q?UeQR0OzhqnJ94U76fT+aHtzpDLD3BmPX7O+VEZxGaGiZ74gKUe4wuOYrdAAm?=
 =?us-ascii?Q?282MZap0HIfoAyNuNvfmnvIhaJJ0ml6VsrzCv/Mq0OYdKFl0mGFI/L/cEgsX?=
 =?us-ascii?Q?9aLUHVcjYM1E2nHluF/1W04Xqdm+l0Oy996jhXCKTJmP2e4BcWJJJvkSu9Tk?=
 =?us-ascii?Q?2cOgnwA2wef659Vf/2ejXcOM9FGvX+oKOPtBi84qxyUmDdX7OnFNS7r4UWmF?=
 =?us-ascii?Q?/rhAs1nl+UCoIQZB7U1cxNZKHws7ydOahWwLFUQ0GFyVXI18KoZwAsyhUL9L?=
 =?us-ascii?Q?N9ZnlOeArZCHqz7oWCf2HwPgPQhOxgkhP6bUmhZRyCWNYSNdCR9Qf+vpCyeB?=
 =?us-ascii?Q?Oi8Z148T8AbvrR1rM513ZQ5eXqFkSl5UIM1/Kxph5bpJxhB9il/8w0A3K9is?=
 =?us-ascii?Q?BQY1KiJfhs1wKXEiJIFqEkz7OTnr92pxCHtEdxWhZgyijvktY27o7w47T/h+?=
 =?us-ascii?Q?1xSVCgoSvEZeLwwYNU8NmiqHrIihUeeQ00ZDH9vqFsn25NU+Ofu1bYwg07UF?=
 =?us-ascii?Q?KRo6OHorHECpQgiu2c1Ofn+W3psYtzmKZtck1BBIrO4C5PGkXiojgjFpFqyq?=
 =?us-ascii?Q?vhKNzsBHp2BhRYcBg+8epWYAmLdne/Og11pyjGh9w/Fc38Y8j1E4fDoLDNEx?=
 =?us-ascii?Q?Ah5KtB+jG3IaQ8FN5AOsVrzSBM14fA6msTG6NmzNuxuRvJBGoHVsHW1xX02s?=
 =?us-ascii?Q?w+gSQ0Zxop+6yKjFW3nNLTdT8a/CM+sgED5vXYuTSRHdR1sR2UEq9nN0ycbA?=
 =?us-ascii?Q?h7OFO+kvprmJE1WsoftydQHmMiZe2g9HjssBp1c6d8fDHNG1/iGDg63SRm/8?=
 =?us-ascii?Q?GJubKuqQehjxYv1fCa7zOn54ELqjEo464scKrC++eGetpL940afRZNXWSGED?=
 =?us-ascii?Q?uyry3oyKUP6WuesZVOTUY/8dYyJXR3VaXnCgbsHRdG9A38OlQGqYkcwK0+H0?=
 =?us-ascii?Q?IxCRW0ZcDepR+LbdrsJE/gCdCu54//pUn5gJiYurxGLexWzR5Z86EYtA2a2H?=
 =?us-ascii?Q?7JC4z+//XEC+xoKfi8JOGVcK5CFluKxO3EZ3NO0ogiL90J+/Z0BbitYv9u/j?=
 =?us-ascii?Q?ddqoEL7opSPStzlhS8ujH1m8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c788e6fb-e877-44a9-8c65-08d8dc4f99ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:11.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfoKTMHFIiGnc9A2J90AYwBVmrdVBTsyHIvS2T5OrN/JRDYR5GNAb1oHChHNt916Ylsn6z1TYCbBnYZ+ZUKI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
 drivers/clocksource/hyperv_timer.c | 180 ++++++++++++++++++++++++++-----------
 include/asm-generic/mshyperv.h     |   5 --
 include/clocksource/hyperv_timer.h |   3 +-
 6 files changed, 132 insertions(+), 72 deletions(-)

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
index cdb8e0c..b2bf5e5 100644
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
@@ -169,10 +182,70 @@ int hv_stimer_cleanup(unsigned int cpu)
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
+	if (stimer0_irq == -1) {
+		hv_remove_stimer0_handler();
+	} else {
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
@@ -188,29 +261,37 @@ int hv_stimer_alloc(void)
 
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
@@ -254,23 +335,6 @@ void hv_stimer_legacy_cleanup(unsigned int cpu)
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
@@ -287,12 +351,17 @@ void hv_stimer_global_cleanup(void)
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
 
@@ -454,9 +523,14 @@ static bool __init hv_init_tsc_clocksource(void)
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

