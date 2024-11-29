Return-Path: <linux-arch+bounces-9114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BB9D018B
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED2C1F22A0C
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5B8F7D;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhgzJPj7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C88F54;
	Sun, 17 Nov 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803034; cv=none; b=Xfvm6PeSXCkoIj4giui6l5ScnQEd/8T2d1Qv6kXDPKtz5Pvo+6GuIJOPS3/QmKfwAR8q2Yatnm9njiqBlIgpNGJmWLpvPQMpqOpRPFUAuZs8GKGXW6g2jYglY6RY8J9NglT2n0dkkdU7UL3AvUNcIRzP25gfn4TOBwxwhdSfZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803034; c=relaxed/simple;
	bh=CGWQhKW6ZnmQfEVvqvVPnQBpPTN+czhYXoOYIavQbgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtDE2fMHuawHmosphlMmu/e634SzK3Guj+JjD5+IAgfh50hHFQEyQ45ymBtg4XMCMe/Tg79HRfa901b+rpBt08OV78Hh23UFClFU+51sIApME09YmeBjAfy7MLdeTmqQ3CVPlzZi8ONmX04FE+bnJKlAwOFjie9CD2IbvtB00+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhgzJPj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBDEC4CED2;
	Sun, 17 Nov 2024 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803034;
	bh=CGWQhKW6ZnmQfEVvqvVPnQBpPTN+czhYXoOYIavQbgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhgzJPj7UB/alJuoFhQJmwXTMxqt2eknRRtihGE/xoxv2b/JH2zQE8dmAU13HCmGS
	 dHRai3+caX8aDZZYf76elLUQaAvsj4pIqA3r4c1rdaE3oY4DJcoLm5CZEF/7zJCyF6
	 5cHb0Axa5Px1IXxjLOK+xmjtN7mgLDW0Lrj2KuWCdzuUGZb9sCie0CVu2bM+/YPEPI
	 cuZ8cs6Nxs4hsYqOm114xzK7KxH3Spbbdt1HXLerQX5S+1nEoMNQIt6EwnWtM6oJGs
	 zGKyhA+ezxhensu8Ym4OW/JSQ1prRxqvsC/l0m+8CUPN2O5UTe067T1bact+o1wav9
	 fKkqmFy8ZShNA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 01/11] lib/crc-t10dif: stop wrapping the crypto API
Date: Sat, 16 Nov 2024 16:22:34 -0800
Message-ID: <20241117002244.105200-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

In preparation for making the CRC-T10DIF library optimized for each
architecture, like what has been done for CRC32, get rid of the weird
layering where crc_t10dif_update() calls into the crypto API.  Instead,
move crc_t10dif_generic() into the crc-t10dif library module, and make
crc_t10dif_update() just call crc_t10dif_generic().  Acceleration will
be reintroduced via crc_t10dif_arch() in the following patches.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig             |   1 +
 crypto/Makefile            |   2 +-
 crypto/crct10dif_common.c  |  82 -------------------
 include/linux/crc-t10dif.h |  16 ++--
 lib/Kconfig                |   2 -
 lib/crc-t10dif.c           | 156 +++++++++++--------------------------
 6 files changed, 58 insertions(+), 201 deletions(-)
 delete mode 100644 crypto/crct10dif_common.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a779cab668c2..b3bf7800dd94 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1099,10 +1099,11 @@ config CRYPTO_CRC32
 	  Used by RoCEv2 and f2fs.
 
 config CRYPTO_CRCT10DIF
 	tristate "CRCT10DIF"
 	select CRYPTO_HASH
+	select CRC_T10DIF
 	help
 	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
 
 	  CRC algorithm used by the SCSI Block Commands standard.
 
diff --git a/crypto/Makefile b/crypto/Makefile
index a1ce3fa5298d..e948a883f151 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -152,11 +152,11 @@ obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
 obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32_generic.o
 CFLAGS_crc32c_generic.o += -DARCH=$(ARCH)
 CFLAGS_crc32_generic.o += -DARCH=$(ARCH)
-obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_common.o crct10dif_generic.o
+obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_generic.o
 obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) += lz4.o
 obj-$(CONFIG_CRYPTO_LZ4HC) += lz4hc.o
diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
deleted file mode 100644
index b2fab366f518..000000000000
--- a/crypto/crct10dif_common.c
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * Cryptographic API.
- *
- * T10 Data Integrity Field CRC16 Crypto Transform
- *
- * Copyright (c) 2007 Oracle Corporation.  All rights reserved.
- * Written by Martin K. Petersen <martin.petersen@oracle.com>
- * Copyright (C) 2013 Intel Corporation
- * Author: Tim Chen <tim.c.chen@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
- */
-
-#include <linux/crc-t10dif.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-/* Table generated using the following polynomium:
- * x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
- * gt: 0x8bb7
- */
-static const __u16 t10_dif_crc_table[256] = {
-	0x0000, 0x8BB7, 0x9CD9, 0x176E, 0xB205, 0x39B2, 0x2EDC, 0xA56B,
-	0xEFBD, 0x640A, 0x7364, 0xF8D3, 0x5DB8, 0xD60F, 0xC161, 0x4AD6,
-	0x54CD, 0xDF7A, 0xC814, 0x43A3, 0xE6C8, 0x6D7F, 0x7A11, 0xF1A6,
-	0xBB70, 0x30C7, 0x27A9, 0xAC1E, 0x0975, 0x82C2, 0x95AC, 0x1E1B,
-	0xA99A, 0x222D, 0x3543, 0xBEF4, 0x1B9F, 0x9028, 0x8746, 0x0CF1,
-	0x4627, 0xCD90, 0xDAFE, 0x5149, 0xF422, 0x7F95, 0x68FB, 0xE34C,
-	0xFD57, 0x76E0, 0x618E, 0xEA39, 0x4F52, 0xC4E5, 0xD38B, 0x583C,
-	0x12EA, 0x995D, 0x8E33, 0x0584, 0xA0EF, 0x2B58, 0x3C36, 0xB781,
-	0xD883, 0x5334, 0x445A, 0xCFED, 0x6A86, 0xE131, 0xF65F, 0x7DE8,
-	0x373E, 0xBC89, 0xABE7, 0x2050, 0x853B, 0x0E8C, 0x19E2, 0x9255,
-	0x8C4E, 0x07F9, 0x1097, 0x9B20, 0x3E4B, 0xB5FC, 0xA292, 0x2925,
-	0x63F3, 0xE844, 0xFF2A, 0x749D, 0xD1F6, 0x5A41, 0x4D2F, 0xC698,
-	0x7119, 0xFAAE, 0xEDC0, 0x6677, 0xC31C, 0x48AB, 0x5FC5, 0xD472,
-	0x9EA4, 0x1513, 0x027D, 0x89CA, 0x2CA1, 0xA716, 0xB078, 0x3BCF,
-	0x25D4, 0xAE63, 0xB90D, 0x32BA, 0x97D1, 0x1C66, 0x0B08, 0x80BF,
-	0xCA69, 0x41DE, 0x56B0, 0xDD07, 0x786C, 0xF3DB, 0xE4B5, 0x6F02,
-	0x3AB1, 0xB106, 0xA668, 0x2DDF, 0x88B4, 0x0303, 0x146D, 0x9FDA,
-	0xD50C, 0x5EBB, 0x49D5, 0xC262, 0x6709, 0xECBE, 0xFBD0, 0x7067,
-	0x6E7C, 0xE5CB, 0xF2A5, 0x7912, 0xDC79, 0x57CE, 0x40A0, 0xCB17,
-	0x81C1, 0x0A76, 0x1D18, 0x96AF, 0x33C4, 0xB873, 0xAF1D, 0x24AA,
-	0x932B, 0x189C, 0x0FF2, 0x8445, 0x212E, 0xAA99, 0xBDF7, 0x3640,
-	0x7C96, 0xF721, 0xE04F, 0x6BF8, 0xCE93, 0x4524, 0x524A, 0xD9FD,
-	0xC7E6, 0x4C51, 0x5B3F, 0xD088, 0x75E3, 0xFE54, 0xE93A, 0x628D,
-	0x285B, 0xA3EC, 0xB482, 0x3F35, 0x9A5E, 0x11E9, 0x0687, 0x8D30,
-	0xE232, 0x6985, 0x7EEB, 0xF55C, 0x5037, 0xDB80, 0xCCEE, 0x4759,
-	0x0D8F, 0x8638, 0x9156, 0x1AE1, 0xBF8A, 0x343D, 0x2353, 0xA8E4,
-	0xB6FF, 0x3D48, 0x2A26, 0xA191, 0x04FA, 0x8F4D, 0x9823, 0x1394,
-	0x5942, 0xD2F5, 0xC59B, 0x4E2C, 0xEB47, 0x60F0, 0x779E, 0xFC29,
-	0x4BA8, 0xC01F, 0xD771, 0x5CC6, 0xF9AD, 0x721A, 0x6574, 0xEEC3,
-	0xA415, 0x2FA2, 0x38CC, 0xB37B, 0x1610, 0x9DA7, 0x8AC9, 0x017E,
-	0x1F65, 0x94D2, 0x83BC, 0x080B, 0xAD60, 0x26D7, 0x31B9, 0xBA0E,
-	0xF0D8, 0x7B6F, 0x6C01, 0xE7B6, 0x42DD, 0xC96A, 0xDE04, 0x55B3
-};
-
-__u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer, size_t len)
-{
-	unsigned int i;
-
-	for (i = 0 ; i < len ; i++)
-		crc = (crc << 8) ^ t10_dif_crc_table[((crc >> 8) ^ buffer[i]) & 0xff];
-
-	return crc;
-}
-EXPORT_SYMBOL(crc_t10dif_generic);
-
-MODULE_DESCRIPTION("T10 DIF CRC calculation common code");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/crc-t10dif.h b/include/linux/crc-t10dif.h
index 6bb0c0bf357b..206ba2305483 100644
--- a/include/linux/crc-t10dif.h
+++ b/include/linux/crc-t10dif.h
@@ -4,13 +4,19 @@
 
 #include <linux/types.h>
 
 #define CRC_T10DIF_DIGEST_SIZE 2
 #define CRC_T10DIF_BLOCK_SIZE 1
