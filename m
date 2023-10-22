Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABBC7D25AC
	for <lists+linux-arch@lfdr.de>; Sun, 22 Oct 2023 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjJVTq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Oct 2023 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVTq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Oct 2023 15:46:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43352EE;
        Sun, 22 Oct 2023 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xPiLUxU2U8e/9yv2aodnlynTGMAbarGa9WinOZ+Kyso=; b=apg2y4w9Dt6/HXTmfqNSPHnovP
        /KhOjUO0GY15DWNYXYY4rb5qAqqQOJsmM/OX0gWcypUKbIyWyYtuZX9jCK8dCC+JuH5AlDk2qsEMR
        xDYSxd4NNSkYDJhGV0zFpeoSwJeF2yS7Q1g6SzWpgD8e+ZG/NaLK6CtUKxGxXdz/poU0ZH1R+Xsgw
        FjQkuBTQYJprFPr6Y8eIuza1H5SSSKxKfnm0oPmi6lxnDw9j+QZnNnmqOl3be63mflrh2U/0eSjJR
        UIES6XJjSha2/JSyOTdOdFBUTF+j7DdQNEJICDfb1y06DMMkbLzFr05edreqf4IrLggszuQLhwwwy
        OvJTrMlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1queOw-0045NN-2k;
        Sun, 22 Oct 2023 19:46:18 +0000
Date:   Sun, 22 Oct 2023 20:46:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231022194618.GC800259@ZenIV>
References: <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022194020.GA972254@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 22, 2023 at 08:40:20PM +0100, Al Viro wrote:
> On Sat, Oct 21, 2023 at 11:22:03PM +0100, Al Viro wrote:
> > On Sat, Oct 21, 2023 at 08:15:25AM +0100, Al Viro wrote:
> > 
> > > I don't think -rc7 is a good time for that, though.  At the
> > > very least it needs a review on linux-arch - I think I hadn't
> > > fucked the ABI for returning u64 up, but...
> > > 
> > > Anyway, completely untested patch follows:
> > 
> > ... and now something that at least builds (with some brainos fixed); it's still
> > slightly suboptimal representation on big-endian 32bit - there it would be better to
> > have have the csum in upper half of the 64bit getting returned and use the lower
> > half as fault indicator, but dealing with that cleanly takes some massage of
> > includes in several places, so I'd left that alone for now.  In any case, the
> > overhead of that is pretty much noise.
> 
> OK, here's what I have in mind for the next cycle.  It's still untested (builds,
> but that's it).  Conversion to including <net/checksum.h> rather than
> <asm/checksum.h> is going to get carved out into a separate patch.
> I _think_ I've got the asm parts (and ABI for returning 64bit) right,
> but I would really appreciate review and testing.

Gyah....  What I got wrong is the lib/iov_iter.c part - check for faults is
backwards ;-/  Hopefully fixed variant follows:

diff --git a/arch/alpha/include/asm/asm-prototypes.h b/arch/alpha/include/asm/asm-prototypes.h
index c8ae46fc2e74..0cf90f406d00 100644
--- a/arch/alpha/include/asm/asm-prototypes.h
+++ b/arch/alpha/include/asm/asm-prototypes.h
@@ -1,10 +1,10 @@
 #include <linux/spinlock.h>
 
-#include <asm/checksum.h>
 #include <asm/console.h>
 #include <asm/page.h>
 #include <asm/string.h>
 #include <linux/uaccess.h>
+#include <net/checksum.h> // for csum_ipv6_magic()
 
 #include <asm-generic/asm-prototypes.h>
 
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
index 4d180d96f09e..5f75fcd19287 100644
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
+	return from64to16 (checksum);
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
+	return from64to16 (checksum);
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
+	return from64to16 (checksum);
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
+	return from64to16 (checksum);
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
index d8a13959bff0..2b9bddb50967 100644
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
+		return -1;
 
 	return csum_partial_copy_from_user(src, dst, len);
 }
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 82e96ac83684..d076a5c8556f 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/arm-smccc.h>
 
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/ftrace.h>
 
 /*
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
index 6928781e6bee..f273c9667914 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
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
diff --git a/arch/ia64/include/asm/asm-prototypes.h b/arch/ia64/include/asm/asm-prototypes.h
index a96689447a74..41d23ab53ff4 100644
--- a/arch/ia64/include/asm/asm-prototypes.h
+++ b/arch/ia64/include/asm/asm-prototypes.h
@@ -3,7 +3,7 @@
 #define _ASM_IA64_ASM_PROTOTYPES_H
 
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/esi.h>
 #include <asm/ftrace.h>
 #include <asm/page.h>
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
 
 
diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
index c892e173ec99..e5858b15cd37 100644
--- a/arch/microblaze/kernel/microblaze_ksyms.c
+++ b/arch/microblaze/kernel/microblaze_ksyms.c
@@ -10,7 +10,7 @@
 #include <linux/in6.h>
 #include <linux/syscalls.h>
 
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <asm/page.h>
diff --git a/arch/mips/include/asm/asm-prototypes.h b/arch/mips/include/asm/asm-prototypes.h
index 8e8fc38b0941..44fd0c30fd73 100644
--- a/arch/mips/include/asm/asm-prototypes.h
+++ b/arch/mips/include/asm/asm-prototypes.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/checksum.h>
 #include <asm/page.h>
 #include <asm/fpu.h>
 #include <asm-generic/asm-prototypes.h>
 #include <linux/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/mmu_context.h>
+#include <net/checksum.h>
 
 extern void clear_page_cpu(void *page);
 extern void copy_page_cpu(void *to, void *from);
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
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 212e5f85004c..a56dea4411ab 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -22,7 +22,7 @@
 
 #include <asm/processor.h>
 #include <linux/uaccess.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/io.h>
 #include <asm/hardirq.h>
 #include <asm/delay.h>
diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 274bce76f5da..c283183e5a81 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -11,7 +11,7 @@
 
 #include <linux/threads.h>
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <linux/uaccess.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/dcr.h>
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
index 1a14c8780278..a23482b9f3f0 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -8,16 +8,16 @@
 #include <linux/export.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <linux/uaccess.h>
 
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
 
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 05e51666db03..9bfd434d31e6 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -28,7 +28,7 @@
 #include <asm/cpcmd.h>
 #include <asm/ebcdic.h>
 #include <asm/sclp.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/debug.h>
 #include <asm/abs_lowcore.h>
 #include <asm/os_info.h>
diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
index 6e1824141b29..44447e3fef84 100644
--- a/arch/s390/kernel/os_info.c
+++ b/arch/s390/kernel/os_info.c
@@ -12,7 +12,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/abs_lowcore.h>
 #include <asm/os_info.h>
 #include <asm/maccess.h>
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
diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 5858936cb431..ce9d5547ac74 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -4,7 +4,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/sections.h>
 
 EXPORT_SYMBOL(memchr);
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
diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index 4987c735ff56..e15661bf8b36 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -4,7 +4,7 @@
  */
 
 #include <asm/xor.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/trap_block.h>
 #include <linux/uaccess.h>
 #include <asm/atomic.h>
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index ce11e0ad80c7..751b89d827aa 100644
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
+static inline __u64
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
index 84ad709cbecb..546968db199d 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
  * we only bother with faults on loads... */
 
 cc_fault:
