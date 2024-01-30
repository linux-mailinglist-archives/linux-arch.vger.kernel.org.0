Return-Path: <linux-arch+bounces-1862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC3842A20
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F411C24A05
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EEA12CD9D;
	Tue, 30 Jan 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bihVHjMT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAB129A89;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633594; cv=none; b=GENgjf0gZPzjflJeYNtq+6X6GKszPhnstLI/ecsNKP4PpStlTpFSlAM7WIt0xj+DtcTvyDx+lVmwzg2M88WIb6pf7Y0EL47gtPtCMHDOpUgFjn3uRH+U5j45/Tmcvjf6sG51gPWzCPSeZZzT0fTKG7NY3CRJ+WGV/ZafyC4+cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633594; c=relaxed/simple;
	bh=4g9gvr2zRDJKqqYI0mUySJAzztyEKM8oIoATdWwyg7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eeVMBp3/dLJK6qv0ITDJrhLvyrEuxMyBKNIJaztUJIRlfT1v4q7CV8IQkirh4UABq0lliwhuy3Az+d0NV4uc69zHR/zawOVAFlhSITuJbLOvOL8Cp27nyalgotMpU66gbY+Rs1CVIDzNa5tfLQ9Rc7FPxd2vgmJoCv8Y1F093bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bihVHjMT; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633584;
	bh=4g9gvr2zRDJKqqYI0mUySJAzztyEKM8oIoATdWwyg7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bihVHjMT8e4Ue70q8Z3rvXqCi80gjbTnxicO3gxmMDeC0vxcZR8yP9+fyJ60aDdvP
	 ZtH4Pl0qqOiXSzGsu372Hho4/PFKWCmQ/ZynIysaQqFioxW895NY9ZquW4AKykzHS+
	 dXa+jzGs49fy0IlxhrTtJEYeYGP8KdB6hWuNHrSgpZ394PbhBgU+SC44d+s6lxIKiv
	 xp4IyzKVfSbh8zD8n/wWr6HDAgtd8aNpc2E5rpc/ONXK+2DS67hV2tArXqF/9NqGyn
	 5zcr0Ec3hXOJ/iQSANYw8xp/neByDUFebT1ybnHZOpWkPtKYp3zEucDjWFCDl7+Mkf
	 hTksPwIfbI8nA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSc3G2mzVgL;
	Tue, 30 Jan 2024 11:53:04 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH v2 6/8] xfs: Use dax_is_supported()
Date: Tue, 30 Jan 2024 11:52:53 -0500
Message-Id: <20240130165255.212591-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() to validate whether the architecture has
virtually aliased data caches at mount time. Silently disable
DAX if dax=always is requested as a mount option on an architecture
which does not support DAX.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches.

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..360f640159b0 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1208,7 +1208,7 @@ static bool
 xfs_inode_should_enable_dax(
 	struct xfs_inode *ip)
 {
-	if (!IS_ENABLED(CONFIG_FS_DAX))
+	if (!dax_is_supported())
 		return false;
 	if (xfs_has_dax_never(ip->i_mount))
 		return false;
-- 
2.39.2


