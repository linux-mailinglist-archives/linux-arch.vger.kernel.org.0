Return-Path: <linux-arch+bounces-9894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E4A1BF53
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DA9189050D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E61F9F5E;
	Fri, 24 Jan 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QeFtJJdY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E51F12EC;
	Fri, 24 Jan 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762984; cv=none; b=uzhXgNtXjapkCDps0u2+wjpYTYNu23jY/MP8h/s4u4JzAJrPYZVm3lvFt7Ydp3sdtoNJvcC/Kt4VJ9/qP1ldUCZegTC8FLshaJXRIfy9Ex76yfXAKot3CAAmeea3SF3f63r6RecQcfKJsSDkqaN7GrmboRnyJEC3EFbHXenfan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762984; c=relaxed/simple;
	bh=6xQbFeFQ9z80aCp3di2KRUyJ0K7BqfnERU/9u4Qz0q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLr2MbzK/edMm1VuGMBANVQ4+K4rPfCaui94SDTHyiUgE4suzrN5ocqrGrGxfleSL95W2tAJm7vk/3nn7khhVUghWCoerpqLTGBiDwSrExmUBDVsCQrHeKjn2Z80a43ywe9Z1qNFX0MFHNVhhb5hOcrA5+O3mgxwQw7H7ALd0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QeFtJJdY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIExIp022002;
	Fri, 24 Jan 2025 23:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=OSIj2
	mJijhCNko8dcXyJfuTUdjY7NtJAOi00OHXcvao=; b=QeFtJJdYB0wtvXXNjl/QM
	MPDJrbyYUVLf9oTAT9Q1GPOvNcwMRB/wQjVpDMKhajG22HNnFiLBqaUY4k9lk+Ch
	p+HSZLNHXxr6eUHaE1S7kk8q9oFnK7c0bR3w9v/pxvPddRrPLiJ8EFvdkZ+MksWF
	kkNtUZMettwjyChukyChxUmO4z5Z6wpnm0a7epnj4d56SjuEL1ws3QX/AiXktMNC
	kWNWqqyzD5/dcni/8xsWCkA+gvfBNoHQTEyIJWLR4DRHSIgRunNbVBi2Zx0tqZ+x
	ony2WUw8mZyEiA/55WfKntKeHX9zSZgPpASTVJgawqgXcW31dZtBBWMWuOFY2Ra+
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awpx5vpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OM0FXi036437;
	Fri, 24 Jan 2025 23:55:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4af9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQ4018051;
	Fri, 24 Jan 2025 23:55:42 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-12;
	Fri, 24 Jan 2025 23:55:42 +0000
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
Subject: [PATCH 11/20] mm: add and use unmap_page_range vm_ops hook
Date: Fri, 24 Jan 2025 15:54:45 -0800
Message-ID: <20250124235454.84587-12-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: MwcrHgPHqQLpE3U3E5SYpIbs-4Wi_R5L
X-Proofpoint-GUID: MwcrHgPHqQLpE3U3E5SYpIbs-4Wi_R5L

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
index bca7aee40f4d..1314af11596d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,6 +39,7 @@ struct anon_vma_chain;
 struct user_struct;
 struct pt_regs;
 struct folio_batch;
+struct zap_details;
 
 extern int sysctl_page_lock_unfairness;
 
@@ -687,8 +688,17 @@ struct vm_operations_struct {
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
index 87761b042ed0..ac3ef62a3dc4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5147,6 +5147,30 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
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
@@ -5160,6 +5184,7 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+	.unmap_page_range = hugetlb_vm_op_unmap_page_range,
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
diff --git a/mm/memory.c b/mm/memory.c
index 2a20e3810534..20bafbb10ea7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1875,7 +1875,7 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 	return addr;
 }
 
-void unmap_page_range(struct mmu_gather *tlb,
+void __unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details)
@@ -1895,6 +1895,16 @@ void unmap_page_range(struct mmu_gather *tlb,
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
@@ -1916,28 +1926,8 @@ static void unmap_single_vma(struct mmu_gather *tlb,
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


