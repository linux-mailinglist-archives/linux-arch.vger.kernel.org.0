Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1665B22BB69
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXBZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGXBZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9CBC0619D3;
        Thu, 23 Jul 2020 18:25:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT6-001GdH-2b; Fri, 24 Jul 2020 01:25:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 13/20] sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()
Date:   Fri, 24 Jul 2020 02:25:39 +0100
Message-Id: <20200724012546.302155-13-viro@ZenIV.linux.org.uk>
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

... and get rid of zeroing the target, etc. on fault.
All exception handlers merge into one; moreover, since we are not
calling lookup_fault() anymore, we don't need the magic with passing
arguments for it from the page fault handler.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/checksum_32.h |  49 +--------
 arch/sparc/lib/checksum_32.S         | 202 +++++++----------------------------
 arch/sparc/mm/fault_32.c             |   6 +-
 3 files changed, 44 insertions(+), 213 deletions(-)

diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index b5873b7b7bf0..d55e480172a6 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -50,9 +50,9 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 
 	__asm__ __volatile__ (
 		"call __csum_partial_copy_sparc_generic\n\t"
-		" mov %6, %%g7\n"
+		" mov -1, %%g7\n"
 	: "=&r" (ret), "=&r" (d), "=&r" (l)
-	: "0" (ret), "1" (d), "2" (l), "r" (0)
+	: "0" (ret), "1" (d), "2" (l)
 	: "o2", "o3", "o4", "o5", "o7",
 	  "g2", "g3", "g4", "g5", "g7",
 	  "memory", "cc");
@@ -61,29 +61,10 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 
 static inline __wsum
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
-  {
-	register unsigned long ret asm("o0") = (unsigned long)src;
-	register char *d asm("o1") = dst;
-	register int l asm("g1") = len;
-	register __wsum s asm("g7") = ~0U;
-	int err = 0;
-
+{
 	if (unlikely(!access_ok(src, len)))
 		return 0;
-
-	__asm__ __volatile__ (
-	".section __ex_table,#alloc\n\t"
-	".align 4\n\t"
-	".word 1f,2\n\t"
-	".previous\n"
-	"1:\n\t"
-	"call __csum_partial_copy_sparc_generic\n\t"
-	" st %8, [%%sp + 64]\n"
-	: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
-	: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (&err)
-	: "o2", "o3", "o4", "o5", "o7", "g2", "g3", "g4", "g5",
-	  "cc", "memory");
-	return err ? 0 : (__force __wsum)ret;
+	return csum_partial_copy_nocheck((__force void *)src, dst, len);
 }
 
 #define HAVE_CSUM_COPY_USER
@@ -91,29 +72,9 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 static inline __wsum
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	register unsigned long ret asm("o0") = (unsigned long)src;
-	register char __user *d asm("o1") = dst;
-	register int l asm("g1") = len;
-	register __wsum s asm("g7") = ~0U;
-	int err = 0;
-
 	if (!access_ok(dst, len))
 		return 0;
-
-	__asm__ __volatile__ (
-	".section __ex_table,#alloc\n\t"
-	".align 4\n\t"
-	".word 1f,1\n\t"
-	".previous\n"
-	"1:\n\t"
-	"call __csum_partial_copy_sparc_generic\n\t"
-	" st %8, [%%sp + 64]\n"
-	: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
-	: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (&err)
-	: "o2", "o3", "o4", "o5", "o7",
-	  "g2", "g3", "g4", "g5",
-	  "cc", "memory");
-	return err ? 0 : (__force __wsum)ret;
+	return csum_partial_copy_nocheck(src, (__force void *)dst, len);
 }
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 6a5469c97246..7488d130faf7 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -144,44 +144,21 @@ cpte:	bne	csum_partial_end_cruft			! yep, handle it
 cpout:	retl						! get outta here
 	 mov	%o2, %o0				! return computed csum
 
-	.globl __csum_partial_copy_start, __csum_partial_copy_end
-__csum_partial_copy_start:
-
 /* Work around cpp -rob */
 #define ALLOC #alloc
 #define EXECINSTR #execinstr
