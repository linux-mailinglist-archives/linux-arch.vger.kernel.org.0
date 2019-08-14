Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912AF8D329
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNMch (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 08:32:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36915 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNMch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 08:32:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so20202833pgp.4;
        Wed, 14 Aug 2019 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRBqiCdvpXqOkL/WM9A4HqBy4MpVKKMPnymNrlH0bgE=;
        b=bQvxaCSlgO0OHvR5lamJbX8KAEZPgsvcoCmQAIorMCFkQWDgZDLJO7/2A43mKVACHE
         cJHBtvwYQN77jHGyc9fs7ZnK+5DnkqVDsLHOvAzCT0V82sCAz3mXfb0K0Gv/Na5RDLqW
         evO9of2oY35uEdTuYtCEd2sxsghvYWqCaynhUUTTUuflS0N59Wk7wgSjLU3ps8xMY9i+
         HSbY8jyg06SbimoRe0DDwzTFhI0UXSwJKaxp3kfyVqBgBkeUp5aarr9YXAhgLzhcK89v
         e3TdS2Hgk+Ih9l46EbW1TwvUgghHRCOloJ3mJ0lYiKOV/KK0V/wVkwma31zLC1cS1BvT
         E5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yRBqiCdvpXqOkL/WM9A4HqBy4MpVKKMPnymNrlH0bgE=;
        b=hoZpLHOsSW7aOZpg8MmgptqkjgKUu7o4F0cA4TNVSLiTRDf63qgqYcb75oO9egLVUI
         9XX35H9EVnpd4PdULYPHL22zV1sNsBMG6UNf/8CBPUEQLh5M4AY+0O0V7VxQLBjeQDPW
         vDDKI3C1547sVTeD2SZAwmUmeGqCT0RDTN01qPFhPWl4zxUEVQP36LKAkoV6mSczkQh2
         W7gNk4eC6vjSULP0ttNQH/J7DUt0KOvqKtlK8IMgqQYGcrngBplesoubFj1xCBKW/MUc
         OIIu/Xb6KUOrmNczcrWBUTEHFTjmlZzuOn9PH92L+J9N+rXbjjl/MrDn4+iWAYjUDT1v
         dgMw==
X-Gm-Message-State: APjAAAWujTzwnL56hd/I4paWxYShj/+6Ky3RgmmaLtAP7vwv5dDG1axT
        qYv5PKmGXv1hx5nrjUTs3cQ=
X-Google-Smtp-Source: APXvYqwmxV8GqjiaZErHdEmtH3XJNXU3OtVOcDARB7OoNEfI0kwU6mw2I/AGyCSeal8g1n8jdf/blw==
X-Received: by 2002:a63:9245:: with SMTP id s5mr39611419pgn.123.1565785956014;
        Wed, 14 Aug 2019 05:32:36 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id u69sm135276430pgu.77.2019.08.14.05.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 05:32:35 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 2/2] clocksource/Hyper-V:  Add Hyper-V specific sched clock function
Date:   Wed, 14 Aug 2019 20:32:16 +0800
Message-Id: <20190814123216.32245-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
References: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
on x86.  But native_sched_clock() directly uses the raw TSC value, which
can be discontinuous in a Hyper-V VM. Add the generic hv_setup_sched_clock()
to set the sched clock function appropriately. On x86, this sets pv_ops.time.
sched_clock to read the Hyper-V reference TSC value that is scaled and adjusted
to be continuous.

Also move the Hyper-V reference TSC initialization much earlier in the boot
process so no discontinuity is observed when pv_ops.time.sched_clock
calculates its offset.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |  2 --
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
 drivers/clocksource/hyperv_timer.c | 22 ++++++++++++----------
 include/asm-generic/mshyperv.h     |  1 +
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0d258688c8cf..866dfb3dca48 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -301,8 +301,6 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
-	/* Register Hyper-V specific clocksource */
-	hv_init_clocksource();
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 062f77279ce3..53afd33990eb 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -29,6 +29,7 @@
 #include <asm/timer.h>
 #include <asm/reboot.h>
 #include <asm/nmi.h>
+#include <clocksource/hyperv_timer.h>
 
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
@@ -338,9 +339,16 @@ static void __init ms_hyperv_init_platform(void)
 		x2apic_phys = 1;
 # endif
 
+	/* Register Hyper-V specific clocksource */
+	hv_init_clocksource();
 #endif
 }
 
+void hv_setup_sched_clock(void *sched_clock)
+{
+	pv_ops.time.sched_clock = sched_clock;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 432aa331df04..dad8af198e20 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -215,6 +215,7 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
 #ifdef CONFIG_HYPERV_TSCPAGE
 
 static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
+static u64 hv_sched_clock_offset __ro_after_init;
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
@@ -222,7 +223,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_sched_clock_tsc(void)
+static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
 	u64 current_tick = hv_read_tsc_page(&tsc_pg);
 
@@ -232,9 +233,9 @@ static u64 notrace read_hv_sched_clock_tsc(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_tsc(struct clocksource *arg)
+static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_sched_clock_tsc();
+	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_tsc = {
@@ -246,7 +247,7 @@ static struct clocksource hyperv_cs_tsc = {
 };
 #endif
 
-static u64 notrace read_hv_sched_clock_msr(void)
+static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 {
 	u64 current_tick;
 	/*
@@ -258,9 +259,9 @@ static u64 notrace read_hv_sched_clock_msr(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_msr(struct clocksource *arg)
+static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_sched_clock_msr();
+	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
@@ -298,8 +299,9 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_tsc);
+
 	return true;
 }
 #else
@@ -329,7 +331,7 @@ void __init hv_init_clocksource(void)
 	hyperv_cs = &hyperv_cs_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_msr, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 0becb7d9704d..18d8e2d8210f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -167,6 +167,7 @@ void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
+void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline void hyperv_cleanup(void) {}
-- 
2.14.5

