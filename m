Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF7630B86
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiKSDt0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiKSDrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5ACC1F5E;
        Fri, 18 Nov 2022 19:47:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9929199pjg.5;
        Fri, 18 Nov 2022 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3qjpotohnIDBJGiUkElMdGRD5fwHCHM0g3ZymBFFdM=;
        b=KqwZEV8a2kCExG25rGD2s+E9r29CMfOLWEI86bfNZ028Q2ODuWjiRqtXxz4Yfqe2Gk
         Et1ESN8bYgHU+nb6o7DcYUyN3PhSMWQImHQGTMOZq9Zo9bVeZFM1AU86+p6yTHSklC5K
         nyk8O2oV6uxtfDyOieVgf1ytD7VJs85KpeV3VItmutk9G0vw8ouxH+4k/oQW+7eYEvrS
         KR4Lt86o15OJX4h6H7OWrFggi0tBzWmd6BZUPJDVKUs+5Ak454+507zJ82JpCDyTa/BH
         JgA3m/cApWx9CPYK8mPram4PJPfsfyrAmW38sEqJXwIQ5Zr+s891l5EPiaej/htuWFQy
         kRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3qjpotohnIDBJGiUkElMdGRD5fwHCHM0g3ZymBFFdM=;
        b=SMN7xx0jGwWIxV/0gin8HOG9eUjTNF1ekA9zBqU7BONP6X/3n97GQviKmPFDgJNpgF
         EDfIEIJ/PUDa0DJ/dku3E3iuy+L4D6iqNV4n7ZZAUgcUtctPz4t8gUY/zRw0rb6Mq5wN
         tkbwUFbsKH2V7wCRPxD52JjCRZ3QvrrL9k+Uy9/L8KJCrXoVwmgG4+jebLPs/DgqC6Dg
         rk/UDV2LoZHbAPcqNpbDkgEpTjSJONq8fhXao6uYbOiF4mszWMhKgRaC8WjFRXYhba+e
         aICI54+Dyh0QBPkmkCeLY92wsw1rTg8jWltjs4m52pj2WzWC+8mgI2BBG3PSQ1rbYdxi
         Sdsg==
X-Gm-Message-State: ANoB5plYSg8gVa9fml9i0OCFRbJmDnXst6dW0SU8klZg3hlurNVvvurI
        0JDf2Ouj3VtCCFjQ/9l00MJIxxkAVevkhA==
X-Google-Smtp-Source: AA0mqf7qGf73NCz68C5Wm69ao01VLtP2h0joAu+fhEKObXUUR3k8EPAUdcAla2AKrtCDtOPmEuEYlw==
X-Received: by 2002:a17:90a:39c9:b0:218:499b:bee9 with SMTP id k9-20020a17090a39c900b00218499bbee9mr11018497pjf.171.1668829622985;
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V2 18/18] x86/sev: Fix interrupt exit code paths from #HV exception
Date:   Fri, 18 Nov 2022 22:46:32 -0500
Message-Id: <20221119034633.1728632-19-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c           | 30 +++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 652fea10d377..45b47132be7c 100644
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
index 5a2f59022c98..ef6a123c50fe 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -153,6 +153,10 @@ struct sev_hv_doorbell_page {
 
 struct sev_snp_runtime_data {
 	struct sev_hv_doorbell_page hv_doorbell_page;
+	/*
+	 * Indication that we are currently handling #HV events.
+	 */
+	bool hv_handling_events;
 };
 
 static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
@@ -206,6 +210,8 @@ static void do_exc_hv(struct pt_regs *regs)
 	union hv_pending_events pending_events;
 	u8 vector;
 
+	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
+
 	while (sev_hv_pending()) {
 		asm volatile("cli" : : : "memory");
 
@@ -244,6 +250,8 @@ static void do_exc_hv(struct pt_regs *regs)
 
 		asm volatile("sti" : : : "memory");
 	}
+
+	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
 }
 
 void check_hv_pending(struct pt_regs *regs)
@@ -2541,3 +2549,25 @@ static int __init snp_init_platform_device(void)
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

