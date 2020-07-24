Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13C822BB6C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGXB0X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGXBZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380AC0619E3;
        Thu, 23 Jul 2020 18:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT5-001GdB-VE; Fri, 24 Jul 2020 01:25:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 12/20] i386: propagate the calling conventions change down to csum_partial_copy_generic()
Date:   Fri, 24 Jul 2020 02:25:38 +0100
Message-Id: <20200724012546.302155-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and don't bother zeroing destination on error

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum_32.h |  18 ++----
 arch/x86/lib/checksum_32.S         | 117 +++++++++++++------------------------
 2 files changed, 47 insertions(+), 88 deletions(-)

diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 5948cde9e4ad..17da95387997 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -27,9 +27,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
-					    int len, __wsum sum,
-					    int *src_err_ptr, int *dst_err_ptr);
+asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 /*
  *	Note: when you get a NULL pointer exception here this means someone
@@ -40,23 +38,21 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
  */
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len);
 }
 
 static inline __wsum csum_and_copy_from_user(const void __user *src,
 					     void *dst, int len)
 {
 	__wsum ret;
-	int err = 0;
 
 	might_sleep();
 	if (!user_access_begin(src, len))
 		return 0;
-	ret = csum_partial_copy_generic((__force void *)src, dst,
-					len, ~0U, &err, NULL);
+	ret = csum_partial_copy_generic((__force void *)src, dst, len);
 	user_access_end();
 
-	return err ? 0 : ret;
+	return ret;
 }
 
 /*
@@ -177,16 +173,14 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 					   int len)
 {
 	__wsum ret;
-	int err = 0;
 
 	might_sleep();
 	if (!user_access_begin(dst, len))
 		return 0;
 
-	ret = csum_partial_copy_generic(src, (__force void *)dst,
-					len, ~0U, NULL, &err);
+	ret = csum_partial_copy_generic(src, (__force void *)dst, len);
 	user_access_end();
-	return err ? 0 : ret;
+	return ret;
 }
 
 #endif /* _ASM_X86_CHECKSUM_32_H */
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index d1d768912368..4304320e51f4 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -253,28 +253,17 @@ EXPORT_SYMBOL(csum_partial)
 
 /*
 unsigned int csum_partial_copy_generic (const char *src, char *dst,
-				  int len, int sum, int *src_err_ptr, int *dst_err_ptr)
+				  int len)
  */ 
 
 /*
  * Copy from ds while checksumming, otherwise like csum_partial
- *
- * The macros SRC and DST specify the type of access for the instruction.
- * thus we can call a custom exception handler for all access types.
- *
- * FIXME: could someone double-check whether I haven't mixed up some SRC and
- *	  DST definitions? It's damn hard to trigger all cases.  I hope I got
- *	  them all but there's no guarantee.
  */
 
-#define SRC(y...)			\
+#define EXC(y...)			\
 	9999: y;			\
 	_ASM_EXTABLE_UA(9999b, 6001f)
 
-#define DST(y...)			\
-	9999: y;			\
-	_ASM_EXTABLE_UA(9999b, 6002f)
-
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
 #define ARGBASE 16		
@@ -285,20 +274,20 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	pushl %edi
 	pushl %esi
 	pushl %ebx
-	movl ARGBASE+16(%esp),%eax	# sum
 	movl ARGBASE+12(%esp),%ecx	# len
 	movl ARGBASE+4(%esp),%esi	# src
 	movl ARGBASE+8(%esp),%edi	# dst
 
+	movl $-1, %eax			# sum
 	testl $2, %edi			# Check alignment. 
 	jz 2f				# Jump if alignment is ok.
 	subl $2, %ecx			# Alignment uses up two bytes.
 	jae 1f				# Jump if we had at least two bytes.
 	addl $2, %ecx			# ecx was < 2.  Deal with it.
 	jmp 4f
