Return-Path: <linux-arch+bounces-681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5178044B8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5ED28140F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D4523A;
	Tue,  5 Dec 2023 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wrmmqTIa"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F5D3;
	Mon,  4 Dec 2023 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zXGGSH6YmbXbuZ4eL8ouPfClKC42PISvPpQOqqYEmHA=; b=wrmmqTIaohTEei0MSmHCsQKh+d
	JgNqtTX9ZfZoK/ortg+wwazolTczRwkHtP1e3Ciraks3fKdc++c+GDAwWKAUG7aox5tbr1+jximmi
	ocTrSotYSxfueepLQq7+V4yFIaNdRp42CvWEe5/e/h7dD28uZ4Fb/InIZT1O2uwn67Nq8AsVTMhSm
	r9R7A4tu1kFt/4A6MMMZw632RY6uCQJ58REVv0B1+IZzg9kZEs/1H8fCQ/N3tvvP3GN1a75sHCRe+
	LCWVxAWIbnYCflLi/BzNDB9OorsvpO4GHGU2D1CHyAQc95zJFRl2yh40dvqzFQ8ArAqxhi2x27v6v
	zNRCNigQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6h-00792C-2k;
	Tue, 05 Dec 2023 02:24:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 04/18] Fix the csum_and_copy_..._user() idiocy
Date: Tue,  5 Dec 2023 02:23:59 +0000
Message-Id: <20231205022418.1703007-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We need a way for csum_and_copy_{from,to}_user() to report faults.
The approach taken back in 2020 (avoid 0 as return value by starting
summing from ~0U, use 0 to report faults) had been broken; it does
yield the right value modulo 2^16-1, but the case when data is
entirely zero-filled is not handled right.  It almost works, since
for most of the codepaths we have a non-zero value added in
and there 0 is not different from anything divisible by 0xffff.
However, there are cases (ICMPv4 replies, for example) where we
are not guaranteed that.

In other words, we really need to have those primitives return 0
on filled-with-zeroes input.  So let's make them return a 64bit
value instead; we can do that cheaply (all supported architectures
do that via a couple of registers) and we can use that to report
faults without disturbing the 32bit csum.

New type: __wsum_fault.  64bit, returned by csum_and_copy_..._user().
Primitives:
        * CSUM_FAULT representing the fault
        * to_wsum_fault() folding __wsum value into that
        * from_wsum_fault() extracting __wsum value
        * wsum_is_fault() checking if it's a fault value

Representation depends upon the target.
        CSUM_FAULT: ~0ULL
        to_wsum_fault(v32): (u64)v32 for 64bit and 32bit l-e,
(u64)v32 << 32 for 32bit b-e.

Rationale: relationship between the calling conventions for returning 64bit
and those for returning 32bit values.  On 64bit architectures the same
register is used; on 32bit l-e the lower half of the value goes in the
same register that is used for returning 32bit values and the upper half
goes into additional register.  On 32bit b-e the opposite happens -
upper 32 bits go into the register used for returning 32bit values and
the lower 32 bits get stuffed into additional register.

So with this choice of representation we need minimal changes on the
asm side (zero an extra register in 32bit case, nothing in 64bit case),
and from_wsum_fault() is as cheap as it gets.

Sum calculation is back to "start from 0".

X-paperbag: brown
Fixes: c693cc4676a0 "saner calling conventions for csum_and_copy_..._user()"
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: gus Gusenleitner Klaus <gus@keba.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h     |  2 +-
 arch/alpha/lib/csum_partial_copy.c    | 74 +++++++++++++--------------
 arch/arm/include/asm/checksum.h       |  6 +--
 arch/arm/lib/csumpartialcopygeneric.S |  3 +-
 arch/arm/lib/csumpartialcopyuser.S    |  8 +--
 arch/m68k/include/asm/checksum.h      |  2 +-
 arch/m68k/lib/checksum.c              |  8 +--
 arch/mips/include/asm/checksum.h      | 16 +++---
 arch/mips/lib/csum_partial.S          | 10 +++-
 arch/powerpc/include/asm/checksum.h   |  8 +--
 arch/powerpc/lib/checksum_32.S        |  6 ++-
 arch/powerpc/lib/checksum_64.S        |  4 +-
 arch/powerpc/lib/checksum_wrappers.c  | 12 ++---
 arch/sh/include/asm/checksum_32.h     | 12 ++---
 arch/sh/lib/checksum.S                |  6 ++-
 arch/sparc/include/asm/checksum_32.h  | 46 ++++++++++++++---
 arch/sparc/include/asm/checksum_64.h  |  4 +-
 arch/sparc/lib/checksum_32.S          |  2 +-
 arch/sparc/lib/csum_copy.S            |  2 +-
 arch/sparc/lib/csum_copy_from_user.S  |  2 +-
 arch/sparc/lib/csum_copy_to_user.S    |  2 +-
 arch/x86/include/asm/checksum_32.h    | 16 +++---
 arch/x86/include/asm/checksum_64.h    |  6 +--
 arch/x86/lib/checksum_32.S            | 20 ++++++--
 arch/x86/lib/csum-copy_64.S           |  6 +--
 arch/x86/lib/csum-wrappers_64.c       | 18 +++----
 arch/xtensa/include/asm/checksum.h    | 12 ++---
 arch/xtensa/lib/checksum.S            |  6 ++-
 include/net/checksum.h                | 46 ++++++++++++++---
 net/core/datagram.c                   |  8 +--
 net/core/skbuff.c                     |  8 +--
 31 files changed, 231 insertions(+), 150 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 99d631e146b2..d3abe290ae4e 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -43,7 +43,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len);
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index 4d180d96f09e..28ddb041bfe5 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -52,7 +52,7 @@ __asm__ __volatile__("insqh %1,%2,%0":"=r" (z):"r" (x),"r" (y))
 	__guu_err;					\
 })
 
