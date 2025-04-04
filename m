Return-Path: <linux-arch+bounces-11268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE4A7B5D4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489DF189D1B5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2B1A072C;
	Fri,  4 Apr 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nVX/7zKw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68BF13AA5D;
	Fri,  4 Apr 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733214; cv=none; b=jCAZCjxBU9lh8PvuVbgcqgiumZ6US0yFpkeALy0hzY6SCr584shSKaqog/J+Q+rFm7ezmGFqxPeNZeKxK8pPdj1OOgLpWbb/nDW2kwUR+TDb3iGlC6wfKRHLgyPaUmS309gQgRSdioEBdiVeRfNVrB4EebOl0XO2kRo4tFULo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733214; c=relaxed/simple;
	bh=bDN7zKYUi1j31rejaWLsRQkMWJk0Q+ZCHRpzIeyVg2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMK+TF3APTkN+leLuxtvSyUBQ40XZT9XpAKgYGRq/p9rPCsPVCEVww7ukvXjbdCOn9Xoi95aKnBRCRyCrhG9mkur183pUyty9pIv7vnUFLIpLjToEA+oLW5vxWScyryAJ62X9eAiR4Plerl/T/pCHBfleZ3tUJZJnQAKMa+b0Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nVX/7zKw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N6uL019296;
	Fri, 4 Apr 2025 02:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Bl6JE
	ql6MB9CDGJQFpauhei0hhqynyHJJWlm3XmR/I8=; b=nVX/7zKwS3gvI5qsECKtH
	NDs4jsDPlOmEiOijuVxA7pDbWh0oA9B2JvEmGCr0PVxf8/XX+eB4Pkri3RebMNQa
	Z74UOgbSpazeIGDFw5Yl8aTiKz2Lb0Akk5JnGojhJ2ZNT9+kjz6Wq1bdZ5jr3z94
	YDjCmXcWktK7zefv1mjhACAlIqskyaqbT0M03ydZbNJjoxQRi9nQz9EWBNMJYpeH
	39adnsY7ZXuemdSz+ihLqXYWCY8cGte6S7eY68F2eCCdxfNGdnqR0aXrdmLWu7R7
	MpXRALsgtYLWZmVKTssUkKVLKkWA8Qm2fulI2+F7oarjKxE6ialYmpq7svcFWdo7
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9ntk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340Wvcw017307;
	Fri, 4 Apr 2025 02:19:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8h8030074;
	Fri, 4 Apr 2025 02:19:45 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-17;
	Fri, 04 Apr 2025 02:19:45 +0000
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
Subject: [PATCH v2 16/20] mm/mshare: Add an ioctl for mapping objects in an mshare region
Date: Thu,  3 Apr 2025 19:18:58 -0700
Message-ID: <20250404021902.48863-17-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: x4FlRSVJiVrDyZtaVnRO1ABhBBdbOkij
X-Proofpoint-ORIG-GUID: x4FlRSVJiVrDyZtaVnRO1ABhBBdbOkij

From: Khalid Aziz <khalid@kernel.org>

Reserve a range of ioctls for msharefs and add an ioctl for mapping
objects within an mshare region. The arguments are the same as mmap()
except that the start of the mapping is specified as an offset into
the mshare region instead of as an address. For now system-selected
addresses are disallowed so MAP_FIXED must be specified. Only shared
anonymous memory is supported initially.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 include/uapi/linux/msharefs.h                 | 31 ++++++++
 mm/mshare.c                                   | 74 +++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 include/uapi/linux/msharefs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 3d1cd7ad9d67..250dd58ebdba 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -306,6 +306,7 @@ Code  Seq#    Include File                                           Comments
 'v'   20-27  arch/powerpc/include/uapi/asm/vas-api.h		     VAS API
 'v'   C0-FF  linux/meye.h                                            conflict!
 'w'   all                                                            CERN SCI driver
+'x'   00-1F  linux/msharefs.h                                        msharefs filesystem
 'y'   00-1F                                                          packet based user level communications
                                                                      <mailto:zapman@interlan.net>
 'z'   00-3F                                                          CAN bus card conflict!
