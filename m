Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238A58DB71
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244713AbiHIP5h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbiHIP5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 11:57:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C961EAD8;
        Tue,  9 Aug 2022 08:57:25 -0700 (PDT)
Date:   Tue, 9 Aug 2022 17:57:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660060643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GubbiwUJvNBdFSjuYJdN+rOiXh1SU5ITYieK1/sI9cQ=;
        b=kckf7Eubyl97DN9aFbx3BHVW22wozyeBdzuZ4L71VVUvvrnsyI2oswNZ3fnbFoCm6zx03I
        zZJTtaOW2ulrQ5dQWHDbTywKwDM8dS14rejL8pDMGB4YJUIGbXOe8KDCuGHvjhGmsd2xLr
        yVlvS57LFn9QtRzGYCTgfTChOro1vjZyuy9xFyVg1cIZUFFkU2pHgMgwghAxpCFNFkr7iB
        DcEp/KOcSchMzii01uEdTV6LLOMT2Qk5bGBn7mknf9vK73BnRor4C/dlPhL+/8QjFQ0UY5
        EkyZXlIdk48H31iog52zm6lt5MPH4rG2TOFqZJXER/r0iZPPVoGsccdawK8+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660060643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GubbiwUJvNBdFSjuYJdN+rOiXh1SU5ITYieK1/sI9cQ=;
        b=llCch5t2RIbNFZOUcGW/cFbAJ5cqY56yv2x1Dkfv11Fakk92thtJBPkgBy/DPHYaoNr/I9
        KeBpJFuO829LnkDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] asm-generic: Conditionally enable do_softirq_own_stack() via
 Kconfig.
Message-ID: <YvKD4hkZ3erf54DG@linutronix.de>
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
 <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the CONFIG_PREEMPT_RT symbol from the ifdef around
do_softirq_own_stack() and move it to Kconfig instead.

Enable softirq stacks based on SOFTIRQ_ON_OWN_STACK which depends on
HAVE_SOFTIRQ_ON_OWN_STACK and its default value is set to !PREEMPT_RT.
This ensures that softirq stacks are not used on PREEMPT_RT and avoids
a 'select' statement on an option which has a 'depends' statement.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/Kconfig                          | 4 ++++
 arch/arm/kernel/irq.c                 | 2 +-
 arch/parisc/kernel/irq.c              | 2 +-
 arch/powerpc/kernel/irq.c             | 4 ++--
 arch/s390/include/asm/softirq_stack.h | 2 +-
 arch/sh/kernel/irq.c                  | 2 +-
 arch/sparc/kernel/irq_64.c            | 2 +-
 arch/x86/include/asm/irq_stack.h      | 2 +-
 arch/x86/kernel/irq_32.c              | 2 +-
 include/asm-generic/softirq_stack.h   | 2 +-
 10 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a6..966aa6f82a5b9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -924,6 +924,10 @@ config HAVE_SOFTIRQ_ON_OWN_STACK
 	  Architecture provides a function to run __do_softirq() on a
 	  separate stack.
 
+config SOFTIRQ_ON_OWN_STACK
+	def_bool !PREEMPT_RT
+	depends on HAVE_SOFTIRQ_ON_OWN_STACK
+
 config ALTERNATE_USER_ADDRESS_SPACE
 	bool
 	help
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 034cb48c9eeb8..fe28fc1f759d9 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -70,7 +70,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(void *arg)
 {
 	__do_softirq();
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index fbb882cb8dbb5..b05055f3ba4b8 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,7 +480,7 @@ static void execute_on_irq_stack(void *func, unsigned long param1)
 	*irq_stack_in_use = 1;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0f17268c1f0bb..9ede61a5a469e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -199,7 +199,7 @@ static inline void check_stack_overflow(unsigned long sp)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static __always_inline void call_do_softirq(const void *sp)
 {
 	/* Temporarily switch r1 to sp, call __do_softirq() then restore r1. */
@@ -335,7 +335,7 @@ void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	call_do_softirq(softirq_ctx[smp_processor_id()]);
diff --git a/arch/s390/include/asm/softirq_stack.h b/arch/s390/include/asm/softirq_stack.h
index af68d6c1d5840..1ac5115d3115e 100644
--- a/arch/s390/include/asm/softirq_stack.h
+++ b/arch/s390/include/asm/softirq_stack.h
@@ -5,7 +5,7 @@
 #include <asm/lowcore.h>
 #include <asm/stacktrace.h>
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static inline void do_softirq_own_stack(void)
 {
 	call_on_stack(0, S390_lowcore.async_stack, void, __do_softirq);
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 9092767380780..4e6835de54cf8 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -149,7 +149,7 @@ void irq_ctx_exit(int cpu)
 	hardirq_ctx[cpu] = NULL;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct thread_info *curctx;
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 41fa1be980a33..72da2e10e2559 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -855,7 +855,7 @@ void __irq_entry handler_irq(int pil, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	void *orig_sp, *sp = softirq_stack[smp_processor_id()];
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 63f818aedf770..147cb8fdda92e 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -203,7 +203,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 /*
  * Macro to invoke __do_softirq on the irq stack. This is only called from
  * task context when bottom halves are about to be reenabled and soft
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index e5dd6da78713b..01833ebf5e8e3 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,7 +132,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/softirq_stack.h
index d3e2d81656e04..2a67aed9ac528 100644
--- a/include/asm-generic/softirq_stack.h
+++ b/include/asm-generic/softirq_stack.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
 #define __ASM_GENERIC_SOFTIRQ_STACK_H
 
-#if defined(CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK) && !defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
-- 
2.36.1

