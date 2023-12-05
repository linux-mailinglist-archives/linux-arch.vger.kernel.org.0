Return-Path: <linux-arch+bounces-677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0090A8044B1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309A31C20C3D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDB6AD7;
	Tue,  5 Dec 2023 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iZtdp/lq"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5C138;
	Mon,  4 Dec 2023 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZCMPofc2KEJbmEAnz7UaJiKj4wW96HZw4tHcbX9kqo4=; b=iZtdp/lqVhW6ovhpzIMykdHDI2
	l6r8tK5+5noZQXY+3M4bVwREPqN+1cxk5jKvVGyLBjFVpL8Ccs+MKi+7nT9Ws09smhv+yPwh8AqTi
	3ndOhJLkrkxKOTG15fJ9jEzFlL4ti5QaQAWnYxsZmjIIqvA17+WV7vVWqamYywHknFRyIxUYRYRDM
	Mm1DLFtIP7Hf/XiAlcYUtGDEP5XGy567znv8fejj3AkdNyKlHMmdBRnF0Kgaau/8/8fOeZY6Z7b9D
	UeroVeubkRoCzDeCo41j4VGHEIZgl59Hz4MrB1Y1nXSCejQQ2qc12CNOJNOBaXNfnIBADWSrACYl4
	MtIM+1+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6m-00794Q-1J;
	Tue, 05 Dec 2023 02:24:24 +0000
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
Subject: [PATCH v2 18/18] uml/x86: use normal x86 checksum.h
Date: Tue,  5 Dec 2023 02:24:18 +0000
Message-Id: <20231205022418.1703007-27-viro@zeniv.linux.org.uk>
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

The only difference left is that UML really does *NOT* want the
csum-and-uaccess combinations; leave those in
arch/x86/include/asm/checksum_{32,64}, move the rest into
arch/x86/include/asm/checksum.h (under ifdefs) and that's
pretty much it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    |  63 ++++++++++++++-
 arch/x86/include/asm/checksum_32.h |  25 ------
 arch/x86/include/asm/checksum_64.h |  25 ------
 arch/x86/um/asm/checksum.h         | 125 -----------------------------
 arch/x86/um/asm/checksum_32.h      |  33 --------
 arch/x86/um/asm/checksum_64.h      |  17 ----
 6 files changed, 60 insertions(+), 228 deletions(-)
 delete mode 100644 arch/x86/um/asm/checksum.h
 delete mode 100644 arch/x86/um/asm/checksum_32.h
 delete mode 100644 arch/x86/um/asm/checksum_64.h

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 05dd4c59880a..e8fb8167f52a 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -22,9 +22,6 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
 #ifdef CONFIG_GENERIC_CSUM
 # include <asm-generic/checksum.h>
 #else
-# define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
-# define HAVE_CSUM_COPY_USER
-# define _HAVE_ARCH_CSUM_AND_COPY
 
 /**
  * csum_partial - Compute an internet checksum.
@@ -124,10 +121,70 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return (__force __sum16)sum;
 }
 
+struct in6_addr;
+
+# ifdef CONFIG_X86_32
+
+#define _HAVE_ARCH_IPV6_CSUM
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+				      __u32 len, __u8 proto, __wsum sum)
+{
+	asm("addl 0(%1), %0	;\n"
+	    "adcl 4(%1), %0	;\n"
+	    "adcl 8(%1), %0	;\n"
+	    "adcl 12(%1), %0	;\n"
+	    "adcl 0(%2), %0	;\n"
+	    "adcl 4(%2), %0	;\n"
+	    "adcl 8(%2), %0	;\n"
+	    "adcl 12(%2), %0	;\n"
+	    "adcl %3, %0	;\n"
+	    "adcl %4, %0	;\n"
+	    "adcl $0, %0	;\n"
+	    : "=&r" (sum)
+	    : "r" (saddr), "r" (daddr),
+	      "r" (htonl(len)), "r" (htonl(proto)), "0" (sum)
+	    : "memory");
+
+	return csum_fold(sum);
+}
+# else
+
+#define _HAVE_IP_COMPUTE_CSUM
+
+/**
+ * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
+ * @saddr: source address
+ * @daddr: destination address
+ * @len: length of packet
+ * @proto: protocol of packet
+ * @sum: initial sum (32bit unfolded) to be added in
+ *
+ * Computes an IPv6 pseudo header checksum. This sum is added the checksum
+ * into UDP/TCP packets and contains some link layer information.
+ * Returns the unfolded 32bit checksum.
+ */
+
+#define _HAVE_ARCH_IPV6_CSUM 1
+extern __sum16
+csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
+		__u32 len, __u8 proto, __wsum sum);
+# endif
+
+#ifndef CONFIG_UML
+/*
+ * UML uaccess is better done in large chunks, so combining csum with
+ * copyin/copyout is not worth the trouble.
+ */
+# define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
+# define HAVE_CSUM_COPY_USER
+# define _HAVE_ARCH_CSUM_AND_COPY
 # ifdef CONFIG_X86_32
 #  include <asm/checksum_32.h>
 # else
 #  include <asm/checksum_64.h>
 # endif
