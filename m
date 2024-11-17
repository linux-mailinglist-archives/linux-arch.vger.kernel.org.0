Return-Path: <linux-arch+bounces-9123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82EF9D01AC
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DFAB2561B
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68055126C09;
	Sun, 17 Nov 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEihOEeZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCB83A17;
	Sun, 17 Nov 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803038; cv=none; b=ifoonNMVlGvfj4aTPN4bDQ2ULyuTC59iOKzn5cNwi/ISnBdo8MDOBPVtu/bZM3Lw/Oe8HX9QwJXx6j72FJkuT4+WVOASL1BGQGtL5lmGx1LwU0aLufKWHtIcm3d4pbSaGVsysmiDnTq8XMeNdwDprQM2w91UffKWI9EHwEYMFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803038; c=relaxed/simple;
	bh=L8iJ9JStDTqpmtdnZloUKPKtnPySgcuceskFsXeoeLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP2+WHLLjL3BRP69MVrLXWwWdklwj9q2cn5ehLme6YD9G14Bnlt/5AjbBYuWGdUndLVtFd6aUUuYebp9dPhFObxE9lGcUabbE5C2zlmVeW0bJDWEBenVWGwgl0mUStsNBHsx6qSREzOWuZW8KvxwUi2mZ0qy1OJX10UKC+un7f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEihOEeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37CCC4CEC3;
	Sun, 17 Nov 2024 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803038;
	bh=L8iJ9JStDTqpmtdnZloUKPKtnPySgcuceskFsXeoeLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KEihOEeZ9pps1Gmhd03DWXm2C9+PD1QlRllHUMri7/q2NQvuv0/RFaVQWNRbEW8oW
	 BtUyHKZRQZi1Tz2zk1m+P1LsHGo9Hv1HtqBFLY974f/LLQt7LPGuUwlFeQrWL3UBed
	 KxIf0qSTOsaup8AqhiXce7laYg2kjw4/wYEDCbfAv9UfzR3lx8slmqYw/THIALTrjO
	 akw/eb3eXF18JfGYvONTeKAQJfP7V50dgIo1sa0UQ294tqk3vH/DRDN+I8oDNku1Hx
	 FTkU7VkZkR6TdhFCuDMLz7ZDDT3BatSTPmOZWO/yq4jRu0FYj9IUG7TH7YJwlj31Uz
	 XzKKBvHnTL8bw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 10/11] powerpc/crc: delete obsolete crc-vpmsum_test.c
Date: Sat, 16 Nov 2024 16:22:43 -0800
Message-ID: <20241117002244.105200-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Delete crc-vpmsum_test.c, since its functionality is now covered by the
new crc_kunit.c as well as the crypto subsystem's fuzz tests.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/configs/ppc64_defconfig  |   1 -
 arch/powerpc/crypto/Kconfig           |   9 --
 arch/powerpc/crypto/Makefile          |   1 -
 arch/powerpc/crypto/crc-vpmsum_test.c | 133 --------------------------
 4 files changed, 144 deletions(-)
 delete mode 100644 arch/powerpc/crypto/crc-vpmsum_test.c

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index ec91e0104713..c6445c2b3131 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -388,11 +388,10 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRYPTO_VPMSUM_TESTER=m
 CONFIG_CRYPTO_MD5_PPC=m
 CONFIG_CRYPTO_SHA1_PPC=m
 CONFIG_CRYPTO_AES_GCM_P10=m
 CONFIG_CRYPTO_DEV_NX=y
 CONFIG_CRYPTO_DEV_NX_ENCRYPT=m
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 90ac79513923..e48d23fb7ea5 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -11,19 +11,10 @@ config CRYPTO_CURVE25519_PPC64
 	  Curve25519 algorithm
 
 	  Architecture: PowerPC64
 	  - Little-endian
 
-config CRYPTO_VPMSUM_TESTER
-	tristate "CRC32c and CRC32T10DIF hardware acceleration tester"
-	depends on CRYPTO_CRC32C && CRC32_ARCH
-	depends on CRYPTO_CRCT10DIF && CRC_T10DIF_ARCH
-	help
-	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
-	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
-	  Unless you are testing these algorithms, you don't need this.
-
 config CRYPTO_MD5_PPC
 	tristate "Digests: MD5"
 	depends on PPC
 	select CRYPTO_HASH
 	help
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index d2238ac7e52c..9b38f4a7bc15 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -8,11 +8,10 @@
 obj-$(CONFIG_CRYPTO_AES_PPC_SPE) += aes-ppc-spe.o
 obj-$(CONFIG_CRYPTO_MD5_PPC) += md5-ppc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC) += sha1-powerpc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC_SPE) += sha1-ppc-spe.o
 obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
