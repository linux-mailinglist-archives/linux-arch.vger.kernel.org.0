Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33E2289D4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgGUU0N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUUZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B2C0619DF;
        Tue, 21 Jul 2020 13:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxypj-00HPpb-3j; Tue, 21 Jul 2020 20:25:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 14/18] mips: propagate the calling convention change down into __csum_partial_copy_..._user()
Date:   Tue, 21 Jul 2020 21:25:45 +0100
Message-Id: <20200721202549.4150745-14-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

and turn the exception handlers into simply returning 0, which
simplifies the hell out of things in csum_partial.S

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/checksum.h |  26 +---
 arch/mips/lib/csum_partial.S     | 258 +++++++++++++--------------------------
 2 files changed, 89 insertions(+), 195 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index bf02d2d3869f..66a86a33339a 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -34,25 +34,17 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_from_user(const void *src, void *dst,
-				     int len, __wsum sum, int *err_ptr);
-__wsum __csum_partial_copy_to_user(const void *src, void *dst,
-				   int len, __wsum sum, int *err_ptr);
+__wsum __csum_partial_copy_from_user(const void __user *src, void *dst, int len);
+__wsum __csum_partial_copy_to_user(const void *src, void __user *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	__wsum sum = ~0U;
-	int err = 0;
-
 	might_fault();
-
 	if (!access_ok(src, len))
 		return 0;
-	sum = __csum_partial_copy_from_user((__force void *)src, dst,
-						     len, sum, &err);
-	return err ? 0 : sum;
+	return __csum_partial_copy_from_user(src, dst, len);
 }
 
 /*
@@ -62,26 +54,20 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 static inline
 __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	int err = 0;
-	__wsum sum = ~0U;
-
 	might_fault();
 	if (!access_ok(dst, len))
 		return 0;
-	sum = __csum_partial_copy_to_user(src,
-					   (__force void *)dst,
-					   len, sum, &err);
-	return err ? 0 : sum;
+	return __csum_partial_copy_to_user(src, dst, len);
 }
 
 /*
  * the same as csum_partial, but copies from user space (but on MIPS
  * we have just one address space, so this is identical to the above)
  */
-__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
+__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len);
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return __csum_partial_copy_nocheck(src, dst, len, 0);
+	return __csum_partial_copy_nocheck(src, dst, len);
 }
 #define csum_partial_copy_nocheck csum_partial_copy_nocheck
 
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 983e909c2052..a46db0807195 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -308,8 +308,8 @@ EXPORT_SYMBOL(csum_partial)
 /*
  * checksum and copy routines based on memcpy.S
  *
- *	csum_partial_copy_nocheck(src, dst, len, sum)
- *	__csum_partial_copy_kernel(src, dst, len, sum, errp)
+ *	csum_partial_copy_nocheck(src, dst, len)
+ *	__csum_partial_copy_kernel(src, dst, len)
  *
  * See "Spec" in memcpy.S for details.	Unlike __copy_user, all
  * function in this file use the standard calling convention.
@@ -318,26 +318,11 @@ EXPORT_SYMBOL(csum_partial)
 #define src a0
 #define dst a1
 #define len a2
-#define psum a3
 #define sum v0
 #define odd t8
-#define errptr t9
 
 /*
- * The exception handler for loads requires that:
- *  1- AT contain the address of the byte just past the end of the source
- *     of the copy,
- *  2- src_entry <= src < AT, and
- *  3- (dst - src) == (dst_entry - src_entry),
- * The _entry suffix denotes values when __copy_user was called.
- *
- * (1) is set up up by __csum_partial_copy_from_user and maintained by
- *	not writing AT in __csum_partial_copy
- * (2) is met by incrementing src by the number of bytes copied
- * (3) is met by not doing loads between a pair of increments of dst and src
- *
- * The exception handlers for stores stores -EFAULT to errptr and return.
- * These handlers do not need to overwrite any data.
+ * All exception handlers simply return 0.
  */
 
 /* Instruction type */
@@ -358,11 +343,11 @@ EXPORT_SYMBOL(csum_partial)
  * addr    : Address
  * handler : Exception handler
  */
-#define EXC(insn, type, reg, addr, handler)	\
+#define EXC(insn, type, reg, addr)		\
 	.if \mode == LEGACY_MODE;		\
 9:		insn reg, addr;			\
 		.section __ex_table,"a";	\
