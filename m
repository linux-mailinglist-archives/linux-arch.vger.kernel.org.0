Return-Path: <linux-arch+bounces-8567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C19B0EA4
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569EC1C218BC
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1221B87B;
	Fri, 25 Oct 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzLmD7tt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11221B867;
	Fri, 25 Oct 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883752; cv=none; b=pdQ5XWsIrpfggLq3JgHRwB2EwRk0djTE8gSZ3/AW2MLleKLvxNt4sus39w4dKXjKJ6PdN7z0hgiATU2t2gtjlI2dO+9wRHpH2SVeTLTwQ8DTyhPUaTIlXEHiB5TCzc+TZeIMmP1y5epuwKyiTL4/xdvcBJg1LKx1KutIYUMkfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883752; c=relaxed/simple;
	bh=hmjPSLT23tUvD2mhqpKoKr7fMC5StQtNq+9niGNg1xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQsGpVHJOJKHnvMfqHQzYSUEch9HwSLCD+1rrNDNjdDv7GXoj4tSdYFEl7A3Y5i2Wal8QBJklZ88zX/iAp7QCY3dv8M1ao9mS//DLyf3z94UmDvoEzF2G6WTfZzCX7zB31ZfmBQwCin46Rx+m1wZX+K5NpqhLHYvnRn5BvNSBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzLmD7tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C0FC4CEE6;
	Fri, 25 Oct 2024 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883752;
	bh=hmjPSLT23tUvD2mhqpKoKr7fMC5StQtNq+9niGNg1xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzLmD7ttenyc+h9adVW5j/4jD+Z5Z8P0K29t1D9dfAOxvrlJPCCHoSOV4RyYU7mc4
	 WbPsgIhtjxpkV+XG3nPg3insOC4hRyvrAtB+xHeMx/2sv8+LDxRpRsk16Im+FD7OHK
	 nUnqYMuKmUS5CAgLS0hmC8rxRCvAFFRQE3a9LQ6mraoZfPE6Wrh/e4XBMcuOck8H93
	 z3X/p9oxCzXfkf5TfKY2NnJPejTnokSSKn6ncqoMBQtIfZhYm21QYTDKYkDSTcMGhO
	 Gis9vIIku/f91IqjUzCIoNWZERD7YQMDSWiIIopXXMdNYw+rvaAmqN5dCLvacPtihK
	 pwFvIaZg4X8kg==
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
Subject: [PATCH v2 14/18] lib/crc32: make crc32c() go directly to lib
Date: Fri, 25 Oct 2024 12:14:50 -0700
Message-ID: <20241025191454.72616-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025191454.72616-1-ebiggers@kernel.org>
References: <20241025191454.72616-1-ebiggers@kernel.org>
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
index 07afcf214f35..b894ee64ff95 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -296,18 +296,14 @@ config CRC7
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
index 773adf88af41..15646679aee2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -161,11 +161,10 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
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
2.47.0


