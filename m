Return-Path: <linux-arch+bounces-11441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE5A9286C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A66118835DC
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600226FD8C;
	Thu, 17 Apr 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCjTuszM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C96269D03;
	Thu, 17 Apr 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914440; cv=none; b=Ysrj3lKntMGilKAHTcDNMlaLuLMdNZ/9KKMBOB6p51k7xohmeHNqw2TlS7x7EOLg2osFhOMIja0sO4RQOiqeIzhNgv17SBvflPudqFSdkeZF0kl5b/76W5tdtSfoP0Qx/4m48GqnTVAQCh6y8WqC4p7PTo6/aafaNeRKQolo2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914440; c=relaxed/simple;
	bh=weiHwrb8NYhC3jbXTkeAL6uW1ADDBVix7ENL1hEP9Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcrymdlwkBjfLwg2YKuW897jCn6YZW/l1PecLQ4AyFDa5SLKUBZsaJBhvj6sGeOdVfYx/qgzI5c3bWL0701Isq+8yOleHmL9PU8bc8Kv83QltROeiqHRnN1bDKfwfpipOxa7kDMyM435b+3b5c37QfStusy2Q2Q5kljVvYQMAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCjTuszM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8210C4CEEA;
	Thu, 17 Apr 2025 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914439;
	bh=weiHwrb8NYhC3jbXTkeAL6uW1ADDBVix7ENL1hEP9Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCjTuszM4I5za4jOS9EsyjTspBJ0uQZA9yPGKgtPAF7EVQ2UNhku70F5twl78Voz7
	 zH8nB24XT3iK9Toliv9UmuFBiKNZ2u0oe2Kj4ZWUNAZpWxDfAK15NzmpfU7I+QUs5M
	 DcXDHvJryrsVLrQzW0CfMkzTynFe80rCTNySXXLH7KI5Vvz4tIBSYTe85v+4OGCQfe
	 UMzel9rxjWo16CbMZrcP7CD7JcGkgw0esCydWj4tzx8p6eoASPrrwV6JmhYpWmtHSW
	 qDj9PHIEf35cxMjKbq+467s1ksm3R0HGCyDsW0ND+Ggl3MnILrL9VNSbaILZOiATP/
	 VWO7CaooiMU4Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 15/15] crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO
Date: Thu, 17 Apr 2025 11:26:23 -0700
Message-ID: <20250417182623.67808-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417182623.67808-1-ebiggers@kernel.org>
References: <20250417182623.67808-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the architecture-optimized Poly1305 kconfig symbols are visible
without CRYPTO, there is no need for CRYPTO_LIB_POLY1305 to select
CRYPTO.  So, remove that.  This makes the indirection through the
CRYPTO_LIB_POLY1305_INTERNAL symbol unnecessary, so get rid of that and
just use CRYPTO_LIB_POLY1305 directly.  Finally, make the fallback to
the generic implementation use a default value instead of a select; this
makes it consistent with how the arch-optimized code gets enabled and
also with how CRYPTO_LIB_BLAKE2S_GENERIC gets enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/Kconfig     |  2 +-
 arch/arm64/crypto/Kconfig   |  2 +-
 arch/mips/crypto/Kconfig    |  2 +-
 arch/powerpc/crypto/Kconfig |  2 +-
 arch/x86/crypto/Kconfig     |  2 +-
 crypto/Kconfig              |  2 +-
 lib/crypto/Kconfig          | 16 +++++-----------
 7 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 960602271443..e07ff8081da7 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -46,12 +46,12 @@ config CRYPTO_NHPOLY1305_NEON
 	  Architecture: arm using:
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_ARM
 	tristate
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_BLAKE2S_ARM
 	bool "Hash functions: BLAKE2s"
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 8184da75b24f..c3322a0fc2f1 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -26,12 +26,12 @@ config CRYPTO_NHPOLY1305_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_NEON
 	tristate
 	depends on KERNEL_MODE_NEON
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on CRYPTO && KERNEL_MODE_NEON
 	select CRYPTO_HASH
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index f1d61457518f..98c9a2afd676 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -2,12 +2,12 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (mips)"
 
 config CRYPTO_POLY1305_MIPS
 	tristate
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_MD5_OCTEON
 	tristate "Digests: MD5 (OCTEON)"
 	depends on CRYPTO && CPU_CAVIUM_OCTEON
 	select CRYPTO_MD5
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index dd3bd22d8e20..3f3253215470 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -100,13 +100,13 @@ config CRYPTO_CHACHA20_P10
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC
-	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_DEV_VMX
         bool "Support for VMX cryptographic acceleration instructions"
         depends on CRYPTO && PPC64 && VSX
         help
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 5b9d6dbe6185..6f4bcdf410d8 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -397,12 +397,12 @@ config CRYPTO_POLYVAL_CLMUL_NI
 	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_POLY1305_X86_64
 	tristate
 	depends on 64BIT
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_SHA1_SSSE3
 	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on CRYPTO && 64BIT
 	select CRYPTO_SHA1
diff --git a/crypto/Kconfig b/crypto/Kconfig
index ed50d1b6f6f3..82c61c8e7235 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -954,12 +954,12 @@ config CRYPTO_POLYVAL
 	  cryptographic hash function.
 
 config CRYPTO_POLY1305
 	tristate "Poly1305"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC
-	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Poly1305 authenticator algorithm (RFC7539)
 
 	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
 	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index cc4c0ee04f98..e23280af302a 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -112,25 +112,19 @@ config CRYPTO_ARCH_HAVE_LIB_POLY1305
 	  accelerated implementation of the Poly1305 library interface,
 	  either builtin or as a module.
 
 config CRYPTO_LIB_POLY1305_GENERIC
 	tristate
+	default CRYPTO_LIB_POLY1305 if !CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
-	  This symbol can be depended upon by arch implementations of the
-	  Poly1305 library interface that require the generic code as a
-	  fallback, e.g., for SIMD implementations. If no arch specific
-	  implementation is enabled, this implementation serves the users
-	  of CRYPTO_LIB_POLY1305.
-
-config CRYPTO_LIB_POLY1305_INTERNAL
-	tristate
-	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+	  This symbol can be selected by arch implementations of the Poly1305
+	  library interface that require the generic code as a fallback, e.g.,
+	  for SIMD implementations. If no arch specific implementation is
+	  enabled, this implementation serves the users of CRYPTO_LIB_POLY1305.
 
 config CRYPTO_LIB_POLY1305
 	tristate
-	select CRYPTO
-	select CRYPTO_LIB_POLY1305_INTERNAL
 	help
 	  Enable the Poly1305 library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
 	  is available and enabled.
 
-- 
2.49.0


