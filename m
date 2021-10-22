Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C824379D1
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhJVP0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhJVP0p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189DC061764;
        Fri, 22 Oct 2021 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YuyqTWtmDeLmcAb29SJGW5zk7v4U9whchNt4bJc1pC4=; b=OWYiEhdCJozrOv5Ampb5c8qs1s
        SObZb3sQ+eisOGy/Geizw37COSGwsBhOus9PfuHCcGGtFEVlDZrV3lEPzBoS/LPE7mtuUhGZQo7tg
        l95LdTfw7s3pHMtZzzMaUuwASILvOUckcgPULk30fK888DWKEkDIgxf2WwRhDxFdzj6xB8z36JxsO
        jXgak5ar95yisRw0otfVzq8Pqsa33WVfLqit7tte2Ob6dnx0j8bpt4N9hN89wM6uEVze2Oi+sbN3c
        rfIIfVCISFoNXVvq76Z/CmHNQhh7XLuBfbKQme9/+BZQst0CdSfvGH5f14FuIlvCM9Z1D5H1pnRMh
        aH6tzIVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00BbM2-52; Fri, 22 Oct 2021 15:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 887473006C2;
        Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A7462C0CA17E; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.285488044@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 3/7] ARM: implement ARCH_STACKWALK
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Implement the flavor of CONFIG_STACKTRACE that relies mostly on generic
code, and only need a small arch_stack_walk() helper that performs the
actual frame unwinding.

Note that this removes the SMP check that used to live in
__save_stack_trace(), but this is no longer needed now that the generic
version of save_stack_trace_tsk() takes care not to walk the call stack
of tasks that are live on other CPUs.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/Kconfig             |    1 
 arch/arm/kernel/stacktrace.c |  114 +++++++------------------------------------
 2 files changed, 20 insertions(+), 95 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
+	select ARCH_STACKWALK
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 
 #include <asm/sections.h>
@@ -87,106 +88,29 @@ void notrace walk_stackframe(struct stac
 EXPORT_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
-
-static int save_trace(struct stackframe *frame, void *d)
-{
-	struct stack_trace_data *data = d;
-	struct stack_trace *trace = data->trace;
-	struct pt_regs *regs;
-	unsigned long addr = frame->pc;
-
-	if (data->no_sched_functions && in_sched_functions(addr))
-		return 0;
-	if (data->skip) {
-		data->skip--;
-		return 0;
-	}
-
-	trace->entries[trace->nr_entries++] = addr;
-
-	if (trace->nr_entries >= trace->max_entries)
-		return 1;
-
-	if (!in_entry_text(frame->pc))
-		return 0;
-
-	regs = (struct pt_regs *)frame->sp;
-	if ((unsigned long)&regs[1] > ALIGN(frame->sp, THREAD_SIZE))
-		return 0;
-
-	trace->entries[trace->nr_entries++] = regs->ARM_pc;
-
-	return trace->nr_entries >= trace->max_entries;
-}
-
-/* This must be noinline to so that our skip calculation works correctly */
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
+noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
+				      void *cookie, struct task_struct *task,
+				      struct pt_regs *regs)
 {
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
-#ifdef CONFIG_SMP
-		/*
-		 * What guarantees do we have here that 'tsk' is not
-		 * running on another CPU?  For now, ignore it as we
-		 * can't guarantee we won't explode.
-		 */
-		return;
-#else
-		frame.fp = thread_saved_fp(tsk);
-		frame.sp = thread_saved_sp(tsk);
-		frame.lr = 0;		/* recovered from the stack */
-		frame.pc = thread_saved_pc(tsk);
-#endif
+	if (regs) {
+		frame.fp = IS_ENABLED(CONFIG_THUMB2_KERNEL) ? regs->ARM_r7
+							    : regs->ARM_fp;
+		frame.sp = regs->ARM_sp;
+		frame.lr = regs->ARM_lr;
+		frame.pc = regs->ARM_pc;
 	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
-		frame.fp = (unsigned long)__builtin_frame_address(0);
-		frame.sp = current_stack_pointer;
-		frame.lr = (unsigned long)__builtin_return_address(0);
-		frame.pc = (unsigned long)__save_stack_trace;
+		frame.fp = thread_saved_fp(task);
+		frame.sp = thread_saved_sp(task);
+		frame.lr = 0;                   /* recovered from the stack */
+		frame.pc = thread_saved_pc(task);
 	}
 
-	walk_stackframe(&frame, save_trace, &data);
-}
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	struct stack_trace_data data;
-	struct stackframe frame;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = 0;
-
-	frame.fp = regs->ARM_fp;
-	frame.sp = regs->ARM_sp;
-	frame.lr = regs->ARM_lr;
-	frame.pc = regs->ARM_pc;
-
-	walk_stackframe(&frame, save_trace, &data);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	__save_stack_trace(tsk, trace, 1);
-}
-EXPORT_SYMBOL(save_stack_trace_tsk);
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	for (;;) {
+		if (unwind_frame(&frame) < 0 ||
+		    !consume_entry(cookie, frame.pc))
+			break;
+	}
 }
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif


