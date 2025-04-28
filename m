Return-Path: <linux-arch+bounces-11665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6CA9F6C8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88CC5A495E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238262951D8;
	Mon, 28 Apr 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nag0WVQ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35212951C0;
	Mon, 28 Apr 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859727; cv=none; b=pLnpc70ZEOuQWPTCbp6ewj/p6TvfiMMCljVLpxDqm3Vd5julu4z48iPL/C2FlGoz63AcOZa/zRBRvWzk0pFt8ermlCuaqPrhMdrXhbxHx/2z4+DgG6TumpryGnRmwdvUMZF1x+ZdjZv5N6lY49WyIKtJSsGW9PM3WIRTDufmWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859727; c=relaxed/simple;
	bh=E4ZzeBfk2GgJquy2SDIZkSeNX8NfXIoZAmTNK3XNeXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk3uQOAuSB2+8kCiaeHMBAGvIrWYoOlAEirWS/shkcET1oyiCZfDu5CmNkLwFpIRIht9nHzNgnDuc3LaJfAHf+CdkZXuFSCpFdi94Au5//lLovV+FoKUP4n/CfUn14b5n6Mp6oeZhxEF1/AHYZRI2fqoaAIx8W2VzoRYQ5sAMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nag0WVQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F35C4CEEE;
	Mon, 28 Apr 2025 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745859726;
	bh=E4ZzeBfk2GgJquy2SDIZkSeNX8NfXIoZAmTNK3XNeXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nag0WVQ8E1TihrQTSEoFR0DZgEIeqxXwyV4+iqc41yTiRiDzs5/2T7qkhTZmHaBIe
	 3NpNYnemnWcQOCXagA5m6zVEi7yUaK7qNITYrJvmQFRS87Igf4LlFVCkGoqoGOGCVG
	 rsFgw3ex79z6SbNqm4v8+b5mBZMqZ9O4OXQBeaDADtRT7kk2/LXqD81qq3/EBLuNs4
	 Xf+BQasDscoPMcUxBho7bRSlGZgBqQCEuwezVvdvBqukAt516lxDSngixk8QEtC60Q
	 hSwIdPcr5osF5Xfc1HTMgM8PDAUDpsO71gwKURmbiK0loWyPcYwTVOaYNJujt2ACtq
	 ABI2T4XgqEKSw==
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
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 13/13] crypto: lib/sha256 - improve function prototypes
Date: Mon, 28 Apr 2025 10:00:38 -0700
Message-ID: <20250428170040.423825-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428170040.423825-1-ebiggers@kernel.org>
References: <20250428170040.423825-1-ebiggers@kernel.org>
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
index 4b19cf977ef1b..563f09c9f3815 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -68,11 +68,11 @@ static inline void __sha256_update(struct sha256_state *sctx, const u8 *data,
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
 
@@ -99,23 +99,23 @@ static inline void __sha256_final(struct sha256_state *sctx, u8 *out,
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


