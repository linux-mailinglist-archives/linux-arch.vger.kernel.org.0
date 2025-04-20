Return-Path: <linux-arch+bounces-11472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CCDA94946
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E048E16B326
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C921C190;
	Sun, 20 Apr 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs10mI3Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024A6DCE1;
	Sun, 20 Apr 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177262; cv=none; b=ulh6c4JTmhPStnQfeZhPkdTxfrFRaY8dTDEhqhEHwGVE0AzsXsd5dqusP3/Fp2PLBl7FFG7aUMeH0OoRTplgZuhzXNdgquF7nazg/m8Ov9kSAEmNflNQN7AbsW32xJUM3NIxYektvzgnbr2uR568X7M/9nufcRxaWndgUXrWWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177262; c=relaxed/simple;
	bh=5jzPL09SfE4WESjYxnB172zEQMoguedQXb5qi2BK7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sm8xl73PkHjfVpR2DJMu3V47FfPoSpH5Z2BREMefHfFqSHs6e6aMgkwKZICUGVfp88Makh8gO8U6kI0oHG+C4HnqI8oUW/tJnXdrFqWP5sfjmN4bhTC12DbXKSgMJ7RZqQRNxj8QthtEPU6UFvPuUl2gloasnW/2vR5P3xu5KpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs10mI3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF7BC4CEEF;
	Sun, 20 Apr 2025 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177262;
	bh=5jzPL09SfE4WESjYxnB172zEQMoguedQXb5qi2BK7CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hs10mI3YY88QuOScEDzVdMCDo2RCAmYofMITZ5CSfexqKoLEbIvTbL0VsGgIN8tdE
	 xmIOrSUTHarguxP+j/aFTQpx/2YWD6/UjI2JX9KlQgiiMHUJhZxhjfj4In3FeqFG20
	 GST12IvgLp3Zan2ATjAwgTlPuqfwrF48bAAVnSE2mhn8oYe65sMe3rncthvmoJgSjU
	 dPQemT0noKUUfOr5ONzpWUjBsMGlVscVo6jSpXjilOSAvNHM8pX7a180YS2dLen1Cc
	 NMM2ZCNnxubQCBMVPd8FAJKsVQs9jNQIZn9TAZrjd0/Y7m6i9HU1BGfBvc/Ym8m87B
	 w0kNRUW3kQM9g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 11/13] crypto: x86 - move library functions to arch/x86/lib/crypto/
Date: Sun, 20 Apr 2025 12:26:07 -0700
Message-ID: <20250420192609.295075-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420192609.295075-1-ebiggers@kernel.org>
References: <20250420192609.295075-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Continue disentangling the crypto library functions from the generic
crypto infrastructure by moving the x86 BLAKE2s, ChaCha, and Poly1305
library functions into a new directory arch/x86/lib/crypto/ that does
not depend on CRYPTO.  This mirrors the distinction between crypto/ and
lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/Kconfig                       | 25 ------------------
 arch/x86/crypto/Makefile                      | 15 -----------
 arch/x86/lib/Makefile                         |  2 ++
 arch/x86/lib/crypto/.gitignore                |  2 ++
 arch/x86/lib/crypto/Kconfig                   | 26 +++++++++++++++++++
 arch/x86/lib/crypto/Makefile                  | 17 ++++++++++++
 arch/x86/{ => lib}/crypto/blake2s-core.S      |  0
 arch/x86/{ => lib}/crypto/blake2s-glue.c      |  0
 .../x86/{ => lib}/crypto/chacha-avx2-x86_64.S |  0
 .../{ => lib}/crypto/chacha-avx512vl-x86_64.S |  0
 .../{ => lib}/crypto/chacha-ssse3-x86_64.S    |  0
 arch/x86/{ => lib}/crypto/chacha_glue.c       |  0
 .../crypto/poly1305-x86_64-cryptogams.pl      |  0
 arch/x86/{ => lib}/crypto/poly1305_glue.c     |  0
 lib/crypto/Kconfig                            |  3 +++
 15 files changed, 50 insertions(+), 40 deletions(-)
 create mode 100644 arch/x86/lib/crypto/.gitignore
 create mode 100644 arch/x86/lib/crypto/Kconfig
 create mode 100644 arch/x86/lib/crypto/Makefile
 rename arch/x86/{ => lib}/crypto/blake2s-core.S (100%)
 rename arch/x86/{ => lib}/crypto/blake2s-glue.c (100%)
 rename arch/x86/{ => lib}/crypto/chacha-avx2-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha-avx512vl-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha-ssse3-x86_64.S (100%)
 rename arch/x86/{ => lib}/crypto/chacha_glue.c (100%)
 rename arch/x86/{ => lib}/crypto/poly1305-x86_64-cryptogams.pl (100%)
 rename arch/x86/{ => lib}/crypto/poly1305_glue.c (100%)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index b4df6cf37e0ea..9e941362e4cd5 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -333,17 +333,10 @@ config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	  - AVX512 (Advanced Vector Extensions)
 	  - GFNI (Galois Field New Instructions)
 
 	  Processes 64 blocks in parallel.
 
