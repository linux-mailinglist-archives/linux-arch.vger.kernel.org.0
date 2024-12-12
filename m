Return-Path: <linux-arch+bounces-9367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA29EF953
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E47D28F629
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B5225A2C;
	Thu, 12 Dec 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s1ETimUa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829F209695;
	Thu, 12 Dec 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025745; cv=none; b=kgqUr1xSBdugpAxwBN/IN0ACBWZjWb4ElOONOe34fk6zI1uuIGvEG4Xmrb9/9EMrJvbTx8BA/4XiT8qgsv2tYLXPpoVamoa/Wl0TJTECp0gJGZxpE81q/Oq6pm29ED6wY0YD1lXvS3IlaDkdymF+WhcxiHH6VhvPLrEdZby2p9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025745; c=relaxed/simple;
	bh=owPE42zZaxSsGoAJPnNUzD6R5EIfiYpT8WHeWp2pkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev67niPZ6OgLHfUStWwh7e+wPxCPT7h+/VDwFm4rArN24yKgUFp3DP8Gul5QspQ4B52MXtX0vtDaJQNBSOM2NMnFahd6MfnVwklBNiWsrQCvdJDHmf5NSe1z8G2b13ImpltoTa4+A25JeUWnfsCTxveqLY69pHkFsd5nev6Nv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s1ETimUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4169C4CECE;
	Thu, 12 Dec 2024 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025745;
	bh=owPE42zZaxSsGoAJPnNUzD6R5EIfiYpT8WHeWp2pkhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1ETimUaLWN+FW+Vfi3Y0zvCPv84uZGqDCYzJ/c9Dn2+AbCc8VCkg5o7WLhSEPCej
	 QBorxPr2tBRG5XbVL8ADRAIiZuz5Tto6P37LZcGO1tojVmAZYjR2vyWnH5Amr4X0+k
	 GKVy3oaocrcxt+CLdiaRkwz9KIkJyX0tUoPyJz8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Slaby <jslaby@suse.cz>,
	Borislav Petkov <bp@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arch@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	x86-ml <x86@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 243/321] x86/asm/crypto: Annotate local functions
Date: Thu, 12 Dec 2024 16:02:41 +0100
Message-ID: <20241212144239.574474355@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 74d8b90a889022e306b543ff2147a6941c99b354 ]

Use the newly added SYM_FUNC_START_LOCAL to annotate beginnings of all
functions which do not have ".globl" annotation, but their endings are
annotated by ENDPROC. This is needed to balance ENDPROC for tools that
generate debuginfo.

These function names are not prepended with ".L" as they might appear in
call traces and they wouldn't be visible after such change.

