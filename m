Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5BDCB86
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436834AbfJRQdV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:33:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439804AbfJRQat (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9B-0002yn-Uz; Fri, 18 Oct 2019 18:30:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2359B1C04D1;
        Fri, 18 Oct 2019 18:30:33 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:32 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/crypto: Annotate local functions
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-7-jslaby@suse.cz>
References: <20191011115108.12392-7-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623294.29376.6953414395239748733.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     74d8b90a889022e306b543ff2147a6941c99b354
Gitweb:        https://git.kernel.org/tip/74d8b90a889022e306b543ff2147a6941c99b354
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:07:15 +02:00

x86/asm/crypto: Annotate local functions

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
---
 arch/x86/crypto/aegis128-aesni-asm.S         |  8 +--
 arch/x86/crypto/aesni-intel_asm.S            | 49 +++++++------------
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  | 20 ++++----
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S | 20 ++++----
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  8 +--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  8 +--
 arch/x86/crypto/chacha-ssse3-x86_64.S        |  4 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  4 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  8 +--
 arch/x86/crypto/serpent-avx2-asm_64.S        |  8 +--
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  8 +--
 11 files changed, 68 insertions(+), 77 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 4434607..b7026fd 100644
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
index e40bdf0..e0a5fb4 100644
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
  * void aesni_dec (struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src)
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
index a14af6e..f4408ca 100644
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
index 4be4c7c..72ae3ed 100644
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
index dc55c33..ef86c6a 100644
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
index 4f0a7cd..b080a74 100644
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
index 2d86c7d..361d2bf 100644
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
index 5d53eff..e81da25 100644
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
index ddc51db..a098aa0 100644
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
index 37bc1d4..6149ba8 100644
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
index 698b8f2..588f0a2 100644
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
