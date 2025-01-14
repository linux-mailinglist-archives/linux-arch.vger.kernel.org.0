Return-Path: <linux-arch+bounces-9775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4AA10F51
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EAF3A3DEB
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7025224881;
	Tue, 14 Jan 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gskN3zx4"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E32236F3
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877808; cv=none; b=Lmp1A1aJrjob82ORqBtysvLkYGFN+w63aUuZZ5o8Y5b0qe+ApPe4yCBAh7cySM/X0i5aoqaQGdxvmx+6qAS15gPQ9l9xOxya0GOr1O/qRzwdAIhcVp+SP7q2D+xOoW56Z9DZFBbkaHQ9kLBG4WgtmPr+egrlNWpyw+TkBP5HIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877808; c=relaxed/simple;
	bh=fSVKY5EuMPh/Z2F2yDud9PfGMc+uopWM8hczjgz3S5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYz9L0jgRwsaDbgDCf1F5fQhcVPEV+CtIy4kDgtF8mCr2R51AchtWlSrG+lL2VSnTsU5nUWQuspYIDBXsENd2t2mXNuKmTit7kZpXQcZ3xGjJFz1DnwfeMhxHZ9w2FmC4y/NWjU/PpHBTre5vExOKj3Zo/Ho6g+bW4HgP4AxmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gskN3zx4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOYbvMechf4Tk3QrOwIKHHFKhIz7g8W0C2CEkfk0nCI=;
	b=gskN3zx4GXERcnC5AlqQWy9ZrUCuPGW3hpYEaOwd6yNvEhEs9scMSULagPvVFYIMmPDlLm
	HW0KZWStQwIev4uFzLL4RjrsMa0Of09KE40A5cZI6MVdQBmFhuMXTwjzvGLCz+Lv4bi24n
	TrxpVF39dTg/y98P/P7SukdqOG3y9JQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-Kq2Q4fXhOu2lJRR6wkpJZw-1; Tue,
 14 Jan 2025 13:03:20 -0500
X-MC-Unique: Kq2Q4fXhOu2lJRR6wkpJZw-1
X-Mimecast-MFC-AGG-ID: Kq2Q4fXhOu2lJRR6wkpJZw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A57A91956054;
	Tue, 14 Jan 2025 18:03:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.55])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C6D619560B7;
	Tue, 14 Jan 2025 18:02:54 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching IPIs
Date: Tue, 14 Jan 2025 18:51:38 +0100
Message-ID: <20250114175143.81438-26-vschneid@redhat.com>
In-Reply-To: <20250114175143.81438-1-vschneid@redhat.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 arch/x86/include/asm/context_tracking_work.h |  6 ++--
 arch/x86/include/asm/text-patching.h         |  1 +
 arch/x86/kernel/alternative.c                | 38 ++++++++++++++++----
 arch/x86/kernel/kprobes/core.c               |  4 +--
 arch/x86/kernel/kprobes/opt.c                |  4 +--
 arch/x86/kernel/module.c                     |  2 +-
 include/asm-generic/sections.h               | 15 ++++++++
 include/linux/context_tracking_work.h        |  4 +--
 8 files changed, 59 insertions(+), 15 deletions(-)

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
index ab9e143ec9fea..9dfa46f721c1d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -33,6 +33,7 @@ extern void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
+extern void text_poke_sync_deferrable(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 #define text_poke_copy text_poke_copy
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 243843e44e89d..633deea8a89cb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,6 +18,7 @@
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
 #include <linux/sync_core.h>
+#include <linux/context_tracking.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -2109,9 +2110,24 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+static bool do_sync_core_defer_cond(int cpu, void *info)
+{
+	return !ct_set_cpu_work(cpu, CT_WORK_SYNC);
+}
+
+static void __text_poke_sync(smp_cond_func_t cond_func)
+{
+	on_each_cpu_cond(cond_func, do_sync_core, NULL, 1);
+}
+
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	__text_poke_sync(NULL);
+}
+
+void text_poke_sync_deferrable(void)
+{
+	__text_poke_sync(do_sync_core_defer_cond);
 }
 
 /*
@@ -2282,6 +2298,7 @@ static int tp_vec_nr;
  */
 static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
+	smp_cond_func_t cond = do_sync_core_defer_cond;
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
@@ -2317,11 +2334,20 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++) {
-		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
-		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+		void *addr = text_poke_addr(&tp[i]);
+
+		/*
+		 * There's no safe way to defer IPIs for patching text in
+		 * .noinstr, record whether there is at least one such poke.
+		 */
+		if (is_kernel_noinstr_text((unsigned long)addr))
+			cond = NULL;
+
+		tp[i].old = *((u8 *)addr);
+		text_poke(addr, &int3, INT3_INSN_SIZE);
 	}
 
-	text_poke_sync();
+	__text_poke_sync(cond);
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -2383,7 +2409,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		text_poke_sync();
+		__text_poke_sync(cond);
 	}
 
 	/*
@@ -2404,7 +2430,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	}
 
 	if (do_sync)
-		text_poke_sync();
+		__text_poke_sync(cond);
 
 	/*
 	 * Remove and wait for refs to be zero.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 72e6a45e7ec24..c2fd2578fd5fc 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -817,7 +817,7 @@ void arch_arm_kprobe(struct kprobe *p)
 	u8 int3 = INT3_INSN_OPCODE;
 
 	text_poke(p->addr, &int3, 1);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
@@ -827,7 +827,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 
 	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 36d6809c6c9e1..b2ce4d9c3ba56 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -513,11 +513,11 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
 
 	text_poke(addr, new, INT3_INSN_SIZE);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 	text_poke(addr + INT3_INSN_SIZE,
 		  new + INT3_INSN_SIZE,
 		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 
 	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 8984abd91c001..acc810150b76c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -194,7 +194,7 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 				   write, apply);
 
 	if (!early) {
-		text_poke_sync();
+		text_poke_sync_deferrable();
 		mutex_unlock(&text_mutex);
 	}
 
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index c768de6f19a9a..1b3ba3084fd2f 100644
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
index c68245f8d77c5..931ade1dcbcc2 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -5,12 +5,12 @@
 #include <linux/bitops.h>
 
 enum {
-	CT_WORK_n_OFFSET,
+	CT_WORK_SYNC,
 	CT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
-	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
+	CT_WORK_SYNC     = BIT(CT_WORK_SYNC_OFFSET),
 	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
 };
 
-- 
2.43.0


