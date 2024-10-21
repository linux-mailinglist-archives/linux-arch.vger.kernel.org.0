Return-Path: <linux-arch+bounces-8324-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508D9A5825
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 02:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BEB2202D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3311474B2;
	Mon, 21 Oct 2024 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdOAy7Sh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12E7145A18;
	Mon, 21 Oct 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729470599; cv=none; b=mMkrRnAjMsiGrlHxsfGZlmJht7cZxV82vyzxVjsmX5cExMiOnVLiFDcV9GgPFWBP92MyTPxdREIuPDtyMPmW1sXnnTCudjGpb0xK3sgKfFtCnOAs6azQ6+U0gl2HRjBLFJBwD6XuVleNsfe9fVNQRYsaYygPTuQeZy/inITs5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729470599; c=relaxed/simple;
	bh=4QrNTfxk1O5mqgXso3Uq4Yh9fW2+aliDT+yU3NaRHjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlXwDqVSOQj6KeLS3PClx8VbJx4jg/6Mwvl+b18+FR4/6K8fEFzXj0w4C5pcvutSnu0kfjl0fHX9K4Rwm/FrWhCGFvT/RMO6DdMvlZYLyQpnOzn0UOmqsm7F6sjaRcXY4RQlAJTZW37/Lxo536uT89dmwcP5n6JOz8sxU91wb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdOAy7Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061F5C4CEC7;
	Mon, 21 Oct 2024 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729470598;
	bh=4QrNTfxk1O5mqgXso3Uq4Yh9fW2+aliDT+yU3NaRHjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdOAy7ShO/AIu2M7e2/271mIPF14WPY1XGHVgfMkByCmqKJXATBSNW69jUcXasSIz
	 6Oim46eD9B5dTBWt6nmgyPg4UMAVXuJsLkLL+lNyLjytgzlCpr3IPjkMy1DF6VXbar
	 8EVzZ0DEKZjdRjWlu3y1BaS5OTSPA+DBPd/1Asf81CkRl4d93oeP0JqzLo4nbyKgju
	 kvA4UB7p6kTLItgXAtWMSY3Dx+Sx3wdf7P779SJHNOVnq9iLuJxD3w2UJzHd7JnH/s
	 Vsuq5JUbm9HNa0fHQQMHG2fJnZeTF+dB1XXhRygSUbwAeBQzflon+jFnPmh8rCiWoX
	 mGjddyhl8fmVA==
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
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 14/15] jbd2: switch to using the crc32c library
Date: Sun, 20 Oct 2024 17:29:34 -0700
Message-ID: <20241021002935.325878-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021002935.325878-1-ebiggers@kernel.org>
References: <20241021002935.325878-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32c().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/jbd2/Kconfig      |  2 --
 fs/jbd2/journal.c    | 25 ++-----------------------
 include/linux/jbd2.h | 31 +++----------------------------
 3 files changed, 5 insertions(+), 53 deletions(-)

diff --git a/fs/jbd2/Kconfig b/fs/jbd2/Kconfig
index 4ad2c67f93f15..9c19e1512101e 100644
--- a/fs/jbd2/Kconfig
+++ b/fs/jbd2/Kconfig
@@ -1,11 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config JBD2
 	tristate
 	select CRC32
-	select CRYPTO
-	select CRYPTO_CRC32C
 	help
 	  This is a generic journaling layer for block devices that support
 	  both 32-bit and 64-bit block numbers.  It is currently used by
 	  the ext4 and OCFS2 filesystems, but it could also be used to add
 	  journal support to other file systems or block devices such
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fcf..56cea5a738a70 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1373,24 +1373,16 @@ static int journal_check_superblock(journal_t *journal)
 		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
 		       "at the same time!\n");
 		return err;
 	}
 
-	/* Load the checksum driver */
 	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
 		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
 			printk(KERN_ERR "JBD2: Unknown checksum type\n");
 			return err;
 		}
 
