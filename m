Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C633D78EC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhG0Ou5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 10:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236978AbhG0Otz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 10:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19DBB61B1F;
        Tue, 27 Jul 2021 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627397395;
        bh=aTWAf1eXMP7xx/2Vrh8rdB4xrBG9ZpKFtagjMdsIQEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUFQpckuGTHhewIwqM/QIkbcSTBbQ1Za6maEsVwJ2IGMyxntteeBuQ7iOqKNvoBhH
         WZu6veChWE0d9nSFeUEIpgKs2m7hdEwaSYk8QLfP7mG7/DWCKXDXczKGTl6OW4J9li
         OHOTjoipxfPICNAhVkn72J7Q74X9xNIXuhORAAJZ7B3uB0uCd17JzRT6erqZpbS+PR
         58/WeeoVkOPC6RJYueMHWWHzhGO1f9Qs2GHD3maRWPno6lvELWKoXLtfgXCdNkvFQI
         dhK3NMuKCMVrx25dg2oa2ud96yRq8XI7oJvU1yOCw/XzM6IhQn2z13/5LBa8vZxdwN
         WMWuo9XDXxhYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 6/6] arch: remove compat_alloc_user_space
Date:   Tue, 27 Jul 2021 16:48:59 +0200
Message-Id: <20210727144859.4150043-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210727144859.4150043-1-arnd@kernel.org>
References: <20210727144859.4150043-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All users of compat_alloc_user_space() and copy_in_user() have been
removed from the kernel, only a few functions in sparc remain that can
be changed to calling arch_copy_in_user() instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h         |  5 --
 arch/arm64/include/asm/uaccess.h        | 11 ----
 arch/arm64/lib/Makefile                 |  2 +-
 arch/arm64/lib/copy_in_user.S           | 77 -------------------------
 arch/mips/cavium-octeon/octeon-memcpy.S |  2 -
 arch/mips/include/asm/compat.h          |  8 ---
 arch/mips/include/asm/uaccess.h         | 26 ---------
 arch/mips/lib/memcpy.S                  | 11 ----
 arch/parisc/include/asm/compat.h        |  6 --
 arch/parisc/include/asm/uaccess.h       |  2 -
 arch/parisc/lib/memcpy.c                |  9 ---
 arch/powerpc/include/asm/compat.h       | 16 -----
 arch/s390/include/asm/compat.h          | 10 ----
 arch/s390/include/asm/uaccess.h         |  3 -
 arch/s390/lib/uaccess.c                 | 63 --------------------
 arch/sparc/include/asm/compat.h         | 19 ------
 arch/sparc/kernel/process_64.c          |  2 +-
 arch/sparc/kernel/signal32.c            | 12 ++--
 arch/sparc/kernel/signal_64.c           |  8 +--
 arch/x86/include/asm/compat.h           | 13 -----
 arch/x86/include/asm/uaccess_64.h       |  7 ---
 include/linux/compat.h                  |  2 -
 include/linux/uaccess.h                 | 10 ----
 kernel/compat.c                         | 21 -------
 24 files changed, 12 insertions(+), 333 deletions(-)
 delete mode 100644 arch/arm64/lib/copy_in_user.S

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 79c1a750e357..eaa6ca062d89 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -107,11 +107,6 @@ struct compat_statfs {
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
 #define COMPAT_MINSIGSTKSZ	2048
 
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	return (void __user *)compat_user_stack_pointer() - len;
-}
-
 struct compat_ipc64_perm {
 	compat_key_t key;
 	__compat_uid32_t uid;
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b5f08621fa29..190b494e22ab 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -430,17 +430,6 @@ extern unsigned long __must_check __arch_copy_to_user(void __user *to, const voi
 	__actu_ret;							\
 })
 
