Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26D4747D1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhLNQXu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhLNQXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:39 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1EC06179E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:22 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id b3-20020a2ebc03000000b0021ffe75b14cso5615158ljf.5
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iKsGybaA1AF0uo5Rm3x+Pkm5+t/N8eu2x4JfmdYC3rY=;
        b=ZWgDP6Ii5viesShK83UAmFO6XPY51RARPAakgm5T6FpZ01hl3Oe4OVcbnMvPn0qdtx
         4wBla4QT1qaA6b0WWxzVlHWic7a4fsIirqLKdcjvdv5mslYLl5P/j+ep247d6Ueuc4RF
         FIIEar8/t5IKCro5fWhjLVJZzH1F9kW6Kr1T3VlTW8wnpXVnFz0P6UQMy0miV/x7QTpg
         UpLO/alhew6nXNwXoQoy9M3PmOhAP9e7O54p5eK/98vQpoRJGp9Zjucxn7clG/YVELaG
         clHeqKMcMVgTy9rKN3dMLBGOfu7eqK1TUktZXdRMXCiRFbLp6DLuf/5mZbPBxPS587uv
         3GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iKsGybaA1AF0uo5Rm3x+Pkm5+t/N8eu2x4JfmdYC3rY=;
        b=IsILPrLjm9v8q2zPT8hVonAiEuSD81/8JZCZFIIwhssFZ5hQweSJQv+S3hxKx2foZ4
         glHJpAjzPNS0ade0kgnxNHQwBaZdTPd+M7F+HDSkYcL9OIWaItm3U7ihFBON5vKG8QBs
         aH/1eLJqu7G1mU2fB0Gr7SRFwxb3frVSau3jxo8qgVLvn3y41W1fGytJgFO790i3avUU
         STqYHMXid7KXtK6gDSpDQjuYHiUrQMx5mdWFek15yVE9u4zwIV3n3mIwT5KyvOuKnxXi
         e3bnDgLJqhQiq2LlFQWWUOp3pm6I4qkiCfby2MJ1zsSSCAmsnDNpHNbpa6y5yTZrGOjt
         IGLg==
X-Gm-Message-State: AOAM530rSekRg5YWUn5dJa/eeDq23zUUB1zz/RV8WZdL1HJWxWoY2pJ6
        m7S1WyxNGsHhe/bTHTAQR0uqIKWTCzU=
X-Google-Smtp-Source: ABdhPJyVHAmS4Hof8ncG2oeJsuYsA4417lJ7Ni1Ox0qNtMudhX4tGmPpZhFU3jYjvIOzKq7axCKUDKGhI3o=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a19:c3d6:: with SMTP id t205mr5766238lff.441.1639499000478;
 Tue, 14 Dec 2021 08:23:20 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:39 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-33-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 32/43] crypto: kmsan: disable accelerated configs under KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KMSAN is unable to understand when initialized values come from assembly.
Disable accelerated configs in KMSAN builds to prevent false positive
reports.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Idb2334bf3a1b68b31b399709baefaa763038cc50
---
 crypto/Kconfig      | 30 ++++++++++++++++++++++++++++++
 drivers/net/Kconfig |  1 +
 2 files changed, 31 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 285f82647d2b7..c6c71acf7d56e 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -290,6 +290,7 @@ config CRYPTO_CURVE25519
 config CRYPTO_CURVE25519_X86
 	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
@@ -338,11 +339,13 @@ config CRYPTO_AEGIS128
 config CRYPTO_AEGIS128_SIMD
 	bool "Support SIMD acceleration for AEGIS-128"
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
+	depends on !KMSAN # avoid false positives from assembly
 	default y
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
 	help
@@ -478,6 +481,7 @@ config CRYPTO_NHPOLY1305
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  SSE2 optimized implementation of the hash function used by the
@@ -486,6 +490,7 @@ config CRYPTO_NHPOLY1305_SSE2
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  AVX2 optimized implementation of the hash function used by the
@@ -599,6 +604,7 @@ config CRYPTO_CRC32C
 config CRYPTO_CRC32C_INTEL
 	tristate "CRC32c INTEL hardware acceleration"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  In Intel processor with SSE4.2 supported, the processor will
