Return-Path: <linux-arch+bounces-11505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56AA970D2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A2917DBF9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A429346B;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUxmNTn8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D4293456;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335698; cv=none; b=dKCQZZ5Do/QhBabS0wuDXIELW4fsMPh6YKz20uTSuRC9NmsyvisJUgqldBpbWo5AtVfI6FA2tP01nzfvDAgw9o5sKx756r2vkoI2vbIeacwn+9auYOnyF5CLoWJXTvEeKBmJsfTKSFsJhwrhY7jvDJqcXY6wD79yMTk1cZ2JDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335698; c=relaxed/simple;
	bh=J8uCpavgYu/bq2A7Hf4ZA97H/cAunDf26vqUDG1MGLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEurk0Pps+bvJadHmBIRCEZxeSJ06NGJWTfmLUjzfJWQHxVX8Tm4AEAFFH0YApxCmH3rwtwXPa7tDqxKJH6tS3XPjVoOker6PFVgAqWAe1egHlj1MftMvSRO+o0NJcGU22NPe1QxaB4NA0isNEJZEQtErwmWLSOjPTOLq4jJHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUxmNTn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F74BC4CEF2;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335698;
	bh=J8uCpavgYu/bq2A7Hf4ZA97H/cAunDf26vqUDG1MGLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUxmNTn8AgQpRrLgdELItVrayTHCc34bWmQEOm6kFtC1wEoqFMj8V36G++QRB0KkK
	 XmZ9rXKUa/yKUmJ8RusFQ4qMCCGGp6w+R+tJ7snWoVB8h+U7MXfdJOkA/lDJXHFE6R
	 r24jn1S1Jfdtu1XFNQqfQm0mInUuuFCtbIOcO4+PMmXWwzcfyazTOJeflVZEYGTwzp
	 rij53w8zkeUtCZR+7YkI2JDpmAKiuk0649Xo/b3J4SvF22jID1OPUfoF+u7izfX19T
	 Gqzebht6PQ2/P3JVmHp1WYwXRCYv6a94up81N3knCmddtfFrR47TFT/AhDgOCw5C6A
	 he/0n9IQlEBEQ==
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
Subject: [PATCH v3 08/13] crypto: powerpc - move library functions to arch/powerpc/lib/crypto/
Date: Tue, 22 Apr 2025 08:27:11 -0700
Message-ID: <20250422152716.5923-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422152716.5923-1-ebiggers@kernel.org>
References: <20250422152716.5923-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Continue disentangling the crypto library functions from the generic
crypto infrastructure by moving the powerpc ChaCha and Poly1305 library
functions into a new directory arch/powerpc/lib/crypto/ that does not
depend on CRYPTO.  This mirrors the distinction between crypto/ and
lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/Kconfig                       | 14 --------------
 arch/powerpc/crypto/Makefile                      |  4 ----
 arch/powerpc/lib/Makefile                         |  2 ++
 arch/powerpc/lib/crypto/Kconfig                   | 15 +++++++++++++++
 arch/powerpc/lib/crypto/Makefile                  |  7 +++++++
 arch/powerpc/{ => lib}/crypto/chacha-p10-glue.c   |  0
 arch/powerpc/{ => lib}/crypto/chacha-p10le-8x.S   |  0
 arch/powerpc/{ => lib}/crypto/poly1305-p10-glue.c |  0
 arch/powerpc/{ => lib}/crypto/poly1305-p10le_64.S |  0
 lib/crypto/Kconfig                                |  3 +++
 10 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/lib/crypto/Kconfig
 create mode 100644 arch/powerpc/lib/crypto/Makefile
 rename arch/powerpc/{ => lib}/crypto/chacha-p10-glue.c (100%)
 rename arch/powerpc/{ => lib}/crypto/chacha-p10le-8x.S (100%)
 rename arch/powerpc/{ => lib}/crypto/poly1305-p10-glue.c (100%)
 rename arch/powerpc/{ => lib}/crypto/poly1305-p10le_64.S (100%)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 8bcc690134644..4bf7b01228e72 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -88,24 +88,10 @@ config CRYPTO_AES_GCM_P10
 	    - Power10 or later features
 
 	  Support for cryptographic acceleration instructions on Power10 or
 	  later CPU. This module supports stitched acceleration for AES/GCM.
 
-config CRYPTO_CHACHA20_P10
-	tristate
-	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
-config CRYPTO_POLY1305_P10
-	tristate
-	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	select CRYPTO_LIB_POLY1305_GENERIC
-	default CRYPTO_LIB_POLY1305_INTERNAL
-
 config CRYPTO_DEV_VMX
         bool "Support for VMX cryptographic acceleration instructions"
         depends on PPC64 && VSX
         help
           Support for VMX cryptographic acceleration instructions.
diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index 2f00b22b0823e..f13aec8a18335 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -9,23 +9,19 @@ obj-$(CONFIG_CRYPTO_AES_PPC_SPE) += aes-ppc-spe.o
 obj-$(CONFIG_CRYPTO_MD5_PPC) += md5-ppc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC) += sha1-powerpc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC_SPE) += sha1-ppc-spe.o
 obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
 obj-$(CONFIG_CRYPTO_AES_GCM_P10) += aes-gcm-p10-crypto.o
-obj-$(CONFIG_CRYPTO_CHACHA20_P10) += chacha-p10-crypto.o
-obj-$(CONFIG_CRYPTO_POLY1305_P10) += poly1305-p10-crypto.o
 obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 obj-$(CONFIG_CRYPTO_CURVE25519_PPC64) += curve25519-ppc64le.o
 
 aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
 md5-ppc-y := md5-asm.o md5-glue.o
 sha1-powerpc-y := sha1-powerpc-asm.o sha1.o
 sha1-ppc-spe-y := sha1-spe-asm.o sha1-spe-glue.o
 sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
 aes-gcm-p10-crypto-y := aes-gcm-p10-glue.o aes-gcm-p10.o ghashp10-ppc.o aesp10-ppc.o
-chacha-p10-crypto-y := chacha-p10-glue.o chacha-p10le-8x.o
-poly1305-p10-crypto-y := poly1305-p10-glue.o poly1305-p10le_64.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 curve25519-ppc64le-y := curve25519-ppc64le-core.o curve25519-ppc64le_asm.o
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 override flavour := linux-ppc64le
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index dd8a4b52a0ccb..1cd74673cbf74 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for ppc-specific library files..
 #
 
+obj-y += crypto/
+
 CFLAGS_code-patching.o += -fno-stack-protector
 CFLAGS_feature-fixups.o += -fno-stack-protector
 
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..3f52610e45eb4
--- /dev/null
+++ b/arch/powerpc/lib/crypto/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_CHACHA20_P10
+	tristate
+	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_POLY1305_P10
+	tristate
+	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	default CRYPTO_LIB_POLY1305_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_LIB_POLY1305_GENERIC
diff --git a/arch/powerpc/lib/crypto/Makefile b/arch/powerpc/lib/crypto/Makefile
new file mode 100644
index 0000000000000..5709ae14258a0
--- /dev/null
+++ b/arch/powerpc/lib/crypto/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_CHACHA20_P10) += chacha-p10-crypto.o
+chacha-p10-crypto-y := chacha-p10-glue.o chacha-p10le-8x.o
+
+obj-$(CONFIG_CRYPTO_POLY1305_P10) += poly1305-p10-crypto.o
+poly1305-p10-crypto-y := poly1305-p10-glue.o poly1305-p10le_64.o
diff --git a/arch/powerpc/crypto/chacha-p10-glue.c b/arch/powerpc/lib/crypto/chacha-p10-glue.c
similarity index 100%
rename from arch/powerpc/crypto/chacha-p10-glue.c
rename to arch/powerpc/lib/crypto/chacha-p10-glue.c
diff --git a/arch/powerpc/crypto/chacha-p10le-8x.S b/arch/powerpc/lib/crypto/chacha-p10le-8x.S
similarity index 100%
rename from arch/powerpc/crypto/chacha-p10le-8x.S
rename to arch/powerpc/lib/crypto/chacha-p10le-8x.S
diff --git a/arch/powerpc/crypto/poly1305-p10-glue.c b/arch/powerpc/lib/crypto/poly1305-p10-glue.c
similarity index 100%
rename from arch/powerpc/crypto/poly1305-p10-glue.c
rename to arch/powerpc/lib/crypto/poly1305-p10-glue.c
diff --git a/arch/powerpc/crypto/poly1305-p10le_64.S b/arch/powerpc/lib/crypto/poly1305-p10le_64.S
similarity index 100%
rename from arch/powerpc/crypto/poly1305-p10le_64.S
rename to arch/powerpc/lib/crypto/poly1305-p10le_64.S
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index c5c01bc3569d5..4b3e94ed84bb6 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -163,8 +163,11 @@ if ARM64
 source "arch/arm64/lib/crypto/Kconfig"
 endif
 if MIPS
 source "arch/mips/lib/crypto/Kconfig"
 endif
+if PPC
+source "arch/powerpc/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