-		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
-		if (IS_ERR(journal->j_chksum_driver)) {
-			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
-			err = PTR_ERR(journal->j_chksum_driver);
-			journal->j_chksum_driver = NULL;
-			return err;
-		}
 		/* Check superblock checksum */
 		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
 			printk(KERN_ERR "JBD2: journal checksum error\n");
 			err = -EFSBADCRC;
 			return err;
@@ -1611,12 +1603,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 	return journal;
 
 err_cleanup:
 	percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-	if (journal->j_chksum_driver)
-		crypto_free_shash(journal->j_chksum_driver);
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	journal_fail_superblock(journal);
 	kfree(journal);
 	return ERR_PTR(err);
@@ -2194,12 +2184,10 @@ int jbd2_journal_destroy(journal_t *journal)
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
 	iput(journal->j_inode);
 	if (journal->j_revoke)
 		jbd2_journal_destroy_revoke(journal);
-	if (journal->j_chksum_driver)
-		crypto_free_shash(journal->j_chksum_driver);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
 	return err;
@@ -2340,23 +2328,14 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 			pr_err("JBD2: Cannot enable fast commits.\n");
 			return 0;
 		}
 	}
 
-	/* Load the checksum driver if necessary */
-	if ((journal->j_chksum_driver == NULL) &&
-	    INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
-		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
-		if (IS_ERR(journal->j_chksum_driver)) {
-			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
-			journal->j_chksum_driver = NULL;
-			return 0;
-		}
-		/* Precompute checksum seed for all metadata */
+	/* Precompute checksum seed for all metadata */
+	if (INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3))
 		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
 						   sizeof(sb->s_uuid));
-	}
 
 	lock_buffer(journal->j_sb_buffer);
 
 	/* If enabling v3 checksums, update superblock */
 	if (INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad573..33d25a3d15f14 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -26,11 +26,11 @@
 #include <linux/mutex.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/bit_spinlock.h>
 #include <linux/blkdev.h>
-#include <crypto/hash.h>
+#include <linux/crc32c.h>
 #endif
 
 #define journal_oom_retry 1
 
 /*
@@ -1239,17 +1239,10 @@ struct journal_s
 	 * An opaque pointer to fs-private information.  ext3 puts its
 	 * superblock pointer here.
 	 */
 	void *j_private;
 
-	/**
-	 * @j_chksum_driver:
-	 *
-	 * Reference to checksum algorithm driver via cryptoapi.
-	 */
-	struct crypto_shash *j_chksum_driver;
-
 	/**
 	 * @j_csum_seed:
 	 *
 	 * Precomputed journal UUID checksum for seeding other checksums.
 	 */
@@ -1748,14 +1741,11 @@ static inline bool jbd2_journal_has_csum_v2or3_feature(journal_t *j)
 	return jbd2_has_feature_csum2(j) || jbd2_has_feature_csum3(j);
 }
 
 static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 {
-	WARN_ON_ONCE(jbd2_journal_has_csum_v2or3_feature(journal) &&
-		     journal->j_chksum_driver == NULL);
-
-	return journal->j_chksum_driver != NULL;
+	return jbd2_journal_has_csum_v2or3_feature(journal);
 }
 
 static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
 {
 	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);
@@ -1794,26 +1784,11 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 #define JBD_MAX_CHECKSUM_SIZE 4
 
 static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
 			      const void *address, unsigned int length)
 {
-	struct {
-		struct shash_desc shash;
-		char ctx[JBD_MAX_CHECKSUM_SIZE];
-	} desc;
-	int err;
-
-	BUG_ON(crypto_shash_descsize(journal->j_chksum_driver) >
-		JBD_MAX_CHECKSUM_SIZE);
-
-	desc.shash.tfm = journal->j_chksum_driver;
-	*(u32 *)desc.ctx = crc;
-
-	err = crypto_shash_update(&desc.shash, address, length);
-	BUG_ON(err);
-
-	return *(u32 *)desc.ctx;
+	return crc32c(crc, address, length);
 }
 
 /* Return most recent uncommitted transaction */
 static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 {
-- 
2.47.0


