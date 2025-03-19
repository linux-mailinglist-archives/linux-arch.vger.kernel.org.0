Return-Path: <linux-arch+bounces-10974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85663A69A9B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6865888163
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C216E01;
	Wed, 19 Mar 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="WUSESR84"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C792153FC
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418611; cv=none; b=Xrl0MEQZwoz6lD9YcG+rnr5W20a2rxVHamVeJDkte+xj827cK5p8KDYHTBnw8gV1QWcz+P7OLn5x/NOYND7+2LXa+Yu68ASSPn+N/mjDAACslIPg25pq/QEHInXNHZhRiQyeXtoL/WuudS2l04rziSIdryNAOYka+CQC7cln2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418611; c=relaxed/simple;
	bh=6IPmLghPW8jdZ2stJBIVx08WU3l6/qx+WkrXY71Uh5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYJEm1bEmU7Y8ILNGedLTp7SRypWXSMTudQhpwXlD7j82+sBrmyTuf4nnczLc2gu/Drjpldi7gQdCt6y6gXw0AUsSNXnevmg6jgPFK2AuIQHJ7CJSGKQhqudh88HoYPnXBJugOdcQK8pukVyiKt87oVYP0A+8VMC2kxdXCJpMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=WUSESR84; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742418607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx30pxg9oOR6nK0KXgwwQMSrayULAmeIQrbjbt6XfpE=;
	b=WUSESR84P9kXilOMPoz9WGZPL3LVKKSCtXgxCzs709k1SWHPtoaIBS6AAv0I4t7RbaEu8I
	M1T12YcpmrgvOP3JgqGhmGs3cxntNrUFDdVIo7HA2JdKZDrBKNPpq8fIAJAmf3afe8217y
	eUoBGdpwf22W65enMsP0Ew9PYzh7F9XaEIQxrI0XkAv9/07AMmJSIlPw6H5rBQ4vygbRLq
	mA2DJAFb+AU+Id1LLePuLWOMUABaDz0hJisf1uBO9339WvsXL6Yhxm3M0MP9XXkxAib520
	GePaM1eVtP50vVAYrjjkF15ozB5vc6xyV2iXujWgMeTVlTZNiZSg8tGEtTe3gw==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Wed, 19 Mar 2025 22:09:45 +0100
Subject: [PATCH v2 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
In-Reply-To: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-arch@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Move the default byteswap implementation into asm-generic so that it can
be included from arch code.

This is required by RISC-V in order to have a fallback implementation
without duplicating it.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +--------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/include/uapi/asm-generic/swab.h b/include/uapi/asm-generic/swab.h
index f2da4e4fd4d129c43f904c5f1b6234036b57cc77..43d83df007a6fbfb0011452e12e71f429425cad5 100644
--- a/include/uapi/asm-generic/swab.h
+++ b/include/uapi/asm-generic/swab.h
@@ -16,4 +16,36 @@
 #endif
 #endif
 
+/*
+ * casts are necessary for constants, because we never know how for sure
+ * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
+ */
+#define ___constant_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
+
+#define ___constant_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
+
+#define ___constant_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
+
+#define ___constant_swahw32(x) ((__u32)(			\
+	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
+	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
+
+#define ___constant_swahb32(x) ((__u32)(			\
+	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
+	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
+
 #endif /* _ASM_GENERIC_SWAB_H */
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 01717181339eb0fb5128668ca13f38205c03fa28..ca808c492996f810ce417ce9701306070873847b 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -6,38 +6,7 @@
 #include <linux/stddef.h>
 #include <asm/bitsperlong.h>
 #include <asm/swab.h>
-
-/*
- * casts are necessary for constants, because we never know how for sure
- * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
- */
-#define ___constant_swab16(x) ((__u16)(				\
-	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
-	(((__u16)(x) & (__u16)0xff00U) >> 8)))
-
-#define ___constant_swab32(x) ((__u32)(				\
-	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
-	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
-	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
-	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
-
-#define ___constant_swab64(x) ((__u64)(				\
-	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
-	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
-	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
-	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
-	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
-	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
-	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
-	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
-
-#define ___constant_swahw32(x) ((__u32)(			\
-	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
-	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
-
-#define ___constant_swahb32(x) ((__u32)(			\
-	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
-	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
+#include <asm-generic/swab.h>
 
 /*
  * Implement the following as inlines, but define the interface using

-- 
2.48.1