-SRC(1:	movw (%esi), %bx	)
+EXC(1:	movw (%esi), %bx	)
 	addl $2, %esi
-DST(	movw %bx, (%edi)	)
+EXC(	movw %bx, (%edi)	)
 	addl $2, %edi
 	addw %bx, %ax	
 	adcl $0, %eax
@@ -306,34 +295,34 @@ DST(	movw %bx, (%edi)	)
 	movl %ecx, FP(%esp)
 	shrl $5, %ecx
 	jz 2f
-	testl %esi, %esi
-SRC(1:	movl (%esi), %ebx	)
-SRC(	movl 4(%esi), %edx	)
+	testl %esi, %esi		# what's wrong with clc?
+EXC(1:	movl (%esi), %ebx	)
+EXC(	movl 4(%esi), %edx	)
 	adcl %ebx, %eax
-DST(	movl %ebx, (%edi)	)
+EXC(	movl %ebx, (%edi)	)
 	adcl %edx, %eax
-DST(	movl %edx, 4(%edi)	)
+EXC(	movl %edx, 4(%edi)	)
 
-SRC(	movl 8(%esi), %ebx	)
-SRC(	movl 12(%esi), %edx	)
+EXC(	movl 8(%esi), %ebx	)
+EXC(	movl 12(%esi), %edx	)
 	adcl %ebx, %eax
-DST(	movl %ebx, 8(%edi)	)
+EXC(	movl %ebx, 8(%edi)	)
 	adcl %edx, %eax
-DST(	movl %edx, 12(%edi)	)
+EXC(	movl %edx, 12(%edi)	)
 
-SRC(	movl 16(%esi), %ebx 	)
-SRC(	movl 20(%esi), %edx	)
+EXC(	movl 16(%esi), %ebx 	)
+EXC(	movl 20(%esi), %edx	)
 	adcl %ebx, %eax
-DST(	movl %ebx, 16(%edi)	)
+EXC(	movl %ebx, 16(%edi)	)
 	adcl %edx, %eax
-DST(	movl %edx, 20(%edi)	)
+EXC(	movl %edx, 20(%edi)	)
 
-SRC(	movl 24(%esi), %ebx	)
-SRC(	movl 28(%esi), %edx	)
+EXC(	movl 24(%esi), %ebx	)
+EXC(	movl 28(%esi), %edx	)
 	adcl %ebx, %eax
-DST(	movl %ebx, 24(%edi)	)
+EXC(	movl %ebx, 24(%edi)	)
 	adcl %edx, %eax
-DST(	movl %edx, 28(%edi)	)
+EXC(	movl %edx, 28(%edi)	)
 
 	lea 32(%esi), %esi
 	lea 32(%edi), %edi
@@ -345,9 +334,9 @@ DST(	movl %edx, 28(%edi)	)
 	andl $0x1c, %edx
 	je 4f
 	shrl $2, %edx			# This clears CF
-SRC(3:	movl (%esi), %ebx	)
+EXC(3:	movl (%esi), %ebx	)
 	adcl %ebx, %eax
-DST(	movl %ebx, (%edi)	)
+EXC(	movl %ebx, (%edi)	)
 	lea 4(%esi), %esi
 	lea 4(%edi), %edi
 	dec %edx
@@ -357,39 +346,24 @@ DST(	movl %ebx, (%edi)	)
 	jz 7f
 	cmpl $2, %ecx
 	jb 5f
-SRC(	movw (%esi), %cx	)
+EXC(	movw (%esi), %cx	)
 	leal 2(%esi), %esi
-DST(	movw %cx, (%edi)	)
+EXC(	movw %cx, (%edi)	)
 	leal 2(%edi), %edi
 	je 6f
 	shll $16,%ecx
-SRC(5:	movb (%esi), %cl	)
-DST(	movb %cl, (%edi)	)
+EXC(5:	movb (%esi), %cl	)
+EXC(	movb %cl, (%edi)	)
 6:	addl %ecx, %eax
 	adcl $0, %eax
 7:
