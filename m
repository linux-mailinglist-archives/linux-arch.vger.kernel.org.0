Return-Path: <linux-arch+bounces-12166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1626ACA0AE
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 00:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C675170781
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED423A997;
	Sun,  1 Jun 2025 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNPBjqUP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B660239E69;
	Sun,  1 Jun 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817954; cv=none; b=IrCR4HpjvinWTlFxrQ0csLUNwGWAD7G2pfUxr+bIibmy5Hc/oO4nj9WnOmRHKO3QzPWLwtHZDsfTX5C36r5ojq3286uPMNBZtCjqIXZ/3SjKKx3bE65IInggCz3v1QrP8dBYC4Sa6ZcRkO1876Yvx3hEmC5+HDDB9H1fj+bEwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817954; c=relaxed/simple;
	bh=HDU9nSTLbE55YbS5EUuBOLBm8L+KFIjICgPyy22jxdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYXZH1X0OWLKAxCzRYne4xmFhxC4momFHWiyuxAl9720beefHPTpyxJHJT5Sp3hc0BVbwwTpizxMCbGo4f+YPMHkx3E2r513oJDQv2vtbWmkN5GZzIoxH8js+PHALAutUoGshMq/DbyPA96uy1UTuGZgjOJFFNp0clohvzPD2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNPBjqUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E3C4CEF3;
	Sun,  1 Jun 2025 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748817953;
	bh=HDU9nSTLbE55YbS5EUuBOLBm8L+KFIjICgPyy22jxdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNPBjqUP++VnaPZeQEjCA9PyqCJOY1jpIJYbHsl58QNltzexLH+k8ZpJP826lKJc6
	 4uiNjnztbjOQdF4v00x2dEGtWcRRGMZXT4P2/7aRYie0N3dfqpFTBMtr4tB/gTk+ro
	 2C8fZYfDf+KKdNV9QH1Fvbe22PkJswPRcWoBHgi7Ae73mX/+cFwVJzfwqCEaqPyQYL
	 dYvjAgD1stt+XlvcSxaIVj8HfZoVRj9GfkwMdVGe18TiSaMerfLHUZXzoq3RcwpSA+
	 kDVCYaQs7AB87EEgn9MXaT1pxlISTeshxy5D2VGrJt0fqsYGg703b67vwpKi5cdlPV
	 9yCrZlVd3VVRQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 01/13] crypto/crc32: register only one shash_alg
Date: Sun,  1 Jun 2025 15:44:29 -0700
Message-ID: <20250601224441.778374-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601224441.778374-1-ebiggers@kernel.org>
References: <20250601224441.778374-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Stop unnecessarily registering a "crc32-generic" shash_alg when a
"crc32-$(ARCH)" shash_alg is registered too.

While every algorithm does need to have a generic implementation to
ensure uniformity of support across platforms, that doesn't mean that we
need to make the generic implementation available through crypto_shash
when an optimized implementation is also available.

Registering the generic shash_alg did allow users of the crypto_shash or
crypto_ahash APIs to request the generic implementation specifically,
instead of an optimized one.  However, the only known use case for that
was the differential fuzz tests in crypto/testmgr.c.  Equivalent test
coverage is now provided by crc_kunit.

Besides simplifying crypto/crc32.c, this change eliminates the need for
the library to provide crc32_le_base() as part of its interface.  Later
patches will make crc32_le_base() be internal to the library.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crc32.c | 69 ++++++++------------------------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/crypto/crc32.c b/crypto/crc32.c
index cc371d42601fd..b61d5663d0bac 100644
--- a/crypto/crc32.c
+++ b/crypto/crc32.c
@@ -57,33 +57,16 @@ static int crc32_init(struct shash_desc *desc)
 static int crc32_update(struct shash_desc *desc, const u8 *data,
 			unsigned int len)
 {
 	u32 *crcp = shash_desc_ctx(desc);
 
-	*crcp = crc32_le_base(*crcp, data, len);
-	return 0;
-}
-
-static int crc32_update_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len)
-{
-	u32 *crcp = shash_desc_ctx(desc);
-
 	*crcp = crc32_le(*crcp, data, len);
 	return 0;
 }
 
 /* No final XOR 0xFFFFFFFF, like crc32_le */
