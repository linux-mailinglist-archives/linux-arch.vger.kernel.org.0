Return-Path: <linux-arch+bounces-668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41938044A6
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1430C1C20B90
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2BE5683;
	Tue,  5 Dec 2023 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EsQvzff5"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31214109;
	Mon,  4 Dec 2023 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=l0dGY8wXvsX//CqlJQm1PUgK6SZc8G9gG8XPflzGv/A=; b=EsQvzff5Z4+poClGfhwfw52Q2S
	T3I0IPkeVDs22mWCJjFU9RpKeVFL8aCAol09icAXYTk7Jbo8wsPZEBTAOSA+eDFYs05mJ6sEbn5Wy
	xDYqUsaxcct6NQ3tY0A+NW4+pd8witM7VwpQZ5HlPJIs2/M0ChSov6yVZe/rHtq96QJ0sNWkOfkLT
	5TSZuVrBrx1CWrm4wMDtVPhM3hwtsPi3/ESoJtGWrbqMIfmQxFCGL8A5LN6DmUku0NZVATKVe+PSs
	fm9G64HeYWj6MxhfQ5enn46y11ZD6ks1vrwU9nYCrqaGpOGpAO3+cLYetcvvU3AQsC1rr1owKo6mM
	flC3bk9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6i-00792Y-1n;
	Tue, 05 Dec 2023 02:24:20 +0000
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
Subject: [PATCH v2 06/18] consolidate csum_tcpudp_magic(), take default variant into net/checksum.h
Date: Tue,  5 Dec 2023 02:24:02 +0000
Message-Id: <20231205022418.1703007-11-viro@zeniv.linux.org.uk>
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

now that nobody includes asm/checksum.h directly, we can just take that
thing (overridably) to net/checksum.h and be done with it, whether
asm-generic/checksum.h is used or not.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h    |  7 +------
 arch/arm/include/asm/checksum.h      | 11 -----------
 arch/hexagon/include/asm/checksum.h  |  4 +---
 arch/hexagon/kernel/hexagon_ksyms.c  |  1 -
 arch/hexagon/lib/checksum.c          |  1 +
 arch/m68k/include/asm/checksum.h     | 12 ------------
 arch/parisc/include/asm/checksum.h   | 11 -----------
 arch/powerpc/include/asm/checksum.h  | 10 ----------
 arch/s390/include/asm/checksum.h     | 10 ----------
 arch/sh/include/asm/checksum_32.h    | 11 -----------
 arch/sparc/include/asm/checksum_32.h | 11 -----------
 arch/sparc/include/asm/checksum_64.h | 11 -----------
 arch/x86/include/asm/checksum_32.h   | 11 -----------
 arch/x86/include/asm/checksum_64.h   | 18 ------------------
 arch/x86/um/asm/checksum.h           | 11 -----------
 arch/xtensa/include/asm/checksum.h   | 11 -----------
 include/asm-generic/checksum.h       |  9 ---------
 include/net/checksum.h               | 16 ++++++++++++++++
 18 files changed, 19 insertions(+), 157 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index d3abe290ae4e..bc6a47e46fed 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -10,12 +10,7 @@
  */
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-__sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-			  __u32 len, __u8 proto, __wsum sum);
+#define _HAVE_ARCH_CSUM_TCPUDP_MAGIC
 
 __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 			  __u32 len, __u8 proto, __wsum sum);
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index a295b0d037f0..23c8ef0311cf 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -129,17 +129,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 	}
 	return sum;
 }	
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16
-csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
-		  __u8 proto, __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
diff --git a/arch/hexagon/include/asm/checksum.h b/arch/hexagon/include/asm/checksum.h
index 4bc6ad96c4c5..1a62fd1aaccb 100644
--- a/arch/hexagon/include/asm/checksum.h
+++ b/arch/hexagon/include/asm/checksum.h
@@ -17,9 +17,7 @@ unsigned int do_csum(const void *voidptr, int len);
 __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 			  __u32 len, __u8 proto, __wsum sum);
 
-#define csum_tcpudp_magic csum_tcpudp_magic
-__sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-			  __u32 len, __u8 proto, __wsum sum);
+#define _HAVE_ARCH_CSUM_TCPUDP_MAGIC
 
 #include <asm-generic/checksum.h>
 
diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index 36a80e31d187..f323d908b103 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -36,4 +36,3 @@ DECLARE_EXPORT(__hexagon_divsi3);
 DECLARE_EXPORT(__hexagon_modsi3);
 DECLARE_EXPORT(__hexagon_udivsi3);
 DECLARE_EXPORT(__hexagon_umodsi3);
-DECLARE_EXPORT(csum_tcpudp_magic);
diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
index ba50822a0800..dbeb8f65d5e4 100644
--- a/arch/hexagon/lib/checksum.c
+++ b/arch/hexagon/lib/checksum.c
@@ -54,6 +54,7 @@ __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 		(__force u64)saddr + (__force u64)daddr +
 		(__force u64)sum + ((len + proto) << 8));
 }
+EXPORT_SYMBOL(csum_tcpudp_magic);
 
 __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 			  __u32 len, __u8 proto, __wsum sum)
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 2adef06feeb3..3462a42b6fec 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -93,18 +93,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, unsigned short len,
 	return sum;
 }
 
-
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16
-csum_tcpudp_magic(__be32 saddr, __be32 daddr, unsigned short len,
-		  unsigned short proto, __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 3c43baca7b39..62a390297414 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -85,17 +85,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index b68184dfac00..5925eaff6b8b 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -81,16 +81,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 #endif
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
-					__u8 proto, __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 #define HAVE_ARCH_CSUM_ADD
 static __always_inline __wsum csum_add(__wsum csum, __wsum addend)
 {
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 69837eec2ff5..23b9840ed640 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -91,16 +91,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 	return (__force __wsum)(csum >> 32);
 }
 
-/*
- * Computes the checksum of the TCP/UDP pseudo-header.
- * Returns a 16-bit checksum, already complemented.
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
-					__u8 proto, __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 /*
  * Used for miscellaneous IP-like checksums, mainly icmp.
  */
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 94464451fd08..7b91b7b6c1e9 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -134,17 +134,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index 6dad14f4c925..e53331114217 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -174,17 +174,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index 0e3041ca384b..70f88abd93a1 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -78,17 +78,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
 
 static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 65ca3448e83d..4521474a08ab 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -120,17 +120,6 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 23c56eef8e47..84e26b8c0af5 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -98,24 +98,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 }
 
 
-/**
- * csum_tcpup_magic - Compute an IPv4 pseudo header checksum.
- * @saddr: source address
- * @daddr: destination address
- * @len: length of packet
- * @proto: ip protocol of packet
- * @sum: initial sum to be added in (32bit unfolded)
- *
- * Returns the 16bit pseudo header checksum the input data already
- * complemented and ready to be filled in.
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-
 /**
  * csum_partial - Compute an internet checksum.
  * @buff: buffer to be checksummed
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index b07824500363..9ef8ef4291f4 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -64,17 +64,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					__u32 len, __u8 proto,
-					__wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 /**
  * ip_fast_csum - Compute the IPv4 header checksum efficiently.
  * iph: ipv4 header
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index bf4ee4fd8f57..d1b0e8dac1a5 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -149,17 +149,6 @@ static __inline__ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	return sum;
 }
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-static __inline__ __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					    __u32 len, __u8 proto,
-					    __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
-}
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..797316e34d15 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -47,15 +47,6 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 		   __u8 proto, __wsum sum);
 #endif
 
-#ifndef csum_tcpudp_magic
-static inline __sum16
-csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
-		  __u8 proto, __wsum sum)
-{
-	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
-}
-#endif
-
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly
  * in icmp.c
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 21a3b5c4e25a..706c5fb287cc 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -55,6 +55,22 @@ static inline bool wsum_is_fault(__wsum_fault v)
 #include <linux/uaccess.h>
 #endif
 
+/*
+ * computes the checksum of the TCP/UDP pseudo-header
+ * returns a 16-bit checksum, already complemented
+ */
+#ifndef _HAVE_ARCH_CSUM_TCPUDP_MAGIC
+static inline __sum16
+csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
+		  __u8 proto, __wsum sum)
+{
+	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
+}
+#else
+extern __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+		  __u32 len, __u8 proto, __wsum sum);
+#endif
+
 #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static __always_inline
 __wsum_fault csum_and_copy_from_user (const void __user *src, void *dst,
-- 
2.39.2


