Return-Path: <linux-arch+bounces-11264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7EA7B5C8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE527A7882
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF0137742;
	Fri,  4 Apr 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKtTA5MD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617519995D;
	Fri,  4 Apr 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733209; cv=none; b=kKOOo0kCb7GHzNf6nt6qDqAruE6edGRizxc/719pAqH1zGQ6g9KrBdc6MaLkKtN7iVPZewOVm87nZFUC1aINZ7q+LqBPWC+fRLktYpYXe9yRZZyubgr/pwBEZr3K4h8Y0aI1mImN4c+N8h855Yz7K71cQKZ/QAsDwLIwJgyVQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733209; c=relaxed/simple;
	bh=KXb77FS/rGhZaDdK0GR4Y0UJuKfUiw15MWVjmLim2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgZdXA/OKUpul93H0dSxJZy1CV9u+c3u/RdA/6nnUXIWM+68LewoFO3/sIhKYH8PP6qpHrcxMVhbk+5nQiPMCW4Bi8XINtJbOBIqNquzVDESkhbU4mzZ5d//mIeG92X1BjYjAgCuNtR5QAUx/FwZJOCp7yClPhLqgTU9kYDjqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKtTA5MD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341N1aZ021759;
	Fri, 4 Apr 2025 02:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=qRdpI
	uCp/tE17I/IAkh9LjXKFn30Xjs2SfQmBLZeMus=; b=lKtTA5MDFrSaUt+MSx01e
	4QDNTa6p2Jo15R6RM9Kn6nQCmrtstm+F6bHSR5QZHvnj1c2q5UUOGpcN8yXmJnIO
	lQJLvfYmiJ1nAGpjMwHTLs/KxetWYtJwYzUYh74SKjzcStys5/811hw5IQmheIdM
	NBzjMFSz6xKU2SMTEnZqeOYRJw2mKWZelJ28nzV7WZZtwiJ5xgiYqTpg6yBQj/1J
	7x0CHBH78MWhvnOGpJgQgNr3t2K+IwCJ3oxSyase3MOqm0FLnYGOBjfaDW4TTEUs
	Uq2B2/XkhmhUR4bSgKdcQPSaC+r9LuWFbVMIhwpuQ//cWDSNgq313MAlwe8lkUWO
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsehex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340b2tj017252;
	Fri, 4 Apr 2025 02:19:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspjer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8h0030074;
	Fri, 4 Apr 2025 02:19:35 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-13;
	Fri, 04 Apr 2025 02:19:35 +0000
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
Subject: [PATCH v2 12/20] mm/mshare: prepare for page table sharing support
Date: Thu,  3 Apr 2025 19:18:54 -0700
Message-ID: <20250404021902.48863-13-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: kjqCYtOYSi4kyYmM1hlElVfdmwM9mYYd
X-Proofpoint-GUID: kjqCYtOYSi4kyYmM1hlElVfdmwM9mYYd

From: Khalid Aziz <khalid@kernel.org>

In preparation for enabling the handling of page faults in an mshare
region provide a way to link an mshare shared page table to a process
page table and otherwise find the actual vma in order to handle a page
fault. Modify the unmap path to ensure that page tables in mshare regions
are unlinked and kept intact when a process exits or an mshare region
is explicitly unmapped.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h |  6 +++++
 mm/memory.c        | 45 +++++++++++++++++++++++++++------
 mm/mshare.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d6cac2cca4da..f06be2f20c20 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1179,11 +1179,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
 int vma_is_stack_for_current(struct vm_area_struct *vma);
 
 #ifdef CONFIG_MSHARE
+vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
 static inline bool vma_is_mshare(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_MSHARE;
 }
 #else
+static inline vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp)
+{
+	WARN_ON_ONCE(1);
+	return VM_FAULT_SIGBUS;
+}
 static inline bool vma_is_mshare(const struct vm_area_struct *vma)
 {
 	return false;
diff --git a/mm/memory.c b/mm/memory.c
index db558fe43088..68422b606819 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -247,7 +247,8 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 
 static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool shared_pud)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -259,7 +260,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		free_pud_range(tlb, p4d, addr, next, floor, ceiling);
