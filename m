Return-Path: <linux-arch+bounces-11261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294FCA7B5C1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BC216E7F5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF261624DD;
	Fri,  4 Apr 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m14CeTB2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15313BAE3;
	Fri,  4 Apr 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733198; cv=none; b=ufLXPkUXcAh9EmfbU59PtBsAf60rguzwc0gTAB2Q8nnKse2QRHqAZK7JfKZ1VeDhD7pZsdqJB4bESuGTcj4LoP/KKKhMsHh84p52JlE/zRYtTZUe/7UukkIUgyrDKNCiVEmtXtz2Cj/SLqiFmvIKCgog8aQEJ/c0CvEmIlIkUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733198; c=relaxed/simple;
	bh=UXcvp4I1qeYAVOV0ZjXs52eGRzk0AcCVDTeNcK4XcrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxSUnTtn0mm9aiBavJRRDOBVu/lC9dltE5gA0jGwiXmq5LVyuph3xqrYTv9tTiMIUT8Idvg3Q7z+Wd9gVEWcUiKR7qkowBAB1xrGwpIU5HV9i3jYXFk963YJyWdj25UHxHhMKXAt5D0RGIZrmHPqpAdSAsgqE0nZhDSXIa2Krfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m14CeTB2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O0ar030247;
	Fri, 4 Apr 2025 02:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=qrrOK
	BJ/3jCKhjqRR4yfWGx2+uS9oDf6jT20lWJ3iuQ=; b=m14CeTB2tu/LSvz0nrYD/
	qagIzSxoh7Xc5bDEZd056ItzD0cuTb4GVd8WG8UbD38+n3OaT6ZLlMNRIQ7+HPZk
	viQHg2frxvNYW3iuscXzofYtV/8gb5Q25cqJqcYMdnLkHGyeJNReDSx0Ws/3IWou
	xnqJEHZfdMkSNPGnFVS+plxeUwrT3nQsZz5ix6XyOEQjdMccScT5dGEM1KAS1lu9
	791hKsHciPkbIlYCt9+j6Ovt5Hv/DLnJ/+TnsHMlRiEe0h8H48OQFJWJLD84x+pl
	WGJt+FITXkazEqnq9p82z5pL1BiZwu/Ub1tL52jpIgVguKiNFlE55cR80+9o+z4f
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0p1nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340hocF017504;
	Fri, 4 Apr 2025 02:19:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspje4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8gw030074;
	Fri, 4 Apr 2025 02:19:33 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-12;
	Fri, 04 Apr 2025 02:19:32 +0000
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
Subject: [PATCH v2 11/20] mm: add and use unmap_page_range vm_ops hook
Date: Thu,  3 Apr 2025 19:18:53 -0700
Message-ID: <20250404021902.48863-12-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: D3avib5KfJw9o7txOeLIIqumVBlsAqWD
X-Proofpoint-GUID: D3avib5KfJw9o7txOeLIIqumVBlsAqWD

Special handling is needed when unmapping a hugetlb vma and will
be needed when unmapping an msharefs vma once support is added for
handling faults in an mshare region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h | 10 ++++++++++
 ipc/shm.c          | 17 +++++++++++++++++
 mm/hugetlb.c       | 25 +++++++++++++++++++++++++
 mm/memory.c        | 36 +++++++++++++-----------------------
 4 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f2f9d15213ab..d6cac2cca4da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -40,6 +40,7 @@ struct anon_vma_chain;
 struct user_struct;
 struct pt_regs;
 struct folio_batch;
+struct zap_details;
 
 void arch_mm_preinit(void);
 void mm_core_init(void);
@@ -661,8 +662,17 @@ struct vm_operations_struct {
 	 */
 	struct page *(*find_special_page)(struct vm_area_struct *vma,
 					  unsigned long addr);
+	void (*unmap_page_range)(struct mmu_gather *tlb,
+				 struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end,
+				 struct zap_details *details);
 };
 
