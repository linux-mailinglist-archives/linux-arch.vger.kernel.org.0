Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3A765C82
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjG0TzD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjG0TzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:55:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4275A2D75;
        Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7376A2380B35;
        Thu, 27 Jul 2023 12:54:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7376A2380B35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690487696;
        bh=TuWZVWY1iff+LQJSSMh+jcbNrniyMsZC/zJdKAe62lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qrw77F109OKgyWZ3v+4fuwgpRvakBiFyX+nnIIS4wAgxOq8kpC7iqTI12m0M3ji9v
         eR0ofilfBiR/qT0F2BpMWr2Yqk7Ybv9dUQoe/j5hqIrny+Yo7DqTB+dpRZjxyjmAH+
         lxo7tYrcuyY9dFOSeQPi6v+d9EUtuQb8oLr6BJec=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH 01/15] hyperv-tlfs: Change shared HV_REGISTER_* defines to HV_MSR_*
Date:   Thu, 27 Jul 2023 12:54:36 -0700
Message-Id: <1690487690-2428-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
VP registers accessed via get/set vp registers hypercall.

This is due to HV_REGISTER_* names being used by hv_set/get_register,
with the arch-specific version delegating to the appropriate mechanism.

The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
VP registers when they are introduced for x86 in future.

This patch solves the issue by:

1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
   This is so HV_REGISTER_ can be reserved for VP registers.

2. Change the non-arch-specific alias used by hv_set/get_register to
   HV_MSR_. This is also happens to be the same name HyperV uses for this
   purpose.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/include/asm/hyperv-tlfs.h |  25 +++++
 arch/x86/include/asm/hyperv-tlfs.h   | 137 +++++++++++++--------------
 arch/x86/include/asm/mshyperv.h      |   8 +-
 arch/x86/kernel/cpu/mshyperv.c       |  22 ++---
 drivers/clocksource/hyperv_timer.c   |  24 ++---
 drivers/hv/hv.c                      |  32 +++----
 drivers/hv/hv_common.c               |  18 ++--
 include/asm-generic/mshyperv.h       |   2 +-
 8 files changed, 146 insertions(+), 122 deletions(-)

diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
index bc6c7ac934a1..a6e852c2fc3a 100644
--- a/arch/arm64/include/asm/hyperv-tlfs.h
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -64,6 +64,31 @@
 #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
 #define HV_REGISTER_STIMER0_COUNT	0x000B0001
 
