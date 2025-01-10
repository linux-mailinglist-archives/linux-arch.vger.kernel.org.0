Return-Path: <linux-arch+bounces-9683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24845A099E2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70E63A992F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAD12163B3;
	Fri, 10 Jan 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WN7IliZH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844762163A0
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534467; cv=none; b=h7zQtty8kya76LQuYptBRMtqvKRO1SrVcDapLQa1S5IzHVuph7IIMhdB3LEuTNmQZv+ooIeviIzzS1fddyCcdSUGsJdkdezq3//yPaNyQTcINDxzmkNPem2B26mBrowrvMsB4eYr/hJIXr00RLXSZGaPOcAp9Vtj8dfWBFw9hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534467; c=relaxed/simple;
	bh=oS6NVhF+DSa3bfb0jLd+nVgq34roa9GfyJSa086VnQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZR70oJuvwnPlOjpNRLJxYrUtmtbYA4CP0PJ4e7ca7ODRRgA/HCP5lshtkP5BvOW6aKbSyGRi80HwbRy5ZlooEETF0MzhSSjxolpjOs9bmSwNnIgJVc6RpUPFS9q6sibGwiaV4WXiJ1Qk13vJTymArD9nPkoNzJncEkYXn7dZp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WN7IliZH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43635895374so15646885e9.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534457; x=1737139257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06++54m2jQMoQajJn4JgiUDifyLkkN/hJfJdF7FjHRg=;
        b=WN7IliZHdzltLjGkykvDndAYXef6RTj23O/ltqw5zDbJO6DTFI4qHrxY4wlUsgphXn
         Flm78XaRinJNz9Og8hpPaaiVxGt3LX+zzMkt1bKLoluo0FOEXUCBaEK2fEwTdW1Mi1Ax
         JjsFJ2fHCZqOlsm8vYuo4EmxIyQ3vGL4abIbb8eCU0+UsZqyt5cCsmONvUjAq3xOHoJf
         1q4ehKmM49+x+5yHVzWSHp8ZN3BFa27gJszr2uxf73dag3RmADbRXfADPVZht0nuYhzn
         9rbYq3bcTKHZcR/ERTe7r0RdYevZfYMEjNQ4n4C7IEcaumIah03Ic1tIXyqA96zhlRic
         GQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534457; x=1737139257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06++54m2jQMoQajJn4JgiUDifyLkkN/hJfJdF7FjHRg=;
        b=QTrTy6UcaMOXRM6ALD6NBqlXcB8E6TH7e4CxRWMMy/dGYy1h3E7NrQIoFMGvtPy5g5
         93aX5tJyH9dZm5nKrr9br7Fi6VVWZWHtqhn/1X9LMF4eiNu9rQrUK65O8I86TKynRLML
         O9jZio65yr1CxHIsZr0ttNoGj8JJqvMpUKTDVIAcVrXd8L9xhWaZVZpFQpV1arcop8GR
         yUBEj6Xbwqmcjfqpgw5UCwLEypf1n3DQXz/U2eMeWPaIOIvsGbnguufZJD8IiBGGJtNR
         /Tl8M+L8vDBBe5440To/IpauieijDFbAkU8pQwuhHcw755T2WpY7mFsFQ3xsm7Fd6I9G
         fdiA==
X-Forwarded-Encrypted: i=1; AJvYcCUc21/jtnvaJccoGhTxBqOEhY4Uy+NRiiNzZUrPsdyYPFGxtzZiEPStn4ljZrjRPNyUoI6yyZdgfuFD@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqUKAaD9C9D2Or4mBRFfe8/iSK2N8mxBfG4pyUYHLbHyh9ioi
	WhoxUDTIYQa7q2fESqc8PZooBXUnGYtqLPNH1T0HJNKmNZPH69VqLVaEsbtSY3CQlDpr53DNp/t
	nrSi6ZnGi6g==
