Return-Path: <linux-arch+bounces-9891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C043CA1BF48
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5CF16E423
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC21F9408;
	Fri, 24 Jan 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MxaiLSyw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62221F890B;
	Fri, 24 Jan 2025 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762972; cv=none; b=Pp97rJCNPepMkHckPti6ljlaT4Sr7BfpjJv5WIws/SsYej5cg2mHZugiAlPEoxvM6LoP+6ZVNUzqNklxK9QJ4LeydTvAwoD6RMB+ghsQLosJzd6CQHQ8YXWFU62BBHxQYD7B1YlmA3w5gI83qsMjhdexIC1NsTnYXU582+nr+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762972; c=relaxed/simple;
	bh=kFEgH5mCfrIFBrw/Jyzmbzc/gWtoLzw19ckTMatStHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfu8fGlEcpoeSb/f267kNB44DH9ziD8z2OK9TZvs3pfaVRg1SZzsxqReTw5GteH85TBBdR6fiJ3++9Q60HZw9XORxbUemfuBOwEodLZYIG4Ohbsefk2sZVzIU6CfV8vNhEFXZheAzm3o6c7QmzY3UrznVJBBByo8dQldVlmiopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MxaiLSyw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIJo4r001375;
	Fri, 24 Jan 2025 23:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=SBsij
	5SflBt2Meq/0t4PQFvud6q4J6+i2o2Phuq8JSQ=; b=MxaiLSywB8uB8wmqgMOmK
	yl8K0Aklj279cAA7G4xPcodpnwSRWYGHQOHf2DOpQym6+foRxx8LjV2Ka+hBsOID
	wz/yQUVE2ZaekBfUZm+dXTq0fwV6+vmgZ0s4W2NhDX9NMl8lD3Yf5hQ6Q7yRo5lY
	uB9MHV3wuG+pWVfvAm2LlhlCqYAugk4pv/pHWz3LwOPVIss0pYx49iubxWfXyAQN
	aBTBKPoW/rxgHA26oxVTbXk4H9FzDJV1+qkU8XlBoGAenQTWpXa3S2aXGdfQgdOO
	pyFF2LgodTDNlH5Beu6mZ/FBTfrHCThLeH6AwK+oT/UHmlU8NQJNZ1IUmzHD4F26
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh5rk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMD09R036431;
	Fri, 24 Jan 2025 23:55:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4a2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPi018051;
	Fri, 24 Jan 2025 23:55:04 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-2;
	Fri, 24 Jan 2025 23:55:04 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, jthoughton@google.com, corbet@lwn.net,
        dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
        liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
        jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, tglx@linutronix.de, cgroups@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
Subject: [PATCH 01/20] mm: Add msharefs filesystem
Date: Fri, 24 Jan 2025 15:54:35 -0800
Message-ID: <20250124235454.84587-2-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: H3g567xUR2NiiHY65FwJbZPol2W-orgQ
X-Proofpoint-GUID: H3g567xUR2NiiHY65FwJbZPol2W-orgQ

From: Khalid Aziz <khalid@kernel.org>

Add a ram-based filesystem that contains page table sharing
information and files that enables processes to share page tables.
This patch adds the basic filesystem that can be mounted and
a CONFIG_MSHARE option for compiling support in a kernel.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 Documentation/filesystems/msharefs.rst | 107 +++++++++++++++++++++++++
 include/uapi/linux/magic.h             |   1 +
 mm/Kconfig                             |   9 +++
 mm/Makefile                            |   4 +
 mm/mshare.c                            |  96 ++++++++++++++++++++++
 5 files changed, 217 insertions(+)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
new file mode 100644
index 000000000000..c3c7168aa18f
--- /dev/null
+++ b/Documentation/filesystems/msharefs.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+msharefs - a filesystem to support shared page tables
+=====================================================
+
+msharefs is a ram-based filesystem that allows multiple processes to
+share page table entries for shared pages. To enable support for
+msharefs the kernel must be compiled with CONFIG_MSHARE set.
+
+msharefs is typically mounted like this::
+
+	mount -t msharefs none /sys/fs/mshare
+
+A file created on msharefs creates a new shared region where all
+processes mapping that region will map it using shared page table
+entries. ioctls are used to initialize or retrieve the start address
+and size of a shared region and to map objects in the shared
+region. It is important to note that an msharefs file is a control
+file for the shared region and does not contain the contents
+of the region itself.
+
+Here are the basic steps for using mshare::
+
+1. Mount msharefs on /sys/fs/mshare::
+
+	mount -t msharefs msharefs /sys/fs/mshare
+
+2. mshare regions have alignment and size requirements. Start
+   address for the region must be aligned to an address boundary and
+   be a multiple of fixed size. This alignment and size requirement
+   can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
+   which returns a number in text format. mshare regions must be
+   aligned to this boundary and be a multiple of this size.
+
+3. For the process creating an mshare region::
+
+a. Create a file on /sys/fs/mshare, for example:
+
+.. code-block:: c
+
+	fd = open("/sys/fs/mshare/shareme",
+			O_RDWR|O_CREAT|O_EXCL, 0600);
+
+b. Establish the starting address and size of the region:
+
+.. code-block:: c
+
+	struct mshare_info minfo;
+
+	minfo.start = TB(2);
+	minfo.size = BUFFER_SIZE;
+	ioctl(fd, MSHAREFS_SET_SIZE, &minfo);
+
+c. Map some memory in the region:
+
+.. code-block:: c
+
+	struct mshare_create mcreate;
+
+	mcreate.addr = TB(2);
+	mcreate.size = BUFFER_SIZE;
+	mcreate.offset = 0;
+	mcreate.prot = PROT_READ | PROT_WRITE;
+	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
+	mcreate.fd = -1;
+
+	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
+
+d. Map the mshare region into the process:
+
+.. code-block:: c
+
+	mmap((void *)TB(2), BUF_SIZE,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+e. Write and read to mshared region normally.
+
+
+4. For processes attaching an mshare region::
+
+a. Open the file on msharefs, for example:
+
+.. code-block:: c
+
+	fd = open("/sys/fs/mshare/shareme", O_RDWR);
+
+b. Get information about mshare'd region from the file:
+
+.. code-block:: c
+
+	struct mshare_info minfo;
+
+	ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
+
+c. Map the mshare'd region into the process:
+
+.. code-block:: c
+
+	mmap(minfo.start, minfo.size,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+5. To delete the mshare region:
+
+.. code-block:: c
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
index 1b501db06417..ba3dbe31f86a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1358,6 +1358,15 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config MSHARE
+	bool "Mshare"
+	depends on MMU
+	help
+	  Enable msharefs: A ram-based filesystem that allows multiple
+	  processes to share page table entries for shared pages. A file
+	  created on msharefs represents a shared region where all processes
+	  mapping that region will map objects within it with shared PTEs.
+	  Ioctls are used to configure and map objects into the shared region
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..68bc967863f9 100644
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
index 000000000000..49d32e0c20d2
--- /dev/null
+++ b/mm/mshare.c
@@ -0,0 +1,96 @@
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
+	.open		= simple_open,
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


