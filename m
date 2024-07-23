Return-Path: <linux-arch+bounces-5588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12C4939CCE
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D7628239D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89014EC66;
	Tue, 23 Jul 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N70Hycgd"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7A14D2AB
	for <linux-arch@vger.kernel.org>; Tue, 23 Jul 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723608; cv=none; b=RZw6072RaAnATRRF5iPFm1HWxX/tukkVN0pKOPWmi1f7Otnl2sgiqaD+WruImCOO806IIkb3doTvjpEb9e4tUnvrzXuLFZg/Qgq5+LOKGZ1A2v7m1t/AJiLZ8WXSjrWnOQhiKHTTLtutvgOcpb9gHsIFDDQroYs+S/J/8C7D+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723608; c=relaxed/simple;
	bh=8qpU8QvLN6vXVX/x53G5eEe50VLRRBnIA+358suYNzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hP8Vof/SwnlHU5ZcAnZ2TvLOHIEDT/iDyA5RP8tzJ9Qih+OJOemoFDoVUMTQ5/xDGTIRNeb/2lZ6/FaYKEJYWzHFqO1M9/dlAxN6PFw7B37bppdb8PzHYVQhPPfZebHXi09CcCIVkL0PxTuqXmwEAELWy4gFhUMto/OXON6hqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N70Hycgd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: arnd@arndb.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721723604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cje3Y5ms0q2wZZ3qNUkIwaPZ+RsvLH8H4iju91pzTbQ=;
	b=N70HycgdIR3ibRzffZLSSKoDwX0DMnfVNAP+94kP0Xckzmrh1ehHKiU2DX7lqmSsF2JTQ5
	aW8Lczzik40cmq6WMH0uY9KDoAMZ73kYcxd03FbPixjXXddnWVkoK9zAL6DSsO07vAiecE
	XydOC3tGCZiWKDPxNjOO63qsWY0TBFg=
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: hch@infradead.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-modules@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 4/4] f2fs: Use module_{subinit, subeixt} helper macros
Date: Tue, 23 Jul 2024 16:32:39 +0800
Message-Id: <20240723083239.41533-5-youling.tang@linux.dev>
In-Reply-To: <20240723083239.41533-1-youling.tang@linux.dev>
References: <20240723083239.41533-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Use module_{subinit, subinit} to ensure that modules init and exit
are in sequence and to simplify the code.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/f2fs/debug.c |   3 +-
 fs/f2fs/f2fs.h  |   4 +-
 fs/f2fs/super.c | 139 +++++++++++-------------------------------------
 3 files changed, 36 insertions(+), 110 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8b0e1e71b667..c08ecf807066 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -727,7 +727,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi)
 	kfree(si);
 }
 
-void __init f2fs_create_root_stats(void)
+int __init f2fs_create_root_stats(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	f2fs_debugfs_root = debugfs_create_dir("f2fs", NULL);
@@ -735,6 +735,7 @@ void __init f2fs_create_root_stats(void)
 	debugfs_create_file("status", 0444, f2fs_debugfs_root, NULL,
 			    &stat_fops);
 #endif
+	return 0;
 }
 
 void f2fs_destroy_root_stats(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8a9d910aa552..b2909383bcd9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4100,7 +4100,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi);
 void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
-void __init f2fs_create_root_stats(void);
+int __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
@@ -4142,7 +4142,7 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 
 static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
-static inline void __init f2fs_create_root_stats(void) { }
+static inline int __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
 static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df4cf31f93df..162ec1005b22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4940,120 +4940,45 @@ static void destroy_inodecache(void)
 	kmem_cache_destroy(f2fs_inode_cachep);
 }
 
-static int __init init_f2fs_fs(void)
+static int register_f2fs(void)
 {
-	int err;
+	return register_filesystem(&f2fs_fs_type);
+}
 
