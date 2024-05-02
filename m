Return-Path: <linux-arch+bounces-4145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6B8BA1CC
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D5B21F65
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB8181304;
	Thu,  2 May 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jjZmo+ud"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EA1E86E;
	Thu,  2 May 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683693; cv=none; b=MxE6ll2VwjRLsLCWMdR/idlT4yzK3FWNdiX9ohTl1bN7n6elEUqJlOSNgG7LIQhDOwhVu8iGNHtxdOtunH8rbhTrfFRQU+Q6nAlRg3+X0u99Av3KAwGGg7HXRRB0PNsb9fEJ17HUY9t3r3J0XmZXTrfmJD+njCBnHlFiF8YPEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683693; c=relaxed/simple;
	bh=DR3v+TCvUQP4e/ehxPG1TPShLSicc1MnBYRHVivADlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJgV6ykfcRSpUbIDzE2/c7UMGFjMBg0Eth1I5wUHfdB/0GhsJEsrfUuUNRaz9PhYW5M5W6rgFS2RKdVInuro+CGjkZjzx0NRVHsgF7dygFIXeKEpeqrsICBfD1mEFwSsJBIMl9zos6/vbYNoQZx+lZBXpcV4haP1hXnwHrM9JR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jjZmo+ud; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Tj6ZIpwTpxFP5n0tD6RjyI7GGUAgGJQ848QLqTpZPQ=; b=jjZmo+udMjYSMMPEgqX5kknDfa
	47sYQJmK8Soh7uEI7euzVF9SYAXxb0YHU4eiIKg9o0QjRYqPDRqHcr6ju1DM9moTUuhZCosfh6UHk
	MjYNEOLRqMTtJ4P5HqkduSuR8gesiBoFKROMPC3su97+l9zfOXrAwvxHWJYvEt4g6Wx02MoL8xtt5
	003kDCAKxI7fPI9OThaWKodHDeEwtQXRT3WA5ILtariaDXvyQ4gViJ2azsIN2kQjtRZW588MEBdQs
	ev8B0m08KwgqUquaasV+V2ftL3guQwSxHHfPhQvH2Cl5Ny0UZK6vPhMYvp9wt8Cdpa2Gqa0aob67/
	8iXDfGaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2dYQ-009kWR-2y;
	Thu, 02 May 2024 21:01:23 +0000
Date: Thu, 2 May 2024 22:01:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org,
	linux-alpha@vger.kernel.org
Subject: alpha cmpxchg.h (was Re: [PATCH v2 cmpxchg 12/13] sh: Emulate
 one-byte cmpxchg)
Message-ID: <20240502210122.GA2322432@ZenIV>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502205345.GK2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 09:53:45PM +0100, Al Viro wrote:
> What's more, load-locked/store-conditional doesn't have 16bit and 8bit
> variants on any Alphas - it's always 32bit (ldl_l) or 64bit (ldq_l).
> 
> What BWX adds is load/store byte/word, load/store byte/word unaligned
> and sign-extend byte/word.  IOW, it's absolutely irrelevant for
> cmpxchg (or xchg) purposes.