+#endif
+
 #endif
 #endif
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 164bf98fb23a..f0e8ef27f220 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_CHECKSUM_32_H
 #define _ASM_X86_CHECKSUM_32_H
 
-#include <linux/in6.h>
 #include <linux/uaccess.h>
 
 /*
@@ -41,30 +40,6 @@ static inline __wsum_fault csum_and_copy_from_user(const void __user *src,
 	return ret;
 }
 
-#define _HAVE_ARCH_IPV6_CSUM
-static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-				      const struct in6_addr *daddr,
-				      __u32 len, __u8 proto, __wsum sum)
-{
-	asm("addl 0(%1), %0	;\n"
-	    "adcl 4(%1), %0	;\n"
-	    "adcl 8(%1), %0	;\n"
-	    "adcl 12(%1), %0	;\n"
-	    "adcl 0(%2), %0	;\n"
-	    "adcl 4(%2), %0	;\n"
-	    "adcl 8(%2), %0	;\n"
-	    "adcl 12(%2), %0	;\n"
-	    "adcl %3, %0	;\n"
-	    "adcl %4, %0	;\n"
-	    "adcl $0, %0	;\n"
-	    : "=&r" (sum)
-	    : "r" (saddr), "r" (daddr),
-	      "r" (htonl(len)), "r" (htonl(proto)), "0" (sum)
-	    : "memory");
-
-	return csum_fold(sum);
-}
-
 /*
  *	Copy and checksum to user
  */
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index ce28f7c0bc29..027d86a9fa3f 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -8,9 +8,6 @@
  * with some code from asm-x86/checksum.h
  */
 
-#include <linux/compiler.h>
-#include <asm/byteorder.h>
-
 /* Do not call this directly. Use the wrappers below */
 extern __visible __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
@@ -18,26 +15,4 @@ extern __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, i
 extern __wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