-static inline unsigned short from64to16(unsigned long x)
+static inline __wsum_fault from64to16(unsigned long x)
 {
 	/* Using extract instructions is a bit more efficient
 	   than the original shift/bitmask version.  */
@@ -72,7 +72,7 @@ static inline unsigned short from64to16(unsigned long x)
 			+ (unsigned long) tmp_v.us[2];
 
 	/* Similarly, out_v.us[2] is always zero for the final add.  */
-	return out_v.us[0] + out_v.us[1];
+	return to_wsum_fault((__force __wsum)(out_v.us[0] + out_v.us[1]));
 }
 
 
@@ -80,17 +80,17 @@ static inline unsigned short from64to16(unsigned long x)
 /*
  * Ok. This isn't fun, but this is the EASY case.
  */
-static inline unsigned long
+static inline __wsum_fault
 csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 			 long len)
 {
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 	unsigned long carry = 0;
 
 	while (len >= 0) {
 		unsigned long word;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return CSUM_FAULT;
 		checksum += carry;
 		src++;
 		checksum += word;
@@ -104,7 +104,7 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 	if (len) {
 		unsigned long word, tmp;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return CSUM_FAULT;
 		tmp = *dst;
 		mskql(word, len, word);
 		checksum += word;
@@ -113,14 +113,14 @@ csum_partial_cfu_aligned(const unsigned long __user *src, unsigned long *dst,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16(checksum);
 }
 
 /*
  * This is even less fun, but this is still reasonably
  * easy.
  */
-static inline unsigned long
+static inline __wsum_fault
 csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 			      unsigned long *dst,
 			      unsigned long soff,
@@ -129,16 +129,16 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 	unsigned long first;
 	unsigned long word, carry;
 	unsigned long lastsrc = 7+len+(unsigned long)src;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	if (__get_word(ldq_u, first,src))
-		return 0;
+		return CSUM_FAULT;
 	carry = 0;
 	while (len >= 0) {
 		unsigned long second;
 
 		if (__get_word(ldq_u, second, src+1))
-			return 0;
+			return CSUM_FAULT;
 		extql(first, soff, word);
 		len -= 8;
 		src++;
@@ -157,7 +157,7 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 		unsigned long tmp;
 		unsigned long second;
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return CSUM_FAULT;
 		tmp = *dst;
 		extql(first, soff, word);
 		extqh(second, soff, first);
@@ -169,13 +169,13 @@ csum_partial_cfu_dest_aligned(const unsigned long __user *src,
 		*dst = word | tmp;
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16(checksum);
 }
 
 /*
  * This is slightly less fun than the above..
  */
-static inline unsigned long
+static inline __wsum_fault
 csum_partial_cfu_src_aligned(const unsigned long __user *src,
 			     unsigned long *dst,
 			     unsigned long doff,
@@ -185,12 +185,12 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	unsigned long carry = 0;
 	unsigned long word;
 	unsigned long second_dest;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
 		if (__get_word(ldq, word, src))
-			return 0;
+			return CSUM_FAULT;
 		len -= 8;
 		insql(word, doff, second_dest);
 		checksum += carry;
@@ -205,7 +205,7 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	if (len) {
 		checksum += carry;
 		if (__get_word(ldq, word, src))
-			return 0;
+			return CSUM_FAULT;
 		mskql(word, len, word);
 		len -= 8;
 		checksum += word;
@@ -226,14 +226,14 @@ csum_partial_cfu_src_aligned(const unsigned long __user *src,
 	stq_u(partial_dest | second_dest, dst);
 out:
 	checksum += carry;
-	return checksum;
+	return from64to16(checksum);
 }
 
 /*
  * This is so totally un-fun that it's frightening. Don't
  * look at this too closely, you'll go blind.
  */
-static inline unsigned long
+static inline __wsum_fault
 csum_partial_cfu_unaligned(const unsigned long __user * src,
 			   unsigned long * dst,
 			   unsigned long soff, unsigned long doff,
@@ -242,10 +242,10 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 	unsigned long carry = 0;
 	unsigned long first;
 	unsigned long lastsrc;
-	unsigned long checksum = ~0U;
+	unsigned long checksum = 0;
 
 	if (__get_word(ldq_u, first, src))
-		return 0;
+		return CSUM_FAULT;
 	lastsrc = 7+len+(unsigned long)src;
 	mskql(partial_dest, doff, partial_dest);
 	while (len >= 0) {
@@ -253,7 +253,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, src+1))
-			return 0;
+			return CSUM_FAULT;
 		extql(first, soff, word);
 		checksum += carry;
 		len -= 8;
@@ -275,7 +275,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return CSUM_FAULT;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -297,7 +297,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		unsigned long second_dest;
 
 		if (__get_word(ldq_u, second, lastsrc))
-			return 0;
+			return CSUM_FAULT;
 		extql(first, soff, word);
 		extqh(second, soff, first);
 		word |= first;
@@ -310,22 +310,21 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 		stq_u(partial_dest | word | second_dest, dst);
 		checksum += carry;
 	}
-	return checksum;
+	return from64to16(checksum);
 }
 
-static __wsum __csum_and_copy(const void __user *src, void *dst, int len)
+static __wsum_fault __csum_and_copy(const void __user *src, void *dst, int len)
 {
 	unsigned long soff = 7 & (unsigned long) src;
 	unsigned long doff = 7 & (unsigned long) dst;
-	unsigned long checksum;
 
 	if (!doff) {
 		if (!soff)
-			checksum = csum_partial_cfu_aligned(
+			return csum_partial_cfu_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst, len-8);
 		else
-			checksum = csum_partial_cfu_dest_aligned(
+			return csum_partial_cfu_dest_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				soff, len-8);
@@ -333,31 +332,28 @@ static __wsum __csum_and_copy(const void __user *src, void *dst, int len)
 		unsigned long partial_dest;
 		ldq_u(partial_dest, dst);
 		if (!soff)
-			checksum = csum_partial_cfu_src_aligned(
+			return csum_partial_cfu_src_aligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				doff, len-8, partial_dest);
 		else
-			checksum = csum_partial_cfu_unaligned(
+			return csum_partial_cfu_unaligned(
 				(const unsigned long __user *) src,
 				(unsigned long *) dst,
 				soff, doff, len-8, partial_dest);
 	}
-	return (__force __wsum)from64to16 (checksum);
 }
 
-__wsum
-csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return CSUM_FAULT;
 	return __csum_and_copy(src, dst, len);
 }
 
-__wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return __csum_and_copy((__force const void __user *)src,
-						dst, len);
+	return from_wsum_fault(__csum_and_copy((__force const void __user *)src,
+						dst, len));
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index d8a13959bff0..a295b0d037f0 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -38,16 +38,16 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
-__wsum
+__wsum_fault
 csum_partial_copy_from_user(const void __user *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return CSUM_FAULT;
 
 	return csum_partial_copy_from_user(src, dst, len);
 }
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 0fd5c10e90a7..5db935eaf165 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -86,7 +86,7 @@ sum	.req	r3
 
 FN_ENTRY
 		save_regs
-		mov	sum, #-1
+		mov	sum, #0
 
 		cmp	len, #8			@ Ensure that we have at least
 		blo	.Lless8			@ 8 bytes to copy.
@@ -160,6 +160,7 @@ FN_ENTRY
 		ldr	sum, [sp, #0]		@ dst
 		tst	sum, #1
 		movne	r0, r0, ror #8
+		mov	r1, #0
 		load_regs
 
 .Lsrc_not_aligned:
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 6928781e6bee..4b69b9f04fda 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -64,7 +64,7 @@
  * unsigned int
  * csum_partial_copy_from_user(const char *src, char *dst, int len)
  *  r0 = src, r1 = dst, r2 = len
- *  Returns : r0 = checksum or 0
+ *  Returns : r0:r1 = checksum:0 on success or -1:-1 on fault
  */
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
@@ -73,11 +73,11 @@
 #include "csumpartialcopygeneric.S"
 
 /*
- * We report fault by returning 0 csum - impossible in normal case, since
- * we start with 0xffffffff for initial sum.
+ * We report fault by returning ~0ULL csum
  */
 		.pushsection .text.fixup,"ax"
 		.align	4
-9001:		mov	r0, #0
+9001:		mov	r0, #-1
+		mov	r1, #-1
 		load_regs
 		.popsection
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 692e7b6cc042..2adef06feeb3 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -32,7 +32,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
-extern __wsum csum_and_copy_from_user(const void __user *src,
+extern __wsum_fault csum_and_copy_from_user(const void __user *src,
 						void *dst,
 						int len);
 
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 5acb821849d3..4fed9070e976 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -128,7 +128,7 @@ EXPORT_SYMBOL(csum_partial);
  * copy from user space while checksumming, with exception handling.
  */
 
-__wsum
+__wsum_fault
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	/*
@@ -137,7 +137,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	 * code.
 	 */
 	unsigned long tmp1, tmp2;
-	__wsum sum = ~0U;
+	__wsum sum = 0;
 
 	__asm__("movel %2,%4\n\t"
 		"btst #1,%4\n\t"	/* Check alignment */
@@ -240,7 +240,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 		".even\n"
 		/* If any exception occurs, return 0 */
 	     "90:\t"
-		"clrl %0\n"
+		"moveq #1,%5\n"
 		"jra 7b\n"
 		".previous\n"
 		".section __ex_table,\"a\"\n"
@@ -262,7 +262,7 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 		: "0" (sum), "1" (len), "2" (src), "3" (dst)
 	    );
 
-	return sum;
+	return tmp2 ? CSUM_FAULT : to_wsum_fault(sum);
 }
 
 
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 4044eaf989ac..3dfe9eca4adc 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -34,16 +34,16 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_from_user(const void __user *src, void *dst, int len);
-__wsum __csum_partial_copy_to_user(const void *src, void __user *dst, int len);
+__wsum_fault __csum_partial_copy_from_user(const void __user *src, void *dst, int len);
+__wsum_fault __csum_partial_copy_to_user(const void *src, void __user *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	might_fault();
 	if (!access_ok(src, len))
-		return 0;
+		return CSUM_FAULT;
 	return __csum_partial_copy_from_user(src, dst, len);
 }
 
@@ -52,11 +52,11 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
  */
 #define HAVE_CSUM_COPY_USER
 static inline
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
+__wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
 	might_fault();
 	if (!access_ok(dst, len))
-		return 0;
+		return CSUM_FAULT;
 	return __csum_partial_copy_to_user(src, dst, len);
 }
 
@@ -65,10 +65,10 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
  * we have just one address space, so this is identical to the above)
  */
 #define _HAVE_ARCH_CSUM_AND_COPY
-__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len);
+__wsum_fault __csum_partial_copy_nocheck(const void *src, void *dst, int len);
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return __csum_partial_copy_nocheck(src, dst, len);
+	return from_wsum_fault(__csum_partial_copy_nocheck(src, dst, len));
 }
 
 /*
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 3d2ff4118d79..b0cda2950f4e 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -437,7 +437,7 @@ EXPORT_SYMBOL(csum_partial)
 
 	.macro __BUILD_CSUM_PARTIAL_COPY_USER mode, from, to
 
-	li	sum, -1
+	move	sum, zero
 	move	odd, zero
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
@@ -723,6 +723,9 @@ EXPORT_SYMBOL(csum_partial)
 1:
 #endif
 	.set	pop
+#ifndef CONFIG_64BIT
+	move	v1, zero
+#endif
 	.set reorder
 	jr	ra
 	.set noreorder
@@ -730,8 +733,11 @@ EXPORT_SYMBOL(csum_partial)
 
 	.set noreorder
 .L_exc:
+#ifndef CONFIG_64BIT
+	li	v1, -1
+#endif
 	jr	ra
-	 li	v0, 0
+	 li	v0, -1
 
 FEXPORT(__csum_partial_copy_nocheck)
 EXPORT_SYMBOL(__csum_partial_copy_nocheck)
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 4b573a3b7e17..b68184dfac00 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -18,18 +18,18 @@
  * Like csum_partial, this must be called with even lengths,
  * except for the last fragment.
  */
-extern __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+extern __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
+extern __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst,
 				      int len);
 #define HAVE_CSUM_COPY_USER
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
+extern __wsum_fault csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len)   \
-        csum_partial_copy_generic((src), (dst), (len))
+        from_wsum_fault(csum_partial_copy_generic((src), (dst), (len)))
 
 
 /*
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index cd00b9bdd772..03f63f36aeba 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -122,7 +122,7 @@ LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
 
 _GLOBAL(csum_partial_copy_generic)
-	li	r12,-1
+	li	r12,0
 	addic	r0,r0,0			/* clear carry */
 	addi	r6,r4,-4
 	neg	r0,r4
