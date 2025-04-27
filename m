Return-Path: <linux-arch+bounces-11629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58069A9DFD7
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76135165B47
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC3252298;
	Sun, 27 Apr 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="L2aWbVyG"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D123F26B;
	Sun, 27 Apr 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735478; cv=none; b=h2WWwoVQRUjm2kXcIG89XuFvEDhUq+2jcZ48Qt0PCsaEpn0zojcTE1BY7Gdm+AEJTSEZRpABCNidreQkopcIGA+6a0QCnV4SsO/HMmoHyBtr8BTYkI/U2fCAw0pOa4ZaopO2Ujkh6PYeC9fZnYi/sdRQCR+JQk//cHXa6TIp8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735478; c=relaxed/simple;
	bh=J1bTmanfCrK/42SpBvnNvAbrGXqxi/gItSfYLubFIzo=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=JMusZbcLOhNO6RmJ6txrssRSuSGOA9ykKS0n8LexnglHJqoM+RmvMbzz5IpCjEay6LDOE9kV2Jp2NE0EEY9MOJgxLRN4XhJtgJvNeuJjagySjeRX5Y9Z6NXkjg4bEojSfzxUjBJ+C6CWd3XooYnrCczRxH0eq/0YdG3TC0Lgsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=L2aWbVyG; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zs+jjuqV59SC6aR+A/8i7hzPzQTJkbGceMgv3+5Qxj4=; b=L2aWbVyG6r6lhYFJXO/r+F+KG3
	IHSQJ4NkJe5lqOGJVGYk4ayMM7AEEoXWCBvNkLvHa643bCTflGGiQOOvP+ex7tjY+kQ2M9+AFbWAN
	jnzxQt16M+5QM+mlM297f1QoOvzt+oy0eCL/7jze2Gso7I02oj9zYlY4Npmjsg+p0EN3pf5vznUUx
	Im1nW2AMO9K667NZ/xW+v73KH2N+o/fCc0mO9EYzy5SbKNvEJIFZC4xxb6PT7dyKV8cd45pd15G+F
	+B8tLCY2km6aqpS6WQaDtwmLoo3OczcMNfjLxFxWniYxkD2ai3vXItpPVMkyWRkE2lS2AOX1zFg7/
	nuAGkRvg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXh-001LXO-2T;
	Sun, 27 Apr 2025 14:31:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:31:09 +0800
Date: Sun, 27 Apr 2025 14:31:09 +0800
Message-Id: <6e5ff24bf6a9a91aa79feb3dfbb9bce1d73c3fbb.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 12/13] crypto: sha256 - remove sha256_base.h
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld " <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

sha256_base.h is no longer used, so remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/sha256_base.h | 151 -----------------------------------
 1 file changed, 151 deletions(-)
 delete mode 100644 include/crypto/sha256_base.h

