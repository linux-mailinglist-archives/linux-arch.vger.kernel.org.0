Return-Path: <linux-arch+bounces-11469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1653A9493E
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CB03AF52F
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210C21A94F;
	Sun, 20 Apr 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8RoY7Xk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF29219A9B;
	Sun, 20 Apr 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177261; cv=none; b=i3VGgcJiKLLyyaIGQt9KVtMq6UtHUcBaUwVYbPDpwscEGufjJHIJWTaHcY3ZCCZsTUFyjMn1DEG1IpbFGVdsz/jGHecT/7pgN2KXrw2L8Kb8U+IN8s+u79b7g2oGj3gd9VIhvH09Lp/J+0l8vPpqss4m8tDvemhxRWvJqhTTkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177261; c=relaxed/simple;
	bh=J8uCpavgYu/bq2A7Hf4ZA97H/cAunDf26vqUDG1MGLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIoXLyDJKv2f+8hTNUjcgaTDAUe0hLRIY2y/yivXsXUxdO2P3RBhYtVvpU0BuVoVFGdsdu2/wcaZpk4ApKVJrqGSH6kzu0Bk+CmCpm2oXM/bldBNOc30m4sih+JPSx+gGY2tIeUKpc/8NBWZi9xz0b4t8pn0omY3LblBuyFkVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8RoY7Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80162C4CEE9;
	Sun, 20 Apr 2025 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177260;
	bh=J8uCpavgYu/bq2A7Hf4ZA97H/cAunDf26vqUDG1MGLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8RoY7Xk2+HzXh2P2QjIH6yktKf9tZx4Ejn9TAliuEFKa5F0exi9scB4GGLALnRu0
	 eQ/+oEJutbwcOIXF33IuZ7DJ+XYAw8Xd6M+D2NJWgfrdQLdwmH9iIuYieO5CDd7xso
	 SMDVKYgDEBMo8Q63lZmhCQyrSyPzgNvPQKMzSoh/DEdYdwjj3kiDpAGHSRZVu3Cc2k
	 XGRaxcvD5dUdB1pIBzYsWi91SjOEXakj39zXjJTHfCbO4T9B1U5kWm/HwfRrZuH8u9
	 dGB4IeL8LC60qso9q9iPRiDH91gggajuaDGTrq7yVzQCpLLteklDVj4RlAskIk9jng
	 Oo+4oz+SGLnVQ==
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
Subject: [PATCH v2 08/13] crypto: powerpc - move library functions to arch/powerpc/lib/crypto/
Date: Sun, 20 Apr 2025 12:26:04 -0700
Message-ID: <20250420192609.295075-9-ebiggers@kernel.org>
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