-		PTR	9b, handler;		\
+		PTR	9b, .L_exc;		\
 		.previous;			\
 	/* This is enabled in EVA mode */	\
 	.else;					\
@@ -371,7 +356,7 @@ EXPORT_SYMBOL(csum_partial)
 		    ((\to == USEROP) && (type == ST_INSN));	\
 9:			__BUILD_EVA_INSN(insn##e, reg, addr);	\
 			.section __ex_table,"a";		\
-			PTR	9b, handler;			\
+			PTR	9b, .L_exc;			\
 			.previous;				\
 		.else;						\
 			/* EVA without exception */		\
@@ -384,14 +369,14 @@ EXPORT_SYMBOL(csum_partial)
 #ifdef USE_DOUBLE
 
 #define LOADK	ld /* No exception */
-#define LOAD(reg, addr, handler)	EXC(ld, LD_INSN, reg, addr, handler)
-#define LOADBU(reg, addr, handler)	EXC(lbu, LD_INSN, reg, addr, handler)
-#define LOADL(reg, addr, handler)	EXC(ldl, LD_INSN, reg, addr, handler)
-#define LOADR(reg, addr, handler)	EXC(ldr, LD_INSN, reg, addr, handler)
-#define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
-#define STOREL(reg, addr, handler)	EXC(sdl, ST_INSN, reg, addr, handler)
-#define STORER(reg, addr, handler)	EXC(sdr, ST_INSN, reg, addr, handler)
-#define STORE(reg, addr, handler)	EXC(sd, ST_INSN, reg, addr, handler)
+#define LOAD(reg, addr)		EXC(ld, LD_INSN, reg, addr)
+#define LOADBU(reg, addr)	EXC(lbu, LD_INSN, reg, addr)
+#define LOADL(reg, addr)	EXC(ldl, LD_INSN, reg, addr)
+#define LOADR(reg, addr)	EXC(ldr, LD_INSN, reg, addr)
+#define STOREB(reg, addr)	EXC(sb, ST_INSN, reg, addr)
+#define STOREL(reg, addr)	EXC(sdl, ST_INSN, reg, addr)
+#define STORER(reg, addr)	EXC(sdr, ST_INSN, reg, addr)
+#define STORE(reg, addr)	EXC(sd, ST_INSN, reg, addr)
 #define ADD    daddu
 #define SUB    dsubu
 #define SRL    dsrl
@@ -404,14 +389,14 @@ EXPORT_SYMBOL(csum_partial)
 #else
 
 #define LOADK	lw /* No exception */
-#define LOAD(reg, addr, handler)	EXC(lw, LD_INSN, reg, addr, handler)
-#define LOADBU(reg, addr, handler)	EXC(lbu, LD_INSN, reg, addr, handler)
-#define LOADL(reg, addr, handler)	EXC(lwl, LD_INSN, reg, addr, handler)
-#define LOADR(reg, addr, handler)	EXC(lwr, LD_INSN, reg, addr, handler)
-#define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
-#define STOREL(reg, addr, handler)	EXC(swl, ST_INSN, reg, addr, handler)
-#define STORER(reg, addr, handler)	EXC(swr, ST_INSN, reg, addr, handler)
-#define STORE(reg, addr, handler)	EXC(sw, ST_INSN, reg, addr, handler)
+#define LOAD(reg, addr)		EXC(lw, LD_INSN, reg, addr)
+#define LOADBU(reg, addr)	EXC(lbu, LD_INSN, reg, addr)
+#define LOADL(reg, addr)	EXC(lwl, LD_INSN, reg, addr)
+#define LOADR(reg, addr)	EXC(lwr, LD_INSN, reg, addr)
+#define STOREB(reg, addr)	EXC(sb, ST_INSN, reg, addr)
+#define STOREL(reg, addr)	EXC(swl, ST_INSN, reg, addr)
+#define STORER(reg, addr)	EXC(swr, ST_INSN, reg, addr)
+#define STORE(reg, addr)	EXC(sw, ST_INSN, reg, addr)
 #define ADD    addu
 #define SUB    subu
 #define SRL    srl
@@ -450,22 +435,9 @@ EXPORT_SYMBOL(csum_partial)
 	.set	at=v1
 #endif
 
-	.macro __BUILD_CSUM_PARTIAL_COPY_USER mode, from, to, __nocheck
+	.macro __BUILD_CSUM_PARTIAL_COPY_USER mode, from, to
 
-	PTR_ADDU	AT, src, len	/* See (1) above. */
-	/* initialize __nocheck if this the first time we execute this
-	 * macro
-	 */
-#ifdef CONFIG_64BIT
-	move	errptr, a4
-#else
-	lw	errptr, 16(sp)
-#endif
-	.if \__nocheck == 1
-	FEXPORT(__csum_partial_copy_nocheck)
-	EXPORT_SYMBOL(__csum_partial_copy_nocheck)
-	.endif
-	move	sum, zero
+	li	sum, -1
 	move	odd, zero
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
@@ -497,31 +469,31 @@ EXPORT_SYMBOL(csum_partial)
 	SUB	len, 8*NBYTES		# subtract here for bgez loop
 	.align	4
 1:
-	LOAD(t0, UNIT(0)(src), .Ll_exc\@)
-	LOAD(t1, UNIT(1)(src), .Ll_exc_copy\@)
-	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
-	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
-	LOAD(t4, UNIT(4)(src), .Ll_exc_copy\@)
-	LOAD(t5, UNIT(5)(src), .Ll_exc_copy\@)
-	LOAD(t6, UNIT(6)(src), .Ll_exc_copy\@)
-	LOAD(t7, UNIT(7)(src), .Ll_exc_copy\@)
+	LOAD(t0, UNIT(0)(src))
+	LOAD(t1, UNIT(1)(src))
+	LOAD(t2, UNIT(2)(src))
+	LOAD(t3, UNIT(3)(src))
+	LOAD(t4, UNIT(4)(src))
+	LOAD(t5, UNIT(5)(src))
+	LOAD(t6, UNIT(6)(src))
+	LOAD(t7, UNIT(7)(src))
 	SUB	len, len, 8*NBYTES
 	ADD	src, src, 8*NBYTES
-	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
+	STORE(t0, UNIT(0)(dst))
 	ADDC(t0, t1)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
+	STORE(t1, UNIT(1)(dst))
 	ADDC(sum, t0)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
+	STORE(t2, UNIT(2)(dst))
 	ADDC(t2, t3)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
+	STORE(t3, UNIT(3)(dst))
 	ADDC(sum, t2)
-	STORE(t4, UNIT(4)(dst),	.Ls_exc\@)
+	STORE(t4, UNIT(4)(dst))
 	ADDC(t4, t5)
-	STORE(t5, UNIT(5)(dst),	.Ls_exc\@)
+	STORE(t5, UNIT(5)(dst))
 	ADDC(sum, t4)
-	STORE(t6, UNIT(6)(dst),	.Ls_exc\@)
+	STORE(t6, UNIT(6)(dst))
 	ADDC(t6, t7)
-	STORE(t7, UNIT(7)(dst),	.Ls_exc\@)
+	STORE(t7, UNIT(7)(dst))
 	ADDC(sum, t6)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 8*NBYTES
@@ -541,19 +513,19 @@ EXPORT_SYMBOL(csum_partial)
 	/*
 	 * len >= 4*NBYTES
 	 */
-	LOAD(t0, UNIT(0)(src), .Ll_exc\@)
-	LOAD(t1, UNIT(1)(src), .Ll_exc_copy\@)
-	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
-	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
+	LOAD(t0, UNIT(0)(src))
+	LOAD(t1, UNIT(1)(src))
+	LOAD(t2, UNIT(2)(src))
+	LOAD(t3, UNIT(3)(src))
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
-	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
+	STORE(t0, UNIT(0)(dst))
 	ADDC(t0, t1)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
+	STORE(t1, UNIT(1)(dst))
 	ADDC(sum, t0)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
+	STORE(t2, UNIT(2)(dst))
 	ADDC(t2, t3)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
+	STORE(t3, UNIT(3)(dst))
 	ADDC(sum, t2)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
@@ -566,10 +538,10 @@ EXPORT_SYMBOL(csum_partial)
 	beq	rem, len, .Lcopy_bytes\@
 	 nop
 1:
-	LOAD(t0, 0(src), .Ll_exc\@)
+	LOAD(t0, 0(src))
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc\@)
+	STORE(t0, 0(dst))
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
@@ -592,10 +564,10 @@ EXPORT_SYMBOL(csum_partial)
 	 ADD	t1, dst, len	# t1 is just past last byte of dst
 	li	bits, 8*NBYTES
 	SLL	rem, len, 3	# rem = number of bits to keep
