Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05F6F2FA3
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjEAI7v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjEAI7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:59:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585410D8;
        Mon,  1 May 2023 01:57:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaebed5bd6so8315655ad.1;
        Mon, 01 May 2023 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931471; x=1685523471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85FbKOIGeJKFvrZkC+4B4Gx5bHvgxBGU0hkt5+QsJqk=;
        b=CYmVFe1ZSITuLQYsYizoY0KSUhYRoc3Md2T3+Zn3YfBMhN96TjlaesKr0AHYkxYL3v
         xf6KqM2vo4FHnlA9N+jobMd2j0rw9GmXaOyD0ksuq3xqSRXWNriRp1dywc02INgHtJOa
         7ZQiLnu7ypHI1/DM3yog6Eq+UrjNGY43okh2hO6Y+VBY2FRliX/lYTQpHj9uYd/JjXh0
         oTwSNOq7l/uXXvImVuBOg82rf4w0t0Wof18L+NUlLzWO5uEtCCvQPS7xzdWD9jG7qNqH
         nXXnq0yTNRHWetCQV7B+OgXJqrIfjSTNe2n4NCfq29mDprN2kOaC6zvS2JvyHgi1LXLT
         Xs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931471; x=1685523471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85FbKOIGeJKFvrZkC+4B4Gx5bHvgxBGU0hkt5+QsJqk=;
        b=EHi6CD/KDOYL8kMfViFr+rsD1X/LaCYXjAeq6z/n3O5NrAKXvVLgxVRnwvdLnZfW78
         h9LZsRYvH6QJwv4lncgjjTVmI/Tk3EJkMbK0v7dDz51kP1Rw0R2OSc6SenCF9KtBOeeK
         pT0tbAlu0mOUb9rc/jH925fW13B+x3Yj2vSXcLFHKCz+voT6Dmg6ul+72I4ZKghs4z8E
         8vxL8zn8lUlPXqivMP4gmSbI7SGRSMhr8xyhPTCeOO47dC3Wgm+wWey5VQ6t/hBoP32a
         ZlH31tk01ofH5rXkxsvn5LPjvfCG0NskuAggnbs/XBeM1DT7f4fr1K2umixQU7oGaHb6
         aAAw==
X-Gm-Message-State: AC+VfDyvodnaMuZ2NmRZI5wCTVLXhQaEvET97aBtMc0rZQMmpG/7H0sF
        zctloVaj/9wIrmcnl7xlEGA=
X-Google-Smtp-Source: ACHHUZ4pSFG50Yn3+YjfnFZIYk4iayAIyRl4ulCUswwf5cB7fb2dNgoNDk/UK/mdNoBXMvkT5zvNHA==
X-Received: by 2002:a17:903:2310:b0:1a6:54ce:4311 with SMTP id d16-20020a170903231000b001a654ce4311mr16387616plh.43.1682931471101;
        Mon, 01 May 2023 01:57:51 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:50 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V5 15/15] x86/sev: Fix interrupt exit code paths from #HV exception
Date:   Mon,  1 May 2023 04:57:25 -0400
Message-Id: <20230501085726.544209-16-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Add checks in interrupt exit code paths in case of returns
to user mode to check if currently executing the #HV handler
then don't follow the irqentry_exit_to_user_mode path as
that can potentially cause the #HV handler to be
preempted and rescheduled on another CPU. Rescheduled #HV
handler on another cpu will cause interrupts to be handled
on a different cpu than the injected one, causing
invalid EOIs and missed/lost guest interrupts and
corresponding hangs and/or per-cpu IRQs handled on
non-intended cpu.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
Change since RFC v3:
       * Add check of hv_handling_events in the do_exc_hv()
       	 to avoid nested entry.
---
 arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c           | 37 +++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b0f3501b2767..415b7e14c227 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,6 +13,10 @@
 
 #include <asm/irq_stack.h>
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
+#endif
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -176,6 +180,7 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
 #define DECLARE_IDTENTRY_IRQ(vector, func)				\
 	DECLARE_IDTENTRY_ERRORCODE(vector, func)
 
