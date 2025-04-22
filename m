Return-Path: <linux-arch+bounces-11502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAF8A970E5
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D621893736
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC6290BD6;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL6mg/Zt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B2290BCC;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335697; cv=none; b=abtF5KEcJoU5c7KzF/Oh9+lBbz3FeO85cbULUiS+NZAj1qWci74mtmcfYwYVq6YiwNnqW0ejSt9iC4+eSV0kW+66XeqsCzXe22JtTm82MHfJQfoz6MIcLRuIYWnKxanJo2PK3CdQYRjCYA0ulUavN1lCEO5QlBB2gPtIpQ/fEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335697; c=relaxed/simple;
	bh=GjEjmwkiG40mBHNNY0hpzCSCY6h3KNGoqBSt3c2rFfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgJZHX6POLia2Y943A7va4jrceMsqIGoTcLP1Bt5UOS0vAf+Bw0MpFGlVG2yRDNNbUyWUfh4FpSgWLiEy2RNIjJEmyJn+r6wKF+eCEEs/gvnksE4w4RkP2xnRd3PKLNBU2A/Tqm7Wn1SouBSIep3F2CX1BFFh4hFujBeZHID74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL6mg/Zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E431C4CEF1;
	Tue, 22 Apr 2025 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335697;
	bh=GjEjmwkiG40mBHNNY0hpzCSCY6h3KNGoqBSt3c2rFfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TL6mg/ZtSZDHi1heG+3zuy63dj9dKawGkDD8bzeicE5MrTZUS9Pd8eZqYL6d16oTs
	 9jryUk406G/+oIa32v8sNWwe0ZGdD4IFD+C7asmF0lMhcV53mOHf2Hj3DZ710BCDQS
	 l8VBbD19T9V8eYW+VfGc3EqqAB1fhV9F3hdcdAWbX/UO2Fglba/2lN6xpzm3ZY2kAm
	 ZCX/m7txQlh4yfz7Dbg0OJaxvNF6iJ25xzc5Trg+lUe47EcpSOuVBLlehC6BqmY1Hp
	 mrXcvhsTVQ9amJxnZjui+0emD4MYMwIaD2zpEN4IOpPNfpUY3nbpPo2lk+ugPRoLg8
	 f/AsWM/F3qkUQ==
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
Subject: [PATCH v3 05/13] crypto: arm - move library functions to arch/arm/lib/crypto/
Date: Tue, 22 Apr 2025 08:27:08 -0700
Message-ID: <20250422152716.5923-6-ebiggers@kernel.org>
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
crypto infrastructure by moving the arm BLAKE2s, ChaCha, and Poly1305
library functions into a new directory arch/arm/lib/crypto/ that does
not depend on CRYPTO.  This mirrors the distinction between crypto/ and
lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS                                   |  1 +
 arch/arm/crypto/Kconfig                       | 23 ----------------
 arch/arm/crypto/Makefile                      | 14 +---------
 arch/arm/lib/Makefile                         |  2 ++
 arch/arm/lib/crypto/.gitignore                |  2 ++
 arch/arm/lib/crypto/Kconfig                   | 24 +++++++++++++++++
 arch/arm/lib/crypto/Makefile                  | 26 +++++++++++++++++++
 arch/arm/{ => lib}/crypto/blake2s-core.S      |  0
 arch/arm/{ => lib}/crypto/blake2s-glue.c      |  0
 arch/arm/{ => lib}/crypto/chacha-glue.c       |  0
 arch/arm/{ => lib}/crypto/chacha-neon-core.S  |  0
 .../arm/{ => lib}/crypto/chacha-scalar-core.S |  0
 arch/arm/{ => lib}/crypto/poly1305-armv4.pl   |  0
 arch/arm/{ => lib}/crypto/poly1305-glue.c     |  0
 lib/crypto/Kconfig                            |  6 +++++
 15 files changed, 62 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/lib/crypto/.gitignore
 create mode 100644 arch/arm/lib/crypto/Kconfig
 create mode 100644 arch/arm/lib/crypto/Makefile
 rename arch/arm/{ => lib}/crypto/blake2s-core.S (100%)
 rename arch/arm/{ => lib}/crypto/blake2s-glue.c (100%)
 rename arch/arm/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/arm/{ => lib}/crypto/chacha-neon-core.S (100%)
 rename arch/arm/{ => lib}/crypto/chacha-scalar-core.S (100%)
 rename arch/arm/{ => lib}/crypto/poly1305-armv4.pl (100%)
 rename arch/arm/{ => lib}/crypto/poly1305-glue.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2604c13f11b4..d0d1968e323aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6286,10 +6286,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
 F:	Documentation/crypto/
 F:	Documentation/devicetree/bindings/crypto/
 F:	arch/*/crypto/
+F:	arch/*/lib/crypto/
 F:	crypto/
 F:	drivers/crypto/
 F:	include/crypto/
 F:	include/linux/crypto*
 F:	lib/crypto/
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 3530e7c80793a..1f889d6bab77d 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -44,28 +44,10 @@ config CRYPTO_NHPOLY1305_NEON
 	  NHPoly1305 hash function (Adiantum)
 
 	  Architecture: arm using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_POLY1305_ARM
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
-
-config CRYPTO_BLAKE2S_ARM
-	bool "Hash functions: BLAKE2s"
-	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  Architecture: arm
-
-	  This is faster than the generic implementations of BLAKE2s and
-	  BLAKE2b, but slower than the NEON implementation of BLAKE2b.
-	  There is no NEON implementation of BLAKE2s, since NEON doesn't
-	  really help with it.
-
 config CRYPTO_BLAKE2B_NEON
 	tristate "Hash functions: BLAKE2b (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLAKE2B
 	help