diff --git a/include/uapi/linux/msharefs.h b/include/uapi/linux/msharefs.h
new file mode 100644
index 000000000000..ad129beeef62
--- /dev/null
+++ b/include/uapi/linux/msharefs.h
@@ -0,0 +1,31 @@
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
+#define MSHAREFS_CREATE_MAPPING	_IOW('x', 0,  struct mshare_create)
+
+struct mshare_create {
+	__u64 region_offset;
+	__u64 size;
+	__u64 offset;
+	__u32 prot;
+	__u32 flags;
+	__u32 fd;
+};
+#endif
diff --git a/mm/mshare.c b/mm/mshare.c
index 4ddaa0d41070..be0aaa894963 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,6 +10,7 @@
  *
  * Copyright (C) 2024 Oracle Corp. All rights reserved.
  * Author:	Khalid Aziz <khalid@kernel.org>
+ * Author:	Matthew Wilcox <willy@infradead.org>
  *
  */
 
@@ -18,6 +19,7 @@
 #include <linux/mman.h>
 #include <linux/mmu_notifier.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/msharefs.h>
 #include <linux/falloc.h>
 #include <asm/tlbflush.h>
 
@@ -230,6 +232,77 @@ msharefs_get_unmapped_area(struct file *file, unsigned long addr,
 				pgoff, flags);
 }
 
+static long
+msharefs_create_mapping(struct mshare_data *m_data, struct mshare_create *mcreate)
+{
+	struct mm_struct *host_mm = m_data->mm;
+	unsigned long mshare_start, mshare_end;
+	unsigned long region_offset = mcreate->region_offset;
+	unsigned long size = mcreate->size;
+	unsigned int fd = mcreate->fd;
+	int flags = mcreate->flags;
+	int prot = mcreate->prot;
+	unsigned long populate = 0;
+	unsigned long mapped_addr;
+	unsigned long addr;
+	vm_flags_t vm_flags;
+	int error = -EINVAL;
+
+	mshare_start = m_data->start;
+	mshare_end = mshare_start + m_data->size;
+	addr = mshare_start + region_offset;
+
+	if ((addr < mshare_start) || (addr >= mshare_end) ||
+	    (addr + size > mshare_end))
+		goto out;
+
+	/*
+	 * Only anonymous shared memory at fixed addresses is allowed for now.
+	 */
+	if ((flags & (MAP_SHARED | MAP_FIXED)) != (MAP_SHARED | MAP_FIXED))
+		goto out;
+	if (fd != -1)
+		goto out;
+
+	if (mmap_write_lock_killable(host_mm)) {
+		error = -EINTR;
+		goto out;
+	}
+
+	error = 0;
+	mapped_addr = __do_mmap(NULL, addr, size, prot, flags, vm_flags,
+				0, &populate, NULL, host_mm);
+
+	if (IS_ERR_VALUE(mapped_addr))
+		error = (long)mapped_addr;
+
+	mmap_write_unlock(host_mm);
+out:
+	return error;
+}
+
+static long
+msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct mshare_data *m_data = filp->private_data;
+	struct mshare_create mcreate;
+
+	switch (cmd) {
+	case MSHAREFS_CREATE_MAPPING:
+		if (copy_from_user(&mcreate, (struct mshare_create __user *)arg,
+			sizeof(mcreate)))
+			return -EFAULT;
+
+		if (!test_bit(MSHARE_INITIALIZED, &m_data->flags))
+			return -EINVAL;
+
+		return msharefs_create_mapping(m_data, &mcreate);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
 static int msharefs_set_size(struct mshare_data *m_data, unsigned long size)
 {
 	int error = -EINVAL;
@@ -285,6 +358,7 @@ static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
 	.mmap			= msharefs_mmap,
 	.get_unmapped_area	= msharefs_get_unmapped_area,
+	.unlocked_ioctl		= msharefs_ioctl,
 	.fallocate		= msharefs_fallocate,
 };
 
-- 
2.43.5


