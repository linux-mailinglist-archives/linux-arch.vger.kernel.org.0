Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFE2289CE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgGUU0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbgGUUZy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:54 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD56C061794;
        Tue, 21 Jul 2020 13:25:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxypj-00HPpu-Jp; Tue, 21 Jul 2020 20:25:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 17/18] amd64: switch csum_partial_copy_generic() to new calling conventions
Date:   Tue, 21 Jul 2020 21:25:48 +0100
Message-Id: <20200721202549.4150745-17-viro@ZenIV.linux.org.uk>
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

... and fold handling of misaligned case into it.

Implementation note: we stash the "will we need to rol8 the sum in the end"
flag into the MSB of %rcx (the lower 32 bits are used for length); the rest
is pretty straightforward.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum_64.h |   5 +-
 arch/x86/lib/csum-copy_64.S        | 140 ++++++++++++++++++++++---------------
 arch/x86/lib/csum-wrappers_64.c    |  72 +++----------------
 3 files changed, 94 insertions(+), 123 deletions(-)

diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 9af3aed54c6b..407beebadaf4 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -130,10 +130,7 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
 /* Do not call this directly. Use the wrappers below */
-extern __visible __wsum csum_partial_copy_generic(const void *src, const void *dst,
-					int len, __wsum sum,
-					int *src_err_ptr, int *dst_err_ptr);
-
+extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index 3394a8ff7fd0..1fbd8ee9642d 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -18,9 +18,6 @@
  * rdi  source
  * rsi  destination
  * edx  len (32bit)
- * ecx  sum (32bit)
- * r8   src_err_ptr (int)
- * r9   dst_err_ptr (int)
  *
  * Output
  * eax  64bit sum. undefined in case of exception.
@@ -31,44 +28,32 @@
 
 	.macro source
 10:
-	_ASM_EXTABLE_UA(10b, .Lbad_source)
+	_ASM_EXTABLE_UA(10b, .Lfault)
 	.endm
 
 	.macro dest
 20:
-	_ASM_EXTABLE_UA(20b, .Lbad_dest)
+	_ASM_EXTABLE_UA(20b, .Lfault)
 	.endm
 
-	/*
-	 * No _ASM_EXTABLE_UA; this is used for intentional prefetch on a
-	 * potentially unmapped kernel address.
-	 */
-	.macro ignore L=.Lignore
-30:
-	_ASM_EXTABLE(30b, \L)
-	.endm
-
-
 SYM_FUNC_START(csum_partial_copy_generic)
-	cmpl	$3*64, %edx
-	jle	.Lignore
-
-.Lignore:
-	subq  $7*8, %rsp
-	movq  %rbx, 2*8(%rsp)
-	movq  %r12, 3*8(%rsp)
-	movq  %r14, 4*8(%rsp)
-	movq  %r13, 5*8(%rsp)
-	movq  %r15, 6*8(%rsp)
+	subq  $5*8, %rsp
+	movq  %rbx, 0*8(%rsp)
+	movq  %r12, 1*8(%rsp)
+	movq  %r14, 2*8(%rsp)
+	movq  %r13, 3*8(%rsp)
+	movq  %r15, 4*8(%rsp)
 
-	movq  %r8, (%rsp)
-	movq  %r9, 1*8(%rsp)
-
-	movl  %ecx, %eax
+	movl  $-1, %eax
+	xorl  %r9d, %r9d
 	movl  %edx, %ecx
+	cmpl  $8, %ecx
+	jb    .Lshort
 
-	xorl  %r9d, %r9d
-	movq  %rcx, %r12
+	testb  $7, %sil
+	jne   .Lunaligned
+.Laligned:
+	movl  %ecx, %r12d
 
 	shrq  $6, %r12
 	jz	.Lhandle_tail       /* < 64 */
@@ -99,7 +84,12 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	source
 	movq  56(%rdi), %r13
 
-	ignore 2f
+30:
+	/*
+	 * No _ASM_EXTABLE_UA; this is used for intentional prefetch on a
+	 * potentially unmapped kernel address.
+	 */
+	_ASM_EXTABLE(30b, 2f)
 	prefetcht0 5*64(%rdi)
 2:
 	adcq  %rbx, %rax
@@ -131,8 +121,6 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	dest
 	movq %r13, 56(%rsi)
 
-3:
-
 	leaq 64(%rdi), %rdi
 	leaq 64(%rsi), %rsi
 
@@ -142,8 +130,8 @@ SYM_FUNC_START(csum_partial_copy_generic)
 
 	/* do last up to 56 bytes */
 .Lhandle_tail:
-	/* ecx:	count */
-	movl %ecx, %r10d
+	/* ecx:	count, rcx.63: the end result needs to be rol8 */
+	movq %rcx, %r10
 	andl $63, %ecx
 	shrl $3, %ecx
 	jz	.Lfold
@@ -172,6 +160,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 .Lhandle_7:
 	movl %r10d, %ecx
 	andl $7, %ecx
+.L1:				/* .Lshort rejoins the common path here */
 	shrl $1, %ecx
 	jz   .Lhandle_1
 	movl $2, %edx
@@ -203,26 +192,65 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	adcl %r9d, %eax		/* carry */
 
 .Lende:
