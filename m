Return-Path: <linux-arch+bounces-9215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81549DF83C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A45B22D23
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA01DB940;
	Mon,  2 Dec 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRNBoGCI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5EE76C61;
	Mon,  2 Dec 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101779; cv=none; b=XzLygYXt1ZvyfCfMyajWeDZ7gkcVBK4aOAca2C6a1KZDPVlZ3OW0Up6VaY3JECJxPigRHbs3fcOQD6X3Uzhpte73tOGdJTC2+K0my/6RunbmEQH/FPhBFyKDlo4QGIZ0soZ3Qe3sh/BVZ2BCACqM+oAItpqPTsqWb9usScbBxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101779; c=relaxed/simple;
	bh=PP2VQoP2EFijtyRoI44vRPGiZLDX36MUSncHwQvCv1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2rUMo6yob3nL9DwhqK78qCjQyi687fHyr8opKSzigsFbEv+jdHz9oHoLb/Cv4bDsEkesF5xaFmGRABBpmuDs06/ypDGINhIEAiExoV+kuEtRnoGSU0Ggwjj0cQ5/dohxXIjyUxQANtLs4l4wJtoq5enRK/xOr/whtoKoZd92HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRNBoGCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67777C4CED2;
	Mon,  2 Dec 2024 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733101778;
	bh=PP2VQoP2EFijtyRoI44vRPGiZLDX36MUSncHwQvCv1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRNBoGCIdmEvP2LAV9aWBOCE0RqRjoWRrZ+2pl/cgwyMG5vcj4ZuepINC3xC23PNF
	 TBeWWldGhWTEM9u2MN8vRuu82YxTCOmQkrMU5peDRfWyhTFYZE3wQ1Urlk6EofBZHp
	 s3UvN5XsBKV4ojBFGtnC4qSzxfRnrd8M/yPXNsmahCS0WWJ9o8qVjbOV81ZFQtYVsj
	 k9mN08Cz4bVHPfB4d0BHFdo/2/puo9xkszBMSSO7qc7nqwl5SSjCZtbmP85+lA+72Z
	 GOIEZwjftOrCVphym/y+1ftYXnre5El8IzQkuJVahwcqYxNkjTxvkFbkg8Z5jlPbqX
	 Ampooa4Yx32Ow==
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
	Ard Biesheuvel <ardb@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v4 17/19] jbd2: switch to using the crc32c library
Date: Sun,  1 Dec 2024 17:08:42 -0800
Message-ID: <20241202010844.144356-18-ebiggers@kernel.org>
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

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32c().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/jbd2/Kconfig      |  2 --
 fs/jbd2/journal.c    | 30 +++---------------------------
 include/linux/jbd2.h | 33 +++------------------------------
 3 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/fs/jbd2/Kconfig b/fs/jbd2/Kconfig
index 4ad2c67f93f1..9c19e1512101 100644
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
index 7e49d912b091..d8084b31b361 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1367,24 +1367,16 @@ static int journal_check_superblock(journal_t *journal)
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
@@ -1606,12 +1598,10 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
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
@@ -2189,12 +2179,10 @@ int jbd2_journal_destroy(journal_t *journal)
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
@@ -2335,31 +2323,19 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
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
-		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
-						   sizeof(sb->s_uuid));
-	}
-
 	lock_buffer(journal->j_sb_buffer);
 
-	/* If enabling v3 checksums, update superblock */
+	/* If enabling v3 checksums, update superblock and precompute seed */
 	if (INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
 		sb->s_checksum_type = JBD2_CRC32C_CHKSUM;
 		sb->s_feature_compat &=
 			~cpu_to_be32(JBD2_FEATURE_COMPAT_CHECKSUM);
+		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
+						   sizeof(sb->s_uuid));
 	}
 
 	/* If enabling v1 checksums, downgrade superblock */
 	if (COMPAT_FEATURE_ON(JBD2_FEATURE_COMPAT_CHECKSUM))
 		sb->s_feature_incompat &=
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 50f7ea8714bf..561025b4f3d9 100644
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
@@ -1788,31 +1778,14 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 #define BJ_Forget	2	/* Buffer superseded by this transaction */
 #define BJ_Shadow	3	/* Buffer contents being shadowed to the log */
 #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
 #define BJ_Types	5
 
-/* JBD uses a CRC32 checksum */
-#define JBD_MAX_CHECKSUM_SIZE 4
-
 static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
 			      const void *address, unsigned int length)
 {
-	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
-		DIV_ROUND_UP(JBD_MAX_CHECKSUM_SIZE,
-			     sizeof(*((struct shash_desc *)0)->__ctx)));
-	int err;
-
-	BUG_ON(crypto_shash_descsize(journal->j_chksum_driver) >
-		JBD_MAX_CHECKSUM_SIZE);
-
-	desc->tfm = journal->j_chksum_driver;
-	*(u32 *)desc->__ctx = crc;
-
-	err = crypto_shash_update(desc, address, length);
-	BUG_ON(err);
-
-	return *(u32 *)desc->__ctx;
+	return crc32c(crc, address, length);
 }
 
 /* Return most recent uncommitted transaction */
 static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 {
-- 
2.47.1