-#define CRC_T10DIF_STRING "crct10dif"
 
-extern __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer,
-				size_t len);
-extern __u16 crc_t10dif(unsigned char const *, size_t);
-extern __u16 crc_t10dif_update(__u16 crc, unsigned char const *, size_t);
+u16 crc_t10dif_generic(u16 crc, const u8 *p, size_t len);
+
+static inline u16 crc_t10dif_update(u16 crc, const u8 *p, size_t len)
+{
+	return crc_t10dif_generic(crc, p, len);
+}
+
+static inline u16 crc_t10dif(const u8 *p, size_t len)
+{
+	return crc_t10dif_update(0, p, len);
+}
 
 #endif
diff --git a/lib/Kconfig b/lib/Kconfig
index b894ee64ff95..eb6c7a023be9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -142,12 +142,10 @@ config CRC16
 	  the kernel tree does. Such modules that use library CRC16
 	  functions require M here.
 
 config CRC_T10DIF
 	tristate "CRC calculation for the T10 Data Integrity Field"
-	select CRYPTO
-	select CRYPTO_CRCT10DIF
 	help
 	  This option is only needed if a module that's not in the
 	  kernel tree needs to calculate CRC checks for use with the
 	  SCSI data integrity subsystem.
 
diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 1ed2ed487097..311c2ab829f1 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -7,125 +7,59 @@
  */
 
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/crc-t10dif.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <crypto/hash.h>
-#include <crypto/algapi.h>
-#include <linux/static_key.h>
-#include <linux/notifier.h>
 