-config CRYPTO_CHACHA20_X86_64
-	tristate
-	depends on 64BIT
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE4.1)"
 	depends on 64BIT
 	select CRYPTO_AEAD
 	help
@@ -371,38 +364,20 @@ config CRYPTO_NHPOLY1305_AVX2
 	  NHPoly1305 hash function for Adiantum
 
 	  Architecture: x86_64 using:
 	  - AVX2 (Advanced Vector Extensions 2)
 
-config CRYPTO_BLAKE2S_X86
-	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
-	depends on 64BIT
-	select CRYPTO_LIB_BLAKE2S_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  Architecture: x86_64 using:
-	  - SSSE3 (Supplemental SSE3)
-	  - AVX-512 (Advanced Vector Extensions-512)
-
 config CRYPTO_POLYVAL_CLMUL_NI
 	tristate "Hash functions: POLYVAL (CLMUL-NI)"
 	depends on 64BIT
 	select CRYPTO_POLYVAL
 	help
 	  POLYVAL hash function for HCTR2
 
 	  Architecture: x86_64 using:
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
-config CRYPTO_POLY1305_X86_64
-	tristate
-	depends on 64BIT
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
-
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on 64BIT
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 2f22b381f2445..fad59a6c6c26f 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -40,13 +40,10 @@ obj-$(CONFIG_CRYPTO_CAST6_AVX_X86_64) += cast6-avx-x86_64.o
 cast6-avx-x86_64-y := cast6-avx-x86_64-asm_64.o cast6_avx_glue.o
 
 obj-$(CONFIG_CRYPTO_AEGIS128_AESNI_SSE2) += aegis128-aesni.o
 aegis128-aesni-y := aegis128-aesni-asm.o aegis128-aesni-glue.o
 
-obj-$(CONFIG_CRYPTO_CHACHA20_X86_64) += chacha-x86_64.o
-chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha-avx512vl-x86_64.o chacha_glue.o
-
 obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
 aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) += aes-ctr-avx-x86_64.o \
 			       aes-gcm-aesni-x86_64.o \
 			       aes-xts-avx-x86_64.o
@@ -61,23 +58,16 @@ obj-$(CONFIG_CRYPTO_SHA256_SSSE3) += sha256-ssse3.o
 sha256-ssse3-y := sha256-ssse3-asm.o sha256-avx-asm.o sha256-avx2-asm.o sha256_ni_asm.o sha256_ssse3_glue.o
 
 obj-$(CONFIG_CRYPTO_SHA512_SSSE3) += sha512-ssse3.o
 sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_ssse3_glue.o
 
-obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
-libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
-
 obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
 ghash-clmulni-intel-y := ghash-clmulni-intel_asm.o ghash-clmulni-intel_glue.o
 
 obj-$(CONFIG_CRYPTO_POLYVAL_CLMUL_NI) += polyval-clmulni.o
 polyval-clmulni-y := polyval-clmulni_asm.o polyval-clmulni_glue.o
 
-obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
-poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
-targets += poly1305-x86_64-cryptogams.S
-
 obj-$(CONFIG_CRYPTO_NHPOLY1305_SSE2) += nhpoly1305-sse2.o
 nhpoly1305-sse2-y := nh-sse2-x86_64.o nhpoly1305-sse2-glue.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305_AVX2) += nhpoly1305-avx2.o
 nhpoly1305-avx2-y := nh-avx2-x86_64.o nhpoly1305-avx2-glue.o
 
@@ -99,12 +89,7 @@ obj-$(CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64) += aria-aesni-avx2-x86_64.o
 aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
 
 obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
 aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
 
