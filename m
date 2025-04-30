Return-Path: <linux-arch+bounces-11753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B97AA417B
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 05:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FAE1BC43E4
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC119D8A3;
	Wed, 30 Apr 2025 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="hWW2WGSU"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266193FE4;
	Wed, 30 Apr 2025 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984919; cv=none; b=WdX4oOt8L5srrfq1Vns+vD8g5BRNWqgPGJfIPSUvWj5FD8aPgsUPNjEj6FwYSQoF4nARtHvShbW7HTFoXEvjR3VLVJYfl6CAeYpA5fULHy6TYs1eTeRCfs2HN4xa81o6EZ3pHTw+42XTJPkLfp8T4XCCyPfBNFXiuXDohtgUyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984919; c=relaxed/simple;
	bh=owYSNEZrINdHA/WPUJwb/zHXBMGIP8AgTItLqkrPG1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0qLYnmddG/yfhrBd/4QHuEUOSGqzrsn/Uya6x5cj7VUM5Wx8jtyNNBA0gPv++feOov9VxMSOJFRXkIo7R0swle7nAqyX1RtFKuDpNRT30N6KG/x+cEwO6QTnyUoyivH+iEob91I8/+Eqn3R+glCpEu0dwCIK+eFwMcIW+eEq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=hWW2WGSU; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fD6zxRFFdRFmxzaf4tcfULngb0ghBzMFzuAhq3mvYqE=; b=hWW2WGSUC7/9y1k66lTSv8t0NB
	86jMa18oP8xVKrRy2pet+kyNDfDkiWXnkDiHusEJqsOTzP0cP/0PkMigOPIuo+87s9Z9XPVpskRro
	dS1WOUUbPQ1jKfi/lWH17yj4Q/Wuok27nYeCDky8E3CU7xBge8BSa1jutA53iZWzZm+x6tU6XvwXb
	Gp6LoZ5J7KqxmrS/+M/LV41C4ymxNHH/0Ilke/dwwr4I6LwfkqKV6LfmlgSYX1Fx8Big8f8hBVE9M
	/BAxCuYpNOUBD5NdkedVJypqafu3Mghqtyq1NxuuZtmuXUh+9ajklKb+hq0UBQv8VBgh17AwRRM4p
	3wjeCrog==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9yQs-0029Ri-24;
	Wed, 30 Apr 2025 11:48:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Apr 2025 11:48:26 +0800
Date: Wed, 30 Apr 2025 11:48:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 01/13] crypto: sha256 - support arch-optimized lib and
 expose through shash
Message-ID: <aBGdiv17ztQnhAps@gondor.apana.org.au>
References: <20250428170040.423825-1-ebiggers@kernel.org>
 <20250428170040.423825-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428170040.423825-2-ebiggers@kernel.org>

On Mon, Apr 28, 2025 at 10:00:26AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As has been done for various other algorithms, rework the design of the
> SHA-256 library to support arch-optimized implementations, and make
> crypto/sha256.c expose both generic and arch-optimized shash algorithms
> that wrap the library functions.
> 
> This allows users of the SHA-256 library functions to take advantage of
> the arch-optimized code, and this makes it much simpler to integrate
> SHA-256 for each architecture.
> 
> Note that sha256_base.h is not used in the new design.  It will be
> removed once all the architecture-specific code has been updated.
> 
> Move the generic block function into its own module to avoid a circular
> dependency from libsha256.ko => sha256-$ARCH.ko => libsha256.ko.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/Kconfig                 |   1 +
>  crypto/Makefile                |   3 +-
>  crypto/sha256.c                | 201 +++++++++++++++++++++++++++++++++
>  crypto/sha256_generic.c        | 102 -----------------
>  include/crypto/internal/sha2.h |  28 +++++
>  include/crypto/sha2.h          |  15 +--
>  include/crypto/sha256_base.h   |   9 +-
>  lib/crypto/Kconfig             |  19 ++++
>  lib/crypto/Makefile            |   3 +
>  lib/crypto/sha256-generic.c    | 137 ++++++++++++++++++++++
>  lib/crypto/sha256.c            | 196 ++++++++++++++------------------
>  11 files changed, 487 insertions(+), 227 deletions(-)
>  create mode 100644 crypto/sha256.c
>  delete mode 100644 crypto/sha256_generic.c
>  create mode 100644 include/crypto/internal/sha2.h
>  create mode 100644 lib/crypto/sha256-generic.c

This is the patch that I will fold in here to maintain the existing
export format:

diff --git a/crypto/sha256.c b/crypto/sha256.c
index 1c2edcf9453d..c2588d08ee3e 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -116,6 +116,32 @@ static int crypto_sha224_final_arch(struct shash_desc *desc, u8 *out)
 	return 0;
 }
 
+static int crypto_sha256_import_lib(struct shash_desc *desc, const void *in)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+	const u8 *p = in;
+
+	memcpy(sctx, p, sizeof(*sctx));
+	p += sizeof(*sctx);
+	sctx->count += *p;
+	return 0;
+}
+
+static int crypto_sha256_export_lib(struct shash_desc *desc, void *out)
+{
+	struct sha256_state *sctx0 = shash_desc_ctx(desc);
+	struct sha256_state sctx = *sctx0;
+	unsigned int partial;
+	u8 *p = out;
+
+	partial = sctx.count % SHA256_BLOCK_SIZE;
+	sctx.count -= partial;
+	memcpy(p, &sctx, sizeof(sctx));
+	p += sizeof(sctx);
+	*p = partial;
+	return 0;
+}
+
 static struct shash_alg algs[] = {
 	{
 		.base.cra_name		= "sha256",
@@ -130,6 +156,10 @@ static struct shash_alg algs[] = {
 		.finup			= crypto_sha256_finup_generic,
 		.digest			= crypto_sha256_digest_generic,
 		.descsize		= sizeof(struct sha256_state),
+		.statesize		= sizeof(struct crypto_sha256_state) +
+					  SHA256_BLOCK_SIZE + 1,
+		.import			= crypto_sha256_import_lib,
+		.export			= crypto_sha256_export_lib,
 	},
 	{
 		.base.cra_name		= "sha224",
@@ -142,6 +172,10 @@ static struct shash_alg algs[] = {
 		.update			= crypto_sha256_update_generic,
 		.final			= crypto_sha224_final_generic,
 		.descsize		= sizeof(struct sha256_state),
+		.statesize		= sizeof(struct crypto_sha256_state) +
+					  SHA256_BLOCK_SIZE + 1,
+		.import			= crypto_sha256_import_lib,
+		.export			= crypto_sha256_export_lib,
 	},
 	{
 		.base.cra_name		= "sha256",
@@ -156,6 +190,10 @@ static struct shash_alg algs[] = {
 		.finup			= crypto_sha256_finup_arch,
 		.digest			= crypto_sha256_digest_arch,
 		.descsize		= sizeof(struct sha256_state),
+		.statesize		= sizeof(struct crypto_sha256_state) +
+					  SHA256_BLOCK_SIZE + 1,
+		.import			= crypto_sha256_import_lib,
+		.export			= crypto_sha256_export_lib,
 	},
 	{
 		.base.cra_name		= "sha224",
@@ -168,6 +206,10 @@ static struct shash_alg algs[] = {
 		.update			= crypto_sha256_update_arch,
 		.final			= crypto_sha224_final_arch,
 		.descsize		= sizeof(struct sha256_state),
+		.statesize		= sizeof(struct crypto_sha256_state) +
+					  SHA256_BLOCK_SIZE + 1,
+		.import			= crypto_sha256_import_lib,
+		.export			= crypto_sha256_export_lib,
 	},
 };

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

