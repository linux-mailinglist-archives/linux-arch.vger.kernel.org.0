Return-Path: <linux-arch+bounces-4791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCC901F7F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 12:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69E8B21775
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12474C1B;
	Mon, 10 Jun 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l4x5w6bf"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23076A953;
	Mon, 10 Jun 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016238; cv=none; b=b8wHR5XxZCsh0xMwW4/nB/Y01m3T8X0j2MkjBeYcQcxbPDnaOxe37L2c9jKVC9CBYKJf1jxjFfZhu51HwpmBmP6zofi7HvnqmKfUbO5RiNQNsMOj0ilf7EIcz0vxqwCV520cNR4OYHa75drpUhEkudQyAuTkwU3Ww9BzhB77J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016238; c=relaxed/simple;
	bh=xbOpV55tnYKAL2xoH5MhtRABX8wVgTGWR/KCz2sEnIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZycWjorbp9i6QrnkQ7DR3jDvLBQYxfeWfa8IVcc2D3yBAdfjF1+DizcCF8ooOUgOOD+QTzgAKm0zr+ZzVyYiFOE1IQWYDmTv8FdanfDj3a2DsosTb4iopyxtMHrWQLYtye9aBDKFNZikVILDu/IdMSXidRJUAg2b8GXj/hG70s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l4x5w6bf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RCp5PQyvd+ZGs5pqurjRzi25/CCJCfeb+DUNbZo1X34=; b=l4x5w6bfNylNn4IocjXwskgIe6
	mTc97tURiNfahmK5+eoxSaVv0g9dANoXHgXjHqjPMS1BnPjifB/IjHoBiEyQTwmJLwSGUPRgAcY8F
	vSCnRRzn5CAhfTJyrS23PnIfupVh91S3veuBhDxcNEDy255s2cOmRpAajDo/bx1PfqYMYI7yVEXA2
	F8CG8v2gR0f+Rw+wVkGySOqwt5is6iKzHGXwx7utA7y0INbVfD6l0nS/fd+QECdjn8tKmTLTmcA74
	20OOJ7SzcuZ2fDcf/cU80451By5U2syy4nlCTyfTSETED/NgDsuclcSYe8+KTcZflFqOvTnVq13gq
	yPOe24Pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGcVE-00000008w2D-2IQd;
	Mon, 10 Jun 2024 10:43:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 265C7300439; Mon, 10 Jun 2024 12:43:52 +0200 (CEST)
Date: Mon, 10 Jun 2024 12:43:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
Message-ID: <20240610104352.GT8774@noisy.programming.kicks-ass.net>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608193504.429644-2-torvalds@linux-foundation.org>

On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:
> Needs more comments and testing, but it works, and has a generic
> fallback for architectures that don't support it.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> Notes from the first hack: I renamed the infrastructure from "static
> const" to "runtime const".  We end up having a number of uses of "static
> const" that are related to the C language notion of "static const"
> variables or functions, and "runtime constant" is a bit more descriptive
> anyway. 
> 
> And this now is properly abstracted out, so that any architecture can
> choose to implement their own version, but it all falls back on "just
> use the variable".
> 
> Josh - sorry for wasting your time on the objtool patch, I ended up
> using the linker functionality that Rasmus pointed out as existing
> instead. 
> 
> Rasmus - I've cleaned up my patch a lot, and it now compiles fine on
> other architectures too, although obviously with the fallback of "no
> constant fixup".  As a result, my patch is actually smaller and much
> cleaner, and I ended up liking my approach more than your RAI thing
> after all. 
> 
> Ingo / Peter / Borislav - I enabled this for 32-bit x86 too, because it
> was literally trivial (had to remove a "q" from "movq").  I did a
> test-build and it looks find, but I didn't actually try to boot it. 
> 
> The x86-64 code is actually tested.  It's not like it has a _lot_ of
> testing, but the patch ends up being pretty small in the end.  Yes, the
> "shift u32 value right by a constant" is a pretty special case, but the
> __d_lookup_rcu() function really is pretty hot.
> 
> Or rather it *was* pretty hot.  It's actually looking very good with
> this, imho. 
> 
> Build tested with allmodconfig and on arm64, but I'm not claiming that I
> have necessarily found all special case corners.  That said, it's small
> and pretty straightforward. 
> 
> Comments?

