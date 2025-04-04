Return-Path: <linux-arch+bounces-11262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A7A7B5C2
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA2189CC34
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3316A95B;
	Fri,  4 Apr 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfgPtYYp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF213CA9C;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733199; cv=none; b=la4gdxq8Hb1pibdyBTv9tA/SnVK/h52pvgL59mCq5H3juIEJmiEd1yKhmfGuj3jrCBpAKtKt1Nyvg1mvS/mwB2rm1xU5xZh4k4b4CqOK+y/L8drEK3hgU9oaEJX4cQ/vGSod7k2IWz7s9zWrKR+hGSgK2lkRNaEhxCmIIXNB+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733199; c=relaxed/simple;
	bh=SiyoxJ1X5XIAgrXKDBaL/qBu+xpWd/HBVR17s0PrL6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skfppGDHKgCLTbn/xwNFJ8jL1u9u2ZPHmvihdkp7iEGMQ1qsCqSTDF8uSIeumIqpWL5Bj1gAvnkSbStiE4uf+Q2aHjY6dshdD7jFOLIl+W3dApbeGqMVeRYGgw57UWLShbxDJb1Plqzmn7ATs7Orb3s6/SDCWUSbX+OLE8f96vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZfgPtYYp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N2KW003850;
	Fri, 4 Apr 2025 02:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=s3Be4
	h3gS8mZLGO0ggl9ZrqQVZS1VM6QgX8fGTsPeZ0=; b=ZfgPtYYpoylzoJBqsSQeN
	LUYLNPEY9WvV+15bBaK2cB95PXsUxqWAXwZmbBT/XnmmN/N5zvfkQQ//334Y4a6w
	5B0GtTjwvqIizjHEbdwyhiMvk4+uHdw90DHrzc/jOOv/3m7rxJ8yrpo2loCL1xFK
	PqtQcQz/DhjIMuYJsR6M3LRxQam9nSH6drJw9VyZl2WuXTU1QzkYKBrrpKsp3SPm
	MHVQYHHxUBNEA0vKQCsEG8gRKyChBbmmWhyw+YDQyU53+D3Cf0jea5XhXTPEgHzg
	lrBNzCH+KF50lCO1XMHs4dx5a1UkrdPqt/YXt0IIMFCxowfsem9GCj5Te+4aimnM
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sax3x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340fjJl017569;
	Fri, 4 Apr 2025 02:19:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspj8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gc030074;
	Fri, 4 Apr 2025 02:19:07 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-2;
	Fri, 04 Apr 2025 02:19:07 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, andreyknvl@gmail.com, dave.hansen@intel.com,
        luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: [PATCH v2 01/20] mm: Add msharefs filesystem
Date: Thu,  3 Apr 2025 19:18:43 -0700
Message-ID: <20250404021902.48863-2-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250404021902.48863-1-anthony.yznaga@oracle.com>
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040014
X-Proofpoint-GUID: idsw14QBE2ePZgxGjKQz5K2iLCV9N4Lh
X-Proofpoint-ORIG-GUID: idsw14QBE2ePZgxGjKQz5K2iLCV9N4Lh

From: Khalid Aziz <khalid@kernel.org>

Add a pseudo filesystem that contains files and page table sharing
information that enables processes to share page table entries.
This patch adds the basic filesystem that can be mounted, a
CONFIG_MSHARE option to enable the feature, and documentation.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 Documentation/filesystems/index.rst    |  1 +
 Documentation/filesystems/msharefs.rst | 96 +++++++++++++++++++++++++
 include/uapi/linux/magic.h             |  1 +
 mm/Kconfig                             |  9 +++
 mm/Makefile                            |  4 ++
 mm/mshare.c                            | 97 ++++++++++++++++++++++++++
 6 files changed, 208 insertions(+)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index a9cf8e950b15..573d7a05dbca 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -101,6 +101,7 @@ Documentation for filesystem implementations.
    fuse-io-uring
    inotify
    isofs
+   msharefs
    nilfs2
    nfs/index
    ntfs3
diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
new file mode 100644
index 000000000000..3e5b7d531821
--- /dev/null
+++ b/Documentation/filesystems/msharefs.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+Msharefs - A filesystem to support shared page tables
+=====================================================
+
+What is msharefs?
+-----------------
+
+msharefs is a pseudo filesystem that allows multiple processes to
+share page table entries for shared pages. To enable support for
+msharefs the kernel must be compiled with CONFIG_MSHARE set.
+
+msharefs is typically mounted like this::
+
+	mount -t msharefs none /sys/fs/mshare
+
+A file created on msharefs creates a new shared region where all
+processes mapping that region will map it using shared page table
+entries. Once the size of the region has been established via
+ftruncate() or fallocate(), the region can be mapped into processes
+and ioctls used to map and unmap objects within it. Note that an
+msharefs file is a control file and accessing mapped objects within
+a shared region through read or write of the file is not permitted.
+
+How to use mshare
+-----------------
+
+Here are the basic steps for using mshare:
+
+  1. Mount msharefs on /sys/fs/mshare::
+
+	mount -t msharefs msharefs /sys/fs/mshare
+
+  2. mshare regions have alignment and size requirements. Start
+     address for the region must be aligned to an address boundary and
+     be a multiple of fixed size. This alignment and size requirement
+     can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
+     which returns a number in text format. mshare regions must be
+     aligned to this boundary and be a multiple of this size.
+
+  3. For the process creating an mshare region:
+
+    a. Create a file on /sys/fs/mshare, for example::
+
+        fd = open("/sys/fs/mshare/shareme",
+                        O_RDWR|O_CREAT|O_EXCL, 0600);
+
+    b. Establish the size of the region::
+
+        fallocate(fd, 0, 0, BUF_SIZE);
+
+      or::
+
+        ftruncate(fd, BUF_SIZE);
+
+    c. Map some memory in the region::
+
+	struct mshare_create mcreate;
+
+	mcreate.region_offset = 0;
+	mcreate.size = BUF_SIZE;
+	mcreate.offset = 0;
+	mcreate.prot = PROT_READ | PROT_WRITE;
+	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
+	mcreate.fd = -1;
+
+	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
+
+    d. Map the mshare region into the process::
+
+	mmap(NULL, BUF_SIZE,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+    e. Write and read to mshared region normally.
+
+
+  4. For processes attaching an mshare region:
+
+    a. Open the msharefs file, for example::
+
+	fd = open("/sys/fs/mshare/shareme", O_RDWR);
+
+    b. Get the size of the mshare region from the file::
+
+        fstat(fd, &sb);
+        mshare_size = sb.st_size;
+
+    c. Map the mshare region into the process::
+
+	mmap(NULL, mshare_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+  5. To delete the mshare region::
+
+		unlink("/sys/fs/mshare/shareme");
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..e53dd6063cba 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define MSHARE_MAGIC		0x4d534852	/* "MSHR" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index d3fb3762887b..e6c90db83d01 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1342,6 +1342,15 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config MSHARE
+	bool "Mshare"
+	depends on MMU
+	help
+	  Enable msharefs: A ram-based filesystem that allows multiple
+	  processes to share page table entries for shared pages. A file
+	  created on msharefs represents a shared region where all processes
+	  mapping that region will map objects within it with shared PTEs.
+	  Ioctls are used to configure and map objects into the shared region.
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/Makefile b/mm/Makefile
index e7f6bbf8ae5f..b32aad62589b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -48,6 +48,10 @@ ifdef CONFIG_64BIT
 mmu-$(CONFIG_MMU)	+= mseal.o
 endif
 
+ifdef CONFIG_MSHARE
+mmu-$(CONFIG_MMU)	+= mshare.o
+endif
+
 obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   maccess.o page-writeback.o folio-compat.o \
 			   readahead.o swap.o truncate.o vmscan.o shrinker.o \
diff --git a/mm/mshare.c b/mm/mshare.c
new file mode 100644
index 000000000000..f703af49ec81
--- /dev/null
+++ b/mm/mshare.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Enable cooperating processes to share page table between
+ * them to reduce the extra memory consumed by multiple copies
+ * of page tables.
+ *
+ * This code adds an in-memory filesystem - msharefs.
+ * msharefs is used to manage page table sharing
+ *
+ *
+ * Copyright (C) 2024 Oracle Corp. All rights reserved.
+ * Author:	Khalid Aziz <khalid@kernel.org>
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <uapi/linux/magic.h>
+
+static const struct file_operations msharefs_file_operations = {
+	.open			= simple_open,
+};
+
+static const struct super_operations mshare_s_ops = {
+	.statfs		= simple_statfs,
+};
+
+static int
+msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
+	sb->s_magic		= MSHARE_MAGIC;
+	sb->s_op		= &mshare_s_ops;
+	sb->s_time_gran		= 1;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR | 0777;
+	simple_inode_init_ts(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int
+msharefs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, msharefs_fill_super);
+}
+
+static const struct fs_context_operations msharefs_context_ops = {
+	.get_tree	= msharefs_get_tree,
+};
+
+static int
+mshare_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &msharefs_context_ops;
+	return 0;
+}
+
+static struct file_system_type mshare_fs = {
+	.name			= "msharefs",
+	.init_fs_context	= mshare_init_fs_context,
+	.kill_sb		= kill_litter_super,
+};
+
+static int __init
+mshare_init(void)
+{
+	int ret;
+
+	ret = sysfs_create_mount_point(fs_kobj, "mshare");
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&mshare_fs);
+	if (ret)
+		sysfs_remove_mount_point(fs_kobj, "mshare");
+
+	return ret;
+}
+
+core_initcall(mshare_init);
-- 
2.43.5


