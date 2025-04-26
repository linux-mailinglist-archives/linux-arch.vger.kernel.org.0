Return-Path: <linux-arch+bounces-11585-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6480A9D881
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 08:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AEB1C008A2
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 06:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B871DE2D6;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnCx345e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF631DB127;
	Sat, 26 Apr 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650300; cv=none; b=CP4r65iRxZSOgry3lP1YjybHf8tbmN/C90o9LywMNHXXWZWq+RJlVnIvVq1956QZnoAnznUPMeMonCSH+KTLL/GA0vaVJohjAfF2zJ1kpTprV+JB/7YHb/XjIpIadixs+znNX/YJPzP1s034/6ak63U3yV3HRyPWx/lq2DhHJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650300; c=relaxed/simple;
	bh=7OTqIkwdmpffU+s8j6eeEIbaROnKmoZXcrXawb6u+CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC5fg373uXzhI+/F/RAZrG6OeHb+6FkPFWqlGXU1ovxVTkHN2WFXty3o1yedko9vJ/v4gMjrKJzJPQ1Kt5f787GfhLwRgJZNMQ9e5Am48pekngP0tnhfO9ORJ+om528P3lKW8sMJ964WMppCIRmg8TJjxzsR862xSgONQbz63dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnCx345e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F4BC4AF09;
	Sat, 26 Apr 2025 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745650300;
	bh=7OTqIkwdmpffU+s8j6eeEIbaROnKmoZXcrXawb6u+CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnCx345e7k6GYaD7lp07RTdoJALGm0Tfdz0gHeobkIyurP2FL8Q9l0TWo24u40hnm
	 QwPtzIFBmgVtZhxe+efteMcjBppa9UsSZ9mbQFSHvO+4gfUSlf/i2I3vg5P01LQD5+
	 ipPNE5yLkVGOmLC/TPYIUTknJ50UVM7CRKFjPSDTOAQuMwJ6aW+yM1rIV8hLOCSN5s
	 +44qFB2STZfOSoq0UObYkUXB2E+fmUeFAxdymSRghOIk2UylTDGMHbrP7iaI1p9xAf
	 6KvALY4xh+QRmqgu8t56rWgm8OO9flVITwIGdbePxGOAR1NAw4UJty/M9XRnDGkhJN
	 5HHJKUmtoDHwA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 01/13] crypto: sha256 - support arch-optimized lib and expose through shash
Date: Fri, 25 Apr 2025 23:50:27 -0700
Message-ID: <20250426065041.1551914-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
References: <20250426065041.1551914-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

As has been done for various other algorithms, rework the design of the
SHA-256 library to support arch-optimized implementations, and make
crypto/sha256.c expose both generic and arch-optimized shash algorithms
that wrap the library functions.

This allows users of the SHA-256 library functions to take advantage of
the arch-optimized code, and this makes it much simpler to integrate
SHA-256 for each architecture.

Note that sha256_base.h is not used in the new design.  It will be
removed once all the architecture-specific code has been updated.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig                 |   1 +
 crypto/Makefile                |   3 +-
 crypto/sha256.c                | 201 +++++++++++++++++++++++++++++++++
 crypto/sha256_generic.c        | 102 -----------------
 include/crypto/internal/sha2.h |  28 +++++
 include/crypto/sha2.h          |  15 +--
 include/crypto/sha256_base.h   |   9 +-
 lib/crypto/Kconfig             |  19 ++++
 lib/crypto/sha256.c            | 122 +++++++++++++++++---
 9 files changed, 367 insertions(+), 133 deletions(-)
 create mode 100644 crypto/sha256.c
 delete mode 100644 crypto/sha256_generic.c
 create mode 100644 include/crypto/internal/sha2.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9878286d1d683..daf46053d25a5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -992,10 +992,11 @@ config CRYPTO_SHA1
 
 config CRYPTO_SHA256
 	tristate "SHA-224 and SHA-256"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA256_GENERIC
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180, ISO/IEC 10118-3)
 
 	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
 	  Used by the btrfs filesystem, Ceph, NFS, and SMB.
