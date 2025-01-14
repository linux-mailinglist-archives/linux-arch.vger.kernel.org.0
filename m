Return-Path: <linux-arch+bounces-9774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C096EA10F2F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009E27A158D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471620CCD8;
	Tue, 14 Jan 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9aKzj9s"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A420CCD1
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877785; cv=none; b=P+D9q+iR8NVAY7MQDIupxf+sx84EIwuGs7fRwYGed6GzDL6LUpVJ07tnqox23zocZaXGK3XbFt9CzlFaLMT/JhYwajDDT4yFHOGnHKXMXTs57mRHhc3Zw5k1JBWKDGSEBrGM+ItD91+gn1gLgUu/QX2Szm1UewPwuG2Qw8TfrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877785; c=relaxed/simple;
	bh=GiKkI8dOPaIMT2aq1S7EgjcbiIo6gGOOKqyXn2n39qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQuRjRUv65Fnc16KBrmNRGVWdCAOk6advxuD2cwbQg7zcDnnIKb4UpxzL3aoIdZ4rkfTFBtb+4FS6oAei/u8YAQfT9sur5s9mcAJyEgY+Vt2fFcBR42z0CVyJ/KFmvBERPKXGA94wJ18ya4LXQJ5rkopL5mqJaAARbLcSDCyNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9aKzj9s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj0SVgwm0Gb22+xO5luDoQDcDRqoe4OsVd+MUCyw+y0=;
	b=A9aKzj9su5q/kEbmiNGzCfqTNnwe+ZLkhX2F9kgxIb64B+9cAQVVzOAgVpF0uX3KzUElK6
	FPPztQBI7tRL9etj6Wb2xrbSqsjavSk30Tdg3eWpfr+6/JUbMhtf76UjJScp5Hb8wptEgD
	qNIcI7bRc4mEsKztbZLcSpqYfRcD88g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-hmcuI36TM9u3E6tRKSsWWQ-1; Tue,
 14 Jan 2025 13:02:57 -0500
X-MC-Unique: hmcuI36TM9u3E6tRKSsWWQ-1
X-Mimecast-MFC-AGG-ID: hmcuI36TM9u3E6tRKSsWWQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD5C41955DD7;
	Tue, 14 Jan 2025 18:02:53 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.55])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7CA19560AB;
	Tue, 14 Jan 2025 18:02:31 +0000 (UTC)
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
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>,
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
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 24/30] context-tracking: Introduce work deferral infrastructure
Date: Tue, 14 Jan 2025 18:51:37 +0100
Message-ID: <20250114175143.81438-25-vschneid@redhat.com>
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

smp_call_function() & friends have the unfortunate habit of sending IPIs to
isolated, NOHZ_FULL, in-userspace CPUs, as they blindly target all online
CPUs.

Some callsites can be bent into doing the right, such as done by commit:

  cc9e303c91f5 ("x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs")

Unfortunately, not all SMP callbacks can be omitted in this
fashion. However, some of them only affect execution in kernelspace, which
means they don't have to be executed *immediately* if the target CPU is in
userspace: stashing the callback and executing it upon the next kernel entry
would suffice. x86 kernel instruction patching or kernel TLB invalidation
are prime examples of it.

Reduce the RCU dynticks counter width to free up some bits to be used as a
deferred callback bitmask. Add some build-time checks to validate that
setup.

Presence of CT_STATE_KERNEL in the ct_state prevents queuing deferred work.

Later commits introduce the bit:callback mappings.

Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/Kconfig                                 |  9 +++
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/context_tracking_work.h | 16 +++++
 include/linux/context_tracking.h             | 21 +++++++
 include/linux/context_tracking_state.h       | 30 ++++++---
 include/linux/context_tracking_work.h        | 26 ++++++++
 kernel/context_tracking.c                    | 66 +++++++++++++++++++-
 kernel/time/Kconfig                          |  5 ++
 8 files changed, 162 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 6682b2a53e342..b637f20f0fc68 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -952,6 +952,15 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	  - No use of instrumentation, unless instrumentation_begin() got
 	    called.
 
