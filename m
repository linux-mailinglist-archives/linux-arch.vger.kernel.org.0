Return-Path: <linux-arch+bounces-685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2D8044BE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76F3B20C68
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678F610D;
	Tue,  5 Dec 2023 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LtctdxV8"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690518B;
	Mon,  4 Dec 2023 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yGsLus4r20WEhHIEUwFMWqvoY3KD5tmxwmXqu9yESi4=; b=LtctdxV88ZB9dZnAzKcrsyJRmK
	3tN0NMX6g3+akOw4y3ZNae1A3WM5uC6dRSRxk6bOx3aJe8VdZMcHFaxBG74+d99D+waBD/i98aJwV
	QU/6GapyrDEWQvaNpCZpTxGjvEIcZIboUFseYoKgzl7oI6yttsI4siDtFjqWhqLxpOU6ImEd/fFbW
	zm6wfLREYe0TezDiEYLrnFGjLo3kTnRvEA9LAJvSbpQ6piFK5m/36cm/rPWhAbx9N1NdpzSFfe3Oc
	LoXFth9KtYsZr1nAQfqwCkznKqpzSctgzBXjzTVJq4pvxKAvKggqk4moJXHMSraFWvOm8IRc9e98R
	iXfHokZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6k-00793Z-2V;
	Tue, 05 Dec 2023 02:24:22 +0000
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
Subject: [PATCH v2 12/18] x86: merge ip_fast_csum() for 32bit and 64bit
Date: Tue,  5 Dec 2023 02:24:12 +0000
Message-Id: <20231205022418.1703007-21-viro@zeniv.linux.org.uk>
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

Identical, except that 32bit version uses asm volatile where 64bit
one uses plain asm.  The former had become pointless when memory
clobber got added to both versions...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 43 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/checksum_32.h | 37 -------------------------
 arch/x86/include/asm/checksum_64.h | 43 ------------------------------
 3 files changed, 43 insertions(+), 80 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index eaa5dda09bee..5e617a380537 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -26,6 +26,49 @@ static inline __sum16 csum_fold(__wsum sum)
 	return (__force __sum16)(~(__force u32)sum >> 16);
 }
 
+/*
+ *	This is a version of ip_compute_csum() optimized for IP headers,
+ *	which always checksum on 4 octet boundaries.
+ *
+ *	By Jorge Cwik <jorge@laser.satlink.net>, adapted for linux by
+ *	Arnt Gulbrandsen.
+ */
+
+/**
+ * ip_fast_csum - Compute the IPv4 header checksum efficiently.
+ * iph: ipv4 header
+ * ihl: length of header / 4
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	unsigned int sum;
+
+	asm("  movl (%1), %0\n"
+	    "  subl $4, %2\n"
+	    "  jbe 2f\n"
+	    "  addl 4(%1), %0\n"
+	    "  adcl 8(%1), %0\n"
+	    "  adcl 12(%1), %0\n"
+	    "1: adcl 16(%1), %0\n"
+	    "  lea 4(%1), %1\n"
+	    "  decl %2\n"
+	    "  jne	1b\n"
+	    "  adcl $0, %0\n"
+	    "  movl %0, %2\n"
+	    "  shrl $16, %0\n"
+	    "  addw %w2, %w0\n"
+	    "  adcl $0, %0\n"
+	    "  notl %0\n"
+	    "2:"
+	/* Since the input registers which are loaded with iph and ihl
+	   are modified, we must also specify them as outputs, or gcc
+	   will assume they contain their original values. */
+	    : "=r" (sum), "=r" (iph), "=r" (ihl)
+	    : "1" (iph), "2" (ihl)
+	    : "memory");
+	return (__force __sum16)sum;
+}
+
 # ifdef CONFIG_X86_32
 #  include <asm/checksum_32.h>
 # else
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 4e96d0473f88..d920e6c335bc 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -55,43 +55,6 @@ static inline __wsum_fault csum_and_copy_from_user(const void __user *src,
 	return ret;
 }
 
-/*
- *	This is a version of ip_compute_csum() optimized for IP headers,
- *	which always checksum on 4 octet boundaries.
- *
- *	By Jorge Cwik <jorge@laser.satlink.net>, adapted for linux by
- *	Arnt Gulbrandsen.
- */
-static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
-{
-	unsigned int sum;
-
-	asm volatile("movl (%1), %0	;\n"
-		     "subl $4, %2	;\n"
-		     "jbe 2f		;\n"
-		     "addl 4(%1), %0	;\n"
-		     "adcl 8(%1), %0	;\n"
-		     "adcl 12(%1), %0;\n"
-		     "1:	adcl 16(%1), %0	;\n"
-		     "lea 4(%1), %1	;\n"
-		     "decl %2	;\n"
-		     "jne 1b		;\n"
-		     "adcl $0, %0	;\n"
-		     "movl %0, %2	;\n"
-		     "shrl $16, %0	;\n"
-		     "addw %w2, %w0	;\n"
-		     "adcl $0, %0	;\n"
-		     "notl %0	;\n"
-		     "2:		;\n"
-	/* Since the input registers which are loaded with iph and ihl
-	   are modified, we must also specify them as outputs, or gcc
-	   will assume they contain their original values. */
-		     : "=r" (sum), "=r" (iph), "=r" (ihl)
-		     : "1" (iph), "2" (ihl)
-		     : "memory");
-	return (__force __sum16)sum;
-}
-
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 					__u32 len, __u8 proto,
 					__wsum sum)
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index d261b4124ca6..b80c82590d8d 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -11,49 +11,6 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 
-/*
- *	This is a version of ip_compute_csum() optimized for IP headers,
- *	which always checksum on 4 octet boundaries.
- *
- *	By Jorge Cwik <jorge@laser.satlink.net>, adapted for linux by
- *	Arnt Gulbrandsen.
- */
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
-	asm("  movl (%1), %0\n"
-	    "  subl $4, %2\n"
-	    "  jbe 2f\n"
-	    "  addl 4(%1), %0\n"
-	    "  adcl 8(%1), %0\n"
-	    "  adcl 12(%1), %0\n"
-	    "1: adcl 16(%1), %0\n"
-	    "  lea 4(%1), %1\n"
-	    "  decl %2\n"
-	    "  jne	1b\n"
-	    "  adcl $0, %0\n"
-	    "  movl %0, %2\n"
-	    "  shrl $16, %0\n"
-	    "  addw %w2, %w0\n"
-	    "  adcl $0, %0\n"
-	    "  notl %0\n"
-	    "2:"
-	/* Since the input registers which are loaded with iph and ihl
-	   are modified, we must also specify them as outputs, or gcc
-	   will assume they contain their original values. */
-	    : "=r" (sum), "=r" (iph), "=r" (ihl)
-	    : "1" (iph), "2" (ihl)
-	    : "memory");
-	return (__force __sum16)sum;
-}
-
 /**
  * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
  * @saddr: source address
-- 
2.39.2