-extern unsigned long __must_check __arch_copy_in_user(void __user *to, const void __user *from, unsigned long n);
-#define raw_copy_in_user(to, from, n)					\
-({									\
-	unsigned long __aciu_ret;					\
-	uaccess_ttbr0_enable();						\
-	__aciu_ret = __arch_copy_in_user(__uaccess_mask_ptr(to),	\
-				    __uaccess_mask_ptr(from), (n));	\
-	uaccess_ttbr0_disable();					\
-	__aciu_ret;							\
-})
-
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 6dd56a49790a..0941180a86d3 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 lib-y		:= clear_user.o delay.o copy_from_user.o		\
-		   copy_to_user.o copy_in_user.o copy_page.o		\
+		   copy_to_user.o copy_page.o				\
 		   clear_page.o csum.o insn.o memchr.o memcpy.o		\
 		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
 		   strnlen.o strchr.o strrchr.o tishift.o
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
deleted file mode 100644
index dbea3799c3ef..000000000000
--- a/arch/arm64/lib/copy_in_user.S
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copy from user space to user space
- *
- * Copyright (C) 2012 ARM Ltd.
- */
-
-#include <linux/linkage.h>
-
-#include <asm/asm-uaccess.h>
-#include <asm/assembler.h>
-#include <asm/cache.h>
-
-/*
- * Copy from user space to user space (alignment handled by the hardware)
- *
- * Parameters:
- *	x0 - to
- *	x1 - from
- *	x2 - n
- * Returns:
- *	x0 - bytes not copied
- */
-	.macro ldrb1 reg, ptr, val
-	user_ldst 9998f, ldtrb, \reg, \ptr, \val
-	.endm
-
-	.macro strb1 reg, ptr, val
-	user_ldst 9998f, sttrb, \reg, \ptr, \val
-	.endm
-
-	.macro ldrh1 reg, ptr, val
-	user_ldst 9997f, ldtrh, \reg, \ptr, \val
-	.endm
-
-	.macro strh1 reg, ptr, val
-	user_ldst 9997f, sttrh, \reg, \ptr, \val
-	.endm
-
-	.macro ldr1 reg, ptr, val
-	user_ldst 9997f, ldtr, \reg, \ptr, \val
-	.endm
-
-	.macro str1 reg, ptr, val
-	user_ldst 9997f, sttr, \reg, \ptr, \val
-	.endm
-
-	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9997f, \reg1, \reg2, \ptr, \val
-	.endm
-
-	.macro stp1 reg1, reg2, ptr, val
-	user_stp 9997f, \reg1, \reg2, \ptr, \val
-	.endm
-
-end	.req	x5
-srcin	.req	x15
-SYM_FUNC_START(__arch_copy_in_user)
-	add	end, x0, x2
-	mov	srcin, x1
-#include "copy_template.S"
-	mov	x0, #0
-	ret
-SYM_FUNC_END(__arch_copy_in_user)
-EXPORT_SYMBOL(__arch_copy_in_user)
-
-	.section .fixup,"ax"
-	.align	2
-9997:	cmp	dst, dstin
-	b.ne	9998f
-	// Before being absolutely sure we couldn't copy anything, try harder
-USER(9998f, ldtrb tmp1w, [srcin])
-USER(9998f, sttrb tmp1w, [dst])
-	add	dst, dst, #1
-9998:	sub	x0, end, dst			// bytes not copied
-	ret
-	.previous
diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 600d018cf354..0a515cde1c18 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -154,8 +154,6 @@ FEXPORT(__raw_copy_from_user)
 EXPORT_SYMBOL(__raw_copy_from_user)
 FEXPORT(__raw_copy_to_user)
 EXPORT_SYMBOL(__raw_copy_to_user)
