Return-Path: <linux-arch+bounces-11431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA8A9283D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333F5169797
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33181265CBB;
	Thu, 17 Apr 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAMyrHeH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D96265615;
	Thu, 17 Apr 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914431; cv=none; b=JIbPKoe22S4A6D6uCl9irNTIclME7iIsm/WgPcmy18XfOo/y9iNSlBkG9q1RiKs0iEaG6aW+jOuTnNcmlE71qS8RLPOR870dr2YvXUSsQDjAP/zC/SK+Toc53Uiik8gcwrMaw7AmG+PYmzgj226ENdi+gQBd0G0UAK9ylvEtjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914431; c=relaxed/simple;
	bh=502owMjVm+hoOhMR1Hf0JVEnqbSzLpYcfIVzN4dcz4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAxu1OJoyogSVUd+WisVRCJNcbph1bO4L5JeCwo0ko/UWr80nyf1DNQfpQCPDQcqtNU8za5Gzy1QWCS7IR5KBVc/Fc8YyqJQ7y3ezDQDSIgPSryAHu8Ph9ZGOEAkDcd2YjxFQprkJcx17Pc+KiLoSGLep/CkVMC9mpvuPBmsYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAMyrHeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C6EC4CEEC;
	Thu, 17 Apr 2025 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914430;
	bh=502owMjVm+hoOhMR1Hf0JVEnqbSzLpYcfIVzN4dcz4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAMyrHeHfLzRwrbxfetwQRDA3HiqUq0/dEEsCTS0UxPPaEbIG5tJmbg3rAGVg2Tk/
	 FWgRyd7u4oJs/J9r/MSQDgrCniZyAAjfv07x8Q433tbtXM/cj02e8z9ogeT8hV3q3k
	 ltrMfiL0NqXOsLJSCktIBNSFeapon/0xKWEuD3gknlKZk/QqP8tIAQ9/aoOZLyKT+w
	 wEHiJRhrRc4OPQUjdEv6x14RMWAq8a1PQmaEc495s7C1yDMMD/HY9o9jkx28ppdzyF
	 5g8gRBVnj0K+a02wOI8Fe01UgGzGW+BWFfJ0rfAaj1KSLahA7+5wtmYqemxVSM60AF
	 fngOflAxzYM2A==
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
Subject: [PATCH 05/15] crypto: mips - remove CRYPTO dependency of library functions
Date: Thu, 17 Apr 2025 11:26:13 -0700
Message-ID: <20250417182623.67808-6-ebiggers@kernel.org>
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

Continue disentangling the crypto library functions from the generic
crypto infrastructure by removing the unnecessary CRYPTO dependency of
CRYPTO_CHACHA_MIPS and CRYPTO_POLY1305_MIPS.  To do this, make
arch/mips/crypto/Kconfig be sourced regardless of CRYPTO, and explicitly
list the CRYPTO dependency in the symbols that do need it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/mips/Kconfig        | 2 ++
 arch/mips/crypto/Kconfig | 8 ++++----
 crypto/Kconfig           | 3 ---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fc0772c1bad4..9e0cf394a46b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3136,8 +3136,10 @@ endif # CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
 
 source "drivers/cpuidle/Kconfig"
 
 endmenu
 
+source "arch/mips/crypto/Kconfig"
+
 source "arch/mips/kvm/Kconfig"
 
 source "arch/mips/vdso/Kconfig"
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 8283664a1f24..beb7b20cf3e8 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -7,41 +7,41 @@ config CRYPTO_POLY1305_MIPS
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	default CRYPTO_LIB_POLY1305_INTERNAL
 
 config CRYPTO_MD5_OCTEON
 	tristate "Digests: MD5 (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
+	depends on CRYPTO && CPU_CAVIUM_OCTEON
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
 	  MD5 message digest algorithm (RFC1321)
 
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA1_OCTEON
 	tristate "Hash functions: SHA-1 (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
+	depends on CRYPTO && CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: mips OCTEON
 
 config CRYPTO_SHA256_OCTEON
 	tristate "Hash functions: SHA-224 and SHA-256 (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
+	depends on CRYPTO && CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA512_OCTEON
 	tristate "Hash functions: SHA-384 and SHA-512 (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
+	depends on CRYPTO && CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index de71e9c9f2ad..cfa426bea0c6 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if MIPS
-source "arch/mips/crypto/Kconfig"
-endif
 if PPC
 source "arch/powerpc/crypto/Kconfig"
 endif
 if RISCV
 source "arch/riscv/crypto/Kconfig"
-- 
2.49.0


