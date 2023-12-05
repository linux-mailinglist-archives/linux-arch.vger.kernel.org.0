Return-Path: <linux-arch+bounces-666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511F8044A4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91DE28145B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A394C6C;
	Tue,  5 Dec 2023 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kjRXCbGw"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11921113;
	Mon,  4 Dec 2023 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oM052cTSQ0OvFerUaTSe6I6I0lV0SevKybQiSTbBEOU=; b=kjRXCbGwoqRFR6digoglQSNMdt
	tOLKNrtrI+3Hols/QMNsf1PolDzkOq3ViCTLxJHy3hZzWj3Zp4mxmlOHbseobjD6cfR+2kBq1X38f
	fxNSBJIWcmjQT9zXwhfryTvyLbtQ/M9zaxnIt7juagR0oMMJAfpmW6HxVPd4YDuqbjM4j3S5ukT+u
	k+p3EEdulEmgi3L/89AjkqdDmSvHq0oKnY2q4m5LLCRJXDm4i3X3eUUF6izjW2OkhXp3TQZ6gG0AI
	lDbKJjgjYOGdkefJQWe+yaLxYcSVY4ULxMeCH9j2Xl3zUcPxhlHzPS2X9ay9MqeT5QpInTZjz3DZz
	TRS8lApw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6j-00792s-19;
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
Subject: [PATCH v2 08/18] alpha: pull asm-generic/checksum.h
Date: Tue,  5 Dec 2023 02:24:06 +0000
Message-Id: <20231205022418.1703007-15-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h | 51 +++----------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 0d7c21a79961..54722eaeb999 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -2,40 +2,7 @@
 #ifndef _ALPHA_CHECKSUM_H
 #define _ALPHA_CHECKSUM_H
 
-#include <linux/in6.h>
-
-/*
- *	This is a version of ip_compute_csum() optimized for IP headers,
- *	which always checksum on 4 octet boundaries.
- */
-extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
-
 #define _HAVE_ARCH_CSUM_TCPUDP_MAGIC
-
-__wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
-			  __u32 len, __u8 proto, __wsum sum);
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
-/*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
 __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len);
@@ -43,21 +10,13 @@ __wsum_fault csum_and_copy_from_user(const void __user *src, void *dst, int len)
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 #define _HAVE_IP_COMPUTE_CSUM
-
-/*
- *	Fold a partial checksum without adding pseudo headers
- */
-
-static inline __sum16 csum_fold(__wsum csum)
-{
-	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
-}
-
 #define _HAVE_ARCH_IPV6_CSUM
+
+struct in6_addr;
 extern __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			       const struct in6_addr *daddr,
 			       __u32 len, __u8 proto, __wsum sum);
+
+#include <asm-generic/checksum.h>
+
 #endif
-- 
2.39.2