diff --git a/crypto/Makefile b/crypto/Makefile
index 5d2f2a28d8a07..2a23926b9f4f5 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -74,11 +74,12 @@ obj-$(CONFIG_CRYPTO_XCBC) += xcbc.o
 obj-$(CONFIG_CRYPTO_NULL2) += crypto_null.o
 obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
 obj-$(CONFIG_CRYPTO_RMD160) += rmd160.o
 obj-$(CONFIG_CRYPTO_SHA1) += sha1_generic.o
-obj-$(CONFIG_CRYPTO_SHA256) += sha256_generic.o
+obj-$(CONFIG_CRYPTO_SHA256) += sha256.o
+CFLAGS_sha256.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_SHA512) += sha512_generic.o
 obj-$(CONFIG_CRYPTO_SHA3) += sha3_generic.o
 obj-$(CONFIG_CRYPTO_SM3_GENERIC) += sm3_generic.o
 obj-$(CONFIG_CRYPTO_STREEBOG) += streebog_generic.o
 obj-$(CONFIG_CRYPTO_WP512) += wp512.o
diff --git a/crypto/sha256.c b/crypto/sha256.c
new file mode 100644
index 0000000000000..1c2edcf9453dc
--- /dev/null
+++ b/crypto/sha256.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Crypto API wrapper for the SHA-256 and SHA-224 library functions
+ *
+ * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ * SHA224 Support Copyright 2007 Intel Corporation <jonathan.lynch@intel.com>
+ */
+#include <crypto/internal/hash.h>
+#include <crypto/internal/sha2.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+const u8 sha224_zero_message_hash[SHA224_DIGEST_SIZE] = {
+	0xd1, 0x4a, 0x02, 0x8c, 0x2a, 0x3a, 0x2b, 0xc9, 0x47,
+	0x61, 0x02, 0xbb, 0x28, 0x82, 0x34, 0xc4, 0x15, 0xa2,
+	0xb0, 0x1f, 0x82, 0x8e, 0xa6, 0x2a, 0xc5, 0xb3, 0xe4,
+	0x2f
+};
+EXPORT_SYMBOL_GPL(sha224_zero_message_hash);
+
+const u8 sha256_zero_message_hash[SHA256_DIGEST_SIZE] = {
+	0xe3, 0xb0, 0xc4, 0x42, 0x98, 0xfc, 0x1c, 0x14,
+	0x9a, 0xfb, 0xf4, 0xc8, 0x99, 0x6f, 0xb9, 0x24,
+	0x27, 0xae, 0x41, 0xe4, 0x64, 0x9b, 0x93, 0x4c,
+	0xa4, 0x95, 0x99, 0x1b, 0x78, 0x52, 0xb8, 0x55
+};
+EXPORT_SYMBOL_GPL(sha256_zero_message_hash);
+
+static int crypto_sha256_init(struct shash_desc *desc)
+{
+	sha256_init(shash_desc_ctx(desc));
+	return 0;
+}
+
+static int crypto_sha256_update_generic(struct shash_desc *desc, const u8 *data,
+					unsigned int len)
+{
+	sha256_update_generic(shash_desc_ctx(desc), data, len);
+	return 0;
+}
+
+static int crypto_sha256_update_arch(struct shash_desc *desc, const u8 *data,
+				     unsigned int len)
+{
+	sha256_update(shash_desc_ctx(desc), data, len);
+	return 0;
+}
+
+static int crypto_sha256_final_generic(struct shash_desc *desc, u8 *out)
+{
+	sha256_final_generic(shash_desc_ctx(desc), out);
+	return 0;
+}
+
+static int crypto_sha256_final_arch(struct shash_desc *desc, u8 *out)
+{
+	sha256_final(shash_desc_ctx(desc), out);
+	return 0;
+}
+
+static int crypto_sha256_finup_generic(struct shash_desc *desc, const u8 *data,
+				       unsigned int len, u8 *out)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	sha256_update_generic(sctx, data, len);
+	sha256_final_generic(sctx, out);
+	return 0;
+}
+
+static int crypto_sha256_finup_arch(struct shash_desc *desc, const u8 *data,
+				    unsigned int len, u8 *out)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	sha256_update(sctx, data, len);
+	sha256_final(sctx, out);
+	return 0;
+}
+
+static int crypto_sha256_digest_generic(struct shash_desc *desc, const u8 *data,
+					unsigned int len, u8 *out)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	sha256_init(sctx);
+	sha256_update_generic(sctx, data, len);
+	sha256_final_generic(sctx, out);
+	return 0;
+}
+
+static int crypto_sha256_digest_arch(struct shash_desc *desc, const u8 *data,
+				     unsigned int len, u8 *out)
+{
+	sha256(data, len, out);
+	return 0;
+}
+
+static int crypto_sha224_init(struct shash_desc *desc)
+{
+	sha224_init(shash_desc_ctx(desc));
+	return 0;
+}
+
+static int crypto_sha224_final_generic(struct shash_desc *desc, u8 *out)
+{
+	sha224_final_generic(shash_desc_ctx(desc), out);
+	return 0;
+}
+
+static int crypto_sha224_final_arch(struct shash_desc *desc, u8 *out)
+{
+	sha224_final(shash_desc_ctx(desc), out);
+	return 0;
+}
+
+static struct shash_alg algs[] = {
+	{
+		.base.cra_name		= "sha256",
+		.base.cra_driver_name	= "sha256-generic",
+		.base.cra_priority	= 100,
+		.base.cra_blocksize	= SHA256_BLOCK_SIZE,
+		.base.cra_module	= THIS_MODULE,
+		.digestsize		= SHA256_DIGEST_SIZE,
+		.init			= crypto_sha256_init,
+		.update			= crypto_sha256_update_generic,
+		.final			= crypto_sha256_final_generic,
+		.finup			= crypto_sha256_finup_generic,
+		.digest			= crypto_sha256_digest_generic,
+		.descsize		= sizeof(struct sha256_state),
+	},
+	{
+		.base.cra_name		= "sha224",
+		.base.cra_driver_name	= "sha224-generic",
+		.base.cra_priority	= 100,
+		.base.cra_blocksize	= SHA224_BLOCK_SIZE,
+		.base.cra_module	= THIS_MODULE,
+		.digestsize		= SHA224_DIGEST_SIZE,
+		.init			= crypto_sha224_init,
+		.update			= crypto_sha256_update_generic,
+		.final			= crypto_sha224_final_generic,
+		.descsize		= sizeof(struct sha256_state),
+	},
+	{
+		.base.cra_name		= "sha256",
+		.base.cra_driver_name	= "sha256-" __stringify(ARCH),
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= SHA256_BLOCK_SIZE,
+		.base.cra_module	= THIS_MODULE,
+		.digestsize		= SHA256_DIGEST_SIZE,
+		.init			= crypto_sha256_init,
+		.update			= crypto_sha256_update_arch,
+		.final			= crypto_sha256_final_arch,
+		.finup			= crypto_sha256_finup_arch,
+		.digest			= crypto_sha256_digest_arch,
+		.descsize		= sizeof(struct sha256_state),
+	},
+	{
+		.base.cra_name		= "sha224",
+		.base.cra_driver_name	= "sha224-" __stringify(ARCH),
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= SHA224_BLOCK_SIZE,
+		.base.cra_module	= THIS_MODULE,
+		.digestsize		= SHA224_DIGEST_SIZE,
+		.init			= crypto_sha224_init,
+		.update			= crypto_sha256_update_arch,
+		.final			= crypto_sha224_final_arch,
+		.descsize		= sizeof(struct sha256_state),
+	},
+};
+
+static unsigned int num_algs;
+
+static int __init crypto_sha256_mod_init(void)
+{
+	/* register the arch flavours only if they differ from generic */
+	num_algs = ARRAY_SIZE(algs);
+	BUILD_BUG_ON(ARRAY_SIZE(algs) % 2 != 0);
+	if (!sha256_is_arch_optimized())
+		num_algs /= 2;
+	return crypto_register_shashes(algs, ARRAY_SIZE(algs));
+}
+subsys_initcall(crypto_sha256_mod_init);
+
+static void __exit crypto_sha256_mod_exit(void)
+{
+	crypto_unregister_shashes(algs, num_algs);
+}
+module_exit(crypto_sha256_mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Crypto API wrapper for the SHA-256 and SHA-224 library functions");
+
+MODULE_ALIAS_CRYPTO("sha256");
+MODULE_ALIAS_CRYPTO("sha256-generic");
+MODULE_ALIAS_CRYPTO("sha256-" __stringify(ARCH));
+MODULE_ALIAS_CRYPTO("sha224");
+MODULE_ALIAS_CRYPTO("sha224-generic");
+MODULE_ALIAS_CRYPTO("sha224-" __stringify(ARCH));
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
deleted file mode 100644
index 05084e5bbaec8..0000000000000
--- a/crypto/sha256_generic.c
+++ /dev/null
@@ -1,102 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Crypto API wrapper for the generic SHA256 code from lib/crypto/sha256.c
- *
- * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
- * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
- * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- * SHA224 Support Copyright 2007 Intel Corporation <jonathan.lynch@intel.com>
- */
-#include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
-#include <crypto/sha256_base.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-
-const u8 sha224_zero_message_hash[SHA224_DIGEST_SIZE] = {
-	0xd1, 0x4a, 0x02, 0x8c, 0x2a, 0x3a, 0x2b, 0xc9, 0x47,
-	0x61, 0x02, 0xbb, 0x28, 0x82, 0x34, 0xc4, 0x15, 0xa2,
-	0xb0, 0x1f, 0x82, 0x8e, 0xa6, 0x2a, 0xc5, 0xb3, 0xe4,
-	0x2f
-};
-EXPORT_SYMBOL_GPL(sha224_zero_message_hash);
-
-const u8 sha256_zero_message_hash[SHA256_DIGEST_SIZE] = {
-	0xe3, 0xb0, 0xc4, 0x42, 0x98, 0xfc, 0x1c, 0x14,
-	0x9a, 0xfb, 0xf4, 0xc8, 0x99, 0x6f, 0xb9, 0x24,
-	0x27, 0xae, 0x41, 0xe4, 0x64, 0x9b, 0x93, 0x4c,
-	0xa4, 0x95, 0x99, 0x1b, 0x78, 0x52, 0xb8, 0x55
-};
-EXPORT_SYMBOL_GPL(sha256_zero_message_hash);
-
-static void sha256_block(struct crypto_sha256_state *sctx, const u8 *input,
-			 int blocks)
-{
-	sha256_transform_blocks(sctx, input, blocks);
-}
-
-static int crypto_sha256_update(struct shash_desc *desc, const u8 *data,
-				unsigned int len)
-{
-	return sha256_base_do_update_blocks(desc, data, len, sha256_block);
-}
-
-static int crypto_sha256_finup(struct shash_desc *desc, const u8 *data,
-			       unsigned int len, u8 *hash)
-{
-	sha256_base_do_finup(desc, data, len, sha256_block);
-	return sha256_base_finish(desc, hash);
-}
-
-static struct shash_alg sha256_algs[2] = { {
-	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
-	.update		=	crypto_sha256_update,
-	.finup		=	crypto_sha256_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha256",
-		.cra_driver_name=	"sha256-generic",
-		.cra_priority	=	100,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA256_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-}, {
-	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
-	.update		=	crypto_sha256_update,
-	.finup		=	crypto_sha256_finup,
-	.descsize	=	sizeof(struct crypto_sha256_state),
-	.base		=	{
-		.cra_name	=	"sha224",
-		.cra_driver_name=	"sha224-generic",
-		.cra_priority	=	100,
-		.cra_flags	=	CRYPTO_AHASH_ALG_BLOCK_ONLY |
-					CRYPTO_AHASH_ALG_FINUP_MAX,
-		.cra_blocksize	=	SHA224_BLOCK_SIZE,
-		.cra_module	=	THIS_MODULE,
-	}
-} };
-
-static int __init sha256_generic_mod_init(void)
-{
-	return crypto_register_shashes(sha256_algs, ARRAY_SIZE(sha256_algs));
-}
-
-static void __exit sha256_generic_mod_fini(void)
-{
-	crypto_unregister_shashes(sha256_algs, ARRAY_SIZE(sha256_algs));
-}
-
-subsys_initcall(sha256_generic_mod_init);
-module_exit(sha256_generic_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithm");
-
-MODULE_ALIAS_CRYPTO("sha224");
-MODULE_ALIAS_CRYPTO("sha224-generic");
-MODULE_ALIAS_CRYPTO("sha256");
-MODULE_ALIAS_CRYPTO("sha256-generic");
diff --git a/include/crypto/internal/sha2.h b/include/crypto/internal/sha2.h
new file mode 100644
index 0000000000000..d641c67abcbc3
--- /dev/null
+++ b/include/crypto/internal/sha2.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _CRYPTO_INTERNAL_SHA2_H
+#define _CRYPTO_INTERNAL_SHA2_H
+
+#include <crypto/sha2.h>
+
+void sha256_update_generic(struct sha256_state *sctx,
+			   const u8 *data, size_t len);
+void sha256_final_generic(struct sha256_state *sctx,
+			  u8 out[SHA256_DIGEST_SIZE]);
+void sha224_final_generic(struct sha256_state *sctx,
+			  u8 out[SHA224_DIGEST_SIZE]);
+
+#if IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_SHA256)
+bool sha256_is_arch_optimized(void);
+#else
+static inline bool sha256_is_arch_optimized(void)
+{
+	return false;
+}
+#endif
+void sha256_blocks_generic(u32 state[SHA256_STATE_WORDS],
+			   const u8 *data, size_t nblocks);
+void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
+			const u8 *data, size_t nblocks);
+
+#endif /* _CRYPTO_INTERNAL_SHA2_H */
diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index abbd882f7849f..444484d1b1cfa 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -11,10 +11,11 @@
 #define SHA224_DIGEST_SIZE	28
 #define SHA224_BLOCK_SIZE	64
 
 #define SHA256_DIGEST_SIZE      32
 #define SHA256_BLOCK_SIZE       64
+#define SHA256_STATE_WORDS      8
 
 #define SHA384_DIGEST_SIZE      48
 #define SHA384_BLOCK_SIZE       128
 
 #define SHA512_DIGEST_SIZE      64
@@ -64,36 +65,26 @@ extern const u8 sha256_zero_message_hash[SHA256_DIGEST_SIZE];
 extern const u8 sha384_zero_message_hash[SHA384_DIGEST_SIZE];
 
 extern const u8 sha512_zero_message_hash[SHA512_DIGEST_SIZE];
 
 struct crypto_sha256_state {
-	u32 state[SHA256_DIGEST_SIZE / 4];
+	u32 state[SHA256_STATE_WORDS];
 	u64 count;
 };
 
 struct sha256_state {
-	u32 state[SHA256_DIGEST_SIZE / 4];
+	u32 state[SHA256_STATE_WORDS];
 	u64 count;
 	u8 buf[SHA256_BLOCK_SIZE];
 };
 
 struct sha512_state {
 	u64 state[SHA512_DIGEST_SIZE / 8];
 	u64 count[2];
 	u8 buf[SHA512_BLOCK_SIZE];
 };
 
-/*
- * Stand-alone implementation of the SHA256 algorithm. It is designed to
- * have as little dependencies as possible so it can be used in the
- * kexec_file purgatory. In other cases you should generally use the
- * hash APIs from include/crypto/hash.h. Especially when hashing large
- * amounts of data as those APIs may be hw-accelerated.
- *
- * For details see lib/crypto/sha256.c
- */
-
 static inline void sha256_init(struct sha256_state *sctx)
 {
 	sctx->state[0] = SHA256_H0;
 	sctx->state[1] = SHA256_H1;
 	sctx->state[2] = SHA256_H2;
diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
index 08cd5e41d4fdb..6878fb9c26c04 100644
--- a/include/crypto/sha256_base.h
+++ b/include/crypto/sha256_base.h
@@ -7,11 +7,11 @@
 
 #ifndef _CRYPTO_SHA256_BASE_H
 #define _CRYPTO_SHA256_BASE_H
 
 #include <crypto/internal/hash.h>
-#include <crypto/sha2.h>
+#include <crypto/internal/sha2.h>
 #include <linux/math.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
 
@@ -172,9 +172,12 @@ static inline int sha256_base_finish(struct shash_desc *desc, u8 *out)
 	struct crypto_sha256_state *sctx = shash_desc_ctx(desc);
 
 	return __sha256_base_finish(sctx->state, out, digest_size);
 }
 
-void sha256_transform_blocks(struct crypto_sha256_state *sst,
-			     const u8 *input, int blocks);
+static inline void sha256_transform_blocks(struct crypto_sha256_state *sst,
+					   const u8 *input, int blocks)
+{
+	sha256_blocks_generic(sst->state, input, blocks);
+}
 
 #endif /* _CRYPTO_SHA256_BASE_H */
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index af2368799579f..7fe678047939b 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -137,10 +137,29 @@ config CRYPTO_LIB_CHACHA20POLY1305
 config CRYPTO_LIB_SHA1
 	tristate
 
 config CRYPTO_LIB_SHA256
 	tristate
+	help
+	  Enable the SHA-256 library interface. This interface may be fulfilled
+	  by either the generic implementation or an arch-specific one, if one
+	  is available and enabled.
+
+config CRYPTO_ARCH_HAVE_LIB_SHA256
+	bool
+	help
+	  Declares whether the architecture provides an arch-specific
+	  accelerated implementation of the SHA-256 library interface.
+
+config CRYPTO_LIB_SHA256_GENERIC
+	tristate
+	default CRYPTO_LIB_SHA256 if !CRYPTO_ARCH_HAVE_LIB_SHA256
+	help
+	  This symbol can be selected by arch implementations of the SHA-256
+	  library interface that require the generic code as a fallback, e.g.,
+	  for SIMD implementations. If no arch specific implementation is
+	  enabled, this implementation serves the users of CRYPTO_LIB_SHA256.
 
 config CRYPTO_LIB_SM3
 	tristate
 
 if !KMSAN # avoid false positives from assembly
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index a89bab377de1a..182d1088d8893 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -9,16 +9,22 @@
  * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2014 Red Hat Inc.
  */
 
-#include <linux/unaligned.h>
-#include <crypto/sha256_base.h>
+#include <crypto/internal/sha2.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/unaligned.h>
 
+/*
+ * If __DISABLE_EXPORTS is defined, then this file is being compiled for a
+ * pre-boot environment.  In that case, ignore the kconfig options and build the
+ * generic code only.
+ */
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_SHA256_GENERIC) || defined(__DISABLE_EXPORTS)
 static const u32 SHA256_K[] = {
 	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
 	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
 	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
 	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
@@ -67,11 +73,12 @@ static inline void BLEND_OP(int I, u32 *W)
 	t2 = e0(a) + Maj(a, b, c);				\
 	d += t1;						\
 	h = t1 + t2;						\
 } while (0)
 
