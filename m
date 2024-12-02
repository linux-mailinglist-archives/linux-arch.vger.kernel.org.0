Return-Path: <linux-arch+bounces-9213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D89DF82F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34C0280F7C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228A1D8DFE;
	Mon,  2 Dec 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUlGfZAb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6D1B07AE;
	Mon,  2 Dec 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101777; cv=none; b=ej1UJ1iCjtKaQGwulLum03Yq7srTsXB2qjDbI4vNrqQ1FSz0JofTjP7t0CTFaZE8E/RKapemCU1zkkW7k9vjfiMntS3P3/5mPFlOCkmROhWO4oO3261l3yMxU1FQ5y9w9kNC+i2b0jLDCRwpj/qe4KJaKGdnRhby8mnPHffBOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101777; c=relaxed/simple;
	bh=zWAjtRpwG/RsPHeuNC3qmqgg0iTy0nmJZ7nxNCPm0aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QigvswvP9sjj2fskP2c5bpkG5SwlQdk/FDtYqZrAgvnP1PKe7TsjjsoU1nP76JAmh2YMRbt6dwUA3JjaEZv60NlTA2XWbwD/zYhd5BWbrz0lF33HRjdxe0Zu8/3XzgtdI1081gL5qYff2ywE3efCIa1F9T03D3wr1JnrPtVmOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUlGfZAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40774C4CED2;
	Mon,  2 Dec 2024 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101777;
	bh=zWAjtRpwG/RsPHeuNC3qmqgg0iTy0nmJZ7nxNCPm0aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUlGfZAbhj1YDLQx1/AEYZvSFdrBTDethDXF4i9ERTYsKp856cW9OmidC69Vr/3qG
	 h80tdaSdP4L/vgp/gjirYV6Gj5ymnF012e/TMEqCFygfv/XflHfgUqt+Bae97/+Cam
	 pwF06a1si8gkRBQv8bkZX/VYxx171Zg5kDCjGYEJAYUhtwU16hpxOQ4m3SMQ1zFrLd
	 SggMqeo6V5UKgOox0+XvI7eGgsTsaElwdc58N51UabgHQO5AA7lZDClfoupMcWwMHl
	 mS73RBctxDz0Zj4d+T980VRjjksWsg2d1VpzhDxexYo9ebIc0U6J7fk3ND8LtWG5y+
	 2HCTso0MHXPYQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 15/19] lib/crc32: make crc32c() go directly to lib
Date: Sun,  1 Dec 2024 17:08:40 -0800
Message-ID: <20241202010844.144356-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202010844.144356-1-ebiggers@kernel.org>
References: <20241202010844.144356-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the lower level __crc32c_le() library function is optimized for
each architecture, make crc32c() just call that instead of taking an
inefficient and error-prone detour through the shash API.

Note: a future cleanup should make crc32c_le() be the actual library
function instead of __crc32c_le().  That will require updating callers
of __crc32c_le() to use crc32c_le() instead, and updating callers of
crc32c_le() that expect a 'const void *' arg to expect 'const u8 *'
instead.  Similarly, a future cleanup should remove LIBCRC32C by making
everyone who is selecting it just select CRC32 directly instead.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/crc32c.h |  7 ++--
 lib/Kconfig            | 10 ++----
 lib/Makefile           |  1 -
 lib/libcrc32c.c        | 74 ------------------------------------------
 4 files changed, 8 insertions(+), 84 deletions(-)
 delete mode 100644 lib/libcrc32c.c

diff --git a/include/linux/crc32c.h b/include/linux/crc32c.h
index 357ae4611a45..47eb78003c26 100644
--- a/include/linux/crc32c.h
+++ b/include/linux/crc32c.h
@@ -1,12 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_CRC32C_H
 #define _LINUX_CRC32C_H
 
-#include <linux/types.h>
+#include <linux/crc32.h>
 
