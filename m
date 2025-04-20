Return-Path: <linux-arch+bounces-11474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A3A9494F
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63FA7A8B29
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2821D5A2;
	Sun, 20 Apr 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7diKfMK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19D21D3CD;
	Sun, 20 Apr 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177263; cv=none; b=HM1udxEioi5JeSwFNJCQ/aLERzAyBD/4f+E2a5fLyF2a6jbtXWXsltCjrswAuqX3FvnKE8g6n2lq6b0NDIxR1jkUthEAzMOGsuVa8DgScV8PkTys0zLr+NQ9wBJwFtmu4q8vQ9oWp2rB8Be9TKAXrdS+jEvJk7agD5iK2HmNCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177263; c=relaxed/simple;
	bh=l+8LTIVco+dbh9d8ET+f2v59CbKZfxOmGWJmTr+W3Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+/FkhoPiyBuzgrs75uhBHUViBaSAQPhZ2Niyb4Cd2S50XRrsgKzUwivst2W1uUhQ0R5b41ygQRu7M8jhZWliuqZmdw3rivf+iHUOOJN6B5dcvq2nHLtB9/Kk+ql0s1C6S1xOt+4GlIBxHRai/+sGKr/l5LXC+fXjn9f2FSEkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7diKfMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DBC4CEF1;
	Sun, 20 Apr 2025 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177262;
	bh=l+8LTIVco+dbh9d8ET+f2v59CbKZfxOmGWJmTr+W3Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7diKfMKGIqUI0dWG9OEthRgl4xcAHQPbzwEdXQkdDAw6iapoPkjDnIuTov4CMDbf
	 8Vwl2j6tHk2PMNcXfxndslqk9VHQe/lmTNOy2KUJKZgHQfcsIQkJdbbUc8Wgi35DRy
	 XIu40aBLPKz8UKcmvCVfnzMBEy+CgEYJfQDmu4TgOG2xmzOHMh7LMQG8uFCYL0ahnv
	 +dV1o6A58RMw2lO1o1iYi+RTHaqfzSISd9BzwRgOpGCneZcEI+ChZIoO+U+QFA3p/1
	 rerVCNXTtPw6jpiLaEVRabfe/lpWZsv8HOB8UoDj/aKhJbFm529B1bk01VVVE0xIlC
	 oNbRlfOqmegWA==
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
Subject: [PATCH v2 12/13] crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
Date: Sun, 20 Apr 2025 12:26:08 -0700
Message-ID: <20250420192609.295075-13-ebiggers@kernel.org>
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

Now that the architecture-optimized ChaCha kconfig symbols are visible
without CRYPTO, there is no need for CRYPTO_LIB_CHACHA to select CRYPTO.
So, remove that.  This makes the indirection through the
CRYPTO_LIB_CHACHA_INTERNAL symbol unnecessary, so get rid of that and
just use CRYPTO_LIB_CHACHA directly.  Finally, make the fallback to the
generic implementation use a default value instead of a select; this
makes it consistent with how the arch-optimized code gets enabled and
also with how CRYPTO_LIB_BLAKE2S_GENERIC gets enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/lib/crypto/Kconfig     |  2 +-
 arch/arm64/lib/crypto/Kconfig   |  2 +-
 arch/mips/lib/crypto/Kconfig    |  2 +-
 arch/powerpc/lib/crypto/Kconfig |  2 +-
 arch/riscv/lib/crypto/Kconfig   |  2 +-
 arch/s390/lib/crypto/Kconfig    |  2 +-
 arch/x86/lib/crypto/Kconfig     |  2 +-
 crypto/Kconfig                  |  2 +-
 lib/crypto/Kconfig              | 16 +++++-----------
 9 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/lib/crypto/Kconfig b/arch/arm/lib/crypto/Kconfig
index 181f138d563b6..5d10bd13fc8df 100644
--- a/arch/arm/lib/crypto/Kconfig
+++ b/arch/arm/lib/crypto/Kconfig
@@ -13,11 +13,11 @@ config CRYPTO_BLAKE2S_ARM
 	  There is no NEON implementation of BLAKE2s, since NEON doesn't
 	  really help with it.
 
 config CRYPTO_CHACHA20_NEON
 	tristate
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_ARM
 	tristate
 	default CRYPTO_LIB_POLY1305_INTERNAL