@@ -639,6 +645,7 @@ config CRYPTO_CRC32
 config CRYPTO_CRC32_PCLMUL
 	tristate "CRC32 PCLMULQDQ hardware acceleration"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	select CRC32
 	help
@@ -704,6 +711,7 @@ config CRYPTO_BLAKE2S
 config CRYPTO_BLAKE2S_X86
 	tristate "BLAKE2s digest algorithm (x86 accelerated version)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 
@@ -718,6 +726,7 @@ config CRYPTO_CRCT10DIF
 config CRYPTO_CRCT10DIF_PCLMUL
 	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
 	depends on X86 && 64BIT && CRC_T10DIF
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
@@ -765,6 +774,7 @@ config CRYPTO_POLY1305
 config CRYPTO_POLY1305_X86_64
 	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
@@ -853,6 +863,7 @@ config CRYPTO_SHA1
 config CRYPTO_SHA1_SSSE3
 	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
@@ -864,6 +875,7 @@ config CRYPTO_SHA1_SSSE3
 config CRYPTO_SHA256_SSSE3
 	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
@@ -876,6 +888,7 @@ config CRYPTO_SHA256_SSSE3
 config CRYPTO_SHA512_SSSE3
 	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
@@ -1034,6 +1047,7 @@ config CRYPTO_WP512
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "GHASH hash function (CLMUL-NI accelerated)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CRYPTD
 	help
 	  This is the x86_64 CLMUL-NI accelerated implementation of
@@ -1084,6 +1098,7 @@ config CRYPTO_AES_TI
 config CRYPTO_AES_NI_INTEL
 	tristate "AES cipher algorithms (AES-NI)"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
@@ -1208,6 +1223,7 @@ config CRYPTO_BLOWFISH_COMMON
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Blowfish cipher algorithm (x86_64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
@@ -1238,6 +1254,7 @@ config CRYPTO_CAMELLIA
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Camellia cipher algorithm (x86_64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
@@ -1254,6 +1271,7 @@ config CRYPTO_CAMELLIA_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
@@ -1272,6 +1290,7 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
@@ -1317,6 +1336,7 @@ config CRYPTO_CAST5
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
@@ -1340,6 +1360,7 @@ config CRYPTO_CAST6
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
@@ -1373,6 +1394,7 @@ config CRYPTO_DES_SPARC64
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Triple DES EDE cipher algorithm (x86-64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
@@ -1430,6 +1452,7 @@ config CRYPTO_CHACHA20
 config CRYPTO_CHACHA20_X86_64
 	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
@@ -1473,6 +1496,7 @@ config CRYPTO_SERPENT
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Serpent cipher algorithm (x86_64/SSE2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1492,6 +1516,7 @@ config CRYPTO_SERPENT_SSE2_X86_64
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Serpent cipher algorithm (i586/SSE2)"
 	depends on X86 && !64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1511,6 +1536,7 @@ config CRYPTO_SERPENT_SSE2_586
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Serpent cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1531,6 +1557,7 @@ config CRYPTO_SERPENT_AVX_X86_64
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Serpent cipher algorithm (x86_64/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
@@ -1672,6 +1699,7 @@ config CRYPTO_TWOFISH_586
 config CRYPTO_TWOFISH_X86_64
 	tristate "Twofish cipher algorithm (x86_64)"
 	depends on (X86 || UML_X86) && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
@@ -1689,6 +1717,7 @@ config CRYPTO_TWOFISH_X86_64
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
@@ -1709,6 +1738,7 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Twofish cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_TWOFISH_COMMON
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6cccc3dc00bcf..d09dabc607a69 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -76,6 +76,7 @@ config WIREGUARD
 	tristate "WireGuard secure network tunnel"
 	depends on NET && INET
 	depends on IPV6 || !IPV6
+	depends on !KMSAN # KMSAN doesn't support the crypto configs below
 	select NET_UDP_TUNNEL
 	select DST_CACHE
 	select CRYPTO
-- 
2.34.1.173.g76aa8bc2d0-goog

