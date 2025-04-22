Return-Path: <linux-arch+bounces-11503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38FA970C3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B19D7A9023
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD92918EC;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1LyDYSb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0C29114B;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335697; cv=none; b=plR74ho2VT/b2kqNo3E6OJALwX2C2H/I2JVeAv4fo7jC4oEoSJ/AWRfi/Vc9FXh6Y2hQOZA8KaPHrOXP4OJpG+5eOmemkimWSkAErK5jAG0cwk3U8Fhgci79oTFaUKlNZFqX8tJY3V9qakVr+4Ic5LmQaIdnCevT9+JUoxu7XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335697; c=relaxed/simple;
	bh=qwubLRmYWTY89E3AJnlutYUREOIU1w2leDnXcCjVCNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL8PI4ROhINViviRoJT8eGdipVuw6fUFh5Q8RCxcpsDFOXJQ6xJErM5z+xA/I+Zfaae0pibujOXVnamQCWhverNYiwiH4wR/O2yK/55hlGzdm7ZS08mfVWrVUD4njI9KFGZMvv+3ka3KkZe3+D7HSzcqgf8J+tCllaMb3uwrytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1LyDYSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F90DC4CEF2;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335697;
	bh=qwubLRmYWTY89E3AJnlutYUREOIU1w2leDnXcCjVCNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1LyDYSbr3xXzcTK7cUP6vBUaQU0bYdQdf8XFaS5jGfJvul+5CF6fBlnz/W0GEbp/
	 PJ9fcIScb+4yn5sV8LHDxWYhzCrstzFS/mtR8hm3+Zqx6Fy2tw1XaKsQgqfZypZvzO
	 GiQ1HON3RTHW1JwN6IaJpWmVCHFwiQLn5BFiJBJjlAhuxWFZlgAnTvHinn0MHsyfBU
	 q0OD2lo2r+ZIkYLsaKX0eGlY8YlI+PJszhxJOq0HUshnoVH6IF3jE9PdGdJVAVk+x4
	 YynfesOqur8aWXcpRQp1Mmz/tNma/AGsCb6TVRkDL7LMfgANrRDdd7FiL/fcWpU7dJ
	 U3O284Fy7Arrw==
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
Subject: [PATCH v3 06/13] crypto: arm64 - move library functions to arch/arm64/lib/crypto/
Date: Tue, 22 Apr 2025 08:27:09 -0700
Message-ID: <20250422152716.5923-7-ebiggers@kernel.org>
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
crypto infrastructure by moving the arm64 ChaCha and Poly1305 library
functions into a new directory arch/arm64/lib/crypto/ that does not
depend on CRYPTO.  This mirrors the distinction between crypto/ and
lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/Kconfig                      | 13 -------------
 arch/arm64/crypto/Makefile                     |  9 +--------
 arch/arm64/lib/Makefile                        |  3 +++
 arch/arm64/lib/crypto/.gitignore               |  2 ++
 arch/arm64/lib/crypto/Kconfig                  | 14 ++++++++++++++
 arch/arm64/lib/crypto/Makefile                 | 16 ++++++++++++++++
 arch/arm64/{ => lib}/crypto/chacha-neon-core.S |  0
 arch/arm64/{ => lib}/crypto/chacha-neon-glue.c |  0
 arch/arm64/{ => lib}/crypto/poly1305-armv8.pl  |  0
 arch/arm64/{ => lib}/crypto/poly1305-glue.c    |  0
 lib/crypto/Kconfig                             |  3 +++
 11 files changed, 39 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/lib/crypto/.gitignore
 create mode 100644 arch/arm64/lib/crypto/Kconfig
 create mode 100644 arch/arm64/lib/crypto/Makefile
 rename arch/arm64/{ => lib}/crypto/chacha-neon-core.S (100%)
 rename arch/arm64/{ => lib}/crypto/chacha-neon-glue.c (100%)
 rename arch/arm64/{ => lib}/crypto/poly1305-armv8.pl (100%)
 rename arch/arm64/{ => lib}/crypto/poly1305-glue.c (100%)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 704d0b7e1d137..55a7d87a67690 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -23,16 +23,10 @@ config CRYPTO_NHPOLY1305_NEON
 	  NHPoly1305 hash function (Adiantum)
 
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_POLY1305_NEON
-	tristate
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
-
 config CRYPTO_SHA1_ARM64_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