FWIW, I do have a cmpxchg-related patch for alpha - the mess with xchg.h
(parametrized double include) is no longer needed, and hadn't been since
2018 (fbfcd0199170 "locking/xchg/alpha: Remove superfluous memory barriers
from the _local() variants" was the point when the things settled down).
Only tangentially related to your stuff, but it makes the damn thing
easier to follow.


commit e992b5436ccd504b07a390118cf2be686355b957
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Apr 8 17:43:37 2024 -0400

    alpha: no need to include asm/xchg.h twice
    
    We used to generate different helpers for local and full
    {cmp,}xchg(); these days the barriers are in arch_{cmp,}xchg()
    instead and generated helpers are identical for local and
    full cases.  No need for those parametrized includes of
    asm/xchg.h - we might as well insert its contents directly
    in asm/cmpxchg.h and do it only once.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 91d4a4d9258c..ae1b96479d0c 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -3,17 +3,232 @@
 #define _ALPHA_CMPXCHG_H
 
 /*
- * Atomic exchange routines.
+ * Atomic exchange.
+ * Since it can be used to implement critical sections
+ * it must clobber "memory" (also for interrupts in UP).
  */
 
-#define ____xchg(type, args...)		__arch_xchg ## type ## _local(args)
-#define ____cmpxchg(type, args...)	__cmpxchg ## type ## _local(args)
-#include <asm/xchg.h>
+static inline unsigned long
+____xchg_u8(volatile char *m, unsigned long val)
+{
+	unsigned long ret, tmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%4,7,%3\n"
+	"	insbl	%1,%4,%1\n"
+	"1:	ldq_l	%2,0(%3)\n"
+	"	extbl	%2,%4,%0\n"
+	"	mskbl	%2,%4,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%3)\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
+	: "r" ((long)m), "1" (val) : "memory");
+
+	return ret;
+}
+
+static inline unsigned long
+____xchg_u16(volatile short *m, unsigned long val)
+{
+	unsigned long ret, tmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%4,7,%3\n"
+	"	inswl	%1,%4,%1\n"
+	"1:	ldq_l	%2,0(%3)\n"
+	"	extwl	%2,%4,%0\n"
+	"	mskwl	%2,%4,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%3)\n"
+	"	beq	%2,2f\n"
+	".subsection 2\n"
+	"2:	br	1b\n"
+	".previous"
+	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
+	: "r" ((long)m), "1" (val) : "memory");
+
+	return ret;
+}
+
+static inline unsigned long
+____xchg_u32(volatile int *m, unsigned long val)
+{
+	unsigned long dummy;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%4\n"
+	"	bis $31,%3,%1\n"
+	"	stl_c %1,%2\n"
+	"	beq %1,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	: "=&r" (val), "=&r" (dummy), "=m" (*m)
+	: "rI" (val), "m" (*m) : "memory");
+
+	return val;
+}
+
+static inline unsigned long
+____xchg_u64(volatile long *m, unsigned long val)
+{
+	unsigned long dummy;
+
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%4\n"
+	"	bis $31,%3,%1\n"
+	"	stq_c %1,%2\n"
+	"	beq %1,2f\n"
+	".subsection 2\n"
+	"2:	br 1b\n"
+	".previous"
+	: "=&r" (val), "=&r" (dummy), "=m" (*m)
+	: "rI" (val), "m" (*m) : "memory");
+
+	return val;
+}
+
+/* This function doesn't exist, so you'll get a linker error
+   if something tries to do an invalid xchg().  */
+extern void __xchg_called_with_bad_pointer(void);
+
+static __always_inline unsigned long
+____xchg(volatile void *ptr, unsigned long x, int size)
+{
+	return
+		size == 1 ? ____xchg_u8(ptr, x) :
+		size == 2 ? ____xchg_u16(ptr, x) :
+		size == 4 ? ____xchg_u32(ptr, x) :
+		size == 8 ? ____xchg_u64(ptr, x) :
+			(__xchg_called_with_bad_pointer(), x);
+}
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+static inline unsigned long
+____cmpxchg_u8(volatile char *m, unsigned char old, unsigned char new)
+{
+	unsigned long prev, tmp, cmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%5,7,%4\n"
+	"	insbl	%1,%5,%1\n"
+	"1:	ldq_l	%2,0(%4)\n"
+	"	extbl	%2,%5,%0\n"
+	"	cmpeq	%0,%6,%3\n"
+	"	beq	%3,2f\n"
+	"	mskbl	%2,%5,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%4)\n"
+	"	beq	%2,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br	1b\n"
+	".previous"
+	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
+	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+____cmpxchg_u16(volatile short *m, unsigned short old, unsigned short new)
+{
+	unsigned long prev, tmp, cmp, addr64;
+
+	__asm__ __volatile__(
+	"	andnot	%5,7,%4\n"
+	"	inswl	%1,%5,%1\n"
+	"1:	ldq_l	%2,0(%4)\n"
+	"	extwl	%2,%5,%0\n"
+	"	cmpeq	%0,%6,%3\n"
+	"	beq	%3,2f\n"
+	"	mskwl	%2,%5,%2\n"
+	"	or	%1,%2,%2\n"
+	"	stq_c	%2,0(%4)\n"
+	"	beq	%2,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br	1b\n"
+	".previous"
+	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
+	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+____cmpxchg_u32(volatile int *m, int old, int new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%5\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stl_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+
+	return prev;
+}
+
+static inline unsigned long
+____cmpxchg_u64(volatile long *m, unsigned long old, unsigned long new)
+{
+	unsigned long prev, cmp;
+
+	__asm__ __volatile__(
+	"1:	ldq_l %0,%5\n"
+	"	cmpeq %0,%3,%1\n"
+	"	beq %1,2f\n"
+	"	mov %4,%1\n"
+	"	stq_c %1,%2\n"
+	"	beq %1,3f\n"
+	"2:\n"
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
+	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+
+	return prev;
+}
+
+/* This function doesn't exist, so you'll get a linker error
+   if something tries to do an invalid cmpxchg().  */
+extern void __cmpxchg_called_with_bad_pointer(void);
+
+static __always_inline unsigned long
+____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
+	      int size)
+{
+	return
+		size == 1 ? ____cmpxchg_u8(ptr, old, new) :
+		size == 2 ? ____cmpxchg_u16(ptr, old, new) :
+		size == 4 ? ____cmpxchg_u32(ptr, old, new) :
+		size == 8 ? ____cmpxchg_u64(ptr, old, new) :
+			(__cmpxchg_called_with_bad_pointer(), old);
+}
 
 #define xchg_local(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __arch_xchg_local((ptr), (unsigned long)_x_,\
+	(__typeof__(*(ptr))) ____xchg((ptr), (unsigned long)_x_,	\
 					       sizeof(*(ptr)));		\
 })
 
@@ -21,7 +236,7 @@
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_,	\
+	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
 					  (unsigned long)_n_,		\
 					  sizeof(*(ptr)));		\
 })
