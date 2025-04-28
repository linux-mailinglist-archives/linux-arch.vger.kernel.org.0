Return-Path: <linux-arch+bounces-11646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16CA9E7A6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 07:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1799A189C7C5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560981FF1DA;
	Mon, 28 Apr 2025 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="VirMdEld"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009511E5B7B;
	Mon, 28 Apr 2025 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817456; cv=none; b=KI5hSQZodKz36TNb/d7+lSPtaM+QwlbUErifihTAxWW0fSj3NDqMhehwVUL8C/8LtOBrsixzVQHmzR3jCHHtPZT0IJOLPr9lu5pTDbqOZSCxGLJyyFKKHip1kYp+zva5dZv+mNqOEpH7PHO2s5Wcby4lSQjGk0+p4+d3XDdUxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817456; c=relaxed/simple;
	bh=epqr+JOPE7whtTWxvsuinnKUCyP4lDemUYxk/GSxuys=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=HKt6EXVE3UTGE5D9FraYo8pL3qPWxqm2YkIhpfaKeQbjYRvno8zWfFpneUBB8u+hAX+P6VLxlaOxPXEhiPks/r1ZmYxme+VMY90mt/k8e0s+4A+IVSaJF3I0EJi9J+PBlLXRGV0X3zqfr78BX9fdeIainX/zyiXYDNGmZSTh8V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=VirMdEld; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tAp+Yq2oPYdQjefDhIqTpmvZxjMW/FXB4OTXZxlKT5Q=; b=VirMdEldr5yxZgBao5sMAQbiO3
	+Rpi9mN0jhAqTSP5VzAjtpyFnEYx+p8tuSU4Lm0FgE8vUsAwF2eNxb7dOFDcbLQUFjuBVmCeKC7Ht
	3ylIkCysveNgVWl1D9uiI9UiqedqGvUZ91mIPdRjNKGVN66k+zhVbCqk2S7QZ/t0jm/D5H7QQCAQH
	D2uefr3GZaxgPCOvZCdIrS8TISrD45riYcJQsknvRW3gsk8m9+zUN15dHOLWpbIkBUqjBWbGPRUeI
	14BEvOCo7YLsbN130ta3eEgdPNMmd49ThLP6RdpXACt2NX8ONY/N1HsPywAJ9Mr0KrKVdJvxZADF3
	17LTxDRg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9Grt-001WTO-1C;
	Mon, 28 Apr 2025 13:17:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 13:17:25 +0800
Date: Mon, 28 Apr 2025 13:17:25 +0800
Message-Id: <22250663cc30d815728d838d7bcc712ceba8bedf.1745816372.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745816372.git.herbert@gondor.apana.org.au>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 10/13] crypto: sparc/sha256 - implement library instead of
 shash
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld " <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Instead of providing crypto_shash algorithms for the arch-optimized
SHA-256 code, instead implement the SHA-256 library.  This is much
simpler, it makes the SHA-256 library functions be arch-optimized, and
it fixes the longstanding issue where the arch-optimized SHA-256 was
disabled by default.  SHA-256 still remains available through
crypto_shash, but individual architectures no longer need to handle it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/sparc/crypto/Kconfig                |  10 --
 arch/sparc/crypto/Makefile               |   2 -
 arch/sparc/crypto/sha256_glue.c          | 128 -----------------------
 arch/sparc/lib/Makefile                  |   1 +
 arch/sparc/lib/crypto/Kconfig            |   8 ++
 arch/sparc/lib/crypto/Makefile           |   4 +
 arch/sparc/lib/crypto/sha256.c           |  64 ++++++++++++
 arch/sparc/{ => lib}/crypto/sha256_asm.S |   2 +-
 lib/crypto/Kconfig                       |   3 +
 9 files changed, 81 insertions(+), 141 deletions(-)
 delete mode 100644 arch/sparc/crypto/sha256_glue.c
 create mode 100644 arch/sparc/lib/crypto/Kconfig
 create mode 100644 arch/sparc/lib/crypto/Makefile
 create mode 100644 arch/sparc/lib/crypto/sha256.c
 rename arch/sparc/{ => lib}/crypto/sha256_asm.S (96%)

diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index e858597de89d..a6ba319c42dc 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -36,16 +36,6 @@ config CRYPTO_SHA1_SPARC64
 
 	  Architecture: sparc64
 
-config CRYPTO_SHA256_SPARC64
-	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on SPARC64
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: sparc64 using crypto instructions, when available
-
 config CRYPTO_SHA512_SPARC64
 	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on SPARC64
