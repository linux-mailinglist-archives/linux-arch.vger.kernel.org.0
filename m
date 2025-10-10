Return-Path: <linux-arch+bounces-14027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11604BCDE0A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E85463D9
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DD2F3C20;
	Fri, 10 Oct 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfKt5nFE"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E3268690
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111233; cv=none; b=Htn1uOodvwvVDa7G+kqBWJwoPJQuUdkbSOMg5V9yo7B/d64muEEBGHnHgR4+Goj+m79WOYlco+mCKz9Z5xyjN88fuIfoTAx6PbPsT160/6HwTMBsrbnH0A6ZnEmmAYIy3RkuRxf5TFlH6yqiIWPBQIpvRKOw+KVoGIqQA4e2R14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111233; c=relaxed/simple;
	bh=9eZrKWE7BqlxB3Jt7PqSxsLRFsM10m+ZdgyKWEgK6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTBO2pA6iFlV10q2ouMU+gpg5hLyqLVdsjsF3UVNelOnrMaKxddNX8ouwoOdpBzt7PbCWPVno53BhJ5pj80mLX8q4GYRjpwTqNP5OLSs6hpkSTuoSbZL9zG/ChIkQ8WvPfkJH3G7u3GVBatkxQg7QQvDQzJcoyMYRZ0Wa4Jp1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfKt5nFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAE4BGzwUqBmQVf4HU1DeXa/8jpyKHrNy0TfmV5JHYg=;
	b=FfKt5nFEqHRNHqmDvL/FW/aO4Hb55n0853oH4akxc2GM2ZoZjTQDMTwf6S9Jg2EeBUklwR
	0jc8BS4HoSAiRqSujWgQ8hgsrbYNG7vrZzDQEALMq1eky4Z4f4Apbr3G719PToqhU6iszN
	R6IyfnXxn2towqyBoA3EGLK6lrwAip4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-hWPLBEZOPFmjletMFat6lw-1; Fri,
 10 Oct 2025 11:47:06 -0400
X-MC-Unique: hWPLBEZOPFmjletMFat6lw-1
X-Mimecast-MFC-AGG-ID: hWPLBEZOPFmjletMFat6lw_1760111219
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B813419560AE;
	Fri, 10 Oct 2025 15:46:59 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0A501800578;
	Fri, 10 Oct 2025 15:46:43 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v6 24/29] context_tracking,x86: Defer kernel text patching IPIs
Date: Fri, 10 Oct 2025 17:38:34 +0200
Message-ID: <20251010153839.151763-25-vschneid@redhat.com>
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
them vs the newly patched instruction. CPUs that are executing in userspace
do not need this synchronization to happen immediately, and this is
actually harmful interference for NOHZ_FULL CPUs.

As the synchronization IPIs are sent using a blocking call, returning from
text_poke_bp_batch() implies all CPUs will observe the patched
instruction(s), and this should be preserved even if the IPI is deferred.
In other words, to safely defer this synchronization, any kernel
instruction leading to the execution of the deferred instruction
sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.

This means we must pay attention to mutable instructions in the early entry
code:
- alternatives
- static keys
- static calls
- all sorts of probes (kprobes/ftrace/bpf/???)

The early entry code leading to ct_work_flush() is noinstr, which gets rid
of the probes.

Alternatives are safe, because it's boot-time patching (before SMP is
even brought up) which is before any IPI deferral can happen.

This leaves us with static keys and static calls.

Any static key used in early entry code should be only forever-enabled at
boot time, IOW __ro_after_init (pretty much like alternatives). Exceptions
are explicitly marked as allowed in .noinstr and will always generate an
IPI when flipped.

The same applies to static calls - they should be only updated at boot
time, or manually marked as an exception.

Objtool is now able to point at static keys/calls that don't respect this,
and all static keys/calls used in early entry code have now been verified
as behaving appropriately.

Leverage the new context_tracking infrastructure to defer sync_core() IPIs
to a target CPU's next kernel entry.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/context_tracking_work.h |  6 ++-
 arch/x86/include/asm/text-patching.h         |  1 +
 arch/x86/kernel/alternative.c                | 39 +++++++++++++++++---
 arch/x86/kernel/kprobes/core.c               |  4 +-
 arch/x86/kernel/kprobes/opt.c                |  4 +-
 arch/x86/kernel/module.c                     |  2 +-
 include/asm-generic/sections.h               | 15 ++++++++
 include/linux/context_tracking_work.h        |  4 +-
 8 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
index 5f3b2d0977235..485b32881fde5 100644
--- a/arch/x86/include/asm/context_tracking_work.h
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -2,11 +2,13 @@
 #ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
 #define _ASM_X86_CONTEXT_TRACKING_WORK_H
 
