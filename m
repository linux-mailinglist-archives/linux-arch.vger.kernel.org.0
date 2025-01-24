Return-Path: <linux-arch+bounces-9890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC3A1BF42
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E69F188FD5C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE701F8F08;
	Fri, 24 Jan 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U17qv4kg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85521F541E;
	Fri, 24 Jan 2025 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762971; cv=none; b=cZRE6Q8WLr80VM87Dwr94k955TMgHP2Xs7oNDLJ06UBI8hegg9e2Zx/IDuTyh6udJdAhkbnFaF54eWmER6tSmIpRiiip5MaSNv6RzvyE/20L1kby9UomBY4tYI7e/7vogUOVJSEj5T6uEiYNUra4hAMfQ0fcK3oKF0xMaIlu4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762971; c=relaxed/simple;
	bh=217bX5CbLlem3zqXe/vk/U08gUEHdHM1T00iFoP3OzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFXDTBrVThtUP17s4dqpRAT7C7Rh6Ht1x5WneuoU2U4dENCVlrXOSIa+WKh/pl2HHxwORbrQu2WVPIUOVrvcQbv8SdyAuIV6UKUA067vSExNxMskNTj2xDXwMfRHmlu9Jb2CKYwwMaFROKtN7aPThUtihtwAO9E/gh6Muy0PjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U17qv4kg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OINfWM031123;
	Fri, 24 Jan 2025 23:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=YR94n
	q9P1Qyhdr85jFXsDeNLWyF6Jz4qdsVA+7ycWG8=; b=U17qv4kgLrflB4RHAeog7
	4wlpmeoJpaSoQ3N6swcZcCacC+QK6zUVbGVxCJmnF7CR/w80FJ7sR+odgKJ3UuIi
	OtXw3u5uE7nk55riixTIRmxB1uecSItgWbCILUpnr38OgT7yMveyfZgnrtM3Mwc5
	R4hrlqSpm3uGwIGQujCqMhibGcC6BLSM7MvvyvSMWBxnn4qJF4zPCQNI5ZbLscNt
	+fjr0vMc5f5X+fkUYSZjrH2NoU3EDMtHPKSjXjV4COMwxKAV42siTVIk3coAlQZM
	9Cr4ZMVkNtfJ+Z0mriz976U2A8GWiJ/ceDvqqwJGKc2kAhsj0MAfAxxUNcjwFLZZ
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsmvmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMmRjc036584;
	Fri, 24 Jan 2025 23:55:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4a92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPq018051;
	Fri, 24 Jan 2025 23:55:20 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-6;
	Fri, 24 Jan 2025 23:55:19 +0000
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
Subject: [PATCH 05/20] mm/mshare: Add ioctl support
Date: Fri, 24 Jan 2025 15:54:39 -0800
Message-ID: <20250124235454.84587-6-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: Z20-vg57O9zfZiKygPd_gm_amo1x_1Ej
X-Proofpoint-ORIG-GUID: Z20-vg57O9zfZiKygPd_gm_amo1x_1Ej

From: Khalid Aziz <khalid@kernel.org>

Reserve a range of ioctls for msharefs and add the first two ioctls
to get and set the start address and size of an mshare region.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 include/uapi/linux/msharefs.h                 | 29 ++++++++
 mm/mshare.c                                   | 68 +++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 include/uapi/linux/msharefs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 243f1f1b554a..aa22b5412e4d 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -303,6 +303,7 @@ Code  Seq#    Include File                                           Comments
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
index 060292fb6a00..056cb5a82547 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,24 +10,91 @@
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
 
 const unsigned long mshare_align = P4D_SIZE;
 
 struct mshare_data {
 	struct mm_struct *mm;
+	spinlock_t m_lock;
+	struct mshare_info minfo;
 };
 
+static long
+msharefs_set_size(struct mm_struct *host_mm, struct mshare_data *m_data,
+			struct mshare_info *minfo)
+{
+	/*
+	 * Validate alignment for start address and size
+	 */
+	if (!minfo->size || ((minfo->start | minfo->size) & (mshare_align - 1))) {
+		spin_unlock(&m_data->m_lock);
+		return -EINVAL;
+	}
+
+	host_mm->mmap_base = minfo->start;
+	host_mm->task_size = minfo->size;
+
+	m_data->minfo.start = host_mm->mmap_base;
+	m_data->minfo.size = host_mm->task_size;
+	spin_unlock(&m_data->m_lock);
+
+	return 0;
+}
+
+static long
+msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct mshare_data *m_data = filp->private_data;
+	struct mm_struct *host_mm = m_data->mm;
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
+		if (m_data->minfo.size != 0) {
+			spin_unlock(&m_data->m_lock);
+			return -EINVAL;
+		}
+
+		return msharefs_set_size(host_mm, m_data, &minfo);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
+	.unlocked_ioctl	= msharefs_ioctl,
 };
 
 static int
@@ -51,6 +118,7 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 	m_data->mm = mm;
+	spin_lock_init(&m_data->m_lock);
 	inode->i_private = m_data;
 
 	return 0;
-- 
2.43.5


