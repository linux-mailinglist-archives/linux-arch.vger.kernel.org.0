Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBC510457
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348683AbiDZQvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353382AbiDZQvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:25 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3AB48E5A
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:18 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id mp18-20020a1709071b1200b006e7f314ecb3so9375393ejc.23
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jk0NMFQ+GIouP+k3atOjYdUnEj7isi+T1qF4OKInEvY=;
        b=q/8YNmW2FY+UOSSefHsoVD/+tXnxdP8E+Oyh/hfdIdafdhpVQDdRSLmWDfSSmsNJKL
         QEvct6PQ12lO5BkzKJzp9F/jBD+fRyuCDw1W1Y+eoR9Lna4fX3FqSnRcbQNFAi9810kd
         1KmXYk///irlbShN5FXTZLud1oM/MoL/kXNVhmqlso/CJrmniNY23vigbiK+1zT/oLX5
         u/p0nsK9LPxyHxzvCXLM9yXvRIIjEDWc9Qa0QoPtEJBwsG2B6/rqSW8o/qagH0NO8S4i
         baPLMv5+6abizA7u6ohuw2x4eEH69qUDUIfIZ/8RQI8GXT+Tdau+m7YEckOF8FW3Fe6p
         4Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jk0NMFQ+GIouP+k3atOjYdUnEj7isi+T1qF4OKInEvY=;
        b=N+KqEpH/iqYvHGexAPTsFEg6ZYegkwyo1jeb5NPKBhRcPs3JeE7NLnuqXctLgoMieK
         ksSTGvTpE5D20JDUwH3yqTs961fnl/mHWLMK1ywTE/Pp/tT7NBz5m5hZ8WV0kAdIenmn
         Erv2fkH6eX5kOf7LKLOXwhw3KsGcIdf+Y/3wvraev0uCvZD79KiQyXr3AuUovnE+ES8q
         VxoLXORHGzaKkxgBQu3OTSr1E6q9lEenBqjWjEz6gGQy3T19CF48X8qQsJM5cOoZPSYr
         XRwWmx6J2f/h8wY9V02j4oQPVDkTsbvdZbtuhy2haf/cj2H48V4rdJekQY7/x7m5fu/v
         RkqA==
X-Gm-Message-State: AOAM533BqOj/J1vs5qH0jvygSw+CVuaSbLfGLBV8pQsCuooyP2pgBb5F
        LpOOuv6O90VSnmlys8Z7zTSrik33Ulg=
X-Google-Smtp-Source: ABdhPJzs34r07s5FrFzj+GFFR4J7VeroU6awpjT3W6Wa0hn8rVzciQSq9AlsjYylNyT2KboobjGXSIMLGNU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:330b:b0:425:eded:7cfe with SMTP id
 e11-20020a056402330b00b00425eded7cfemr10281416eda.357.1650991577116; Tue, 26
 Apr 2022 09:46:17 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:14 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-46-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 45/46] x86: kmsan: handle register passing from
 uninstrumented code
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace instrumentation_begin() with instrumentation_begin_with_regs()
to let KMSAN handle the non-instrumented code and unpoison pt_regs
passed from the instrumented part. This is done to reduce the number of
false positive reports.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- this patch was previously called "x86: kmsan: handle register
    passing from uninstrumented code". Instead of adding KMSAN-specific
    code to every instrumentation_begin()/instrumentation_end() section,
    we changed instrumentation_begin() to
    instrumentation_begin_with_regs() where applicable.

Link: https://linux-review.googlesource.com/id/I435ec076cd21752c2f877f5da81f5eced62a2ea4
---
 arch/x86/entry/common.c         |  3 ++-
 arch/x86/include/asm/idtentry.h | 10 +++++-----
 arch/x86/kernel/cpu/mce/core.c  |  2 +-
 arch/x86/kernel/kvm.c           |  2 +-
 arch/x86/kernel/nmi.c           |  2 +-
 arch/x86/kernel/sev.c           |  4 ++--
 arch/x86/kernel/traps.c         | 14 +++++++-------
 arch/x86/mm/fault.c             |  2 +-
 8 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b337..047d157987859 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/errno.h>
+#include <linux/kmsan.h>
 #include <linux/ptrace.h>
 #include <linux/export.h>
 #include <linux/nospec.h>
@@ -75,7 +76,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
 		/* Invalid system call, but still a system call. */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7924f27f5c8b1..172b9b6f90628 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -53,7 +53,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -100,7 +100,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -197,7 +197,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
@@ -237,7 +237,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	instrumentation_end();						\
@@ -264,7 +264,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e4..e5acff54f7d55 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1376,7 +1376,7 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 /* Handle unconfigured int18 (should never happen) */
 static noinstr void unexpected_machine_check(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
 	instrumentation_end();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 8b1c45c9cda87..3df82a51ab1b5 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -250,7 +250,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 
 	state = irqentry_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	/*
 	 * If the host managed to inject an async #PF into an interrupt
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index e73f7df362f5d..5078417e16ec1 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -328,7 +328,7 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index e6d316a01fdd4..9bfc29fc9c983 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1330,7 +1330,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 
 	irq_state = irqentry_nmi_enter(regs);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	if (!vc_raw_handle_exception(regs, error_code)) {
 		/* Show some debug info */
@@ -1362,7 +1362,7 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 	}
 
 	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	if (!vc_raw_handle_exception(regs, error_code)) {
 		/*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1563fb9950059..9d3c9c4de94d3 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -305,7 +305,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	/*
 	 * All lies, just get the WARN/BUG out.
 	 */
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
@@ -336,7 +336,7 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 		return;
 
 	state = irqentry_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	handle_invalid_op(regs);
 	instrumentation_end();
 	irqentry_exit(regs, state);
@@ -490,7 +490,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 #endif
 
 	irqentry_nmi_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -820,14 +820,14 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	 */
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		do_int3_user(regs);
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
@@ -1026,7 +1026,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 */
 	unsigned long dr7 = local_db_save();
 	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	/*
 	 * If something gets miswired and we end up here for a user mode
@@ -1105,7 +1105,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	 */
 
 	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	/*
 	 * Start the virtual/ptrace DR6 value with just the DR_STEP mask
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f2250a32a10ca..676e394f1af5b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1557,7 +1557,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 */
 	state = irqentry_enter(regs);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

