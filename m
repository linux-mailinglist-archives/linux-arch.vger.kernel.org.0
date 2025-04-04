Return-Path: <linux-arch+bounces-11256-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3BA7B5B6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A9F3B83F1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD8139566;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFbf2O0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786A433A8;
	Fri,  4 Apr 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733196; cv=none; b=O/XvWV7wuDxpwuL1t2uJUbUhzn11QRl17e8tB0KcNvQvyG3GrbNVNJBrt97lgfRPkqWZAaLGm6KAM2Cn0C7V2MCPKCeKdogLHRg5kWEEJAQmKAxihcdX0Xx2EtVN5Cni3Ieggqp761PJHbqX5Lsoyngt6ghHmFvRvA7HrylSPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733196; c=relaxed/simple;
	bh=/nOt9kWKHtyttzHLDo4BR6axHs3dyV6J2cgoGrO8r9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7FPkAdim7W4Y1hXD91/rBCl58vviv9ZpQBMXnqiJCfnGzOH7kWUQL1vNMj1MEAwUDNFtSLC2cEdAJmB/QAjHQjmpwp2ndnzmEsRSAUi8Esv2dnemlyvHot0xTCHWYYgC1cImFbAL8pClnAJuyfDSHflbx5/rpUUMz+5DM69mXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFbf2O0a; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341PCiw018034;
	Fri, 4 Apr 2025 02:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=G6bFI
	3MSbYckAqKa8DbmqZRRvXTFnR+psrnW0s3D10w=; b=SFbf2O0apdBaReO3aXDX7
	qKBUp06v+LfCXy0HNTBraJaIWnHOVxFbRMFWeDE+xWKivuPsWFd63fZ2vIRMhDod
	2JI3SJ4oIX1MDPh1T251RJz02RdoXuK0L/BYn0eZm81zJXgI0bfs6qRH0tRwxoeG
	1Xzx7Dol5K51BGUgsbm95Hob68Ab6UN6fz8jRdD+L7NQw709KMnaTddt/XR4TmN+
	nFO8wvSdRyNl4xiN807TbZy+7jUxGlOUwKzC8oo9U23+2/N8iiOvvpOCiRHbZAxy
	JobYNget7etnDru2/7kUJPteFu0nv0/cyACbU3IRXFbD4gihYUyT92lgwhraJpqz
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2efn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340esOZ017552;
	Fri, 4 Apr 2025 02:19:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8go030074;
	Fri, 4 Apr 2025 02:19:23 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-8;
	Fri, 04 Apr 2025 02:19:22 +0000
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
Subject: [PATCH v2 07/20] mm/mshare: Add mmap support
Date: Thu,  3 Apr 2025 19:18:49 -0700
Message-ID: <20250404021902.48863-8-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: qDuqjeXm7WJqgdoVZNMoI87iLLLG-uKZ
X-Proofpoint-GUID: qDuqjeXm7WJqgdoVZNMoI87iLLLG-uKZ

From: Khalid Aziz <khalid@kernel.org>

Add support for mapping an mshare region into a process after the
region has been established in msharefs. Disallow operations that
could split the resulting msharefs vma such as partial unmaps and
protection changes. Fault handling, mapping, unmapping, and
protection changes for objects mapped into an mshare region will
be done using the shared vmas created for them in the host mm. This
functionality will be added in later patches.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mshare.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 5eed18bc3b51..6bdbcfa8deea 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -15,19 +15,146 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/mman.h>
 #include <uapi/linux/magic.h>
 #include <linux/falloc.h>
 
 const unsigned long mshare_align = P4D_SIZE;
+const unsigned long mshare_base = mshare_align;
 
 #define MSHARE_INITIALIZED	0x1
 
 struct mshare_data {
 	struct mm_struct *mm;
+	unsigned long start;
 	unsigned long size;
 	unsigned long flags;
 };
 
+static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
+static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start,
+				 unsigned long end, unsigned long newflags)
+{
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct msharefs_vm_ops = {
+	.may_split = mshare_vm_op_split,
+	.mprotect = mshare_vm_op_mprotect,
+};
+
+/*
+ * msharefs_mmap() - mmap an mshare region
+ */
+static int
+msharefs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct mshare_data *m_data = file->private_data;
+
+	vma->vm_private_data = m_data;
+	vm_flags_set(vma, VM_MSHARE | VM_DONTEXPAND);
+	vma->vm_ops = &msharefs_vm_ops;
+
+	return 0;
+}
+
+static unsigned long
+msharefs_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_unmapped_area_info info = {};
+
+	info.length = len;
+	info.low_limit = current->mm->mmap_base;
+	info.high_limit = arch_get_mmap_end(addr, len, flags);
+	info.align_mask = PAGE_MASK & (mshare_align - 1);
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long
+msharefs_get_unmapped_area_topdown(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct vm_unmapped_area_info info = {};
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
+	info.align_mask = PAGE_MASK & (mshare_align - 1);
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (unlikely(offset_in_page(addr))) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = current->mm->mmap_base;
+		info.high_limit = arch_get_mmap_end(addr, len, flags);
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+static unsigned long
+msharefs_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mshare_data *m_data = file->private_data;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	unsigned long mshare_start, mshare_size;
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
+
+	mmap_assert_write_locked(mm);
+
+	if ((flags & MAP_TYPE) == MAP_PRIVATE)
+		return -EINVAL;
+
+	if (!test_bit(MSHARE_INITIALIZED, &m_data->flags))
+		return -EINVAL;
+
+	mshare_start = m_data->start;
+	mshare_size = m_data->size;
+
+	if (len != mshare_size)
+		return -EINVAL;
+
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	if (flags & MAP_FIXED) {
+		if (!IS_ALIGNED(addr, mshare_align))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (addr) {
+		addr = ALIGN(addr, mshare_align);
+		vma = find_vma_prev(mm, addr, &prev);
+		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+		    (!vma || addr + len <= vm_start_gap(vma)) &&
+		    (!prev || addr >= vm_end_gap(prev)))
+			return addr;
+	}
+
+	if (!test_bit(MMF_TOPDOWN, &mm->flags))
+		return msharefs_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	else
+		return msharefs_get_unmapped_area_topdown(file, addr, len,
+				pgoff, flags);
+}
+
 static int msharefs_set_size(struct mshare_data *m_data, unsigned long size)
 {
 	int error = -EINVAL;
@@ -81,6 +208,8 @@ static const struct inode_operations msharefs_file_inode_ops;
 
 static const struct file_operations msharefs_file_operations = {
 	.open			= simple_open,
+	.mmap			= msharefs_mmap,
+	.get_unmapped_area	= msharefs_get_unmapped_area,
 	.fallocate		= msharefs_fallocate,
 };
 
@@ -97,7 +226,8 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 
-	mm->mmap_base = mm->task_size = 0;
+	mm->mmap_base = mshare_base;
+	mm->task_size = 0;
 
 	m_data = kzalloc(sizeof(*m_data), GFP_KERNEL);
 	if (!m_data) {
@@ -105,6 +235,7 @@ msharefs_fill_mm(struct inode *inode)
 		goto err_free;
 	}
 	m_data->mm = mm;
+	m_data->start = mshare_base;
 	inode->i_private = m_data;
 
 	return 0;
-- 
2.43.5