-#define _HAVE_IP_COMPUTE_CSUM
-
-/**
- * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
- * @saddr: source address
- * @daddr: destination address
- * @len: length of packet
- * @proto: protocol of packet
- * @sum: initial sum (32bit unfolded) to be added in
- *
- * Computes an IPv6 pseudo header checksum. This sum is added the checksum
- * into UDP/TCP packets and contains some link layer information.
- * Returns the unfolded 32bit checksum.
- */
-
-struct in6_addr;
-
-#define _HAVE_ARCH_IPV6_CSUM 1
-extern __sum16
-csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
-		__u32 len, __u8 proto, __wsum sum);
-
 #endif /* _ASM_X86_CHECKSUM_64_H */
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
deleted file mode 100644
index 0986c19e5ff0..000000000000
--- a/arch/x86/um/asm/checksum.h
+++ /dev/null
@@ -1,125 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_CHECKSUM_H
-#define __UM_CHECKSUM_H
-
-#include <linux/string.h>
-#include <linux/in6.h>
-#include <linux/uaccess.h>
-
-static inline unsigned add32_with_carry(unsigned a, unsigned b)
-{
-	asm("addl %2,%0\n\t"
-	    "adcl $0,%0"
-	    : "=r" (a)
-	    : "0" (a), "rm" (b));
-	return a;
-}
-
-/* note: with gcc-8 or later generic csum_add() yields the same code */
-#define HAVE_ARCH_CSUM_ADD
-static inline __wsum csum_add(__wsum csum, __wsum addend)
-{
-	return (__force __wsum)add32_with_carry((__force unsigned)csum,
-						(__force unsigned)addend);
-}
-
-/*
- * computes the checksum of a memory block at buff, length len,
- * and adds in "sum" (32-bit)
- *
- * returns a 32-bit number suitable for feeding into itself
- * or csum_tcpudp_magic
- *
- * this function must be called with even lengths, except
- * for the last fragment, which may be odd
- *
- * it's best to have buff aligned on a 32-bit boundary
- */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-
-/**
- * csum_fold - Fold and invert a 32bit checksum.
- * sum: 32bit unfolded sum
- *
- * Fold a 32bit running checksum to 16bit and invert it. This is usually
- * the last step before putting a checksum into a packet.
- * Make sure not to mix with 64bit checksums.
- */
-static inline __sum16 csum_fold(__wsum sum)
-{
-	__asm__(
-		"  addl %1,%0\n"
-		"  adcl $0xffff,%0"
-		: "=r" (sum)
-		: "r" ((__force u32)sum << 16),
-		  "0" ((__force u32)sum & 0xffff0000)
-	);
-	return (__force __sum16)(~(__force u32)sum >> 16);
-}
-
-/**
- * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
- * @saddr: source address
- * @daddr: destination address
- * @len: length of packet
- * @proto: ip protocol of packet
- * @sum: initial sum to be added in (32bit unfolded)
- *
- * Returns the pseudo header checksum the input data. Result is
- * 32bit unfolded.
- */
-static inline __wsum
-csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
-		  __u8 proto, __wsum sum)
-{
-	asm("  addl %1, %0\n"
-	    "  adcl %2, %0\n"
-	    "  adcl %3, %0\n"
-	    "  adcl $0, %0\n"
-		: "=r" (sum)
-	    : "g" (daddr), "g" (saddr), "g" ((len + proto) << 8), "0" (sum));
-	return sum;
-}
-
-/**
- * ip_fast_csum - Compute the IPv4 header checksum efficiently.
- * iph: ipv4 header
- * ihl: length of header / 4
- */
-static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
-{
-	unsigned int sum;
-
-	asm(	"  movl (%1), %0\n"
-		"  subl $4, %2\n"
-		"  jbe 2f\n"
-		"  addl 4(%1), %0\n"
-		"  adcl 8(%1), %0\n"
-		"  adcl 12(%1), %0\n"
-		"1: adcl 16(%1), %0\n"
-		"  lea 4(%1), %1\n"
-		"  decl %2\n"
-		"  jne	1b\n"
-		"  adcl $0, %0\n"
-		"  movl %0, %2\n"
-		"  shrl $16, %0\n"
-		"  addw %w2, %w0\n"
-		"  adcl $0, %0\n"
-		"  notl %0\n"
-		"2:"
-	/* Since the input registers which are loaded with iph and ipl
-	   are modified, we must also specify them as outputs, or gcc
-	   will assume they contain their original values. */
-	: "=r" (sum), "=r" (iph), "=r" (ihl)
-	: "1" (iph), "2" (ihl)
-	: "memory");
-	return (__force __sum16)sum;
-}
-
-#ifdef CONFIG_X86_32
-# include "checksum_32.h"
-#else
-# include "checksum_64.h"
-#endif
-
-#endif
diff --git a/arch/x86/um/asm/checksum_32.h b/arch/x86/um/asm/checksum_32.h
deleted file mode 100644
index c5820c5d819b..000000000000
--- a/arch/x86/um/asm/checksum_32.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Licensed under the GPL
- */
-
-#ifndef __UM_SYSDEP_CHECKSUM_H
-#define __UM_SYSDEP_CHECKSUM_H
-
-#define _HAVE_ARCH_IPV6_CSUM
-static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-					  const struct in6_addr *daddr,
-					  __u32 len, __u8 proto,
-					  __wsum sum)
-{
-	__asm__(
-		"addl 0(%1), %0		;\n"
-		"adcl 4(%1), %0		;\n"
-		"adcl 8(%1), %0		;\n"
-		"adcl 12(%1), %0	;\n"
-		"adcl 0(%2), %0		;\n"
-		"adcl 4(%2), %0		;\n"
-		"adcl 8(%2), %0		;\n"
-		"adcl 12(%2), %0	;\n"
-		"adcl %3, %0		;\n"
-		"adcl %4, %0		;\n"
-		"adcl $0, %0		;\n"
-		: "=&r" (sum)
-		: "r" (saddr), "r" (daddr),
-		  "r"(htonl(len)), "r"(htonl(proto)), "0"(sum));
-
-	return csum_fold(sum);
-}
-
-#endif
diff --git a/arch/x86/um/asm/checksum_64.h b/arch/x86/um/asm/checksum_64.h
deleted file mode 100644
index 228424a52b7f..000000000000
--- a/arch/x86/um/asm/checksum_64.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Licensed under the GPL
- */
-
-#ifndef __UM_SYSDEP_CHECKSUM_H
-#define __UM_SYSDEP_CHECKSUM_H
-
-#define _HAVE_IP_COMPUTE_CSUM
-
-struct in6_addr;
-
-#define _HAVE_ARCH_IPV6_CSUM 1
-extern __sum16
-csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
-		__u32 len, __u8 proto, __wsum sum);
-
-#endif
-- 
2.39.2


