Return-Path: <linux-arch+bounces-9116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393B9D0191
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7A028649A
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68987D531;
	Sun, 17 Nov 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHGBbzqp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD63C8CE;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803035; cv=none; b=tgV3SJkzOqk1WGyOPNTujSX4oDoRkhqjy73AWSpdMQWRNT4RSlU9sDKpHivbKk/g5pa74bvTd4EOuI9KE6rf6PrbPN/COo4wDb7p/udUESs7C/xFKGLPIrxXxjfjQPVUYcc9QcKLjWYNMA+nHkQSanTM4RYX+RrumJydg/5hl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803035; c=relaxed/simple;
	bh=fz4SkCeYBuj7fsA/U1fUHvVppsJG5UVFRFRoPgOF4lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzx4y4AnoHKB4U5d5MLecR5DO/XnAeJRY8ACf2UChDZmy8rRgS9Xs28AwV8qcXsxnTXB8OPRsS6i7ENjkb84GNbXZE67RrnQBiUR0wtoxPwAhUcYZxu7y3okRDr6UhDL4OY0UbGvG9rXFaQve6OFKtBlabyXAFt04TVG3IY3LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHGBbzqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DC5C4CED6;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803034;
	bh=fz4SkCeYBuj7fsA/U1fUHvVppsJG5UVFRFRoPgOF4lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHGBbzqpxxXr7z9JTDGZvIsMrkHcSwzjkEx2FI60yxgCeuqd7tlL2odGxTgZf534f
	 giTrqvVfr65GbOH5Ng0xGyxC2lsMyOPC3zCe135DvXeMC2LgYcXdoFARkKEazMxP2S
	 FehNuJ8ZDFj942jvr3zEQ8IxBZP48bBUFQJQsp4a7tds04ZqPcw53S9svvFYaLhlv6
	 zaBgI3R3pSUtCc6ETR0AkkpCWdxmToc1xGnMpbR5cl23tXHtgXwV47kVcMaSMUROFD
	 +x7tSIlYPh2purRhNnEq5ELrIHjTitDF4gVgTH8zfln7JvJ1qUexkZCOf0heRM+0/7
	 cAEO7vRyLTMtQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 03/11] crypto: crct10dif - expose arch-optimized lib function
Date: Sat, 16 Nov 2024 16:22:36 -0800
Message-ID: <20241117002244.105200-4-ebiggers@kernel.org>
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

Now that crc_t10dif_update() may be directly optimized for each
architecture, make the shash driver for crct10dif register a
crct10dif-$arch algorithm that uses it, instead of only
crct10dif-generic which uses crc_t10dif_generic().

The result is that architecture-optimized crct10dif will remain
available through the shash API once the architectures implement
crc_t10dif_arch() instead of the shash API.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Makefile            |  1 +
 crypto/crct10dif_generic.c | 82 +++++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index e948a883f151..8361fdb1a27d 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -153,10 +153,11 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32_generic.o
 CFLAGS_crc32c_generic.o += -DARCH=$(ARCH)
 CFLAGS_crc32_generic.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_generic.o
+CFLAGS_crct10dif_generic.o += -DARCH=$(ARCH)
 obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) += lz4.o
 obj-$(CONFIG_CRYPTO_LZ4HC) += lz4hc.o
diff --git a/crypto/crct10dif_generic.c b/crypto/crct10dif_generic.c
index e843982073bb..259cb01932cb 100644
--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -55,10 +55,19 @@ static int chksum_update(struct shash_desc *desc, const u8 *data,
 
 	ctx->crc = crc_t10dif_generic(ctx->crc, data, length);
 	return 0;
 }
 
+static int chksum_update_arch(struct shash_desc *desc, const u8 *data,
+			      unsigned int length)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	ctx->crc = crc_t10dif_update(ctx->crc, data, length);
+	return 0;
+}
+
 static int chksum_final(struct shash_desc *desc, u8 *out)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
 	*(__u16 *)out = ctx->crc;
@@ -69,49 +78,86 @@ static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
 	*(__u16 *)out = crc_t10dif_generic(crc, data, len);
 	return 0;
 }
 
+static int __chksum_finup_arch(__u16 crc, const u8 *data, unsigned int len,
+			       u8 *out)
+{
+	*(__u16 *)out = crc_t10dif_update(crc, data, len);
+	return 0;
+}
+
 static int chksum_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *out)
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
 	return __chksum_finup(ctx->crc, data, len, out);
 }
 
+static int chksum_finup_arch(struct shash_desc *desc, const u8 *data,
+			     unsigned int len, u8 *out)
+{
+	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
+
+	return __chksum_finup_arch(ctx->crc, data, len, out);
+}
+
 static int chksum_digest(struct shash_desc *desc, const u8 *data,
 			 unsigned int length, u8 *out)
 {
 	return __chksum_finup(0, data, length, out);
 }
 
-static struct shash_alg alg = {
-	.digestsize		=	CRC_T10DIF_DIGEST_SIZE,
-	.init		=	chksum_init,
-	.update		=	chksum_update,
-	.final		=	chksum_final,
-	.finup		=	chksum_finup,
-	.digest		=	chksum_digest,
-	.descsize		=	sizeof(struct chksum_desc_ctx),
-	.base			=	{
-		.cra_name		=	"crct10dif",
-		.cra_driver_name	=	"crct10dif-generic",
-		.cra_priority		=	100,
-		.cra_blocksize		=	CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		=	THIS_MODULE,
-	}
-};
+static int chksum_digest_arch(struct shash_desc *desc, const u8 *data,
+			      unsigned int length, u8 *out)
+{
+	return __chksum_finup_arch(0, data, length, out);
+}
+
+static struct shash_alg algs[] = {{
+	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
+	.init			= chksum_init,
+	.update			= chksum_update,
+	.final			= chksum_final,
+	.finup			= chksum_finup,
+	.digest			= chksum_digest,
+	.descsize		= sizeof(struct chksum_desc_ctx),
+	.base.cra_name		= "crct10dif",
+	.base.cra_driver_name	= "crct10dif-generic",
+	.base.cra_priority	= 100,
+	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+}, {
+	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
+	.init			= chksum_init,
+	.update			= chksum_update_arch,
+	.final			= chksum_final,
+	.finup			= chksum_finup_arch,
+	.digest			= chksum_digest_arch,
+	.descsize		= sizeof(struct chksum_desc_ctx),
+	.base.cra_name		= "crct10dif",
+	.base.cra_driver_name	= "crct10dif-" __stringify(ARCH),
+	.base.cra_priority	= 150,
+	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
+	.base.cra_module	= THIS_MODULE,
+}};
+
+static int num_algs;
 
 static int __init crct10dif_mod_init(void)
 {
-	return crypto_register_shash(&alg);
+	/* register the arch flavor only if it differs from the generic one */
+	num_algs = 1 + crc_t10dif_is_optimized();
+
+	return crypto_register_shashes(algs, num_algs);
 }
 
 static void __exit crct10dif_mod_fini(void)
 {
-	crypto_unregister_shash(&alg);
+	crypto_unregister_shashes(algs, num_algs);
 }
 
 subsys_initcall(crct10dif_mod_init);
 module_exit(crct10dif_mod_fini);
 
-- 
2.47.0


