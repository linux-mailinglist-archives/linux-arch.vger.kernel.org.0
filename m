Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357F260E28D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiJZNtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiJZNsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 09:48:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 260754DB44;
        Wed, 26 Oct 2022 06:48:17 -0700 (PDT)
Received: from anrayabh-desk.corp.microsoft.com (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5E5BC210AF1E;
        Wed, 26 Oct 2022 06:48:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E5BC210AF1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666792097;
        bh=XpK1X4zhf3TiHKLaOrNIEobrLMtZr0H214Cll4f/OsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbMgTmVDjRypDBMGQCoY/WEcjAKoYiqGtbMw7VkVQCYwmx96GFslPqIgK9LXhWMkD
         KoOtLQIBZT6ugsXoEcRBbketkQoxa5gk4b3zu7wasD7XT3GcqAUvbMkx6qnGYjp8k5
         EigtvY+winLAwR0gxpSi4HqGK/bXuoqTj6d5aUCc=
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, daniel.lezcano@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, mail@anirudhrb.com
Subject: [PATCH 2/2] clocksource/drivers/hyperv: add data structure for reference TSC MSR
Date:   Wed, 26 Oct 2022 19:17:15 +0530
Message-Id: <20221026134715.1438789-3-anrayabh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a data structure to represent the reference TSC MSR similar to
other MSRs. This simplifies the code for updating the MSR.

Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c          | 10 +++++-----
 drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
 include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 76ff63d69461..78993148d14c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -537,7 +537,7 @@ void __init hyperv_init(void)
 void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
-	u64 tsc_msr;
+	union hv_reference_tsc_msr tsc_msr;
 
 	unregister_syscore_ops(&hv_syscore_ops);
 
@@ -557,10 +557,10 @@ void hyperv_cleanup(void)
 	hypercall_msr.enable = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	/* Reset the TSC page */
-	rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
-	tsc_msr &= ~BIT_ULL(0);
-	wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
+	/* Reset the TSC page. */
+	rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
+	tsc_msr.enable = 0;
+	wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bb47610bbd1c..11332c82d1af 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -395,25 +395,25 @@ static u64 notrace read_hv_sched_clock_tsc(void)
 
 static void suspend_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 tsc_msr;
+	union hv_reference_tsc_msr tsc_msr;
 
 	/* Disable the TSC page */
-	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
-	tsc_msr &= ~BIT_ULL(0);
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
+	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.enable = 0;
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 
 static void resume_hv_clock_tsc(struct clocksource *arg)
 {
 	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
-	u64 tsc_msr;
+	union hv_reference_tsc_msr tsc_msr;
 
 	/* Re-enable the TSC page */
-	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
-	tsc_msr &= GENMASK_ULL(11, 0);
-	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
+	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.enable = 1;
+	tsc_msr.pfn = __phys_to_pfn(phys_addr);
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
@@ -495,7 +495,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 
 static bool __init hv_init_tsc_clocksource(void)
 {
-	u64		tsc_msr;
+	union hv_reference_tsc_msr tsc_msr;
 	phys_addr_t	phys_addr;
 
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
@@ -530,10 +530,10 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * (which already has at least the low 12 bits set to zero since
 	 * it is page aligned). Also set the "enable" bit, which is bit 0.
 	 */
-	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
-	tsc_msr &= GENMASK_ULL(11, 0);
-	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
+	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.enable = 1;
+	tsc_msr.pfn = __phys_to_pfn(phys_addr);
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index fdce7a4cfc6f..b17c6eeb9afa 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -102,6 +102,15 @@ struct ms_hyperv_tsc_page {
 	volatile s64 tsc_offset;
 } __packed;
 
+union hv_reference_tsc_msr {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 reserved:11;
+		u64 pfn:52;
+	} __packed;
+};
+
 /*
  * The guest OS needs to register the guest ID with the hypervisor.
  * The guest ID is a 64 bit entity and the structure of this ID is
-- 
2.34.1

