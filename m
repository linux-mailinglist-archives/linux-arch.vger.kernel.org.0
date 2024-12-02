Return-Path: <linux-arch+bounces-9207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B49DF7FE
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C6AB22238
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD1917084F;
	Mon,  2 Dec 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US1regxR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D099166308;
	Mon,  2 Dec 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101775; cv=none; b=qBJZoeXWTJ0U/L+r9Yq3LFCqgCxj7dRN8yUcqphxUb9bZBv+qxGg+ho67B//nxkQyEgSN5RB6/+CB+MDmF7Wl+6zySAWEjWBPM/ps7TsCgYa4n8JR8zv1ekv+UtW7ypqk1vF6iV+K3a1PsV6I1QaDfnUsJjnMVlCZb7MLhoL2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101775; c=relaxed/simple;
	bh=mzXFZZ0Vz/BRB/L8KPcvHF3jTMUR8RtIn7ipn8nX7g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C06T6PgAfYEvptsjatupkh0XHxBUKle00lmOROIr+YiPvUKhd5GlUEXB/DCk4UQQaQw7K/ypHQ+K2lJ08k4sG1kWsN8/beam2PcslyJvfsKYGJZX4l5nSVCEGbQfhJ3BcvkRE1IfVsG1+HpurZoMdEhRVVtgLPYNFSW33v4mFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US1regxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAC1C4CEDC;
	Mon,  2 Dec 2024 01:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101774;
	bh=mzXFZZ0Vz/BRB/L8KPcvHF3jTMUR8RtIn7ipn8nX7g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=US1regxRVbMk/4uvzySwCFeNkxoYNQ94lMbWSxIZTHAkkd5Z96Ss7Xhfo6oWSayYd
	 ZwghVlyjvVPk8m+Qu1guk6X1lfppEt5y9w50yTMWyQq8QJOjTbCEWBkgyTyuRKxnQE
	 ufgOr1kPph2iib5kp5nY2bo2hSEwfFboPSEKeLpgcFKqHec8NJjfzkznHPXFY/oC03
	 ozPa8a13L8/pSOu6I4NR8vy2SGjH68Q6t/wsC3hRsKxx5Mv+nK/ixpp/hRij2dd8CE
	 Z2TSyP3nrCeYl+0+Efem28ljoF40vgj6y1rnVFpy9kL9TRl6JREdT7VQP0MMYJYR80
	 Zx6g8YrIoJA9A==
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
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 10/19] sparc/crc32: expose CRC32 functions through lib
Date: Sun,  1 Dec 2024 17:08:35 -0800
Message-ID: <20241202010844.144356-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
References: <20241202010844.144356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move the sparc CRC32C assembly code into the lib directory and wire it
up to the library interface.  This allows it to be used without going
through the crypto API.  It remains usable via the crypto API too via
the shash algorithms that use the library interface.  Thus all the
arch-specific "shash" code becomes unnecessary and is removed.

Note: to see the diff from arch/sparc/crypto/crc32c_glue.c to
arch/sparc/lib/crc32_glue.c, view this commit with 'git show -M10'.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/sparc/Kconfig                      |   1 +
 arch/sparc/crypto/Kconfig               |  10 --
 arch/sparc/crypto/Makefile              |   4 -
 arch/sparc/crypto/crc32c_glue.c         | 184 ------------------------
 arch/sparc/lib/Makefile                 |   2 +
 arch/sparc/lib/crc32_glue.c             |  93 ++++++++++++
 arch/sparc/{crypto => lib}/crc32c_asm.S |   2 +-
 7 files changed, 97 insertions(+), 199 deletions(-)
 delete mode 100644 arch/sparc/crypto/crc32c_glue.c
 create mode 100644 arch/sparc/lib/crc32_glue.c
 rename arch/sparc/{crypto => lib}/crc32c_asm.S (92%)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index dcfdb7f1dae9..0f88123925a4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -108,10 +108,11 @@ config SPARC64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select ARCH_HAS_CRC32
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
 config CPU_BIG_ENDIAN
diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index cfe5102b1c68..e858597de89d 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -14,20 +14,10 @@ config CRYPTO_DES_SPARC64
 	  Length-preserving ciphers: DES with ECB and CBC modes
 	  Length-preserving ciphers: Tripe DES EDE with ECB and CBC modes
 
 	  Architecture: sparc64
 
-config CRYPTO_CRC32C_SPARC64
-	tristate "CRC32c"
-	depends on SPARC64
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
-
-	  Architecture: sparc64
-
 config CRYPTO_MD5_SPARC64
 	tristate "Digests: MD5"
 	depends on SPARC64
 	select CRYPTO_MD5
 	select CRYPTO_HASH
diff --git a/arch/sparc/crypto/Makefile b/arch/sparc/crypto/Makefile
index d257186c27d1..a2d7fca40cb4 100644
--- a/arch/sparc/crypto/Makefile
+++ b/arch/sparc/crypto/Makefile
@@ -10,17 +10,13 @@ obj-$(CONFIG_CRYPTO_MD5_SPARC64) += md5-sparc64.o
 
 obj-$(CONFIG_CRYPTO_AES_SPARC64) += aes-sparc64.o
 obj-$(CONFIG_CRYPTO_DES_SPARC64) += des-sparc64.o
 obj-$(CONFIG_CRYPTO_CAMELLIA_SPARC64) += camellia-sparc64.o
 
-obj-$(CONFIG_CRYPTO_CRC32C_SPARC64) += crc32c-sparc64.o
-
 sha1-sparc64-y := sha1_asm.o sha1_glue.o
 sha256-sparc64-y := sha256_asm.o sha256_glue.o
 sha512-sparc64-y := sha512_asm.o sha512_glue.o
 md5-sparc64-y := md5_asm.o md5_glue.o
 
 aes-sparc64-y := aes_asm.o aes_glue.o
 des-sparc64-y := des_asm.o des_glue.o
 camellia-sparc64-y := camellia_asm.o camellia_glue.o