diff --git a/include/crypto/sha256_base.h b/include/crypto/sha256_base.h
deleted file mode 100644
index 804361731a7a..000000000000
--- a/include/crypto/sha256_base.h
+++ /dev/null
@@ -1,151 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * sha256_base.h - core logic for SHA-256 implementations
- *
- * Copyright (C) 2015 Linaro Ltd <ard.biesheuvel@linaro.org>
- */
-
-#ifndef _CRYPTO_SHA256_BASE_H
-#define _CRYPTO_SHA256_BASE_H
-
-#include <crypto/internal/blockhash.h>
-#include <crypto/internal/hash.h>
-#include <crypto/internal/sha2.h>
-#include <linux/math.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/unaligned.h>
-
-typedef void (sha256_block_fn)(struct crypto_sha256_state *sst, u8 const *src,
-			       int blocks);
-
-static inline int sha224_base_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
-
-	sha224_init(sctx);
-	return 0;
-}
-
-static inline int sha256_base_init(struct shash_desc *desc)
-{
-	struct sha256_state *sctx = shash_desc_ctx(desc);
-
-	sha256_init(sctx);
-	return 0;
-}
-
-static inline int lib_sha256_base_do_update(struct sha256_state *sctx,
-					    const u8 *data,
-					    unsigned int len,
-					    sha256_block_fn *block_fn)
-{
-	unsigned int partial = sctx->count % SHA256_BLOCK_SIZE;
-
-	sctx->count += len;
-	BLOCK_HASH_UPDATE_BLOCKS(block_fn, &sctx->ctx, data, len,
-				 SHA256_BLOCK_SIZE, sctx->buf, partial);
-	return 0;
-}
-
-static inline int lib_sha256_base_do_update_blocks(
-	struct crypto_sha256_state *sctx, const u8 *data, unsigned int len,
-	sha256_block_fn *block_fn)
-{
-	unsigned int remain = len - round_down(len, SHA256_BLOCK_SIZE);
-
-	sctx->count += len - remain;
-	block_fn(sctx, data, len / SHA256_BLOCK_SIZE);
-	return remain;
-}
-
-static inline int sha256_base_do_update_blocks(
-	struct shash_desc *desc, const u8 *data, unsigned int len,
-	sha256_block_fn *block_fn)
-{
-	return lib_sha256_base_do_update_blocks(shash_desc_ctx(desc), data,
-						len, block_fn);
-}
-
-static inline int lib_sha256_base_do_finup(struct crypto_sha256_state *sctx,
-					   const u8 *src, unsigned int len,
-					   sha256_block_fn *block_fn)
-{
-	unsigned int bit_offset = SHA256_BLOCK_SIZE / 8 - 1;
-	union {
-		__be64 b64[SHA256_BLOCK_SIZE / 4];
-		u8 u8[SHA256_BLOCK_SIZE * 2];
-	} block = {};
-
-	if (len >= bit_offset * 8)
-		bit_offset += SHA256_BLOCK_SIZE / 8;
-	memcpy(&block, src, len);
-	block.u8[len] = 0x80;
-	sctx->count += len;
-	block.b64[bit_offset] = cpu_to_be64(sctx->count << 3);
-	block_fn(sctx, block.u8, (bit_offset + 1) * 8 / SHA256_BLOCK_SIZE);
-	memzero_explicit(&block, sizeof(block));
-
-	return 0;
-}
-
-static inline int sha256_base_do_finup(struct shash_desc *desc,
-				       const u8 *src, unsigned int len,
-				       sha256_block_fn *block_fn)
-{
-	struct crypto_sha256_state *sctx = shash_desc_ctx(desc);
-
-	if (len >= SHA256_BLOCK_SIZE) {
-		int remain;
-
-		remain = lib_sha256_base_do_update_blocks(sctx, src, len,
-							  block_fn);
-		src += len - remain;
-		len = remain;
-	}
-	return lib_sha256_base_do_finup(sctx, src, len, block_fn);
-}
-
-static inline int lib_sha256_base_do_finalize(struct sha256_state *sctx,
-					      sha256_block_fn *block_fn)
-{
-	unsigned int partial = sctx->count % SHA256_BLOCK_SIZE;
-	struct crypto_sha256_state *state = (void *)sctx;
-
-	sctx->count -= partial;
-	return lib_sha256_base_do_finup(state, sctx->buf, partial, block_fn);
-}
-
-static inline int __sha256_base_finish(u32 state[SHA256_DIGEST_SIZE / 4],
-				       u8 *out, unsigned int digest_size)
-{
-	__be32 *digest = (__be32 *)out;
-	int i;
-
-	for (i = 0; digest_size > 0; i++, digest_size -= sizeof(__be32))
-		put_unaligned_be32(state[i], digest++);
-	return 0;
-}
-
-static inline void lib_sha256_base_finish(struct sha256_state *sctx, u8 *out,
-					  unsigned int digest_size)
-{
-	__sha256_base_finish(sctx->state, out, digest_size);
-	memzero_explicit(sctx, sizeof(*sctx));
-}
-
-static inline int sha256_base_finish(struct shash_desc *desc, u8 *out)
-{
-	unsigned int digest_size = crypto_shash_digestsize(desc->tfm);
-	struct crypto_sha256_state *sctx = shash_desc_ctx(desc);
-
-	return __sha256_base_finish(sctx->state, out, digest_size);
-}
-
-static inline void sha256_transform_blocks(struct crypto_sha256_state *sst,
-					   const u8 *input, int blocks)
-{
-	sha256_blocks_generic(sst->state, input, blocks);
-}
-
-#endif /* _CRYPTO_SHA256_BASE_H */
-- 
2.39.5