-FEXPORT(__raw_copy_in_user)
-EXPORT_SYMBOL(__raw_copy_in_user)
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 53f015a1b0a7..bbb3bc5a42fd 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -96,14 +96,6 @@ struct compat_statfs {
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	struct pt_regs *regs = (struct pt_regs *)
-		((unsigned long) current_thread_info() + THREAD_SIZE - 32) - 1;
-
-	return (void __user *) (regs->regs[29] - len);
-}
-
 struct compat_ipc64_perm {
 	compat_key_t key;
 	__compat_uid32_t uid;
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 783fecce65c8..f8f74f9f5883 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -428,7 +428,6 @@ do {									\
 
 extern size_t __raw_copy_from_user(void *__to, const void *__from, size_t __n);
 extern size_t __raw_copy_to_user(void *__to, const void *__from, size_t __n);
-extern size_t __raw_copy_in_user(void *__to, const void *__from, size_t __n);
 
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -480,31 +479,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-static inline unsigned long
-raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
-{
-	register void __user *__cu_to_r __asm__("$4");
-	register const void __user *__cu_from_r __asm__("$5");
-	register long __cu_len_r __asm__("$6");
-
-	__cu_to_r = to;
-	__cu_from_r = from;
-	__cu_len_r = n;
-
-	__asm__ __volatile__(
-		".set\tnoreorder\n\t"
-		__MODULE_JAL(__raw_copy_in_user)
-		".set\tnoat\n\t"
-		__UA_ADDU "\t$1, %1, %2\n\t"
-		".set\tat\n\t"
-		".set\treorder"
-		: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)
-		:
-		: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",
-		  DADDI_SCRATCH, "memory");
-	return __cu_len_r;
-}
-
 extern __kernel_size_t __bzero(void __user *addr, __kernel_size_t size);
 
 /*
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index e19fb98b5d38..277c32296636 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -666,8 +666,6 @@ FEXPORT(__raw_copy_from_user)
 EXPORT_SYMBOL(__raw_copy_from_user)
 FEXPORT(__raw_copy_to_user)
 EXPORT_SYMBOL(__raw_copy_to_user)
-FEXPORT(__raw_copy_in_user)
-EXPORT_SYMBOL(__raw_copy_in_user)
 #endif
 	/* Legacy Mode, user <-> user */
 	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP
@@ -703,13 +701,4 @@ EXPORT_SYMBOL(__raw_copy_to_user)
 __BUILD_COPY_USER EVA_MODE KERNELOP USEROP
 END(__raw_copy_to_user)
 
-/*
- * __copy_in_user (EVA)
- */
-
-LEAF(__raw_copy_in_user)
-EXPORT_SYMBOL(__raw_copy_in_user)
-__BUILD_COPY_USER EVA_MODE USEROP USEROP
-END(__raw_copy_in_user)
-
 #endif
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index b5d90e82b65d..c04f5a637c39 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -163,12 +163,6 @@ struct compat_shmid64_ds {
 #define COMPAT_ELF_NGREG 80
 typedef compat_ulong_t compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
-static __inline__ void __user *arch_compat_alloc_user_space(long len)
-{
-	struct pt_regs *regs = &current->thread.regs;
-	return (void __user *)regs->gr[30];
-}
-
 static inline int __is_compat_task(struct task_struct *t)
 {
 	return test_tsk_thread_flag(t, TIF_32BIT);
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index ed2cd4fb479b..7c13314aae4a 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -215,8 +215,6 @@ unsigned long __must_check raw_copy_to_user(void __user *dst, const void *src,
 					    unsigned long len);
 unsigned long __must_check raw_copy_from_user(void *dst, const void __user *src,
 					    unsigned long len);
-unsigned long __must_check raw_copy_in_user(void __user *dst, const void __user *src,
-					    unsigned long len);
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 4b75388190b4..ea70a0e08321 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -38,14 +38,6 @@ unsigned long raw_copy_from_user(void *dst, const void __user *src,
 }
 EXPORT_SYMBOL(raw_copy_from_user);
 
-unsigned long raw_copy_in_user(void __user *dst, const void __user *src, unsigned long len)
-{
-	mtsp(get_user_space(), 1);
-	mtsp(get_user_space(), 2);
-	return pa_memcpy((void __force *)dst, (void __force *)src, len);
-}
-
-
 void * memcpy(void * dst,const void *src, size_t count)
 {
 	mtsp(get_kernel_space(), 1);
@@ -54,7 +46,6 @@ void * memcpy(void * dst,const void *src, size_t count)
 	return dst;
 }
 
-EXPORT_SYMBOL(raw_copy_in_user);
 EXPORT_SYMBOL(memcpy);
 
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index e33dcf134cdd..7afc96fb6524 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -83,22 +83,6 @@ struct compat_statfs {
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	struct pt_regs *regs = current->thread.regs;
-	unsigned long usp = regs->gpr[1];
-
-	/*
-	 * We can't access below the stack pointer in the 32bit ABI and
-	 * can access 288 bytes in the 64bit big-endian ABI,
-	 * or 512 bytes with the new ELFv2 little-endian ABI.
-	 */
-	if (!is_32bit_task())
-		usp -= USER_REDZONE_SIZE;
-
-	return (void __user *) (usp - len);
-}
-
 /*
  * ipc64_perm is actually 32/64bit clean but since the compat layer refers to
  * it we may as well define it.
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 8d49505b4a43..cdc7ae72529d 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -176,16 +176,6 @@ static inline int is_compat_task(void)
 	return test_thread_flag(TIF_31BIT);
 }
 
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	unsigned long stack;
-
-	stack = KSTK_ESP(current);
-	if (is_compat_task())
-		stack &= 0x7fffffffUL;
-	return (void __user *) (stack - len);
-}
-
 #endif
 
 struct compat_ipc64_perm {
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 2316f2440881..98a1fce2ce67 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -227,9 +227,6 @@ static inline int __get_user_fn(void *x, const void __user *ptr, unsigned long s
 	__get_user(x, ptr);					\
 })
 
-unsigned long __must_check
-raw_copy_in_user(void __user *to, const void __user *from, unsigned long n);
-
 /*
  * Copy a null terminated string from userspace.
  */
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index 7ec8b1fa0f08..0df833cedd2c 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -204,69 +204,6 @@ unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long
 }
 EXPORT_SYMBOL(raw_copy_to_user);
 
-static inline unsigned long copy_in_user_mvcos(void __user *to, const void __user *from,
-					       unsigned long size)
-{
-	unsigned long tmp1, tmp2;
-
-	tmp1 = -4096UL;
-	/* FIXME: copy with reduced length. */
-	asm volatile(
-		"   lgr	  0,%[spec]\n"
-		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
-		"   jz	  2f\n"
-		"1: algr  %0,%3\n"
-		"   slgr  %1,%3\n"
-		"   slgr  %2,%3\n"
-		"   j	  0b\n"
-		"2:slgr  %0,%0\n"
-		"3: \n"
-		EX_TABLE(0b,3b)
-		: "+a" (size), "+a" (to), "+a" (from), "+a" (tmp1), "=a" (tmp2)
-		: [spec] "d" (0x810081UL)
-		: "cc", "memory", "0");
-	return size;
-}
-
-static inline unsigned long copy_in_user_mvc(void __user *to, const void __user *from,
-					     unsigned long size)
-{
-	unsigned long tmp1;
-
-	asm volatile(
-		"   sacf  256\n"
-		"   aghi  %0,-1\n"
-		"   jo	  5f\n"
-		"   bras  %3,3f\n"
-		"0: aghi  %0,257\n"
-		"1: mvc	  0(1,%1),0(%2)\n"
-		"   la	  %1,1(%1)\n"
-		"   la	  %2,1(%2)\n"
-		"   aghi  %0,-1\n"
-		"   jnz	  1b\n"
-		"   j	  5f\n"
-		"2: mvc	  0(256,%1),0(%2)\n"
-		"   la	  %1,256(%1)\n"
-		"   la	  %2,256(%2)\n"
-		"3: aghi  %0,-256\n"
-		"   jnm	  2b\n"
-		"4: ex	  %0,1b-0b(%3)\n"
-		"5: slgr  %0,%0\n"
-		"6: sacf  768\n"
-		EX_TABLE(1b,6b) EX_TABLE(2b,0b) EX_TABLE(4b,0b)
-		: "+a" (size), "+a" (to), "+a" (from), "=a" (tmp1)
-		: : "cc", "memory");
-	return size;
-}
-
-unsigned long raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
-{
-	if (copy_with_mvcos())
-		return copy_in_user_mvcos(to, from, n);
-	return copy_in_user_mvc(to, from, n);
-}
-EXPORT_SYMBOL(raw_copy_in_user);
-
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
 	unsigned long tmp1, tmp2;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 8b63410e830f..bd949fcf9d63 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -116,25 +116,6 @@ struct compat_statfs {
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 
-#ifdef CONFIG_COMPAT
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	struct pt_regs *regs = current_thread_info()->kregs;
-	unsigned long usp = regs->u_regs[UREG_I6];
-
-	if (test_thread_64bit_stack(usp))
-		usp += STACK_BIAS;
-
-	if (test_thread_flag(TIF_32BIT))
-		usp &= 0xffffffffUL;
-
-	usp -= len;
-	usp &= ~0x7UL;
-
-	return (void __user *) usp;
-}
-#endif
-
 struct compat_ipc64_perm {
 	compat_key_t key;
 	__compat_uid32_t uid;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d33c58a58d4f..4f5967ebf4e5 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -458,7 +458,7 @@ static unsigned long clone_stackframe(unsigned long csp, unsigned long psp)
 
 	distance = fp - psp;
 	rval = (csp - distance);
-	if (copy_in_user((void __user *) rval, (void __user *) psp, distance))
+	if (raw_copy_in_user((void __user *)rval, (void __user *)psp, distance))
 		rval = 0;
 	else if (!stack_64bit) {
 		if (put_user(((u32)csp),
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e9695a06492f..afd8455ea05f 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -435,9 +435,9 @@ static int setup_frame32(struct ksignal *ksig, struct pt_regs *regs,
 			      (_COMPAT_NSIG_WORDS - 1) * sizeof(unsigned int));
 
 	if (!wsaved) {
-		err |= copy_in_user((u32 __user *)sf,
-				    (u32 __user *)(regs->u_regs[UREG_FP]),
-				    sizeof(struct reg_window32));
+		err |= raw_copy_in_user((u32 __user *)sf,
+					(u32 __user *)(regs->u_regs[UREG_FP]),
+					sizeof(struct reg_window32));
 	} else {
 		struct reg_window *rp;
 
@@ -567,9 +567,9 @@ static int setup_rt_frame32(struct ksignal *ksig, struct pt_regs *regs,
 	err |= put_compat_sigset(&sf->mask, oldset, sizeof(compat_sigset_t));
 
 	if (!wsaved) {
-		err |= copy_in_user((u32 __user *)sf,
-				    (u32 __user *)(regs->u_regs[UREG_FP]),
-				    sizeof(struct reg_window32));
+		err |= raw_copy_in_user((u32 __user *)sf,
+					(u32 __user *)(regs->u_regs[UREG_FP]),
+					sizeof(struct reg_window32));
 	} else {
 		struct reg_window *rp;
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index a0eec62c825d..3bc4a25f7c25 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -406,10 +406,10 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	err |= copy_to_user(&sf->mask, sigmask_to_save(), sizeof(sigset_t));
 
 	if (!wsaved) {
-		err |= copy_in_user((u64 __user *)sf,
-				    (u64 __user *)(regs->u_regs[UREG_FP] +
-						   STACK_BIAS),
-				    sizeof(struct reg_window));
+		err |= raw_copy_in_user((u64 __user *)sf,
+					(u64 __user *)(regs->u_regs[UREG_FP] +
+					   STACK_BIAS),
+					sizeof(struct reg_window));
 	} else {
 		struct reg_window *rp;
 
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 4ae01cdb99de..7516e4199b3c 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -156,19 +156,6 @@ struct compat_shmid64_ds {
 	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
 #endif
 
-static inline void __user *arch_compat_alloc_user_space(long len)
-{
-	compat_uptr_t sp = task_pt_regs(current)->sp;
-
-	/*
-	 * -128 for the x32 ABI redzone.  For IA32, it is not strictly
-	 * necessary, but not harmful.
-	 */
-	sp -= 128;
-
-	return (void __user *)round_down(sp - len, 16);
-}
-
 static inline bool in_x32_syscall(void)
 {
 #ifdef CONFIG_X86_X32_ABI
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index e7265a552f4f..45697e04d771 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -58,13 +58,6 @@ raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 	return copy_user_generic((__force void *)dst, src, size);
 }
 
-static __always_inline __must_check
-unsigned long raw_copy_in_user(void __user *dst, const void __user *src, unsigned long size)
-{
-	return copy_user_generic((__force void *)dst,
-				 (__force void *)src, size);
-}
-
 extern long __copy_user_nocache(void *dst, const void __user *src,
 				unsigned size, int zerorest);
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 2d42cebd1fb8..1c758b0e0359 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -511,8 +511,6 @@ extern long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 struct epoll_event;	/* fortunately, this one is fixed-layout */
 
-extern void __user *compat_alloc_user_space(unsigned long len);
-
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 #define unsafe_compat_save_altstack(uss, sp, label) do { \
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index c05e903cef02..ac0394087f7d 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -200,16 +200,6 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 		n = _copy_to_user(to, from, n);
 	return n;
 }
-#ifdef CONFIG_COMPAT
-static __always_inline unsigned long __must_check
-copy_in_user(void __user *to, const void __user *from, unsigned long n)
-{
-	might_fault();
-	if (access_ok(to, n) && access_ok(from, n))
-		n = raw_copy_in_user(to, from, n);
-	return n;
-}
-#endif
 
 #ifndef copy_mc_to_kernel
 /*
diff --git a/kernel/compat.c b/kernel/compat.c
index 05adfd6fa8bf..55551989d9da 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -269,24 +269,3 @@ get_compat_sigset(sigset_t *set, const compat_sigset_t __user *compat)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(get_compat_sigset);
-
-/*
- * Allocate user-space memory for the duration of a single system call,
- * in order to marshall parameters inside a compat thunk.
- */
-void __user *compat_alloc_user_space(unsigned long len)
-{
-	void __user *ptr;
-
-	/* If len would occupy more than half of the entire compat space... */
-	if (unlikely(len > (((compat_uptr_t)~0) >> 1)))
-		return NULL;
-
-	ptr = arch_compat_alloc_user_space(len);
-
-	if (unlikely(!access_ok(ptr, len)))
-		return NULL;
-
-	return ptr;
-}
-EXPORT_SYMBOL_GPL(compat_alloc_user_space);
-- 
2.29.2

