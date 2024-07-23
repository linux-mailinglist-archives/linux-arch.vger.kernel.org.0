Return-Path: <linux-arch+bounces-5586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1613939CC4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B8D281F74
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04BE14D711;
	Tue, 23 Jul 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obXgWZdd"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267714D45E
	for <linux-arch@vger.kernel.org>; Tue, 23 Jul 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723594; cv=none; b=QBgz2oZDxOgmibLgxzGr0I1vt40DpwkEnD9haN5XAEXnB1A6haa8QVv+RZyM+jVpmGnNwPeLtBd/9mD/zn4JARd4l/GVomNqmbtm2qy5cj9a8GMI4vhz2QffA7lo0D/kCrnM4tGhr3ent4vrWQMjPZxWRKPQgyrZCidHM5UgKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723594; c=relaxed/simple;
	bh=aUtYHLJ/I++YuGgw+lRjcbWtMgEMqa2dApBe1d3FQcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DG+KTR119RcOaksh+why+xxDnoR3sm8QtGcnaKoBgBTCR+ThqpV6kMQrsfdvKO1dzJsr7HeI9CeINVWTmjHL18w2c7qr6JCoQaeSW/3mGMA2yRlzCPQCVjs9zN1UWMTgcImdzdMTCebXBM8VBCjfjeR1yBCjbpsniKlYU5/14vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obXgWZdd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: arnd@arndb.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721723591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxA91QkgOX+0VUDnwCt0xfORmuQFDgxjT+SW/I9SKQs=;
	b=obXgWZddWdqx+zVOxSS8TJb8HANTxzSQNfsDVMfOVZnMmH1e7jW+1BRdsrBuqvRXHSoZJf
	1UPvBvOVTl8nd0O9wFzheyPT6A0hV9oinYwkFSkY1Mw54TOjhHHnOcfIqBO5NSyKXy9cyH
	GbznrE8Sg3iLW2RTf6CypTVG1MEHpyU=
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
Subject: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and module_subeixt helper macros
Date: Tue, 23 Jul 2024 16:32:37 +0800
Message-Id: <20240723083239.41533-3-youling.tang@linux.dev>
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
 fs/btrfs/super.c | 123 +++++++++--------------------------------------
 1 file changed, 23 insertions(+), 100 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 08d33cb372fb..620493b3f319 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2490,115 +2490,38 @@ static void unregister_btrfs(void)
 	unregister_filesystem(&btrfs_fs_type);
 }
 