+config HAVE_CONTEXT_TRACKING_WORK
+	bool
+	help
+	  Architecture supports deferring work while not in kernel context.
+	  This is especially useful on setups with isolated CPUs that might
+	  want to avoid being interrupted to perform housekeeping tasks (for
+	  ex. TLB invalidation or icache invalidation). The housekeeping
+	  operations are performed upon re-entering the kernel.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c42..ca5dd4cfc354b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -216,6 +216,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER		if X86_64
 	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
+	select HAVE_CONTEXT_TRACKING_WORK		if X86_64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL_NOP_MCOUNT		if HAVE_OBJTOOL_MCOUNT
diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
new file mode 100644
index 0000000000000..5f3b2d0977235
--- /dev/null
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
+#define _ASM_X86_CONTEXT_TRACKING_WORK_H
+
+static __always_inline void arch_context_tracking_work(enum ct_work work)
+{
+	switch (work) {
+	case CT_WORK_n:
+		// Do work...
+		break;
+	case CT_WORK_MAX:
+		WARN_ON_ONCE(true);
+	}
+}
+
+#endif
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..0b0faa040e9b5 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/context_tracking_work.h>
 #include <linux/instrumentation.h>
 
 #include <asm/ptrace.h>
@@ -137,6 +138,26 @@ static __always_inline unsigned long ct_state_inc(int incby)
 	return raw_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static __always_inline unsigned long ct_state_inc_clear_work(int incby)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+	unsigned long new, old, state;
