Return-Path: <linux-arch+bounces-11510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC57A970FE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1CC3B80AE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB829616B;
	Tue, 22 Apr 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuNjZ/SJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF2296158;
	Tue, 22 Apr 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335701; cv=none; b=WgEry9hTwH3hMWE3yDMo4RY2/eGBEscGHi4SxZ2LZ0ARRBg5H5e7zCPwyMZOM9JCN8XfOvt3Jy3MZiV2rXD4l+3L+5nuBoJRtWOgpWTxw/glhTKWqtUJikytYerqQvNHOg7/18Ptkq/FdzGFcx32GpS0SQHv+QHcNQK0Ds+WZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335701; c=relaxed/simple;
	bh=/KmscafjzVVui9ZfhF2V3SnpWNzO/mZrkUglchVeyKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbxKqvcjq3NQy1/UUFofHhSRfitIc6is2b1aBuYXaH0bPxj6B52tBDVoCEW9CccDDqdXX1XKd5PbjSl4D3MK1aqieMQbK8gQk4cMuOFK9A5n7WUTv3AWLOtzTHFIo6q4PSQC/JmqjhhpYaiXHgNbbewzx7mWpHMKj4LWxUc8Hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuNjZ/SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0297C4CEEC;
	Tue, 22 Apr 2025 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335700;
	bh=/KmscafjzVVui9ZfhF2V3SnpWNzO/mZrkUglchVeyKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuNjZ/SJrEzQtsB5ZEn+Yk2JTaA2nrQbL/H1czw0XJaW8aTEfRMfEWhAxoPC1Ta53
	 lhvGkQgr5r2iGqLIT1t/I40hBfAjG3jEximHUObEJemAtwyB9JaWUj2STMJG7vAKSd
	 jD8oyoPjpImTzR4sCm7icQMcg1YCa2D63b9Dv6AIfTmeF9iwTobfCvrXgQQgY8/h+6
	 0bE3bYb+vQTvq2CQnMwq50TMtXNObtXXyDZ0RL0MildTJVYCrwCBi8cdV1zHKjtmUE
	 DFCpeD8EAO1jExvckOxytr7efqi9TiKmOMdMuDRVOUT3DoW8p628+E6qMLvOJ8DNiM
	 iG3CBdLj+sZTA==
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
Subject: [PATCH v3 12/13] crypto: lib/chacha - remove INTERNAL symbol and selection of CRYPTO
Date: Tue, 22 Apr 2025 08:27:15 -0700
Message-ID: <20250422152716.5923-13-ebiggers@kernel.org>
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

Now that the architecture-optimized ChaCha kconfig symbols are defined
regardless of CRYPTO, there is no need for CRYPTO_LIB_CHACHA to select
CRYPTO.  So, remove that.  This makes the indirection through the
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


