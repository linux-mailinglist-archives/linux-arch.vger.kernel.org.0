Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE95A0B69
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiHYI0F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiHYIZn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 04:25:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A674378;
        Thu, 25 Aug 2022 01:25:09 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:25:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661415906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I+OR5YB+BLFNevDPHUusJLUnA4AAkcWyBeiJfeMJGqo=;
        b=3IBTa8m0hYX4g47RaiT/8j8T78Oa8GCMeWBExbrcwFPwlNixTGZHdPyk8R7VZquIIC80wr
        H6RmoQrIcPVa4H/h/93KAfDCL3hxfKONW3wp2MYvaFs3atU9uhl+6WiYdRYcHRid1QerLu
        +hVKpdbrUHUp1h3DNx02k03TncLw98ur4aZoJ6LkSsRb2ORchWoqrEtkTc37dz456Z3BD7
        wTYUuuCNSZSGn0AO3JgapjpUscP1fq9xXEjUTjmdA1NlsK7m3XtvWEdE+3+2hj6tSpl+i9
        FLLfCJrZoNEm03/BcgXG8UsndhQVK4jTyAHPTt15wq1JOpmucrPRjg9TuUHISQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661415906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I+OR5YB+BLFNevDPHUusJLUnA4AAkcWyBeiJfeMJGqo=;
        b=qdOsv/2fa3HTVE2Xit7I736gOQEAJKwmF4VVbOVradxW8PYfqmDnSqxUbjhHENWiyBYRCB
        8EIV+CPZ3fm43FAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 REPOST] asm-generic: Conditionally enable
 do_softirq_own_stack() via Kconfig.
Message-ID: <Ywcx4QBdYNIBLJiy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Link: https://lore.kernel.org/YvN5E%2FPrHfUhggr7@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Arnd, could you please route it via your tree?=20

v1=E2=80=A6v2:
   - Use "def_bool HAVE_SOFTIRQ_ON_OWN_STACK && !PREEMPT_RT"

 arch/Kconfig                          |    3 +++
 arch/arm/kernel/irq.c                 |    2 +-
 arch/parisc/kernel/irq.c              |    2 +-
 arch/powerpc/kernel/irq.c             |    4 ++--
 arch/s390/include/asm/softirq_stack.h |    2 +-
 arch/sh/kernel/irq.c                  |    2 +-
 arch/sparc/kernel/irq_64.c            |    2 +-
 arch/x86/include/asm/irq_stack.h      |    2 +-
 arch/x86/kernel/irq_32.c              |    2 +-
 include/asm-generic/softirq_stack.h   |    2 +-
 10 files changed, 13 insertions(+), 10 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -923,6 +923,9 @@ config HAVE_SOFTIRQ_ON_OWN_STACK
 	  Architecture provides a function to run __do_softirq() on a
 	  separate stack.
=20
+config SOFTIRQ_ON_OWN_STACK
+	def_bool HAVE_SOFTIRQ_ON_OWN_STACK && !PREEMPT_RT
+
 config ALTERNATE_USER_ADDRESS_SPACE
 	bool
 	help
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -70,7 +70,7 @@ static void __init init_irq_stacks(void)
 	}
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(void *arg)
 {
 	__do_softirq();
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,7 +480,7 @@ static void execute_on_irq_stack(void *f
 	*irq_stack_in_use =3D 1;
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -199,7 +199,7 @@ static inline void check_stack_overflow(
 	}
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static __always_inline void call_do_softirq(const void *sp)
 {
 	/* Temporarily switch r1 to sp, call __do_softirq() then restore r1. */
@@ -335,7 +335,7 @@ void *mcheckirq_ctx[NR_CPUS] __read_most
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	call_do_softirq(softirq_ctx[smp_processor_id()]);
--- a/arch/s390/include/asm/softirq_stack.h
+++ b/arch/s390/include/asm/softirq_stack.h
@@ -5,7 +5,7 @@
 #include <asm/lowcore.h>
 #include <asm/stacktrace.h>
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static inline void do_softirq_own_stack(void)
 {
 	call_on_stack(0, S390_lowcore.async_stack, void, __do_softirq);
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -149,7 +149,7 @@ void irq_ctx_exit(int cpu)
 	hardirq_ctx[cpu] =3D NULL;
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct thread_info *curctx;
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -855,7 +855,7 @@ void __irq_entry handler_irq(int pil, st
 	set_irq_regs(old_regs);
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	void *orig_sp, *sp =3D softirq_stack[smp_processor_id()];
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -203,7 +203,7 @@
 			      IRQ_CONSTRAINTS, regs, vector);		\
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 /*
  * Macro to invoke __do_softirq on the irq stack. This is only called from
  * task context when bottom halves are about to be reenabled and soft
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,7 +132,7 @@ int irq_init_percpu_irqstack(unsigned in
 	return 0;
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
--- a/include/asm-generic/softirq_stack.h
+++ b/include/asm-generic/softirq_stack.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
 #define __ASM_GENERIC_SOFTIRQ_STACK_H
=20
-#if defined(CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK) && !defined(CONFIG_PREEMPT_R=
T)
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