@@ -233,12 +233,14 @@ _GLOBAL(csum_partial_copy_generic)
 	slwi	r0,r0,8
 	adde	r12,r12,r0
 66:	addze	r3,r12
+	li	r4,0
 	beqlr+	cr7
 	rlwinm	r3,r3,8,0,31	/* odd destination address: rotate one byte */
 	blr
 
 fault:
-	li	r3,0
+	li	r3,-1
+	li	r4,-1
 	blr
 
 	EX_TABLE(70b, fault);
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index d53d8f09a2c2..3bbfeb98d256 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -208,7 +208,7 @@ EXPORT_SYMBOL(__csum_partial)
  * csum_partial_copy_generic(r3=src, r4=dst, r5=len)
  */
 _GLOBAL(csum_partial_copy_generic)
-	li	r6,-1
+	li	r6,0
 	addic	r0,r6,0			/* clear carry */
 
 	srdi.	r6,r5,3			/* less than 8 bytes? */
@@ -406,7 +406,7 @@ dstnr;	stb	r6,0(r4)
 	ld	r16,STK_REG(R16)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 .Lerror_nr:
-	li	r3,0
+	li	r3,-1
 	blr
 
 EXPORT_SYMBOL(csum_partial_copy_generic)
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index 6df0fd24482e..92425984cd47 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -11,13 +11,13 @@
 #include <linux/uaccess.h>
 #include <net/checksum.h>
 
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst,
 			       int len)
 {
-	__wsum csum;
+	__wsum_fault csum;
 
 	if (unlikely(!user_read_access_begin(src, len)))
-		return 0;
+		return CSUM_FAULT;
 
 	csum = csum_partial_copy_generic((void __force *)src, dst, len);
 
@@ -25,12 +25,12 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 	return csum;
 }
 
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
+__wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	__wsum csum;
+	__wsum_fault csum;
 
 	if (unlikely(!user_write_access_begin(dst, len)))