-	LOAD(t0, 0(src), .Ll_exc\@)
+	LOAD(t0, 0(src))
 	SUB	bits, bits, rem # bits = number of bits to discard
 	SHIFT_DISCARD t0, t0, bits
-	STREST(t0, -1(t1), .Ls_exc\@)
+	STREST(t0, -1(t1))
 	SHIFT_DISCARD_REVERT t0, t0, bits
 	.set reorder
 	ADDC(sum, t0)
@@ -612,12 +584,12 @@ EXPORT_SYMBOL(csum_partial)
 	 * Set match = (src and dst have same alignment)
 	 */
 #define match rem
-	LDFIRST(t3, FIRST(0)(src), .Ll_exc\@)
+	LDFIRST(t3, FIRST(0)(src))
 	ADD	t2, zero, NBYTES
-	LDREST(t3, REST(0)(src), .Ll_exc_copy\@)
+	LDREST(t3, REST(0)(src))
 	SUB	t2, t2, t1	# t2 = number of bytes copied
 	xor	match, t0, t1
-	STFIRST(t3, FIRST(0)(dst), .Ls_exc\@)
+	STFIRST(t3, FIRST(0)(dst))
 	SLL	t4, t1, 3		# t4 = number of bits to discard
 	SHIFT_DISCARD t3, t3, t4
 	/* no SHIFT_DISCARD_REVERT to handle odd buffer properly */