-/* Helper structure for long init/exit functions. */
-struct init_sequence {
-	int (*init_func)(void);
-	/* Can be NULL if the init_func doesn't need cleanup. */
-	void (*exit_func)(void);
-};
-
-static const struct init_sequence mod_init_seq[] = {
-	{
-		.init_func = btrfs_props_init,
-		.exit_func = NULL,
-	}, {
-		.init_func = btrfs_init_sysfs,
-		.exit_func = btrfs_exit_sysfs,
-	}, {
-		.init_func = btrfs_init_compress,
-		.exit_func = btrfs_exit_compress,
-	}, {
-		.init_func = btrfs_init_cachep,
-		.exit_func = btrfs_destroy_cachep,
-	}, {
-		.init_func = btrfs_init_dio,
-		.exit_func = btrfs_destroy_dio,
-	}, {
-		.init_func = btrfs_transaction_init,
-		.exit_func = btrfs_transaction_exit,
-	}, {
-		.init_func = btrfs_ctree_init,
-		.exit_func = btrfs_ctree_exit,
-	}, {
-		.init_func = btrfs_free_space_init,
-		.exit_func = btrfs_free_space_exit,
-	}, {
-		.init_func = extent_state_init_cachep,
-		.exit_func = extent_state_free_cachep,
-	}, {
-		.init_func = extent_buffer_init_cachep,
-		.exit_func = extent_buffer_free_cachep,
-	}, {
-		.init_func = btrfs_bioset_init,
-		.exit_func = btrfs_bioset_exit,
-	}, {
-		.init_func = extent_map_init,
-		.exit_func = extent_map_exit,
-	}, {
-		.init_func = ordered_data_init,
-		.exit_func = ordered_data_exit,
-	}, {
-		.init_func = btrfs_delayed_inode_init,
-		.exit_func = btrfs_delayed_inode_exit,
-	}, {
-		.init_func = btrfs_auto_defrag_init,
-		.exit_func = btrfs_auto_defrag_exit,
-	}, {
-		.init_func = btrfs_delayed_ref_init,
-		.exit_func = btrfs_delayed_ref_exit,
-	}, {
-		.init_func = btrfs_prelim_ref_init,
-		.exit_func = btrfs_prelim_ref_exit,
-	}, {
-		.init_func = btrfs_interface_init,
-		.exit_func = btrfs_interface_exit,
-	}, {
-		.init_func = btrfs_print_mod_info,
-		.exit_func = NULL,
-	}, {
-		.init_func = btrfs_run_sanity_tests,
-		.exit_func = NULL,
-	}, {
-		.init_func = register_btrfs,
-		.exit_func = unregister_btrfs,
-	}
-};
-
-static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
-
-static __always_inline void btrfs_exit_btrfs_fs(void)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
-		if (!mod_init_result[i])
-			continue;
-		if (mod_init_seq[i].exit_func)
-			mod_init_seq[i].exit_func();
-		mod_init_result[i] = false;
-	}
-}
+static struct subexitcall_rollback rollback;
 
 static void __exit exit_btrfs_fs(void)
 {
-	btrfs_exit_btrfs_fs();
+	module_subexit(&rollback);
 	btrfs_cleanup_fs_uuids();
 }
 
 static int __init init_btrfs_fs(void)
 {
-	int ret;
-	int i;
+	module_subinit_noexit(btrfs_props_init, &rollback);
+	module_subinit(btrfs_init_sysfs, btrfs_exit_sysfs, &rollback);
+	module_subinit(btrfs_init_compress, btrfs_exit_compress, &rollback);
+	module_subinit(btrfs_init_cachep, btrfs_destroy_cachep, &rollback);
+	module_subinit(btrfs_init_dio, btrfs_destroy_dio, &rollback);
+	module_subinit(btrfs_transaction_init, btrfs_transaction_exit, &rollback);
+	module_subinit(btrfs_ctree_init, btrfs_ctree_exit, &rollback);
+	module_subinit(btrfs_free_space_init, btrfs_free_space_exit, &rollback);
+	module_subinit(extent_state_init_cachep, extent_state_free_cachep, &rollback);
+	module_subinit(extent_buffer_init_cachep, extent_buffer_free_cachep, &rollback);
+	module_subinit(btrfs_bioset_init, btrfs_bioset_exit, &rollback);
+	module_subinit(extent_map_init, extent_map_exit, &rollback);
+	module_subinit(ordered_data_init, ordered_data_exit, &rollback);
+	module_subinit(btrfs_delayed_inode_init, btrfs_delayed_inode_exit, &rollback);
+	module_subinit(btrfs_auto_defrag_init, btrfs_auto_defrag_exit, &rollback);
+	module_subinit(btrfs_delayed_ref_init, btrfs_delayed_ref_exit, &rollback);
+	module_subinit(btrfs_prelim_ref_init, btrfs_prelim_ref_exit, &rollback);
+	module_subinit(btrfs_interface_init, btrfs_interface_exit, &rollback);
+	module_subinit_noexit(btrfs_print_mod_info, &rollback);
+	module_subinit_noexit(btrfs_run_sanity_tests, &rollback);
+	module_subinit(register_btrfs, unregister_btrfs, &rollback);
 
-	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
-		ASSERT(!mod_init_result[i]);
-		ret = mod_init_seq[i].init_func();
-		if (ret < 0) {
-			btrfs_exit_btrfs_fs();
-			return ret;
-		}
-		mod_init_result[i] = true;
-	}
 	return 0;
 }
 
-- 
2.34.1