@@ -204,12 +186,7 @@ config CRYPTO_AES_ARM_CE
 	     and IEEE 1619)
 
 	  Architecture: arm using:
 	  - ARMv8 Crypto Extensions
 
-config CRYPTO_CHACHA20_NEON
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 endmenu
 
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 3d0e23ff9e746..ecabe6603e080 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -7,14 +7,11 @@ obj-$(CONFIG_CRYPTO_AES_ARM) += aes-arm.o
 obj-$(CONFIG_CRYPTO_AES_ARM_BS) += aes-arm-bs.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM) += sha1-arm.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_NEON) += sha1-arm-neon.o
 obj-$(CONFIG_CRYPTO_SHA256_ARM) += sha256-arm.o
 obj-$(CONFIG_CRYPTO_SHA512_ARM) += sha512-arm.o
-obj-$(CONFIG_CRYPTO_BLAKE2S_ARM) += libblake2s-arm.o
 obj-$(CONFIG_CRYPTO_BLAKE2B_NEON) += blake2b-neon.o
-obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
-obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
 obj-$(CONFIG_CRYPTO_CURVE25519_NEON) += curve25519-neon.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM_CE) += aes-arm-ce.o
 obj-$(CONFIG_CRYPTO_SHA1_ARM_CE) += sha1-arm-ce.o
@@ -27,34 +24,25 @@ sha1-arm-y	:= sha1-armv4-large.o sha1_glue.o
 sha1-arm-neon-y	:= sha1-armv7-neon.o sha1_neon_glue.o
 sha256-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha256_neon_glue.o
 sha256-arm-y	:= sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
 sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
 sha512-arm-y	:= sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
-libblake2s-arm-y:= blake2s-core.o blake2s-glue.o
 blake2b-neon-y  := blake2b-neon-core.o blake2b-neon-glue.o
 sha1-arm-ce-y	:= sha1-ce-core.o sha1-ce-glue.o
 sha2-arm-ce-y	:= sha2-ce-core.o sha2-ce-glue.o
 aes-arm-ce-y	:= aes-ce-core.o aes-ce-glue.o
 ghash-arm-ce-y	:= ghash-ce-core.o ghash-ce-glue.o
-chacha-neon-y := chacha-scalar-core.o chacha-glue.o
-chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
-poly1305-arm-y := poly1305-core.o poly1305-glue.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 curve25519-neon-y := curve25519-core.o curve25519-glue.o
 
 quiet_cmd_perl = PERL    $@
       cmd_perl = $(PERL) $(<) > $(@)
 
 $(obj)/%-core.S: $(src)/%-armv4.pl
 	$(call cmd,perl)
 
-clean-files += poly1305-core.S sha256-core.S sha512-core.S
+clean-files += sha256-core.S sha512-core.S
 
 aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
 
 AFLAGS_sha256-core.o += $(aflags-thumb2-y)
 AFLAGS_sha512-core.o += $(aflags-thumb2-y)
-
-# massage the perlasm code a bit so we only get the NEON routine if we need it
-poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
-poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
-AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 007874320937d..39ffabd3cf2a2 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -3,10 +3,12 @@
 # linux/arch/arm/lib/Makefile
 #
 # Copyright (C) 1995-2000 Russell King
 #
 
+obj-y += crypto/
+
 lib-y		:= changebit.o csumipv6.o csumpartial.o               \
 		   csumpartialcopy.o csumpartialcopyuser.o clearbit.o \
 		   delay.o delay-loop.o findbit.o memchr.o memcpy.o   \
 		   memmove.o memset.o setbit.o                        \
 		   strchr.o strrchr.o                                 \