+		if (unlikely(shared_pud))
+			p4d_clear(p4d);
+		else
+			free_pud_range(tlb, p4d, addr, next, floor, ceiling);
 	} while (p4d++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
@@ -281,9 +285,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 /*
  * This function frees user-level page tables of a process.
  */
-void free_pgd_range(struct mmu_gather *tlb,
+static void __free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
-			unsigned long floor, unsigned long ceiling)
+			unsigned long floor, unsigned long ceiling,
+			bool shared_pud)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -339,10 +344,17 @@ void free_pgd_range(struct mmu_gather *tlb,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		free_p4d_range(tlb, pgd, addr, next, floor, ceiling);
+		free_p4d_range(tlb, pgd, addr, next, floor, ceiling, shared_pud);
 	} while (pgd++, addr = next, addr != end);
 }
 
+void free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
+{
+	__free_pgd_range(tlb, addr, end, floor, ceiling, false);
+}
+
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked)
@@ -379,9 +391,12 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 
 			/*
 			 * Optimization: gather nearby vmas into one call down
+			 *
+			 * Do not free the shared page tables of an mshare region.
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && !vma_is_mshare(next)) {
 				vma = next;
 				next = mas_find(mas, ceiling - 1);
 				if (unlikely(xa_is_zero(next)))
@@ -392,9 +407,11 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 				unlink_file_vma_batch_add(&vb, vma);
 			}
 			unlink_file_vma_batch_final(&vb);
-			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
+			__free_pgd_range(tlb, addr, vma->vm_end,
+				floor, next ? next->vm_start : ceiling,
+				vma_is_mshare(vma));
 		}
+
 		vma = next;
 	} while (vma);
 }
@@ -1884,6 +1901,13 @@ void __unmap_page_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	/*
+	 * Do not unmap vmas that share page tables through an
+	 * mshare region.
+	 */
+	if (vma_is_mshare(vma))
+		return;
+
 	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
@@ -6275,6 +6299,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (ret)
 		goto out;
 
+	if (unlikely(vma_is_mshare(vma))) {
+		WARN_ON_ONCE(1);
+		return VM_FAULT_SIGBUS;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE)) {
diff --git a/mm/mshare.c b/mm/mshare.c
index 792d86c61042..4ddaa0d41070 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -44,6 +44,56 @@ static const struct mmu_notifier_ops mshare_mmu_ops = {
 	.arch_invalidate_secondary_tlbs = mshare_invalidate_tlbs,
 };
 
+static p4d_t *walk_to_p4d(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return NULL;
+
+	return p4d;
+}
+
+/* Returns holding the host mm's lock for read.  Caller must release. */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
+{
+	struct vm_area_struct *vma, *guest = *vmap;
+	struct mshare_data *m_data = guest->vm_private_data;
+	struct mm_struct *host_mm = m_data->mm;
+	unsigned long host_addr;
+	p4d_t *p4d, *guest_p4d;
+
+	mmap_read_lock_nested(host_mm, SINGLE_DEPTH_NESTING);
+	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
+	p4d = walk_to_p4d(host_mm, host_addr);
+	guest_p4d = walk_to_p4d(guest->vm_mm, *addrp);
+	if (!p4d_same(*guest_p4d, *p4d)) {
+		set_p4d(guest_p4d, *p4d);
+		mmap_read_unlock(host_mm);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	vma = find_vma(host_mm, host_addr);
+
+	/* XXX: expand stack? */
+	if (vma && vma->vm_start > host_addr)
+		vma = NULL;
+
+	*vmap = vma;
+
+	/*
+	 * release host mm lock unless a matching vma is found
+	 */
+	if (!vma)
+		mmap_read_unlock(host_mm);
+	return 0;
+}
+
 static int mshare_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	return -EINVAL;
@@ -55,9 +105,21 @@ static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start
 	return -EINVAL;
 }
 
+static void mshare_vm_op_unmap_page_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
+{
+	/*
+	 * The msharefs vma is being unmapped. Do not unmap pages in the
+	 * mshare region itself.
+	 */
+}
+
 static const struct vm_operations_struct msharefs_vm_ops = {
 	.may_split = mshare_vm_op_split,
 	.mprotect = mshare_vm_op_mprotect,
+	.unmap_page_range = mshare_vm_op_unmap_page_range,
 };
 
 /*
-- 
2.43.5