-		return 0;
+		return CSUM_FAULT;
 
 	csum = csum_partial_copy_generic(src, (void __force *)dst, len);
 
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 2b5fa75b4651..94464451fd08 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -31,7 +31,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 /*
@@ -44,15 +44,15 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return CSUM_FAULT;
 	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
@@ -193,12 +193,12 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static inline __wsum csum_and_copy_to_user(const void *src,
+static inline __wsum_fault csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len)
 {
 	if (!access_ok(dst, len))
-		return 0;
+		return CSUM_FAULT;
 	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif /* __ASM_SH_CHECKSUM_H */
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..2d624efc4c2d 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -193,7 +193,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
 ! r6:	int LEN
 !
 ENTRY(csum_partial_copy_generic)
-	mov	#-1,r7
+	mov	#0,r7
 	mov	#3,r0		! Check src and dest are equally aligned
 	mov	r4,r1
 	and	r0,r1
@@ -358,8 +358,10 @@ EXC(	mov.b	r0,@r5	)
 .section .fixup, "ax"							
 
 6001:
+	mov	#-1,r1
 	rts
-	 mov	#0,r0
+	 mov	#-1,r0
 .previous
+	mov	#0,r1
 	rts
 	 mov	r7,r0
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index ce11e0ad80c7..6dad14f4c925 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -50,7 +50,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 
 	__asm__ __volatile__ (
 		"call __csum_partial_copy_sparc_generic\n\t"
-		" mov -1, %%g7\n"
+		" clr %%g7\n"
 	: "=&r" (ret), "=&r" (d), "=&r" (l)
 	: "0" (ret), "1" (d), "2" (l)
 	: "o2", "o3", "o4", "o5", "o7",
@@ -59,20 +59,50 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 	return (__force __wsum)ret;
 }
 
