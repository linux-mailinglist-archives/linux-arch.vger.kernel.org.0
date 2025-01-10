Return-Path: <linux-arch+bounces-9684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB86FA099E7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F9C3A9CF1
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3449220688;
	Fri, 10 Jan 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqoMSySx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9B215798
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534467; cv=none; b=CXfBk9hcHunO7Ycsqmo7z4os7Q0sMoZOFQHs0geRrxRIlKJ2z8UUzBuSXnjUaIUrCQpeemxwWiCqg8dXM7r77qqE5qUVjwSoOjkzSOGbuE11XpAQ1OdM0ROxNTAYu3qEfs5YcMRB+YbDMSYvUp7GqoVnU9wW50cozWCk7ifAxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534467; c=relaxed/simple;
	bh=ppNCw40AQelfOsMApvnPgOpEK2zwiMkQe7+3NgGhc9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2aOyQFMCqyxcwidw8qn6i+I1EIbUL8zxeMiVEsijpWYByimGMDXjup36lOS2QBaZosRicAQ+tx4FP39MIiPU2WLm4bJE3b6RMd0KUML0/dXDk3Rax0HZNhNY8blAzLewL2L0jDKnzQdKuAAwuNP1o3ESFKwR6jV1xBCGGrT6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqoMSySx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43673af80a6so19099905e9.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534453; x=1737139253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoGlz9R9SPVMFZpNV+d4L6dWHbzE359F5HGhLwEH9Ng=;
        b=MqoMSySxoM8TqrR9EwnUzkPsSPMjbI4W1MuluzX5TWhEHYtEmrtITy2o3pLcm2bYfc
         2J4/YeiW00MpByq2xDFV38JgnqIibWQNLLLvyz4FHq4rtNHV65mVd/S8ceUt3gH5UxTc
         TzjRPy/S4K5GiNCI/YOF2dFnE154J9Fuqdj+QUhtVug3f/0d7zLy5lXWfSHDCiAEeEAc
         Dx1E5MAX1JkbgQ+VmrX8daagj/X/QF9CUo31TL/NrB9F+fhP7I/lqPN2KK9oCsWxPsIZ
         DbLd+ti6D4VViOrc1VNtIyPzOTM32G0Cpw68sR5qQca9rkrRdTWwoXIKiS8jc6HyBnDT
         lJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534453; x=1737139253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoGlz9R9SPVMFZpNV+d4L6dWHbzE359F5HGhLwEH9Ng=;
        b=LwH3Zg4dgoc++zMUPFndNjRN1BXZYQBvzJ1RGgxvRrtt5H+FoaFEZr2KfJaUYGVlM2
         JihLKG5hsKkzwQpgNBQS9nLZcJaJsLTIB8rCGjgrtCp4/PjLFOQd9nwNu+0gTcz/2QNN
         HFSUxqdBl3sqlefQmGY/nRlhq/KMJiNvziEiO8ghm+w2WyC/C0AWi7U9ggt0yyrsKx/J
         s6pomrgZ9yhOzGrkgqJfnnvSsg5rT5AJV27DGlW4wEgonKJgYxoDSLNnsdunN7PDdXp6
         z3AxTbrqagsJixkYIVW+i93nalNmUZe7J7awpWHWpiik3ldBuvoZHFYL1J1hnvXmum2x
         QTCg==
X-Forwarded-Encrypted: i=1; AJvYcCWQS1g5YKbn3ssfrM+W3XbouZqeFuk8F6jnqMyE8Vtnl1Owyb26luYN2Xqp4yrI5N6ien3DTN7gjR/O@vger.kernel.org
X-Gm-Message-State: AOJu0YwquJVpynXJEbxGvvPIiLr7Xi8Ie2o316AFxrO/Uo7sooSXjhte
	FctviV4X7Fg9o9oDOQewCe8/0qGaf1loGyruxDONZ0gxaY8/Er2/ofi8AeAZRT9+WgUtT2XLIib
	s0a7FQmMNlw==
