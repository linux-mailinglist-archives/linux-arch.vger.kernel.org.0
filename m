Return-Path: <linux-arch+bounces-8556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEF9B0E3B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB6D1F25949
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1820F3F6;
	Fri, 25 Oct 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI9KH2T6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1520F3D2;
	Fri, 25 Oct 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883745; cv=none; b=I9iTNj59lJp7omG4U0ScbnPYcdcfrrjiiM0IeLz5CCg0YwXZOa7Y0xIIbp8qe3GvXCD6AhqTb7qxoHbNDP1otVLyWOX+aur0tUq/kFFDhVtuEBsCAXFox5jvj9hTs6doNAVMxpbCgpPyOJf5YFG5dT/QWMpAad3G6MfSDz8slmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883745; c=relaxed/simple;
	bh=cAJYaYF7J3aaXrRf/1YfFopFsst+6vDJ5/6wykaVcrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nst+PYVrlUIdPBUH04dvLyxaTv6xa7p34Dv3P0tfRjMbnViAIqjObtnbEwuKKsPQwv0/V+Ai++ouPBnW8O/jCo6RvjkM9fVoW+nAG7x+Le9H6undMGvug8yGxJSUKSMpJapMkg1rDDa2ks0TljS6KoNZaiw6YBOeCoDO4zNHFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI9KH2T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AED1C4CEF2;
	Fri, 25 Oct 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883745;
	bh=cAJYaYF7J3aaXrRf/1YfFopFsst+6vDJ5/6wykaVcrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QI9KH2T6touAeB0Bal3BOeVfOL9fssjod4GL6OqC7Pk6qRKNz9IPMverC8NgaWU7O
	 ER6xq1eq2ZWfPo1xlfIxSL/jgpJppO0mPJ89PTjZdCahyFmziLwWnkwj43+YtLFUKh
	 /cLt9rhrf2AqarRF5VND46RANchTj3PmSwBF/braEnqKyKknURDV8wgDod4hG3GHwt
	 byCNSM8KoUkpZF/cgYu4kz52r7RJwzyRomoqpWsVuW7t4xdVjwDKO15dN8Fjxh5Riz
	 t4wuPl8VpjQO5DRxjrsjFjxHcMDbZrCjQv+8hlnhaXJ1VjD5rLSfkGmv2hg6GCMm7U
	 TOvve01DNwQ8w==
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
Subject: [PATCH v2 03/18] lib/crc32: expose whether the lib is really optimized at runtime
Date: Fri, 25 Oct 2024 12:14:39 -0700
Message-ID: <20241025191454.72616-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025191454.72616-1-ebiggers@kernel.org>
References: <20241025191454.72616-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make the CRC32 library export some flags that indicate which CRC32
functions are actually executing optimized code at runtime.  Set these
correctly from the architectures that implement the CRC32 functions.

This will be used to determine whether the crc32[c]-$arch shash
algorithms should be registered in the crypto API.  btrfs could also
start using these flags instead of the hack that it currently uses where
it parses the crypto_shash_driver_name.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/lib/crc32-glue.c  | 15 +++++++++++++++
 arch/riscv/lib/crc32-riscv.c | 15 +++++++++++++++
 include/linux/crc32.h        | 15 +++++++++++++++
 lib/crc32.c                  |  5 +++++
 4 files changed, 50 insertions(+)

diff --git a/arch/arm64/lib/crc32-glue.c b/arch/arm64/lib/crc32-glue.c
index d7f6e1cbf0d2..16f2b7c04294 100644
--- a/arch/arm64/lib/crc32-glue.c
+++ b/arch/arm64/lib/crc32-glue.c
@@ -83,7 +83,22 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 
 	return crc32_be_arm64(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_be_arch);
 
+static int __init crc32_arm64_init(void)
+{
+	if (cpus_have_cap(ARM64_HAS_CRC32))
+		crc32_optimizations = CRC32_LE_OPTIMIZATION |
+				      CRC32_BE_OPTIMIZATION |
+				      CRC32C_OPTIMIZATION;
+	return 0;
+}
+arch_initcall(crc32_arm64_init);
+
+static void __exit crc32_arm64_exit(void)
+{
+}
+module_exit(crc32_arm64_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("arm64-optimized CRC32 functions");
diff --git a/arch/riscv/lib/crc32-riscv.c b/arch/riscv/lib/crc32-riscv.c
index a3ff7db2a1ce..a61c13d89364 100644
--- a/arch/riscv/lib/crc32-riscv.c
+++ b/arch/riscv/lib/crc32-riscv.c
@@ -295,7 +295,22 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
 legacy:
 	return crc32_be_base(crc, p, len);
 }
 EXPORT_SYMBOL(crc32_be_arch);
 
+static int __init crc32_riscv_init(void)
+{
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
+		crc32_optimizations = CRC32_LE_OPTIMIZATION |
+				      CRC32_BE_OPTIMIZATION |
+				      CRC32C_OPTIMIZATION;
+	return 0;
+}
+arch_initcall(crc32_riscv_init);
+
+static void __exit crc32_riscv_exit(void)
+{
+}
+module_exit(crc32_riscv_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Accelerated CRC32 implementation with Zbc extension");
diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 58c632533b08..bf26d454b60d 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -35,10 +35,25 @@ static inline u32 __pure __crc32c_le(u32 crc, const u8 *p, size_t len)
 	if (IS_ENABLED(CONFIG_CRC32_ARCH))
 		return crc32c_le_arch(crc, p, len);
 	return crc32c_le_base(crc, p, len);
 }
 
+/*
+ * crc32_optimizations contains flags that indicate which CRC32 library
+ * functions are using architecture-specific optimizations.  Unlike
+ * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
+ * variants and also whether any needed CPU features are available at runtime.
+ */
+#define CRC32_LE_OPTIMIZATION	BIT(0) /* crc32_le() is optimized */
+#define CRC32_BE_OPTIMIZATION	BIT(1) /* crc32_be() is optimized */
+#define CRC32C_OPTIMIZATION	BIT(2) /* __crc32c_le() is optimized */
+#if IS_ENABLED(CONFIG_CRC32_ARCH)
+extern u32 crc32_optimizations;
+#else
+#define crc32_optimizations 0
+#endif
+
 /**
  * crc32_le_combine - Combine two crc32 check values into one. For two
  * 		      sequences of bytes, seq1 and seq2 with lengths len1
  * 		      and len2, crc32_le() check values were calculated
  * 		      for each, crc1 and crc2.
diff --git a/lib/crc32.c b/lib/crc32.c
index 47151624332e..194de73f30f8 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -336,5 +336,10 @@ u32 __pure crc32_be_base(u32 crc, const u8 *p, size_t len)
 {
 	return crc32_be_generic(crc, p, len, crc32table_be, CRC32_POLY_BE);
 }
 #endif
 EXPORT_SYMBOL(crc32_be_base);
+
+#if IS_ENABLED(CONFIG_CRC32_ARCH)
+u32 crc32_optimizations;
+EXPORT_SYMBOL(crc32_optimizations);
+#endif
-- 
2.47.0