It obviously has the constraint of never running the code before the
corresponding runtime_const_init() has been done, otherwise things will
go sideways in a hurry, but this also makes the whole thing a *lot*
simpler.

The only thing I'm not sure about is it having a section per symbol,
given how jump_label and static_call took off, this might not be
scalable.

Yes, the approach is super simple and straight forward, but imagine
there being like a 100 symbols soon :/

The below hackery -- it very much needs cleanup and is only compiled on
x86_64 and does not support modules, boots for me.

---


Index: linux-2.6/arch/Kconfig
===================================================================
--- linux-2.6.orig/arch/Kconfig
+++ linux-2.6/arch/Kconfig
@@ -1492,6 +1492,9 @@ config HAVE_SPARSE_SYSCALL_NR
 config ARCH_HAS_VDSO_DATA
 	bool
 
+config HAVE_RUNTIME_CONST
+	bool
+
 config HAVE_STATIC_CALL
 	bool
 
Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -279,6 +279,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
+	select HAVE_RUNTIME_CONST
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
Index: linux-2.6/arch/x86/include/asm/runtime_const.h
===================================================================
--- /dev/null
+++ linux-2.6/arch/x86/include/asm/runtime_const.h
@@ -0,0 +1,62 @@
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#include <asm/asm.h>
+
+#define __runtime_const(sym, op, type)			\
+({							\
+	typeof(sym) __ret;				\
+	asm(op " %1, %0\n1:\n"				\
+	    ".pushsection __runtime_const, \"aw\"\n\t"	\
+	    ".long %c3 - .      # sym \n\t"		\
+	    ".long %c2          # size \n\t"		\
+	    ".long 1b - %c2 - . # addr \n\t"		\
+	    ".popsection\n\t"				\
+	    : "=r" (__ret)				\
+	    : "i" ((type)0x0123456789abcdefull),	\
+	      "i" (sizeof(type)),			\
+	      "i" ((void *)&sym));			\
+	__ret;						\
+})
+
+#define runtime_const(sym)						\
+({									\
+ 	typeof(sym) __ret;						\
+	switch(sizeof(sym)) {						\
+	case 1: __ret = __runtime_const(sym, "movb", u8); break;	\
+	case 2: __ret = __runtime_const(sym, "movs", u16); break;	\
+	case 4: __ret = __runtime_const(sym, "movl", u32); break;	\
+	case 8: __ret = __runtime_const(sym, "movq", u64); break;	\
+	default: BUG();							\
+	}								\
+	__ret;								\
+})
+
+#define runtime_const_shr32(val, sym)			\
+({							\
+	typeof(0u+val) __ret = (val);			\
+	asm("shrl $12, %k0\n1:\n"			\
+	    ".pushsection __runtime_const, \"aw\"\n\t"	\
+	    ".long %c3 - .      # sym \n\t"		\
+	    ".long %c2          # size \n\t"		\
+	    ".long 1b - %c2 - . # addr \n\t"		\
+	    ".popsection\n\t"				\
+	    : "+r" (__ret)				\
+	    : "i" ((u8)0x12), 				\
+	      "i" (sizeof(u8)),				\
+	      "i" ((void *)&sym));			\
+	__ret;						\
+})
+
+struct runtime_const_entry {
+	s32 sym;
+	u32 size;
+	s32 addr;
+};
+
+extern struct runtime_const_entry __start___runtime_const[];
+extern struct runtime_const_entry __stop___runtime_const[];
+
+extern void arch_runtime_const_set(struct runtime_const_entry *rc, u64 val);
+
+#endif /* _ASM_RUNTIME_CONST_H */
Index: linux-2.6/include/asm-generic/Kbuild
===================================================================
--- linux-2.6.orig/include/asm-generic/Kbuild
+++ linux-2.6/include/asm-generic/Kbuild
@@ -53,6 +53,7 @@ mandatory-y += shmparam.h
 mandatory-y += simd.h
 mandatory-y += softirq_stack.h
 mandatory-y += switch_to.h