-static struct crypto_shash __rcu *crct10dif_tfm;
-static DEFINE_STATIC_KEY_TRUE(crct10dif_fallback);
-static DEFINE_MUTEX(crc_t10dif_mutex);
-static struct work_struct crct10dif_rehash_work;
-
-static int crc_t10dif_notify(struct notifier_block *self, unsigned long val, void *data)
-{
-	struct crypto_alg *alg = data;
-
-	if (val != CRYPTO_MSG_ALG_LOADED ||
-	    strcmp(alg->cra_name, CRC_T10DIF_STRING))
-		return NOTIFY_DONE;
-
-	schedule_work(&crct10dif_rehash_work);
-	return NOTIFY_OK;
-}
-
-static void crc_t10dif_rehash(struct work_struct *work)
-{
-	struct crypto_shash *new, *old;
-
-	mutex_lock(&crc_t10dif_mutex);
-	old = rcu_dereference_protected(crct10dif_tfm,
-					lockdep_is_held(&crc_t10dif_mutex));
-	new = crypto_alloc_shash(CRC_T10DIF_STRING, 0, 0);
-	if (IS_ERR(new)) {
-		mutex_unlock(&crc_t10dif_mutex);
-		return;
-	}
-	rcu_assign_pointer(crct10dif_tfm, new);
-	mutex_unlock(&crc_t10dif_mutex);
-
-	if (old) {
-		synchronize_rcu();
-		crypto_free_shash(old);
-	} else {
-		static_branch_disable(&crct10dif_fallback);
-	}
-}
-
-static struct notifier_block crc_t10dif_nb = {
-	.notifier_call = crc_t10dif_notify,
+/*
+ * Table generated using the following polynomial:
+ * x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
+ * gt: 0x8bb7
+ */
+static const u16 t10_dif_crc_table[256] = {
+	0x0000, 0x8BB7, 0x9CD9, 0x176E, 0xB205, 0x39B2, 0x2EDC, 0xA56B,
+	0xEFBD, 0x640A, 0x7364, 0xF8D3, 0x5DB8, 0xD60F, 0xC161, 0x4AD6,
+	0x54CD, 0xDF7A, 0xC814, 0x43A3, 0xE6C8, 0x6D7F, 0x7A11, 0xF1A6,
+	0xBB70, 0x30C7, 0x27A9, 0xAC1E, 0x0975, 0x82C2, 0x95AC, 0x1E1B,
+	0xA99A, 0x222D, 0x3543, 0xBEF4, 0x1B9F, 0x9028, 0x8746, 0x0CF1,
+	0x4627, 0xCD90, 0xDAFE, 0x5149, 0xF422, 0x7F95, 0x68FB, 0xE34C,
+	0xFD57, 0x76E0, 0x618E, 0xEA39, 0x4F52, 0xC4E5, 0xD38B, 0x583C,
+	0x12EA, 0x995D, 0x8E33, 0x0584, 0xA0EF, 0x2B58, 0x3C36, 0xB781,
+	0xD883, 0x5334, 0x445A, 0xCFED, 0x6A86, 0xE131, 0xF65F, 0x7DE8,
+	0x373E, 0xBC89, 0xABE7, 0x2050, 0x853B, 0x0E8C, 0x19E2, 0x9255,
+	0x8C4E, 0x07F9, 0x1097, 0x9B20, 0x3E4B, 0xB5FC, 0xA292, 0x2925,
+	0x63F3, 0xE844, 0xFF2A, 0x749D, 0xD1F6, 0x5A41, 0x4D2F, 0xC698,
+	0x7119, 0xFAAE, 0xEDC0, 0x6677, 0xC31C, 0x48AB, 0x5FC5, 0xD472,
+	0x9EA4, 0x1513, 0x027D, 0x89CA, 0x2CA1, 0xA716, 0xB078, 0x3BCF,
+	0x25D4, 0xAE63, 0xB90D, 0x32BA, 0x97D1, 0x1C66, 0x0B08, 0x80BF,
+	0xCA69, 0x41DE, 0x56B0, 0xDD07, 0x786C, 0xF3DB, 0xE4B5, 0x6F02,
+	0x3AB1, 0xB106, 0xA668, 0x2DDF, 0x88B4, 0x0303, 0x146D, 0x9FDA,
+	0xD50C, 0x5EBB, 0x49D5, 0xC262, 0x6709, 0xECBE, 0xFBD0, 0x7067,
+	0x6E7C, 0xE5CB, 0xF2A5, 0x7912, 0xDC79, 0x57CE, 0x40A0, 0xCB17,
+	0x81C1, 0x0A76, 0x1D18, 0x96AF, 0x33C4, 0xB873, 0xAF1D, 0x24AA,
+	0x932B, 0x189C, 0x0FF2, 0x8445, 0x212E, 0xAA99, 0xBDF7, 0x3640,
+	0x7C96, 0xF721, 0xE04F, 0x6BF8, 0xCE93, 0x4524, 0x524A, 0xD9FD,
+	0xC7E6, 0x4C51, 0x5B3F, 0xD088, 0x75E3, 0xFE54, 0xE93A, 0x628D,
+	0x285B, 0xA3EC, 0xB482, 0x3F35, 0x9A5E, 0x11E9, 0x0687, 0x8D30,
+	0xE232, 0x6985, 0x7EEB, 0xF55C, 0x5037, 0xDB80, 0xCCEE, 0x4759,
+	0x0D8F, 0x8638, 0x9156, 0x1AE1, 0xBF8A, 0x343D, 0x2353, 0xA8E4,
+	0xB6FF, 0x3D48, 0x2A26, 0xA191, 0x04FA, 0x8F4D, 0x9823, 0x1394,
+	0x5942, 0xD2F5, 0xC59B, 0x4E2C, 0xEB47, 0x60F0, 0x779E, 0xFC29,
+	0x4BA8, 0xC01F, 0xD771, 0x5CC6, 0xF9AD, 0x721A, 0x6574, 0xEEC3,
+	0xA415, 0x2FA2, 0x38CC, 0xB37B, 0x1610, 0x9DA7, 0x8AC9, 0x017E,
+	0x1F65, 0x94D2, 0x83BC, 0x080B, 0xAD60, 0x26D7, 0x31B9, 0xBA0E,
+	0xF0D8, 0x7B6F, 0x6C01, 0xE7B6, 0x42DD, 0xC96A, 0xDE04, 0x55B3
 };
 
-__u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
-{
-	struct {
-		struct shash_desc shash;
-		__u16 crc;
-	} desc;
-	int err;
-
-	if (static_branch_unlikely(&crct10dif_fallback))
-		return crc_t10dif_generic(crc, buffer, len);
-
-	rcu_read_lock();
-	desc.shash.tfm = rcu_dereference(crct10dif_tfm);
-	desc.crc = crc;
-	err = crypto_shash_update(&desc.shash, buffer, len);
-	rcu_read_unlock();
-
-	BUG_ON(err);
-
-	return desc.crc;
-}
-EXPORT_SYMBOL(crc_t10dif_update);
-
-__u16 crc_t10dif(const unsigned char *buffer, size_t len)
-{
-	return crc_t10dif_update(0, buffer, len);
-}
-EXPORT_SYMBOL(crc_t10dif);
-
-static int __init crc_t10dif_mod_init(void)
-{
-	INIT_WORK(&crct10dif_rehash_work, crc_t10dif_rehash);
-	crypto_register_notifier(&crc_t10dif_nb);
-	crc_t10dif_rehash(&crct10dif_rehash_work);
-	return 0;
-}
-
-static void __exit crc_t10dif_mod_fini(void)
-{
-	crypto_unregister_notifier(&crc_t10dif_nb);
-	cancel_work_sync(&crct10dif_rehash_work);
-	crypto_free_shash(rcu_dereference_protected(crct10dif_tfm, 1));
-}
-
-module_init(crc_t10dif_mod_init);
-module_exit(crc_t10dif_mod_fini);
-
-static int crc_t10dif_transform_show(char *buffer, const struct kernel_param *kp)
+u16 crc_t10dif_generic(u16 crc, const u8 *p, size_t len)
 {
-	struct crypto_shash *tfm;
-	int len;
+	size_t i;
 
-	if (static_branch_unlikely(&crct10dif_fallback))
-		return sprintf(buffer, "fallback\n");
+	for (i = 0; i < len; i++)
+		crc = (crc << 8) ^ t10_dif_crc_table[(crc >> 8) ^ p[i]];
 
-	rcu_read_lock();
-	tfm = rcu_dereference(crct10dif_tfm);
-	len = snprintf(buffer, PAGE_SIZE, "%s\n",
-		       crypto_shash_driver_name(tfm));
-	rcu_read_unlock();
-
-	return len;
+	return crc;
 }
+EXPORT_SYMBOL(crc_t10dif_generic);
 
-module_param_call(transform, NULL, crc_t10dif_transform_show, NULL, 0444);
-
-MODULE_DESCRIPTION("T10 DIF CRC calculation (library API)");
+MODULE_DESCRIPTION("T10 DIF CRC calculation");
 MODULE_LICENSE("GPL");
-MODULE_SOFTDEP("pre: crct10dif");
-- 
2.47.0


