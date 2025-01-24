Return-Path: <linux-arch+bounces-9884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8FFA1BF2B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A173A4F93
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B41EEA33;
	Fri, 24 Jan 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbz8o9rG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06C1E9905;
	Fri, 24 Jan 2025 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762967; cv=none; b=ERwLQ49RU/YVEaW6ovzVacy+0JxlOdW1NFxHqXiUgJKtZwi798+Mbc55z41jpM2zW+HA8sHn09pGWqgwd6oNK9nMRfUwAT8P6l9zjoJEDyWqjCmIJ7XfwqleHB3qk1pbjHl8PKH1Y45J58SyU3HyTifVdb+5uuDsTfyEMGhNMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762967; c=relaxed/simple;
	bh=hkODf8pSBZwGyP464LA+YMAYvvWiQaPmursGJe64fc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZNoA1VWZCGnklDK8voG1OCVLXh7YST22SYVBf1S6nF8dxJ4PfGYC6oauBaRVAHL10PkNKZyRI3vYIbQRK08O1ZcyFbhCBQKUtBQNWiB/Rpd9Orbs9D4mQdJhj8e0bXo5C17lI8iwrp86BvyHhBkdWEoT/R+vB50VtZUSPqD39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbz8o9rG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIEkFN002187;
	Fri, 24 Jan 2025 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=WMU6L
	Wuuz0sPUG0ZZmDbq73rQ3vuBHP+1rFTOp/x2RM=; b=nbz8o9rGukImzGsDob9en
	39eAIUc2+JsNnnyy1oLFl6BBl0xeOR1PcFdBkSlAA4rzc0+GhaIcJPfVnGLg/+JN
	Wfmcvc0WXR2fVzZRDhwPHkpPwWKxXt3mhdvCMlfd7qSDhFqmAd5qfiBojuf9+t2/
	DnaUiWy3tMqp6/snf+Ooy2j3r6VSq8PQXW3LSAW9zYbTyxssN8BYDgy/WOBkWkeP
	Ys9AtYq4Nt3ZvDSXjD3H9k72fimLgFlPwjb5zTCe+C7nENNJvedZOE8MQ3qtKRwJ
	jaZdedCDLHtrPy3KxnVgcpiJ24btlclTgnD1e5hJxh1R4eHwhj+7FCVDEbEnwsn3
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awufwwhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OMPchG036590;
	Fri, 24 Jan 2025 23:55:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ac7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxPu018051;
	Fri, 24 Jan 2025 23:55:28 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-8;
	Fri, 24 Jan 2025 23:55:27 +0000
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
Subject: [PATCH 07/20] mm/mshare: Add mmap support
Date: Fri, 24 Jan 2025 15:54:41 -0800
Message-ID: <20250124235454.84587-8-anthony.yznaga@oracle.com>
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
 spamscore=0 mlxlogscore=765 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501240162
X-Proofpoint-ORIG-GUID: kbiUWFzTnM-XfItFGqup7QCxCSWShv0i
X-Proofpoint-GUID: kbiUWFzTnM-XfItFGqup7QCxCSWShv0i

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
 mm/mshare.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/mm/mshare.c b/mm/mshare.c
index 056cb5a82547..529a90fe1602 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/mman.h>
 #include <linux/spinlock_types.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/msharefs.h>
@@ -28,6 +29,74 @@ struct mshare_data {
 	struct mshare_info minfo;
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
+msharefs_get_unmapped_area(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct mshare_data *m_data = file->private_data;
+	struct mm_struct *mm = current->mm;
+	unsigned long mshare_start, mshare_size;
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
+
+	mmap_assert_write_locked(mm);
+
+	if ((flags & MAP_TYPE) == MAP_PRIVATE)
+		return -EINVAL;
+
+	spin_lock(&m_data->m_lock);
+	mshare_start = m_data->minfo.start;
+	mshare_size = m_data->minfo.size;
+	spin_unlock(&m_data->m_lock);
+
+	if ((mshare_size == 0) || (len != mshare_size))
+		return -EINVAL;
+
+	if (len > mmap_end - mmap_min_addr)
+		return -ENOMEM;
+
+	if (addr && (addr != mshare_start))
+		return -EINVAL;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	if (find_vma_intersection(mm, mshare_start, mshare_start + mshare_size))
+		return -EEXIST;
+
+	return mshare_start;
+}
+
 static long
 msharefs_set_size(struct mm_struct *host_mm, struct mshare_data *m_data,
 			struct mshare_info *minfo)
@@ -94,6 +163,8 @@ static const struct inode_operations msharefs_file_inode_ops;
 
 static const struct file_operations msharefs_file_operations = {
 	.open		= simple_open,
+	.mmap		= msharefs_mmap,
+	.get_unmapped_area	 = msharefs_get_unmapped_area,
 	.unlocked_ioctl	= msharefs_ioctl,
 };
 
-- 
2.43.5


