Return-Path: <linux-arch+bounces-11249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA13A7B081
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711143B2B2E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 21:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23881FDA8C;
	Thu,  3 Apr 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="FcMOfVC+"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E01FCFF3
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712485; cv=none; b=FtVVJTj5FIGwwUnTlwsJunzV64V94YThdaoBp6x/Vcb4wwH4Z/vxDQxJHpaDknFpEekmeIYaCED4zaDXISYvgDwul8X3/vuK6Lmc8GznISTs2kZ5d0TF6rrrH1DPevHDtG2drEsbHkXhbhhMnhD5uute+G5VlIO7hBEMEG0HduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712485; c=relaxed/simple;
	bh=vNjPf3P0PUxeTGKWeu+8t+D+VDii1FobxL9MZssx2m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbRo2cOLHwAEc9W8woCZvIBsVt0ytNMbauKSeibu4Ik8m1we5GkyLLVsp6ZxrRdkaJmhDTBzXLnI4YtYPJKvHzo2hJLQTsIdS/Q0g/P/sUehKUPVe0ak/RHjpgYFxX28rWN0ZkAm9pCfgRe4saQruLEnPIzWE0ccMAoaE5IpM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=FcMOfVC+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743712481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XottEP9+kxqN7k8r+CHXORR/CTolk7gMW8RtuPxzLJg=;
	b=FcMOfVC+xU7hwwVLr0B5iWZuITi70KZBKm4qeHGCRW6+WbcUhz661oepH44LwuaDQ+9cKz
	UTZij1H0QJGIb84cke/NAuBZGNbozLcHObxCyd2uvRVTfe5qfXpQKi6pkT9RLKuO4C5G0a
	CIAEWfKq8W7hlph0Qg45iUfiPOVlF8YkX+PNZm6um6pt8/nqGvkktAEvCfZVvMtH6gZR47
	xy9bCACXaHv0yOYcLSDjCNLGmzWwN1e35e7htTPw29Pi5yz4ws+xspnMXC3kO1j1gLznMz
	EExAgTiLMZgzWo2QPxVkwazDq9zCDeQq0SAd0jE4czpD3i1GSQTt+eMMR/iPcg==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Thu, 03 Apr 2025 22:34:17 +0200
Subject: [PATCH v3 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-riscv-swab-v3-1-3bf705d80e33@iencinas.com>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
In-Reply-To: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
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
index f2da4e4fd4d1..43d83df007a6 100644
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


