Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C045158E989
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 11:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHJJXq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiHJJXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 05:23:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D6AE23A;
        Wed, 10 Aug 2022 02:23:34 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:23:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660123412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HWN3MBEuCVFX8UKlJj6PwdpMdFjg0O5CvJcE3JmtvM=;
        b=W34XICQTVr4AnT5zOfE1kS3VYwQoUZo2WxMrKRZbPkbN7ar0EMut6zarANq8I3rlkbuLJn
        ZT1bVnsKw1uH/y6cm+41b/xi1tZy/04QDR8bBph/UDMJa5X23utqmFN5v3lnYJFcqmh7o7
        k4c4Pk01P19RKtSfb9Ml+QHAa5zCpPQxQ/FixfDybpfIhbllxqSQuVlPcYa+a85XtPRVYi
        m6CAmSPXmrTJyng6lG6vuDTaODWEVHatTA/PYJDE6u17BQBaakLS/3gI+nijtBUo/gNhWj
        GKD6VbrvP3OP3WFWupueNMSH/LR74IqeKPKmtGurOei5BbbIlZXDsfblAqbBbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660123412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HWN3MBEuCVFX8UKlJj6PwdpMdFjg0O5CvJcE3JmtvM=;
        b=MiSnta9s2QurxZXWkf35yqvfSbeo1OsMDOjjGCUh/jMxOcV68XhI3pqnZJAogUWNzXVjPI
        xmFf9tC59gpODFCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH v2] asm-generic: Conditionally enable do_softirq_own_stack()
 via Kconfig.
Message-ID: <YvN5E/PrHfUhggr7@linutronix.de>
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
 <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
 <YvKD4hkZ3erf54DG@linutronix.de>
 <8735e4v7yk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8735e4v7yk.ffs@tglx>
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
v1=E2=80=A6v2:
On 2022-08-10 10:06:11 [+0200], Thomas Gleixner wrote:
> > +config SOFTIRQ_ON_OWN_STACK
> > +	def_bool !PREEMPT_RT
> > +	depends on HAVE_SOFTIRQ_ON_OWN_STACK
>=20
>         def_bool !PREEMPT_RT && HAVE_SOFTIRQ_ON_OWN_STACK
>=20
> No?

works, too. Let me compress it then.

 arch/Kconfig                          | 3 +++
 arch/arm/kernel/irq.c                 | 2 +-
 arch/parisc/kernel/irq.c              | 2 +-
 arch/powerpc/kernel/irq.c             | 4 ++--
 arch/s390/include/asm/softirq_stack.h | 2 +-
 arch/sh/kernel/irq.c                  | 2 +-
 arch/sparc/kernel/irq_64.c            | 2 +-
 arch/x86/include/asm/irq_stack.h      | 2 +-
 arch/x86/kernel/irq_32.c              | 2 +-
 include/asm-generic/softirq_stack.h   | 2 +-
 10 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a6..dc2dce2120a0b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -924,6 +924,9 @@ config HAVE_SOFTIRQ_ON_OWN_STACK
 	  Architecture provides a function to run __do_softirq() on a
 	  separate stack.
=20
+config SOFTIRQ_ON_OWN_STACK
+	def_bool HAVE_SOFTIRQ_ON_OWN_STACK && !PREEMPT_RT
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
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static void ____do_softirq(void *arg)
 {
 	__do_softirq();
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index fbb882cb8dbb5..b05055f3ba4b8 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,7 +480,7 @@ static void execute_on_irq_stack(void *func, unsigned l=
ong param1)
 	*irq_stack_in_use =3D 1;
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0f17268c1f0bb..9ede61a5a469e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -199,7 +199,7 @@ static inline void check_stack_overflow(unsigned long s=
p)
 	}
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 static __always_inline void call_do_softirq(const void *sp)
 {
 	/* Temporarily switch r1 to sp, call __do_softirq() then restore r1. */
@@ -335,7 +335,7 @@ void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	call_do_softirq(softirq_ctx[smp_processor_id()]);
diff --git a/arch/s390/include/asm/softirq_stack.h b/arch/s390/include/asm/=
softirq_stack.h
index af68d6c1d5840..1ac5115d3115e 100644
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
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 9092767380780..4e6835de54cf8 100644
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
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 41fa1be980a33..72da2e10e2559 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -855,7 +855,7 @@ void __irq_entry handler_irq(int pil, struct pt_regs *r=
egs)
 	set_irq_regs(old_regs);
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	void *orig_sp, *sp =3D softirq_stack[smp_processor_id()];
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_st=
ack.h
index 63f818aedf770..147cb8fdda92e 100644
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
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index e5dd6da78713b..01833ebf5e8e3 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -132,7 +132,7 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 	return 0;
 }
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 	struct irq_stack *irqstk;
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/soft=
irq_stack.h
index d3e2d81656e04..2a67aed9ac528 100644
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
--=20
2.36.1

