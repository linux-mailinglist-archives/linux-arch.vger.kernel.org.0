Return-Path: <linux-arch+bounces-4757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37390135E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF0B2826D9
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE72134D1;
	Sat,  8 Jun 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="izEYON8i"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02528134B1;
	Sat,  8 Jun 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717875829; cv=none; b=FPyRkihIPidH6jSyTNt+2CJ/D02P9BFf06WnXsDnfa/iosmwD5TeBWqvaLRFrdtkzNpFWn6BwXwxJ7lv5KdygBDU+i8mSuQug/5PAt2aUa7+TcPRwdYZZcZq3hFE9MFgbVp5e1pjF+xCFbgHVUklceETF0VKnViZQOdwDNqnvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717875829; c=relaxed/simple;
	bh=ASFabXtRa1wFAO6TA1/5iLXPo5NYMXTtx1bqem/hIBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4itQ3OEmqfqkXAJyRHtzhGL7KH+dD3yorGtsYz58fnbkAPkoymmSKk8IZ6eJ3W6HQn43KXGrdeQPZkvVAzR5gCoGfq3dnNHROYOcXSL4WWwOB1jooOUjbMOf7L3mrkD5OvsQdnSAyVSjJhnxjcbccSBLHRwDMAvRPNZY1E/S00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=izEYON8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F61C2BD11;
	Sat,  8 Jun 2024 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717875828;
	bh=ASFabXtRa1wFAO6TA1/5iLXPo5NYMXTtx1bqem/hIBo=;
	h=From:To:Cc:Subject:Date:From;
	b=izEYON8irr9+sSFBaMZGvQzmPI7gOpxIrihxApW07s0vI2HhDUUE7icramuCaZoxQ
	 0BrKHNlLandyhpIcVekjg+rwF01WqCTXZRMHLO1hMM9Jq6sHdXN9ucC5rXuCFoP1IF
	 VxKvRRSGGhOcadqzzXeQgVepZU229xvse3W282/w=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86: add 'runtime constant' infrastructure
Date: Sat,  8 Jun 2024 12:35:05 -0700
Message-ID: <20240608193504.429644-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Needs more comments and testing, but it works, and has a generic
fallback for architectures that don't support it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Notes from the first hack: I renamed the infrastructure from "static
const" to "runtime const".  We end up having a number of uses of "static
const" that are related to the C language notion of "static const"
variables or functions, and "runtime constant" is a bit more descriptive
anyway. 

And this now is properly abstracted out, so that any architecture can
choose to implement their own version, but it all falls back on "just
use the variable".

Josh - sorry for wasting your time on the objtool patch, I ended up
using the linker functionality that Rasmus pointed out as existing
instead. 

Rasmus - I've cleaned up my patch a lot, and it now compiles fine on
other architectures too, although obviously with the fallback of "no
constant fixup".  As a result, my patch is actually smaller and much
cleaner, and I ended up liking my approach more than your RAI thing
after all. 

Ingo / Peter / Borislav - I enabled this for 32-bit x86 too, because it
was literally trivial (had to remove a "q" from "movq").  I did a
test-build and it looks find, but I didn't actually try to boot it. 

The x86-64 code is actually tested.  It's not like it has a _lot_ of
testing, but the patch ends up being pretty small in the end.  Yes, the
"shift u32 value right by a constant" is a pretty special case, but the
__d_lookup_rcu() function really is pretty hot.

Or rather it *was* pretty hot.  It's actually looking very good with
this, imho. 

Build tested with allmodconfig and on arm64, but I'm not claiming that I
have necessarily found all special case corners.  That said, it's small
and pretty straightforward. 

Comments?

 arch/x86/include/asm/runtime-const.h | 61 ++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |  3 ++
 fs/dcache.c                          | 24 +++++++----
 include/asm-generic/Kbuild           |  1 +
 include/asm-generic/runtime-const.h  | 15 +++++++
 include/asm-generic/vmlinux.lds.h    |  8 ++++
 6 files changed, 104 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/include/asm/runtime-const.h
 create mode 100644 include/asm-generic/runtime-const.h

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
new file mode 100644
index 000000000000..b4f7efc0a554
--- /dev/null
+++ b/arch/x86/include/asm/runtime-const.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+#define runtime_const_ptr(sym) ({				\
+	typeof(sym) __ret;					\
+	asm("mov %1,%0\n1:\n"					\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
+		".long 1b - %c2 - .\n\t"			\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"i" ((unsigned long)0x0123456789abcdefull),	\
+		 "i" (sizeof(long)));				\
+	__ret; })
+
+// The 'typeof' will create at _least_ a 32-bit type, but
+// will happily also take a bigger type and the 'shrl' will
+// clear the upper bits
+#define runtime_const_shift_right_32(val, sym) ({		\
+	typeof(0u+(val)) __ret = (val);				\
+	asm("shrl $12,%k0\n1:\n"				\
+		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
+		".long 1b - 1 - .\n\t"				\
+		".popsection"					\
+		:"+r" (__ret));					\
+	__ret; })
+
+#define runtime_const_init(type, sym, value) do {	\
+	extern s32 __start_runtime_##type##_##sym[];	\
+	extern s32 __stop_runtime_##type##_##sym[];	\
+	runtime_const_fixup(__runtime_fixup_##type,	\
+		(unsigned long)(value), 		\
+		__start_runtime_##type##_##sym,		\
+		__stop_runtime_##type##_##sym);		\
+} while (0)
+
+/*
+ * The text patching is trivial - you can only do this at init time,
+ * when the text section hasn't been marked RO, and before the text
+ * has ever been executed.
+ */
+static inline void __runtime_fixup_ptr(void *where, unsigned long val)
+{
+	*(unsigned long *)where = val;
+}
+
+static inline void __runtime_fixup_shift(void *where, unsigned long val)
+{
+	*(unsigned char *)where = val;
+}
+
+static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
+	unsigned long val, s32 *start, s32 *end)
+{
+	while (start < end) {
+		fn(*start + (void *)start, val);
+		start++;
+	}
+}
+
+#endif
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3509afc6a672..6e73403e874f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -357,6 +357,9 @@ SECTIONS
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
 #endif
 
