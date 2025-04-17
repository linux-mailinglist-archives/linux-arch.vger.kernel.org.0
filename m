Return-Path: <linux-arch+bounces-11428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE9A92827
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 20:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C586F4A2A19
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AA263F39;
	Thu, 17 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toxBea61"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6A263F24;
	Thu, 17 Apr 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914427; cv=none; b=Yfi4kTfIgQKSov5h47LqJw+vD7LTgTnrAaRtt+f4V1b6T0S/HC2Pc0Fvterr/SpRNSf0308yJqsXtcRM1+vef0XgjM26pqvvgrgOf/3NJfmHdGvniySTA+EjSiha035DdBt5HylzoQBdmRJG7nCUIDWawBZlAdQReILjsTMcwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914427; c=relaxed/simple;
	bh=nXbV1Uvq4c8RL4YhRp/ivGFjNzOtTa70IujwafR6+UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfnQ+Jidud3R1l1Qom68znfU06e8QC+5b5ZUFy9n9vnx0yoszsZ5lzyBfvDjuuypwv1aBnFpxo71CE9DFcwBFtE/okbyETwf1ptaO2/K6HMK5qkfAJIUPdAH7BXlTYKqpur8pP3WPoC+bTfSIAy6j3U9UcSZbrSVul/7bBaTa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toxBea61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8307C4CEEC;
	Thu, 17 Apr 2025 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744914427;
	bh=nXbV1Uvq4c8RL4YhRp/ivGFjNzOtTa70IujwafR6+UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toxBea61JWC5/trBUl49NvCsVkVAmNhju3B87UReIfBHz8VnRyE/LuVybLVF2k/nY
	 ozG0hZ8OBwzDL6uS4Zi1cnO2Mrn+mq1gQ/r8Oq+czYCLjfyTD/V03RB7fCo5SP71wf
	 zlxk4RJm3o05FtCFrRaAKTzpr6oWDwo/e21dJwjhdxrVVorZg+xwqsKTLym49Olhvz
	 SwdxWMKOu8BP6ibmjf8JnzW3kYR8b7Naf0ZpIJmNV9xQkNMUjmcXpx+iFVvnhelZFG
	 WffphaS/N+aHynjqKlRMXoA+AQi8OOH4tWYJ2rqeMi/Rw6uFqtGdZWOBgLIHH2X50p
	 7wDfzUig2kHFw==
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
Subject: [PATCH 02/15] crypto: arm64 - drop redundant dependencies on ARM64
Date: Thu, 17 Apr 2025 11:26:10 -0700
Message-ID: <20250417182623.67808-3-ebiggers@kernel.org>
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

arch/arm64/crypto/Kconfig is sourced only when CONFIG_ARM64=y, so there
is no need for the symbols defined inside it to depend on ARM64.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 7c2f63f2e307..704d0b7e1d13 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -135,11 +135,11 @@ config CRYPTO_AES_ARM64
 
 	  Architecture: arm64
 
 config CRYPTO_AES_ARM64_CE
 	tristate "Ciphers: AES (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
 	  Block ciphers: AES cipher algorithms (FIPS-197)
 
@@ -252,11 +252,11 @@ config CRYPTO_SM4_ARM64_NEON_BLK
 	  Architecture: arm64 using:
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AEAD cipher: AES in CCM mode (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AES_ARM64_CE_BLK
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
-- 
2.49.0


