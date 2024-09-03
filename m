Return-Path: <linux-arch+bounces-6982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C796ACD0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC321C237BF
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD61D79BC;
	Tue,  3 Sep 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gyq+srtC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23461D5CEC;
	Tue,  3 Sep 2024 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405839; cv=none; b=CVwoBOnyOqBYn4nqonXmVNvXRkFMj3xyGkySp5oLMuZxQOH4bAptaoQOgrmqZet4s1elVGuYQglsthjN2dCY6b/EL5uLtEt+h/6OjFV/7J1OW+HpujR9qrvc2y3simg2zXAHnuAl+oebz3Hi7Z593tZO6+M4DgUOsJ7zzju5clQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405839; c=relaxed/simple;
	bh=MnKbj6sSS3HCJqNa+kkOnsAeT3g9xf0IOvxLxlKUb28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf1giXc2PBJMjJz+BJNX1YSlidGkRw/RZ6Znw+37MaF0YeC9BVGAjQvkYRohGVEV8gTZROrOej2HUYJ2YSSxw9OkpgJK8D8m0FKX7dz81N0pB4MTIXlGsPidEKNKJTceCtvLhQIw0lJ9dd6eREQLAbnvJFbnifaBkf6+hOVkMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gyq+srtC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBUmx028866;
	Tue, 3 Sep 2024 23:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=q
	EfvffDSVfz+Cs+eDRWcr3G6GuHXhaLNpWU2hJkHeiQ=; b=Gyq+srtC+arStnlah
	Us7IAI2/G+LfgIpGjAK8YYVBmyqXbNrPdVSsYfi6KxSst/w//YW85yCDlvqKbgGk
	a6XQFyfiHiUNspyERhIq2oXw4HCL3XZHfk4aOIufJCxJGWByFbOk3X6X1SFy532i
	Zb7jAjs8YD0gSHcgJW4ZM0Ik85p1/fEBy/Fvs3oDrkTDIeKROz3Jl3UD1cr3h+Eb
	fStki0YNMIkS6Io0UYpRQpWQJ+EGHP1BXHscMnPRUmdAMFd08E18023W1JMJALfG
	1wo93GM8jya6z7nlhHpLcq5Bki7UAK/mLwf0PVFSNpkYCduT7PR9p86CvMO4LDxl
	GuGkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndj1ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483L2mjO001723;
	Tue, 3 Sep 2024 23:23:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmndr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfG040456;
	Tue, 3 Sep 2024 23:23:30 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-6;
	Tue, 03 Sep 2024 23:23:30 +0000
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
Subject: [RFC PATCH v3 05/10] mm/mshare: Add ioctl support
Date: Tue,  3 Sep 2024 16:22:36 -0700
Message-ID: <20240903232241.43995-6-anthony.yznaga@oracle.com>
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
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030187
X-Proofpoint-GUID: F6ATNHHZ8mdBkmlzSGVUWfQGjEu59pOv
X-Proofpoint-ORIG-GUID: F6ATNHHZ8mdBkmlzSGVUWfQGjEu59pOv

From: Khalid Aziz <khalid@kernel.org>

Reserve a range of ioctls for msharefs and add the first two ioctls
to get and set the start address and size of an mshare region.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 include/uapi/linux/msharefs.h                 | 29 ++++++++
 mm/mshare.c                                   | 72 +++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 include/uapi/linux/msharefs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e91c0376ee59..d2fa6b117f66 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -301,6 +301,7 @@ Code  Seq#    Include File                                           Comments
 'v'   20-27  arch/powerpc/include/uapi/asm/vas-api.h		     VAS API
 'v'   C0-FF  linux/meye.h                                            conflict!
 'w'   all                                                            CERN SCI driver
+'x'   00-1F  linux/msharefs.h                                        msharefs filesystem
 'y'   00-1F                                                          packet based user level communications
                                                                      <mailto:zapman@interlan.net>
 'z'   00-3F                                                          CAN bus card conflict!
diff --git a/include/uapi/linux/msharefs.h b/include/uapi/linux/msharefs.h
new file mode 100644
index 000000000000..c7b509c7e093
--- /dev/null
+++ b/include/uapi/linux/msharefs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * msharefs defines a memory region that is shared across processes.
+ * ioctl is used on files created under msharefs to set various
+ * attributes on these shared memory regions
+ *
+ *
+ * Copyright (C) 2024 Oracle Corp. All rights reserved.
+ * Author:	Khalid Aziz <khalid@kernel.org>
+ */
+
+#ifndef _UAPI_LINUX_MSHAREFS_H
+#define _UAPI_LINUX_MSHAREFS_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * msharefs specific ioctl commands
+ */
+#define MSHAREFS_GET_SIZE	_IOR('x', 0,  struct mshare_info)
+#define MSHAREFS_SET_SIZE	_IOW('x', 1,  struct mshare_info)
+
+struct mshare_info {
+	__u64 start;
+	__u64 size;
+};
+
+#endif
diff --git a/mm/mshare.c b/mm/mshare.c
index a37849e724e1..af46eb76d2bc 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,15 +10,20 @@
  *
  * Copyright (C) 2024 Oracle Corp. All rights reserved.
  * Author:	Khalid Aziz <khalid@kernel.org>
+ * Author:	Matthew Wilcox <willy@infradead.org>
  *
  */
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/spinlock_types.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/msharefs.h>
 
 struct mshare_data {
 	struct mm_struct *mm;
+	spinlock_t m_lock;
+	struct mshare_info minfo;
 };
 
 struct msharefs_info {
@@ -28,8 +33,74 @@ struct msharefs_info {
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
+static long
+msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
+			struct mshare_info *minfo)
+{
+	unsigned long end = minfo->start + minfo->size;
+
+	/*
+	 * Validate alignment for start address, and size
+	 */
+	if ((minfo->start | end) & (PGDIR_SIZE - 1)) {
+		spin_unlock(&m_data->m_lock);
+		return -EINVAL;
+	}
+
+	mm->mmap_base = minfo->start;
+	mm->task_size = minfo->size;
+	if (!mm->task_size)
+		mm->task_size--;
+
+	m_data->minfo.start = mm->mmap_base;
+	m_data->minfo.size = mm->task_size;
+	spin_unlock(&m_data->m_lock);
+
+	return 0;
+}
+
+static long
+msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct mshare_data *m_data = filp->private_data;
+	struct mm_struct *mm = m_data->mm;
+	struct mshare_info minfo;
+
+	switch (cmd) {
+	case MSHAREFS_GET_SIZE:
+		spin_lock(&m_data->m_lock);
+		minfo = m_data->minfo;
+		spin_unlock(&m_data->m_lock);
+
+		if (copy_to_user((void __user *)arg, &minfo, sizeof(minfo)))
+			return -EFAULT;
+
+		return 0;
+
+	case MSHAREFS_SET_SIZE:
+		if (copy_from_user(&minfo, (struct mshare_info __user *)arg,
+			sizeof(minfo)))
+			return -EFAULT;
+
+		/*
+		 * If this mshare region has been set up once already, bail out
+		 */
+		spin_lock(&m_data->m_lock);
+		if (m_data->minfo.start != 0) {
+			spin_unlock(&m_data->m_lock);
+			return -EINVAL;
+		}
+
+		return msharefs_set_size(mm, m_data, &minfo);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
+	.unlocked_ioctl	= msharefs_ioctl,
 	.llseek		= no_llseek,
 };
 
@@ -54,6 +125,7 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 	m_data->mm = mm;
+	spin_lock_init(&m_data->m_lock);
 	inode->i_private = m_data;
 
 	return 0;
-- 
2.43.5