-static inline __wsum
+static inline __wsum_fault
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
+	register unsigned int ret asm("o0") = (unsigned int)src;
+	register char *d asm("o1") = dst;
+	register int l asm("g1") = len; // used to return an error
+
 	if (unlikely(!access_ok(src, len)))
-		return 0;
-	return csum_partial_copy_nocheck((__force void *)src, dst, len);
+		return CSUM_FAULT;
+
+	__asm__ __volatile__ (
+		"call __csum_partial_copy_sparc_generic\n\t"
+		" clr %%g7\n"
+	: "=&r" (ret), "=&r" (d), "=&r" (l)
+	: "0" (ret), "1" (d), "2" (l)
+	: "o2", "o3", "o4", "o5", "o7",
+	  "g2", "g3", "g4", "g5", "g7",
+	  "memory", "cc");
+	if (unlikely(l < 0))
+		return CSUM_FAULT;
+	return to_wsum_fault((__force __wsum)ret);
 }
 
-static inline __wsum
+static inline __wsum_fault
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	if (!access_ok(dst, len))
-		return 0;
-	return csum_partial_copy_nocheck(src, (__force void *)dst, len);
+	register unsigned int ret asm("o0") = (unsigned int)src;
+	register char *d asm("o1") = (__force void *)dst;
+	register int l asm("g1") = len; // used to return an error
+
+	if (unlikely(!access_ok(dst, len)))
+		return CSUM_FAULT;
+
+	__asm__ __volatile__ (
+		"call __csum_partial_copy_sparc_generic\n\t"
+		" clr %%g7\n"
+	: "=&r" (ret), "=&r" (d), "=&r" (l)
+	: "0" (ret), "1" (d), "2" (l)
+	: "o2", "o3", "o4", "o5", "o7",
+	  "g2", "g3", "g4", "g5", "g7",
+	  "memory", "cc");
+	if (unlikely(l < 0))
+		return CSUM_FAULT;
+	return to_wsum_fault((__force __wsum)ret);
 }
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index d6b59461e064..0e3041ca384b 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -39,8 +39,8 @@ __wsum csum_partial(const void * buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len);
+__wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len);
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
  * the majority of the time.
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 66eda40fce36..546968db199d 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -454,4 +454,4 @@ ccslow:	cmp	%g1, 0
 
 cc_fault:
 	retl
