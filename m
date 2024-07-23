Return-Path: <linux-arch+bounces-5587-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC7939CC9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4E9281FF5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5614A4E7;
	Tue, 23 Jul 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+j7TsDH"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533B14E2E8
	for <linux-arch@vger.kernel.org>; Tue, 23 Jul 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723600; cv=none; b=oAHgi014yN4Rbevd6Yf4gw5PzOx/pKs23nhPyJ51NtMMgDU8DXMNMHXJ5+JkkN0L7DjH/3cBqVv+nOxjKPmjdWYduJKxH3LamNO8SJSaE34PRem3Jj57DbtnOZNIfIx+fxxjWMZJdsPzDzJfK3MIZHKdqlF6sAW5FJlUOZDJlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723600; c=relaxed/simple;
	bh=/mwN5SsbhIgDMwi2o5jzaWYzFJunRtJZ5k7XEtLZcxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhaG2/po/icSShkj5D3IsYWFEWwZk/k4r92AOaxYFpCf3QixwA8NQ9ZGu3n9pZetc0VLjJLy7voRXNwXr+8MFX9fVi1LAvoWNy2Lc3BJk2ZUySMEvk07APgsnzgbs3McNn30s+LMLGb3xbA6GEny47B4AOYB9ZQPdp8GFP11Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+j7TsDH; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: arnd@arndb.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721723597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FpchObtj1bgKZan3q5qtLR0pzIfvv/hdOK5gMl3pYc=;
	b=d+j7TsDHafpzbLmS3vv6N/qkImQhjEqmin45ALNJBaRxl0qHDTvOB+rqR+HlCL96wm0LOF
	eA2U2qzRIYTczg0xNz8D9dMn0NWdsVOeb8S60GRVOWIpHir2+okklwMqcuf8x5jN+lBWRl
	uhgkDt50wo+N4yrygEF4KSBzYqB6z2U=
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
Subject: [PATCH 3/4] ext4: Use module_{subinit, subexit} helper macros
Date: Tue, 23 Jul 2024 16:32:38 +0800
Message-Id: <20240723083239.41533-4-youling.tang@linux.dev>
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
 fs/ext4/super.c | 115 ++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 82 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..207076e7e7f0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7302,103 +7302,54 @@ static struct file_system_type ext4_fs_type = {
 };
 MODULE_ALIAS_FS("ext4");
 
+static int register_ext(void)
+{
+	register_as_ext3();
+	register_as_ext2();
+	return register_filesystem(&ext4_fs_type);
+}
+
+static void unregister_ext(void)
+{
+	unregister_as_ext2();
+	unregister_as_ext3();
+	unregister_filesystem(&ext4_fs_type);
+}
+
+static struct subexitcall_rollback rollback;
+
+static void __exit ext4_exit_fs(void)
+{
+	ext4_destroy_lazyinit_thread();
+	module_subexit(&rollback);
+}
+
 /* Shared across all ext4 file systems */
 wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
 
 static int __init ext4_init_fs(void)
 {
-	int i, err;
-
 	ratelimit_state_init(&ext4_mount_msg_ratelimit, 30 * HZ, 64);
 	ext4_li_info = NULL;
 
 	/* Build-time check for flags consistency */
 	ext4_check_flag_values();
 
-	for (i = 0; i < EXT4_WQ_HASH_SZ; i++)
+	for (int i = 0; i < EXT4_WQ_HASH_SZ; i++)
 		init_waitqueue_head(&ext4__ioend_wq[i]);
 
-	err = ext4_init_es();
-	if (err)
-		return err;
-
-	err = ext4_init_pending();
-	if (err)
-		goto out7;
-
-	err = ext4_init_post_read_processing();
-	if (err)
-		goto out6;
-
-	err = ext4_init_pageio();
-	if (err)
-		goto out5;
-
-	err = ext4_init_system_zone();
-	if (err)
-		goto out4;
-
-	err = ext4_init_sysfs();
-	if (err)
-		goto out3;
-
-	err = ext4_init_mballoc();
-	if (err)
-		goto out2;
-	err = init_inodecache();
-	if (err)
-		goto out1;
-
-	err = ext4_fc_init_dentry_cache();
-	if (err)
-		goto out05;
-
-	register_as_ext3();
-	register_as_ext2();
-	err = register_filesystem(&ext4_fs_type);
-	if (err)
-		goto out;
+	module_subinit(ext4_init_es, ext4_exit_es, &rollback);
+	module_subinit(ext4_init_pending, ext4_exit_pending, &rollback);
+	module_subinit(ext4_init_post_read_processing, ext4_exit_post_read_processing, &rollback);
+	module_subinit(ext4_init_pageio, ext4_exit_pageio, &rollback);
+	module_subinit(ext4_init_system_zone, ext4_exit_system_zone, &rollback);
+	module_subinit(ext4_init_sysfs, ext4_exit_sysfs, &rollback);
+	module_subinit(ext4_init_mballoc, ext4_exit_mballoc, &rollback);
+	module_subinit(init_inodecache, destroy_inodecache, &rollback);
+	module_subinit(ext4_fc_init_dentry_cache, ext4_fc_destroy_dentry_cache, &rollback);
+	module_subinit(register_ext, unregister_ext, &rollback);
 
 	return 0;
-out:
-	unregister_as_ext2();
-	unregister_as_ext3();
-	ext4_fc_destroy_dentry_cache();
-out05:
-	destroy_inodecache();
-out1:
-	ext4_exit_mballoc();
-out2:
-	ext4_exit_sysfs();
-out3:
-	ext4_exit_system_zone();
-out4:
-	ext4_exit_pageio();
-out5:
-	ext4_exit_post_read_processing();
-out6:
-	ext4_exit_pending();
-out7:
-	ext4_exit_es();
-
-	return err;
-}
-
-static void __exit ext4_exit_fs(void)
-{
-	ext4_destroy_lazyinit_thread();
-	unregister_as_ext2();
-	unregister_as_ext3();
-	unregister_filesystem(&ext4_fs_type);
-	ext4_fc_destroy_dentry_cache();
-	destroy_inodecache();
-	ext4_exit_mballoc();
-	ext4_exit_sysfs();
-	ext4_exit_system_zone();
-	ext4_exit_pageio();
-	ext4_exit_post_read_processing();
-	ext4_exit_es();
-	ext4_exit_pending();
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
-- 
2.34.1


