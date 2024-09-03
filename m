Return-Path: <linux-arch+bounces-6979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C096ACC9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D091C233E5
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE82AEFD;
	Tue,  3 Sep 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UBaIiA4Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218DF126C07;
	Tue,  3 Sep 2024 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405828; cv=none; b=me88rQ/7x6yNB8uweQIspFM9o4I8sBUtXJZESPhNzemZIrJrbjuaJq5ykLkJAVdM00EeZAQLXf0k+x8Gcf+YAOE2982DX1fOe/Q2vI8Aupom4YBFVJcVciER7ap6MhvjdcMM2ymvEtAF7WHpTv8f8WDDLLfzSdZps8yDi/gL1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405828; c=relaxed/simple;
	bh=oip20uQrYY7rnkb8XHDWOmT/22jSoiihJJSpXyjaWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI+PWL2aBFJQzyAQ4xtKUEXzPowqkoRRN14LNnHWl42p9oHgQs8uYQWmpCIUV/hJKHWLeOodT7Q09Y2iy4Dxtboj2KpZC01PgRsHioUOX40tK88TXKO3zXHDf+hmdzJHWOorI9h4EhEPPvjCiFJrpiSXvpEBGQyygLD6uewtH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UBaIiA4Z; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBjOJ023355;
	Tue, 3 Sep 2024 23:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=D
	4FeNiFjoW7280RGlNaW295fu5x23k8wulvm/byXbLI=; b=UBaIiA4ZeuUrN9Zzm
	ITOCcX3GYzkJGDkAIXVty2hKiZT1pRHW7dJmm4nXq6fwFaJ61HioM+feWiWSj9Mp
	uv+F37VLQW5mT/1rMmf+mKwfO6x7+Dn4OpxBJBEHgeqIXtbcAwZW/rRWeHBntNaf
	l8Sbkxigh8ILYyEzZsQGYQWJHNKVadTewbpiHHMgu172T4qNxObVNkEtk1kyBdE9
	H33PtNZFqRYbRliM/J+RwnyTcNJODKDoQv1BXMJYseilKi13IjG1NVwvpj3+fW7f
	PpX+VqAL5egKerN7nZwIqgEYbhhCbHr9fMalceQp2IlhJl//2xDZwcup8P71Ov7b
	vBZZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jtfte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483M7tw3001738;
	Tue, 3 Sep 2024 23:23:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmn7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkf8040456;
	Tue, 3 Sep 2024 23:23:16 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-2;
	Tue, 03 Sep 2024 23:23:15 +0000
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
Subject: [RFC PATCH v3 01/10] mm: Add msharefs filesystem
Date: Tue,  3 Sep 2024 16:22:32 -0700
Message-ID: <20240903232241.43995-2-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903232241.43995-1-anthony.yznaga@oracle.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_11,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=876 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-GUID: AbPuJa1pBRboO3bqigacEes6kB0erZoG
X-Proofpoint-ORIG-GUID: AbPuJa1pBRboO3bqigacEes6kB0erZoG

From: Khalid Aziz <khalid@kernel.org>

Add a ram-based filesystem that contains page table sharing
information and files that enables processes to share page tables.
This patch adds the basic filesystem that can be mounted.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 Documentation/filesystems/msharefs.rst | 107 +++++++++++++++++++++++++
 include/uapi/linux/magic.h             |   1 +
 mm/Makefile                            |   2 +-
 mm/mshare.c                            |  97 ++++++++++++++++++++++
 4 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
new file mode 100644
index 000000000000..727cda663b0b
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
+share page table entries for shared pages.
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
+
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
diff --git a/mm/Makefile b/mm/Makefile
index d2915f8c9dc0..956137de9e1f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -45,7 +45,7 @@ mmu-$(CONFIG_MMU)	+= process_vm_access.o
 endif
 
 ifdef CONFIG_64BIT
-mmu-$(CONFIG_MMU)	+= mseal.o
+mmu-$(CONFIG_MMU)	+= mseal.o mshare.o
 endif
 
 obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
diff --git a/mm/mshare.c b/mm/mshare.c
new file mode 100644
index 000000000000..d5d8e2530e5a
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
+	.open		= simple_open,
+	.llseek		= no_llseek,
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