To be symmetric, the functions' ENDPROCs are converted to the new
SYM_FUNC_END.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-7-jslaby@suse.cz
Stable-dep-of: 3b2f2d22fb42 ("crypto: x86/aegis128 - access 32-bit arguments as 32-bit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S         |  8 ++--
 arch/x86/crypto/aesni-intel_asm.S            | 49 ++++++++------------
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 ++--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 ++--
 arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 ++--
 arch/x86/crypto/serpent-avx2-asm_64.S        |  8 ++--
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 ++--
 11 files changed, 68 insertions(+), 77 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 4434607e366dc..b7026fdef4ff2 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -71,7 +71,7 @@
  *   %r8
  *   %r9
  */
-__load_partial:
+SYM_FUNC_START_LOCAL(__load_partial)
 	xor %r9d, %r9d
 	pxor MSG, MSG
 
@@ -123,7 +123,7 @@ __load_partial:
 
 .Lld_partial_8:
 	ret
-ENDPROC(__load_partial)
+SYM_FUNC_END(__load_partial)
 
 /*
  * __store_partial: internal ABI
@@ -137,7 +137,7 @@ ENDPROC(__load_partial)
  *   %r9
  *   %r10
  */
-__store_partial:
+SYM_FUNC_START_LOCAL(__store_partial)
 	mov LEN, %r8
 	mov DST, %r9
 
@@ -181,7 +181,7 @@ __store_partial:
 
 .Lst_partial_1:
 	ret
-ENDPROC(__store_partial)
+SYM_FUNC_END(__store_partial)
 
 /*
  * void crypto_aegis128_aesni_init(void *state, const void *key, const void *iv);
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index dd954d8db629b..ef62383c6bd8f 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1759,7 +1759,7 @@ ENDPROC(aesni_gcm_finalize)
 
 .align 4
 _key_expansion_128:
-_key_expansion_256a:
+SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1770,10 +1770,9 @@ _key_expansion_256a:
 	add $0x10, TKEYP
 	ret
 ENDPROC(_key_expansion_128)
-ENDPROC(_key_expansion_256a)
+SYM_FUNC_END(_key_expansion_256a)
 
-.align 4
-_key_expansion_192a:
+SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1795,10 +1794,9 @@ _key_expansion_192a:
 	movaps %xmm1, 0x10(TKEYP)
 	add $0x20, TKEYP
 	ret
-ENDPROC(_key_expansion_192a)
+SYM_FUNC_END(_key_expansion_192a)
 
-.align 4
-_key_expansion_192b:
+SYM_FUNC_START_LOCAL(_key_expansion_192b)
 	pshufd $0b01010101, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
 	pxor %xmm4, %xmm0
@@ -1815,10 +1813,9 @@ _key_expansion_192b:
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
 	ret
-ENDPROC(_key_expansion_192b)
+SYM_FUNC_END(_key_expansion_192b)
 
-.align 4
-_key_expansion_256b:
+SYM_FUNC_START_LOCAL(_key_expansion_256b)
 	pshufd $0b10101010, %xmm1, %xmm1
 	shufps $0b00010000, %xmm2, %xmm4
 	pxor %xmm4, %xmm2
@@ -1828,7 +1825,7 @@ _key_expansion_256b:
 	movaps %xmm2, (TKEYP)
 	add $0x10, TKEYP
 	ret
-ENDPROC(_key_expansion_256b)
+SYM_FUNC_END(_key_expansion_256b)
 
 /*
  * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
@@ -1981,8 +1978,7 @@ ENDPROC(aesni_enc)
  *	KEY
  *	TKEYP (T1)
  */
-.align 4
-_aesni_enc1:
+SYM_FUNC_START_LOCAL(_aesni_enc1)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE		# round 0
@@ -2025,7 +2021,7 @@ _aesni_enc1:
 	movaps 0x70(TKEYP), KEY
 	AESENCLAST KEY STATE
 	ret
-ENDPROC(_aesni_enc1)
+SYM_FUNC_END(_aesni_enc1)
 
 /*
  * _aesni_enc4:	internal ABI
@@ -2045,8 +2041,7 @@ ENDPROC(_aesni_enc1)
  *	KEY
  *	TKEYP (T1)
  */
-.align 4
-_aesni_enc4:
+SYM_FUNC_START_LOCAL(_aesni_enc4)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE1		# round 0
@@ -2134,7 +2129,7 @@ _aesni_enc4:
 	AESENCLAST KEY STATE3
 	AESENCLAST KEY STATE4
 	ret
-ENDPROC(_aesni_enc4)
+SYM_FUNC_END(_aesni_enc4)
 
 /*
  * void aesni_dec (const void *ctx, u8 *dst, const u8 *src)
@@ -2173,8 +2168,7 @@ ENDPROC(aesni_dec)
  *	KEY
  *	TKEYP (T1)
  */
-.align 4
-_aesni_dec1:
+SYM_FUNC_START_LOCAL(_aesni_dec1)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE		# round 0
@@ -2217,7 +2211,7 @@ _aesni_dec1:
 	movaps 0x70(TKEYP), KEY
 	AESDECLAST KEY STATE
 	ret
-ENDPROC(_aesni_dec1)
+SYM_FUNC_END(_aesni_dec1)
 
 /*
  * _aesni_dec4:	internal ABI
@@ -2237,8 +2231,7 @@ ENDPROC(_aesni_dec1)
  *	KEY
  *	TKEYP (T1)
  */
-.align 4
-_aesni_dec4:
+SYM_FUNC_START_LOCAL(_aesni_dec4)
 	movaps (KEYP), KEY		# key
 	mov KEYP, TKEYP
 	pxor KEY, STATE1		# round 0
@@ -2326,7 +2319,7 @@ _aesni_dec4:
 	AESDECLAST KEY STATE3
 	AESDECLAST KEY STATE4
 	ret
-ENDPROC(_aesni_dec4)
+SYM_FUNC_END(_aesni_dec4)
 
 /*
  * void aesni_ecb_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
@@ -2604,8 +2597,7 @@ ENDPROC(aesni_cbc_dec)
  *	INC:	== 1, in little endian
  *	BSWAP_MASK == endian swapping mask
  */
-.align 4
-_aesni_inc_init:
+SYM_FUNC_START_LOCAL(_aesni_inc_init)
 	movaps .Lbswap_mask, BSWAP_MASK
 	movaps IV, CTR
 	PSHUFB_XMM BSWAP_MASK CTR
@@ -2613,7 +2605,7 @@ _aesni_inc_init:
 	MOVQ_R64_XMM TCTR_LOW INC
 	MOVQ_R64_XMM CTR TCTR_LOW
 	ret
-ENDPROC(_aesni_inc_init)
+SYM_FUNC_END(_aesni_inc_init)
 
 /*
  * _aesni_inc:		internal ABI
@@ -2630,8 +2622,7 @@ ENDPROC(_aesni_inc_init)
  *	CTR:	== output IV, in little endian
  *	TCTR_LOW: == lower qword of CTR
  */
-.align 4
-_aesni_inc:
+SYM_FUNC_START_LOCAL(_aesni_inc)
 	paddq INC, CTR
 	add $1, TCTR_LOW
 	jnc .Linc_low
@@ -2642,7 +2633,7 @@ _aesni_inc:
 	movaps CTR, IV
 	PSHUFB_XMM BSWAP_MASK IV
 	ret
-ENDPROC(_aesni_inc)
+SYM_FUNC_END(_aesni_inc)
 
 /*
  * void aesni_ctr_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
diff --git a/arch/x86/crypto/camellia-aesni-avx-asm_64.S b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
index a14af6eb09cb0..f4408ca55fdb3 100644
--- a/arch/x86/crypto/camellia-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx-asm_64.S
@@ -189,20 +189,20 @@
  * larger and would only be 0.5% faster (on sandy-bridge).
  */
 .align 8
-roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd:
+SYM_FUNC_START_LOCAL(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm16(%xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 		  %xmm8, %xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, %xmm15,
 		  %rcx, (%r9));
 	ret;
-ENDPROC(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
+SYM_FUNC_END(roundsm16_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
 .align 8
-roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab:
+SYM_FUNC_START_LOCAL(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm16(%xmm4, %xmm5, %xmm6, %xmm7, %xmm0, %xmm1, %xmm2, %xmm3,
 		  %xmm12, %xmm13, %xmm14, %xmm15, %xmm8, %xmm9, %xmm10, %xmm11,
 		  %rax, (%r9));
 	ret;
-ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
+SYM_FUNC_END(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
  * IN/OUT:
@@ -722,7 +722,7 @@ ENDPROC(roundsm16_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 .text
 
 .align 8
-__camellia_enc_blk16:
+SYM_FUNC_START_LOCAL(__camellia_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 256 bytes
@@ -806,10 +806,10 @@ __camellia_enc_blk16:
 		     %xmm15, %rax, %rcx, 24);
 
 	jmp .Lenc_done;
-ENDPROC(__camellia_enc_blk16)
+SYM_FUNC_END(__camellia_enc_blk16)
 
 .align 8
-__camellia_dec_blk16:
+SYM_FUNC_START_LOCAL(__camellia_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 256 bytes
@@ -891,7 +891,7 @@ __camellia_dec_blk16:
 	      ((key_table + (24) * 8) + 4)(CTX));
 
 	jmp .Ldec_max24;
-ENDPROC(__camellia_dec_blk16)
+SYM_FUNC_END(__camellia_dec_blk16)
 
 ENTRY(camellia_ecb_enc_16way)
 	/* input:
@@ -1120,7 +1120,7 @@ ENDPROC(camellia_ctr_16way)
 	vpxor tmp, iv, iv;
 
 .align 8
-camellia_xts_crypt_16way:
+SYM_FUNC_START_LOCAL(camellia_xts_crypt_16way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (16 blocks)
@@ -1254,7 +1254,7 @@ camellia_xts_crypt_16way:
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_xts_crypt_16way)
+SYM_FUNC_END(camellia_xts_crypt_16way)
 
 ENTRY(camellia_xts_enc_16way)
 	/* input:
diff --git a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
index 4be4c7c3ba273..72ae3edd09979 100644
--- a/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/camellia-aesni-avx2-asm_64.S
@@ -223,20 +223,20 @@
  * larger and would only marginally faster.
  */
 .align 8
-roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd:
+SYM_FUNC_START_LOCAL(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 	roundsm32(%ymm0, %ymm1, %ymm2, %ymm3, %ymm4, %ymm5, %ymm6, %ymm7,
 		  %ymm8, %ymm9, %ymm10, %ymm11, %ymm12, %ymm13, %ymm14, %ymm15,
 		  %rcx, (%r9));
 	ret;
-ENDPROC(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
+SYM_FUNC_END(roundsm32_x0_x1_x2_x3_x4_x5_x6_x7_y0_y1_y2_y3_y4_y5_y6_y7_cd)
 
 .align 8
-roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab:
+SYM_FUNC_START_LOCAL(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 	roundsm32(%ymm4, %ymm5, %ymm6, %ymm7, %ymm0, %ymm1, %ymm2, %ymm3,
 		  %ymm12, %ymm13, %ymm14, %ymm15, %ymm8, %ymm9, %ymm10, %ymm11,
 		  %rax, (%r9));
 	ret;
-ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
+SYM_FUNC_END(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 
 /*
  * IN/OUT:
@@ -760,7 +760,7 @@ ENDPROC(roundsm32_x4_x5_x6_x7_x0_x1_x2_x3_y4_y5_y6_y7_y0_y1_y2_y3_ab)
 .text
 
 .align 8
-__camellia_enc_blk32:
+SYM_FUNC_START_LOCAL(__camellia_enc_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 512 bytes
@@ -844,10 +844,10 @@ __camellia_enc_blk32:
 		     %ymm15, %rax, %rcx, 24);
 
 	jmp .Lenc_done;
-ENDPROC(__camellia_enc_blk32)
+SYM_FUNC_END(__camellia_enc_blk32)
 
 .align 8
-__camellia_dec_blk32:
+SYM_FUNC_START_LOCAL(__camellia_dec_blk32)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rax: temporary storage, 512 bytes
@@ -929,7 +929,7 @@ __camellia_dec_blk32:
 	      ((key_table + (24) * 8) + 4)(CTX));
 
 	jmp .Ldec_max24;
-ENDPROC(__camellia_dec_blk32)
+SYM_FUNC_END(__camellia_dec_blk32)
 
 ENTRY(camellia_ecb_enc_32way)
 	/* input:
@@ -1222,7 +1222,7 @@ ENDPROC(camellia_ctr_32way)
 	vpxor tmp1, iv, iv;
 
 .align 8
-camellia_xts_crypt_32way:
+SYM_FUNC_START_LOCAL(camellia_xts_crypt_32way)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	%rsi: dst (32 blocks)
@@ -1367,7 +1367,7 @@ camellia_xts_crypt_32way:
 
 	FRAME_END
 	ret;
-ENDPROC(camellia_xts_crypt_32way)
+SYM_FUNC_END(camellia_xts_crypt_32way)
 
 ENTRY(camellia_xts_enc_32way)
 	/* input:
diff --git a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
index dc55c3332fcc4..ef86c6a966de1 100644
--- a/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast5-avx-x86_64-asm_64.S
@@ -209,7 +209,7 @@
 .text
 
 .align 16
-__cast5_enc_blk16:
+SYM_FUNC_START_LOCAL(__cast5_enc_blk16)
 	/* input:
 	 *	%rdi: ctx
 	 *	RL1: blocks 1 and 2
@@ -280,10 +280,10 @@ __cast5_enc_blk16:
 	outunpack_blocks(RR4, RL4, RTMP, RX, RKM);
 
 	ret;
-ENDPROC(__cast5_enc_blk16)
+SYM_FUNC_END(__cast5_enc_blk16)
 
 .align 16
-__cast5_dec_blk16:
+SYM_FUNC_START_LOCAL(__cast5_dec_blk16)
 	/* input:
 	 *	%rdi: ctx
 	 *	RL1: encrypted blocks 1 and 2
@@ -357,7 +357,7 @@ __cast5_dec_blk16:
 .L__skip_dec:
 	vpsrldq $4, RKR, RKR;
 	jmp .L__dec_tail;
-ENDPROC(__cast5_dec_blk16)
+SYM_FUNC_END(__cast5_dec_blk16)
 
 ENTRY(cast5_ecb_enc_16way)
 	/* input:
diff --git a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
index 4f0a7cdb94d9d..b080a7454e70e 100644
--- a/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/cast6-avx-x86_64-asm_64.S
@@ -247,7 +247,7 @@
 .text
 
 .align 8
-__cast6_enc_blk8:
+SYM_FUNC_START_LOCAL(__cast6_enc_blk8)
 	/* input:
 	 *	%rdi: ctx
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -292,10 +292,10 @@ __cast6_enc_blk8:
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
 	ret;
-ENDPROC(__cast6_enc_blk8)
+SYM_FUNC_END(__cast6_enc_blk8)
 
 .align 8
-__cast6_dec_blk8:
+SYM_FUNC_START_LOCAL(__cast6_dec_blk8)
 	/* input:
 	 *	%rdi: ctx
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: encrypted blocks
@@ -339,7 +339,7 @@ __cast6_dec_blk8:
 	outunpack_blocks(RA2, RB2, RC2, RD2, RTMP, RX, RKRF, RKM);
 
 	ret;
-ENDPROC(__cast6_dec_blk8)
+SYM_FUNC_END(__cast6_dec_blk8)
 
 ENTRY(cast6_ecb_enc_8way)
 	/* input:
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/crypto/chacha-ssse3-x86_64.S
index 2d86c7d6dc88c..361d2bfc253cb 100644
--- a/arch/x86/crypto/chacha-ssse3-x86_64.S
+++ b/arch/x86/crypto/chacha-ssse3-x86_64.S
@@ -33,7 +33,7 @@ CTRINC:	.octa 0x00000003000000020000000100000000
  *
  * Clobbers: %r8d, %xmm4-%xmm7
  */
-chacha_permute:
+SYM_FUNC_START_LOCAL(chacha_permute)
 
 	movdqa		ROT8(%rip),%xmm4
 	movdqa		ROT16(%rip),%xmm5
@@ -109,7 +109,7 @@ chacha_permute:
 	jnz		.Ldoubleround
 
 	ret
-ENDPROC(chacha_permute)
+SYM_FUNC_END(chacha_permute)
 
 ENTRY(chacha_block_xor_ssse3)
 	# %rdi: Input state matrix, s
diff --git a/arch/x86/crypto/ghash-clmulni-intel_asm.S b/arch/x86/crypto/ghash-clmulni-intel_asm.S
index 5d53effe8abee..e81da25a33caf 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_asm.S
+++ b/arch/x86/crypto/ghash-clmulni-intel_asm.S
@@ -44,7 +44,7 @@
  *	T2
  *	T3
  */
-__clmul_gf128mul_ble:
+SYM_FUNC_START_LOCAL(__clmul_gf128mul_ble)
 	movaps DATA, T1
 	pshufd $0b01001110, DATA, T2
 	pshufd $0b01001110, SHASH, T3
@@ -87,7 +87,7 @@ __clmul_gf128mul_ble:
 	pxor T2, T1
 	pxor T1, DATA
 	ret
-ENDPROC(__clmul_gf128mul_ble)
+SYM_FUNC_END(__clmul_gf128mul_ble)
 
 /* void clmul_ghash_mul(char *dst, const u128 *shash) */
 ENTRY(clmul_ghash_mul)
diff --git a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
index ddc51dbba3af9..a098aa0157840 100644
--- a/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/serpent-avx-x86_64-asm_64.S
@@ -555,7 +555,7 @@
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
 .align 8
-__serpent_enc_blk8_avx:
+SYM_FUNC_START_LOCAL(__serpent_enc_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -606,10 +606,10 @@ __serpent_enc_blk8_avx:
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(__serpent_enc_blk8_avx)
+SYM_FUNC_END(__serpent_enc_blk8_avx)
 
 .align 8
-__serpent_dec_blk8_avx:
+SYM_FUNC_START_LOCAL(__serpent_dec_blk8_avx)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: encrypted blocks
@@ -660,7 +660,7 @@ __serpent_dec_blk8_avx:
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(__serpent_dec_blk8_avx)
+SYM_FUNC_END(__serpent_dec_blk8_avx)
 
 ENTRY(serpent_ecb_enc_8way_avx)
 	/* input:
diff --git a/arch/x86/crypto/serpent-avx2-asm_64.S b/arch/x86/crypto/serpent-avx2-asm_64.S
index 37bc1d48106c4..6149ba80b4d16 100644
--- a/arch/x86/crypto/serpent-avx2-asm_64.S
+++ b/arch/x86/crypto/serpent-avx2-asm_64.S
@@ -561,7 +561,7 @@
 	transpose_4x4(x0, x1, x2, x3, t0, t1, t2)
 
 .align 8
-__serpent_enc_blk16:
+SYM_FUNC_START_LOCAL(__serpent_enc_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: plaintext
@@ -612,10 +612,10 @@ __serpent_enc_blk16:
 	write_blocks(RA2, RB2, RC2, RD2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(__serpent_enc_blk16)
+SYM_FUNC_END(__serpent_enc_blk16)
 
 .align 8
-__serpent_dec_blk16:
+SYM_FUNC_START_LOCAL(__serpent_dec_blk16)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: ciphertext
@@ -666,7 +666,7 @@ __serpent_dec_blk16:
 	write_blocks(RC2, RD2, RB2, RE2, RK0, RK1, RK2);
 
 	ret;
-ENDPROC(__serpent_dec_blk16)
+SYM_FUNC_END(__serpent_dec_blk16)
 
 ENTRY(serpent_ecb_enc_16way)
 	/* input:
diff --git a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
index 698b8f2a56e28..588f0a2f63ab2 100644
--- a/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
+++ b/arch/x86/crypto/twofish-avx-x86_64-asm_64.S
@@ -234,7 +234,7 @@
 	vpxor		x3, wkey, x3;
 
 .align 8
-__twofish_enc_blk8:
+SYM_FUNC_START_LOCAL(__twofish_enc_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RA1, RB1, RC1, RD1, RA2, RB2, RC2, RD2: blocks
@@ -273,10 +273,10 @@ __twofish_enc_blk8:
 	outunpack_blocks(RC2, RD2, RA2, RB2, RK1, RX0, RY0, RK2);
 
 	ret;
-ENDPROC(__twofish_enc_blk8)
+SYM_FUNC_END(__twofish_enc_blk8)
 
 .align 8
-__twofish_dec_blk8:
+SYM_FUNC_START_LOCAL(__twofish_dec_blk8)
 	/* input:
 	 *	%rdi: ctx, CTX
 	 *	RC1, RD1, RA1, RB1, RC2, RD2, RA2, RB2: encrypted blocks
@@ -313,7 +313,7 @@ __twofish_dec_blk8:
 	outunpack_blocks(RA2, RB2, RC2, RD2, RK1, RX0, RY0, RK2);
 
 	ret;
-ENDPROC(__twofish_dec_blk8)
+SYM_FUNC_END(__twofish_dec_blk8)
 
 ENTRY(twofish_ecb_enc_8way)
 	/* input:
-- 
2.43.0




