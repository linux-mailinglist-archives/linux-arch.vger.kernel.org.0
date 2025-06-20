Return-Path: <linux-arch+bounces-12416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411B2AE19DC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 13:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF63AA8ED
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4028A713;
	Fri, 20 Jun 2025 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fVUuJUo9"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3128A1D0;
	Fri, 20 Jun 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418217; cv=none; b=tsUn33PcKbJVxHsipyp8YZHw+gpZf/hA72qVlU9zqRNL50KsF6pydgjRhotYRYgQvV30w8Fh6NJcdV6XNUaxF0+xzvF35ADbI/FSnyFCi8hnDDoZHyWofiMzbgb1nNnPyw6+xbifzQpEQ7ByvCgz/YsRiZ5StIEVxefBSxxSeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418217; c=relaxed/simple;
	bh=sskRXO+L7/j0s902K25TvnhEU38zDf6vBYWCLbDE66c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm6RxeFr0dtQfbUJ4PU8Be+kNKLZOXXWBMX8afvoRz82/M+DN0hFJ1A+FGcXVfD+ksT0W80hGn7iasVem6FOkbgvys8g4Rd63p9I+uXbSKQIGhGHKjBjiuIKbQYpWI4kn4WRYJzjYHpb7AbEVHJDTMlk8K67zvFNwgJyu6YRcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fVUuJUo9; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750418213; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i6Itj8EUP34Ecukcbx4LZV19FLhT/XveeyJP7HjJzps=;
	b=fVUuJUo9wBTIvP37w6+Mxi1uoEe92OEytcLwTUJL7P2J0le26G2jeAQKce8KavbsLNDh8eWizH6U1ERZrn5erzjxmnSAQKjGm817nIdEugr82DJ4ln0WO2ddVpazggIvuoW93+oPhr9BSXY/uwkIR530aX/GoDiLTpblx+myRTs=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WeKdQMr_1750418210 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Jun 2025 19:16:52 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	arnd@arndb.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb extension
Date: Fri, 20 Jun 2025 19:16:10 +0800
Message-ID: <20250620111610.52750-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620111610.52750-1-cp0613@linux.alibaba.com>
References: <20250620111610.52750-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The RISC-V Zbb extension[1] defines bitwise rotation instructions,
which can be used to implement rotate related functions.

[1] https://github.com/riscv/riscv-bitmanip/

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/include/asm/bitops.h | 172 ++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2b..be247ef9e686 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -20,17 +20,20 @@
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/rotate.h>
 
 #else
 #define __HAVE_ARCH___FFS
 #define __HAVE_ARCH___FLS
 #define __HAVE_ARCH_FFS
 #define __HAVE_ARCH_FLS
+#define __HAVE_ARCH_ROTATE
 
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/rotate.h>
 
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
@@ -175,6 +178,175 @@ static __always_inline int variable_fls(unsigned int x)
 	 variable_fls(x_);					\
 })
 
+static __always_inline u64 variable_rol64(u64 word, unsigned int shift)
+{
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rol %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word), "r" (shift) :);
+
+	return word;
+
+legacy:
+	return generic_rol64(word, shift);
+}
+
+static inline u64 variable_ror64(u64 word, unsigned int shift)
+{
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"ror %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word), "r" (shift) :);
+
+	return word;
+
+legacy:
+	return generic_ror64(word, shift);
+}
+
+static inline u32 variable_rol32(u32 word, unsigned int shift)
+{
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rolw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word), "r" (shift) :);
+
+	return word;
+
+legacy:
+	return generic_rol32(word, shift);
+}
+
+static inline u32 variable_ror32(u32 word, unsigned int shift)
+{
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rorw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word) : "r" (word), "r" (shift) :);
+
+	return word;
+
+legacy:
+	return generic_ror32(word, shift);
+}
+
+static inline u16 variable_rol16(u16 word, unsigned int shift)
+{
+	u32 word32 = ((u32)word << 16) | word;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rolw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word32) : "r" (word32), "r" (shift) :);
+
+	return (u16)word32;
+
+legacy:
+	return generic_rol16(word, shift);
+}
+
+static inline u16 variable_ror16(u16 word, unsigned int shift)
+{
+	u32 word32 = ((u32)word << 16) | word;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rorw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word32) : "r" (word32), "r" (shift) :);
+
+	return (u16)word32;
+
+legacy:
+	return generic_ror16(word, shift);
+}
+
+static inline u8 variable_rol8(u8 word, unsigned int shift)
+{
+	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rolw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word32) : "r" (word32), "r" (shift) :);
+
+	return (u8)word32;
+
+legacy:
+	return generic_rol8(word, shift);
+}
+
+static inline u8 variable_ror8(u8 word, unsigned int shift)
+{
+	u32 word32 = ((u32)word << 24) | ((u32)word << 16) | ((u32)word << 8) | word;
+
+	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
+				      RISCV_ISA_EXT_ZBB, 1)
+			  : : : : legacy);
+
+	asm volatile(
+		".option push\n"
+		".option arch,+zbb\n"
+		"rorw %0, %1, %2\n"
+		".option pop\n"
+		: "=r" (word32) : "r" (word32), "r" (shift) :);
+
+	return (u8)word32;
+
+legacy:
+	return generic_ror8(word, shift);
+}
+
+#define rol64(word, shift) variable_rol64(word, shift)
+#define ror64(word, shift) variable_ror64(word, shift)
+#define rol32(word, shift) variable_rol32(word, shift)
+#define ror32(word, shift) variable_ror32(word, shift)
+#define rol16(word, shift) variable_rol16(word, shift)
+#define ror16(word, shift) variable_ror16(word, shift)
+#define rol8(word, shift)  variable_rol8(word, shift)
+#define ror8(word, shift)  variable_ror8(word, shift)
+
 #endif /* !(defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)) || defined(NO_ALTERNATIVE) */
 
 #include <asm-generic/bitops/ffz.h>
-- 
2.49.0


