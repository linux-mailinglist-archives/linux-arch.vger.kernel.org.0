Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C586D4F7D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjDCRqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDCRpX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:45:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF13C10;
        Mon,  3 Apr 2023 10:44:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso33392930pjb.3;
        Mon, 03 Apr 2023 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgf457aunDrkl2WhwoRG8QIPPft59HyZBgW7yaFAyA4=;
        b=OMShyxyPTVdfPfhFnqcPIKKLJd2IIWaJNF8XCVmJ3jVqpq3RDw2zJCNHAZrZd7kV/g
         cMCkpcLcVznjFi8A5KmvMhRuVJ8Flr/3oSRaQaCSuCwGnUBJozqaiXaX1SovzkmEMQNm
         XERfLsjYJrV+lOrQpVdQfrMBkH8rxgczU9jxj1v09GNDz32YNr+FVEOhBR2DpFGJ983c
         HifoDUEDYfaBo6JVBgjfmY3uK+ek4KBaPOSQnh17oO/DHnWkhUN63VZ6e1o8gF561fww
         vXwGzKxvMYylLW8dADI7aW4TQpzTyrMURnF3mcXG/FKqE6fruUBJ5Y223x2uwwfROYDC
         DZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgf457aunDrkl2WhwoRG8QIPPft59HyZBgW7yaFAyA4=;
        b=wNO9hJUqjFCw4EyYYyBuyo1MkNOL69lzbWdR0S0g8GIidLIaU+P6YMdIMUzLFn6q5R
         GXCZDMTVkilpF35xmUCNcAcRm7jzMVmMgoDjE/ht2YtGR147wUnXx1nuUrp6JvSYns5I
         Y1C8ylr9rUJs5rpbMVdlKMyPPkh97WBmvd2qOdY2riYZzKtRch8c57dmJNX73fBWf8ja
         x7dUQD4l1cTZHI1EnZMCDyQ90TjrSNWs5epPuFg56FV1jWifdA8U//AFNPEabeuL+jW1
         uy/lyDacFAM0s7maMa0qgW6GRcQma5CY94mPlZYkMAVQuKW80fi2ftXgrV6D+rjdSS/S
         ncGA==
X-Gm-Message-State: AAQBX9dNkizFL0wkdTkf7Ea2aG1xejuir4LWDGY6ovCC6Z05boyCdf8Z
        1FH+uMKqI/5j91hN9anbQYw=
X-Google-Smtp-Source: AKy350ap5d9DGz1XnWBU56RZbP9TcA2E7/HgF6MA7iTiEtbMMw/LoWZiaPBQElRAKwCvxW9xWzeefA==
X-Received: by 2002:a17:902:7c11:b0:1a0:566c:aaf8 with SMTP id x17-20020a1709027c1100b001a0566caaf8mr31283646pll.27.1680543871035;
        Mon, 03 Apr 2023 10:44:31 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:30 -0700 (PDT)
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
Subject: [RFC PATCH V4 16/17] x86/sev: Fix interrupt exit code paths from #HV exception
Date:   Mon,  3 Apr 2023 13:44:04 -0400
Message-Id: <20230403174406.4180472-17-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/x86/kernel/sev.c           | 34 +++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 22ac10a7b34f..08cc99936531 100644
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
index 2c964f7ac7dc..32d7dd0159ac 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -147,6 +147,10 @@ struct sev_hv_doorbell_page {
 
 struct sev_snp_runtime_data {
 	struct sev_hv_doorbell_page hv_doorbell_page;
+	/*
+	 * Indication that we are currently handling #HV events.
+	 */
+	bool hv_handling_events;
 };
 
 static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
@@ -202,6 +206,12 @@ static void do_exc_hv(struct pt_regs *regs)
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
@@ -236,6 +246,8 @@ static void do_exc_hv(struct pt_regs *regs)
 			common_interrupt(regs, pending_events.vector);
 		}
 	}
+
+	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
 }
 
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
@@ -2533,3 +2545,25 @@ static int __init snp_init_platform_device(void)
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

