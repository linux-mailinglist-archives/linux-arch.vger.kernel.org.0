Return-Path: <linux-arch+bounces-11508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECB7A970E0
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A216E141
	for <lists+linux-arch@lfdr.de>; Tue, 22 Apr 2025 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023712951AA;
	Tue, 22 Apr 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKwMSXyS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350A2949F5;
	Tue, 22 Apr 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335699; cv=none; b=DgF0+pgX84bG4+OQXQZu9aWfPiLagcGfxKEmOWBQ/I8tnCQ+FCumd77xDOfQX9dLkj/3AaT1EaAmIrh+QUELKIHcqvdzzVzkCXMVAXY3Aw1bkg1LYuIm7RwSPf+mEGzy6NrDUzIBrK4hmicaeaTw/bkAul4H00TtvpcURymymFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335699; c=relaxed/simple;
	bh=ki6Sn/ee5qgO3vhh3ZkrojeEv770iQQrw7Ukhfk4zI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIsAeBm3fUpFTEZKSLP/xGMufrUzUXnzow5Y7UEOfhOG6EtiKlew3bJVY+EQJIeLI4j+H/d6FjwZAPUqppEdCnz3iqqunWk9apY1Fh2rPPU2+TTFdvo7dOq7K3MCLIO3KOaCFQJlpGUroW+45Qhj6jTf0WIyH7CKu1kiCJFYpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKwMSXyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04868C4CEF0;
	Tue, 22 Apr 2025 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335699;
	bh=ki6Sn/ee5qgO3vhh3ZkrojeEv770iQQrw7Ukhfk4zI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKwMSXyShmoHoJUgBOV9El8W3aUBH6B0Lz2ReK5Ym+/HXRopKgkn01mXIoaJjRjWO
	 Rmyc7OlIJeA+Jq8fnsi9olY+0Z6qJ33MBan8XAwwZU15EexRsxco6jYkVAJpbmWUdw
	 k0W+pKj3tOJd9n0K/kF93dD+ZqWixWfdWR2iEC2blBH7niDgSzB+Eab1g9SkEPXWPK
	 miq+8VeFRIDQ9eKZZ6SRyjXnnrGZwZBPk4rcz3Zml+i3s+36nIv/RasGxrNX1GI9of
	 Wo4JYKUEfdCTsdGvzQWPi78zsaclbLaPDuWsc2OgCOInv7zjSeKx10axodSTGDrhSh
	 yIGZqaS1xAWdQ==
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
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v3 10/13] crypto: s390 - move library functions to arch/s390/lib/crypto/
Date: Tue, 22 Apr 2025 08:27:13 -0700
Message-ID: <20250422152716.5923-11-ebiggers@kernel.org>
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

Continue disentangling the crypto library functions from the generic
crypto infrastructure by moving the s390 ChaCha library functions into a
new directory arch/s390/lib/crypto/ that does not depend on CRYPTO.
This mirrors the distinction between crypto/ and lib/crypto/.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/crypto/Kconfig                 | 6 ------
 arch/s390/crypto/Makefile                | 3 ---
 arch/s390/lib/Makefile                   | 1 +
 arch/s390/lib/crypto/Kconfig             | 7 +++++++
 arch/s390/lib/crypto/Makefile            | 4 ++++
 arch/s390/{ => lib}/crypto/chacha-glue.c | 0
 arch/s390/{ => lib}/crypto/chacha-s390.S | 0
 arch/s390/{ => lib}/crypto/chacha-s390.h | 0
 lib/crypto/Kconfig                       | 3 +++
 9 files changed, 15 insertions(+), 9 deletions(-)
 create mode 100644 arch/s390/lib/crypto/Kconfig
 create mode 100644 arch/s390/lib/crypto/Makefile
 rename arch/s390/{ => lib}/crypto/chacha-glue.c (100%)
 rename arch/s390/{ => lib}/crypto/chacha-s390.S (100%)
 rename arch/s390/{ => lib}/crypto/chacha-s390.h (100%)

diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index e88d9cd256ef5..a2bfd6eef0ca3 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -97,16 +97,10 @@ config CRYPTO_DES_S390
 	  Architecture: s390
 
 	  As of z990 the ECB and CBC mode are hardware accelerated.
 	  As of z196 the CTR mode is hardware accelerated.
 
-config CRYPTO_CHACHA_S390
-	tristate
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 config CRYPTO_HMAC_S390
 	tristate "Keyed-hash message authentication code: HMAC"
 	select CRYPTO_HASH
 	help
 	  s390 specific HMAC hardware support for SHA224, SHA256, SHA384 and
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index 14dafadbcbed4..e3853774e1a3a 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -9,12 +9,9 @@ obj-$(CONFIG_CRYPTO_SHA512_S390) += sha512_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_SHA3_256_S390) += sha3_256_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_SHA3_512_S390) += sha3_512_s390.o sha_common.o
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
 obj-$(CONFIG_CRYPTO_PAES_S390) += paes_s390.o
-obj-$(CONFIG_CRYPTO_CHACHA_S390) += chacha_s390.o
 obj-$(CONFIG_S390_PRNG) += prng.o
 obj-$(CONFIG_CRYPTO_GHASH_S390) += ghash_s390.o
 obj-$(CONFIG_CRYPTO_HMAC_S390) += hmac_s390.o
 obj-y += arch_random.o
-
-chacha_s390-y := chacha-glue.o chacha-s390.o
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index 14bbfe50033c7..fce4edbe8a078 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for s390-specific library files..
 #
 
+obj-y += crypto/
 lib-y += delay.o string.o uaccess.o find.o spinlock.o tishift.o
 lib-y += csum-partial.o
 obj-y += mem.o xor.o
 lib-$(CONFIG_KPROBES) += probes.o
 lib-$(CONFIG_UPROBES) += probes.o
diff --git a/arch/s390/lib/crypto/Kconfig b/arch/s390/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..b79fd91af9fe1
--- /dev/null
+++ b/arch/s390/lib/crypto/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_CHACHA_S390
+	tristate
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
diff --git a/arch/s390/lib/crypto/Makefile b/arch/s390/lib/crypto/Makefile
new file mode 100644
index 0000000000000..06c2cf77178ef
--- /dev/null
+++ b/arch/s390/lib/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_CHACHA_S390) += chacha_s390.o
+chacha_s390-y := chacha-glue.o chacha-s390.o
diff --git a/arch/s390/crypto/chacha-glue.c b/arch/s390/lib/crypto/chacha-glue.c
similarity index 100%
rename from arch/s390/crypto/chacha-glue.c
rename to arch/s390/lib/crypto/chacha-glue.c
diff --git a/arch/s390/crypto/chacha-s390.S b/arch/s390/lib/crypto/chacha-s390.S
similarity index 100%
rename from arch/s390/crypto/chacha-s390.S
rename to arch/s390/lib/crypto/chacha-s390.S
diff --git a/arch/s390/crypto/chacha-s390.h b/arch/s390/lib/crypto/chacha-s390.h
similarity index 100%
rename from arch/s390/crypto/chacha-s390.h
rename to arch/s390/lib/crypto/chacha-s390.h
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 0b06c25eb38a5..db19a7acc2fbf 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -169,8 +169,11 @@ if PPC
 source "arch/powerpc/lib/crypto/Kconfig"
 endif
 if RISCV
 source "arch/riscv/lib/crypto/Kconfig"
 endif
+if S390
+source "arch/s390/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