+mandatory-y += runtime_const.h
 mandatory-y += timex.h
 mandatory-y += tlbflush.h
 mandatory-y += topology.h
Index: linux-2.6/include/asm-generic/runtime_const.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-generic/runtime_const.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#define runtime_const(sym) (sym)
+#define runtime_const_shr32(val, sym)	((u32)(val) >> (sym))
+
+#endif /* _ASM_RUNTIME_CONST_H */
Index: linux-2.6/include/asm-generic/vmlinux.lds.h
===================================================================
--- linux-2.6.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6/include/asm-generic/vmlinux.lds.h
@@ -423,6 +423,14 @@
 #define STATIC_CALL_DATA
 #endif
 
+#ifdef CONFIG_HAVE_RUNTIME_CONST
+#define RUNTIME_CONST_DATA						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_BY(__runtime_const, ___runtime_const)
+#else
+#define RUNTIME_CONST_DATA
+#endif
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -434,6 +442,7 @@
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
 	STATIC_CALL_DATA						\
+	RUNTIME_CONST_DATA						\
 	__end_ro_after_init = .;
 #endif
 
Index: linux-2.6/include/linux/runtime_const.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/runtime_const.h
@@ -0,0 +1,23 @@
+#ifndef _LINUX_RUNTIME_CONST_H
+#define _LINUX_RUNTIME_CONST_H
+
+#include "asm/runtime_const.h"
+
+#ifdef CONFIG_HAVE_RUNTIME_CONST
+
+extern void __runtime_const_set(void *sym, int size, u64 val);
+
+#define runtime_const_set(sym, val)			\
+	__runtime_const_set(&(sym), sizeof(val), val)
+
+extern void runtime_const_init(void);
+
+#else
+
+#define runtime_const_set(sym, val)	((sym) = (val))
+
+static inline void runtime_const_init(void) { }
+
+#endif
+
+#endif /* _LINUX_RUNTIME_CONST_H */
Index: linux-2.6/kernel/Makefile
===================================================================
--- linux-2.6.orig/kernel/Makefile
+++ linux-2.6/kernel/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
+obj-$(CONFIG_HAVE_RUNTIME_CONST) += runtime_const.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_NUMA) += numa.o
 
