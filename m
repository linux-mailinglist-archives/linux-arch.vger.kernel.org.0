Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692C4786BB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2HxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 03:53:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40053 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2HxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 03:53:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so27578855pfp.7;
        Mon, 29 Jul 2019 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nV30ax2owcZ8dYmlfx3Sd29gsgHWTdEK1plVWhERPGw=;
        b=EJl6AC3btOoOLqQq1jQTx0PS4G+WvvWWsvqvqdHUpYmR01n+i8mnV45itQPuSIUgoo
         zcIWAXEGdC7baoI3FNHNNnquTZWD3vfefDFFNi/njS8gBs82EZ4sY8IJvlFQHWM61qZP
         Olcl3zqABYVqJSmoWUmE9VWxAFw6exlisTiw13bTQ3qBT0Fbw6YRXTutPgQF2lxuzl1m
         b756BeMDOz2g0U/+hK1FDOe3HgfKuH0L94naHddA0E0E+Nf51eQ2BOjf4W9lTZuQh8sn
         kR8FjmI3rz1c/nEp7A267k8ovQrsPtcfivV/fNhDC260ga3sDAtELJdD3tC+Zb+3dGPE
         NJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nV30ax2owcZ8dYmlfx3Sd29gsgHWTdEK1plVWhERPGw=;
        b=pB+6t2qV8ecSNV7O/MxJIXWjYRMLkM1osCcQGgkEcCkt1BkmX2Eck7w5C8gBCanflK
         B4yOR48aGZdGLBCqA+pA75COO0ggK3/7uZYuux56dxy9I7T89JFqtyDCTZ1dgIuvWMHy
         p0OtYcC5Xy6/AWmvhmrrzf+XC8AO5KVLT6zDlllfTE1+VLYEt1OI1Lg8uQ5iLQVw9nRF
         Ox3ZZhHUPGY+cZG6F5NANO8wLh+ZuGtighQgHqAIy7AWEmJas2cEJqsEJltnrwleCA74
         XiSh6xOHSvtXX4Vu694aTAK7jSEpzUvlJUCdzqF2La67EOrOpp8M57gS2OfUO7az5zNC
         5nqQ==
X-Gm-Message-State: APjAAAUDgadRjqPy13/duY1aQePxb9a8WISKDeeunM/yaplVLGaQ7DPc
        bkxes8trPdLDcFxhHp/BZb4=
X-Google-Smtp-Source: APXvYqw8youGAIY7O2MsetpRD8NwnPrzV035+W6h4D6GTapJmZvoo5eUP/YmTBB/jzUGqeO8fUmKLw==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr35569997pfa.126.1564386784413;
        Mon, 29 Jul 2019 00:53:04 -0700 (PDT)
Received: from SAW-L7607608QSA.guest.corp.microsoft.com ([167.220.255.91])
        by smtp.googlemail.com with ESMTPSA id s5sm40878033pfm.97.2019.07.29.00.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 00:53:03 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 2/2] clocksource/Hyper-V:  Add Hyper-V specific sched clock function
Date:   Mon, 29 Jul 2019 15:52:43 +0800
Message-Id: <20190729075243.22745-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
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
index 86764ec9a854..eafca89b44d7 100644
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