-static int __crc32_finup(u32 *crcp, const u8 *data, unsigned int len,
-			 u8 *out)
-{
-	put_unaligned_le32(crc32_le_base(*crcp, data, len), out);
-	return 0;
-}
-
-static int __crc32_finup_arch(u32 *crcp, const u8 *data, unsigned int len,
-			      u8 *out)
+static int __crc32_finup(u32 *crcp, const u8 *data, unsigned int len, u8 *out)
 {
 	put_unaligned_le32(crc32_le(*crcp, data, len), out);
 	return 0;
 }
 
@@ -91,16 +74,10 @@ static int crc32_finup(struct shash_desc *desc, const u8 *data,
 		       unsigned int len, u8 *out)
 {
 	return __crc32_finup(shash_desc_ctx(desc), data, len, out);
 }
 
-static int crc32_finup_arch(struct shash_desc *desc, const u8 *data,
-		       unsigned int len, u8 *out)
-{
-	return __crc32_finup_arch(shash_desc_ctx(desc), data, len, out);
-}
-
 static int crc32_final(struct shash_desc *desc, u8 *out)
 {
 	u32 *crcp = shash_desc_ctx(desc);
 
 	put_unaligned_le32(*crcp, out);
@@ -111,72 +88,48 @@ static int crc32_digest(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
 	return __crc32_finup(crypto_shash_ctx(desc->tfm), data, len, out);
 }
 
-static int crc32_digest_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *out)
-{
-	return __crc32_finup_arch(crypto_shash_ctx(desc->tfm), data, len, out);
-}
-
-static struct shash_alg algs[] = {{
+static struct shash_alg alg = {
 	.setkey			= crc32_setkey,
 	.init			= crc32_init,
 	.update			= crc32_update,
 	.final			= crc32_final,
 	.finup			= crc32_finup,
 	.digest			= crc32_digest,
 	.descsize		= sizeof(u32),
 	.digestsize		= CHKSUM_DIGEST_SIZE,
 
 	.base.cra_name		= "crc32",
-	.base.cra_driver_name	= "crc32-generic",
 	.base.cra_priority	= 100,
 	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(u32),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32_cra_init,
-}, {
-	.setkey			= crc32_setkey,
-	.init			= crc32_init,
-	.update			= crc32_update_arch,
-	.final			= crc32_final,
-	.finup			= crc32_finup_arch,
-	.digest			= crc32_digest_arch,
-	.descsize		= sizeof(u32),
-	.digestsize		= CHKSUM_DIGEST_SIZE,
-
-	.base.cra_name		= "crc32",
-	.base.cra_driver_name	= "crc32-" __stringify(ARCH),
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(u32),
-	.base.cra_module	= THIS_MODULE,
-	.base.cra_init		= crc32_cra_init,
-}};
-
-static int num_algs;
+};
 
 static int __init crc32_mod_init(void)
 {
-	/* register the arch flavor only if it differs from the generic one */
-	num_algs = 1 + ((crc32_optimizations() & CRC32_LE_OPTIMIZATION) != 0);
+	const char *driver_name =
+		(crc32_optimizations() & CRC32_LE_OPTIMIZATION) ?
+			"crc32-" __stringify(ARCH) :
+			"crc32-generic";
+
+	strscpy(alg.base.cra_driver_name, driver_name, CRYPTO_MAX_ALG_NAME);
 
-	return crypto_register_shashes(algs, num_algs);
+	return crypto_register_shash(&alg);
 }
 
 static void __exit crc32_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, num_algs);
+	crypto_unregister_shash(&alg);
 }
 
 module_init(crc32_mod_init);
 module_exit(crc32_mod_fini);
 
 MODULE_AUTHOR("Alexander Boyko <alexander_boyko@xyratex.com>");
 MODULE_DESCRIPTION("CRC32 calculations wrapper for lib/crc32");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("crc32");
-MODULE_ALIAS_CRYPTO("crc32-generic");
-- 
2.49.0