Index: linux-2.6/kernel/runtime_const.c
===================================================================
--- /dev/null
+++ linux-2.6/kernel/runtime_const.c
@@ -0,0 +1,119 @@
+
+#include <linux/sort.h>
+#include <linux/mutex.h>
+#include <linux/bsearch.h>
+#include <linux/bug.h>
+#include <linux/runtime_const.h>
+#include <asm/sections.h>
+#include <asm/text-patching.h>
+
+static bool runtime_const_initialized;
+
+static unsigned long runtime_const_sym(const struct runtime_const_entry *rc)
+{
+	return (unsigned long)&rc->sym + rc->sym;
+}
+
+static unsigned long runtime_const_addr(const struct runtime_const_entry *rc)
+{
+	return (unsigned long)&rc->addr + rc->addr;
+}
+
+static int runtime_const_cmp(const void *a, const void *b)
+{
+	const struct runtime_const_entry *rca = a;
+	const struct runtime_const_entry *rcb = b;
+
+	if (runtime_const_sym(rca) < runtime_const_sym(rcb))
+		return -1;
+
+	if (runtime_const_sym(rca) > runtime_const_sym(rcb))
+		return 1;
+
+	return 0;
+}
+
+static void runtime_const_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct runtime_const_entry *rca = a;
+	struct runtime_const_entry *rcb = b;
+	struct runtime_const_entry tmp = *rca;
+
+	rca->sym = rcb->sym - delta;
+	rca->size = rcb->size;
+	rca->addr = rcb->addr - delta;
+
+	rcb->sym = tmp.sym + delta;
+	rcb->size = tmp.size;
+	rcb->addr = tmp.addr + delta;
+}
+
+static DEFINE_MUTEX(runtime_const_lock);
+
+void __init runtime_const_init(void)
+{
+	struct runtime_const_entry *start = __start___runtime_const;
+	struct runtime_const_entry *stop  = __stop___runtime_const;
+	unsigned long num = ((unsigned long)stop - (unsigned long)start) / sizeof(*start);
+
+	if (runtime_const_initialized)
+		return;
+
+	mutex_lock(&runtime_const_lock);
+	sort(start, num, sizeof(*start), runtime_const_cmp, runtime_const_swap);
+	mutex_unlock(&runtime_const_lock);
+
+	runtime_const_initialized = true;
+}
+
+static struct runtime_const_entry *rc_find_sym(void *sym)
+{
+	struct runtime_const_entry *start = __start___runtime_const;
+	struct runtime_const_entry *stop  = __stop___runtime_const;
+	unsigned long num = ((unsigned long)stop - (unsigned long)start) / sizeof(*start);
+	struct runtime_const_entry k = {
+		.sym = (unsigned long)sym - (unsigned long)&k.sym,
+	};
+	struct runtime_const_entry *i =
+		bsearch(&k, start, num, sizeof(*start), runtime_const_cmp);
+	if (!i)
+		return i;
+	early_printk("XXX i: %ld s: %d\n", (i - start), i->size);
+	while (i > start) {
+		if (runtime_const_sym(i-1) == (unsigned long)sym)
+			i--;
+		else
+			break;
+	}
+		early_printk("XXY i: %ld\n", (i - start));
+	return i;
+}
+
+__weak void arch_runtime_const_set(struct runtime_const_entry *rc, u64 val)
+{
+	void *addr = (void *)runtime_const_addr(rc);
+	switch (rc->size) {
+	case 1: { *(u8 *)addr = val; break; }
+	case 2: { *(u16 *)addr = val; break; }
+	case 4: { *(u32 *)addr = val; break; }
+	case 8: { *(u64 *)addr = val; break; }
+	default: BUG();
+	}
+}
+
+void __runtime_const_set(void *sym, int size, u64 val)
+{
+	struct runtime_const_entry *i, *stop = __stop___runtime_const;
+
+	mutex_lock(&runtime_const_lock);
+	
+	for (i = rc_find_sym(sym);
+	     i && i < stop && runtime_const_sym(i) == (unsigned long)sym;
+	     i++) {
+		WARN_ONCE(i->size != size, "%d != %d\n", i->size, size);
+		arch_runtime_const_set(i, val);
+	}
+
+	mutex_unlock(&runtime_const_lock);
+}
Index: linux-2.6/arch/x86/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/setup.c
+++ linux-2.6/arch/x86/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
 #include <linux/random.h>
+#include <linux/runtime_const.h>
 
 #include <uapi/linux/mount.h>
 
@@ -782,6 +783,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	jump_label_init();
 	static_call_init();
+//	runtime_const_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -97,12 +97,14 @@ EXPORT_SYMBOL(dotdot_name);
  */
 
 static unsigned int d_hash_shift __ro_after_init;
-
 static struct hlist_bl_head *dentry_hashtable __ro_after_init;
 
+#include <linux/runtime_const.h>
+
 static inline struct hlist_bl_head *d_hash(unsigned int hash)
 {
-	return dentry_hashtable + (hash >> d_hash_shift);
+	return runtime_const(dentry_hashtable) +
+	       runtime_const_shr32(hash, d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -3129,6 +3131,11 @@ static void __init dcache_init_early(voi
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init();
+
+	runtime_const_set(dentry_hashtable, (unsigned long)dentry_hashtable);
+	runtime_const_set(d_hash_shift, (u8)d_hash_shift);
 }
 
 static void __init dcache_init(void)
@@ -3157,6 +3164,9 @@ static void __init dcache_init(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_set(dentry_hashtable, (unsigned long)dentry_hashtable);
+	runtime_const_set(d_hash_shift, (u8)d_hash_shift);
 }
 
 /* SLAB cache for __getname() consumers */