-	 clr	%o0
+	 mov -1, %g1
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index f968e83bc93b..9312d51367d3 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -71,7 +71,7 @@
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
-	mov		-1, %o3
+	clr		%o3
 	clr		%o4
 	andcc		%g1, 0x3, %g0
 	bne,pn		%icc, 95f
diff --git a/arch/sparc/lib/csum_copy_from_user.S b/arch/sparc/lib/csum_copy_from_user.S
index b0ba8d4dd439..d74241692f0f 100644
--- a/arch/sparc/lib/csum_copy_from_user.S
+++ b/arch/sparc/lib/csum_copy_from_user.S
@@ -9,7 +9,7 @@
 	.section .fixup, "ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	0, %o0;		\
+	 mov	-1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
diff --git a/arch/sparc/lib/csum_copy_to_user.S b/arch/sparc/lib/csum_copy_to_user.S
index 91ba36dbf7d2..2878a933d7ab 100644
--- a/arch/sparc/lib/csum_copy_to_user.S
+++ b/arch/sparc/lib/csum_copy_to_user.S
@@ -9,7 +9,7 @@
 	.section .fixup,"ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	0, %o0;		\
+	 mov	-1, %o0;	\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 17da95387997..65ca3448e83d 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -27,7 +27,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
 /*
  *	Note: when you get a NULL pointer exception here this means someone
@@ -38,17 +38,17 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
  */
 static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 
