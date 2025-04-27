Return-Path: <linux-arch+bounces-11630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9AEA9DFE4
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1A41A83D71
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C52528EB;
	Sun, 27 Apr 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="c/bG7Pmo"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B61252284;
	Sun, 27 Apr 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735479; cv=none; b=jkDKMq+qPXpmRdBCDTI/wgtzJBBPZtqpOsOQ/NXu9oFqB8aDfKEMWBSezkFXOXhTVjvHX7cTw6pswaePhiqMy/zzMFxfszwAiTJ4r7t6f1wI09GOkiIFv0rl5IXPHKpR03zAKiLqZsLO0fXWhX4iMxxrkWhVZVqaFjLhsouDfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735479; c=relaxed/simple;
	bh=SQtb6nAdMsr+moU0ZJo9JpOgHQ/TtzTkBQl/+CKgm00=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=HrsRfn5P/mACOgfm3jU5KiIt0eqPrViTOVdLtc7SxNx9OqEPLk5Bosxjfpte1x+YA1fOJnwqImbpop2B5gM6vC7aropSuTVawsLbtpczbJO1q+WK1a5BWx+5V3ERAIQQy0CgMZMEwDzAMC5SFn1IwYpiY8R+dgDjBflvGo63tXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=c/bG7Pmo; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p52B43yI7yzG7IFY2yqwoQVRnjSzHB18F+tstzNAX4I=; b=c/bG7PmonGoeGCcd/Ntc0Cz8ar
	hBLXW/VxFBpKXZi3xo5i2meaz/6R3cCqYVdKIiRLrWN8VtjiN2F2WnWy/q1ssBztd4D9XD5HFR1jA
	5Pkj4sPqYktI1OYjVt90QVAYdnL20m4K4SVVgn/yL8O0uNkSi9U1peWa/6h9PeYowVZbIjhDo8FqJ
	e5ZTZoS2dqBy9gLSGnQ/qAy9o28ctdu2ZwBndw9Y4lbPpberlPlWMKIVZb8QJwVZpQTkg2i0d621G
	Iq5lPqLx2si1FzrOOa00uCCojbqrFJ2or0Rid0kTydSAI9sRXY8WsdsztGHyCvAvDQYfbfeArMD6z
	RHhemc1A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8vXk-001LXh-0E;
	Sun, 27 Apr 2025 14:31:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 14:31:12 +0800
Date: Sun, 27 Apr 2025 14:31:12 +0800
Message-Id: <e1fd4c41e9c1e0da47176b811e23ae2c84fa1d98.1745734678.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745734678.git.herbert@gondor.apana.org.au>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 13/13] crypto: lib/sha256 - improve function prototypes
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld " <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Follow best practices by changing the length parameters to size_t and
explicitly specifying the length of the output digest arrays.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/internal/sha2.h |  2 +-
 include/crypto/sha2.h          |  8 ++++----
 lib/crypto/sha256.c            | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/crypto/internal/sha2.h b/include/crypto/internal/sha2.h
index 09f622c2ae7d..421872a93a83 100644
--- a/include/crypto/internal/sha2.h
+++ b/include/crypto/internal/sha2.h
@@ -46,7 +46,7 @@ static inline void sha256_choose_blocks(
 
 static __always_inline void sha256_finup(
 	struct crypto_sha256_state *sctx, const u8 *src, unsigned int len,
-	u8 *out, size_t digest_size, bool force_generic,
+	u8 out[SHA256_DIGEST_SIZE], size_t digest_size, bool force_generic,
 	bool force_simd)
 {
 	unsigned int bit_offset = SHA256_BLOCK_SIZE / 8 - 1;
diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index 9a56286d736d..9853cd2d1291 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -100,9 +100,9 @@ static inline void sha256_init(struct sha256_state *sctx)
 	sctx->state[7] = SHA256_H7;
 	sctx->count = 0;
 }
-void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len);
-void sha256_final(struct sha256_state *sctx, u8 *out);
-void sha256(const u8 *data, unsigned int len, u8 *out);
+void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len);
+void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE]);
+void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE]);
 
 static inline void sha224_init(struct sha256_state *sctx)
 {
@@ -117,6 +117,6 @@ static inline void sha224_init(struct sha256_state *sctx)
 	sctx->count = 0;
 }
 /* Simply use sha256_update as it is equivalent to sha224_update. */
-void sha224_final(struct sha256_state *sctx, u8 *out);
+void sha224_final(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE]);
 
 #endif /* _CRYPTO_SHA2_H */
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index d2bd9fdb8571..107d2bdea682 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -33,7 +33,7 @@ static inline void sha256_blocks(u32 state[SHA256_STATE_WORDS], const u8 *data,
 			     sha256_force_generic(), false);
 }
 
-void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
+void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len)
 {
 	size_t partial = sctx->count % SHA256_BLOCK_SIZE;
 
@@ -43,8 +43,8 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 }
 EXPORT_SYMBOL(sha256_update);
 
-static void __sha256_final(struct sha256_state *sctx, u8 *out,
-			   size_t digest_size)
+static void __sha256_final(struct sha256_state *sctx,
+			   u8 out[SHA256_DIGEST_SIZE], size_t digest_size)
 {
 	unsigned int len = sctx->count % SHA256_BLOCK_SIZE;
 
@@ -54,19 +54,19 @@ static void __sha256_final(struct sha256_state *sctx, u8 *out,
 	memzero_explicit(sctx, sizeof(*sctx));
 }
 
-void sha256_final(struct sha256_state *sctx, u8 *out)
+void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE])
 {
 	__sha256_final(sctx, out, SHA256_DIGEST_SIZE);
 }
 EXPORT_SYMBOL(sha256_final);
 
-void sha224_final(struct sha256_state *sctx, u8 *out)
+void sha224_final(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE])
 {
 	__sha256_final(sctx, out, SHA224_DIGEST_SIZE);
 }
 EXPORT_SYMBOL(sha224_final);
 
-void sha256(const u8 *data, unsigned int len, u8 *out)
+void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE])
 {
 	struct sha256_state sctx;
 
-- 
2.39.5