+#include <asm/sync_core.h>
+
 static __always_inline void arch_context_tracking_work(enum ct_work work)
 {
 	switch (work) {
-	case CT_WORK_n:
-		// Do work...
+	case CT_WORK_SYNC:
+		sync_core();
 		break;
 	case CT_WORK_MAX:
 		WARN_ON_ONCE(true);
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 5337f1be18f6e..a33541ab210db 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -33,6 +33,7 @@ extern void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t i
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void smp_text_poke_sync_each_cpu(void);
+extern void smp_text_poke_sync_each_cpu_deferrable(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 #define text_poke_copy text_poke_copy
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7bde68247b5fc..07c91f0a30eaf 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/context_tracking.h>
 
 #include <asm/text-patching.h>
 #include <asm/insn.h>
@@ -2648,9 +2649,24 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+static bool do_sync_core_defer_cond(int cpu, void *info)
+{
+	return !ct_set_cpu_work(cpu, CT_WORK_SYNC);
+}
+
+static void __smp_text_poke_sync_each_cpu(smp_cond_func_t cond_func)
+{
+	on_each_cpu_cond(cond_func, do_sync_core, NULL, 1);
+}
+
 void smp_text_poke_sync_each_cpu(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	__smp_text_poke_sync_each_cpu(NULL);
+}
+
+void smp_text_poke_sync_each_cpu_deferrable(void)
+{
+	__smp_text_poke_sync_each_cpu(do_sync_core_defer_cond);
 }
 
 /*
@@ -2820,6 +2836,7 @@ noinstr int smp_text_poke_int3_handler(struct pt_regs *regs)
  */
 void smp_text_poke_batch_finish(void)
 {
+	smp_cond_func_t cond = do_sync_core_defer_cond;
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
@@ -2856,11 +2873,21 @@ void smp_text_poke_batch_finish(void)
 	 * First step: add a INT3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < text_poke_array.nr_entries; i++) {
-		text_poke_array.vec[i].old = *(u8 *)text_poke_addr(&text_poke_array.vec[i]);
-		text_poke(text_poke_addr(&text_poke_array.vec[i]), &int3, INT3_INSN_SIZE);
+		void *addr = text_poke_addr(&text_poke_array.vec[i]);
+
+		/*
+		 * There's no safe way to defer IPIs for patching text in
+		 * .noinstr, record whether there is at least one such poke.
+		 */
+		if (is_kernel_noinstr_text((unsigned long)addr) ||
+		    is_module_noinstr_text_address((unsigned long)addr))
+			cond = NULL;
+
+		text_poke_array.vec[i].old = *((u8 *)addr);
+		text_poke(addr, &int3, INT3_INSN_SIZE);
 	}
 
-	smp_text_poke_sync_each_cpu();
+	__smp_text_poke_sync_each_cpu(cond);
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -2922,7 +2949,7 @@ void smp_text_poke_batch_finish(void)
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		smp_text_poke_sync_each_cpu();
+		__smp_text_poke_sync_each_cpu(cond);
 	}
 
 	/*
@@ -2943,7 +2970,7 @@ void smp_text_poke_batch_finish(void)
 	}
 
 	if (do_sync)
-		smp_text_poke_sync_each_cpu();
+		__smp_text_poke_sync_each_cpu(cond);
 
 	/*
 	 * Remove and wait for refs to be zero.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6079d15dab8ca..cce08add9aa0e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -790,7 +790,7 @@ void arch_arm_kprobe(struct kprobe *p)
 	u8 int3 = INT3_INSN_OPCODE;
 
 	text_poke(p->addr, &int3, 1);
-	smp_text_poke_sync_each_cpu();
+	smp_text_poke_sync_each_cpu_deferrable();
 	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
@@ -800,7 +800,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 
 	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
-	smp_text_poke_sync_each_cpu();
+	smp_text_poke_sync_each_cpu_deferrable();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 0aabd4c4e2c4f..eada8dca1c2e8 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -513,11 +513,11 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
 
 	text_poke(addr, new, INT3_INSN_SIZE);
-	smp_text_poke_sync_each_cpu();
+	smp_text_poke_sync_each_cpu_deferrable();
 	text_poke(addr + INT3_INSN_SIZE,
 		  new + INT3_INSN_SIZE,
 		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
-	smp_text_poke_sync_each_cpu();
+	smp_text_poke_sync_each_cpu_deferrable();
 
 	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 0ffbae902e2fe..c6c4f391eb465 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -206,7 +206,7 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 				   write, apply);
 
 	if (!early) {
-		smp_text_poke_sync_each_cpu();
+		smp_text_poke_sync_each_cpu_deferrable();
 		mutex_unlock(&text_mutex);
 	}
 
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 0755bc39b0d80..7d2403014010e 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -199,6 +199,21 @@ static inline bool is_kernel_inittext(unsigned long addr)
 	       addr < (unsigned long)_einittext;
 }
 
+
+/**
+ * is_kernel_noinstr_text - checks if the pointer address is located in the
+ *                    .noinstr section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .noinstr, false otherwise.
+ */
+static inline bool is_kernel_noinstr_text(unsigned long addr)
+{
+	return addr >= (unsigned long)__noinstr_text_start &&
+	       addr < (unsigned long)__noinstr_text_end;
+}
+
 /**
  * __is_kernel_text - checks if the pointer address is located in the
  *                    .text section
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
index c68245f8d77c5..2facc621be067 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -5,12 +5,12 @@
 #include <linux/bitops.h>
 
 enum {
-	CT_WORK_n_OFFSET,
+	CT_WORK_SYNC_OFFSET,
 	CT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
-	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
+	CT_WORK_SYNC     = BIT(CT_WORK_SYNC_OFFSET),
 	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
 };
 
-- 
2.51.0


