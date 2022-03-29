Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2D4EAD98
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiC2Mty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiC2MsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:48:11 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E521A25DAB9
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:38 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id x1-20020a50f181000000b00418f6d4bccbso10996218edl.12
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SXzoEK+WJk4pacaOPaL1kxqndb2ET/uQVttgxEkML+w=;
        b=EBgX4Z2SSMT4cCzIkiyvRhgKVrX4GCoNERzYeL3X7WwtwGGVnYOFgUHYNinxWjvjqh
         kPkONHRo3AKKxZf7R9b/cbfY+0RkKOgrN2sHOaZlXcyZw9J83ocbcq3eROphMcFU1OEF
         YKJAZFiUIL4gSt2ikNRjoKRlkYyZREXJJz7VZhoC8/sgm/33yNzmvyYsBx61nm/5RFi7
         Uan2pjppFHg5+0ZzLB/M100362XN/KNKnBk+E1pryuHawtyJIDPxaGso4I1pLwK0vTOC
         Sf0uIg6BZNx/aUM8AwFe9jVH9IO3gu9QyjACglxQsPj/loJje/iBcBYgMBagUP0EX/7M
         jrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SXzoEK+WJk4pacaOPaL1kxqndb2ET/uQVttgxEkML+w=;
        b=ff2ws2jG83KnJfS7wcADpy282x8KBpBLPtWfpLnW8z7+kQs6RCt4o3VTtCCjm1FEUl
         XeqY5bMSq4syRdJiDBvOpbkeM4Zn/YYZtL0fyTMqiiaE4W0aqJuCaTeqXNVTJEKm6kyO
         1RMtJse/cfM5VM8ImICp7zWlsV+mhb4KXWWs2BGfSAkf/iwPQ0rK9+e68a8VujU3FAO6
         W06VuSgGp4InO/sg2mOc5dxaSbR6DNpb62lvEo+zTMRqaTtZqp0fTGSMr7XR+2XtYCvZ
         KKXiSlftGVVrOFtCazz2CIxjQj/4WQTfNStTOFzQNYG79XiS7rBJCD7Q401noXc/ByRO
         wdCw==
X-Gm-Message-State: AOAM531xIcHfy80//HfklHjSE4MSq687ZsaTVrN8XNgDaP1S/qvUkv0a
        5zaBCTtAmcv0B9EUaS9TBYwMNAGdQjo=
X-Google-Smtp-Source: ABdhPJy8fACfQ4jyGr9xF342/z75NoNcLTDY10G+LWoaiStO0hTLZbGlHwL73c3ZjRYtS31XbeKhwJgw3p0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:9acd:b0:6e0:b74d:d932 with SMTP id
 ah13-20020a1709069acd00b006e0b74dd932mr24156373ejc.695.1648557754011; Tue, 29
 Mar 2022 05:42:34 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:16 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-48-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 47/48] x86: kmsan: handle register passing from
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 1345088e99025..f24ff33fc3681 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -51,7 +51,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -98,7 +98,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -195,7 +195,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
@@ -235,7 +235,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	instrumentation_end();						\
@@ -262,7 +262,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
-	instrumentation_begin();					\
+	instrumentation_begin_with_regs(regs);				\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d4..7b8c43d8727cc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1355,7 +1355,7 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 /* Handle unconfigured int18 (should never happen) */
 static noinstr void unexpected_machine_check(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
 	instrumentation_end();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d77481ecb0d5f..eaed9b412908c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -249,7 +249,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 
 	state = irqentry_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	/*
 	 * If the host managed to inject an async #PF into an interrupt
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802d25fb1..3f987a5dc38c7 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -329,7 +329,7 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 
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
index 8143693a7ea6e..f08741abc0e5b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -229,7 +229,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	/*
 	 * All lies, just get the WARN/BUG out.
 	 */
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
@@ -260,7 +260,7 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 		return;
 
 	state = irqentry_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	handle_invalid_op(regs);
 	instrumentation_end();
 	irqentry_exit(regs, state);
@@ -414,7 +414,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 #endif
 
 	irqentry_nmi_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -690,14 +690,14 @@ DEFINE_IDTENTRY_RAW(exc_int3)
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
@@ -896,7 +896,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 */
 	unsigned long dr7 = local_db_save();
 	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 
 	/*
 	 * If something gets miswired and we end up here for a user mode
@@ -975,7 +975,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
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
2.35.1.1021.g381101b075-goog

