Return-Path: <linux-arch+bounces-683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5D8044BA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13332814B4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883D53A6;
	Tue,  5 Dec 2023 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C3RsCWHB"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425A135;
	Mon,  4 Dec 2023 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/J1DMvJDhMDQg3O1ndEHHzNhgHxS+xK8Hiq9G81jNnU=; b=C3RsCWHB/nk/cPj31hAsf9i/xo
	nQHlIVEnr3GTpjQnSj7riv2bMhj8lYZY10KWqsbLSF/w63dZknGkPEjy80SIKly9H2+JZ7v9/wjSJ
	7wutVXXUPEAbOpKS+J3RVQ2W9jIsD2r6LM3qDcZJM7cHKxIGMymQWNPaQ+Xo2lgkUiLsFDxURzFlE
	JsbzqchWX5gUDE1HVaf/xlRpSCNGNeYOtYrME3cZruHBBhECSwKZvqB8TK+d677p8FKHX06Xu46yj
	r7r7DsGxvGm4pv0dQ6EQDQToa72XFgTFNjU4H2K9zREgkw5iReF/d2EICDj2bwsUCo52R5jYMRy//
	6aVXPd7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6l-00794E-2W;
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
Subject: [PATCH v2 17/18] x86_64: move csum_ipv6_magic() from csum-wrappers_64.c to csum-partial_64.c
Date: Tue,  5 Dec 2023 02:24:17 +0000
Message-Id: <20231205022418.1703007-26-viro@zeniv.linux.org.uk>
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

... and make uml/amd64 use it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/lib/csum-partial_64.c  | 23 +++++++++++++++++++++++
 arch/x86/lib/csum-wrappers_64.c | 23 -----------------------
 arch/x86/um/asm/checksum_64.h   |  7 +++++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 192d4772c2a3..6a1ca0cddc21 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -144,3 +144,26 @@ __sum16 ip_compute_csum(const void *buff, int len)
 	return csum_fold(csum_partial(buff, len, 0));
 }
 EXPORT_SYMBOL(ip_compute_csum);
+
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum)
+{
+	__u64 rest, sum64;
+
+	rest = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
+		(__force __u64)sum;
+
+	asm("	addq (%[saddr]),%[sum]\n"
+	    "	adcq 8(%[saddr]),%[sum]\n"
+	    "	adcq (%[daddr]),%[sum]\n"
+	    "	adcq 8(%[daddr]),%[sum]\n"
+	    "	adcq $0,%[sum]\n"
+
+	    : [sum] "=r" (sum64)
+	    : "[sum]" (rest), [saddr] "r" (saddr), [daddr] "r" (daddr));
+
+	return csum_fold(
+	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index da3158416572..fa513d41ff2b 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -67,26 +67,3 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 	return from_wsum_fault(csum_partial_copy_generic(src, dst, len));
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-
-__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-			const struct in6_addr *daddr,
-			__u32 len, __u8 proto, __wsum sum)
-{
-	__u64 rest, sum64;
-
-	rest = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
-		(__force __u64)sum;
-
-	asm("	addq (%[saddr]),%[sum]\n"
-	    "	adcq 8(%[saddr]),%[sum]\n"
-	    "	adcq (%[daddr]),%[sum]\n"
-	    "	adcq 8(%[daddr]),%[sum]\n"
-	    "	adcq $0,%[sum]\n"
-
-	    : [sum] "=r" (sum64)
-	    : "[sum]" (rest), [saddr] "r" (saddr), [daddr] "r" (daddr));
-
-	return csum_fold(
-	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
-}
-EXPORT_SYMBOL(csum_ipv6_magic);
diff --git a/arch/x86/um/asm/checksum_64.h b/arch/x86/um/asm/checksum_64.h
index 17228e4c26b6..228424a52b7f 100644
--- a/arch/x86/um/asm/checksum_64.h
+++ b/arch/x86/um/asm/checksum_64.h
@@ -7,4 +7,11 @@
 
 #define _HAVE_IP_COMPUTE_CSUM
 
+struct in6_addr;
+
+#define _HAVE_ARCH_IPV6_CSUM 1
+extern __sum16
+csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
+		__u32 len, __u8 proto, __wsum sum);
+
 #endif
-- 
2.39.2