-quiet_cmd_perlasm = PERLASM $@
-      cmd_perlasm = $(PERL) $< > $@
-$(obj)/%.S: $(src)/%.pl FORCE
-	$(call if_changed,perlasm)
-
 # Disable GCOV in odd or sensitive code
 GCOV_PROFILE_curve25519-x86_64.o := n
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 1c50352eb49f9..4f0d57a354267 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for x86 specific library files.
 #
 
+obj-y += crypto/
+
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
 # KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
 KCSAN_SANITIZE_delay.o := n
diff --git a/arch/x86/lib/crypto/.gitignore b/arch/x86/lib/crypto/.gitignore
new file mode 100644
index 0000000000000..580c839bb1776
--- /dev/null
+++ b/arch/x86/lib/crypto/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+poly1305-x86_64-cryptogams.S
diff --git a/arch/x86/lib/crypto/Kconfig b/arch/x86/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..f83aa51dd9129
--- /dev/null
+++ b/arch/x86/lib/crypto/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_BLAKE2S_X86
+	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
+	depends on 64BIT
+	select CRYPTO_LIB_BLAKE2S_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX-512 (Advanced Vector Extensions-512)
+
+config CRYPTO_CHACHA20_X86_64
+	tristate
+	depends on 64BIT
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_POLY1305_X86_64
+	tristate
+	depends on 64BIT
+	default CRYPTO_LIB_POLY1305_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/x86/lib/crypto/Makefile b/arch/x86/lib/crypto/Makefile
new file mode 100644
index 0000000000000..c2ff8c5f1046e
--- /dev/null
+++ b/arch/x86/lib/crypto/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
+libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
+
+obj-$(CONFIG_CRYPTO_CHACHA20_X86_64) += chacha-x86_64.o
+chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha-avx512vl-x86_64.o chacha_glue.o
+
+obj-$(CONFIG_CRYPTO_POLY1305_X86_64) += poly1305-x86_64.o
+poly1305-x86_64-y := poly1305-x86_64-cryptogams.o poly1305_glue.o
+targets += poly1305-x86_64-cryptogams.S
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $< > $@
+
+$(obj)/%.S: $(src)/%.pl FORCE
+	$(call if_changed,perlasm)
diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/lib/crypto/blake2s-core.S
similarity index 100%
rename from arch/x86/crypto/blake2s-core.S
rename to arch/x86/lib/crypto/blake2s-core.S
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/lib/crypto/blake2s-glue.c
similarity index 100%
rename from arch/x86/crypto/blake2s-glue.c
rename to arch/x86/lib/crypto/blake2s-glue.c
diff --git a/arch/x86/crypto/chacha-avx2-x86_64.S b/arch/x86/lib/crypto/chacha-avx2-x86_64.S
similarity index 100%
rename from arch/x86/crypto/chacha-avx2-x86_64.S
rename to arch/x86/lib/crypto/chacha-avx2-x86_64.S
diff --git a/arch/x86/crypto/chacha-avx512vl-x86_64.S b/arch/x86/lib/crypto/chacha-avx512vl-x86_64.S
similarity index 100%
rename from arch/x86/crypto/chacha-avx512vl-x86_64.S
rename to arch/x86/lib/crypto/chacha-avx512vl-x86_64.S
diff --git a/arch/x86/crypto/chacha-ssse3-x86_64.S b/arch/x86/lib/crypto/chacha-ssse3-x86_64.S
similarity index 100%
rename from arch/x86/crypto/chacha-ssse3-x86_64.S
rename to arch/x86/lib/crypto/chacha-ssse3-x86_64.S
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/lib/crypto/chacha_glue.c
similarity index 100%
rename from arch/x86/crypto/chacha_glue.c
rename to arch/x86/lib/crypto/chacha_glue.c
diff --git a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl b/arch/x86/lib/crypto/poly1305-x86_64-cryptogams.pl
similarity index 100%
rename from arch/x86/crypto/poly1305-x86_64-cryptogams.pl
rename to arch/x86/lib/crypto/poly1305-x86_64-cryptogams.pl
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/lib/crypto/poly1305_glue.c
similarity index 100%
rename from arch/x86/crypto/poly1305_glue.c
rename to arch/x86/lib/crypto/poly1305_glue.c
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index db19a7acc2fbf..f321fe1a8681b 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -172,8 +172,11 @@ if RISCV
 source "arch/riscv/lib/crypto/Kconfig"
 endif
 if S390
 source "arch/s390/lib/crypto/Kconfig"
 endif
+if X86
+source "arch/x86/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