-	movq 2*8(%rsp), %rbx
-	movq 3*8(%rsp), %r12
-	movq 4*8(%rsp), %r14
-	movq 5*8(%rsp), %r13
-	movq 6*8(%rsp), %r15
-	addq $7*8, %rsp
+	testq %r10, %r10
+	js  .Lwas_odd
+.Lout:
+	movq 0*8(%rsp), %rbx
+	movq 1*8(%rsp), %r12
+	movq 2*8(%rsp), %r14
+	movq 3*8(%rsp), %r13
+	movq 4*8(%rsp), %r15
+	addq $5*8, %rsp
 	ret
+.Lshort:
+	movl %ecx, %r10d
+	jmp  .L1
+.Lunaligned:
+	xorl %ebx, %ebx
+	testb $1, %sil
+	jne  .Lodd
+1:	testb $2, %sil
+	je   2f
+	source
+	movw (%rdi), %bx
+	dest
+	movw %bx, (%rsi)
+	leaq 2(%rdi), %rdi
+	subq $2, %rcx
+	leaq 2(%rsi), %rsi
+	addq %rbx, %rax
+2:	testb $4, %sil
+	je .Laligned
+	source
+	movl (%rdi), %ebx
+	dest
+	movl %ebx, (%rsi)
+	leaq 4(%rdi), %rdi
+	subq $4, %rcx
+	leaq 4(%rsi), %rsi
+	addq %rbx, %rax
+	jmp .Laligned
+
+.Lodd:
+	source
+	movb (%rdi), %bl
+	dest
+	movb %bl, (%rsi)
+	leaq 1(%rdi), %rdi
+	leaq 1(%rsi), %rsi
+	/* decrement, set MSB */
+	leaq -1(%rcx, %rcx), %rcx
+	rorq $1, %rcx
+	shll $8, %ebx
+	addq %rbx, %rax
+	jmp 1b
+
+.Lwas_odd:
+	roll $8, %eax
+	jmp .Lout
 
-	/* Exception handlers. Very simple, zeroing is done in the wrappers */
-.Lbad_source:
-	movq (%rsp), %rax
-	testq %rax, %rax
-	jz   .Lende
-	movl $-EFAULT, (%rax)
-	jmp  .Lende
-
-.Lbad_dest:
-	movq 8(%rsp), %rax
-	testq %rax, %rax
-	jz   .Lende
-	movl $-EFAULT, (%rax)
-	jmp .Lende
+	/* Exception: just return 0 */
+.Lfault:
+	xorl %eax, %eax
+	jmp  .Lout
 SYM_FUNC_END(csum_partial_copy_generic)
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index ae2fb87e2274..189344924a2b 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -21,49 +21,16 @@
  * src and dst are best aligned to 64bits.
  */
 __wsum
-csum_and_copy_from_user(const void __user *src, void *dst,
-			    int len)
+csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	int err = 0;
-	__wsum isum = ~0U;
+	__wsum sum;
 
 	might_sleep();
-
 	if (!user_access_begin(src, len))
 		return 0;
-
-	/*
-	 * Why 6, not 7? To handle odd addresses aligned we
-	 * would need to do considerable complications to fix the
-	 * checksum which is defined as an 16bit accumulator. The
-	 * fix alignment code is primarily for performance
-	 * compatibility with 32bit and that will handle odd
-	 * addresses slowly too.
-	 */
-	if (unlikely((unsigned long)src & 6)) {
-		while (((unsigned long)src & 6) && len >= 2) {
-			__u16 val16;
-
-			unsafe_get_user(val16, (const __u16 __user *)src, out);
-
-			*(__u16 *)dst = val16;
-			isum = (__force __wsum)add32_with_carry(
-					(__force unsigned)isum, val16);
-			src += 2;
-			dst += 2;
-			len -= 2;
-		}
-	}
-	isum = csum_partial_copy_generic((__force const void *)src,
-				dst, len, isum, &err, NULL);
-	user_access_end();
-	if (unlikely(err))
-		isum = 0;
-	return isum;
-
-out:
+	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
 	user_access_end();
-	return 0;
+	return sum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
@@ -79,37 +46,16 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
  * src and dst are best aligned to 64bits.
  */
 __wsum
-csum_and_copy_to_user(const void *src, void __user *dst,
-			  int len)
+csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	__wsum ret, isum = ~0U;
-	int err = 0;
+	__wsum sum;
 
 	might_sleep();
-
 	if (!user_access_begin(dst, len))
 		return 0;
-
-	if (unlikely((unsigned long)dst & 6)) {
-		while (((unsigned long)dst & 6) && len >= 2) {
-			__u16 val16 = *(__u16 *)src;
-
-			isum = (__force __wsum)add32_with_carry(
-					(__force unsigned)isum, val16);
-			unsafe_put_user(val16, (__u16 __user *)dst, out);
-			src += 2;
-			dst += 2;
-			len -= 2;
-		}
-	}
-
-	ret = csum_partial_copy_generic(src, (void __force *)dst,
-					len, isum, NULL, &err);
-	user_access_end();
-	return err ? 0 : ret;
-out:
+	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
 	user_access_end();
-	return 0;
+	return sum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
 
@@ -125,7 +71,7 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
-- 
2.11.0

