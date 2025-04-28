Return-Path: <linux-arch+bounces-11649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752D2A9E7B6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 07:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A617AFBD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07F20E003;
	Mon, 28 Apr 2025 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="CVAR2Ix3"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1C209F5A;
	Mon, 28 Apr 2025 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745817459; cv=none; b=IQxLF5KBeTyEhMv3df02ixR0ce2i507F/rX92tfbwJmgJ5iPucAxGZreNiVYS9HYn/IkSuQF2F1Z9fWSGvurTeH47aSeKOCNvVoAb8bhoqc7SZC7nTX6eIWUgvwnjzavfNgzfujwyTKwpc69rrgzXR17TGuu0UxNWcoJxv6M2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745817459; c=relaxed/simple;
	bh=3Hr/NZujGM7tGbdFMXAHaZVvz0LsweGBPWUSdQ4mHvs=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=ShIBMRzWnPdC6jOtPSEir5y01DQhqC+XHAqjALXbGz6bxM4uvV5qdb6kakDOF0gv6CPox9HKG9mkcIxew4GLTd4xiIfpG79xL1iwQR2W7w2x90A63/FVPLkDd1ZLFDKFynTc95zx/BkRKZCDlc332jFx8QLXjrDgmHUpajjiftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=CVAR2Ix3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GB9/DZlVKQ+qX1C/pXbez0MkOkRiHenUXD6OWOuCEZs=; b=CVAR2Ix3IfhZQmpfOpkslfwtId
	Hlx7GZhAXeDLd38FBrIcfXPECpLUEFQes2kYLfGw36skzAGoBU/HwsB+kw5lEV46hoFiABvWRp1YY
	tIZvMun+xGqBsNvA53UxfPhPKi83+pWsISxJ1T8YnbiVOsCBh8/0AokycWgZy8BD/3/Az6gp/rLnG
	GCI6x0zgmUWVZeZpSWuYSy7Ibvh+DaRPvp5QRZi+5JwBmrZ9j0JUcpzfDWU1eZtT142silVTEiDcK
	Zmd+4T/ITi0Xd3Eso3737704RQM9K4xdXm9ZMzIpVdz45evkjIfv5r3ewihD74Y5i42P/J2W+ggEt
	IFdqSL5w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9Gs0-001WUX-0r;
	Mon, 28 Apr 2025 13:17:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Apr 2025 13:17:32 +0800
Date: Mon, 28 Apr 2025 13:17:32 +0800
Message-Id: <f97814714c68dcf60028a2927d541b2e8c81c3bf.1745816372.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745816372.git.herbert@gondor.apana.org.au>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 13/13] crypto: lib/sha256 - improve function prototypes
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
index a27e2bf1842d..4912572578dc 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -105,9 +105,9 @@ static inline void sha256_init(struct sha256_state *sctx)
 {
 	sha256_block_init(&sctx->ctx);
 }
-void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len);
-void sha256_final(struct sha256_state *sctx, u8 *out);
-void sha256(const u8 *data, unsigned int len, u8 *out);
+void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len);
+void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE]);
+void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE]);
 
 static inline void sha224_block_init(struct crypto_sha256_state *sctx)
 {
@@ -127,6 +127,6 @@ static inline void sha224_init(struct sha256_state *sctx)
 	sha224_block_init(&sctx->ctx);
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


