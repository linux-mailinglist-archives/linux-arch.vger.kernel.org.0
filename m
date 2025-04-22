Return-Path: <linux-arch+bounces-11504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C238BA970CF
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07803177473
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5CE292934;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCNc0DKF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09450292917;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335698; cv=none; b=D4EFSQfNz9fJ+31x4z+SU6nsnDI9JPsH2T3U19EkBDirnEsIrtYgKb9JyxZBUwAGSiwes0sN6APQyZpbJH4Z//QLdOj5A3bUmZat4v2cyg/nmdLyQDqU6klO1Bro1hif/1ql7rTpibisrCLGlBrbvVFkTTLZPDOpWg6pBV3krPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335698; c=relaxed/simple;
	bh=qN/B6X2mvQN94BK3RyJeOZTVFWohKhnnWgVazqat/cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVsjR87/20TDp0s07Ff2VSrraq19DF5FMBEHpkuKhUKrOOOOS0zPghEqUvU8KrvqduLwJtOm6zDrRUB+pMUoSAUXocIXw4jb7IEUC2gO1m0R+/nobuIy+3QVoRICRh25y5s/zy6oz4hlSyuYgne/v/7vY/rLGIr7FdsoWqtx3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCNc0DKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901F7C4CEF0;
	Tue, 22 Apr 2025 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335697;
	bh=qN/B6X2mvQN94BK3RyJeOZTVFWohKhnnWgVazqat/cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCNc0DKFbLWtkplqTtT13CfwTQE6PaHVBBB82/X3fpAVVgtphrM7DaoQyH455ZtOA
	 3od7qCZHN+hjsgHwHoLLaoYUvUy0n4ZLD8MXqabiEQnfE8b0eEYnokQm4XP7Z6lAec
	 EXcafR4+DRXVWUUo+U3YX0MI9revROjD3N+FINWhLx2ySRUQS+CtMP5XWtT7z1Bse+
	 sWKjSYAtxfBtHbgvbh8/qo8Ii1gZwC22fBFUmufECRvIgkgizSl0vTv5e3ZptSKsYc
	 BMjVjUSfg43cgoox7tDqaWuq1v9tK+qmeq9iIGiYy9qynq949O7WRuHB2Su5l2kxzE
	 OsTl37h8/3eAg==
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
Subject: [PATCH v3 07/13] crypto: mips - move library functions to arch/mips/lib/crypto/
Date: Tue, 22 Apr 2025 08:27:10 -0700
Message-ID: <20250422152716.5923-8-ebiggers@kernel.org>
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
crypto infrastructure by moving the mips ChaCha and Poly1305 library
functions into a new directory arch/mips/lib/crypto/ that does not
depend on CRYPTO.  This mirrors the distinction between crypto/ and
lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/mips/crypto/Kconfig                    | 11 -----------
 arch/mips/crypto/Makefile                   | 17 -----------------
 arch/mips/lib/Makefile                      |  2 ++
 arch/mips/lib/crypto/.gitignore             |  2 ++
 arch/mips/lib/crypto/Kconfig                | 12 ++++++++++++
 arch/mips/lib/crypto/Makefile               | 19 +++++++++++++++++++
 arch/mips/{ => lib}/crypto/chacha-core.S    |  0
 arch/mips/{ => lib}/crypto/chacha-glue.c    |  0
 arch/mips/{ => lib}/crypto/poly1305-glue.c  |  0
 arch/mips/{ => lib}/crypto/poly1305-mips.pl |  0
 lib/crypto/Kconfig                          |  3 +++
 11 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 arch/mips/lib/crypto/.gitignore
 create mode 100644 arch/mips/lib/crypto/Kconfig
 create mode 100644 arch/mips/lib/crypto/Makefile
 rename arch/mips/{ => lib}/crypto/chacha-core.S (100%)
 rename arch/mips/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/mips/{ => lib}/crypto/poly1305-glue.c (100%)
 rename arch/mips/{ => lib}/crypto/poly1305-mips.pl (100%)

diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 8283664a1f24b..9db1fd6d9f0e0 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 menu "Accelerated Cryptographic Algorithms for CPU (mips)"
 
-config CRYPTO_POLY1305_MIPS
-	tristate
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
-
 config CRYPTO_MD5_OCTEON
 	tristate "Digests: MD5 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_MD5
 	select CRYPTO_HASH
@@ -45,12 +40,6 @@ config CRYPTO_SHA512_OCTEON
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: mips OCTEON using crypto instructions, when available
 
