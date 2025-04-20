Return-Path: <linux-arch+bounces-11463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2FA94910
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C4B170A7D
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070D21480C;
	Sun, 20 Apr 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2xZ4KW5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1A214A7B;
	Sun, 20 Apr 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177258; cv=none; b=Rcx1/LcSYk9v02tTTCV5xfRSPh1Dcd/c52dtIADguwAGsIcc4GQK4RTEv3L3JNFtf/hqS5GEPQLpLQTzOsSJHuCMNuPvkZmvgGSFudJEOowWlxgepEQXRcGPDxWfPb8MWsKm7tQpO5FbwuTGjCs8ot9ZSEYTtS5P96cUWt5wolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177258; c=relaxed/simple;
	bh=Wsz8KfnWpKz3RjYagwsQwuMx7mcDuZ3DmLJCHCvCnLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igWFD4axyIqlU47IjYhvHzDVWdpNjAdPAP1DqNJI5vJRgCWdxtr2Ng2RVt2A+e16xnSoIIEeshdmsM/H3qy++YIynIrRYSWEXEFWWDr0C0/qAuaTbj0j1nGaU4Z0SSt9E472u8CxnPCdF0lpr1OyRE1a8PNFP0/IBE2EwzeXOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2xZ4KW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88EFC4CEF2;
	Sun, 20 Apr 2025 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177258;
	bh=Wsz8KfnWpKz3RjYagwsQwuMx7mcDuZ3DmLJCHCvCnLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2xZ4KW5Pp6GY/TWizi6GAOOXMZzDb5wjHT++8poogg5/85P9lO38XFXkIkTyJidR
	 94z2Ah7sF4UvG3kioylNC8LbE17K+iuEdbZ5tCXkenLerrhreO4+VGH2wXRdIPVynv
	 OLo1yy3vEIgsLZZ44hNSqAv7xog5qZ6wshOeEjGEGI55ke8xourKat6MoUhaZ0vZI0
	 AzDHJ5R7NXKhaunnB9eeyAiOHktkhimLjnL55dtZrAB0LWczGZu/OkRfXmJAbkmR/w
	 XFxLJvu5AyYntgJSpWFP9Jdq6V2iJfF/7anZPtGfK9IvUGKNFzQ+UonFs0oZblHKBS
	 U0U/IkR8RwExA==
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
Subject: [PATCH v2 02/13] crypto: powerpc - drop redundant dependencies on PPC
Date: Sun, 20 Apr 2025 12:25:58 -0700
Message-ID: <20250420192609.295075-3-ebiggers@kernel.org>
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

arch/powerpc/crypto/Kconfig is sourced only when CONFIG_PPC=y, so there
is no need for the symbols defined inside it to depend on PPC.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index cbcf76953d835..8bcc690134644 100644
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