-#define EX(x,y,a,b)				\
-98:     x,y;                                    \
-        .section .fixup,ALLOC,EXECINSTR;	\
-        .align  4;                              \
-99:     ba 30f;                                 \
-         a, b, %o3;                             \
-        .section __ex_table,ALLOC;		\
-        .align  4;                              \
-        .word   98b, 99b;                       \
-        .text;                                  \
-        .align  4
-
-#define EX2(x,y)				\
-98:     x,y;                                    \
-        .section __ex_table,ALLOC;		\
-        .align  4;                              \
-        .word   98b, 30f;                       \
-        .text;                                  \
-        .align  4
-
-#define EX3(x,y)				\
+#define EX(x,y)					\
 98:     x,y;                                    \
         .section __ex_table,ALLOC;		\
         .align  4;                              \
-        .word   98b, 96f;                       \
+        .word   98b, cc_fault;                   \
         .text;                                  \
         .align  4
 
-#define EXT(start,end,handler)			\
+#define EXT(start,end)				\
         .section __ex_table,ALLOC;		\
         .align  4;                              \
-        .word   start, 0, end, handler;         \
+        .word   start, 0, end, cc_fault;         \
         .text;                                  \
         .align  4
 
@@ -252,21 +229,21 @@ __csum_partial_copy_start:
 cc_end_cruft:
 	be	1f
 	 andcc	%o3, 4, %g0
-	EX(ldd	[%o0 + 0x00], %g2, and %o3, 0xf)
+	EX(ldd	[%o0 + 0x00], %g2)
 	add	%o1, 8, %o1
 	addcc	%g2, %g7, %g7
 	add	%o0, 8, %o0
 	addxcc	%g3, %g7, %g7
-	EX2(st	%g2, [%o1 - 0x08])
+	EX(st	%g2, [%o1 - 0x08])
 	addx	%g0, %g7, %g7
 	andcc	%o3, 4, %g0
-	EX2(st	%g3, [%o1 - 0x04])
+	EX(st	%g3, [%o1 - 0x04])
 1:	be	1f
 	 andcc	%o3, 3, %o3
-	EX(ld	[%o0 + 0x00], %g2, add %o3, 4)
+	EX(ld	[%o0 + 0x00], %g2)
 	add	%o1, 4, %o1
 	addcc	%g2, %g7, %g7
-	EX2(st	%g2, [%o1 - 0x04])
+	EX(st	%g2, [%o1 - 0x04])
 	addx	%g0, %g7, %g7
 	andcc	%o3, 3, %g0
 	add	%o0, 4, %o0
@@ -276,14 +253,14 @@ cc_end_cruft:
 	 subcc	%o3, 2, %o3
 	b	4f
 	 or	%g0, %g0, %o4
-2:	EX(lduh	[%o0 + 0x00], %o4, add %o3, 2)
+2:	EX(lduh	[%o0 + 0x00], %o4)
 	add	%o0, 2, %o0
-	EX2(sth	%o4, [%o1 + 0x00])
+	EX(sth	%o4, [%o1 + 0x00])
 	be	6f
 	 add	%o1, 2, %o1
 	sll	%o4, 16, %o4
-4:	EX(ldub	[%o0 + 0x00], %o5, add %g0, 1)
-	EX2(stb	%o5, [%o1 + 0x00])
+4:	EX(ldub	[%o0 + 0x00], %o5)
+	EX(stb	%o5, [%o1 + 0x00])
 	sll	%o5, 8, %o5
 	or	%o5, %o4, %o4
 6:	addcc	%o4, %g7, %g7
@@ -306,9 +283,9 @@ cc_dword_align:
 	 andcc	%o0, 0x2, %g0
 	be	1f
 	 andcc	%o0, 0x4, %g0
-	EX(lduh	[%o0 + 0x00], %g4, add %g1, 0)
+	EX(lduh	[%o0 + 0x00], %g4)
 	sub	%g1, 2, %g1
