Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB954B86B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiFNSSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbiFNSSU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 14:18:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6255517040;
        Tue, 14 Jun 2022 11:18:18 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:18:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655230696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=glKtlzrdgS42FUCeVSzwN4g68eQlfOzE5nkkDj9Hmbo=;
        b=bdOWxOcYLa1MqIDMGml1p3YAa+XuOEhBnRnAIoDvIzOoOBnLKkuT0WmGM+GhFRcb2f73ds
        q06UZPG2KI6Q/2WCjvU91DDQey2tlZOP8I9x99QFDBgtnCHm3RZciXHiNK3p+4ZS4YRw8q
        JaY523zT9e6y0T1b33h64fvnQ1cJIarN4kPLYgKKLz07N1QNteLZ+qULdMTTqzrFkQrWeD
        gx4NOOS1VjWgk7yJzaW9uHe6Vtc3BrBt6VC7pYB1ufcbKzsz0oTwvXZezknB13L/uDJgdh
        FUFbNwY7b1wffxieh0zy1moi3CApldOhWe+i2qDH7UVqOzvbJONNa7mxuqfR5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655230696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=glKtlzrdgS42FUCeVSzwN4g68eQlfOzE5nkkDj9Hmbo=;
        b=xTHjXNhpcCR8SakGE0xHmIzkgkPPHrYipvdxi4xgUsrXIkGeJ97y9f+lUhxwstj5DToUol
        xtiZ47mMHrxI8+DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] arch/*: Disable softirq stacks on PREEMPT_RT.
Message-ID: <YqjQ5kso7czrmYPW@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PREEMPT_RT preempts softirqs and the current implementation avoids
do_softirq_own_stack() and only uses __do_softirq().

Disable the unused softirqs stacks on PREEMPT_RT to safe some memory and
ensure that do_softirq_own_stack() is not used bwcause it is not
expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Initially I aimed only for the asm-generic bits and arm since I have
most bits of the port ready. Arnd then suggested to do all arches at
once and here it is.
I tried to keep it minimal in sense that I didn't remove the dedicated
softirq-stacks on parisc or powerpc for instance. That would add another
few ifdefs and I don't know if we manage to get it up and running on
parisc. I do have the missing bits for powerpc however ;)

 arch/arm/kernel/irq.c                 | 3 ++-
 arch/parisc/kernel/irq.c              | 2 ++
 arch/powerpc/kernel/irq.c             | 4 ++++
 arch/s390/include/asm/softirq_stack.h | 3 ++-
 arch/sh/kernel/irq.c                  | 2 ++
 arch/sparc/kernel/irq_64.c            | 2 ++
 include/asm-generic/softirq_stack.h   | 2 +-
 7 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 5c6f8d11a3ce5..034cb48c9eeb8 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -70,6 +70,7 @@ static void __init init_irq_stacks(void)
 	}
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static void ____do_softirq(void *arg)
 {
 	__do_softirq();
@@ -80,7 +81,7 @@ void do_softirq_own_stack(void)
 	call_with_stack(____do_softirq, NULL,
 			__this_cpu_read(irq_stack_ptr));
 }
-
+#endif
 #endif
 
 int arch_show_interrupts(struct seq_file *p, int prec)
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0fe2d79fb123f..eba193bcdab1b 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -480,10 +480,12 @@ static void execute_on_irq_stack(void *func, unsigned long param1)
 	*irq_stack_in_use = 1;
 }
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	execute_on_irq_stack(__do_softirq, 0);
 }
+#endif
 #endif /* CONFIG_IRQSTACKS */
 
 /* ONLY called from entry.S:intr_extint() */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index dd09919c3c668..0822a274a549c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -611,6 +611,7 @@ static inline void check_stack_overflow(void)
 	}
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static __always_inline void call_do_softirq(const void *sp)
 {
 	/* Temporarily switch r1 to sp, call __do_softirq() then restore r1. */
@@ -629,6 +630,7 @@ static __always_inline void call_do_softirq(const void *sp)
 		   "r11", "r12"
 	);
 }
+#endif
 
 static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
 {
@@ -747,10 +749,12 @@ void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 void *softirq_ctx[NR_CPUS] __read_mostly;
 void *hardirq_ctx[NR_CPUS] __read_mostly;
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	call_do_softirq(softirq_ctx[smp_processor_id()]);
 }
+#endif
 
 irq_hw_number_t virq_to_hw(unsigned int virq)
 {
diff --git a/arch/s390/include/asm/softirq_stack.h b/arch/s390/include/asm/softirq_stack.h
index fd17f25704bd5..af68d6c1d5840 100644
--- a/arch/s390/include/asm/softirq_stack.h
+++ b/arch/s390/include/asm/softirq_stack.h
@@ -5,9 +5,10 @@
 #include <asm/lowcore.h>
 #include <asm/stacktrace.h>
 
+#ifndef CONFIG_PREEMPT_RT
 static inline void do_softirq_own_stack(void)
 {
 	call_on_stack(0, S390_lowcore.async_stack, void, __do_softirq);
 }
-
+#endif
 #endif /* __ASM_S390_SOFTIRQ_STACK_H */
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index ef0f0827cf575..2d3eca8fee011 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -149,6 +149,7 @@ void irq_ctx_exit(int cpu)
 	hardirq_ctx[cpu] = NULL;
 }
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	struct thread_info *curctx;
@@ -176,6 +177,7 @@ void do_softirq_own_stack(void)
 		  "r5", "r6", "r7", "r8", "r9", "r15", "t", "pr"
 	);
 }
+#endif
 #else
 static inline void handle_one_irq(unsigned int irq)
 {
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index c8848bb681a11..41fa1be980a33 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -855,6 +855,7 @@ void __irq_entry handler_irq(int pil, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+#ifndef CONFIG_PREEMPT_RT
 void do_softirq_own_stack(void)
 {
 	void *orig_sp, *sp = softirq_stack[smp_processor_id()];
@@ -869,6 +870,7 @@ void do_softirq_own_stack(void)
 	__asm__ __volatile__("mov %0, %%sp"
 			     : : "r" (orig_sp));
 }
+#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(void)
diff --git a/include/asm-generic/softirq_stack.h b/include/asm-generic/softirq_stack.h
index eceeecf6a5bd8..d3e2d81656e04 100644
--- a/include/asm-generic/softirq_stack.h
+++ b/include/asm-generic/softirq_stack.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_SOFTIRQ_STACK_H
 #define __ASM_GENERIC_SOFTIRQ_STACK_H
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+#if defined(CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK) && !defined(CONFIG_PREEMPT_RT)
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
-- 
2.36.1