+#ifndef CONFIG_AMD_MEM_ENCRYPT
 /**
  * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
  * @func:	Function name of the entry point
@@ -205,6 +210,26 @@ __visible noinstr void func(struct pt_regs *regs,			\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
+#else
+
+#define DEFINE_IDTENTRY_IRQ(func)					\
+static void __##func(struct pt_regs *regs, u32 vector);		\
+									\
+__visible noinstr void func(struct pt_regs *regs,			\
+			    unsigned long error_code)			\
+{									\
+	irqentry_state_t state = irqentry_enter(regs);			\
+	u32 vector = (u32)(u8)error_code;				\
+									\
+	instrumentation_begin();					\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	run_irq_on_irqstack_cond(__##func, regs, vector);		\
+	instrumentation_end();						\
+	irqentry_exit_hv_cond(regs, state);				\
+}									\
+									\
+static noinline void __##func(struct pt_regs *regs, u32 vector)
+#endif
 
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
@@ -221,6 +246,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
 #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+#ifndef CONFIG_AMD_MEM_ENCRYPT
 /**
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
@@ -245,6 +271,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
+#else
+
+#define DEFINE_IDTENTRY_SYSVEC(func)					\
+static void __##func(struct pt_regs *regs);				\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	irqentry_state_t state = irqentry_enter(regs);			\
+									\
+	instrumentation_begin();					\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	run_sysvec_on_irqstack_cond(__##func, regs);			\
+	instrumentation_end();						\
+	irqentry_exit_hv_cond(regs, state);				\
+}									\
+									\
+static noinline void __##func(struct pt_regs *regs)
+#endif
+
+#ifndef CONFIG_AMD_MEM_ENCRYPT
 
 /**
  * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
@@ -274,6 +320,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
+#else
+
+#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	irqentry_state_t state = irqentry_enter(regs);			\
+									\
+	instrumentation_begin();					\
+	__irq_enter_raw();						\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	__##func(regs);						\
+	__irq_exit_raw();						\
+	instrumentation_end();						\
+	irqentry_exit_hv_cond(regs, state);				\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
+#endif
 
 /**
  * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b6becf158598..69b55075ddfe 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -149,6 +149,10 @@ struct sev_hv_doorbell_page {
 
 struct sev_snp_runtime_data {
 	struct sev_hv_doorbell_page hv_doorbell_page;
+	/*
+	 * Indication that we are currently handling #HV events.
+	 */
+	bool hv_handling_events;
 };
 
 static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
@@ -204,6 +208,12 @@ static void do_exc_hv(struct pt_regs *regs)
 {
 	union hv_pending_events pending_events;
 
+	/* Avoid nested entry. */
+	if (this_cpu_read(snp_runtime_data)->hv_handling_events)
+		return;
+
+	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
+
 	while (sev_hv_pending()) {
 		pending_events.events = xchg(
 			&sev_snp_current_doorbell_page()->pending_events.events,
@@ -218,7 +228,7 @@ static void do_exc_hv(struct pt_regs *regs)
 #endif
 
 		if (!pending_events.vector)
-			return;
+			goto out;
 
 		if (pending_events.vector < FIRST_EXTERNAL_VECTOR) {
 			/* Exception vectors */
@@ -238,6 +248,9 @@ static void do_exc_hv(struct pt_regs *regs)
 			common_interrupt(regs, pending_events.vector);
 		}
 	}
+
+out:
+	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
 }
 
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
@@ -2542,3 +2555,25 @@ static int __init snp_init_platform_device(void)
 	return 0;
 }
 device_initcall(snp_init_platform_device);
+
+noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
+{
+	/*
+	 * Check whether this returns to user mode, if so and if
+	 * we are currently executing the #HV handler then we don't
+	 * want to follow the irqentry_exit_to_user_mode path as
+	 * that can potentially cause the #HV handler to be
+	 * preempted and rescheduled on another CPU. Rescheduled #HV
+	 * handler on another cpu will cause interrupts to be handled
+	 * on a different cpu than the injected one, causing
+	 * invalid EOIs and missed/lost guest interrupts and
+	 * corresponding hangs and/or per-cpu IRQs handled on
+	 * non-intended cpu.
+	 */
+	if (user_mode(regs) &&
+	    this_cpu_read(snp_runtime_data)->hv_handling_events)
+		return;
+
+	/* follow normal interrupt return/exit path */
+	irqentry_exit(regs, state);
+}
-- 
2.25.1