-	ret
-	 clr	%o0
+	retl
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
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..655e25745349 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -4,7 +4,7 @@
 #include <linux/pgtable.h>
 #include <asm/string.h>
 #include <asm/page.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/mce.h>
 
 #include <asm-generic/asm-prototypes.h>
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
index 23318c338db0..ab58a528d846 100644
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
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf..5e877592a7b3 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -8,7 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/word-at-a-time.h>
 
 static inline unsigned short from32to16(unsigned a)
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 145f9a0bde29..e90ac389a013 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -4,7 +4,7 @@
  *
  * Wrappers of assembly checksum functions for x86-64.
  */
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <asm/smap.h>
@@ -14,20 +14,18 @@
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad source address.
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
@@ -38,20 +36,18 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad destination address.
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
@@ -62,14 +58,13 @@ csum_and_copy_to_user(const void *src, void __user *dst, int len)
  * @src: source address
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @sum: initial sum that is added into the result (32bit unfolded)
  *
  * Returns an 32bit unfolded checksum of the buffer.
  */
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len);
+	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
diff --git a/arch/xtensa/include/asm/asm-prototypes.h b/arch/xtensa/include/asm/asm-prototypes.h
index b0da61812b85..b01b8170fafb 100644
--- a/arch/xtensa/include/asm/asm-prototypes.h
+++ b/arch/xtensa/include/asm/asm-prototypes.h
@@ -3,7 +3,7 @@
 #define __ASM_PROTOTYPES_H
 
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/ftrace.h>
 #include <asm/page.h>
 #include <asm/string.h>
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
diff --git a/drivers/net/ethernet/brocade/bna/bnad.h b/drivers/net/ethernet/brocade/bna/bnad.h
index 627a93ce38ab..a3334ad8ecc8 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.h
+++ b/drivers/net/ethernet/brocade/bna/bnad.h
@@ -19,8 +19,6 @@
 #include <linux/firmware.h>
 #include <linux/if_vlan.h>
 
