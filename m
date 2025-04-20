Return-Path: <linux-arch+bounces-11473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69DA94952
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02031695CF
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B021D59C;
	Sun, 20 Apr 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4LM7CNb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23721D3D6;
	Sun, 20 Apr 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177263; cv=none; b=qYIuOtkyI0GV8He2k2U/BjHud9mJZtDx+lDQ6qC4erS3HGcz/W2HVdZtQv8mw2PwsDnL9TB00vTDlbHlE5Dtr5B2YPy2tpHl3hDm1UJSD2H/cviSqSVYSmP3Eyk+J23PPYQLyTfz+nm373HNF2obE74AtoJjA9Q/1ILTedbWPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177263; c=relaxed/simple;
	bh=HMSzkB91c7IREkKSrVwmdHo1uPEnRz+uSzHzcQq/qGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG/jQL8jjirt8yfKmOusuz3jNTMkuyY4usIA/y/bqKFCwDh5Wyw3UaToVVlqSQNA9EzUgsnP8ir7rFyvVfERS2g6FCfHJVsWBGZljvu3lGrH3f8JAzijNRTpobINisy6uWO0DGMYsjb1O/G/pyNwP/ZORSpWzMuezPtgWvUfryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4LM7CNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88C2C4CEED;
	Sun, 20 Apr 2025 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177263;
	bh=HMSzkB91c7IREkKSrVwmdHo1uPEnRz+uSzHzcQq/qGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4LM7CNbFNHSY9hnaV2d6rZrucqFS5jA0FMbMBdwQhTnV7B6CFjDepHfolH+jxCrh
	 5XrCpkEXF1CKL3Wv+meg+/WDdpWDdzMR6d0YTyx/HMTSK39QvEDQeB71H5T3OYMhbQ
	 5VulWkvXdM9Xy1c1JPSKPDoyxWJdCE7DGFYzgLOZ3vzo4owv5FqfvufKOKkpiWf6ak
	 UXWhl2RLrqSHRmi1NhZJ+h6oMbe+HEnlebNSYSvOQn5oR2L7vVspR7zZJYQhFQjLyp
	 PtqZ72j6asn+SwPhNngp7lPFqIHWEE/AUUj4NuLpX4GKx59STfPOQ4Q/f6vEY1VZeM
	 Yzu6bjYzg4QGw==
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
Subject: [PATCH v2 13/13] crypto: lib/poly1305 - remove INTERNAL symbol and selection of CRYPTO
Date: Sun, 20 Apr 2025 12:26:09 -0700
Message-ID: <20250420192609.295075-14-ebiggers@kernel.org>
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
 arch/arm/lib/crypto/Kconfig     |  2 +-
 arch/arm64/lib/crypto/Kconfig   |  2 +-
 arch/mips/lib/crypto/Kconfig    |  2 +-
 arch/powerpc/lib/crypto/Kconfig |  2 +-
 arch/x86/lib/crypto/Kconfig     |  2 +-
 crypto/Kconfig                  |  2 +-
 lib/crypto/Kconfig              | 16 +++++-----------
 7 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/lib/crypto/Kconfig b/arch/arm/lib/crypto/Kconfig
index 5d10bd13fc8df..e8444fd0aae30 100644
--- a/arch/arm/lib/crypto/Kconfig
+++ b/arch/arm/lib/crypto/Kconfig
@@ -18,7 +18,7 @@ config CRYPTO_CHACHA20_NEON
 	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_ARM
 	tristate
-	default CRYPTO_LIB_POLY1305_INTERNAL
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/arm64/lib/crypto/Kconfig b/arch/arm64/lib/crypto/Kconfig
index 2a8ff7cfc08d3..0b903ef524d85 100644
--- a/arch/arm64/lib/crypto/Kconfig
+++ b/arch/arm64/lib/crypto/Kconfig
@@ -8,7 +8,7 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_NEON
 	tristate
 	depends on KERNEL_MODE_NEON
-	default CRYPTO_LIB_POLY1305_INTERNAL
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/mips/lib/crypto/Kconfig b/arch/mips/lib/crypto/Kconfig
index 454354e30d76c..0670a170c1be0 100644
--- a/arch/mips/lib/crypto/Kconfig
+++ b/arch/mips/lib/crypto/Kconfig
@@ -6,7 +6,7 @@ config CRYPTO_CHACHA_MIPS
 	default CRYPTO_LIB_CHACHA
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_MIPS
 	tristate
-	default CRYPTO_LIB_POLY1305_INTERNAL
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
index 6627d28cd24e0..bf6d0ab22c27d 100644
--- a/arch/powerpc/lib/crypto/Kconfig
+++ b/arch/powerpc/lib/crypto/Kconfig
@@ -8,8 +8,8 @@ config CRYPTO_CHACHA20_P10
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
-	default CRYPTO_LIB_POLY1305_INTERNAL
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC
diff --git a/arch/x86/lib/crypto/Kconfig b/arch/x86/lib/crypto/Kconfig
index e44403d9677f5..546fe2afe0b51 100644
--- a/arch/x86/lib/crypto/Kconfig
+++ b/arch/x86/lib/crypto/Kconfig
@@ -20,7 +20,7 @@ config CRYPTO_CHACHA20_X86_64
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_POLY1305_X86_64
 	tristate
 	depends on 64BIT
-	default CRYPTO_LIB_POLY1305_INTERNAL
+	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 832af6363951f..9878286d1d683 100644
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
index c6ab724c1dbd9..af2368799579f 100644
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


