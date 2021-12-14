Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D2C4747E4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhLNQYd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhLNQXs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:48 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E07C06175E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:40 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso8131244wms.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZnUpsMEEEaMIFMfW4PiNPKRHgYFqldIePfksOe3OgBA=;
        b=Brq++2uVFJ7WxZlLWrMfD1XXDJqAOv4L9P8DlGsnmIbBTBmkiTlNYXtKvICVzXC21X
         p2luCbzc/WruKPL5Xqzd9MX/xVCI4e0BFpjW0gTaCghNJ9hMa+M7NA8RaBIj4qkggONp
         erlrak/5+1AuLCDBZeneRT9IrzUpM8smn0SaGrq6Z1Gn/AgydnHqszcqrHVFLsX0KRHm
         Pj2Vth9a/a7+xjr3P3LUlwLjrZcX84eOiYEzaqp5rf1os88wDyhH/k3fzcarsT3OIddf
         4upeVK2qPvDT/2fiEah4d6eC3+zktfq6gHE9r0qNam4togje7tTKHu2Cv8hzXkoqGQ9E
         roxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZnUpsMEEEaMIFMfW4PiNPKRHgYFqldIePfksOe3OgBA=;
        b=ehxJ2wcGUk6IbQiut/2CnRFnMmZA2/U+tL5dIcxOZMN5Y4JBx0UWXGvuDu943gt0Dp
         +8lFcv03nRE2cOGz1T7HaPDgZ7HgELLIpaWaEiXhGPgA8Lis1HG6MHdRt9hJu21t2dRL
         S5xpkDJyMtL+MHdlhdKH58NO6rE/XSag9p9zZnxwpW5Y7aA2sUFtSTA9r1AW+uJX+sVb
         qTNVyZnI7/kkpUwK5uzSYvAKndemsznDoA3+7SvQHW7perTI9H/2Svktb+ohATaFeHbP
         0+gMF6BLrztzCnlw2e5VzQtMu9Fij0C8nqomrv4OVZZxt8y9ddEJ/MlOK1GLrgP1kksP
         I0gw==
X-Gm-Message-State: AOAM530x0r79spcsm/2KRSB3fc3Er5cZq+G5JfF8JFmzFSmfNRaMsPyz
        OiwnTwwETgueEZPOJfvjB6VYuHkvTp0=
X-Google-Smtp-Source: ABdhPJxn0bLPYKI+N4zgBzr2ctmr3gZCxqLQaRF/4JPBJnIsdR5ZCIM+Tz7ExfM234sKmO38Qfn+7kwMOp0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:6000:250:: with SMTP id
 m16mr6863763wrz.459.1639499019403; Tue, 14 Dec 2021 08:23:39 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:46 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-40-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 39/43] x86: kmsan: handle register passing from uninstrumented code
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When calling KMSAN-instrumented functions from non-instrumented
functions, function parameters may not be initialized properly, leading
to false positive reports. In particular, this happens all the time when
calling interrupt handlers from `noinstr` IDT entries.

Fortunately, x86 code has instrumentation_begin() and
instrumentation_end(), which denote the regions where `noinstr` code
calls potentially instrumented code. We add calls to
kmsan_instrumentation_begin() to those regions, which:
 - wipe the current KMSAN state at the beginning of the region, ensuring
   that the first call of an instrumented function receives initialized
   parameters (this is a pretty good approximation of having all other
   instrumented functions receive initialized parameters);
 - unpoison the `struct pt_regs` set up by the non-instrumented assembly
   code.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I435ec076cd21752c2f877f5da81f5eced62a2ea4
---
 arch/x86/entry/common.c         | 2 ++
 arch/x86/include/asm/idtentry.h | 5 +++++
 arch/x86/kernel/cpu/mce/core.c  | 1 +
 arch/x86/kernel/kvm.c           | 1 +
 arch/x86/kernel/nmi.c           | 1 +
 arch/x86/kernel/sev.c           | 2 ++
 arch/x86/kernel/traps.c         | 7 +++++++
 arch/x86/mm/fault.c             | 1 +
 kernel/entry/common.c           | 3 +++
 9 files changed, 23 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b337..a0f90588c514e 100644
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
@@ -76,6 +77,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
 		/* Invalid system call, but still a system call. */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e99025..f025fdc0f25df 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -52,6 +52,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
+	kmsan_instrumentation_begin(regs);				\
 	__##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -99,6 +100,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
+	kmsan_instrumentation_begin(regs);				\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -196,6 +198,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
 	instrumentation_begin();					\
+	kmsan_instrumentation_begin(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
@@ -236,6 +239,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
+	kmsan_instrumentation_begin(regs);				\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	instrumentation_end();						\
@@ -263,6 +267,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
+	kmsan_instrumentation_begin(regs);				\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b1..b49e2c6bb8ca2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1314,6 +1314,7 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 static noinstr void unexpected_machine_check(struct pt_regs *regs)
 {
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	pr_err("CPU#%d: Unexpected int18 (Machine Check)\n",
 	       smp_processor_id());
 	instrumentation_end();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 59abbdad7729c..55ffe1bc73b00 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -250,6 +250,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 
 	state = irqentry_enter(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	/*
 	 * If the host managed to inject an async #PF into an interrupt
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802d25fb1..d91327d271359 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,6 +330,7 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a9fc2ac7a8bd5..421d59b982cae 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1426,6 +1426,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 	irq_state = irqentry_nmi_enter(regs);
 
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	if (!vc_raw_handle_exception(regs, error_code)) {
 		/* Show some debug info */
@@ -1458,6 +1459,7 @@ DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	if (!vc_raw_handle_exception(regs, error_code)) {
 		/*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c9d566dcf89a0..3a821010def63 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -230,6 +230,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
@@ -261,6 +262,7 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 
 	state = irqentry_enter(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	handle_invalid_op(regs);
 	instrumentation_end();
 	irqentry_exit(regs, state);
@@ -415,6 +417,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 	irqentry_nmi_enter(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -690,6 +693,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
+		kmsan_instrumentation_begin(regs);
 		do_int3_user(regs);
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
@@ -697,6 +701,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 
 		instrumentation_begin();
+		kmsan_instrumentation_begin(regs);
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
@@ -896,6 +901,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	unsigned long dr7 = local_db_save();
 	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	/*
 	 * If something gets miswired and we end up here for a user mode
@@ -975,6 +981,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 
 	/*
 	 * Start the virtual/ptrace DR6 value with just the DR_STEP mask
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index abed0aedf00d2..0437d2fe31ecb 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1558,6 +1558,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	state = irqentry_enter(regs);
 
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5d..3a569ea5a78fb 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -104,6 +104,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 	__enter_from_user_mode(regs);
 
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	local_irq_enable();
 	ret = __syscall_enter_from_user_work(regs, syscall);
 	instrumentation_end();
@@ -297,6 +298,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
@@ -310,6 +312,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
+	kmsan_instrumentation_begin(regs);
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
-- 
2.34.1.173.g76aa8bc2d0-goog