+	RUNTIME_CONST(shift, d_hash_shift)
+	RUNTIME_CONST(ptr, dentry_hashtable)
+
 	. = ALIGN(PAGE_SIZE);
 
 	/* freed after init ends here */
diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..4511e557bf84 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -97,12 +97,14 @@ EXPORT_SYMBOL(dotdot_name);
  */
 
 static unsigned int d_hash_shift __ro_after_init;
-
 static struct hlist_bl_head *dentry_hashtable __ro_after_init;
 
-static inline struct hlist_bl_head *d_hash(unsigned int hash)
+#include <asm/runtime-const.h>
+
+static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-	return dentry_hashtable + (hash >> d_hash_shift);
+	return runtime_const_ptr(dentry_hashtable) +
+		runtime_const_shift_right_32(hashlen, d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -495,7 +497,7 @@ static void ___d_drop(struct dentry *dentry)
 	if (unlikely(IS_ROOT(dentry)))
 		b = &dentry->d_sb->s_roots;
 	else
-		b = d_hash(dentry->d_name.hash);
+		b = d_hash(dentry->d_name.hash_len);
 
 	hlist_bl_lock(b);
 	__hlist_bl_del(&dentry->d_hash);
@@ -2104,7 +2106,7 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 	unsigned *seqp)
 {
 	u64 hashlen = name->hash_len;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
@@ -2171,7 +2173,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 {
 	u64 hashlen = name->hash_len;
 	const unsigned char *str = name->name;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
@@ -2277,7 +2279,7 @@ EXPORT_SYMBOL(d_lookup);
 struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 {
 	unsigned int hash = name->hash;
-	struct hlist_bl_head *b = d_hash(hash);
+	struct hlist_bl_head *b = d_hash(name->hash_len);
 	struct hlist_bl_node *node;
 	struct dentry *found = NULL;
 	struct dentry *dentry;
@@ -2397,7 +2399,7 @@ EXPORT_SYMBOL(d_delete);
 
 static void __d_rehash(struct dentry *entry)
 {
-	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
+	struct hlist_bl_head *b = d_hash(entry->d_name.hash_len);
 
 	hlist_bl_lock(b);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
@@ -3129,6 +3131,9 @@ static void __init dcache_init_early(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable, dentry_hashtable);
 }
 
 static void __init dcache_init(void)
@@ -3157,6 +3162,9 @@ static void __init dcache_init(void)
 					0,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
+
+	runtime_const_init(shift, d_hash_shift, d_hash_shift);
+	runtime_const_init(ptr, dentry_hashtable, dentry_hashtable);
 }
 
 /* SLAB cache for __getname() consumers */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b20fa25a7e8d..052e5c98c105 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -46,6 +46,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += runtime-const.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
 mandatory-y += serial.h
diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
new file mode 100644
index 000000000000..b54824bd616e
--- /dev/null
+++ b/include/asm-generic/runtime-const.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RUNTIME_CONST_H
+#define _ASM_RUNTIME_CONST_H
+
+/*
+ * This is the fallback for when the architecture doesn't
+ * support the runtime const operations.
+ *
+ * We just use the actual symbols as-is.
+ */
+#define runtime_const_ptr(sym) (sym)
+#define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
+#define runtime_const_init(type,sym,value) do { } while (0)
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5703526d6ebf..389a78415b9b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -944,6 +944,14 @@
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
+#define RUNTIME_NAME(t,x) runtime_##t##_##x
+
+#define RUNTIME_CONST(t,x)						\
+	. = ALIGN(8);							\
+	RUNTIME_NAME(t,x) : AT(ADDR(RUNTIME_NAME(t,x)) - LOAD_OFFSET) {	\
+		*(RUNTIME_NAME(t,x));					\
+	}
+
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
 		. = ALIGN(8);						\
-- 
2.45.1.209.gc6f12300df


