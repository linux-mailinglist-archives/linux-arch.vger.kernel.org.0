Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD87F5AD2C2
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiIEMbV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbiIEMaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:30:18 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8459D606A3
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:30 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id s26-20020adfa29a000000b00228b0cdb116so469014wra.23
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YUiFcVJy4Yf/nhkRGOhECdnAl5j2ey18UxYwbxsEwuI=;
        b=EuJefT6pFI1SfJ1MHzNVEtL/D1nKROem7gBcZZNWm+tmUjIlm6XlXML4r/Ulb6F8Oi
         7JZcAeqwIFv11ItGjGtVY+2vAoI145sAHWAJ2eCCgc9gmOJQ+rJxoOxi4IxQuKOqo9Xs
         jwJqNPHrB7IP6p+X7A89Sq60etOBYFLCpzyG1ZEogPtR1XI1hN447p2zQBgEEyXxDXjB
         1ueq55cwIKpWhpvImTkpLZb0xUfSkeDqxz8hzbFPpqjbXx8+aAig55o5wiquAxAR3RQy
         vct2tlYLX55zgMwv7nfI7KoeAFF3ZoNEKvex9CtBI8yLfc403GWeouQugJijjiHsxxof
         X/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YUiFcVJy4Yf/nhkRGOhECdnAl5j2ey18UxYwbxsEwuI=;
        b=0qfTCKAwsV0PFr2XAXn40+O9vq5E5tD+v7+Flx10oD8EUZQs4LeW8DO4I3D8d8AyU7
         IHX8lJYTEPpDPjAPlah4Vqr15K+4xQfA41+91C6rkkToXXPqUYQAjb6t/6ZaSVisWe+n
         7W8qpLU5HBKdPmm53Rh+Eajdt4vYrkqRmHnxuzVU83Uplj9h27+GR0xpHQCv+/2xq0/d
         2UuAr6jEYc5CJvTuzhdW9+94cFvPd/lhiBhZb0NLTAFx5eCoTzzs7kOq/3+Wz6GVGSgD
         y8mprbfnWTN7PJzDOXCTdBVN1LX7Ww5TPgKVnjWB4yOTjSQLXzDvkH5d5X8LJ5pUlR8b
         dNmw==
X-Gm-Message-State: ACgBeo0UgIOj2Rs7/CdvA46OO8BtwlJyxC1Jy8q43NJbJkkcGShvNggx
        4qM1jaMFxpu4x/bGxifJ6hqTUNDr8B0=
X-Google-Smtp-Source: AA6agR5XcljDqREXz5yOy07HcvY+X3l1ismgSiUmdI4a6SdYPcZywBoA3OLSshLNFBaU4Mi1hXiZhhBtJnA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a05:6000:713:b0:226:ea6c:2d7d with SMTP id
 bs19-20020a056000071300b00226ea6c2d7dmr14917835wrb.293.1662380772234; Mon, 05
 Sep 2022 05:26:12 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:35 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-28-glider@google.com>
Subject: [PATCH v6 27/44] crypto: kmsan: disable accelerated configs under KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index bb427a835e44a..182fb817ebb52 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -319,6 +319,7 @@ config CRYPTO_CURVE25519
 config CRYPTO_CURVE25519_X86
 	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
@@ -367,11 +368,13 @@ config CRYPTO_AEGIS128
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
@@ -517,6 +520,7 @@ config CRYPTO_NHPOLY1305
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  SSE2 optimized implementation of the hash function used by the
@@ -525,6 +529,7 @@ config CRYPTO_NHPOLY1305_SSE2
 config CRYPTO_NHPOLY1305_AVX2
 	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_NHPOLY1305
 	help
 	  AVX2 optimized implementation of the hash function used by the
@@ -649,6 +654,7 @@ config CRYPTO_CRC32C
 config CRYPTO_CRC32C_INTEL
 	tristate "CRC32c INTEL hardware acceleration"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  In Intel processor with SSE4.2 supported, the processor will
@@ -689,6 +695,7 @@ config CRYPTO_CRC32
 config CRYPTO_CRC32_PCLMUL
 	tristate "CRC32 PCLMULQDQ hardware acceleration"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	select CRC32
 	help
@@ -748,6 +755,7 @@ config CRYPTO_BLAKE2B
 config CRYPTO_BLAKE2S_X86
 	bool "BLAKE2s digest algorithm (x86 accelerated version)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 