-static void sha256_transform(u32 *state, const u8 *input, u32 *W)
+static void sha256_block_generic(u32 state[SHA256_STATE_WORDS],
+				 const u8 *input, u32 W[64])
 {
 	u32 a, b, c, d, e, f, g, h;
 	int i;
 
 	/* load the input */
@@ -116,45 +123,109 @@ static void sha256_transform(u32 *state, const u8 *input, u32 *W)
 
 	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
 }
 
-void sha256_transform_blocks(struct crypto_sha256_state *sst,
-			     const u8 *input, int blocks)
+void sha256_blocks_generic(u32 state[SHA256_STATE_WORDS],
+			   const u8 *data, size_t nblocks)
 {
 	u32 W[64];
 
 	do {
-		sha256_transform(sst->state, input, W);
-		input += SHA256_BLOCK_SIZE;
-	} while (--blocks);
+		sha256_block_generic(state, data, W);
+		data += SHA256_BLOCK_SIZE;
+	} while (--nblocks);
 
 	memzero_explicit(W, sizeof(W));
 }
-EXPORT_SYMBOL_GPL(sha256_transform_blocks);
+EXPORT_SYMBOL_GPL(sha256_blocks_generic);
+#endif /* CONFIG_CRYPTO_LIB_SHA256_GENERIC || __DISABLE_EXPORTS */
+
+static inline void sha256_blocks(u32 state[SHA256_STATE_WORDS], const u8 *data,
+				 size_t nblocks, bool force_generic)
+{
+#if IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_SHA256) && !defined(__DISABLE_EXPORTS)
+	if (!force_generic)
+		return sha256_blocks_arch(state, data, nblocks);
+#endif
+	sha256_blocks_generic(state, data, nblocks);
+}
+
+static inline void __sha256_update(struct sha256_state *sctx, const u8 *data,
+				   size_t len, bool force_generic)
+{
+	size_t partial = sctx->count % SHA256_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (partial + len >= SHA256_BLOCK_SIZE) {
+		size_t nblocks;
+
+		if (partial) {
+			size_t l = SHA256_BLOCK_SIZE - partial;
+
+			memcpy(&sctx->buf[partial], data, l);
+			data += l;
+			len -= l;
+
+			sha256_blocks(sctx->state, sctx->buf, 1, force_generic);
+		}
+
+		nblocks = len / SHA256_BLOCK_SIZE;
+		len %= SHA256_BLOCK_SIZE;
+
+		if (nblocks) {
+			sha256_blocks(sctx->state, data, nblocks,
+				      force_generic);
+			data += nblocks * SHA256_BLOCK_SIZE;
+		}
+		partial = 0;
+	}
+	if (len)
+		memcpy(&sctx->buf[partial], data, len);
+}
 
 void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