-	err = init_inodecache();
-	if (err)
-		goto fail;
-	err = f2fs_create_node_manager_caches();
-	if (err)
-		goto free_inodecache;
-	err = f2fs_create_segment_manager_caches();
-	if (err)
-		goto free_node_manager_caches;
-	err = f2fs_create_checkpoint_caches();
-	if (err)
-		goto free_segment_manager_caches;
-	err = f2fs_create_recovery_cache();
-	if (err)
-		goto free_checkpoint_caches;
-	err = f2fs_create_extent_cache();
-	if (err)
-		goto free_recovery_cache;
-	err = f2fs_create_garbage_collection_cache();
-	if (err)
-		goto free_extent_cache;
-	err = f2fs_init_sysfs();
-	if (err)
-		goto free_garbage_collection_cache;
-	err = f2fs_init_shrinker();
-	if (err)
-		goto free_sysfs;
-	err = register_filesystem(&f2fs_fs_type);
-	if (err)
-		goto free_shrinker;
-	f2fs_create_root_stats();
-	err = f2fs_init_post_read_processing();
-	if (err)
-		goto free_root_stats;
-	err = f2fs_init_iostat_processing();
-	if (err)
-		goto free_post_read;
-	err = f2fs_init_bio_entry_cache();
-	if (err)
-		goto free_iostat;
-	err = f2fs_init_bioset();
-	if (err)
-		goto free_bio_entry_cache;
-	err = f2fs_init_compress_mempool();
-	if (err)
-		goto free_bioset;
-	err = f2fs_init_compress_cache();
-	if (err)
-		goto free_compress_mempool;
-	err = f2fs_create_casefold_cache();
-	if (err)
-		goto free_compress_cache;
-	return 0;
-free_compress_cache:
-	f2fs_destroy_compress_cache();
-free_compress_mempool:
-	f2fs_destroy_compress_mempool();
-free_bioset:
-	f2fs_destroy_bioset();
-free_bio_entry_cache:
-	f2fs_destroy_bio_entry_cache();
-free_iostat:
-	f2fs_destroy_iostat_processing();
-free_post_read:
-	f2fs_destroy_post_read_processing();
-free_root_stats:
-	f2fs_destroy_root_stats();
+static void unregister_f2fs(void)
+{
 	unregister_filesystem(&f2fs_fs_type);
-free_shrinker:
-	f2fs_exit_shrinker();
-free_sysfs:
-	f2fs_exit_sysfs();
-free_garbage_collection_cache:
-	f2fs_destroy_garbage_collection_cache();
-free_extent_cache:
-	f2fs_destroy_extent_cache();
-free_recovery_cache:
-	f2fs_destroy_recovery_cache();
-free_checkpoint_caches:
-	f2fs_destroy_checkpoint_caches();
-free_segment_manager_caches:
-	f2fs_destroy_segment_manager_caches();
-free_node_manager_caches:
-	f2fs_destroy_node_manager_caches();
-free_inodecache:
-	destroy_inodecache();
-fail:
-	return err;
 }
 
+static struct subexitcall_rollback rollback;
+
 static void __exit exit_f2fs_fs(void)
 {
-	f2fs_destroy_casefold_cache();
-	f2fs_destroy_compress_cache();
-	f2fs_destroy_compress_mempool();
-	f2fs_destroy_bioset();
-	f2fs_destroy_bio_entry_cache();
-	f2fs_destroy_iostat_processing();
-	f2fs_destroy_post_read_processing();
-	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
-	f2fs_exit_shrinker();
-	f2fs_exit_sysfs();
-	f2fs_destroy_garbage_collection_cache();
-	f2fs_destroy_extent_cache();
-	f2fs_destroy_recovery_cache();
-	f2fs_destroy_checkpoint_caches();
-	f2fs_destroy_segment_manager_caches();
-	f2fs_destroy_node_manager_caches();
-	destroy_inodecache();
+	module_subexit(&rollback);
+}
+
+static int __init init_f2fs_fs(void)
+{
+	module_subinit(init_inodecache, destroy_inodecache, &rollback);
+	module_subinit(f2fs_create_node_manager_caches, f2fs_destroy_node_manager_caches, &rollback);
+	module_subinit(f2fs_create_segment_manager_caches, f2fs_destroy_segment_manager_caches, &rollback);
+	module_subinit(f2fs_create_checkpoint_caches, f2fs_destroy_checkpoint_caches, &rollback);
+	module_subinit(f2fs_create_recovery_cache, f2fs_destroy_recovery_cache, &rollback);
+	module_subinit(f2fs_create_extent_cache, f2fs_destroy_extent_cache, &rollback);
+	module_subinit(f2fs_create_garbage_collection_cache, f2fs_destroy_garbage_collection_cache, &rollback);
+	module_subinit(f2fs_init_sysfs, f2fs_exit_sysfs, &rollback);
+	module_subinit(f2fs_init_shrinker, f2fs_exit_shrinker, &rollback);
+	module_subinit(register_f2fs, unregister_f2fs, &rollback);
+	module_subinit(f2fs_create_root_stats, f2fs_destroy_root_stats, &rollback);
+	module_subinit(f2fs_init_post_read_processing, f2fs_destroy_post_read_processing, &rollback);
+	module_subinit(f2fs_init_iostat_processing, f2fs_destroy_iostat_processing, &rollback);
+	module_subinit(f2fs_init_bio_entry_cache, f2fs_destroy_bio_entry_cache, &rollback);
+	module_subinit(f2fs_init_bioset, f2fs_destroy_bioset, &rollback);
+	module_subinit(f2fs_init_compress_mempool, f2fs_destroy_compress_mempool, &rollback);
+	module_subinit(f2fs_init_compress_cache, f2fs_destroy_compress_cache, &rollback);
+	module_subinit(f2fs_create_casefold_cache, f2fs_destroy_casefold_cache, &rollback);
+
+	return 0;
 }
 
 module_init(init_f2fs_fs)
-- 
2.34.1


