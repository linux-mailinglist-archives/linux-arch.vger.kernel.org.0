Return-Path: <linux-arch+bounces-11596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F5EA9D8CD
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 08:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F52B7AC244
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 06:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE101204598;
	Sat, 26 Apr 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HilrkFzM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F522036FE;
	Sat, 26 Apr 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745650306; cv=none; b=q9ST3ajb3bpXj2W2AcUMCrWgUFuxNE3+fRi85Ic9JS1QQjayUXMeRhG+d5x4fe0KhI31GqxZ2A8wfkbkIgLRf+NLZ0EoMxP3AZXYx5A0Eoc6JOmYpTuA8CgZiF9GQWd8qqTHJQKq/C7HntUSAHdrpHuhCfsboMzZvWEvyOmi1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745650306; c=relaxed/simple;
	bh=uxkZytCeZvKEdMW9eFrdi+rqyJFN6GhaSoUePQ/ntfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACiguzyKiplXs8G92wFz7SHnrkLwo3cSiK7qiXe3dYx07Hes7+lyhjlW3eElq//oe2QRgRAD6imoVPGH9jih9Vt3vt5D3uRTK2/tNNvyqfueJlyEu2ZkE5FlUD6tqOUMn13sxjPvpGiB5zApMscUMRYXuekkFjHNQiSNDeDGS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HilrkFzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09417C4CEED;
	Sat, 26 Apr 2025 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745650306;
	bh=uxkZytCeZvKEdMW9eFrdi+rqyJFN6GhaSoUePQ/ntfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HilrkFzMypaE/jIuU0kTXgtftC4qBLOTw4seM8HhEu/vbFizNFfHH6KMuDCWnG6Q/
	 KZPP3M7aruiQPHkimuNafc0ZgceaGQVq7ihnupITN9O6kx0XqsuuUAkEzbVAzyOYeX
	 eQyqtz08tOMEv+wvVdrqGo0qjmnc6yj+Mk9W+BXiXEPwTGvG4hdgUi29/4kuoy8hmw
	 CxUKHIyOuWc/K/8MGHFuDPyXBSUbyq41L95FNpDiYx9Vo0epwwRv7r8GF9cSfKtMBQ
	 cVCOCOElXPtNz7aRifsPpDm9k1hZ8uJ05EZZUo+ycNHIvMt3kVa6z4k3RpSwuY1UqN
	 X3XoiFpLXmAJA==
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
Subject: [PATCH 13/13] crypto: lib/sha256 - improve function prototypes
Date: Fri, 25 Apr 2025 23:50:39 -0700
Message-ID: <20250426065041.1551914-14-ebiggers@kernel.org>
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

Follow best practices by changing the length parameters to size_t and
explicitly specifying the length of the output digest arrays.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/sha2.h | 8 ++++----
 lib/crypto/sha256.c   | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/crypto/sha2.h b/include/crypto/sha2.h
index 444484d1b1cfa..7dfc560daa2c7 100644
--- a/include/crypto/sha2.h
+++ b/include/crypto/sha2.h
@@ -93,13 +93,13 @@ static inline void sha256_init(struct sha256_state *sctx)
 	sctx->state[5] = SHA256_H5;
 	sctx->state[6] = SHA256_H6;
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
 	sctx->state[0] = SHA224_H0;
 	sctx->state[1] = SHA224_H1;
@@ -110,8 +110,8 @@ static inline void sha224_init(struct sha256_state *sctx)
 	sctx->state[6] = SHA224_H6;
 	sctx->state[7] = SHA224_H7;
 	sctx->count = 0;
 }
 /* Simply use sha256_update as it is equivalent to sha224_update. */
-void sha224_final(struct sha256_state *sctx, u8 *out);
+void sha224_final(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE]);
 
 #endif /* _CRYPTO_SHA2_H */
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 182d1088d8893..50b7eeac2d89e 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -182,11 +182,11 @@ static inline void __sha256_update(struct sha256_state *sctx, const u8 *data,
 	}
 	if (len)
 		memcpy(&sctx->buf[partial], data, len);
 }
 
-void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
+void sha256_update(struct sha256_state *sctx, const u8 *data, size_t len)
 {
 	__sha256_update(sctx, data, len, false);
 }
 EXPORT_SYMBOL(sha256_update);
 
@@ -213,23 +213,23 @@ static inline void __sha256_final(struct sha256_state *sctx, u8 *out,
 		put_unaligned_be32(sctx->state[i / 4], out + i);
 
 	memzero_explicit(sctx, sizeof(*sctx));
 }
 
-void sha256_final(struct sha256_state *sctx, u8 *out)
+void sha256_final(struct sha256_state *sctx, u8 out[SHA256_DIGEST_SIZE])
 {
 	__sha256_final(sctx, out, SHA256_DIGEST_SIZE, false);
 }
 EXPORT_SYMBOL(sha256_final);
 
-void sha224_final(struct sha256_state *sctx, u8 *out)
+void sha224_final(struct sha256_state *sctx, u8 out[SHA224_DIGEST_SIZE])
 {
 	__sha256_final(sctx, out, SHA224_DIGEST_SIZE, false);
 }
 EXPORT_SYMBOL(sha224_final);
 
-void sha256(const u8 *data, unsigned int len, u8 *out)
+void sha256(const u8 *data, size_t len, u8 out[SHA256_DIGEST_SIZE])
 {
 	struct sha256_state sctx;
 
 	sha256_init(&sctx);
 	sha256_update(&sctx, data, len);
-- 
2.49.0