diff --git a/arch/arm64/lib/crypto/Kconfig b/arch/arm64/lib/crypto/Kconfig
index 169311547efe3..2a8ff7cfc08d3 100644
--- a/arch/arm64/lib/crypto/Kconfig
+++ b/arch/arm64/lib/crypto/Kconfig
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config CRYPTO_CHACHA20_NEON
 	tristate
 	depends on KERNEL_MODE_NEON
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_NEON
 	tristate
diff --git a/arch/mips/lib/crypto/Kconfig b/arch/mips/lib/crypto/Kconfig
index 5b82ba753c55c..454354e30d76c 100644
--- a/arch/mips/lib/crypto/Kconfig
+++ b/arch/mips/lib/crypto/Kconfig
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config CRYPTO_CHACHA_MIPS
 	tristate
 	depends on CPU_MIPS32_R2
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_MIPS
 	tristate
 	default CRYPTO_LIB_POLY1305_INTERNAL
diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
index 3f52610e45eb4..6627d28cd24e0 100644
--- a/arch/powerpc/lib/crypto/Kconfig
+++ b/arch/powerpc/lib/crypto/Kconfig
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config CRYPTO_CHACHA20_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_P10
 	tristate
diff --git a/arch/riscv/lib/crypto/Kconfig b/arch/riscv/lib/crypto/Kconfig
index 46ce2a7ac1f2c..bc7a43f33eb3a 100644
--- a/arch/riscv/lib/crypto/Kconfig
+++ b/arch/riscv/lib/crypto/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config CRYPTO_CHACHA_RISCV64
 	tristate
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
diff --git a/arch/s390/lib/crypto/Kconfig b/arch/s390/lib/crypto/Kconfig
index b79fd91af9fe1..069b355fe51aa 100644
--- a/arch/s390/lib/crypto/Kconfig
+++ b/arch/s390/lib/crypto/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config CRYPTO_CHACHA_S390
 	tristate
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
diff --git a/arch/x86/lib/crypto/Kconfig b/arch/x86/lib/crypto/Kconfig
index f83aa51dd9129..e44403d9677f5 100644
--- a/arch/x86/lib/crypto/Kconfig
+++ b/arch/x86/lib/crypto/Kconfig
@@ -13,11 +13,11 @@ config CRYPTO_BLAKE2S_X86
 	  - AVX-512 (Advanced Vector Extensions-512)
 
 config CRYPTO_CHACHA20_X86_64
 	tristate
 	depends on 64BIT
-	default CRYPTO_LIB_CHACHA_INTERNAL
+	default CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_X86_64
 	tristate
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9322e42e562de..832af6363951f 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -632,12 +632,12 @@ config CRYPTO_ARC4
 	  WEP, but it should not be for other purposes because of the
 	  weakness of the algorithm.
 
 config CRYPTO_CHACHA20
 	tristate "ChaCha"
+	select CRYPTO_LIB_CHACHA
 	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_LIB_CHACHA_INTERNAL
 	select CRYPTO_SKCIPHER
 	help
 	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
 
 	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index f321fe1a8681b..c6ab724c1dbd9 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -48,26 +48,20 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
 	  accelerated implementation of the ChaCha library interface,
 	  either builtin or as a module.
 
 config CRYPTO_LIB_CHACHA_GENERIC
 	tristate
+	default CRYPTO_LIB_CHACHA if !CRYPTO_ARCH_HAVE_LIB_CHACHA
 	select CRYPTO_LIB_UTILS
 	help
-	  This symbol can be depended upon by arch implementations of the
-	  ChaCha library interface that require the generic code as a
-	  fallback, e.g., for SIMD implementations. If no arch specific
-	  implementation is enabled, this implementation serves the users
-	  of CRYPTO_LIB_CHACHA.
-
-config CRYPTO_LIB_CHACHA_INTERNAL
-	tristate
-	select CRYPTO_LIB_CHACHA_GENERIC if CRYPTO_ARCH_HAVE_LIB_CHACHA=n
+	  This symbol can be selected by arch implementations of the ChaCha
+	  library interface that require the generic code as a fallback, e.g.,
+	  for SIMD implementations. If no arch specific implementation is
+	  enabled, this implementation serves the users of CRYPTO_LIB_CHACHA.
 
 config CRYPTO_LIB_CHACHA
 	tristate
-	select CRYPTO
-	select CRYPTO_LIB_CHACHA_INTERNAL
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
 	  is available and enabled.
 
-- 
2.49.0