-static inline __wsum csum_and_copy_from_user(const void __user *src,
+static inline __wsum_fault csum_and_copy_from_user(const void __user *src,
 					     void *dst, int len)
 {
-	__wsum ret;
+	__wsum_fault ret;
 
 	might_sleep();
 	if (!user_access_begin(src, len))
-		return 0;
+		return CSUM_FAULT;
 	ret = csum_partial_copy_generic((__force void *)src, dst, len);
 	user_access_end();
 
@@ -168,15 +168,15 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 /*
  *	Copy and checksum to user
  */
-static inline __wsum csum_and_copy_to_user(const void *src,
+static inline __wsum_fault csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len)
 {
-	__wsum ret;
+	__wsum_fault ret;
 
 	might_sleep();
 	if (!user_access_begin(dst, len))
-		return 0;
+		return CSUM_FAULT;
 
 	ret = csum_partial_copy_generic(src, (__force void *)dst, len);
 	user_access_end();
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 4d4a47a3a8ab..23c56eef8e47 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -129,10 +129,10 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
 /* Do not call this directly. Use the wrappers below */
-extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+extern __visible __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
+extern __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len);
+extern __wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /**
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 68f7fa3e1322..7b4047429f1d 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -262,7 +262,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst,
 
 #define EXC(y...)						\
 	9999: y;						\
-	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLEAR_AX)
+	_ASM_EXTABLE_TYPE(9999b, 9f, EX_TYPE_UACCESS)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -278,7 +278,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movl ARGBASE+4(%esp),%esi	# src
 	movl ARGBASE+8(%esp),%edi	# dst
 
-	movl $-1, %eax			# sum
+	xorl %eax,%eax			# sum
 	testl $2, %edi			# Check alignment. 
 	jz 2f				# Jump if alignment is ok.
 	subl $2, %ecx			# Alignment uses up two bytes.
@@ -357,12 +357,17 @@ EXC(	movb %cl, (%edi)	)
 6:	addl %ecx, %eax
 	adcl $0, %eax
 7:
-
+	xorl %edx, %edx
+8:
 	popl %ebx
 	popl %esi
 	popl %edi
 	popl %ecx			# equivalent to addl $4,%esp
 	RET
+9:
+	movl $-1,%eax
+	movl $-1,%edx
+	jmp 8b
 SYM_FUNC_END(csum_partial_copy_generic)
 
 #else
@@ -388,7 +393,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movl ARGBASE+4(%esp),%esi	#src
 	movl ARGBASE+8(%esp),%edi	#dst	
 	movl ARGBASE+12(%esp),%ecx	#len
-	movl $-1, %eax			#sum
+	xorl %eax, %eax			#sum
 #	movl %ecx, %edx  
 	movl %ecx, %ebx  
 	movl %esi, %edx
@@ -430,11 +435,16 @@ EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
-
+	xorl %edx, %edx
+8:
 	popl %esi
 	popl %edi
 	popl %ebx
 	RET
+9:
+	movl $-1,%eax
+	movl $-1,%edx
+	jmp 8b
 SYM_FUNC_END(csum_partial_copy_generic)
 				
 #undef ROUND
diff --git a/arch/x86/lib/csum-copy_64.S b/arch/x86/lib/csum-copy_64.S
index d9e16a2cf285..084181030dd3 100644
--- a/arch/x86/lib/csum-copy_64.S
+++ b/arch/x86/lib/csum-copy_64.S
@@ -44,7 +44,7 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	movq  %r13, 3*8(%rsp)
 	movq  %r15, 4*8(%rsp)
 
-	movl  $-1, %eax
+	xorl  %eax, %eax
 	xorl  %r9d, %r9d
 	movl  %edx, %ecx
 	cmpl  $8, %ecx
@@ -249,8 +249,8 @@ SYM_FUNC_START(csum_partial_copy_generic)
 	roll $8, %eax
 	jmp .Lout
 
-	/* Exception: just return 0 */
+	/* Exception: just return -1 */
 .Lfault:
-	xorl %eax, %eax
+	movq -1, %rax
 	jmp  .Lout
 SYM_FUNC_END(csum_partial_copy_generic)
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 03251664462a..da3158416572 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -15,17 +15,17 @@
  * @dst: destination address
  * @len: number of bytes to be copied.
  *
- * Returns an 32bit unfolded checksum of the buffer.
+ * Returns an 32bit unfolded checksum of the buffer or -1ULL on error
  * src and dst are best aligned to 64bits.
  */
-__wsum
+__wsum_fault
 csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	__wsum sum;
+	__wsum_fault sum;
 
 	might_sleep();
 	if (!user_access_begin(src, len))
-		return 0;
+		return CSUM_FAULT;
 	sum = csum_partial_copy_generic((__force const void *)src, dst, len);
 	user_access_end();
 	return sum;
@@ -37,17 +37,17 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
  *
- * Returns an 32bit unfolded checksum of the buffer.
+ * Returns an 32bit unfolded checksum of the buffer or -1ULL on error
  * src and dst are best aligned to 64bits.
  */
-__wsum
+__wsum_fault
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	__wsum sum;
+	__wsum_fault sum;
 
 	might_sleep();
 	if (!user_access_begin(dst, len))
-		return 0;
+		return CSUM_FAULT;
 	sum = csum_partial_copy_generic(src, (void __force *)dst, len);
 	user_access_end();
 	return sum;
@@ -64,7 +64,7 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 44ec1d0b2a35..bf4ee4fd8f57 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -37,7 +37,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+asmlinkage __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 /*
@@ -47,16 +47,16 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len)
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
+__wsum_fault csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len)
 {
 	if (!access_ok(src, len))
-		return 0;
+		return CSUM_FAULT;
 	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
@@ -237,11 +237,11 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
+static __inline__ __wsum_fault csum_and_copy_to_user(const void *src,
 					       void __user *dst, int len)
 {
 	if (!access_ok(dst, len))
-		return 0;
+		return CSUM_FAULT;
 	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif
diff --git a/arch/xtensa/lib/checksum.S b/arch/xtensa/lib/checksum.S
index ffee6f94c8f8..71a70bed4618 100644
--- a/arch/xtensa/lib/checksum.S
+++ b/arch/xtensa/lib/checksum.S
@@ -192,7 +192,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
 ENTRY(csum_partial_copy_generic)
 
 	abi_entry_default
-	movi	a5, -1
+	movi	a5, 0
 	or	a10, a2, a3
 
 	/* We optimize the following alignment tests for the 4-byte
@@ -311,6 +311,7 @@ EX(10f)	s8i	a9, a3, 0
 	ONES_ADD(a5, a9)
 8:
 	mov	a2, a5
+	movi	a3, 0
 	abi_ret_default
 
 5:
@@ -353,7 +354,8 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
 # Exception handler:
 .section .fixup, "ax"
 10:
-	movi	a2, 0
+	movi	a2, -1
+	movi	a3, -1
 	abi_ret_default
 
 .previous
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 5bf7dcebb5c2..21a3b5c4e25a 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -18,6 +18,38 @@
 #include <linux/errno.h>
 #include <linux/bitops.h>
 #include <asm/byteorder.h>
+
+typedef u64 __bitwise __wsum_fault;
+
+static inline __wsum_fault to_wsum_fault(__wsum v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return (__force __wsum_fault)v;
+#else
+	return (__force __wsum_fault)((__force u64)v << 32);
+#endif
+}
+
+static inline __wsum from_wsum_fault(__wsum_fault v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return (__force __wsum)v;
+#else
+	return (__force __wsum)((__force u64)v >> 32);
+#endif
+}
+
+static inline bool wsum_is_fault(__wsum_fault v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return unlikely((__force u64)v & (1ULL << 63));
+#else
+	return unlikely((__force u32)v & (1U << 31));
+#endif
+}
+
+#define CSUM_FAULT ((__force __wsum_fault)-1)
+
 #include <asm/checksum.h>
 #if !defined(_HAVE_ARCH_COPY_AND_CSUM_FROM_USER) || !defined(HAVE_CSUM_COPY_USER)
 #include <linux/uaccess.h>
@@ -25,24 +57,24 @@
 
 #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static __always_inline
-__wsum csum_and_copy_from_user (const void __user *src, void *dst,
+__wsum_fault csum_and_copy_from_user (const void __user *src, void *dst,
 				      int len)
 {
 	if (copy_from_user(dst, src, len))
-		return 0;
-	return csum_partial(dst, len, ~0U);
+		return CSUM_FAULT;
+	return to_wsum_fault(csum_partial(dst, len, 0));
 }
 #endif
 
 #ifndef HAVE_CSUM_COPY_USER
-static __always_inline __wsum csum_and_copy_to_user
+static __always_inline __wsum_fault csum_and_copy_to_user
 (const void *src, void __user *dst, int len)
 {
-	__wsum sum = csum_partial(src, len, ~0U);
+	__wsum sum = csum_partial(src, len, 0);
 
 	if (copy_to_user(dst, src, len) == 0)
-		return sum;
-	return 0;
+		return to_wsum_fault(sum);
+	return CSUM_FAULT;
 }
 #endif
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 103d46fa0eeb..a0d3701665d9 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -739,11 +739,11 @@ static __always_inline
 size_t copy_to_user_iter_csum(void __user *iter_to, size_t progress,
 			      size_t len, void *from, void *priv2)
 {
-	__wsum next, *csum = priv2;
+	__wsum *csum = priv2;
+	__wsum_fault next = csum_and_copy_to_user(from + progress, iter_to, len);
 
-	next = csum_and_copy_to_user(from + progress, iter_to, len);
-	*csum = csum_block_add(*csum, next, progress);
-	return next ? 0 : len;
+	*csum = csum_block_add(*csum, from_wsum_fault(next), progress);
+	return !wsum_is_fault(next) ? 0 : len;
 }
 
 static __always_inline
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..2aed0bffa88b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6965,11 +6965,11 @@ static __always_inline
 size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
 				size_t len, void *to, void *priv2)
 {
-	__wsum next, *csum = priv2;
+	__wsum *csum = priv2;
+	__wsum_fault next = csum_and_copy_from_user(iter_from, to + progress, len);
 
-	next = csum_and_copy_from_user(iter_from, to + progress, len);
-	*csum = csum_block_add(*csum, next, progress);
-	return next ? 0 : len;
+	*csum = csum_block_add(*csum, from_wsum_fault(next), progress);
+	return !wsum_is_fault(next) ? 0 : len;
 }
 
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
-- 
2.39.2