-obj-$(CONFIG_CRYPTO_VPMSUM_TESTER) += crc-vpmsum_test.o
 obj-$(CONFIG_CRYPTO_AES_GCM_P10) += aes-gcm-p10-crypto.o
 obj-$(CONFIG_CRYPTO_CHACHA20_P10) += chacha-p10-crypto.o
 obj-$(CONFIG_CRYPTO_POLY1305_P10) += poly1305-p10-crypto.o
 obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 obj-$(CONFIG_CRYPTO_CURVE25519_PPC64) += curve25519-ppc64le.o
diff --git a/arch/powerpc/crypto/crc-vpmsum_test.c b/arch/powerpc/crypto/crc-vpmsum_test.c
deleted file mode 100644
index c61a874a3a5c..000000000000
--- a/arch/powerpc/crypto/crc-vpmsum_test.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CRC vpmsum tester
- * Copyright 2017 Daniel Axtens, IBM Corporation.
- */
-
-#include <linux/crc-t10dif.h>
-#include <linux/crc32.h>
-#include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/random.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/cpufeature.h>
-#include <asm/switch_to.h>
-
-static unsigned long iterations = 10000;
-
-#define MAX_CRC_LENGTH 65535
-
-
-static int __init crc_test_init(void)
-{
-	u16 crc16 = 0, verify16 = 0;
-	__le32 verify32le = 0;
-	unsigned char *data;
-	u32 verify32 = 0;
-	unsigned long i;
-	__le32 crc32;
-	int ret;
-
-	struct crypto_shash *crct10dif_tfm;
-	struct crypto_shash *crc32c_tfm;
-
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-		return -ENODEV;
-
-	data = kmalloc(MAX_CRC_LENGTH, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
-
-	if (IS_ERR(crct10dif_tfm)) {
-		pr_err("Error allocating crc-t10dif\n");
-		goto free_buf;
-	}
-
-	crc32c_tfm = crypto_alloc_shash("crc32c", 0, 0);
-
-	if (IS_ERR(crc32c_tfm)) {
-		pr_err("Error allocating crc32c\n");
-		goto free_16;
-	}
-
-	do {
-		SHASH_DESC_ON_STACK(crct10dif_shash, crct10dif_tfm);
-		SHASH_DESC_ON_STACK(crc32c_shash, crc32c_tfm);
-
-		crct10dif_shash->tfm = crct10dif_tfm;
-		ret = crypto_shash_init(crct10dif_shash);
-
-		if (ret) {
-			pr_err("Error initing crc-t10dif\n");
-			goto free_32;
-		}
-
-
-		crc32c_shash->tfm = crc32c_tfm;
-		ret = crypto_shash_init(crc32c_shash);
-
-		if (ret) {
-			pr_err("Error initing crc32c\n");
-			goto free_32;
-		}
-
-		pr_info("crc-vpmsum_test begins, %lu iterations\n", iterations);
-		for (i=0; i<iterations; i++) {
-			size_t offset = get_random_u32_below(16);
-			size_t len = get_random_u32_below(MAX_CRC_LENGTH);
-
-			if (len <= offset)
-				continue;
-			get_random_bytes(data, len);
-			len -= offset;
-
-			crypto_shash_update(crct10dif_shash, data+offset, len);
-			crypto_shash_final(crct10dif_shash, (u8 *)(&crc16));
-			verify16 = crc_t10dif_generic(verify16, data+offset, len);
-
-
-			if (crc16 != verify16) {
-				pr_err("FAILURE in CRC16: got 0x%04x expected 0x%04x (len %lu)\n",
-				       crc16, verify16, len);
-				break;
-			}
-
-			crypto_shash_update(crc32c_shash, data+offset, len);
-			crypto_shash_final(crc32c_shash, (u8 *)(&crc32));
-			verify32 = le32_to_cpu(verify32le);
-		        verify32le = ~cpu_to_le32(__crc32c_le(~verify32, data+offset, len));
-			if (crc32 != verify32le) {
-				pr_err("FAILURE in CRC32: got 0x%08x expected 0x%08x (len %lu)\n",
-				       crc32, verify32, len);
-				break;
-			}
-		cond_resched();
-		}
-		pr_info("crc-vpmsum_test done, completed %lu iterations\n", i);
-	} while (0);
-
-free_32:
-	crypto_free_shash(crc32c_tfm);
-
-free_16:
-	crypto_free_shash(crct10dif_tfm);
-
-free_buf:
-	kfree(data);
-
-	return 0;
-}
-
-static void __exit crc_test_exit(void) {}
-
-module_init(crc_test_init);
-module_exit(crc_test_exit);
-module_param(iterations, long, 0400);
-
-MODULE_AUTHOR("Daniel Axtens <dja@axtens.net>");
-MODULE_DESCRIPTION("Vector polynomial multiply-sum CRC tester");
-MODULE_LICENSE("GPL");
-- 
2.47.0