-/* Fix for IA64 */
-#include <asm/checksum.h>
 #include <net/ip6_checksum.h>
 
 #include <net/ip.h>
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index f5961bdcc480..a6e88d673878 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -27,8 +27,6 @@
 #include <linux/module.h>
 #include <linux/property.h>
 
-#include <asm/checksum.h>
-
 #include <lantiq_soc.h>
 #include <xway_dma.h>
 #include <lantiq_platform.h>
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 915aaf18c409..bef4cd73f06d 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -51,7 +51,6 @@
 #include <linux/ipv6.h>
 #include <linux/in.h>
 #include <linux/etherdevice.h>
-#include <asm/checksum.h>
 #include <linux/if_vlan.h>
 #include <linux/if_arp.h>
 #include <linux/inetdevice.h>
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index bc3be0330f1d..bcbff216fa5f 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -27,7 +27,7 @@
 #include <asm/debug.h>
 #include <asm/processor.h>
 #include <asm/irqflags.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/os_info.h>
 #include <asm/switch_to.h>
 #include <asm/maccess.h>
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e7..22c97902845d 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -16,8 +16,40 @@
 #define _CHECKSUM_H
 
 #include <linux/errno.h>
-#include <asm/types.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
+
+typedef u64 __bitwise __wsum_fault;
+static inline __wsum_fault to_wsum_fault(__wsum v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return (__force __wsum_fault)v;
+#else
+	return (__force __wsum_fault)((__force u64)v << 32);
+#endif
+}
+
+static inline __wsum_fault from_wsum_fault(__wsum v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return (__force __wsum)v;
+#else
+	return (__force __wsum)((__force u64)v >> 32);
+#endif
+}
+
+static inline bool wsum_fault_check(__wsum_fault v)
+{
+#if defined(CONFIG_64BIT) || defined(__LITTLE_ENDIAN__)
+	return (__force s64)v < 0;
+#else
+	return (int)(__force u32)v < 0;
+#endif
+}
+
+#define CSUM_FAULT ((__force __wsum_fault)-1)
+
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
 
diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index c8a96b888277..4666b9855263 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -25,7 +25,7 @@
 #include <asm/types.h>
 #include <asm/byteorder.h>
 #include <net/ip.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <linux/in6.h>
 #include <linux/tcp.h>
 #include <linux/ipv6.h>
diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
index 0eed92b77ba3..971e7824893b 100644
--- a/lib/checksum_kunit.c
+++ b/lib/checksum_kunit.c
@@ -4,7 +4,7 @@
  */
 
 #include <kunit/test.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 
 #define MAX_LEN 512
 #define MAX_ALIGN 64
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..0da8f36ce341 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1184,15 +1184,16 @@ EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-	__wsum sum, next;
+	__wsum sum;
+	__wsum_fault next;
 	sum = *csum;
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_from_user(base, addr + off, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
+		sum = csum_block_add(sum, from_wsum_fault(next), off);
+		likely(!wsum_fault_check(next)) ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(addr + off, base, len, sum, off);
 	})
@@ -1206,7 +1207,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 			     struct iov_iter *i)
 {
 	struct csum_state *csstate = _csstate;
-	__wsum sum, next;
+	__wsum sum;
+	__wsum_fault next;
 
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
@@ -1222,8 +1224,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	sum = csum_shift(csstate->csum, csstate->off);
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_to_user(addr + off, base, len);
-		sum = csum_block_add(sum, next, off);
-		next ? 0 : len;
+		sum = csum_block_add(sum, from_wsum_fault(next), off);
+		likely(!wsum_fault_check(next)) ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(base, addr + off, len, sum, off);
 	})
diff --git a/net/ipv6/ip6_checksum.c b/net/ipv6/ip6_checksum.c
index 377717045f8f..fce94af322ae 100644
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -2,7 +2,7 @@
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/udplite.h>
-#include <asm/checksum.h>
+#include <net/ip6_checksum.h>
 
 #ifndef _HAVE_ARCH_IPV6_CSUM
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