+/*
+ * To support non-arch-specific code calling hv_set/get_register:
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
+ * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
+ */
+#define HV_MSR_VP_INDEX		(HV_REGISTER_VP_INDEX)
+#define HV_MSR_TIME_REF_COUNT	(HV_REGISTER_TIME_REF_COUNT)
+#define HV_MSR_REFERENCE_TS	(HV_REGISTER_REFERENCE_TSC)
+
+#define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
+#define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
+
+#define HV_MSR_SCONTROL		(HV_REGISTER_SCONTROL)
+#define HV_MSR_SIEFP		(HV_REGISTER_SIEFP)
+#define HV_MSR_SIMP		(HV_REGISTER_SIMP)
+#define HV_MSR_EOM		(HV_REGISTER_EOM)
+#define HV_MSR_SINT0		(HV_REGISTER_SINT0)
+
+#define HV_MSR_CRASH_P0		(HV_REGISTER_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_REGISTER_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_REGISTER_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_REGISTER_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_REGISTER_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_REGISTER_CRASH_CTL)
+
 union hv_msi_entry {
 	u64 as_uint64[2];
 	struct {
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index cea95dcd27c2..40902a767733 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -181,7 +181,7 @@ enum hv_isolation_type {
 #define HV_X64_MSR_HYPERCALL			0x40000001
 
 /* MSR used to provide vcpu index */
-#define HV_REGISTER_VP_INDEX			0x40000002
+#define HV_X64_MSR_VP_INDEX			0x40000002
 
 /* MSR used to reset the guest OS. */
 #define HV_X64_MSR_RESET			0x40000003
@@ -190,10 +190,10 @@ enum hv_isolation_type {
 #define HV_X64_MSR_VP_RUNTIME			0x40000010
 
 /* MSR used to read the per-partition time reference counter */
-#define HV_REGISTER_TIME_REF_COUNT		0x40000020
+#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
 
 /* A partition's reference time stamp counter (TSC) page */
-#define HV_REGISTER_REFERENCE_TSC		0x40000021
+#define HV_X64_MSR_REFERENCE_TSC		0x40000021
 
 /* MSR used to retrieve the TSC frequency */
 #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
@@ -208,61 +208,61 @@ enum hv_isolation_type {
 #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
 
 /* Define synthetic interrupt controller model specific registers. */
-#define HV_REGISTER_SCONTROL			0x40000080
-#define HV_REGISTER_SVERSION			0x40000081
-#define HV_REGISTER_SIEFP			0x40000082
-#define HV_REGISTER_SIMP			0x40000083
-#define HV_REGISTER_EOM				0x40000084
-#define HV_REGISTER_SINT0			0x40000090
-#define HV_REGISTER_SINT1			0x40000091
-#define HV_REGISTER_SINT2			0x40000092
-#define HV_REGISTER_SINT3			0x40000093
-#define HV_REGISTER_SINT4			0x40000094
-#define HV_REGISTER_SINT5			0x40000095
-#define HV_REGISTER_SINT6			0x40000096
-#define HV_REGISTER_SINT7			0x40000097
-#define HV_REGISTER_SINT8			0x40000098
-#define HV_REGISTER_SINT9			0x40000099
-#define HV_REGISTER_SINT10			0x4000009A
-#define HV_REGISTER_SINT11			0x4000009B
-#define HV_REGISTER_SINT12			0x4000009C
-#define HV_REGISTER_SINT13			0x4000009D
-#define HV_REGISTER_SINT14			0x4000009E
-#define HV_REGISTER_SINT15			0x4000009F
+#define HV_X64_MSR_SCONTROL			0x40000080
+#define HV_X64_MSR_SVERSION			0x40000081
+#define HV_X64_MSR_SIEFP			0x40000082
+#define HV_X64_MSR_SIMP				0x40000083
+#define HV_X64_MSR_EOM				0x40000084
+#define HV_X64_MSR_SINT0			0x40000090
+#define HV_X64_MSR_SINT1			0x40000091
+#define HV_X64_MSR_SINT2			0x40000092
+#define HV_X64_MSR_SINT3			0x40000093
+#define HV_X64_MSR_SINT4			0x40000094
+#define HV_X64_MSR_SINT5			0x40000095
+#define HV_X64_MSR_SINT6			0x40000096
+#define HV_X64_MSR_SINT7			0x40000097
+#define HV_X64_MSR_SINT8			0x40000098
+#define HV_X64_MSR_SINT9			0x40000099
+#define HV_X64_MSR_SINT10			0x4000009A
+#define HV_X64_MSR_SINT11			0x4000009B
+#define HV_X64_MSR_SINT12			0x4000009C
+#define HV_X64_MSR_SINT13			0x4000009D
+#define HV_X64_MSR_SINT14			0x4000009E
+#define HV_X64_MSR_SINT15			0x4000009F
 
 /*
  * Define synthetic interrupt controller model specific registers for
  * nested hypervisor.
  */
-#define HV_REGISTER_NESTED_SCONTROL            0x40001080
-#define HV_REGISTER_NESTED_SVERSION            0x40001081
-#define HV_REGISTER_NESTED_SIEFP               0x40001082
-#define HV_REGISTER_NESTED_SIMP                0x40001083
-#define HV_REGISTER_NESTED_EOM                 0x40001084
-#define HV_REGISTER_NESTED_SINT0               0x40001090
+#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
+#define HV_X64_MSR_NESTED_SVERSION		0x40001081
+#define HV_X64_MSR_NESTED_SIEFP			0x40001082
+#define HV_X64_MSR_NESTED_SIMP			0x40001083
+#define HV_X64_MSR_NESTED_EOM			0x40001084
+#define HV_X64_MSR_NESTED_SINT0			0x40001090
 
 /*
  * Synthetic Timer MSRs. Four timers per vcpu.
  */
-#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
-#define HV_REGISTER_STIMER0_COUNT		0x400000B1
-#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
-#define HV_REGISTER_STIMER1_COUNT		0x400000B3
-#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
-#define HV_REGISTER_STIMER2_COUNT		0x400000B5
-#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
-#define HV_REGISTER_STIMER3_COUNT		0x400000B7
+#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
+#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
+#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
+#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
+#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
+#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
+#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
+#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
 
 /* Hyper-V guest idle MSR */
 #define HV_X64_MSR_GUEST_IDLE			0x400000F0
 
 /* Hyper-V guest crash notification MSR's */
-#define HV_REGISTER_CRASH_P0			0x40000100
-#define HV_REGISTER_CRASH_P1			0x40000101
-#define HV_REGISTER_CRASH_P2			0x40000102
-#define HV_REGISTER_CRASH_P3			0x40000103
-#define HV_REGISTER_CRASH_P4			0x40000104
-#define HV_REGISTER_CRASH_CTL			0x40000105
+#define HV_X64_MSR_CRASH_P0			0x40000100
+#define HV_X64_MSR_CRASH_P1			0x40000101
+#define HV_X64_MSR_CRASH_P2			0x40000102
+#define HV_X64_MSR_CRASH_P3			0x40000103
+#define HV_X64_MSR_CRASH_P4			0x40000104
+#define HV_X64_MSR_CRASH_CTL			0x40000105
 
 /* TSC emulation after migration */
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
@@ -275,31 +275,30 @@ enum hv_isolation_type {
 /* HV_X64_MSR_TSC_INVARIANT_CONTROL bits */
 #define HV_EXPOSE_INVARIANT_TSC		BIT_ULL(0)
 
-/* Register name aliases for temporary compatibility */
-#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
-#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
-#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
-#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
-#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
-#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
-#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
-#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
-#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
-#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
-#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
-#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
-#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
-#define HV_X64_MSR_EOM			HV_REGISTER_EOM
-#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
-#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
-#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
-#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
-#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
-#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
-#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
-#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
-#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
-#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
+/*
+ * To support non-arch-specific code calling hv_set/get_register:
+ * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
+ * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
+ */
+#define HV_MSR_VP_INDEX		(HV_X64_MSR_VP_INDEX)
+#define HV_MSR_TIME_REF_COUNT	(HV_X64_MSR_TIME_REF_COUNT)
+#define HV_MSR_REFERENCE_TSC	(HV_X64_MSR_REFERENCE_TSC)
+
+#define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
+#define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
+
+#define HV_MSR_SCONTROL		(HV_X64_MSR_SCONTROL)
+#define HV_MSR_SIEFP		(HV_X64_MSR_SIEFP)
+#define HV_MSR_SIMP		(HV_X64_MSR_SIMP)
+#define HV_MSR_EOM		(HV_X64_MSR_EOM)
+#define HV_MSR_SINT0		(HV_X64_MSR_SINT0)
+
+#define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_X64_MSR_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_X64_MSR_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_X64_MSR_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_X64_MSR_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_X64_MSR_CRASH_CTL)
 
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b445e252aa83..23cdcf6525dc 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -242,14 +242,14 @@ extern bool hv_isolation_type_snp(void);
 
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
-	return (reg >= HV_REGISTER_SCONTROL) &&
-	       (reg <= HV_REGISTER_SINT15);
+	return (reg >= HV_X64_MSR_SCONTROL) &&
+	       (reg <= HV_X64_MSR_SINT15);
 }
 
 static inline bool hv_is_sint_reg(unsigned int reg)
 {
-	return (reg >= HV_REGISTER_SINT0) &&
-	       (reg <= HV_REGISTER_SINT15);
+	return (reg >= HV_X64_MSR_SINT0) &&
+	       (reg <= HV_X64_MSR_SINT15);
 }
 
 u64 hv_get_register(unsigned int reg);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 29e1c0d5347a..57f6a5879b30 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -43,19 +43,19 @@ struct ms_hyperv_info ms_hyperv;
 static inline unsigned int hv_get_nested_reg(unsigned int reg)
 {
 	if (hv_is_sint_reg(reg))
-		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
+		return reg - HV_X64_MSR_SINT0 + HV_X64_MSR_NESTED_SINT0;
 
 	switch (reg) {
-	case HV_REGISTER_SIMP:
-		return HV_REGISTER_NESTED_SIMP;
-	case HV_REGISTER_SIEFP:
-		return HV_REGISTER_NESTED_SIEFP;
-	case HV_REGISTER_SVERSION:
-		return HV_REGISTER_NESTED_SVERSION;
-	case HV_REGISTER_SCONTROL:
-		return HV_REGISTER_NESTED_SCONTROL;
-	case HV_REGISTER_EOM:
-		return HV_REGISTER_NESTED_EOM;
+	case HV_X64_MSR_SIMP:
+		return HV_X64_MSR_NESTED_SIMP;
+	case HV_X64_MSR_SIEFP:
+		return HV_X64_MSR_NESTED_SIEFP;
+	case HV_X64_MSR_SVERSION:
+		return HV_X64_MSR_NESTED_SVERSION;
+	case HV_X64_MSR_SCONTROL:
+		return HV_X64_MSR_NESTED_SCONTROL;
+	case HV_X64_MSR_EOM:
+		return HV_X64_MSR_NESTED_EOM;
 	default:
 		return reg;
 	}
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bcd9042a0c9f..0e82b0db4f32 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
 
 	current_tick = hv_read_reference_counter();
 	current_tick += delta;
-	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
+	hv_set_register(HV_MSR_STIMER0_COUNT, current_tick);
 	return 0;
 }
 
 static int hv_ce_shutdown(struct clock_event_device *evt)
 {
-	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
-	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
+	hv_set_register(HV_MSR_STIMER0_COUNT, 0);
+	hv_set_register(HV_MSR_STIMER0_CONFIG, 0);
 	if (direct_mode_enabled && stimer0_irq >= 0)
 		disable_percpu_irq(stimer0_irq);
 
@@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		timer_cfg.direct_mode = 0;
 		timer_cfg.sintx = stimer0_message_sint;
 	}
-	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
+	hv_set_register(HV_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
 	return 0;
 }
 
@@ -398,7 +398,7 @@ static u64 notrace read_hv_clock_tsc(void)
 	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
-		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+		current_tick = hv_get_register(HV_MSR_TIME_REF_COUNT);
 
 	return current_tick;
 }
@@ -419,9 +419,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Disable the TSC page */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_register(HV_MSR_REFERENCE_TSC);
 	tsc_msr.enable = 0;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_register(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 
@@ -430,10 +430,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Re-enable the TSC page */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_register(HV_MSR_REFERENCE_TSC);
 	tsc_msr.enable = 1;
 	tsc_msr.pfn = tsc_pfn;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_register(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
@@ -467,7 +467,7 @@ static u64 notrace read_hv_clock_msr(void)
 	 * is set to 0 when the partition is created and is incremented in
 	 * 100 nanosecond units.
 	 */
-	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+	return hv_get_register(HV_MSR_TIME_REF_COUNT);
 }
 
 static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
@@ -554,14 +554,14 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * thus TSC clocksource will work even without the real TSC page
 	 * mapped.
 	 */
-	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	tsc_msr.as_uint64 = hv_get_register(HV_MSR_REFERENCE_TSC);
 	if (hv_root_partition)
 		tsc_pfn = tsc_msr.pfn;
 	else
 		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
 	tsc_msr.enable = 1;
 	tsc_msr.pfn = tsc_pfn;
-	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
+	hv_set_register(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 7f6b00af7f01..bffd15ce06f3 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -172,7 +172,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_register(HV_MSR_SIMP);
 	simp.simp_enabled = 1;
 
 	if (hv_isolation_type_snp() || hv_root_partition) {
@@ -188,10 +188,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_register(HV_MSR_SIMP, simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_register(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
 	if (hv_isolation_type_snp() || hv_root_partition) {
@@ -207,12 +207,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_register(HV_MSR_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+	shared_sint.as_uint64 = hv_get_register(HV_MSR_SINT0 +
 					VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = vmbus_interrupt;
@@ -228,14 +228,14 @@ void hv_synic_enable_regs(unsigned int cpu)
 #else
 	shared_sint.auto_eoi = 0;
 #endif
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	hv_set_register(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_register(HV_MSR_SCONTROL);
 	sctrl.enable = 1;
 
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_register(HV_MSR_SCONTROL, sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -259,17 +259,17 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+	shared_sint.as_uint64 = hv_get_register(HV_MSR_SINT0 +
 					VMBUS_MESSAGE_SINT);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+	hv_set_register(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	simp.as_uint64 = hv_get_register(HV_MSR_SIMP);
 	/*
 	 * In Isolation VM, sim and sief pages are allocated by
 	 * paravisor. These pages also will be used by kdump
@@ -284,9 +284,9 @@ void hv_synic_disable_regs(unsigned int cpu)
 		simp.base_simp_gpa = 0;
 	}
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_register(HV_MSR_SIMP, simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	siefp.as_uint64 = hv_get_register(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 0;
 
 	if (hv_isolation_type_snp() || hv_root_partition) {
@@ -296,12 +296,12 @@ void hv_synic_disable_regs(unsigned int cpu)
 		siefp.base_siefp_gpa = 0;
 	}
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	hv_set_register(HV_MSR_SIEFP, siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	sctrl.as_uint64 = hv_get_register(HV_MSR_SCONTROL);
 	sctrl.enable = 0;
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_register(HV_MSR_SCONTROL, sctrl.as_uint64);
 
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 64f9ceca887b..522d57a5e8a0 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -227,17 +227,17 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * contain the size of the panic data in that page. Rest of the
 	 * registers are no-op when the NOTIFY_MSG flag is set.
 	 */
-	hv_set_register(HV_REGISTER_CRASH_P0, 0);
-	hv_set_register(HV_REGISTER_CRASH_P1, 0);
-	hv_set_register(HV_REGISTER_CRASH_P2, 0);
-	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
-	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
+	hv_set_register(HV_MSR_CRASH_P0, 0);
+	hv_set_register(HV_MSR_CRASH_P1, 0);
+	hv_set_register(HV_MSR_CRASH_P2, 0);
+	hv_set_register(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_register(HV_MSR_CRASH_P4, bytes_written);
 
 	/*
 	 * Let Hyper-V know there is crash data available along with
 	 * the panic message.
 	 */
-	hv_set_register(HV_REGISTER_CRASH_CTL,
+	hv_set_register(HV_MSR_CRASH_CTL,
 			(HV_CRASH_CTL_CRASH_NOTIFY |
 			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
 }
@@ -310,7 +310,7 @@ int __init hv_common_init(void)
 		 * Register for panic kmsg callback only if the right
 		 * capability is supported by the hypervisor.
 		 */
-		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
+		hyperv_crash_ctl = hv_get_register(HV_MSR_CRASH_CTL);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
 			hv_kmsg_dump_register();
 
@@ -373,7 +373,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 	}
 
-	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
+	msr_vp_index = hv_get_register(HV_MSR_VP_INDEX);
 
 	hv_vp_index[cpu] = msr_vp_index;
 
@@ -477,7 +477,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
  */
 static u64 __hv_read_ref_counter(void)
 {
-	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+	return hv_get_register(HV_MSR_TIME_REF_COUNT);
 }
 
 u64 (*hv_read_reference_counter)(void) = __hv_read_ref_counter;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 402a8c1c202d..094c57320ed1 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -149,7 +149,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_set_register(HV_REGISTER_EOM, 0);
+		hv_set_register(HV_MSR_EOM, 0);
 	}
 }
 
-- 
2.25.1

