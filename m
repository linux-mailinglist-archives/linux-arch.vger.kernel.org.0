Return-Path: <linux-arch+bounces-678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBFC8044B3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF22F1C20B21
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B296FAF;
	Tue,  5 Dec 2023 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mPJx6ea8"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC3C136;
	Mon,  4 Dec 2023 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w69zjgaxFJQbH1/ONj8McE50176zxtKRnbYIHlWVN5w=; b=mPJx6ea8oysK7tXYQlQso0iNu3
	QNqxLTplWTnXH7JcjgChAJqb8ktoawBN0Wg3Q6iZf26dg2nXOTF6JmRm3n7D4TtaA3hWA1J2+9z5W
	sAxKvkZ9ytFirqfPJFn2OV9qBhxgPI5415JUCo106lcM5fGnW8WXf3HM4Hv+EtKBcCsEkr2ZUtzrt
	xInbDCw6pntBUv46kgFdCjBWD5NblNaZ44rcUNEItc+USpKs8qFi9dVIXDJwF6JuYxLqyijwUsGsM
	S0QEjt09L0/6UoA5L6hk+A7uGB/dzFdW3c0Zy7OY7TPW56TwEENnmxcXWueYoQBXm9HbsmNZZucCX
	Ow9SY0Dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6i-00792h-38;
	Tue, 05 Dec 2023 02:24:21 +0000
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
Subject: [PATCH v2 07/18] consolidate default ip_compute_csum()
Date: Tue,  5 Dec 2023 02:24:04 +0000
Message-Id: <20231205022418.1703007-13-viro@zeniv.linux.org.uk>
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

... and take it into include/net/checksum.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h    |  8 +-------
 arch/arm/include/asm/checksum.h      | 10 ----------
 arch/m68k/include/asm/checksum.h     | 10 ----------
 arch/mips/include/asm/checksum.h     |  9 ---------
 arch/parisc/include/asm/checksum.h   | 10 ----------
 arch/powerpc/include/asm/checksum.h  |  9 ---------
 arch/s390/include/asm/checksum.h     |  8 --------
 arch/sh/include/asm/checksum_32.h    |  9 ---------
 arch/sparc/include/asm/checksum_32.h |  6 ------
 arch/sparc/include/asm/checksum_64.h |  6 ------
 arch/x86/include/asm/checksum_32.h   | 10 ----------
 arch/x86/include/asm/checksum_64.h   | 10 +---------
 arch/x86/um/asm/checksum_32.h        |  5 -----
 arch/x86/um/asm/checksum_64.h        |  4 ++--
 arch/xtensa/include/asm/checksum.h   | 10 ----------
 include/asm-generic/checksum.h       |  8 +++-----
 include/net/checksum.h               | 17 +++++++++++++++++
 17 files changed, 24 insertions(+), 125 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index bc6a47e46fed..0d7c21a79961 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -42,13 +42,7 @@ __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
