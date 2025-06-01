Return-Path: <linux-arch+bounces-12167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45070ACA0B5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C6D3B305E
	for <lists+linux-arch@lfdr.de>; Sun,  1 Jun 2025 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204923BCFA;
	Sun,  1 Jun 2025 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5KZx5zF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609823BCE7;
	Sun,  1 Jun 2025 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817954; cv=none; b=J8hFCl1X7QEqofPcEUR9b4kWWPediqgCNc0d4NCc03OZRqbPmyAbGZpwaix12maE9ZNWywP0dmsY5eWZKPMlD+gDfGfdQCrnE7bI8YKzZo8gyMsNXMBg8BRsyGHX2vJ96jcpBNkv+wW5gsdRG055HVSVdt1LQIb4hzPrSQKrQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817954; c=relaxed/simple;
	bh=DuymbRdfQNASqdv95GmKI7xo6X3aqFKpkNJXYJg46+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szrDzpYQhtWMZQLzBHc1b1B/hbP00nbu0hb8KdCAhtPCic5xgkyr/11VO+D6bs/hojbT9aqfI1ROfrl95E5hHhouyZZWuHYuKoRdVAPoDSUxNFCWVcOVnT8b4CBDCtMD2e7Ucl93r/WKLQSIWnBXvrYhXjBUad3IfAcxSKAbVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5KZx5zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E5FC4AF09;
	Sun,  1 Jun 2025 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748817954;
	bh=DuymbRdfQNASqdv95GmKI7xo6X3aqFKpkNJXYJg46+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5KZx5zFP0pmjW+yPAWdh9HSDJ2eN9w2ECvi4PqHcvu7LAXDpxsbC+W620rIBoLrE
	 DznkxM4gfP4EgC5XNbW/1IZSwXBfLwYb/IAzXBTSTWzJC4xcVQe3Kc8S5SaI7DgHDo
	 zB1yc7zunGBGTw5P/TzAbj5R/07z6Jz4uDjDkknV7a/3ATwioeZfpMpSDAJIGlwvmZ
	 lDcK7YxikgkmIs33oVtz5QhNny84wp9XVplAzVmdhy00Q1kCZDwflOiPDRUlhAlYk2
	 Eg0xXw+k7lVB/hD59SGVjKJq3uODrL4J9EKIvDT8fqH39+CwyxjA3VwspzvlJX9AJO
	 fhH3nLtfKMqaw==
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
Subject: [PATCH 02/13] crypto/crc32c: register only one shash_alg
Date: Sun,  1 Jun 2025 15:44:30 -0700
Message-ID: <20250601224441.778374-3-ebiggers@kernel.org>
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

Stop unnecessarily registering a "crc32c-generic" shash_alg when a
"crc32c-$(ARCH)" shash_alg is registered too.

While every algorithm does need to have a generic implementation to
ensure uniformity of support across platforms, that doesn't mean that we
need to make the generic implementation available through crypto_shash
when an optimized implementation is also available.

Registering the generic shash_alg did allow users of the crypto_shash or
crypto_ahash APIs to request the generic implementation specifically,
instead of an optimized one.  However, the only known use case for that
was the differential fuzz tests in crypto/testmgr.c.  Equivalent test
coverage is now provided by crc_kunit.

Besides simplifying crypto/crc32c.c, this change eliminates the need for
the library to provide crc32c_base() as part of its interface.  Later
patches will make crc32c_base() be internal to the library.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/crc32c.c | 70 +++++++------------------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/crypto/crc32c.c b/crypto/crc32c.c
index e5377898414a2..e160695682f16 100644
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -83,19 +83,10 @@ static int chksum_setkey(struct crypto_shash *tfm, const u8 *key,
 static int chksum_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int length)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	ctx->crc = crc32c_base(ctx->crc, data, length);
-	return 0;
-}
-
-static int chksum_update_arch(struct shash_desc *desc, const u8 *data,
-			      unsigned int length)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
 	ctx->crc = crc32c(ctx->crc, data, length);
 	return 0;
 }
 
 static int chksum_final(struct shash_desc *desc, u8 *out)
@@ -105,17 +96,10 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 	put_unaligned_le32(~ctx->crc, out);
 	return 0;
 }
 
 static int __chksum_finup(u32 *crcp, const u8 *data, unsigned int len, u8 *out)
