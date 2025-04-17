Return-Path: <linux-arch+bounces-11432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD3A92846
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE4E8E0D48
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3D263F27;
	Thu, 17 Apr 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWMie4DA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6A266B48;
	Thu, 17 Apr 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914432; cv=none; b=TieW1JcNoc1n9BXzZgkuH59y1lJoysrlLzk7Zwr7CXkGnSmUBB1EmJG1dgWLPnKf2eWiWGe7Xj1Vum4hJgejrU8CYeXeyrswKdo+g/XhzSBDQD2dhg7zqd/z8WXQak8gD0fhjR1Av1BuQwHFCD/gSf5HH0visPpXg3ifPp4NLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914432; c=relaxed/simple;
	bh=G+RJfQwnrkpe+wcA+WG93U24b0GCpAuDSETRip59rRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGfIpQPZqVP3w9NXGjs3frY+PtHTn5sGVWY7tGaBhXcvDjTqfX8VoUGqmxKG9WxUL8Hij0T+MBLwDRTUcUHdDmObw2mon3jicKwEDHibbgbznVTIbz3McYHRE6mhe6UlJQRq5Z9q14p9rW4htwjr1jw1+RnzlRncj0DuNvvVfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWMie4DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E2AC4CEF0;
	Thu, 17 Apr 2025 18:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914431;
	bh=G+RJfQwnrkpe+wcA+WG93U24b0GCpAuDSETRip59rRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWMie4DATTokrFQv/LaLT+2y5Te5b7EzAIDVUK6YdkaXLjrBF5GDhBHPh+63huN2W
	 Er83WZhTfYFCVtYFjOI3rJWltW5O9QQ2PCYWbMoZAQvKCc+FAm47RNAKyZTqpbmLMv
	 5/wbtrkLP20SSF/KC5920irbPfn5FnSadNc4EAK1eVK8tb/4Uf2ZOSnZ3cHuiQ1zNO
	 VzCg47eWhx45SZp2T/tDX+++Uc+pssczx1X8xY3QBG4xkFlVkMu6ZumATl2ZMa97wB
	 quS/5UzIHOtaGmLyS7TiXHsHj/cYY6Mw48TKzI9Z8ILte/qi2p4qJMoeEFfVRCDNxn
	 m7ZdqcDwRm2ag==
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
Subject: [PATCH 06/15] crypto: powerpc - drop redundant dependencies on PPC
Date: Thu, 17 Apr 2025 11:26:14 -0700
Message-ID: <20250417182623.67808-7-ebiggers@kernel.org>
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

arch/powerpc/crypto/Kconfig is sourced only when CONFIG_PPC=y, so there
is no need for the symbols defined inside it to depend on PPC.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index cbcf76953d83..8bcc69013464 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -15,48 +15,46 @@ config CRYPTO_CURVE25519_PPC64
 	  Architecture: PowerPC64
 	  - Little-endian
 
 config CRYPTO_MD5_PPC
 	tristate "Digests: MD5"
-	depends on PPC
 	select CRYPTO_HASH
 	help
 	  MD5 message digest algorithm (RFC1321)
 
 	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC
 	tristate "Hash functions: SHA-1"
-	depends on PPC
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC_SPE
 	tristate "Hash functions: SHA-1 (SPE)"
-	depends on PPC && SPE
+	depends on SPE
 	help
 	  SHA-1 secure hash algorithm (FIPS 180)
 
 	  Architecture: powerpc using
 	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_SHA256_PPC_SPE
 	tristate "Hash functions: SHA-224 and SHA-256 (SPE)"
-	depends on PPC && SPE
+	depends on SPE
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
 	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
 
 	  Architecture: powerpc using
 	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_AES_PPC_SPE
 	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (SPE)"
-	depends on PPC && SPE
+	depends on SPE
 	select CRYPTO_SKCIPHER
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 	  Length-preserving ciphers: AES with ECB, CBC, CTR, and XTS modes
 
-- 
2.49.0