-
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-
-extern __sum16 ip_compute_csum(const void *buff, int len);
+#define _HAVE_IP_COMPUTE_CSUM
 
 /*
  *	Fold a partial checksum without adding pseudo headers
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 23c8ef0311cf..f5ca8aac5eda 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -130,16 +130,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 	return sum;
 }	
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16
-ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 extern __wsum
 __csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr, __be32 len,
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 3462a42b6fec..9979f5728d70 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -93,16 +93,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, unsigned short len,
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold (csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ __sum16
 csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 3dfe9eca4adc..1e49fd107da1 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -170,15 +170,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 }
 #define csum_tcpudp_nofold csum_tcpudp_nofold
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 62a390297414..6ddd591e9dde 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -85,16 +85,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16 ip_compute_csum(const void *buf, int len)
-{
-	 return csum_fold (csum_partial(buf, len, 0));
-}
-
-
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 5925eaff6b8b..910a3a71e3ae 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -193,15 +193,6 @@ static __always_inline __wsum csum_partial(const void *buff, int len, __wsum sum
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 23b9840ed640..49c509a23b8a 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -91,14 +91,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 	return (__force __wsum)(csum >> 32);
 }
 
-/*
- * Used for miscellaneous IP-like checksums, mainly icmp.
- */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 				      const struct in6_addr *daddr,
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 7b91b7b6c1e9..77e89f308ad5 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -134,15 +134,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-    return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 				      const struct in6_addr *daddr,
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index e53331114217..e0322970ad83 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -208,12 +208,6 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-/* this routine is used for miscellaneous IP-like checksums, mainly in icmp.c */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define HAVE_ARCH_CSUM_ADD
 static inline __wsum csum_add(__wsum csum, __wsum addend)
 {
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index 70f88abd93a1..e4cca92cecd6 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -112,12 +112,6 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-/* this routine is used for miscellaneous IP-like checksums, mainly in icmp.c */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define HAVE_ARCH_CSUM_ADD
 static inline __wsum csum_add(__wsum csum, __wsum addend)
 {
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 4521474a08ab..7570bdff7dea 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -120,16 +120,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-    return csum_fold(csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 				      const struct in6_addr *daddr,
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 84e26b8c0af5..2bd75710eea1 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -117,15 +117,7 @@ extern __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, i
 extern __wsum_fault csum_and_copy_to_user(const void *src, void __user *dst, int len);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
-/**
- * ip_compute_csum - Compute an 16bit IP checksum.
- * @buff: buffer address.
- * @len: length of buffer.
- *
- * Returns the 16bit folded/inverted checksum of the passed buffer.
- * Ready to fill in.
- */
-extern __sum16 ip_compute_csum(const void *buff, int len);
+#define _HAVE_IP_COMPUTE_CSUM
 
 /**
  * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
diff --git a/arch/x86/um/asm/checksum_32.h b/arch/x86/um/asm/checksum_32.h
index 0b13c2947ad1..c5820c5d819b 100644
--- a/arch/x86/um/asm/checksum_32.h
+++ b/arch/x86/um/asm/checksum_32.h
@@ -5,11 +5,6 @@
 #ifndef __UM_SYSDEP_CHECKSUM_H
 #define __UM_SYSDEP_CHECKSUM_H
 
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-    return csum_fold (csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
diff --git a/arch/x86/um/asm/checksum_64.h b/arch/x86/um/asm/checksum_64.h
index 7b6cd1921573..fd1ab07e4a4c 100644
--- a/arch/x86/um/asm/checksum_64.h
+++ b/arch/x86/um/asm/checksum_64.h
@@ -5,6 +5,8 @@
 #ifndef __UM_SYSDEP_CHECKSUM_H
 #define __UM_SYSDEP_CHECKSUM_H
 
+#define _HAVE_IP_COMPUTE_CSUM
+
 static inline unsigned add32_with_carry(unsigned a, unsigned b)
 {
         asm("addl %2,%0\n\t"
@@ -14,6 +16,4 @@ static inline unsigned add32_with_carry(unsigned a, unsigned b)
         return a;
 }
 
-extern __sum16 ip_compute_csum(const void *buff, int len);
-
 #endif
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index d1b0e8dac1a5..9fa7664a60c0 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -149,16 +149,6 @@ static __inline__ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-
-static __inline__ __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold (csum_partial(buff, len, 0));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 					  const struct in6_addr *daddr,
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 797316e34d15..cbc06ac7829f 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -47,10 +47,8 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 		   __u8 proto, __wsum sum);
 #endif
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-extern __sum16 ip_compute_csum(const void *buff, int len);
+#ifdef CONFIG_GENERIC_CSUM
+#define _HAVE_IP_COMPUTE_CSUM
+#endif
 
 #endif /* __ASM_GENERIC_CHECKSUM_H */
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 706c5fb287cc..078ec71368fa 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -55,6 +55,23 @@ static inline bool wsum_is_fault(__wsum_fault v)
 #include <linux/uaccess.h>
 #endif
 
+/**
+ * ip_compute_csum - Compute an 16bit IP checksum.
+ * @buff: buffer address.
+ * @len: length of buffer.
+ *
+ * Returns the 16bit folded/inverted checksum of the passed buffer.
+ * Ready to fill in.
+ */
+#ifndef _HAVE_IP_COMPUTE_CSUM
+static inline __sum16 ip_compute_csum(const void *buff, int len)
+{
+	return csum_fold (csum_partial(buff, len, 0));
+}
+#else
+extern __sum16 ip_compute_csum(const void *buff, int len);
+#endif
+
 /*
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 16-bit checksum, already complemented
-- 
2.39.2