@@ -178,17 +172,10 @@ config CRYPTO_AES_ARM64_NEON_BLK
 	    and IEEE 1619)
 
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_CHACHA20_NEON
-	tristate
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 config CRYPTO_AES_ARM64_BS
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XCTR/XTS modes (bit-sliced NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index e7139c4768ce4..089ae3ddde810 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -60,17 +60,10 @@ obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
 sha256-arm64-y := sha256-glue.o sha256-core.o
 
 obj-$(CONFIG_CRYPTO_SHA512_ARM64) += sha512-arm64.o
 sha512-arm64-y := sha512-glue.o sha512-core.o
 
-obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
-chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
-
-obj-$(CONFIG_CRYPTO_POLY1305_NEON) += poly1305-neon.o
-poly1305-neon-y := poly1305-core.o poly1305-glue.o
-AFLAGS_poly1305-core.o += -Dpoly1305_init=poly1305_init_arm64
-
 obj-$(CONFIG_CRYPTO_NHPOLY1305_NEON) += nhpoly1305-neon.o
 nhpoly1305-neon-y := nh-neon-core.o nhpoly1305-neon-glue.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64) += aes-arm64.o
 aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
@@ -85,6 +78,6 @@ $(obj)/%-core.S: $(src)/%-armv8.pl
 	$(call cmd,perlasm)
 
 $(obj)/sha256-core.S: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 
-clean-files += poly1305-core.S sha256-core.S sha512-core.S
+clean-files += sha256-core.S sha512-core.S
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 4d49dff721a84..25be7825f28d8 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-y += crypto/
+
 lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_page.o				\
 		   clear_page.o csum.o insn.o memchr.o memcpy.o		\
 		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
 		   strnlen.o strchr.o strrchr.o tishift.o
diff --git a/arch/arm64/lib/crypto/.gitignore b/arch/arm64/lib/crypto/.gitignore
new file mode 100644
index 0000000000000..0d47d4f21c6de
--- /dev/null
+++ b/arch/arm64/lib/crypto/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+poly1305-core.S
diff --git a/arch/arm64/lib/crypto/Kconfig b/arch/arm64/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..169311547efe3
--- /dev/null
+++ b/arch/arm64/lib/crypto/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_CHACHA20_NEON
+	tristate
+	depends on KERNEL_MODE_NEON
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_POLY1305_NEON
+	tristate
+	depends on KERNEL_MODE_NEON
+	default CRYPTO_LIB_POLY1305_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/arm64/lib/crypto/Makefile b/arch/arm64/lib/crypto/Makefile
new file mode 100644
index 0000000000000..ac624c3effdaf
--- /dev/null
+++ b/arch/arm64/lib/crypto/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
+chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
+
+obj-$(CONFIG_CRYPTO_POLY1305_NEON) += poly1305-neon.o
+poly1305-neon-y := poly1305-core.o poly1305-glue.o
+AFLAGS_poly1305-core.o += -Dpoly1305_init=poly1305_init_arm64
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $(<) void $(@)
+
+$(obj)/%-core.S: $(src)/%-armv8.pl
+	$(call cmd,perlasm)
+
+clean-files += poly1305-core.S
diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/lib/crypto/chacha-neon-core.S
similarity index 100%
rename from arch/arm64/crypto/chacha-neon-core.S
rename to arch/arm64/lib/crypto/chacha-neon-core.S
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/lib/crypto/chacha-neon-glue.c
similarity index 100%
rename from arch/arm64/crypto/chacha-neon-glue.c
rename to arch/arm64/lib/crypto/chacha-neon-glue.c
diff --git a/arch/arm64/crypto/poly1305-armv8.pl b/arch/arm64/lib/crypto/poly1305-armv8.pl
similarity index 100%
rename from arch/arm64/crypto/poly1305-armv8.pl
rename to arch/arm64/lib/crypto/poly1305-armv8.pl
diff --git a/arch/arm64/crypto/poly1305-glue.c b/arch/arm64/lib/crypto/poly1305-glue.c
similarity index 100%
rename from arch/arm64/crypto/poly1305-glue.c
rename to arch/arm64/lib/crypto/poly1305-glue.c
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 59135009e4f02..7395234d654b7 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -157,8 +157,11 @@ config CRYPTO_LIB_SM3
 
 if !KMSAN # avoid false positives from assembly
 if ARM
 source "arch/arm/lib/crypto/Kconfig"
 endif
+if ARM64
+source "arch/arm64/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