-{
-	put_unaligned_le32(~crc32c_base(*crcp, data, len), out);
-	return 0;
-}
-
-static int __chksum_finup_arch(u32 *crcp, const u8 *data, unsigned int len,
-			       u8 *out)
 {
 	put_unaligned_le32(~crc32c(*crcp, data, len), out);
 	return 0;
 }
 
@@ -125,98 +109,64 @@ static int chksum_finup(struct shash_desc *desc, const u8 *data,
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
 	return __chksum_finup(&ctx->crc, data, len, out);
 }
 
-static int chksum_finup_arch(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, u8 *out)
-{
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup_arch(&ctx->crc, data, len, out);
-}
-
 static int chksum_digest(struct shash_desc *desc, const u8 *data,
 			 unsigned int length, u8 *out)
 {
 	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
 
 	return __chksum_finup(&mctx->key, data, length, out);
 }
 
-static int chksum_digest_arch(struct shash_desc *desc, const u8 *data,
-			      unsigned int length, u8 *out)
-{
-	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
-
-	return __chksum_finup_arch(&mctx->key, data, length, out);
-}
-
 static int crc32c_cra_init(struct crypto_tfm *tfm)
 {
 	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->key = ~0;
 	return 0;
 }
 
-static struct shash_alg algs[] = {{
+static struct shash_alg alg = {
 	.digestsize		= CHKSUM_DIGEST_SIZE,
 	.setkey			= chksum_setkey,
 	.init			= chksum_init,
 	.update			= chksum_update,
 	.final			= chksum_final,
 	.finup			= chksum_finup,
 	.digest			= chksum_digest,
 	.descsize		= sizeof(struct chksum_desc_ctx),
 
 	.base.cra_name		= "crc32c",
-	.base.cra_driver_name	= "crc32c-generic",
 	.base.cra_priority	= 100,
 	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(struct chksum_ctx),
 	.base.cra_module	= THIS_MODULE,
 	.base.cra_init		= crc32c_cra_init,
-}, {
-	.digestsize		= CHKSUM_DIGEST_SIZE,
-	.setkey			= chksum_setkey,
-	.init			= chksum_init,
-	.update			= chksum_update_arch,
-	.final			= chksum_final,
-	.finup			= chksum_finup_arch,
-	.digest			= chksum_digest_arch,
-	.descsize		= sizeof(struct chksum_desc_ctx),
-
-	.base.cra_name		= "crc32c",
-	.base.cra_driver_name	= "crc32c-" __stringify(ARCH),
-	.base.cra_priority	= 150,
-	.base.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
-	.base.cra_blocksize	= CHKSUM_BLOCK_SIZE,
-	.base.cra_ctxsize	= sizeof(struct chksum_ctx),
-	.base.cra_module	= THIS_MODULE,
-	.base.cra_init		= crc32c_cra_init,
-}};
-
-static int num_algs;
+};
 
 static int __init crc32c_mod_init(void)
 {
-	/* register the arch flavor only if it differs from the generic one */
-	num_algs = 1 + ((crc32_optimizations() & CRC32C_OPTIMIZATION) != 0);
+	const char *driver_name =
+		(crc32_optimizations() & CRC32C_OPTIMIZATION) ?
+			"crc32c-" __stringify(ARCH) :
+			"crc32c-generic";
+
+	strscpy(alg.base.cra_driver_name, driver_name, CRYPTO_MAX_ALG_NAME);
 
-	return crypto_register_shashes(algs, num_algs);
+	return crypto_register_shash(&alg);
 }
 
 static void __exit crc32c_mod_fini(void)
 {
-	crypto_unregister_shashes(algs, num_algs);
+	crypto_unregister_shash(&alg);
 }
 
 module_init(crc32c_mod_init);
 module_exit(crc32c_mod_fini);
 
 MODULE_AUTHOR("Clay Haapala <chaapala@cisco.com>");
 MODULE_DESCRIPTION("CRC32c (Castagnoli) calculations wrapper for lib/crc32c");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_CRYPTO("crc32c");
-MODULE_ALIAS_CRYPTO("crc32c-generic");
-- 
2.49.0


