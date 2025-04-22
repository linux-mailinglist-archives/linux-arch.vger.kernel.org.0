Return-Path: <linux-arch+bounces-11500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA51A970B4
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202567A77E1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAC2900A2;
	Tue, 22 Apr 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBsUn+1u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D828F932;
	Tue, 22 Apr 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335696; cv=none; b=uuxTjgQJSp510YjYuDxQLmq9s1VE+UdkODRiMmRcAjFLQ5phV3ltun/i79G0fgA4MWjasXgsKGh6qPmzIYfWmJc93oMQ7e2bdBW/LVZiS/cuCwIf8d6OMu9y45kMmKvrnpVO4+ijpZccpx27sA4B6fDh2CyBoIAsbcXzInGONv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335696; c=relaxed/simple;
	bh=Wsz8KfnWpKz3RjYagwsQwuMx7mcDuZ3DmLJCHCvCnLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBq/yVMRSHsTnWbCxc/GGxNGadF3a4UqJXCTFV06HXo3wohDMk+yUtqiPQeVOocgdBPZpwBwLZvJ9fqLQa6RDEXej8+RxsZAJat7A9bTFqnkXh/3Uce1hgtV9eRQapwGBkZe516IyokgnCKSod8gWG7DRk0JAA/Yb7P/slLOX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBsUn+1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E98C4CEE9;
	Tue, 22 Apr 2025 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335695;
	bh=Wsz8KfnWpKz3RjYagwsQwuMx7mcDuZ3DmLJCHCvCnLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBsUn+1uknnAtCvGxigHZ4JZToY6+Gy1ixr68PQvV2N71BUQl87w4yMZvlkmjCwZ0
	 RiCZCN4vIV2n0ynKuXxTLvrHQVn87JR/9LqXwv5UnpKrmGxngl4unZebkUVwATB/sE
	 IaMI4ynGGpFpbI3ZRnoRy8dF2K06NBvFqAB9SziK+JLDHzV8/1oz0c8BZdihd951Qw
	 c5+HPn83XoB+DEMH5jnPKhtWdxpTkVxm/BPC9ZhGUEnLGxZ5UomAOSh+VAoTMwUtNK
	 4tXgPPEpd0lYeetuHeVpKT/bTaC5YXBvG+nlQRTRr/c8aoQJpGfdjm9w+zNTOpb2JF
	 xGv23N6geYPRQ==
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
Subject: [PATCH v3 02/13] crypto: powerpc - drop redundant dependencies on PPC
Date: Tue, 22 Apr 2025 08:27:05 -0700
Message-ID: <20250422152716.5923-3-ebiggers@kernel.org>
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