diff --git a/arch/arm/lib/crypto/.gitignore b/arch/arm/lib/crypto/.gitignore
new file mode 100644
index 0000000000000..0d47d4f21c6de
--- /dev/null
+++ b/arch/arm/lib/crypto/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+poly1305-core.S
diff --git a/arch/arm/lib/crypto/Kconfig b/arch/arm/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..181f138d563b6
--- /dev/null
+++ b/arch/arm/lib/crypto/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_BLAKE2S_ARM
+	bool "Hash functions: BLAKE2s"
+	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: arm
+
+	  This is faster than the generic implementations of BLAKE2s and
+	  BLAKE2b, but slower than the NEON implementation of BLAKE2b.
+	  There is no NEON implementation of BLAKE2s, since NEON doesn't
+	  really help with it.
+
+config CRYPTO_CHACHA20_NEON
+	tristate
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_POLY1305_ARM
+	tristate
+	default CRYPTO_LIB_POLY1305_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/arm/lib/crypto/Makefile b/arch/arm/lib/crypto/Makefile
new file mode 100644
index 0000000000000..4c042a4c77ed6
--- /dev/null
+++ b/arch/arm/lib/crypto/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_BLAKE2S_ARM) += libblake2s-arm.o
+libblake2s-arm-y := blake2s-core.o blake2s-glue.o
+
+obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
+chacha-neon-y := chacha-scalar-core.o chacha-glue.o
+chacha-neon-$(CONFIG_KERNEL_MODE_NEON) += chacha-neon-core.o
+
+obj-$(CONFIG_CRYPTO_POLY1305_ARM) += poly1305-arm.o
+poly1305-arm-y := poly1305-core.o poly1305-glue.o
+
+quiet_cmd_perl = PERL    $@
+      cmd_perl = $(PERL) $(<) > $(@)
+
+$(obj)/%-core.S: $(src)/%-armv4.pl
+	$(call cmd,perl)
+
+clean-files += poly1305-core.S
+
+aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
+
+# massage the perlasm code a bit so we only get the NEON routine if we need it
+poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
+poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
+AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)
diff --git a/arch/arm/crypto/blake2s-core.S b/arch/arm/lib/crypto/blake2s-core.S
similarity index 100%
rename from arch/arm/crypto/blake2s-core.S
rename to arch/arm/lib/crypto/blake2s-core.S
diff --git a/arch/arm/crypto/blake2s-glue.c b/arch/arm/lib/crypto/blake2s-glue.c
similarity index 100%
rename from arch/arm/crypto/blake2s-glue.c
rename to arch/arm/lib/crypto/blake2s-glue.c
diff --git a/arch/arm/crypto/chacha-glue.c b/arch/arm/lib/crypto/chacha-glue.c
similarity index 100%
rename from arch/arm/crypto/chacha-glue.c
rename to arch/arm/lib/crypto/chacha-glue.c
diff --git a/arch/arm/crypto/chacha-neon-core.S b/arch/arm/lib/crypto/chacha-neon-core.S
similarity index 100%
rename from arch/arm/crypto/chacha-neon-core.S
rename to arch/arm/lib/crypto/chacha-neon-core.S
diff --git a/arch/arm/crypto/chacha-scalar-core.S b/arch/arm/lib/crypto/chacha-scalar-core.S
similarity index 100%
rename from arch/arm/crypto/chacha-scalar-core.S
rename to arch/arm/lib/crypto/chacha-scalar-core.S
diff --git a/arch/arm/crypto/poly1305-armv4.pl b/arch/arm/lib/crypto/poly1305-armv4.pl
similarity index 100%
rename from arch/arm/crypto/poly1305-armv4.pl
rename to arch/arm/lib/crypto/poly1305-armv4.pl
diff --git a/arch/arm/crypto/poly1305-glue.c b/arch/arm/lib/crypto/poly1305-glue.c
similarity index 100%
rename from arch/arm/crypto/poly1305-glue.c
rename to arch/arm/lib/crypto/poly1305-glue.c
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 2c6ab80e0cdc4..59135009e4f02 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -153,6 +153,12 @@ config CRYPTO_LIB_SHA256
 	tristate
 
 config CRYPTO_LIB_SM3
 	tristate
 
+if !KMSAN # avoid false positives from assembly
+if ARM
+source "arch/arm/lib/crypto/Kconfig"
+endif
+endif
+
 endmenu
-- 
2.49.0