-	lib_sha256_base_do_update(sctx, data, len, sha256_transform_blocks);
+	__sha256_update(sctx, data, len, false);
 }
 EXPORT_SYMBOL(sha256_update);
 
-static void __sha256_final(struct sha256_state *sctx, u8 *out, int digest_size)
+static inline void __sha256_final(struct sha256_state *sctx, u8 *out,
+				  size_t digest_size, bool force_generic)
 {
-	lib_sha256_base_do_finalize(sctx, sha256_transform_blocks);
-	lib_sha256_base_finish(sctx, out, digest_size);
+	const size_t bit_offset = SHA256_BLOCK_SIZE - sizeof(__be64);
+	__be64 *bits = (__be64 *)&sctx->buf[bit_offset];
+	size_t partial = sctx->count % SHA256_BLOCK_SIZE;
+	size_t i;
+
+	sctx->buf[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(&sctx->buf[partial], 0, SHA256_BLOCK_SIZE - partial);
+		sha256_blocks(sctx->state, sctx->buf, 1, force_generic);
+		partial = 0;
+	}
+
+	memset(&sctx->buf[partial], 0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	sha256_blocks(sctx->state, sctx->buf, 1, force_generic);
+
+	for (i = 0; i < digest_size; i += 4)
+		put_unaligned_be32(sctx->state[i / 4], out + i);
+
+	memzero_explicit(sctx, sizeof(*sctx));
 }
 
 void sha256_final(struct sha256_state *sctx, u8 *out)
 {
-	__sha256_final(sctx, out, 32);
+	__sha256_final(sctx, out, SHA256_DIGEST_SIZE, false);
 }
 EXPORT_SYMBOL(sha256_final);
 
 void sha224_final(struct sha256_state *sctx, u8 *out)
 {
-	__sha256_final(sctx, out, 28);
+	__sha256_final(sctx, out, SHA224_DIGEST_SIZE, false);
 }
 EXPORT_SYMBOL(sha224_final);
 
 void sha256(const u8 *data, unsigned int len, u8 *out)
 {
@@ -164,7 +235,28 @@ void sha256(const u8 *data, unsigned int len, u8 *out)
 	sha256_update(&sctx, data, len);
 	sha256_final(&sctx, out);
 }
 EXPORT_SYMBOL(sha256);
 
+#if IS_ENABLED(CONFIG_CRYPTO_LIB_SHA256_GENERIC) && !defined(__DISABLE_EXPORTS)
+void sha256_update_generic(struct sha256_state *sctx,
+			   const u8 *data, size_t len)
+{
+	__sha256_update(sctx, data, len, true);
+}
+EXPORT_SYMBOL(sha256_update_generic);
+
+void sha256_final_generic(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE])
+{
+	__sha256_final(sctx, out, SHA256_DIGEST_SIZE, true);
+}
+EXPORT_SYMBOL(sha256_final_generic);
+
+void sha224_final_generic(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE])
+{
+	__sha256_final(sctx, out, SHA224_DIGEST_SIZE, true);
+}
+EXPORT_SYMBOL(sha224_final_generic);
+#endif
+
 MODULE_DESCRIPTION("SHA-256 Algorithm");
 MODULE_LICENSE("GPL");
-- 
2.49.0