-extern u32 crc32c(u32 crc, const void *address, unsigned int length);
+static inline u32 crc32c(u32 crc, const void *address, unsigned int length)
+{
+	return __crc32c_le(crc, address, length);
+}
 
 /* This macro exists for backwards-compatibility. */
 #define crc32c_le crc32c
 
 #endif	/* _LINUX_CRC32C_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 8858030bebae..d0c2dc0dac32 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -308,18 +308,14 @@ config CRC7
 	  the kernel tree does. Such modules that use library CRC7
 	  functions require M here.
 
 config LIBCRC32C
 	tristate "CRC32c (Castagnoli, et al) Cyclic Redundancy-Check"
-	select CRYPTO
-	select CRYPTO_CRC32C
+	select CRC32
 	help
-	  This option is provided for the case where no in-kernel-tree
-	  modules require CRC32c functions, but a module built outside the
-	  kernel tree does. Such modules that use library CRC32c functions
-	  require M here.  See Castagnoli93.
-	  Module will be libcrc32c.
+	  This option just selects CRC32 and is provided for compatibility
+	  purposes until the users are updated to select CRC32 directly.
 
 config CRC8
 	tristate "CRC8 function"
 	help
 	  This option provides CRC8 function. Drivers may select this
diff --git a/lib/Makefile b/lib/Makefile
index a8155c972f02..6573163d24e4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -165,11 +165,10 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC64)     += crc64.o
 obj-$(CONFIG_CRC32_SELFTEST)	+= crc32test.o
 obj-$(CONFIG_CRC4)	+= crc4.o
 obj-$(CONFIG_CRC7)	+= crc7.o
-obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_CRC8)	+= crc8.o
 obj-$(CONFIG_CRC64_ROCKSOFT) += crc64-rocksoft.o
 obj-$(CONFIG_XXHASH)	+= xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
diff --git a/lib/libcrc32c.c b/lib/libcrc32c.c
deleted file mode 100644
index 649e687413a0..000000000000
--- a/lib/libcrc32c.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* 
- * CRC32C
- *@Article{castagnoli-crc,
- * author =       { Guy Castagnoli and Stefan Braeuer and Martin Herrman},
- * title =        {{Optimization of Cyclic Redundancy-Check Codes with 24
- *                 and 32 Parity Bits}},
- * journal =      IEEE Transactions on Communication,
- * year =         {1993},
- * volume =       {41},
- * number =       {6},
- * pages =        {},
- * month =        {June},
- *}
- * Used by the iSCSI driver, possibly others, and derived from
- * the iscsi-crc.c module of the linux-iscsi driver at
- * http://linux-iscsi.sourceforge.net.
- *
- * Following the example of lib/crc32, this function is intended to be
- * flexible and useful for all users.  Modules that currently have their
- * own crc32c, but hopefully may be able to use this one are:
- *  net/sctp (please add all your doco to here if you change to
- *            use this one!)
- *  <endoflist>
- *
- * Copyright (c) 2004 Cisco Systems, Inc.
- */
-
-#include <crypto/hash.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/crc32c.h>
-
-static struct crypto_shash *tfm;
-
-u32 crc32c(u32 crc, const void *address, unsigned int length)
-{
-	SHASH_DESC_ON_STACK(shash, tfm);
-	u32 ret, *ctx = (u32 *)shash_desc_ctx(shash);
-	int err;
-
-	shash->tfm = tfm;
-	*ctx = crc;
-
-	err = crypto_shash_update(shash, address, length);
-	BUG_ON(err);
-
-	ret = *ctx;
-	barrier_data(ctx);
-	return ret;
-}
-
-EXPORT_SYMBOL(crc32c);
-
-static int __init libcrc32c_mod_init(void)
-{
-	tfm = crypto_alloc_shash("crc32c", 0, 0);
-	return PTR_ERR_OR_ZERO(tfm);
-}
-
-static void __exit libcrc32c_mod_fini(void)
-{
-	crypto_free_shash(tfm);
-}
-
-module_init(libcrc32c_mod_init);
-module_exit(libcrc32c_mod_fini);
-
-MODULE_AUTHOR("Clay Haapala <chaapala@cisco.com>");
-MODULE_DESCRIPTION("CRC32c (Castagnoli) calculations");
-MODULE_LICENSE("GPL");
-MODULE_SOFTDEP("pre: crc32c");
-- 
2.47.1