X-Google-Smtp-Source: AGHT+IGnlkbZgvto5V3RLsC0pJW1qd+uu81ptaoP4aB2W/3FKEzvBJWjRMlcB/euDId6QKmAnD2UbMWUf073rw==
X-Received: from wmqd22.prod.google.com ([2002:a05:600c:34d6:b0:436:185e:c91d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:444a:b0:434:fe3c:c662 with SMTP id 5b1f17b1804b1-436e9d7b99cmr59996085e9.12.1736534456699;
 Fri, 10 Jan 2025 10:40:56 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:31 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-5-8419288bc805@google.com>
Subject: [PATCH RFC v2 05/29] mm: asi: ASI support in interrupts/exceptions
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
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"

Add support for potentially switching address spaces from within
interrupts/exceptions/NMIs etc. An interrupt does not automatically
switch to the unrestricted address space. It can switch if needed to
access some memory not available in the restricted address space, using
the normal asi_exit call.

On return from the outermost interrupt, if the target address space was
the restricted address space (e.g. we were in the critical code path
between ASI Enter and VM Enter), the restricted address space will be
automatically restored. Otherwise, execution will continue in the
unrestricted address space until the next explicit ASI Enter.

In order to keep track of when to restore the restricted address space,
an interrupt/exception nesting depth counter is maintained per-task.
An alternative implementation without needing this counter is also
possible, but the counter unlocks an additional nice-to-have benefit by
allowing detection of whether or not we are currently executing inside
an exception context, which would be useful in a later patch.

Note that for KVM on SVM, this is not actually necessary as NMIs are in
fact maskable via CLGI. It's not clear to me if VMX has something
equivalent but we will need this infrastructure in place for userspace
support anyway.

RFC: Once userspace ASI is implemented, this idtentry integration
looks a bit heavy-handed. For example, we don't need this logic
for INT 80 emulation, so having it in DEFINE_IDTENTRY_RAW is
confusing. It could lead to a bug if the order of interrupter counter
modifications and ASI transition logic gets flipped around somehow.

checkpatch.pl SPACING is false positive. AVOID_BUG ignored for RFC.

Checkpatch-args: --ignore=SPACING,AVOID_BUG
Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h       | 68 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/idtentry.h  | 50 ++++++++++++++++++++++++-----
 arch/x86/include/asm/processor.h |  5 +++
 arch/x86/kernel/process.c        |  2 ++
 arch/x86/kernel/traps.c          | 22 +++++++++++++
 arch/x86/mm/asi.c                |  7 ++++-
 include/asm-generic/asi.h        | 10 ++++++
 7 files changed, 153 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index b9671ef2dd3278adceed18507fd260e21954d574..9a9a139518289fc65f26a4d1cd311aa52cc5357f 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -157,6 +157,11 @@ void asi_relax(void);
 /* Immediately exit the restricted address space if in it */
 void asi_exit(void);
 
+static inline void asi_init_thread_state(struct thread_struct *thread)
+{
+	thread->asi_state.intr_nest_depth = 0;
+}
+
 /* The target is the domain we'll enter when returning to process context. */
 static __always_inline struct asi *asi_get_target(struct task_struct *p)
 {
@@ -197,9 +202,10 @@ static __always_inline bool asi_is_relaxed(void)
 /*
  * Is the current task in the critical section?
  *
- * This is just the inverse of !asi_is_relaxed(). We have both functions in order to
- * help write intuitive client code. In particular, asi_is_tense returns false
- * when ASI is disabled, which is judged to make user code more obvious.
+ * This is just the inverse of !asi_is_relaxed(). We have both functions in
+ * order to help write intuitive client code. In particular, asi_is_tense
+ * returns false when ASI is disabled, which is judged to make user code more
+ * obvious.
  */
 static __always_inline bool asi_is_tense(void)
 {
@@ -211,6 +217,62 @@ static __always_inline pgd_t *asi_pgd(struct asi *asi)
 	return asi ? asi->pgd : NULL;
 }
 
+static __always_inline void asi_intr_enter(void)
+{
+	if (static_asi_enabled() && asi_is_tense()) {
+		current->thread.asi_state.intr_nest_depth++;
+		barrier();
+	}
+}
+
+void __asi_enter(void);
+
+static __always_inline void asi_intr_exit(void)
+{
+	if (static_asi_enabled() && asi_is_tense()) {
+		/*
+		 * If an access to sensitive memory got reordered after the
+		 * decrement, the #PF handler for that access would see a value
+		 * of 0 for the counter and re-__asi_enter before returning to
+		 * the faulting access, triggering an infinite PF loop.
+		 */
+		barrier();
+
+		if (--current->thread.asi_state.intr_nest_depth == 0) {
+			/*
+			 * If the decrement got reordered after __asi_enter, an
+			 * interrupt that came between __asi_enter and the
+			 * decrement would always see a nonzero value for the
+			 * counter so it wouldn't call __asi_enter again and we
+			 * would return to process context in the wrong address
+			 * space.
+			 */
+			barrier();
+			__asi_enter();
+		}
+	}
+}
+
+/*
+ * Returns the nesting depth of interrupts/exceptions that have interrupted the
+ * ongoing critical section. If the current task is not in a critical section
+ * this is 0.
+ */
+static __always_inline int asi_intr_nest_depth(void)
+{
+	return current->thread.asi_state.intr_nest_depth;
+}
+
+/*
+ * Remember that interrupts/exception don't count as the critical section. If
+ * you want to know if the current task is in the critical section use
+ * asi_is_tense().
+ */
+static __always_inline bool asi_in_critical_section(void)
+{
+	return asi_is_tense() && !asi_intr_nest_depth();
+}
+
 #define INIT_MM_ASI(init_mm) \
 	.asi_init_lock = __MUTEX_INITIALIZER(init_mm.asi_init_lock),
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ad5c68f0509d4dfd0834303c0f9dabc93ef73aa4..9e00da0a3b08f83ca5e603dc2abbfd5fa3059811 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -12,6 +12,7 @@
 #include <linux/hardirq.h>
 
 #include <asm/irq_stack.h>
+#include <asm/asi.h>
 
 typedef void (*idtentry_t)(struct pt_regs *regs);
 
@@ -55,12 +56,15 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	asi_intr_enter();						\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	asi_intr_exit();						\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -102,12 +106,15 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	asi_intr_enter();						\
+	state = irqentry_enter(regs);					\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	asi_intr_exit();						\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -139,7 +146,16 @@ static __always_inline void __##func(struct pt_regs *regs,		\
  * is required before the enter/exit() helpers are invoked.
  */
 #define DEFINE_IDTENTRY_RAW(func)					\
-__visible noinstr void func(struct pt_regs *regs)
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	asi_intr_enter();						\
+	__##func (regs);						\
+	asi_intr_exit();						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
 
 /**
  * DEFINE_FREDENTRY_RAW - Emit code for raw FRED entry points
@@ -178,7 +194,18 @@ noinstr void fred_##func(struct pt_regs *regs)
  * is required before the enter/exit() helpers are invoked.
  */
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
-__visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code);		\
+									\
+__visible noinstr void func(struct pt_regs *regs, unsigned long error_code)\
+{									\
+	asi_intr_enter();						\
+	__##func (regs, error_code);					\
+	asi_intr_exit();						\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs,		\
+				     unsigned long error_code)
 
 /**
  * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
@@ -209,14 +236,17 @@ static void __##func(struct pt_regs *regs, u32 vector);			\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 	u32 vector = (u32)(u8)error_code;				\
 									\
+	asi_intr_enter();						\
+	state = irqentry_enter(regs);					\
 	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	asi_intr_exit();						\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs, u32 vector)
@@ -255,13 +285,16 @@ static __always_inline void instr_##func(struct pt_regs *regs)		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	asi_intr_enter();						\
+	state = irqentry_enter(regs);					\
 	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	asi_intr_exit();						\
 }									\
 									\
 void fred_##func(struct pt_regs *regs)					\
@@ -294,13 +327,16 @@ static __always_inline void instr_##func(struct pt_regs *regs)		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	asi_intr_enter();						\
+	state = irqentry_enter(regs);					\
 	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
+	asi_intr_exit();						\
 }									\
 									\
 void fred_##func(struct pt_regs *regs)					\
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f02220e6b4df911d87e2fee4b497eade61a27161..a32a53405f45e4c0473fe081e216029cf5bd0cdd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -508,6 +508,11 @@ struct thread_struct {
 	struct {
 		/* Domain to enter when returning to process context. */
 		struct asi	*target;
+		/*
+		 * The depth of interrupt/exceptions interrupting an ASI
+		 * critical section
+		 */
+		int		intr_nest_depth;
 	} asi_state;
 #endif
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91f3d1171f307b92179556ba2d716d..44abc161820153b7f68664b97267658b8e011101 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,6 +96,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
+	asi_init_thread_state(&dst->thread);
+
 	/* Drop the copied pointer to current's fpstate */
 	dst->thread.fpu.fpstate = NULL;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2dbadf347b5f4f66625c4f49b76c41b412270d57..beea861da8d3e9a4e2afb3a92ed5f66f11d67bd6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -65,6 +65,7 @@
 #include <asm/umip.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/asi.h>
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
@@ -463,6 +464,27 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
+	/*
+	 * Do an asi_exit() only here because a #DF usually indicates
+	 * the system is in a really bad state, and we don't want to
+	 * cause any additional issue that would prevent us from
+	 * printing a correct stack trace.
+	 *
+	 * The additional issues are not related to a possible triple
+	 * fault, which can only occurs if a fault is encountered while
+	 * invoking this handler, but here we are already executing it.
+	 * Instead, an ASI-induced #PF here could potentially end up
+	 * getting another #DF. For example, if there was some issue in
+	 * invoking the #PF handler. The handler for the second #DF
+	 * could then again cause an ASI-induced #PF leading back to the
+	 * same recursion.
+	 *
+	 * This is not needed in the espfix64 case above, since that
+	 * code is about turning a #DF into a #GP which is okay to
+	 * handle in the restricted domain. That's also why we don't
+	 * asi_exit() in the #GP handler.
+	 */
+	asi_exit();
 	irqentry_nmi_enter(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 5baf563a078f5b3a6cd4b9f5e92baaf81b0774c4..054315d566c082c0925a00ce3a0877624c8b9957 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -235,7 +235,7 @@ static __always_inline void maybe_flush_data(struct asi *next_asi)
 	this_cpu_and(asi_taints, ~ASI_TAINTS_DATA_MASK);
 }
 
-static noinstr void __asi_enter(void)
+noinstr void __asi_enter(void)
 {
 	u64 asi_cr3;
 	struct asi *target = asi_get_target(current);
@@ -250,6 +250,7 @@ static noinstr void __asi_enter(void)
 	 * disabling preemption should be fine.
 	 */
 	VM_BUG_ON(preemptible());
+	VM_BUG_ON(current->thread.asi_state.intr_nest_depth != 0);
 
 	if (!target || target == this_cpu_read(curr_asi))
 		return;
@@ -290,6 +291,7 @@ noinstr void asi_enter(struct asi *asi)
 	if (!static_asi_enabled())
 		return;
 
+	VM_WARN_ON_ONCE(asi_intr_nest_depth());
 	VM_WARN_ON_ONCE(!asi);
 
 	/* Should not have an asi_enter() without a prior asi_relax(). */
@@ -305,6 +307,7 @@ EXPORT_SYMBOL_GPL(asi_enter);
 noinstr void asi_relax(void)
 {
 	if (static_asi_enabled()) {
+		VM_WARN_ON_ONCE(asi_intr_nest_depth());
 		barrier();
 		asi_set_target(current, NULL);
 	}
@@ -326,6 +329,8 @@ noinstr void asi_exit(void)
 
 	asi = this_cpu_read(curr_asi);
 	if (asi) {
+		WARN_ON_ONCE(asi_in_critical_section());
+
 		maybe_flush_control(NULL);
 
 		unrestricted_cr3 =
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index eedc961ee916a9e1da631ca489ea4a7bc9e6089f..7f542c59c2b8a2b74432e4edb7199f9171db8a84 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -52,6 +52,8 @@ static inline bool asi_is_relaxed(void) { return true; }
 
 static inline bool asi_is_tense(void) { return false; }
 
+static inline bool asi_in_critical_section(void) { return false; }
+
 static inline void asi_exit(void) { }
 
 static inline bool asi_is_restricted(void) { return false; }
@@ -65,6 +67,14 @@ static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
 
 static inline void asi_handle_switch_mm(void) { }
 
+static inline void asi_init_thread_state(struct thread_struct *thread) { }
+
+static inline void asi_intr_enter(void) { }
+
+static inline int asi_intr_nest_depth(void) { return 0; }
+
+static inline void asi_intr_exit(void) { }
+
 #define static_asi_enabled() false
 
 static inline void asi_check_boottime_disable(void) { }

-- 
2.47.1.613.gc27f4b7a9f-goog