-config CRYPTO_CHACHA_MIPS
-	tristate
-	depends on CPU_MIPS32_R2
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 endmenu
diff --git a/arch/mips/crypto/Makefile b/arch/mips/crypto/Makefile
index fddc882814123..5adb631a69c18 100644
--- a/arch/mips/crypto/Makefile
+++ b/arch/mips/crypto/Makefile
@@ -1,22 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for MIPS crypto files..
 #
 
-obj-$(CONFIG_CRYPTO_CHACHA_MIPS) += chacha-mips.o
-chacha-mips-y := chacha-core.o chacha-glue.o
-AFLAGS_chacha-core.o += -O2 # needed to fill branch delay slots
-
-obj-$(CONFIG_CRYPTO_POLY1305_MIPS) += poly1305-mips.o
-poly1305-mips-y := poly1305-core.o poly1305-glue.o
-
-perlasm-flavour-$(CONFIG_32BIT) := o32
-perlasm-flavour-$(CONFIG_64BIT) := 64
-
-quiet_cmd_perlasm = PERLASM $@
-      cmd_perlasm = $(PERL) $(<) $(perlasm-flavour-y) $(@)
-
-$(obj)/poly1305-core.S: $(src)/poly1305-mips.pl FORCE
-	$(call if_changed,perlasm)
-
-targets += poly1305-core.S
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9c024e6d5e54c..9d75845ef78e1 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for MIPS-specific library files..
 #
 
+obj-y	+= crypto/
+
 lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
 	   mips-atomic.o strncpy_user.o \
 	   strnlen_user.o uncached.o
 
 obj-y			+= iomap_copy.o
diff --git a/arch/mips/lib/crypto/.gitignore b/arch/mips/lib/crypto/.gitignore
new file mode 100644
index 0000000000000..0d47d4f21c6de
--- /dev/null
+++ b/arch/mips/lib/crypto/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+poly1305-core.S
diff --git a/arch/mips/lib/crypto/Kconfig b/arch/mips/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..5b82ba753c55c
--- /dev/null
+++ b/arch/mips/lib/crypto/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_CHACHA_MIPS
+	tristate
+	depends on CPU_MIPS32_R2
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+config CRYPTO_POLY1305_MIPS
+	tristate
+	default CRYPTO_LIB_POLY1305_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/mips/lib/crypto/Makefile b/arch/mips/lib/crypto/Makefile
new file mode 100644
index 0000000000000..804488c7adedc
--- /dev/null
+++ b/arch/mips/lib/crypto/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_CHACHA_MIPS) += chacha-mips.o
+chacha-mips-y := chacha-core.o chacha-glue.o
+AFLAGS_chacha-core.o += -O2 # needed to fill branch delay slots
+
+obj-$(CONFIG_CRYPTO_POLY1305_MIPS) += poly1305-mips.o
+poly1305-mips-y := poly1305-core.o poly1305-glue.o
+
+perlasm-flavour-$(CONFIG_32BIT) := o32
+perlasm-flavour-$(CONFIG_64BIT) := 64
+
+quiet_cmd_perlasm = PERLASM $@
+      cmd_perlasm = $(PERL) $(<) $(perlasm-flavour-y) $(@)
+
+$(obj)/poly1305-core.S: $(src)/poly1305-mips.pl FORCE
+	$(call if_changed,perlasm)
+
+targets += poly1305-core.S
diff --git a/arch/mips/crypto/chacha-core.S b/arch/mips/lib/crypto/chacha-core.S
similarity index 100%
rename from arch/mips/crypto/chacha-core.S
rename to arch/mips/lib/crypto/chacha-core.S
diff --git a/arch/mips/crypto/chacha-glue.c b/arch/mips/lib/crypto/chacha-glue.c
similarity index 100%
rename from arch/mips/crypto/chacha-glue.c
rename to arch/mips/lib/crypto/chacha-glue.c
diff --git a/arch/mips/crypto/poly1305-glue.c b/arch/mips/lib/crypto/poly1305-glue.c
similarity index 100%
rename from arch/mips/crypto/poly1305-glue.c
rename to arch/mips/lib/crypto/poly1305-glue.c
diff --git a/arch/mips/crypto/poly1305-mips.pl b/arch/mips/lib/crypto/poly1305-mips.pl
similarity index 100%
rename from arch/mips/crypto/poly1305-mips.pl
rename to arch/mips/lib/crypto/poly1305-mips.pl
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 7395234d654b7..c5c01bc3569d5 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -160,8 +160,11 @@ if ARM
 source "arch/arm/lib/crypto/Kconfig"
 endif
 if ARM64
 source "arch/arm64/lib/crypto/Kconfig"
 endif
+if MIPS
+source "arch/mips/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


