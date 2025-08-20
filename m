Return-Path: <linux-arch+bounces-13219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF9B2D11A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EACEA02EF7
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA972224892;
	Wed, 20 Aug 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqZ1Qy60"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E52222B7;
	Wed, 20 Aug 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651966; cv=none; b=BgIukgdSy65s0WLiMEB4Y//ipp0B81lwocpQRNUp/+19GRjqUCPCCc//iR6lEUVJWeZuWt1ux2Dql6cRuzfYXx+Pd633+EqCfEKrW508db5tQRbDnP27anK0uvHXWJJRD0TNB6GFDvgiQQrOWcoPRL+YGFYaDvPxmUJV1GJI3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651966; c=relaxed/simple;
	bh=/RhrwRbkVHnFBF07M6aULHNkv0YMhhGpWK6+QpX7VLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFP6CLsTFCifl9Z66JWTlJFpfZU75p8+XDJM7HbFOylCSCnk3MGkxplKC1pIBJXMG1+87s8V1cwmByMLUTRXUCwFeyxSF29EzyHtXastK3Sz2ZdC93F5OwraxwuzjvhXvkxNwpcBUCjk/Knq1plHZhs8pfW2kFgK37ujzG0VJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqZ1Qy60; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLC7Jg006874;
	Wed, 20 Aug 2025 01:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=GNBho
	c+YcWSTKbxc9VAOMiT6S5zpt8f2lVNd6yhPsGs=; b=kqZ1Qy60fgqJijj34CYnH
	mnn8DCBFkvJ8aDaasVhFhShGR4dHPh1Mvx0KesTuKOA2zROjrhn71WJedww8WxtX
	kbAMmdurLhcCwKbBYCoNL9FCaQHEtlDSWT8kKmpKo1GgdJTnfRJr1qOQbo34pLpn
	/n6XScPHYwTjF+qgLWoJRJuvZcga1Fl921ChfcT84r6WYs95cyRB8QO3vPgYlL1k
	s7yTn7DvGY8GvFVh1hvj68p23sOdR3JBMhzlV9GYw066Qcp3T3ko0d6mBIZELu6h
	9e3rG1m1+hxRxPe9W0jMNKE0g/R539B3BzxjhFEorfGEWrBGvz9Qvq1z7ZASPo0E
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsr854-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNwUoL007361;
	Wed, 20 Aug 2025 01:05:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14Nde011685;
	Wed, 20 Aug 2025 01:05:11 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-19;
	Wed, 20 Aug 2025 01:05:10 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
        bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com,
        jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com,
        khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com,
        lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
        maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
        mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de,
        osalvador@suse.de, pcc@google.com, peterz@infradead.org,
        pfalcato@suse.de, rostedt@goodmis.org, rppt@kernel.org,
        shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
        vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
        viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
        x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 18/22] mm/mshare: Add an ioctl for mapping objects in an mshare region
Date: Tue, 19 Aug 2025 18:04:11 -0700
Message-ID: <20250820010415.699353-19-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820010415.699353-1-anthony.yznaga@oracle.com>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200007
X-Proofpoint-GUID: 6KYLXE3TpaFgkOXiCEvekb2ffu_D24DL
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a51f49 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=EF7ItLl7AAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JfrnYn6hAAAA:8 a=gkfpIXjfDrXi2JZSh4AA:9 a=lqcHg5cX4UMA:10
 a=KzV_IjdM9kfMg8rc9Rf7:22 a=1CNFftbPRP8L7MoqJWF3:22 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 6KYLXE3TpaFgkOXiCEvekb2ffu_D24DL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX+xKyLrwWzz+S
 DkBTmG7J0OyaAKxYPFlj+zmqZqkYUQsJBWCr0l7NpA6HStjKdLnelBOuauFwZHNl1KMK+FU2aag
 IM7UTYQSxuaqF3XoTGeLQWlhJGBQgQz+ig1fvMNqUKl/J7JUpydagUZP53hbjErCPC/UKuUiF6r
 6xnSMQXe6fknnuIH8H6FGDxT5cQbuEc0iyQDzDpJyyezoy9e9QbZ6QBz5YsqjKmoppIYUgk1cmS
 SjobAvchPfXIfHnRH8+RlCJNOo4S1vP2WwLhTFufqvycrf78FhGwXTA0jemhAtJq79rNimtwz/I
 ntyHr4mrdVf0gPiNjA+gTolI5/s5/ZJ4fHYQ0WINLUy30aueKHUIPqg8fzIXTekxzHzgjRzTfwW
 CmUog9/8KoeuRkB/tzd7fpYBWjP66A==

From: Khalid Aziz <khalid@kernel.org>

Reserve a range of ioctls for msharefs and add an ioctl for mapping
objects within an mshare region. The arguments are the same as mmap()
except that the start of the mapping is specified as an offset into
the mshare region instead of as an address. System-selected addresses
are not supported so MAP_FIXED must be specified. Only shared anonymous
memory is supported initially.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 include/uapi/linux/msharefs.h                 | 31 ++++++++
 mm/mshare.c                                   | 76 ++++++++++++++++++-
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/msharefs.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 406a9f4d0869..cb7377f40696 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -308,6 +308,7 @@ Code  Seq#    Include File                                             Comments
 'v'   20-27  arch/powerpc/include/uapi/asm/vas-api.h                   VAS API
 'v'   C0-FF  linux/meye.h                                              conflict!
 'w'   all                                                              CERN SCI driver
+'x'   00-1F  linux/msharefs.h                                          msharefs filesystem
 'y'   00-1F                                                            packet based user level communications
                                                                        <mailto:zapman@interlan.net>
 'z'   00-3F                                                            CAN bus card conflict!
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
index 8a23b391fa11..ebec51e655e4 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -10,6 +10,7 @@
  *
  * Copyright (C) 2024 Oracle Corp. All rights reserved.
  * Author:	Khalid Aziz <khalid@kernel.org>
+ * Author:	Matthew Wilcox <willy@infradead.org>
  *
  */
 
@@ -19,6 +20,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/mshare.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/msharefs.h>
 #include <linux/falloc.h>
 #include <asm/tlbflush.h>
 
@@ -308,7 +310,7 @@ msharefs_get_unmapped_area(struct file *file, unsigned long addr,
 	if ((flags & MAP_TYPE) == MAP_PRIVATE)
 		return -EINVAL;
 
-	if (!mshare_is_initialized(m_data))
+	if (!mshare_is_initialized(m_data) || !mshare_has_owner(m_data))
 		return -EINVAL;
 
 	mshare_start = m_data->start;
@@ -343,6 +345,77 @@ msharefs_get_unmapped_area(struct file *file, unsigned long addr,
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
+	if (!mshare_is_initialized(m_data))
+		return -EINVAL;
+
+	switch (cmd) {
+	case MSHAREFS_CREATE_MAPPING:
+		if (copy_from_user(&mcreate, (struct mshare_create __user *)arg,
+			sizeof(mcreate)))
+			return -EFAULT;
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
@@ -398,6 +471,7 @@ static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
 	.mmap			= msharefs_mmap,
 	.get_unmapped_area	= msharefs_get_unmapped_area,
+	.unlocked_ioctl		= msharefs_ioctl,
 	.fallocate		= msharefs_fallocate,
 };
 
-- 
2.47.1


