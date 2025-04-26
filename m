Return-Path: <linux-arch+bounces-11603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC27A9DB9A
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0311B64D1D
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9913E41A;
	Sat, 26 Apr 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="X6B2J3t5"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C91FCF7C
	for <linux-arch@vger.kernel.org>; Sat, 26 Apr 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679402; cv=none; b=kH0zQ5lZ1SwtaZMqEwuGqcSicWQovSErctb174hDMESSAP4MPW4wY2JZf++UMTA08EWWtqHtAHNkJJMOy5vYyQbA9JHAHMSXI9T/P/xKTJCiSt7ZioK5sRyEVJQlXP/YoONfrSiwVABjc+W+seGBUUVYdIOCcaXCiaSqK/gWgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679402; c=relaxed/simple;
	bh=A91oyDJzVW2A+SsBR2soCVb/dkMc/nCruf6KCnJLaKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhVRwsuMPU8m62S7YWehvMBCkz0o+BOs3Lg+VSd8zi6N5wFDnteebkjqidALE68wVOHCsRUrvzqRchHJVwuKcupnj0pTQejTXcvHycsbWBwC59STBd4C5xAwqPEkjbOQIpxHcgmaayd0eGJcfkUZh5xbZ2BXUyDtBs4fRjWGTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=X6B2J3t5; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1745679398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3D2Wq7EVGu9ukjexMYuq8e+jDjRLdPow92yjOGXrYg=;
	b=X6B2J3t5QVaUwP7jK9sXf5HGgOifbaWiOZg7lIwgwDBLFPRYVgRamqlr5U8nc3JXmLJDg9
	pvIfOWv387GbCj1rEYzJQhlCqtjAxKhV5yg6gW4rJ6Ez6ct8uUf0QNF5l9vlKVVsJnV5ou
	k17pnrDQs0cGuZ6dj80CFkBYSYvnqZpUM6fi+oKfAlbm3786HwXtb416wIhHOY9ggXETjv
	e3owhLIaP/k11iVwMF3+smUv77RheHhryHr9iQfJxHP/Qb+KShLMthcsdrpXD8bNBVij2M
	qm683yde833B5QC6WMFFbHFVoGEWsi8dO2mxzONqA7hZLVu8ZEuIRq0C891UDg==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Sat, 26 Apr 2025 16:56:18 +0200
Subject: [PATCH v4 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250426-riscv-swab-v4-1-64201404a68c@iencinas.com>
References: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
In-Reply-To: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
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
 include/uapi/asm-generic/swab.h | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/swab.h       | 33 +--------------------------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/uapi/asm-generic/swab.h b/include/uapi/asm-generic/swab.h
index f2da4e4fd4d1..232e81661dc5 100644
--- a/include/uapi/asm-generic/swab.h
+++ b/include/uapi/asm-generic/swab.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_SWAB_H
 
 #include <asm/bitsperlong.h>
+#include <linux/types.h>
 
 /*
  * 32 bit architectures typically (but not always) want to
@@ -16,4 +17,36 @@
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
index 01717181339e..ca808c492996 100644
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
2.49.0