+void __unmap_page_range(struct mmu_gather *tlb,
+			struct vm_area_struct *vma,
+			unsigned long addr, unsigned long end,
+			struct zap_details *details);
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline void vma_numab_state_init(struct vm_area_struct *vma)
 {
diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..cadd551e60b9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -585,6 +585,22 @@ static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
 }
 #endif
 
+static void shm_unmap_page_range(struct mmu_gather *tlb,
+				 struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end,
+				 struct zap_details *details)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	if (sfd->vm_ops->unmap_page_range) {
+		sfd->vm_ops->unmap_page_range(tlb, vma, addr, end, details);
+		return;
+	}
+
+	__unmap_page_range(tlb, vma, addr, end, details);
+}
+
 static int shm_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct shm_file_data *sfd = shm_file_data(file);
@@ -685,6 +701,7 @@ static const struct vm_operations_struct shm_vm_ops = {
 	.set_policy = shm_set_policy,
 	.get_policy = shm_get_policy,
 #endif
+	.unmap_page_range = shm_unmap_page_range,
 };
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 39f92aad7bd1..e4a516f458a0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5426,6 +5426,30 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+static void hugetlb_vm_op_unmap_page_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
+{
+	zap_flags_t zap_flags = details ?  details->zap_flags : 0;
+
+	/*
+	 * It is undesirable to test vma->vm_file as it
+	 * should be non-null for valid hugetlb area.
+	 * However, vm_file will be NULL in the error
+	 * cleanup path of mmap_region. When
+	 * hugetlbfs ->mmap method fails,
+	 * mmap_region() nullifies vma->vm_file
+	 * before calling this function to clean up.
+	 * Since no pte has actually been setup, it is
+	 * safe to do nothing in this case.
+	 */
+	if (!vma->vm_file)
+		return;
+
+	__unmap_hugepage_range(tlb, vma, addr, end, NULL, zap_flags);
+}
+
 /*
  * When a new function is introduced to vm_operations_struct and added
  * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
@@ -5439,6 +5463,7 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+	.unmap_page_range = hugetlb_vm_op_unmap_page_range,
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
diff --git a/mm/memory.c b/mm/memory.c
index 6ea3551eb2df..db558fe43088 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1876,7 +1876,7 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 	return addr;
 }
 
-void unmap_page_range(struct mmu_gather *tlb,
+void __unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details)
@@ -1896,6 +1896,16 @@ void unmap_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
+void unmap_page_range(struct mmu_gather *tlb,
+			     struct vm_area_struct *vma,
+			     unsigned long addr, unsigned long end,
+			     struct zap_details *details)
+{
+	if (vma->vm_ops && vma->vm_ops->unmap_page_range)
+		vma->vm_ops->unmap_page_range(tlb, vma, addr, end, details);
+	else
+		__unmap_page_range(tlb, vma, addr, end, details);
+}
 
 static void unmap_single_vma(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
@@ -1917,28 +1927,8 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn(vma, 0, 0, mm_wr_locked);
 
-	if (start != end) {
-		if (unlikely(is_vm_hugetlb_page(vma))) {
-			/*
-			 * It is undesirable to test vma->vm_file as it
-			 * should be non-null for valid hugetlb area.
-			 * However, vm_file will be NULL in the error
-			 * cleanup path of mmap_region. When
-			 * hugetlbfs ->mmap method fails,
-			 * mmap_region() nullifies vma->vm_file
-			 * before calling this function to clean up.
-			 * Since no pte has actually been setup, it is
-			 * safe to do nothing in this case.
-			 */
-			if (vma->vm_file) {
-				zap_flags_t zap_flags = details ?
-				    details->zap_flags : 0;
-				__unmap_hugepage_range(tlb, vma, start, end,
-							     NULL, zap_flags);
-			}
-		} else
-			unmap_page_range(tlb, vma, start, end, details);
-	}
+	if (start != end)
+		unmap_page_range(tlb, vma, start, end, details);
 }
 
 /**
-- 
2.43.5