+
+	state = arch_atomic_read(&ct->state);
+	do {
+		old = state;
+		new = old & ~CT_WORK_MASK;
+		new += incby;
+		state = arch_atomic_cmpxchg(&ct->state, old, new);
+	} while (old != state);
+
+	return new;
+}
+#else
+#define ct_state_inc_clear_work(x) ct_state_inc(x)
+#endif
+
 static __always_inline bool warn_rcu_enter(void)
 {
 	bool ret = false;
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index eb2149b20baef..b6ddfccba9714 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
+#include <linux/context_tracking_work.h>
 
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
@@ -39,16 +40,19 @@ struct context_tracking {
 };
 
 /*
- * We cram two different things within the same atomic variable:
+ * We cram up to three different things within the same atomic variable:
  *
- *                     CT_RCU_WATCHING_START  CT_STATE_START
- *                                |                |
- *                                v                v
- *     MSB [ RCU watching counter ][ context_state ] LSB
- *         ^                       ^
- *         |                       |
- * CT_RCU_WATCHING_END        CT_STATE_END
+ *                     CT_RCU_WATCHING_START                  CT_STATE_START
+ *                                |         CT_WORK_START          |
+ *                                |               |                |
+ *                                v               v                v
+ *     MSB [ RCU watching counter ][ context work ][ context_state ] LSB
+ *         ^                       ^               ^
+ *         |                       |               |
+ *         |                  CT_WORK_END          |
+ * CT_RCU_WATCHING_END                        CT_STATE_END
  *
+ * The [ context work ] region spans 0 bits if CONFIG_CONTEXT_WORK=n
  * Bits are used from the LSB upwards, so unused bits (if any) will always be in
  * upper bits of the variable.
  */
@@ -59,18 +63,24 @@ struct context_tracking {
 #define CT_STATE_START 0
 #define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
 
-#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
+#define CT_WORK_WIDTH (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? CT_WORK_MAX_OFFSET : 0)
+#define	CT_WORK_START (CT_STATE_END + 1)
+#define CT_WORK_END   (CT_WORK_START + CT_WORK_WIDTH - 1)
+
+#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_WORK_WIDTH - CT_STATE_WIDTH)
 #define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
-#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
+#define CT_RCU_WATCHING_START     (CT_WORK_END + 1)
 #define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
 #define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
 
 #define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
+#define CT_WORK_MASK         GENMASK(CT_WORK_END,         CT_WORK_START)
 #define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
 
 #define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
 
 static_assert(CT_STATE_WIDTH        +
+	      CT_WORK_WIDTH         +
 	      CT_RCU_WATCHING_WIDTH +
 	      CT_UNUSED_WIDTH       ==
 	      CT_SIZE);
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
new file mode 100644
index 0000000000000..c68245f8d77c5
--- /dev/null
+++ b/include/linux/context_tracking_work.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
+#define _LINUX_CONTEXT_TRACKING_WORK_H
+
+#include <linux/bitops.h>
+
+enum {
+	CT_WORK_n_OFFSET,
+	CT_WORK_MAX_OFFSET
+};
+
+enum ct_work {
+	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
+	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
+};
+
+#include <asm/context_tracking_work.h>
+
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+extern bool ct_set_cpu_work(unsigned int cpu, enum ct_work work);
+#else
+static inline bool
+ct_set_cpu_work(unsigned int cpu, unsigned int work) { return false; }
+#endif
+
+#endif
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 15f10ddec8cbe..f7019c12269f9 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -72,6 +72,67 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static noinstr void ct_work_flush(unsigned long seq)
+{
+	int bit;
+
+	seq = (seq & CT_WORK_MASK) >> CT_WORK_START;
+
+	/*
+	 * arch_context_tracking_work() must be noinstr, non-blocking,
+	 * and NMI safe.
+	 */
+	for_each_set_bit(bit, &seq, CT_WORK_MAX)
+		arch_context_tracking_work(BIT(bit));
+}
+
+/**
+ * ct_set_cpu_work - set work to be run at next kernel context entry
+ *
+ * If @cpu is not currently executing in kernelspace, it will execute the
+ * callback mapped to @work (see arch_context_tracking_work()) at its next
+ * transition to CT_KERNEL_STATE.
+ *
+ * If it is already in CT_KERNEL_STATE, this will be a no-op.
+ */
+bool ct_set_cpu_work(unsigned int cpu, enum ct_work work)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	unsigned int old;
+	bool ret = false;
+
+	if (!ct->active)
+		return false;
+
+	preempt_disable();
+
+	old = atomic_read(&ct->state);
+
+	/*
+	 * We only want to set the work bit if the target CPU is not in
+	 * kernelspace, so we clear the KERNEL bit here and let the cmpxchg do
+	 * the check for us - the state could change between the atomic_read() and
+	 * the cmpxchg().
+	 */
+	old &= ~CT_STATE_KERNEL;
+	/*
+	 * Try setting the work until either
+	 * - the target CPU has entered kernelspace
+	 * - the work has been set
+	 */
+	do {
+		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
+	} while (!ret && ((old & CT_STATE_MASK) != CT_STATE_KERNEL));
+
+	preempt_enable();
+	return ret;
+}
+#else
+static __always_inline void ct_work_flush(unsigned long work) { }
+static __always_inline void ct_work_clear(struct context_tracking *ct) { }
+#endif
+
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -88,7 +149,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * next idle sojourn.
 	 */
 	rcu_task_trace_heavyweight_enter();  // Before CT state update!
-	seq = ct_state_inc(offset);
+	seq = ct_state_inc_clear_work(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
 }
@@ -100,7 +161,7 @@ static noinstr void ct_kernel_exit_state(int offset)
  */
 static noinstr void ct_kernel_enter_state(int offset)
 {
-	int seq;
+	unsigned long seq;
 
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
@@ -108,6 +169,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 * critical section.
 	 */
 	seq = ct_state_inc(offset);
+	ct_work_flush(seq);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_task_trace_heavyweight_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b0b97a60aaa6f..7e8106a0d981f 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,6 +181,11 @@ config CONTEXT_TRACKING_USER_FORCE
 	  Say N otherwise, this option brings an overhead that you
 	  don't want in production.
 
+config CONTEXT_TRACKING_WORK
+	bool
+	depends on HAVE_CONTEXT_TRACKING_WORK && CONTEXT_TRACKING_USER
+	default y
+
 config NO_HZ
 	bool "Old Idle dynticks config"
 	help
-- 
2.43.0


