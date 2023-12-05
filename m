Return-Path: <linux-arch+bounces-674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37F8044AC
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8986C28148A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F126ABF;
	Tue,  5 Dec 2023 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UJDauNpR"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E3134;
	Mon,  4 Dec 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lz9jDx1K1J1PVs+5ELGTz3x5GcPqr4KZv94HVfgzNvM=; b=UJDauNpRs2sWRFoqxzYw4pL6kX
	kvCaUzHAkNfC9Xk2cC4LSbtif0CXS9TFXcA1qBHhoEXGpDQaALJu8QLQh2R0JclzfpfMYvz4BQVbm
	Vb5plQmEVC6PzpbB16Qdnf2xzresMHr8kppWJpbGbVNjXPv8OyPuXagNLk2OFDSoZ6Hv417zHn3TT
	/lzijk8PybhTEqV4023qhQoPgKWI7Yo4hHNg0aZRyJvVMZITEOOQLSf9Z3yy+1VfhH/2aK2ljyqJv
	I0pmXBHrlD/1TJ63VFrrVFBf2zPhNOyUznkbY8dNxqIIZxd+TbhYKF45TC21Sku0XjkffGP3ljHbj
	Kz13T9ow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6l-00793x-14;
	Tue, 05 Dec 2023 02:24:23 +0000
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
Subject: [PATCH v2 15/18] x86: optimized csum_add() is the same for 32bit and 64bit
Date: Tue,  5 Dec 2023 02:24:15 +0000
Message-Id: <20231205022418.1703007-24-viro@zeniv.linux.org.uk>
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

... and when gcc-8 becomes a requirement, we could simply switch to
generic version.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 18 ++++++++++++++++++
 arch/x86/include/asm/checksum_64.h | 16 ----------------
 arch/x86/um/asm/checksum.h         | 17 +++++++++++++++++
 arch/x86/um/asm/checksum_64.h      |  9 ---------
 4 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index c66fa797703a..5c0a730c7316 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,6 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_CHECKSUM_H
 #define _ASM_X86_CHECKSUM_H
+
+static inline unsigned add32_with_carry(unsigned a, unsigned b)
+{
+	asm("addl %2,%0\n\t"
+	    "adcl $0,%0"
+	    : "=r" (a)
+	    : "0" (a), "rm" (b));
+	return a;
+}
+
+/* note: with gcc-8 or later generic csum_add() yields the same code */
+#define HAVE_ARCH_CSUM_ADD
+static inline __wsum csum_add(__wsum csum, __wsum addend)
+{
+	return (__force __wsum)add32_with_carry((__force unsigned)csum,
+						(__force unsigned)addend);
+}
+
 #ifdef CONFIG_GENERIC_CSUM
 # include <asm-generic/checksum.h>
 #else
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index e225a12cec68..c86db605c0fd 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -52,20 +52,4 @@ extern __sum16
 csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
 		__u32 len, __u8 proto, __wsum sum);
 
-static inline unsigned add32_with_carry(unsigned a, unsigned b)
-{
-	asm("addl %2,%0\n\t"
-	    "adcl $0,%0"
-	    : "=r" (a)
-	    : "0" (a), "rm" (b));
-	return a;
-}
-
-#define HAVE_ARCH_CSUM_ADD
-static inline __wsum csum_add(__wsum csum, __wsum addend)
-{
-	return (__force __wsum)add32_with_carry((__force unsigned)csum,
-						(__force unsigned)addend);
-}
-
 #endif /* _ASM_X86_CHECKSUM_64_H */
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index 9ef8ef4291f4..0986c19e5ff0 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -6,6 +6,23 @@
 #include <linux/in6.h>
 #include <linux/uaccess.h>
 
+static inline unsigned add32_with_carry(unsigned a, unsigned b)
+{
+	asm("addl %2,%0\n\t"
+	    "adcl $0,%0"
+	    : "=r" (a)
+	    : "0" (a), "rm" (b));
+	return a;
+}
+
+/* note: with gcc-8 or later generic csum_add() yields the same code */
+#define HAVE_ARCH_CSUM_ADD
+static inline __wsum csum_add(__wsum csum, __wsum addend)
+{
+	return (__force __wsum)add32_with_carry((__force unsigned)csum,
+						(__force unsigned)addend);
+}
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
diff --git a/arch/x86/um/asm/checksum_64.h b/arch/x86/um/asm/checksum_64.h
index fd1ab07e4a4c..17228e4c26b6 100644
--- a/arch/x86/um/asm/checksum_64.h
+++ b/arch/x86/um/asm/checksum_64.h
@@ -7,13 +7,4 @@
 
 #define _HAVE_IP_COMPUTE_CSUM
 
-static inline unsigned add32_with_carry(unsigned a, unsigned b)
-{
-        asm("addl %2,%0\n\t"
-            "adcl $0,%0"
-            : "=r" (a)
-            : "0" (a), "r" (b));
-        return a;
-}
-
 #endif
-- 
2.39.2