diff --git a/arch/sparc/crypto/Makefile b/arch/sparc/crypto/Makefile
index a2d7fca40cb4..701c39edb0d7 100644
--- a/arch/sparc/crypto/Makefile
+++ b/arch/sparc/crypto/Makefile
@@ -4,7 +4,6 @@
 #
 
 obj-$(CONFIG_CRYPTO_SHA1_SPARC64) += sha1-sparc64.o
-obj-$(CONFIG_CRYPTO_SHA256_SPARC64) += sha256-sparc64.o
 obj-$(CONFIG_CRYPTO_SHA512_SPARC64) += sha512-sparc64.o
 obj-$(CONFIG_CRYPTO_MD5_SPARC64) += md5-sparc64.o
 
@@ -13,7 +12,6 @@ obj-$(CONFIG_CRYPTO_DES_SPARC64) += des-sparc64.o
 obj-$(CONFIG_CRYPTO_CAMELLIA_SPARC64) += camellia-sparc64.o
 
 sha1-sparc64-y := sha1_asm.o sha1_glue.o
-sha256-sparc64-y := sha256_asm.o sha256_glue.o
 sha512-sparc64-y := sha512_asm.o sha512_glue.o
 md5-sparc64-y := md5_asm.o md5_glue.o
 
diff --git a/arch/sparc/crypto/sha256_glue.c b/arch/sparc/crypto/sha256_glue.c
deleted file mode 100644
index 25008603a986..000000000000
--- a/arch/sparc/crypto/sha256_glue.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Glue code for SHA256 hashing optimized for sparc64 crypto opcodes.
- *
- * This is based largely upon crypto/sha256_generic.c
- *
- * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
- * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
- * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- * SHA224 Support Copyright 2007 Intel Corporation <jonathan.lynch@intel.com>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <asm/elf.h>
-#include <asm/opcodes.h>
-#include <asm/pstate.h>
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-asmlinkage void sha256_sparc64_transform(u32 *digest, const char *data,
-					 unsigned int rounds);
-
-static void sha256_block(struct crypto_sha256_state *sctx, const u8 *src,
-			 int blocks)
-{
-	sha256_sparc64_transform(sctx->state, src, blocks);
-}
-
-static int sha256_sparc64_update(struct shash_desc *desc, const u8 *data,
-				 unsigned int len)
-{
-	return sha256_base_do_update_blocks(desc, data, len, sha256_block);
-}
-
-static int sha256_sparc64_finup(struct shash_desc *desc, const u8 *src,
-				unsigned int len, u8 *out)
-{
-	sha256_base_do_finup(desc, src, len, sha256_block);
-	return sha256_base_finish(desc, out);
-}
-
-static struct shash_alg sha256_alg = {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	sha256_sparc64_update,
-	.finup		=	sha256_sparc64_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name=	"sha256-sparc64",
-		.cra_priority	=	SPARC_CR_OPCODE_PRIORITY,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-};
-
-static struct shash_alg sha224_alg = {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	sha256_sparc64_update,
-	.finup		=	sha256_sparc64_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name=	"sha224-sparc64",
-		.cra_priority	=	SPARC_CR_OPCODE_PRIORITY,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-};
-
-static bool __init sparc64_has_sha256_opcode(void)
-{
-	unsigned long cfr;
-
-	if (!(sparc64_elf_hwcap & HWCAP_SPARC_CRYPTO))
-		return false;
-
-	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
-	if (!(cfr & CFR_SHA256))
-		return false;
-
-	return true;
-}
-
-static int __init sha256_sparc64_mod_init(void)
-{
-	if (sparc64_has_sha256_opcode()) {
-		int ret = crypto_register_shash(&sha224_alg);
-		if (ret < 0)
-			return ret;
-
-		ret = crypto_register_shash(&sha256_alg);
-		if (ret < 0) {
-			crypto_unregister_shash(&sha224_alg);
-			return ret;
-		}
-
-		pr_info("Using sparc64 sha256 opcode optimized SHA-256/SHA-224 implementation\n");
-		return 0;
-	}
-	pr_info("sparc64 sha256 opcode not available.\n");
-	return -ENODEV;
-}
-
-static void __exit sha256_sparc64_mod_fini(void)
-{
-	crypto_unregister_shash(&sha224_alg);
-	crypto_unregister_shash(&sha256_alg);
-}
-
-module_init(sha256_sparc64_mod_init);
-module_exit(sha256_sparc64_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithm, sparc64 sha256 opcode accelerated");
-
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_ALIAS_CRYPTO("sha256");
-
-#include "crop_devid.c"
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 5724d0f356eb..98887dc295a1 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -4,6 +4,7 @@
 
 asflags-y := -ansi -DST_DIV0=0x02
 
+obj-y                 += crypto/
 lib-$(CONFIG_SPARC32) += ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
 lib-y                 += strlen.o
diff --git a/arch/sparc/lib/crypto/Kconfig b/arch/sparc/lib/crypto/Kconfig
new file mode 100644
index 000000000000..e5c3e4d3dba6
--- /dev/null
+++ b/arch/sparc/lib/crypto/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_SHA256_SPARC64
+	tristate
+	depends on SPARC64
+	default CRYPTO_LIB_SHA256
+	select CRYPTO_ARCH_HAVE_LIB_SHA256
+	select CRYPTO_LIB_SHA256_GENERIC
diff --git a/arch/sparc/lib/crypto/Makefile b/arch/sparc/lib/crypto/Makefile
new file mode 100644
index 000000000000..75ee244ad6f7
--- /dev/null
+++ b/arch/sparc/lib/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_SHA256_SPARC64) += sha256-sparc64.o
+sha256-sparc64-y := sha256.o sha256_asm.o
diff --git a/arch/sparc/lib/crypto/sha256.c b/arch/sparc/lib/crypto/sha256.c
new file mode 100644
index 000000000000..b4fc475dcc40
--- /dev/null
+++ b/arch/sparc/lib/crypto/sha256.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SHA-256 accelerated using the sparc64 sha256 opcodes
+ *
+ * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ * SHA224 Support Copyright 2007 Intel Corporation <jonathan.lynch@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <asm/elf.h>
+#include <asm/opcodes.h>
+#include <asm/pstate.h>
+#include <crypto/internal/sha2.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_sha256_opcodes);
+
+asmlinkage void sha256_sparc64_transform(u32 state[SHA256_STATE_WORDS],
+					 const u8 *data, size_t nblocks);
+
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks)
+{
+	if (static_branch_likely(&have_sha256_opcodes))
+		sha256_sparc64_transform(state, data, nblocks);
+	else
+		sha256_blocks_generic(state, data, nblocks);
+}
+EXPORT_SYMBOL_GPL(sha256_blocks_arch);
+
+bool sha256_is_arch_optimized(void)
+{
+	return static_key_enabled(&have_sha256_opcodes);
+}
+EXPORT_SYMBOL_GPL(sha256_is_arch_optimized);
+
+static int __init sha256_sparc64_mod_init(void)
+{
+	unsigned long cfr;
+
+	if (!(sparc64_elf_hwcap & HWCAP_SPARC_CRYPTO))
+		return 0;
+
+	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
+	if (!(cfr & CFR_SHA256))
+		return 0;
+
+	static_branch_enable(&have_sha256_opcodes);
+	pr_info("Using sparc64 sha256 opcode optimized SHA-256/SHA-224 implementation\n");
+	return 0;
+}
+arch_initcall(sha256_sparc64_mod_init);
+
+static void __exit sha256_sparc64_mod_exit(void)
+{
+}
+module_exit(sha256_sparc64_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-256 accelerated using the sparc64 sha256 opcodes");
diff --git a/arch/sparc/crypto/sha256_asm.S b/arch/sparc/lib/crypto/sha256_asm.S
similarity index 96%
rename from arch/sparc/crypto/sha256_asm.S
rename to arch/sparc/lib/crypto/sha256_asm.S
index 8ce88611e98a..ddcdd3daf31e 100644
--- a/arch/sparc/crypto/sha256_asm.S
+++ b/arch/sparc/lib/crypto/sha256_asm.S
@@ -4,7 +4,7 @@
 #include <asm/visasm.h>
 
 ENTRY(sha256_sparc64_transform)
-	/* %o0 = digest, %o1 = data, %o2 = rounds */
+	/* %o0 = state, %o1 = data, %o2 = nblocks */
 	VISEntryHalf
 	ld	[%o0 + 0x00], %f0
 	ld	[%o0 + 0x04], %f1
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index ad0a4705682c..1ec1466108cc 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -189,6 +189,9 @@ endif
 if S390
 source "arch/s390/lib/crypto/Kconfig"
 endif
+if SPARC
+source "arch/sparc/lib/crypto/Kconfig"
+endif
 if X86
 source "arch/x86/lib/crypto/Kconfig"
 endif
-- 
2.39.5