-	EX2(sth	%g4, [%o1 + 0x00])
+	EX(sth	%g4, [%o1 + 0x00])
 	add	%o0, 2, %o0
 	sll	%g4, 16, %g4
 	addcc	%g4, %g7, %g7
@@ -322,9 +299,9 @@ cc_dword_align:
 	or	%g3, %g7, %g7
 1:	be	3f
 	 andcc	%g1, 0xffffff80, %g0
-	EX(ld	[%o0 + 0x00], %g4, add %g1, 0)
+	EX(ld	[%o0 + 0x00], %g4)
 	sub	%g1, 4, %g1
-	EX2(st	%g4, [%o1 + 0x00])
+	EX(st	%g4, [%o1 + 0x00])
 	add	%o0, 4, %o0
 	addcc	%g4, %g7, %g7
 	add	%o1, 4, %o1
@@ -354,7 +331,7 @@ __csum_partial_copy_sparc_generic:
 	CSUMCOPY_BIGCHUNK(%o0,%o1,%g7,0x20,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
 	CSUMCOPY_BIGCHUNK(%o0,%o1,%g7,0x40,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
 	CSUMCOPY_BIGCHUNK(%o0,%o1,%g7,0x60,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
-10:	EXT(5b, 10b, 20f)		! note for exception handling
+10:	EXT(5b, 10b)			! note for exception handling
 	sub	%g1, 128, %g1		! detract from length
 	addx	%g0, %g7, %g7		! add in last carry bit
 	andcc	%g1, 0xffffff80, %g0	! more to csum?
@@ -379,7 +356,7 @@ cctbl:	CSUMCOPY_LASTCHUNK(%o0,%o1,%g7,0x68,%g2,%g3,%g4,%g5)
 	CSUMCOPY_LASTCHUNK(%o0,%o1,%g7,0x28,%g2,%g3,%g4,%g5)
 	CSUMCOPY_LASTCHUNK(%o0,%o1,%g7,0x18,%g2,%g3,%g4,%g5)
 	CSUMCOPY_LASTCHUNK(%o0,%o1,%g7,0x08,%g2,%g3,%g4,%g5)
-12:	EXT(cctbl, 12b, 22f)		! note for exception table handling
+12:	EXT(cctbl, 12b)			! note for exception table handling
 	addx	%g0, %g7, %g7
 	andcc	%o3, 0xf, %g0		! check for low bits set
 ccte:	bne	cc_end_cruft		! something left, handle it out of band
@@ -390,7 +367,7 @@ ccdbl:	CSUMCOPY_BIGCHUNK_ALIGNED(%o0,%o1,%g7,0x00,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o
 	CSUMCOPY_BIGCHUNK_ALIGNED(%o0,%o1,%g7,0x20,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
 	CSUMCOPY_BIGCHUNK_ALIGNED(%o0,%o1,%g7,0x40,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
 	CSUMCOPY_BIGCHUNK_ALIGNED(%o0,%o1,%g7,0x60,%o4,%o5,%g2,%g3,%g4,%g5,%o2,%o3)
-11:	EXT(ccdbl, 11b, 21f)		! note for exception table handling
+11:	EXT(ccdbl, 11b)			! note for exception table handling
 	sub	%g1, 128, %g1		! detract from length
 	addx	%g0, %g7, %g7		! add in last carry bit
 	andcc	%g1, 0xffffff80, %g0	! more to csum?
@@ -407,9 +384,9 @@ ccslow:	cmp	%g1, 0
 	be,a	1f
 	 srl	%g1, 1, %g4		
 	sub	%g1, 1, %g1	
-	EX(ldub	[%o0], %g5, add %g1, 1)
+	EX(ldub	[%o0], %g5)
 	add	%o0, 1, %o0	
-	EX2(stb	%g5, [%o1])
+	EX(stb	%g5, [%o1])
 	srl	%g1, 1, %g4
 	add	%o1, 1, %o1
 1:	cmp	%g4, 0		
@@ -418,34 +395,34 @@ ccslow:	cmp	%g1, 0
 	andcc	%o0, 2, %g0	
 	be,a	1f
 	 srl	%g4, 1, %g4
-	EX(lduh	[%o0], %o4, add %g1, 0)
+	EX(lduh	[%o0], %o4)
 	sub	%g1, 2, %g1	
 	srl	%o4, 8, %g2
 	sub	%g4, 1, %g4	
-	EX2(stb	%g2, [%o1])
+	EX(stb	%g2, [%o1])
 	add	%o4, %g5, %g5
-	EX2(stb	%o4, [%o1 + 1])
+	EX(stb	%o4, [%o1 + 1])
 	add	%o0, 2, %o0	
 	srl	%g4, 1, %g4
 	add	%o1, 2, %o1
 1:	cmp	%g4, 0		
 	be,a	2f
 	 andcc	%g1, 2, %g0
-	EX3(ld	[%o0], %o4)
+	EX(ld	[%o0], %o4)
 5:	srl	%o4, 24, %g2
 	srl	%o4, 16, %g3
-	EX2(stb	%g2, [%o1])
+	EX(stb	%g2, [%o1])
 	srl	%o4, 8, %g2
-	EX2(stb	%g3, [%o1 + 1])
+	EX(stb	%g3, [%o1 + 1])
 	add	%o0, 4, %o0
-	EX2(stb	%g2, [%o1 + 2])
+	EX(stb	%g2, [%o1 + 2])
 	addcc	%o4, %g5, %g5
-	EX2(stb	%o4, [%o1 + 3])
+	EX(stb	%o4, [%o1 + 3])
 	addx	%g5, %g0, %g5	! I am now to lazy to optimize this (question it
 	add	%o1, 4, %o1	! is worthy). Maybe some day - with the sll/srl
 	subcc	%g4, 1, %g4	! tricks
 	bne,a	5b
-	 EX3(ld	[%o0], %o4)
+	 EX(ld	[%o0], %o4)
 	sll	%g5, 16, %g2
 	srl	%g5, 16, %g5
 	srl	%g2, 16, %g2
@@ -453,19 +430,19 @@ ccslow:	cmp	%g1, 0
 	add	%g2, %g5, %g5 
 2:	be,a	3f		
 	 andcc	%g1, 1, %g0
-	EX(lduh	[%o0], %o4, and %g1, 3)
+	EX(lduh	[%o0], %o4)
 	andcc	%g1, 1, %g0
 	srl	%o4, 8, %g2
 	add	%o0, 2, %o0	
-	EX2(stb	%g2, [%o1])
+	EX(stb	%g2, [%o1])
 	add	%g5, %o4, %g5
-	EX2(stb	%o4, [%o1 + 1])
+	EX(stb	%o4, [%o1 + 1])
 	add	%o1, 2, %o1
 3:	be,a	1f		
 	 sll	%g5, 16, %o4
-	EX(ldub	[%o0], %g2, add %g0, 1)
+	EX(ldub	[%o0], %g2)
 	sll	%g2, 8, %o4	
-	EX2(stb	%g2, [%o1])
+	EX(stb	%g2, [%o1])
 	add	%g5, %o4, %g5
 	sll	%g5, 16, %o4
 1:	addcc	%o4, %g5, %g5
@@ -481,113 +458,10 @@ ccslow:	cmp	%g1, 0
 4:	addcc	%g7, %g5, %g7
 	retl	
 	 addx	%g0, %g7, %o0
-__csum_partial_copy_end:
 
 /* We do these strange calculations for the csum_*_from_user case only, ie.
  * we only bother with faults on loads... */
 
-/* o2 = ((g2%20)&3)*8
- * o3 = g1 - (g2/20)*32 - o2 */
-20:
-	cmp	%g2, 20
-	blu,a	1f
-	 and	%g2, 3, %o2
-	sub	%g1, 32, %g1
-	b	20b
-	 sub	%g2, 20, %g2
-1:
-	sll	%o2, 3, %o2
-	b	31f
-	 sub	%g1, %o2, %o3
-
-/* o2 = (!(g2 & 15) ? 0 : (((g2 & 15) + 1) & ~1)*8)
- * o3 = g1 - (g2/16)*32 - o2 */
-21:
-	andcc	%g2, 15, %o3
-	srl	%g2, 4, %g2
-	be,a	1f
-	 clr	%o2
-	add	%o3, 1, %o3
-	and	%o3, 14, %o3
-	sll	%o3, 3, %o2
-1:
-	sll	%g2, 5, %g2
-	sub	%g1, %g2, %o3
-	b	31f
-	 sub	%o3, %o2, %o3
-
-/* o0 += (g2/10)*16 - 0x70
- * 01 += (g2/10)*16 - 0x70
- * o2 = (g2 % 10) ? 8 : 0
- * o3 += 0x70 - (g2/10)*16 - o2 */
-22:
-	cmp	%g2, 10
-	blu,a	1f
-	 sub	%o0, 0x70, %o0
-	add	%o0, 16, %o0
-	add	%o1, 16, %o1
-	sub	%o3, 16, %o3
-	b	22b
-	 sub	%g2, 10, %g2
-1:
-	sub	%o1, 0x70, %o1
-	add	%o3, 0x70, %o3
-	clr	%o2
-	tst	%g2
-	bne,a	1f
-	 mov	8, %o2
-1:
-	b	31f
-	 sub	%o3, %o2, %o3
-96:
-	and	%g1, 3, %g1
-	sll	%g4, 2, %g4
-	add	%g1, %g4, %o3
-30:
-/* %o1 is dst
- * %o3 is # bytes to zero out
- * %o4 is faulting address
- * %o5 is %pc where fault occurred */
-	clr	%o2
-31:
-/* %o0 is src
- * %o1 is dst
- * %o2 is # of bytes to copy from src to dst
- * %o3 is # bytes to zero out
- * %o4 is faulting address
- * %o5 is %pc where fault occurred */
-	save	%sp, -104, %sp
-        mov     %i5, %o0
-        mov     %i7, %o1
-        mov	%i4, %o2
-        call    lookup_fault
-	 mov	%g7, %i4
-	cmp	%o0, 2
-	bne	1f	
-	 add	%g0, -EFAULT, %i5
-	tst	%i2
-	be	2f
-	 mov	%i0, %o1
-	mov	%i1, %o0
-5:
-	call	memcpy
-	 mov	%i2, %o2
-	tst	%o0
-	bne,a	2f
-	 add	%i3, %i2, %i3
-	add	%i1, %i2, %i1
-2:
-	mov	%i1, %o0
-6:
-	call	__bzero
-	 mov	%i3, %o1
-1:
-	ld	[%sp + 168], %o2		! struct_ptr of parent
-	st	%i5, [%o2]
+cc_fault:
 	ret
-	 restore
-
-        .section __ex_table,#alloc
-        .align 4
-        .word 5b,2
-	.word 6b,2
+	 clr	%o0
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index cfef656eda0f..1185b6169144 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -297,8 +297,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		if (fixup > 10) {
 			extern const unsigned int __memset_start[];
 			extern const unsigned int __memset_end[];
-			extern const unsigned int __csum_partial_copy_start[];
-			extern const unsigned int __csum_partial_copy_end[];
 
 #ifdef DEBUG_EXCEPTIONS
 			printk("Exception: PC<%08lx> faddr<%08lx>\n",
@@ -307,9 +305,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 				regs->pc, fixup, g2);
 #endif
 			if ((regs->pc >= (unsigned long)__memset_start &&
-			     regs->pc < (unsigned long)__memset_end) ||
-			    (regs->pc >= (unsigned long)__csum_partial_copy_start &&
-			     regs->pc < (unsigned long)__csum_partial_copy_end)) {
+			     regs->pc < (unsigned long)__memset_end)) {
 				regs->u_regs[UREG_I4] = address;
 				regs->u_regs[UREG_I5] = regs->pc;
 			}
-- 
2.11.0