X-Google-Smtp-Source: AGHT+IFPE8+5SCTXqr49FlBKd+8kKzimRqkvhpstM5ymbp/ZYkpFIu6SM4TYwUHOcXTpPXWmM6SB9Eylsg8TKg==
X-Received: from wmbhg22.prod.google.com ([2002:a05:600c:5396:b0:434:e90f:9fd3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4745:b0:434:9c60:95a3 with SMTP id 5b1f17b1804b1-436e26c4218mr116881415e9.11.1736534452359;
 Fri, 10 Jan 2025 10:40:52 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:29 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-3-8419288bc805@google.com>
Subject: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Ofir Weisse <oweisse@google.com>, 
	Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce core API for Address Space Isolation (ASI).  Kernel address
space isolation provides the ability to run some kernel
code with a restricted kernel address space.

There can be multiple classes of such restricted kernel address spaces
(e.g. KPTI, KVM-PTI etc.). Each ASI class is identified by an index.
The ASI class can register some hooks to be called when
entering/exiting the restricted address space.

Currently, there is a fixed maximum number of ASI classes supported.
In addition, each process can have at most one restricted address space
from each ASI class. Neither of these are inherent limitations and
are merely simplifying assumptions for the time being.

To keep things simpler for the time being, we disallow context switches
within the restricted address space. In the future, we would be able to
relax this limitation for the case of context switches to different
threads within the same process (or to the idle thread and back).

Note that this doesn't really support protecting sibling VM guests
within the same VMM process from one another. From first principles
it seems unlikely that anyone who cares about VM isolation would do
that, but there could be a use-case to think about. In that case need
something like the OTHER_MM logic might be needed, but specific to
intra-process guest separation.

[0]:
https://lore.kernel.org/kvm/1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com

Notes about RFC-quality implementation details:

 - Ignoring checkpatch.pl AVOID_BUG.
 - The dynamic registration of classes might be pointless complexity.
   This was kept from RFCv1 without much thought.
 - The other-mm logic is also perhaps overly complex, suggestions are
   welcome for how best to tackle this (or we could just forget about
   it for the moment, and rely on asi_exit() happening in process
   switch).
 - The taint flag definitions would probably be clearer with an enum or
   something.

Checkpatch-args: --ignore=AVOID_BUG,COMMIT_LOG_LONG_LINE,EXPORT_SYMBOL
Co-developed-by: Ofir Weisse <oweisse@google.com>
Signed-off-by: Ofir Weisse <oweisse@google.com>
Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h       | 208 +++++++++++++++++++++++
 arch/x86/include/asm/processor.h |   8 +
 arch/x86/mm/Makefile             |   1 +
 arch/x86/mm/asi.c                | 350 +++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/init.c               |   3 +-
 arch/x86/mm/tlb.c                |   1 +
 include/asm-generic/asi.h        |  67 ++++++++
 include/linux/mm_types.h         |   7 +
 kernel/fork.c                    |   3 +
 kernel/sched/core.c              |   9 +
 mm/init-mm.c                     |   4 +
 11 files changed, 660 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
new file mode 100644
index 0000000000000000000000000000000000000000..7cc635b6653a3970ba9dbfdc9c828a470e27bd44
--- /dev/null
+++ b/arch/x86/include/asm/asi.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ASI_H
+#define _ASM_X86_ASI_H
+
+#include <linux/sched.h>
+
+#include <asm-generic/asi.h>
+
+#include <asm/pgtable_types.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
+/*
+ * Overview of API usage by ASI clients:
+ *
+ * Setup: First call asi_init() to create a domain. At present only one domain
+ * can be created per mm per class, but it's safe to asi_init() this domain
+ * multiple times. For each asi_init() call you must call asi_destroy() AFTER
+ * you are certain all CPUs have exited the restricted address space (by
+ * calling asi_exit()).
+ *
+ * Runtime usage:
+ *
+ * 1. Call asi_enter() to switch to the restricted address space. This can't be
+ *    from an interrupt or exception handler and preemption must be disabled.
+ *
+ * 2. Execute untrusted code.
+ *
+ * 3. Call asi_relax() to inform the ASI subsystem that untrusted code execution
+ *    is finished. This doesn't cause any address space change. This can't be
+ *    from an interrupt or exception handler and preemption must be disabled.
+ *
+ * 4. Either:
+ *
+ *    a. Go back to 1.
+ *
+ *    b. Call asi_exit() before returning to userspace. This immediately
+ *       switches to the unrestricted address space.
+ *
+ * The region between 1 and 3 is called the "ASI critical section". During the
+ * critical section, it is a bug to access any sensitive data, and you mustn't
+ * sleep.
+ *
+ * The restriction on sleeping is not really a fundamental property of ASI.
+ * However for performance reasons it's important that the critical section is
+ * absolutely as short as possible. So the ability to do sleepy things like
+ * taking mutexes oughtn't to confer any convenience on API users.
+ *
+ * Similarly to the issue of sleeping, the need to asi_exit in case 4b is not a
+ * fundamental property of the system but a limitation of the current
+ * implementation. With further work it is possible to context switch
+ * from and/or to the restricted address space, and to return to userspace
+ * directly from the restricted address space, or _in_ it.
+ *
+ * Note that the critical section only refers to the direct execution path from
+ * asi_enter to asi_relax: it's fine to access sensitive data from exceptions
+ * and interrupt handlers that occur during that time. ASI will re-enter the
+ * restricted address space before returning from the outermost
+ * exception/interrupt.
+ *
+ * Note: ASI does not modify KPTI behaviour; when ASI and KPTI run together
+ * there are 2+N address spaces per task: the unrestricted kernel address space,
+ * the user address space, and one restricted (kernel) address space for each of
+ * the N ASI classes.
+ */
+
+/*
+ * ASI uses a per-CPU tainting model to track what mitigation actions are
+ * required on domain transitions. Taints exist along two dimensions:
+ *
+ *  - Who touched the CPU (guest, unprotected kernel, userspace).
+ *
+ *  - What kind of state might remain: "data" means there might be data owned by
+ *    a victim domain left behind in a sidechannel. "Control" means there might
+ *    be state controlled by an attacker domain left behind in the branch
+ *    predictor.
+ *
+ *    In principle the same domain can be both attacker and victim, thus we have
+ *    both data and control taints for userspace, although there's no point in
+ *    trying to protect against attacks from the kernel itself, so there's no
+ *    ASI_TAINT_KERNEL_CONTROL.
+ */
+#define ASI_TAINT_KERNEL_DATA		((asi_taints_t)BIT(0))
+#define ASI_TAINT_USER_DATA		((asi_taints_t)BIT(1))
+#define ASI_TAINT_GUEST_DATA		((asi_taints_t)BIT(2))
+#define ASI_TAINT_OTHER_MM_DATA		((asi_taints_t)BIT(3))
+#define ASI_TAINT_USER_CONTROL		((asi_taints_t)BIT(4))
+#define ASI_TAINT_GUEST_CONTROL		((asi_taints_t)BIT(5))
+#define ASI_TAINT_OTHER_MM_CONTROL	((asi_taints_t)BIT(6))
+#define ASI_NUM_TAINTS			6
+static_assert(BITS_PER_BYTE * sizeof(asi_taints_t) >= ASI_NUM_TAINTS);
+
+#define ASI_TAINTS_CONTROL_MASK \
+	(ASI_TAINT_USER_CONTROL | ASI_TAINT_GUEST_CONTROL | ASI_TAINT_OTHER_MM_CONTROL)
+
+#define ASI_TAINTS_DATA_MASK \
+	(ASI_TAINT_KERNEL_DATA | ASI_TAINT_USER_DATA | ASI_TAINT_OTHER_MM_DATA)
+
+#define ASI_TAINTS_GUEST_MASK (ASI_TAINT_GUEST_DATA | ASI_TAINT_GUEST_CONTROL)
+#define ASI_TAINTS_USER_MASK (ASI_TAINT_USER_DATA | ASI_TAINT_USER_CONTROL)
+
+/* The taint policy tells ASI how a class interacts with the CPU taints */
+struct asi_taint_policy {
+	/*
+	 * What taints would necessitate a flush when entering the domain, to
+	 * protect it from attack by prior domains?
+	 */
+	asi_taints_t prevent_control;
+	/*
+	 * What taints would necessetate a flush when entering the domain, to
+	 * protect former domains from attack by this domain?
+	 */
+	asi_taints_t protect_data;
+	/* What taints should be set when entering the domain? */
+	asi_taints_t set;
+};
+
+/*
+ * An ASI domain (struct asi) represents a restricted address space. The
+ * unrestricted address space (and user address space under PTI) are not
+ * represented as a domain.
+ */
+struct asi {
+	pgd_t *pgd;
+	struct mm_struct *mm;
+	int64_t ref_count;
+	enum asi_class_id class_id;
+};
+
+DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
+
+void asi_init_mm_state(struct mm_struct *mm);
+
+int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
+void asi_uninit_class(enum asi_class_id class_id);
+const char *asi_class_name(enum asi_class_id class_id);
+
+int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi);
+void asi_destroy(struct asi *asi);
+
+/* Enter an ASI domain (restricted address space) and begin the critical section. */
+void asi_enter(struct asi *asi);
+
+/*
+ * Leave the "tense" state if we are in it, i.e. end the critical section. We
+ * will stay relaxed until the next asi_enter.
+ */
+void asi_relax(void);
+
+/* Immediately exit the restricted address space if in it */
+void asi_exit(void);
+
+/* The target is the domain we'll enter when returning to process context. */
+static __always_inline struct asi *asi_get_target(struct task_struct *p)
+{
+	return p->thread.asi_state.target;
+}
+
+static __always_inline void asi_set_target(struct task_struct *p,
+					   struct asi *target)
+{
+	p->thread.asi_state.target = target;
+}
+
+static __always_inline struct asi *asi_get_current(void)
+{
+	return this_cpu_read(curr_asi);
+}
+
+/* Are we currently in a restricted address space? */
+static __always_inline bool asi_is_restricted(void)
+{
+	return (bool)asi_get_current();
+}
+
+/* If we exit/have exited, can we stay that way until the next asi_enter? */
+static __always_inline bool asi_is_relaxed(void)
+{
+	return !asi_get_target(current);
+}
+
+/*
+ * Is the current task in the critical section?
+ *
+ * This is just the inverse of !asi_is_relaxed(). We have both functions in order to
+ * help write intuitive client code. In particular, asi_is_tense returns false
+ * when ASI is disabled, which is judged to make user code more obvious.
+ */
+static __always_inline bool asi_is_tense(void)
+{
+	return !asi_is_relaxed();
+}
+
+static __always_inline pgd_t *asi_pgd(struct asi *asi)
+{
+	return asi ? asi->pgd : NULL;
+}
+
+#define INIT_MM_ASI(init_mm) \
+	.asi_init_lock = __MUTEX_INITIALIZER(init_mm.asi_init_lock),
+
+void asi_handle_switch_mm(void);
+
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
+#endif
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1a1b7ea5d7d32a47d783d9d62cd2a53672addd6f..f02220e6b4df911d87e2fee4b497eade61a27161 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -5,6 +5,7 @@
 #include <asm/processor-flags.h>
 
 /* Forward declaration, a strange C thing */
+struct asi;
 struct task_struct;
 struct mm_struct;
 struct io_bitmap;
@@ -503,6 +504,13 @@ struct thread_struct {
 	struct thread_shstk	shstk;
 #endif
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	struct {
+		/* Domain to enter when returning to process context. */
+		struct asi	*target;
+	} asi_state;
+#endif
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e8538b62a176ce838820e363575b7897..89ade7363798cc20d5e5643526eba7378174baa0 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
+obj-$(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION)		+= asi.o
 
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
new file mode 100644
index 0000000000000000000000000000000000000000..105cd8b43eaf5c20acc80d4916b761559fb95d74
--- /dev/null
+++ b/arch/x86/mm/asi.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler_types.h>
+#include <linux/export.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+
+#include <asm/asi.h>
+#include <asm/cmdline.h>
+#include <asm/cpufeature.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
+
+static struct asi_taint_policy *taint_policies[ASI_MAX_NUM_CLASSES];
+
+const char *asi_class_names[] = {
+#if IS_ENABLED(CONFIG_KVM)
+	[ASI_CLASS_KVM] = "KVM",
+#endif
+};
+
+DEFINE_PER_CPU_ALIGNED(struct asi *, curr_asi);
+EXPORT_SYMBOL(curr_asi);
+
+static inline bool asi_class_id_valid(enum asi_class_id class_id)
+{
+	return class_id >= 0 && class_id < ASI_MAX_NUM_CLASSES;
+}
+
+static inline bool asi_class_initialized(enum asi_class_id class_id)
+{
+	if (WARN_ON(!asi_class_id_valid(class_id)))
+		return false;
+
+	return !!(taint_policies[class_id]);
+}
+
+int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy)
+{
+	if (asi_class_initialized(class_id))
+		return -EEXIST;
+
+	WARN_ON(!(taint_policy->prevent_control & ASI_TAINTS_CONTROL_MASK));
+	WARN_ON(!(taint_policy->protect_data & ASI_TAINTS_DATA_MASK));
+
+	taint_policies[class_id] = taint_policy;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asi_init_class);
+
+void asi_uninit_class(enum asi_class_id class_id)
+{
+	if (!asi_class_initialized(class_id))
+		return;
+
+	taint_policies[class_id] = NULL;
+}
+EXPORT_SYMBOL_GPL(asi_uninit_class);
+
+const char *asi_class_name(enum asi_class_id class_id)
+{
+	if (WARN_ON_ONCE(!asi_class_id_valid(class_id)))
+		return "<invalid>";
+
+	return asi_class_names[class_id];
+}
+
+static void __asi_destroy(struct asi *asi)
+{
+	lockdep_assert_held(&asi->mm->asi_init_lock);
+
+}
+
+int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi)
+{
+	struct asi *asi;
+	int err = 0;
+
+	*out_asi = NULL;
+
+	if (WARN_ON(!asi_class_initialized(class_id)))
+		return -EINVAL;
+
+	asi = &mm->asi[class_id];
+
+	mutex_lock(&mm->asi_init_lock);
+
+	if (asi->ref_count++ > 0)
+		goto exit_unlock; /* err is 0 */
+
+	BUG_ON(asi->pgd != NULL);
+
+	/*
+	 * For now, we allocate 2 pages to avoid any potential problems with
+	 * KPTI code. This won't be needed once KPTI is folded into the ASI
+	 * framework.
+	 */
+	asi->pgd = (pgd_t *)__get_free_pages(
+		GFP_KERNEL_ACCOUNT | __GFP_ZERO, PGD_ALLOCATION_ORDER);
+	if (!asi->pgd) {
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	asi->mm = mm;
+	asi->class_id = class_id;
+
+exit_unlock:
+	if (err)
+		__asi_destroy(asi);
+	else
+		*out_asi = asi;
+
+	mutex_unlock(&mm->asi_init_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(asi_init);
+
+void asi_destroy(struct asi *asi)
+{
+	struct mm_struct *mm;
+
+	if (!asi)
+		return;
+
+	if (WARN_ON(!asi_class_initialized(asi->class_id)))
+		return;
+
+	mm = asi->mm;
+	/*
+	 * We would need this mutex even if the refcount was atomic as we need
+	 * to block concurrent asi_init calls.
+	 */
+	mutex_lock(&mm->asi_init_lock);
+	WARN_ON_ONCE(asi->ref_count <= 0);
+	if (--(asi->ref_count) == 0) {
+		free_pages((ulong)asi->pgd, PGD_ALLOCATION_ORDER);
+		memset(asi, 0, sizeof(struct asi));
+	}
+	mutex_unlock(&mm->asi_init_lock);
+}
+EXPORT_SYMBOL_GPL(asi_destroy);
+
+DEFINE_PER_CPU_ALIGNED(asi_taints_t, asi_taints);
+
+/*
+ * Flush out any potentially malicious speculative control flow (e.g. branch
+ * predictor) state if necessary when we are entering a new domain (which may be
+ * NULL when we are exiting to the restricted address space).
+ *
+ * This is "backwards-looking" mitigation, the attacker is in the past: we want
+ * then when logically transitioning from A to B and B doesn't trust A.
+ *
+ * This function must tolerate reentrancy.
+ */
+static __always_inline void maybe_flush_control(struct asi *next_asi)
+{
+	asi_taints_t taints = this_cpu_read(asi_taints);
+
+	if (next_asi) {
+		taints &= taint_policies[next_asi->class_id]->prevent_control;
+	} else {
+		/*
+		 * Going to the unrestricted address space, this has an implicit
+		 * policy of flushing all taints.
+		 */
+		taints &= ASI_TAINTS_CONTROL_MASK;
+	}
+
+	if (!taints)
+		return;
+
+	/*
+	 * This is where we'll do the actual dirty work of clearing uarch state.
+	 * For now we just pretend, clear the taints.
+	 */
+	this_cpu_and(asi_taints, ~ASI_TAINTS_CONTROL_MASK);
+}
+
+/*
+ * Flush out any data that might be hanging around in uarch state that can be
+ * leaked through sidechannels if necessary when we are entering a new domain.
+ *
+ * This is "forwards-looking" mitigation, the attacker is in the future: we want
+ * this when logically transitioning from A to B and A doesn't trust B.
+ *
+ * This function must tolerate reentrancy.
+ */
+static __always_inline void maybe_flush_data(struct asi *next_asi)
+{
+	asi_taints_t taints = this_cpu_read(asi_taints)
+		& taint_policies[next_asi->class_id]->protect_data;
+
+	if (!taints)
+		return;
+
+	/*
+	 * This is where we'll do the actual dirty work of clearing uarch state.
+	 * For now we just pretend, clear the taints.
+	 */
+	this_cpu_and(asi_taints, ~ASI_TAINTS_DATA_MASK);
+}
+
+static noinstr void __asi_enter(void)
+{
+	u64 asi_cr3;
+	struct asi *target = asi_get_target(current);
+
+	/*
+	 * This is actually false restriction, it should be fine to be
+	 * preemptible during the critical section. But we haven't tested it. We
+	 * will also need to disable preemption during this function itself and
+	 * perhaps elsewhere. This false restriction shouldn't create any
+	 * additional burden for ASI clients anyway: the critical section has
+	 * to be as short as possible to avoid unnecessary ASI transitions so
+	 * disabling preemption should be fine.
+	 */
+	VM_BUG_ON(preemptible());
+
+	if (!target || target == this_cpu_read(curr_asi))
+		return;
+
+	VM_BUG_ON(this_cpu_read(cpu_tlbstate.loaded_mm) ==
+		  LOADED_MM_SWITCHING);
+
+	/*
+	 * Must update curr_asi before writing CR3 to ensure an interrupting
+	 * asi_exit sees that it may need to switch address spaces.
+	 * This is the real beginning of the ASI critical section.
+	 */
+	this_cpu_write(curr_asi, target);
+	maybe_flush_control(target);
+
+	asi_cr3 = build_cr3_noinstr(target->pgd,
+				    this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+				    tlbstate_lam_cr3_mask());
+	write_cr3(asi_cr3);
+
+	maybe_flush_data(target);
+	/*
+	 * It's fine to set the control taints late like this, since we haven't
+	 * actually got to the untrusted code yet. Waiting until now to set the
+	 * data taints is less obviously correct: we've mapped in the incoming
+	 * domain's secrets now so we can't guarantee they haven't already got
+	 * into a sidechannel. However, preemption is off so the only way we can
+	 * reach another asi_enter() is in the return from an interrupt - in
+	 * that case the reentrant asi_enter() call is entering the same domain
+	 * that we're entering at the moment, it doesn't need to flush those
+	 * secrets.
+	 */
+	this_cpu_or(asi_taints, taint_policies[target->class_id]->set);
+}
+
+noinstr void asi_enter(struct asi *asi)
+{
+	VM_WARN_ON_ONCE(!asi);
+
+	/* Should not have an asi_enter() without a prior asi_relax(). */
+	VM_WARN_ON_ONCE(asi_get_target(current));
+
+	asi_set_target(current, asi);
+	barrier();
+
+	__asi_enter();
+}
+EXPORT_SYMBOL_GPL(asi_enter);
+
+noinstr void asi_relax(void)
+{
+	barrier();
+	asi_set_target(current, NULL);
+}
+EXPORT_SYMBOL_GPL(asi_relax);
+
+noinstr void asi_exit(void)
+{
+	u64 unrestricted_cr3;
+	struct asi *asi;
+
+	preempt_disable_notrace();
+
+	VM_BUG_ON(this_cpu_read(cpu_tlbstate.loaded_mm) ==
+		  LOADED_MM_SWITCHING);
+
+	asi = this_cpu_read(curr_asi);
+	if (asi) {
+		maybe_flush_control(NULL);
+
+		unrestricted_cr3 =
+			build_cr3_noinstr(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+					  this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+					  tlbstate_lam_cr3_mask());
+
+		/* Tainting first makes reentrancy easier to reason about.  */
+		this_cpu_or(asi_taints, ASI_TAINT_KERNEL_DATA);
+		write_cr3(unrestricted_cr3);
+		/*
+		 * Must not update curr_asi until after CR3 write, otherwise a
+		 * re-entrant call might not enter this branch. (This means we
+		 * might do unnecessary CR3 writes).
+		 */
+		this_cpu_write(curr_asi, NULL);
+	}
+
+	preempt_enable_notrace();
+}
+EXPORT_SYMBOL_GPL(asi_exit);
+
+void asi_init_mm_state(struct mm_struct *mm)
+{
+	memset(mm->asi, 0, sizeof(mm->asi));
+	mutex_init(&mm->asi_init_lock);
+}
+
+void asi_handle_switch_mm(void)
+{
+	/*
+	 * We can't handle context switching in the restricted address space yet
+	 * so this is pointless in practice (we asi_exit() in this path, which
+	 * doesn't care about the fine details of who exactly got at the branch
+	 * predictor), but just to illustrate how the tainting model is supposed
+	 * to work, here we squash the per-domain (guest/userspace) taints into
+	 * a general "other MM" taint. Other processes don't care if their peers
+	 * are attacking them from a guest or from bare metal.
+	 */
+	asi_taints_t taints = this_cpu_read(asi_taints);
+	asi_taints_t new_taints = 0;
+
+	if (taints & ASI_TAINTS_CONTROL_MASK)
+		new_taints |= ASI_TAINT_OTHER_MM_CONTROL;
+	if (taints & ASI_TAINTS_DATA_MASK)
+		new_taints |= ASI_TAINT_OTHER_MM_DATA;
+
+	/*
+	 * We can't race with asi_enter() or we'd clobber the taint it sets.
+	 * Would be odd given this function says context_switch in the name but
+	 * just be to sure...
+	 */
+	lockdep_assert_preemption_disabled();
+
+	/*
+	 * Can'tt just this_cpu_write here as we could be racing with asi_exit()
+	 * (at least, in the future where this function is actually necessary),
+	 * we mustn't clobber ASI_TAINT_KERNEL_DATA.
+	 */
+	this_cpu_or(asi_taints, new_taints);
+	this_cpu_and(asi_taints, ~(ASI_TAINTS_GUEST_MASK | ASI_TAINTS_USER_MASK));
+}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f53c3195ca4f299593c0112dab0fb09e7dd..de4227ed5169ff84d0ce80b677caffc475198fa6 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -250,7 +250,8 @@ static void __init probe_page_size_mask(void)
 	/* By the default is everything supported: */
 	__default_kernel_pte_mask = __supported_pte_mask;
 	/* Except when with PTI where the kernel is mostly non-Global: */
-	if (cpu_feature_enabled(X86_FEATURE_PTI))
+	if (cpu_feature_enabled(X86_FEATURE_PTI) ||
+	    IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION))
 		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/* Enable 1 GB linear kernel mappings if available: */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f0428e5e1f1947903ee87c4c6444844ee11b45c3..7c2309996d1d5a7cac23bd122f7b56a869d67d6a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -608,6 +608,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * Apply process to process speculation vulnerability
 		 * mitigations if applicable.
 		 */
+		asi_handle_switch_mm();
 		cond_mitigation(tsk);
 
 		/*
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index c4d9a5ff860a96428422a15000c622aeecc2d664..6b84202837605fa57e4a910318c8353b3f816f06 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -2,4 +2,71 @@
 #ifndef __ASM_GENERIC_ASI_H
 #define __ASM_GENERIC_ASI_H
 
+#include <linux/types.h>
+
+#ifndef _ASSEMBLY_
+
+/*
+ * An ASI class is a type of isolation that can be applied to a process. A
+ * process may have a domain for each class.
+ */
+enum asi_class_id {
+#if IS_ENABLED(CONFIG_KVM)
+	ASI_CLASS_KVM,
+#endif
+	ASI_MAX_NUM_CLASSES,
+};
+
+typedef u8 asi_taints_t;
+
+#ifndef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
+struct asi_hooks {};
+struct asi {};
+
+static inline
+int asi_init_class(enum asi_class_id class_id,
+		       asi_taints_t control_taints, asi_taints_t data_taints)
+{
+	return 0;
+}
+
+static inline void asi_uninit_class(enum asi_class_id class_id) { }
+
+struct mm_struct;
+static inline void asi_init_mm_state(struct mm_struct *mm) { }
+
+static inline int asi_init(struct mm_struct *mm, enum asi_class_id class_id,
+			   struct asi **out_asi)
+{
+	return 0;
+}
+
+static inline void asi_destroy(struct asi *asi) { }
+
+static inline void asi_enter(struct asi *asi) { }
+
+static inline void asi_relax(void) { }
+
+static inline bool asi_is_relaxed(void) { return true; }
+
+static inline bool asi_is_tense(void) { return false; }
+
+static inline void asi_exit(void) { }
+
+static inline bool asi_is_restricted(void) { return false; }
+
+static inline struct asi *asi_get_current(void) { return NULL; }
+
+struct task_struct;
+static inline struct asi *asi_get_target(struct task_struct *p) { return NULL; }
+
+static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
+
+static inline void asi_handle_switch_mm(void) { }
+
+#endif /* !CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+
+#endif  /* !_ASSEMBLY_ */
+
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bcaee66a71f5566ac7debb94c0ee78..391e32a41ca3df84a619f3ee8ea45d3729a43023 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,8 +19,10 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/mutex.h>
 
 #include <asm/mmu.h>
+#include <asm/asi.h>
 
 #ifndef AT_VECTOR_SIZE_ARCH
 #define AT_VECTOR_SIZE_ARCH 0
@@ -826,6 +828,11 @@ struct mm_struct {
 		atomic_t membarrier_state;
 #endif
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+		struct asi asi[ASI_MAX_NUM_CLASSES];
+		struct mutex asi_init_lock;
+#endif
+
 		/**
 		 * @mm_users: The number of users including userspace.
 		 *
diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031d48fd5be2606e86642334be9735f..bb73758790d08112265d398b16902ff9a4c2b8fe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/asi.h>
 
 #include <trace/events/sched.h>
 
@@ -1296,6 +1297,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	asi_init_mm_state(mm);
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1c353a62c5684e3e773dd100afbddb818c480be..b1f7f73730c1e56f700cd3611a8093f177184842 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -78,6 +78,7 @@
 #include <asm/irq_regs.h>
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
+#include <asm/asi.h>
 
 #define CREATE_TRACE_POINTS
 #include <linux/sched/rseq_api.h>
@@ -5272,6 +5273,14 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
+	/*
+	 * It's possible to avoid this by tweaking ASI's domain management code
+	 * and updating code that modifies CR3 to be ASI-aware. Even without
+	 * that, it's probably possible to get rid of this in certain cases just
+	 * by fiddling with the context switch path itself.
+	 */
+	asi_exit();
+
 	prepare_task_switch(rq, prev, next);
 
 	/*
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 24c809379274503ac4f261fe7cfdbab3cb1ed1e7..e820e1c6edd48836a0ebe58e777046498d6a89ee 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -12,6 +12,7 @@
 #include <linux/user_namespace.h>
 #include <linux/iommu.h>
 #include <asm/mmu.h>
+#include <asm/asi.h>
 
 #ifndef INIT_MM_CONTEXT
 #define INIT_MM_CONTEXT(name)
@@ -44,6 +45,9 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	INIT_MM_ASI(init_mm)
+#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 

-- 
2.47.1.613.gc27f4b7a9f-goog


