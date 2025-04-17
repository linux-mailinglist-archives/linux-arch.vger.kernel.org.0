Return-Path: <linux-arch+bounces-11437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466FA9285A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFD819E17F2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41926A082;
	Thu, 17 Apr 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsPQ7SM0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091A269D03;
	Thu, 17 Apr 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914436; cv=none; b=GIn6W7B34ng8X+L1OvJiHqb/V7HZzeOnCDshNxuJpehwetsksdc2y9+q8rlvCsejT9m19cK/P7d7z0FHZCKDZxfSyyUdFEySFvbs/hxITZwD8KTrATPtl8qscOrLrIQtz1zTLUFB+1HPbB3JqSRgFSyhHUAaTP3xEaqPTdKiMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914436; c=relaxed/simple;
	bh=JbJS8/qnHgUt3U/s/OZ1wHouJGsPrwOIMNb0fsrruts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQp2ZxXZNyq8lld+wgdx/nV5CqyaAkwSWIEa2zT0d9nGQRP25tPJ1yvQU8dcSQamJbESjb55Y1GceSc0525Tt78LH3cS5bVPJA30lPlpkMsFE20XBq2t0km7K9c822tOpXK3NI+G+cw/PRDkMR+JqX613ZIQ1dNO/Vqffsv3ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsPQ7SM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A178C4CEEE;
	Thu, 17 Apr 2025 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914435;
	bh=JbJS8/qnHgUt3U/s/OZ1wHouJGsPrwOIMNb0fsrruts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsPQ7SM08OE2nVaOMuo7BI2L0WCPbuWvkvRFKYA1VN20m7TA2WLujzpAcLu7ZMcib
	 hPnCRg0E7SNiql3hUMjtjrKocI+hy9AGuNATMqCgnk/rNoSndaJyXohW2QtNmOUSPf
	 HrM2yP1EtnKQZI2TXj4jwGIcWlPFoOfnUtif6W1J55H7QSOzeGZBBl4pFsL/oOnTEN
	 CWOaPKhbHIyWJ9YsfjPH79eEhWbfY/xLRdrWQ9tJfUzkID0IPOW6mp/fkmf8M1/xUN
	 vdYRLr2CQUbbJhMAXeeDorK0RWUQEsRQB9v5kyhJZrk3fHLwmkx9SgLxxg4V3BakOJ
	 ld/9yQXGcf11g==
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
Subject: [PATCH 11/15] crypto: sparc - source arch/sparc/crypto/Kconfig without CRYPTO
Date: Thu, 17 Apr 2025 11:26:19 -0700
Message-ID: <20250417182623.67808-12-ebiggers@kernel.org>
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

Source arch/sparc/crypto/Kconfig regardless of CRYPTO, so that if
library functions are ever added to there they can be built without
pulling in the generic crypto infrastructure.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/sparc/Kconfig        |  2 ++
 arch/sparc/crypto/Kconfig | 14 +++++++-------
 crypto/Kconfig            |  3 ---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0f88123925a4..b1081e627a28 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -407,10 +407,12 @@ config UBOOT_ENTRY_ADDR
 	 hardcoded by the SPARC32 and LEON port.
 
 	 This is the virtual address u-boot jumps to when booting the Linux
 	 Kernel.
 
+source "arch/sparc/crypto/Kconfig"
+
 endmenu
 endif
 
 endmenu
 
diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index e858597de89d..477a85370507 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -2,11 +2,11 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (sparc64)"
 
 config CRYPTO_DES_SPARC64
 	tristate "Ciphers: DES and Triple DES EDE, modes: ECB/CBC"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	select CRYPTO_SKCIPHER
 	help
 	  Block cipher: DES (FIPS 46-2) cipher algorithm
@@ -16,61 +16,61 @@ config CRYPTO_DES_SPARC64
 
 	  Architecture: sparc64
 
 config CRYPTO_MD5_SPARC64
 	tristate "Digests: MD5"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
 	  MD5 message digest algorithm (RFC1321)
 
 	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA1_SPARC64
 	tristate "Hash functions: SHA-1"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: sparc64
 
 config CRYPTO_SHA256_SPARC64
 	tristate "Hash functions: SHA-224 and SHA-256"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA512_SPARC64
 	tristate "Hash functions: SHA-384 and SHA-512"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_AES_SPARC64
 	tristate "Ciphers: AES, modes: ECB, CBC, CTR"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_SKCIPHER
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 	  Length-preseving ciphers: AES with ECB, CBC, and CTR modes
 
 	  Architecture: sparc64 using crypto instructions
 
 config CRYPTO_CAMELLIA_SPARC64
 	tristate "Ciphers: Camellia, modes: ECB, CBC"
-	depends on SPARC64
+	depends on CRYPTO && SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
 	  Block ciphers: Camellia cipher algorithms
 	  Length-preserving ciphers: Camellia with ECB and CBC modes
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 78e83ce576ed..c0906bb4f844 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1424,13 +1424,10 @@ endmenu
 
 config CRYPTO_HASH_INFO
 	bool
 
 if !KMSAN # avoid false positives from assembly
-if SPARC
-source "arch/sparc/crypto/Kconfig"
-endif
 if X86
 source "arch/x86/crypto/Kconfig"
 endif
 endif
 
-- 
2.49.0