@@ -639,26 +611,26 @@ EXPORT_SYMBOL(csum_partial)
  * It's OK to load FIRST(N+1) before REST(N) because the two addresses
  * are to the same unit (unless src is aligned, but it's not).
  */
-	LDFIRST(t0, FIRST(0)(src), .Ll_exc\@)
-	LDFIRST(t1, FIRST(1)(src), .Ll_exc_copy\@)
+	LDFIRST(t0, FIRST(0)(src))
+	LDFIRST(t1, FIRST(1)(src))
 	SUB	len, len, 4*NBYTES
-	LDREST(t0, REST(0)(src), .Ll_exc_copy\@)
-	LDREST(t1, REST(1)(src), .Ll_exc_copy\@)
-	LDFIRST(t2, FIRST(2)(src), .Ll_exc_copy\@)
-	LDFIRST(t3, FIRST(3)(src), .Ll_exc_copy\@)
-	LDREST(t2, REST(2)(src), .Ll_exc_copy\@)
-	LDREST(t3, REST(3)(src), .Ll_exc_copy\@)
+	LDREST(t0, REST(0)(src))
+	LDREST(t1, REST(1)(src))
+	LDFIRST(t2, FIRST(2)(src))
+	LDFIRST(t3, FIRST(3)(src))
+	LDREST(t2, REST(2)(src))
+	LDREST(t3, REST(3)(src))
 	ADD	src, src, 4*NBYTES
 #ifdef CONFIG_CPU_SB1
 	nop				# improves slotting
 #endif
-	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
+	STORE(t0, UNIT(0)(dst))
 	ADDC(t0, t1)
-	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
+	STORE(t1, UNIT(1)(dst))
 	ADDC(sum, t0)
-	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
+	STORE(t2, UNIT(2)(dst))
 	ADDC(t2, t3)
-	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
+	STORE(t3, UNIT(3)(dst))
 	ADDC(sum, t2)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
@@ -671,11 +643,11 @@ EXPORT_SYMBOL(csum_partial)
 	beq	rem, len, .Lcopy_bytes\@
 	 nop
 1:
-	LDFIRST(t0, FIRST(0)(src), .Ll_exc\@)
-	LDREST(t0, REST(0)(src), .Ll_exc_copy\@)
+	LDFIRST(t0, FIRST(0)(src))
+	LDREST(t0, REST(0)(src))
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
-	STORE(t0, 0(dst), .Ls_exc\@)
+	STORE(t0, 0(dst))
 	ADDC(sum, t0)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
@@ -696,11 +668,10 @@ EXPORT_SYMBOL(csum_partial)
 #endif
 	move	t2, zero	# partial word
 	li	t3, SHIFT_START # shift
-/* use .Ll_exc_copy here to return correct sum on fault */
 #define COPY_BYTE(N)			\
-	LOADBU(t0, N(src), .Ll_exc_copy\@);	\
+	LOADBU(t0, N(src));		\
 	SUB	len, len, 1;		\
-	STOREB(t0, N(dst), .Ls_exc\@);	\
+	STOREB(t0, N(dst));		\
 	SLLV	t0, t0, t3;		\
 	addu	t3, SHIFT_INC;		\
 	beqz	len, .Lcopy_bytes_done\@; \
@@ -714,9 +685,9 @@ EXPORT_SYMBOL(csum_partial)
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 #endif
-	LOADBU(t0, NBYTES-2(src), .Ll_exc_copy\@)
+	LOADBU(t0, NBYTES-2(src))
 	SUB	len, len, 1
-	STOREB(t0, NBYTES-2(dst), .Ls_exc\@)
+	STOREB(t0, NBYTES-2(dst))
 	SLLV	t0, t0, t3
 	or	t2, t0
 .Lcopy_bytes_done\@:
@@ -753,94 +724,31 @@ EXPORT_SYMBOL(csum_partial)
 #endif
 	.set	pop
 	.set reorder
-	ADDC32(sum, psum)
 	jr	ra
 	.set noreorder
+	.endm
 
-.Ll_exc_copy\@:
-	/*
-	 * Copy bytes from src until faulting load address (or until a
-	 * lb faults)
-	 *
-	 * When reached by a faulting LDFIRST/LDREST, THREAD_BUADDR($28)
-	 * may be more than a byte beyond the last address.
-	 * Hence, the lb below may get an exception.
-	 *
-	 * Assumes src < THREAD_BUADDR($28)
-	 */
-	LOADK	t0, TI_TASK($28)
-	 li	t2, SHIFT_START
-	LOADK	t0, THREAD_BUADDR(t0)
-1:
-	LOADBU(t1, 0(src), .Ll_exc\@)
-	ADD	src, src, 1
-	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
-	SLLV	t1, t1, t2
-	addu	t2, SHIFT_INC
-	ADDC(sum, t1)
-	.set	reorder				/* DADDI_WAR */
-	ADD	dst, dst, 1
-	bne	src, t0, 1b
-	.set	noreorder
-.Ll_exc\@:
-	LOADK	t0, TI_TASK($28)
-	 nop
-	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
-	 nop
-	SUB	len, AT, t0		# len number of uncopied bytes
-	/*
-	 * Here's where we rely on src and dst being incremented in tandem,
-	 *   See (3) above.
-	 * dst += (fault addr - src) to put dst at first byte to clear
-	 */
-	ADD	dst, t0			# compute start address in a1
-	SUB	dst, src
-	/*
-	 * Clear len bytes starting at dst.  Can't call __bzero because it
-	 * might modify len.  An inefficient loop for these rare times...
-	 */
-	.set	reorder				/* DADDI_WAR */
-	SUB	src, len, 1
-	beqz	len, .Ldone\@
-	.set	noreorder
-1:	sb	zero, 0(dst)
-	ADD	dst, dst, 1
-	.set	push
-	.set	noat
-#ifndef CONFIG_CPU_DADDI_WORKAROUNDS
-	bnez	src, 1b
-	 SUB	src, src, 1
-#else
-	li	v1, 1
-	bnez	src, 1b
-	 SUB	src, src, v1
-#endif
-	li	v1, -EFAULT
-	b	.Ldone\@
-	 sw	v1, (errptr)
-
-.Ls_exc\@:
-	li	v0, -1 /* invalid checksum */
-	li	v1, -EFAULT
+	.set noreorder
+.L_exc:
 	jr	ra
-	 sw	v1, (errptr)
-	.set	pop
-	.endm
+	 li	v0, 0
 
+FEXPORT(__csum_partial_copy_nocheck)
+EXPORT_SYMBOL(__csum_partial_copy_nocheck)
 #ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
 EXPORT_SYMBOL(__csum_partial_copy_to_user)
 FEXPORT(__csum_partial_copy_from_user)
 EXPORT_SYMBOL(__csum_partial_copy_from_user)
 #endif
-__BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
+__BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP
 
 #ifdef CONFIG_EVA
 LEAF(__csum_partial_copy_to_user)
-__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE KERNELOP USEROP 0
+__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE KERNELOP USEROP
 END(__csum_partial_copy_to_user)
 
 LEAF(__csum_partial_copy_from_user)
-__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE USEROP KERNELOP 0
+__BUILD_CSUM_PARTIAL_COPY_USER EVA_MODE USEROP KERNELOP
 END(__csum_partial_copy_from_user)
 #endif
-- 
2.11.0

