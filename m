Return-Path: <linux-arch+bounces-11462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141CA9490A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FF7A720F
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53649214810;
	Sun, 20 Apr 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9TI7aC0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46C2147E6;
	Sun, 20 Apr 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177258; cv=none; b=chndl2t9DrSRKiQTn6aEDpLYa4trqBoxQmU0CDPKK8QtUMIqYYhDxt29aZgrdkLITy4NqUcWAzXPpfcWQjZNpiKGRokPMQGMNalb645MXKKSobt6GsHwAmLgjePdOqovm6OmsNH4pC2huChBB1OMMTxsAl/50Y8B3A1DFf1Je/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177258; c=relaxed/simple;
	bh=ySujzJwEjUZrj9er8XlrWX/11KoXjZIlZ2vhV5/jq10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg+jgBV+tGceGep+dv7oitBlvYGRmrCQDnGrPlIIB6Nlvwem8ki8gE1ehEMFk0jXP117ow+lXYVT0dDbWdwUcWmOKWyQNkQcEKMjHRsowPqHAUVERYZ5dlpqdP4HU31airJL/QlzExdCFNaVuenUjF6MgzQJsVXt66mml+xt6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9TI7aC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A345C4CEF0;
	Sun, 20 Apr 2025 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177257;
	bh=ySujzJwEjUZrj9er8XlrWX/11KoXjZIlZ2vhV5/jq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9TI7aC0W6sDFYjdwFetT0Htr1lKbZ7CRIb92PqjTlyPCPRl834rlsPq4Upa7TwVU
	 KUK3O17RKKGtV9jgwuXyKmuOVSZQqgsouS72xWZ2DXYXR2p3aaop7Z/twb1Pp2xNrh
	 VSR8kglU79GjgMfqghQnbKAFMEFT6wrVHmrnbFNrAdKrNv8Ow9NZ1Wk+PQCHs+Ubwf
	 05CeLhHFtz4u9QqW+2DLK5sXGu72F+lpuVxsqScpn5fKKuKiGEaQkcwCdA9aHHDDv0
	 KmyWrMC+UAVURp3ysmv/Bn5eXgycy3Jqe2p8DBklv3xLuCGcbUhveQqhNiOlXVgRYj
	 y//Xcbxc8AzVw==
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
Subject: [PATCH v2 01/13] crypto: arm64 - drop redundant dependencies on ARM64
Date: Sun, 20 Apr 2025 12:25:57 -0700
Message-ID: <20250420192609.295075-2-ebiggers@kernel.org>
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

arch/arm64/crypto/Kconfig is sourced only when CONFIG_ARM64=y, so there
is no need for the symbols defined inside it to depend on ARM64.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 7c2f63f2e3072..704d0b7e1d137 100644
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


