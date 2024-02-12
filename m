Return-Path: <linux-arch+bounces-2198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D9085198F
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4DC1F233BC
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82204EB28;
	Mon, 12 Feb 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B/pnnO95"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2D1E89B;
	Mon, 12 Feb 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755469; cv=none; b=lDWtFfPg9KZIwmsHSNJfjZLhljHu3wHebo/3EjIRnC5KlBijSBpxB4ha5IBNpylScIyppX6GuR8iC466a8kn15QbGDRGnMBuVG+gHrYG8RGVs88zQDeRYrvga/4ao+WTWnpUI4cnOKw8qEzNr4SUVVTma1sxylbah5LbydPpk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755469; c=relaxed/simple;
	bh=/grdS8Lpv8iOI39Sws5KokxIBSxOa0HOFRuTqUntpHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKr3mM+e3CGSAV7KRx240uyfox096oO/YRcDaGbRSCKN5X96mWtTupPWUKNgK1SsXsNJ54AurVR5D9J/dLR4tHg/38twq66zf5g4Ud1AgaqpX8pKHg+D6zFfvpgx97uge0ESd+B85y9KVEZ1uFkLMWCM/WoCBubIFK0WFIaUMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B/pnnO95; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707755465;
	bh=/grdS8Lpv8iOI39Sws5KokxIBSxOa0HOFRuTqUntpHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/pnnO95L1htB3hWWCF4AF8YB2ZjXV07XWuDFRuNTVg9v/lCje1jgMnLoFbNO/rkr
	 l83/diGRpiByxq3cGzsx1L01iER9LPjT73JHfiI9hLUTgB8++idtYRY1VGF0vKZYbG
	 MQXDKfayzT9Nb7t2SUnoFVE3ci4tnEMHm2bcA57ycTxSieBqyrz3tpFzi8TjsMfGxQ
	 O3lr2cR3pWBPK4+6Eb+d/efb8ER8prBbyRRucJ5UkXiULs6b6sshscN9zB/HkWGm8a
	 cEJbx86f7+QkM3fNR2e1Whfi3EPzdnGG8qLQaVs6kZD7GvN1u9pfj5r7L/QWqQp25H
	 k9nmoHUHNr+kw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TYVMF1V3MzXxh;
	Mon, 12 Feb 2024 11:31:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
Date: Mon, 12 Feb 2024 11:30:58 -0500
Message-Id: <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for checking whether the architecture has data cache
aliasing within alloc_dax(), modify the error handling of virtio
virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
non-fatal.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
---
 fs/fuse/virtio_fs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce..f9acd9972af2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -16,6 +16,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/highmem.h>
+#include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
 
@@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
 	put_dax(dax_dev);
 }
 
+DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR(_T)) virtio_fs_cleanup_dax(_T))
+
 static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 {
+	struct dax_device *dax_dev __free(cleanup_dax) = ERR_PTR(-EOPNOTSUPP);
 	struct virtio_shm_region cache_reg;
 	struct dev_pagemap *pgmap;
 	bool have_cache;
@@ -804,6 +808,12 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	if (!IS_ENABLED(CONFIG_FUSE_DAX))
 		return 0;
 
+	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
+	if (IS_ERR(dax_dev)) {
+		int rc = PTR_ERR(dax_dev);
+		return rc == -EOPNOTSUPP ? 0 : rc;
+	}
+
 	/* Get cache region */
 	have_cache = virtio_get_shm_region(vdev, &cache_reg,
 					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
@@ -849,10 +859,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
 		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
 
-	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
-	if (IS_ERR(fs->dax_dev))
-		return PTR_ERR(fs->dax_dev);
-
+	fs->dax_dev = no_free_ptr(dax_dev);
 	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
 					fs->dax_dev);
 }
-- 
2.39.2