@@ -762,6 +770,7 @@ config CRYPTO_CRCT10DIF
 config CRYPTO_CRCT10DIF_PCLMUL
 	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
 	depends on X86 && 64BIT && CRC_T10DIF
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_HASH
 	help
 	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
@@ -831,6 +840,7 @@ config CRYPTO_POLY1305
 config CRYPTO_POLY1305_X86_64
 	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
@@ -920,6 +930,7 @@ config CRYPTO_SHA1
 config CRYPTO_SHA1_SSSE3
 	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
@@ -931,6 +942,7 @@ config CRYPTO_SHA1_SSSE3
 config CRYPTO_SHA256_SSSE3
 	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
@@ -943,6 +955,7 @@ config CRYPTO_SHA256_SSSE3
 config CRYPTO_SHA512_SSSE3
 	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
@@ -1168,6 +1181,7 @@ config CRYPTO_WP512
 config CRYPTO_GHASH_CLMUL_NI_INTEL
 	tristate "GHASH hash function (CLMUL-NI accelerated)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CRYPTD
 	help
 	  This is the x86_64 CLMUL-NI accelerated implementation of
@@ -1228,6 +1242,7 @@ config CRYPTO_AES_TI
 config CRYPTO_AES_NI_INTEL
 	tristate "AES cipher algorithms (AES-NI)"
 	depends on X86
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
@@ -1369,6 +1384,7 @@ config CRYPTO_BLOWFISH_COMMON
 config CRYPTO_BLOWFISH_X86_64
 	tristate "Blowfish cipher algorithm (x86_64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
@@ -1399,6 +1415,7 @@ config CRYPTO_CAMELLIA
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Camellia cipher algorithm (x86_64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
@@ -1415,6 +1432,7 @@ config CRYPTO_CAMELLIA_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
@@ -1433,6 +1451,7 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
@@ -1478,6 +1497,7 @@ config CRYPTO_CAST5
 config CRYPTO_CAST5_AVX_X86_64
 	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
 	select CRYPTO_CAST_COMMON
@@ -1501,6 +1521,7 @@ config CRYPTO_CAST6
 config CRYPTO_CAST6_AVX_X86_64
 	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
 	select CRYPTO_CAST_COMMON
@@ -1534,6 +1555,7 @@ config CRYPTO_DES_SPARC64
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Triple DES EDE cipher algorithm (x86-64)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
@@ -1604,6 +1626,7 @@ config CRYPTO_CHACHA20
 config CRYPTO_CHACHA20_X86_64
 	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
@@ -1674,6 +1697,7 @@ config CRYPTO_SERPENT
 config CRYPTO_SERPENT_SSE2_X86_64
 	tristate "Serpent cipher algorithm (x86_64/SSE2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1693,6 +1717,7 @@ config CRYPTO_SERPENT_SSE2_X86_64
 config CRYPTO_SERPENT_SSE2_586
 	tristate "Serpent cipher algorithm (i586/SSE2)"
 	depends on X86 && !64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1712,6 +1737,7 @@ config CRYPTO_SERPENT_SSE2_586
 config CRYPTO_SERPENT_AVX_X86_64
 	tristate "Serpent cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
@@ -1732,6 +1758,7 @@ config CRYPTO_SERPENT_AVX_X86_64
 config CRYPTO_SERPENT_AVX2_X86_64
 	tristate "Serpent cipher algorithm (x86_64/AVX2)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
@@ -1876,6 +1903,7 @@ config CRYPTO_TWOFISH_586
 config CRYPTO_TWOFISH_X86_64
 	tristate "Twofish cipher algorithm (x86_64)"
 	depends on (X86 || UML_X86) && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
@@ -1893,6 +1921,7 @@ config CRYPTO_TWOFISH_X86_64
 config CRYPTO_TWOFISH_X86_64_3WAY
 	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
@@ -1913,6 +1942,7 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 config CRYPTO_TWOFISH_AVX_X86_64
 	tristate "Twofish cipher algorithm (x86_64/AVX)"
 	depends on X86 && 64BIT
+	depends on !KMSAN # avoid false positives from assembly
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_TWOFISH_COMMON
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 94c889802566a..2aaf02bfe6f7e 100644
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
2.37.2.789.g6183377224-goog