-5000:
 
 # Exception handler:
 .section .fixup, "ax"							
 
 6001:
-	movl ARGBASE+20(%esp), %ebx	# src_err_ptr
-	movl $-EFAULT, (%ebx)
-
-	# zero the complete destination - computing the rest
-	# is too much work 
-	movl ARGBASE+8(%esp), %edi	# dst
-	movl ARGBASE+12(%esp), %ecx	# len
-	xorl %eax,%eax
-	rep ; stosb
-
-	jmp 5000b
-
-6002:
-	movl ARGBASE+24(%esp), %ebx	# dst_err_ptr
-	movl $-EFAULT,(%ebx)
-	jmp 5000b
+	xorl %eax, %eax
+	jmp 7b
 
 .previous
 
@@ -405,14 +379,14 @@ SYM_FUNC_END(csum_partial_copy_generic)
 /* Version for PentiumII/PPro */
 
 #define ROUND1(x) \
-	SRC(movl x(%esi), %ebx	)	;	\
+	EXC(movl x(%esi), %ebx	)	;	\
 	addl %ebx, %eax			;	\
-	DST(movl %ebx, x(%edi)	)	; 
+	EXC(movl %ebx, x(%edi)	)	;
 
 #define ROUND(x) \
-	SRC(movl x(%esi), %ebx	)	;	\
+	EXC(movl x(%esi), %ebx	)	;	\
 	adcl %ebx, %eax			;	\
-	DST(movl %ebx, x(%edi)	)	;
+	EXC(movl %ebx, x(%edi)	)	;
 
 #define ARGBASE 12
 		
@@ -423,7 +397,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movl ARGBASE+4(%esp),%esi	#src
 	movl ARGBASE+8(%esp),%edi	#dst	
 	movl ARGBASE+12(%esp),%ecx	#len
-	movl ARGBASE+16(%esp),%eax	#sum
+	movl $-1, %eax			#sum
 #	movl %ecx, %edx  
 	movl %ecx, %ebx  
 	movl %esi, %edx
@@ -439,7 +413,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	JMP_NOSPEC ebx
 1:	addl $64,%esi
 	addl $64,%edi 
-	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
+	EXC(movb -32(%edx),%bl)	; EXC(movb (%edx),%bl)
 	ROUND1(-64) ROUND(-60) ROUND(-56) ROUND(-52)	
 	ROUND (-48) ROUND(-44) ROUND(-40) ROUND(-36)	
 	ROUND (-32) ROUND(-28) ROUND(-24) ROUND(-20)	
@@ -453,29 +427,20 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	jz 7f
 	cmpl $2, %edx
 	jb 5f
-SRC(	movw (%esi), %dx         )
+EXC(	movw (%esi), %dx         )
 	leal 2(%esi), %esi
-DST(	movw %dx, (%edi)         )
+EXC(	movw %dx, (%edi)         )
 	leal 2(%edi), %edi
 	je 6f
 	shll $16,%edx
 5:
-SRC(	movb (%esi), %dl         )
-DST(	movb %dl, (%edi)         )
+EXC(	movb (%esi), %dl         )
+EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
 .section .fixup, "ax"
-6001:	movl	ARGBASE+20(%esp), %ebx	# src_err_ptr	
-	movl $-EFAULT, (%ebx)
-	# zero the complete destination (computing the rest is too much work)
-	movl ARGBASE+8(%esp),%edi	# dst
-	movl ARGBASE+12(%esp),%ecx	# len
-	xorl %eax,%eax
-	rep; stosb
-	jmp 7b
-6002:	movl ARGBASE+24(%esp), %ebx	# dst_err_ptr
-	movl $-EFAULT, (%ebx)
+6001:	xorl %eax, %eax
 	jmp  7b			
 .previous				
 
-- 
2.11.0

