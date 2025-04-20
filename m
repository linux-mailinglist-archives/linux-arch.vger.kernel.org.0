Return-Path: <linux-arch+bounces-11470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F499A94941
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 21:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39373AE11A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Apr 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F721B18C;
	Sun, 20 Apr 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCkUDe2S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93F2147E6;
	Sun, 20 Apr 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177261; cv=none; b=faJ/Oy7tZC6UxulyVtTW+n3ChDM2vCA14hq3syH1oI37cdUQpIctd5hmGtmBBQiCpSdFBkvZXBq4+BqxAbQvoBaMdNn8ELEnCN3EaZ1+9xSvINsMeEdwkW8WK3Fu7WtlkOSB9bwOkijf9gj+8TDTlCZ740PBNgvl+rcWPZg2MVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177261; c=relaxed/simple;
	bh=JceMeyvHZFS3hU3osMnM8DtDXrhU/UjeqoFMt/NCYhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZr1jFTTwq++N6CW0+xpsw02rfhgt/UguapcIctYX3YjGGb35Kc3o4Dgz/rPqpO8CKGpPHNqulWbK8HyltwqnmKtN8/ACM2mVa3Meum343U8ECi+VxMuQQDY3wOTptJAD5gDqEBTERzmvXdglgIX+qgmjRQLB+XEV3fgRCw8u2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCkUDe2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F183DC4CEED;
	Sun, 20 Apr 2025 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745177261;
	bh=JceMeyvHZFS3hU3osMnM8DtDXrhU/UjeqoFMt/NCYhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCkUDe2S72itq2OYuxxdcNB38pxf0twZvxcIytZW+K9b6WjYA0TAIwlMai/eahJAx
	 w8hnWfFuUPwQIEWcmraLbu+8LuMqAmesx2H0tNclifUpqnw3RlSCtQJQXl7qosnV2B
	 X9dfT634nEyucjsrsXXn2P/ZQhmdjtoJhC5zA8zcTDZzetaY0MekSgwZdqf1NxO2DG
	 rGjDYkc5mRCzY0avNxgFZx69VsIWcl/xjeGBuZUOG9mWyOjDRjtgn9xGXhXEkHed9d
	 0Qkk02QD/yLL5xsi23VAlR3hd1WRfL/GqaURyDQikpiyFjKT3o0P20ZHdJC6pdJW+2
	 BorTK//xE0hgg==
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
Subject: [PATCH v2 09/13] crypto: riscv - move library functions to arch/riscv/lib/crypto/
Date: Sun, 20 Apr 2025 12:26:05 -0700
Message-ID: <20250420192609.295075-10-ebiggers@kernel.org>
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

Continue disentangling the crypto library functions from the generic
crypto infrastructure by moving the riscv ChaCha library functions into
a new directory arch/riscv/lib/crypto/ that does not depend on CRYPTO.
This mirrors the distinction between crypto/ and lib/crypto/.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/crypto/Kconfig                         | 7 -------
 arch/riscv/crypto/Makefile                        | 3 ---
 arch/riscv/lib/Makefile                           | 1 +
 arch/riscv/lib/crypto/Kconfig                     | 8 ++++++++
 arch/riscv/lib/crypto/Makefile                    | 4 ++++
 arch/riscv/{ => lib}/crypto/chacha-riscv64-glue.c | 0
 arch/riscv/{ => lib}/crypto/chacha-riscv64-zvkb.S | 0
 lib/crypto/Kconfig                                | 3 +++
 8 files changed, 16 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/lib/crypto/Kconfig
 create mode 100644 arch/riscv/lib/crypto/Makefile
 rename arch/riscv/{ => lib}/crypto/chacha-riscv64-glue.c (100%)
 rename arch/riscv/{ => lib}/crypto/chacha-riscv64-zvkb.S (100%)

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 27a1f26d41bde..4863be2a4ec2f 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -16,17 +16,10 @@ config CRYPTO_AES_RISCV64
 	  - Zvkned vector crypto extension
 	  - Zvbb vector extension (XTS)
 	  - Zvkb vector crypto extension (CTR)
 	  - Zvkg vector crypto extension (XTS)
 
-config CRYPTO_CHACHA_RISCV64
-	tristate
-	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	select CRYPTO_LIB_CHACHA_GENERIC
-	default CRYPTO_LIB_CHACHA_INTERNAL
-
 config CRYPTO_GHASH_RISCV64
 	tristate "Hash functions: GHASH"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	select CRYPTO_GCM
 	help
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 247c7bc7288ce..4ae9bf762e907 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -2,13 +2,10 @@
 
 obj-$(CONFIG_CRYPTO_AES_RISCV64) += aes-riscv64.o
 aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
 		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
-obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
-chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
-
 obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
 ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
 
 obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
 sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index b1c46153606a6..0baec92d2f55b 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= crypto/
 lib-y			+= delay.o
 lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
 ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
diff --git a/arch/riscv/lib/crypto/Kconfig b/arch/riscv/lib/crypto/Kconfig
new file mode 100644
index 0000000000000..46ce2a7ac1f2c
--- /dev/null
+++ b/arch/riscv/lib/crypto/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CRYPTO_CHACHA_RISCV64
+	tristate
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	default CRYPTO_LIB_CHACHA_INTERNAL
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	select CRYPTO_LIB_CHACHA_GENERIC
diff --git a/arch/riscv/lib/crypto/Makefile b/arch/riscv/lib/crypto/Makefile
new file mode 100644
index 0000000000000..e27b78f317fc8
--- /dev/null
+++ b/arch/riscv/lib/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
+chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
diff --git a/arch/riscv/crypto/chacha-riscv64-glue.c b/arch/riscv/lib/crypto/chacha-riscv64-glue.c
similarity index 100%
rename from arch/riscv/crypto/chacha-riscv64-glue.c
rename to arch/riscv/lib/crypto/chacha-riscv64-glue.c
diff --git a/arch/riscv/crypto/chacha-riscv64-zvkb.S b/arch/riscv/lib/crypto/chacha-riscv64-zvkb.S
similarity index 100%
rename from arch/riscv/crypto/chacha-riscv64-zvkb.S
rename to arch/riscv/lib/crypto/chacha-riscv64-zvkb.S
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 4b3e94ed84bb6..0b06c25eb38a5 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -166,8 +166,11 @@ if MIPS
 source "arch/mips/lib/crypto/Kconfig"
 endif
 if PPC
 source "arch/powerpc/lib/crypto/Kconfig"
 endif
+if RISCV
+source "arch/riscv/lib/crypto/Kconfig"
+endif
 endif
 
 endmenu
-- 
2.49.0