-
-crc32c-sparc64-y := crc32c_asm.o crc32c_glue.o
diff --git a/arch/sparc/crypto/crc32c_glue.c b/arch/sparc/crypto/crc32c_glue.c
deleted file mode 100644
index 913b9a09e885..000000000000
--- a/arch/sparc/crypto/crc32c_glue.c
+++ /dev/null
@@ -1,184 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Glue code for CRC32C optimized for sparc64 crypto opcodes.
- *
- * This is based largely upon arch/x86/crypto/crc32c-intel.c
- *
- * Copyright (C) 2008 Intel Corporation
- * Authors: Austin Zhang <austin_zhang@linux.intel.com>
- *          Kent Liu <kent.liu@intel.com>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/crc32.h>
-
-#include <crypto/internal/hash.h>
-
-#include <asm/pstate.h>
-#include <asm/elf.h>
-#include <linux/unaligned.h>
-
-#include "opcodes.h"
-
-/*
- * Setting the seed allows arbitrary accumulators and flexible XOR policy
- * If your algorithm starts with ~0, then XOR with ~0 before you set
- * the seed.
- */
-static int crc32c_sparc64_setkey(struct crypto_shash *hash, const u8 *key,
-				 unsigned int keylen)
-{
-	u32 *mctx = crypto_shash_ctx(hash);
-
-	if (keylen != sizeof(u32))
-		return -EINVAL;
-	*mctx = get_unaligned_le32(key);
-	return 0;
-}
-
-static int crc32c_sparc64_init(struct shash_desc *desc)
-{
-	u32 *mctx = crypto_shash_ctx(desc->tfm);
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = *mctx;
-
-	return 0;
-}
-
-extern void crc32c_sparc64(u32 *crcp, const u64 *data, unsigned int len);
-
-static u32 crc32c_compute(u32 crc, const u8 *data, unsigned int len)
-{
-	unsigned int n = -(uintptr_t)data & 7;
-
-	if (n) {
-		/* Data isn't 8-byte aligned.  Align it. */
-		n = min(n, len);
-		crc = __crc32c_le(crc, data, n);
-		data += n;
-		len -= n;
-	}
-	n = len & ~7U;
-	if (n) {
-		crc32c_sparc64(&crc, (const u64 *)data, n);
-		data += n;
-		len -= n;
-	}
-	if (len)
-		crc = __crc32c_le(crc, data, len);
-	return crc;
-}
-
-static int crc32c_sparc64_update(struct shash_desc *desc, const u8 *data,
-				 unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	*crcp = crc32c_compute(*crcp, data, len);
-	return 0;
-}
-
-static int __crc32c_sparc64_finup(const u32 *crcp, const u8 *data,
-				  unsigned int len, u8 *out)
-{
-	put_unaligned_le32(~crc32c_compute(*crcp, data, len), out);
-	return 0;
-}
-
-static int crc32c_sparc64_finup(struct shash_desc *desc, const u8 *data,
-				unsigned int len, u8 *out)
-{
-	return __crc32c_sparc64_finup(shash_desc_ctx(desc), data, len, out);
-}
-
-static int crc32c_sparc64_final(struct shash_desc *desc, u8 *out)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
-	put_unaligned_le32(~*crcp, out);
-	return 0;
-}
-
-static int crc32c_sparc64_digest(struct shash_desc *desc, const u8 *data,
-				 unsigned int len, u8 *out)
-{
-	return __crc32c_sparc64_finup(crypto_shash_ctx(desc->tfm), data, len,
-				      out);
-}
-
-static int crc32c_sparc64_cra_init(struct crypto_tfm *tfm)
-{
-	u32 *key = crypto_tfm_ctx(tfm);
-
-	*key = ~0;
-
-	return 0;
-}
-
-#define CHKSUM_BLOCK_SIZE	1
-#define CHKSUM_DIGEST_SIZE	4
-
-static struct shash_alg alg = {
-	.setkey			=	crc32c_sparc64_setkey,
-	.init			=	crc32c_sparc64_init,
-	.update			=	crc32c_sparc64_update,
-	.final			=	crc32c_sparc64_final,
-	.finup			=	crc32c_sparc64_finup,
-	.digest			=	crc32c_sparc64_digest,
-	.descsize		=	sizeof(u32),
-	.digestsize		=	CHKSUM_DIGEST_SIZE,
-	.base			=	{
-		.cra_name		=	"crc32c",
-		.cra_driver_name	=	"crc32c-sparc64",
-		.cra_priority		=	SPARC_CR_OPCODE_PRIORITY,
-		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
-		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
-		.cra_ctxsize		=	sizeof(u32),
-		.cra_module		=	THIS_MODULE,
-		.cra_init		=	crc32c_sparc64_cra_init,
-	}
-};
-
-static bool __init sparc64_has_crc32c_opcode(void)
-{
-	unsigned long cfr;
-
-	if (!(sparc64_elf_hwcap & HWCAP_SPARC_CRYPTO))
-		return false;
-
-	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
-	if (!(cfr & CFR_CRC32C))
-		return false;
-
-	return true;
-}
-
-static int __init crc32c_sparc64_mod_init(void)
-{
-	if (sparc64_has_crc32c_opcode()) {
-		pr_info("Using sparc64 crc32c opcode optimized CRC32C implementation\n");
-		return crypto_register_shash(&alg);
-	}
-	pr_info("sparc64 crc32c opcode not available.\n");
-	return -ENODEV;
-}
-
-static void __exit crc32c_sparc64_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-module_init(crc32c_sparc64_mod_init);
-module_exit(crc32c_sparc64_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("CRC32c (Castagnoli), sparc64 crc32c opcode accelerated");
-
-MODULE_ALIAS_CRYPTO("crc32c");
-
-#include "crop_devid.c"
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index ee5091dd67ed..5724d0f356eb 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -51,5 +51,7 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
+obj-$(CONFIG_CRC32_ARCH) += crc32-sparc.o
+crc32-sparc-y := crc32_glue.o crc32c_asm.o
diff --git a/arch/sparc/lib/crc32_glue.c b/arch/sparc/lib/crc32_glue.c
new file mode 100644
index 000000000000..41076d2b1fd2
--- /dev/null
+++ b/arch/sparc/lib/crc32_glue.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Glue code for CRC32C optimized for sparc64 crypto opcodes.
+ *
+ * This is based largely upon arch/x86/crypto/crc32c-intel.c
+ *
+ * Copyright (C) 2008 Intel Corporation
+ * Authors: Austin Zhang <austin_zhang@linux.intel.com>
+ *          Kent Liu <kent.liu@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crc32.h>
+#include <asm/pstate.h>
+#include <asm/elf.h>
+
+static DEFINE_STATIC_KEY_FALSE(have_crc32c_opcode);
+
+u32 crc32_le_arch(u32 crc, const u8 *data, size_t len)
+{
+	return crc32_le_base(crc, data, len);
+}
+EXPORT_SYMBOL(crc32_le_arch);
+
+void crc32c_sparc64(u32 *crcp, const u64 *data, size_t len);
+
+u32 crc32c_le_arch(u32 crc, const u8 *data, size_t len)
+{
+	size_t n = -(uintptr_t)data & 7;
+
+	if (!static_branch_likely(&have_crc32c_opcode))
+		return crc32c_le_base(crc, data, len);
+
+	if (n) {
+		/* Data isn't 8-byte aligned.  Align it. */
+		n = min(n, len);
+		crc = crc32c_le_base(crc, data, n);
+		data += n;
+		len -= n;
+	}
+	n = len & ~7U;
+	if (n) {
+		crc32c_sparc64(&crc, (const u64 *)data, n);
+		data += n;
+		len -= n;
+	}
+	if (len)
+		crc = crc32c_le_base(crc, data, len);
+	return crc;
+}
+EXPORT_SYMBOL(crc32c_le_arch);
+
+u32 crc32_be_arch(u32 crc, const u8 *data, size_t len)
+{
+	return crc32_be_base(crc, data, len);
+}
+EXPORT_SYMBOL(crc32_be_arch);
+
+static int __init crc32_sparc_init(void)
+{
+	unsigned long cfr;
+
+	if (!(sparc64_elf_hwcap & HWCAP_SPARC_CRYPTO))
+		return 0;
+
+	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
+	if (!(cfr & CFR_CRC32C))
+		return 0;
+
+	static_branch_enable(&have_crc32c_opcode);
+	pr_info("Using sparc64 crc32c opcode optimized CRC32C implementation\n");
+	return 0;
+}
+arch_initcall(crc32_sparc_init);
+
+static void __exit crc32_sparc_exit(void)
+{
+}
+module_exit(crc32_sparc_exit);
+
+u32 crc32_optimizations(void)
+{
+	if (static_key_enabled(&have_crc32c_opcode))
+		return CRC32C_OPTIMIZATION;
+	return 0;
+}
+EXPORT_SYMBOL(crc32_optimizations);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CRC32c (Castagnoli), sparc64 crc32c opcode accelerated");
diff --git a/arch/sparc/crypto/crc32c_asm.S b/arch/sparc/lib/crc32c_asm.S
similarity index 92%
rename from arch/sparc/crypto/crc32c_asm.S
rename to arch/sparc/lib/crc32c_asm.S
index b8659a479242..ee454fa6aed6 100644
--- a/arch/sparc/crypto/crc32c_asm.S
+++ b/arch/sparc/lib/crc32c_asm.S
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/visasm.h>
 #include <asm/asi.h>
 
-#include "opcodes.h"
+#include "../crypto/opcodes.h"
 
 ENTRY(crc32c_sparc64)
 	/* %o0=crc32p, %o1=data_ptr, %o2=len */
 	VISEntryHalf
 	lda	[%o0] ASI_PL, %f1
-- 
2.47.1