@@ -32,12 +247,6 @@
 	cmpxchg_local((ptr), (o), (n));					\
 })
 
-#undef ____xchg
-#undef ____cmpxchg
-#define ____xchg(type, args...)		__arch_xchg ##type(args)
-#define ____cmpxchg(type, args...)	__cmpxchg ##type(args)
-#include <asm/xchg.h>
-
 /*
  * The leading and the trailing memory barriers guarantee that these
  * operations are fully ordered.
@@ -48,7 +257,7 @@
 	__typeof__(*(ptr)) _x_ = (x);					\
 	smp_mb();							\
 	__ret = (__typeof__(*(ptr)))					\
-		__arch_xchg((ptr), (unsigned long)_x_, sizeof(*(ptr)));	\
+		____xchg((ptr), (unsigned long)_x_, sizeof(*(ptr)));	\
 	smp_mb();							\
 	__ret;								\
 })
@@ -59,7 +268,7 @@
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
 	smp_mb();							\
-	__ret = (__typeof__(*(ptr))) __cmpxchg((ptr),			\
+	__ret = (__typeof__(*(ptr))) ____cmpxchg((ptr),			\
 		(unsigned long)_o_, (unsigned long)_n_, sizeof(*(ptr)));\
 	smp_mb();							\
 	__ret;								\
@@ -71,6 +280,4 @@
 	arch_cmpxchg((ptr), (o), (n));					\
 })
 
-#undef ____cmpxchg
-
 #endif /* _ALPHA_CMPXCHG_H */
diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
deleted file mode 100644
index 7adb80c6746a..000000000000
--- a/arch/alpha/include/asm/xchg.h
+++ /dev/null
@@ -1,246 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ALPHA_CMPXCHG_H
-#error Do not include xchg.h directly!
-#else
-/*
- * xchg/xchg_local and cmpxchg/cmpxchg_local share the same code
- * except that local version do not have the expensive memory barrier.
- * So this file is included twice from asm/cmpxchg.h.
- */
-
-/*
- * Atomic exchange.
- * Since it can be used to implement critical sections
- * it must clobber "memory" (also for interrupts in UP).
- */
-
-static inline unsigned long
-____xchg(_u8, volatile char *m, unsigned long val)
-{
-	unsigned long ret, tmp, addr64;
-
-	__asm__ __volatile__(
-	"	andnot	%4,7,%3\n"
-	"	insbl	%1,%4,%1\n"
-	"1:	ldq_l	%2,0(%3)\n"
-	"	extbl	%2,%4,%0\n"
-	"	mskbl	%2,%4,%2\n"
-	"	or	%1,%2,%2\n"
-	"	stq_c	%2,0(%3)\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
-	: "r" ((long)m), "1" (val) : "memory");
-
-	return ret;
-}
-
-static inline unsigned long
-____xchg(_u16, volatile short *m, unsigned long val)
-{
-	unsigned long ret, tmp, addr64;
-
-	__asm__ __volatile__(
-	"	andnot	%4,7,%3\n"
-	"	inswl	%1,%4,%1\n"
-	"1:	ldq_l	%2,0(%3)\n"
-	"	extwl	%2,%4,%0\n"
-	"	mskwl	%2,%4,%2\n"
-	"	or	%1,%2,%2\n"
-	"	stq_c	%2,0(%3)\n"
-	"	beq	%2,2f\n"
-	".subsection 2\n"
-	"2:	br	1b\n"
-	".previous"
-	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
-	: "r" ((long)m), "1" (val) : "memory");
-
-	return ret;
-}
-
-static inline unsigned long
-____xchg(_u32, volatile int *m, unsigned long val)
-{
-	unsigned long dummy;
-
-	__asm__ __volatile__(
-	"1:	ldl_l %0,%4\n"
-	"	bis $31,%3,%1\n"
-	"	stl_c %1,%2\n"
-	"	beq %1,2f\n"
-	".subsection 2\n"
-	"2:	br 1b\n"
-	".previous"
-	: "=&r" (val), "=&r" (dummy), "=m" (*m)
-	: "rI" (val), "m" (*m) : "memory");
-
-	return val;
-}
-
-static inline unsigned long
-____xchg(_u64, volatile long *m, unsigned long val)
-{
-	unsigned long dummy;
-
-	__asm__ __volatile__(
-	"1:	ldq_l %0,%4\n"
-	"	bis $31,%3,%1\n"
-	"	stq_c %1,%2\n"
-	"	beq %1,2f\n"
-	".subsection 2\n"
-	"2:	br 1b\n"
-	".previous"
-	: "=&r" (val), "=&r" (dummy), "=m" (*m)
-	: "rI" (val), "m" (*m) : "memory");
-
-	return val;
-}
-
-/* This function doesn't exist, so you'll get a linker error
-   if something tries to do an invalid xchg().  */
-extern void __xchg_called_with_bad_pointer(void);
-
-static __always_inline unsigned long
-____xchg(, volatile void *ptr, unsigned long x, int size)
-{
-	switch (size) {
-		case 1:
-			return ____xchg(_u8, ptr, x);
-		case 2:
-			return ____xchg(_u16, ptr, x);
-		case 4:
-			return ____xchg(_u32, ptr, x);
-		case 8:
-			return ____xchg(_u64, ptr, x);
-	}
-	__xchg_called_with_bad_pointer();
-	return x;
-}
-
-/*
- * Atomic compare and exchange.  Compare OLD with MEM, if identical,
- * store NEW in MEM.  Return the initial value in MEM.  Success is
- * indicated by comparing RETURN with OLD.
- */
-
-static inline unsigned long
-____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
-{
-	unsigned long prev, tmp, cmp, addr64;
-
-	__asm__ __volatile__(
-	"	andnot	%5,7,%4\n"
-	"	insbl	%1,%5,%1\n"
-	"1:	ldq_l	%2,0(%4)\n"
-	"	extbl	%2,%5,%0\n"
-	"	cmpeq	%0,%6,%3\n"
-	"	beq	%3,2f\n"
-	"	mskbl	%2,%5,%2\n"
-	"	or	%1,%2,%2\n"
-	"	stq_c	%2,0(%4)\n"
-	"	beq	%2,3f\n"
-	"2:\n"
-	".subsection 2\n"
-	"3:	br	1b\n"
-	".previous"
-	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
-	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
-
-	return prev;
-}
-
-static inline unsigned long
-____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
-{
-	unsigned long prev, tmp, cmp, addr64;
-
-	__asm__ __volatile__(
-	"	andnot	%5,7,%4\n"
-	"	inswl	%1,%5,%1\n"
-	"1:	ldq_l	%2,0(%4)\n"
-	"	extwl	%2,%5,%0\n"
-	"	cmpeq	%0,%6,%3\n"
-	"	beq	%3,2f\n"
-	"	mskwl	%2,%5,%2\n"
-	"	or	%1,%2,%2\n"
-	"	stq_c	%2,0(%4)\n"
-	"	beq	%2,3f\n"
-	"2:\n"
-	".subsection 2\n"
-	"3:	br	1b\n"
-	".previous"
-	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
-	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
-
-	return prev;
-}
-
-static inline unsigned long
-____cmpxchg(_u32, volatile int *m, int old, int new)
-{
-	unsigned long prev, cmp;
-
-	__asm__ __volatile__(
-	"1:	ldl_l %0,%5\n"
-	"	cmpeq %0,%3,%1\n"
-	"	beq %1,2f\n"
-	"	mov %4,%1\n"
-	"	stl_c %1,%2\n"
-	"	beq %1,3f\n"
-	"2:\n"
-	".subsection 2\n"
-	"3:	br 1b\n"
-	".previous"
-	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m) : "memory");
-
-	return prev;
-}
-
-static inline unsigned long
-____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
-{
-	unsigned long prev, cmp;
-
-	__asm__ __volatile__(
-	"1:	ldq_l %0,%5\n"
-	"	cmpeq %0,%3,%1\n"
-	"	beq %1,2f\n"
-	"	mov %4,%1\n"
-	"	stq_c %1,%2\n"
-	"	beq %1,3f\n"
-	"2:\n"
-	".subsection 2\n"
-	"3:	br 1b\n"
-	".previous"
-	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
-	: "r"((long) old), "r"(new), "m"(*m) : "memory");
-
-	return prev;
-}
-
-/* This function doesn't exist, so you'll get a linker error
-   if something tries to do an invalid cmpxchg().  */
-extern void __cmpxchg_called_with_bad_pointer(void);
-
-static __always_inline unsigned long
-____cmpxchg(, volatile void *ptr, unsigned long old, unsigned long new,
-	      int size)
-{
-	switch (size) {
-		case 1:
-			return ____cmpxchg(_u8, ptr, old, new);
-		case 2:
-			return ____cmpxchg(_u16, ptr, old, new);
-		case 4:
-			return ____cmpxchg(_u32, ptr, old, new);
-		case 8:
-			return ____cmpxchg(_u64, ptr, old, new);
-	}
-	__cmpxchg_called_with_bad_pointer();
-	return old;
-}
-
-#endif

