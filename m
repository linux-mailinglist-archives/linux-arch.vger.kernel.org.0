Return-Path: <linux-arch+bounces-8816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5921C9BA8E5
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 23:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93CAB21D70
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81161ABEA9;
	Sun,  3 Nov 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrX8vnYi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0F1AB530;
	Sun,  3 Nov 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673148; cv=none; b=j9XJ6+ctG2y7BlaPb/5ck44/7ZcGr1EYWipdKTMNF9A5+R3xcyRFYfSfkBo+afbrfYSJBGG2749YGn1G/0NiRrAXxoin7kf65sBqE2/mq8sTxHDaEBRZTNhAixF16iVftTiHGWtJWkaDbjXPO5Sb/RupULs7Ap2rlPRSvM2RDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673148; c=relaxed/simple;
	bh=R3RIsL1uK8EQAGi0SGqk7fPI8kAR8rBJM+i88HKwo+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/oemhjuoosILHuteiZn9lxZ2FLdP77o+ECH74gHd4ypgRDi0qmxy1ZKOnU45KNmiIZsQTisUHaj3GajxTraouNioJJsMaBImwAmoHralytnaIWTtWN+LviECrl/DTtVIPh/E2zgAY2X+8uUHLqhFXZCo+uPdX2oxxxr+rTD8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrX8vnYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A3C4AF09;
	Sun,  3 Nov 2024 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730673145;
	bh=R3RIsL1uK8EQAGi0SGqk7fPI8kAR8rBJM+i88HKwo+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrX8vnYi6RABnxqWW60rA5vLS2/aG1Tnc49VRVlwICi9yJ7QBnDWco/Yks+8wcuHa
	 RJuv3uzU+Z6DTR7yfQGoDUX9bYZhQ8O6Hq7pMkhfl3QqRSKQV3ExIVZu2uhcpBKIjR
	 fiwyAeVZAnX/xcIlgG4UBHb2UTaDQHawqpOvN2/n/J7uPYSvzXmIV9xhwyN2GFDagS
	 H4ngn3Fodl7aHmeNPUSVT2tVlOXuaBpibrQaV+wveq6oJO8Y8WsWgddFxjNtz0h7QF
	 GPGvqV/QcxpUiurjY8UUYUNlQ8oSIkZuJkJ/X9GpLLyNaLm2a8lC9ndMRajJMGOHq2
	 j8og8QUJ6tDSg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 03/18] lib/crc32: expose whether the lib is really optimized at runtime
Date: Sun,  3 Nov 2024 14:31:39 -0800
Message-ID: <20241103223154.136127-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103223154.136127-1-ebiggers@kernel.org>
References: <20241103223154.136127-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make the CRC32 library export a function crc32_optimizations() which
returns flags that indicate which CRC32 functions are actually executing
optimized code at runtime.

This will be used to determine whether the crc32[c]-$arch shash
algorithms should be registered in the crypto API.  btrfs could also
start using these flags instead of the hack that it currently uses where
it parses the crypto_shash_driver_name.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/lib/crc32-glue.c  | 10 ++++++++++
 arch/riscv/lib/crc32-riscv.c | 10 ++++++++++
 include/linux/crc32.h        | 15 +++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/arm64/lib/crc32-glue.c b/arch/arm64/lib/crc32-glue.c
index d7f6e1cbf0d2..15c4c9db573e 100644
--- a/arch/arm64/lib/crc32-glue.c
+++ b/arch/arm64/lib/crc32-glue.c
@@ -83,7 +83,17 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 
 	return crc32_be_arm64(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_be_arch);
 
+u32 crc32_optimizations(void)
+{
+	if (alternative_has_cap_likely(ARM64_HAS_CRC32))
+		return CRC32_LE_OPTIMIZATION |
+		       CRC32_BE_OPTIMIZATION |
+		       CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("arm64-optimized CRC32 functions");
diff --git a/arch/riscv/lib/crc32-riscv.c b/arch/riscv/lib/crc32-riscv.c
index a3ff7db2a1ce..53d56ab422c7 100644
--- a/arch/riscv/lib/crc32-riscv.c
+++ b/arch/riscv/lib/crc32-riscv.c
@@ -295,7 +295,17 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 legacy:
 	return crc32_be_base(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_be_arch);
 
+u32 crc32_optimizations(void)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		return CRC32_LE_OPTIMIZATION |
+		       CRC32_BE_OPTIMIZATION |
+		       CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Accelerated CRC32 implementation with Zbc extension");
diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 58c632533b08..e9bd40056687 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -35,10 +35,25 @@ static inline u32 __pure __crc32c_le(u32 crc, const u8 *p, size_t len)
 	if (IS_ENABLED(CONFIG_CRC32_ARCH))
 		return crc32c_le_arch(crc, p, len);
 	return crc32c_le_base(crc, p, len);
 }
 
+/*
+ * crc32_optimizations() returns flags that indicate which CRC32 library
+ * functions are using architecture-specific optimizations.  Unlike
+ * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
+ * variants and also whether any needed CPU features are available at runtime.
+ */
+#define CRC32_LE_OPTIMIZATION	BIT(0) /* crc32_le() is optimized */
+#define CRC32_BE_OPTIMIZATION	BIT(1) /* crc32_be() is optimized */
+#define CRC32C_OPTIMIZATION	BIT(2) /* __crc32c_le() is optimized */
+#if IS_ENABLED(CONFIG_CRC32_ARCH)
+u32 crc32_optimizations(void);
+#else
+static inline u32 crc32_optimizations(void) { return 0; }
+#endif
+
 /**
  * crc32_le_combine - Combine two crc32 check values into one. For two
  * 		      sequences of bytes, seq1 and seq2 with lengths len1
  * 		      and len2, crc32_le() check values were calculated
  * 		      for each, crc1 and crc2.
-- 
2.47.0


