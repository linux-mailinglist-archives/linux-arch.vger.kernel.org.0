Return-Path: <linux-arch+bounces-6986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662296ACD9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6CC1C23C28
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601111D79A3;
	Tue,  3 Sep 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6VunbqX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B71D9D6F;
	Tue,  3 Sep 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405853; cv=none; b=P5sTlI6pBXD8pQS0WSVacyNgK6q9EZJI6XVkqQT8rgMlJA58dMH8vjuHLmBd44yGe3EXCA8WfiQgLNqbnOw6i86/CDnC4S0IfuAdwz4RqUFo5Jo4za9/kSLebm81ZyfO+MX0m8qkBnoWD0hphuKXL4OAJJVWTNEK+XZ2aO8lfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405853; c=relaxed/simple;
	bh=XI7RIDWVv9618/pl+3asj62kXvUVuj11YsnW63s4z1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKwamX2eCBOKFpvvpMiY1W6uiLz2SeH5X0ylF2t8BNDZAFTJ8v7J2hQF9RDVOX10rD9Y0dCnjEPzzC2flANJvop7k8V0NaaeT2w1++QYRRl76SlOt/wPgHDJl7yUUjKJOCcFNiqCWMhMQ9Dke6faBDgCC72ELhrSmKqIYSrLUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h6VunbqX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBUsR028873;
	Tue, 3 Sep 2024 23:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Z
	opa4j/YG9ypfcYjVylIZK6eOHt2AhaFVb3bFR+h2R0=; b=h6VunbqXq7Bp5fy3K
	vROsz7xaF1ga6xe+IdCk7NIersH2TEIx+n55RSTobgnwZRnBc4AGbLXewz0DqcgG
	d7xXJncUcGErVEQSlSKaWTfjB4UEagI8SVJBFHWj556KQ+vzogJ0ds1t2hiVGDW6
	edUxjOwoHctJhlDga2SctYImPafF5uRhpyhPekQD8zIr8dSufRBa3HszJ+a5lV/5
	jmFZSX3O+4RngMR7EoBwGuNLLkNtnPfGaid2Q0nsA1hn2vDQhOOUDKO+IMvZ9HAf
	oUZLmkpxxySAsp5y2SKpX92oeSOmHwN2RFI83NypOSf7vsyrv2OA6zC83mh5n3A3
	IopEA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dwndj1b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483LOnF5001684;
	Tue, 3 Sep 2024 23:23:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmnj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:23:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkfM040456;
	Tue, 3 Sep 2024 23:23:41 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-9;
	Tue, 03 Sep 2024 23:23:41 +0000
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
Subject: [RFC PATCH v3 08/10] mm/mshare: Add basic page table sharing support
Date: Tue,  3 Sep 2024 16:22:39 -0700
Message-ID: <20240903232241.43995-9-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: qZisTCCz9aXLQkiiG6O8unjhEMrL-EHe
X-Proofpoint-ORIG-GUID: qZisTCCz9aXLQkiiG6O8unjhEMrL-EHe

From: Khalid Aziz <khalid@kernel.org>

Add support for handling page faults in an mshare region by
redirecting the faults to operate on the mshare mm_struct and
vmas contained in it and to link the page tables of the faulting
process with the shared page tables in the mshare mm.
Modify the unmap path to ensure that page tables in mshare regions
are kept intact when a process exits. Note that they are also
kept intact and not unlinked from a process when an mshare region
is explicitly unmapped which is bug to be addressed.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/internal.h |  1 +
 mm/memory.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/mshare.c   | 38 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8005d5956b6e..8ac224d96806 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1578,6 +1578,7 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vma, unsigned long *addrp);
 static inline bool vma_is_shared(const struct vm_area_struct *vma)
 {
 	return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
diff --git a/mm/memory.c b/mm/memory.c
index 3c01d68065be..f526aef71a61 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -387,11 +387,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			vma_start_write(vma);
 		unlink_anon_vmas(vma);
 
+		/*
+		 * There is no page table to be freed for vmas that
+		 * are mapped in mshare regions
+		 */
 		if (is_vm_hugetlb_page(vma)) {
 			unlink_file_vma(vma);
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
-		} else {
+		} else if (!vma_is_shared(vma)) {
 			unlink_file_vma_batch_init(&vb);
 			unlink_file_vma_batch_add(&vb, vma);
 
@@ -399,7 +403,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && !vma_is_shared(next)) {
 				vma = next;
 				next = mas_find(mas, ceiling - 1);
 				if (unlikely(xa_is_zero(next)))
@@ -412,7 +417,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 			unlink_file_vma_batch_final(&vb);
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
-		}
+		} else
+			unlink_file_vma(vma);
+
 		vma = next;
 	} while (vma);
 }
@@ -1797,6 +1804,13 @@ void unmap_page_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	/*
+	 * No need to unmap vmas that share page table through
+	 * mshare region
+	 */
+	 if (vma_is_shared(vma))
+		return;
+
 	BUG_ON(addr >= end);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
@@ -5801,6 +5815,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
 	bool is_droppable;
+	bool shared = false;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5808,6 +5823,21 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (ret)
 		goto out;
 
+	if (unlikely(vma_is_shared(vma))) {
+		/* XXX mshare does not support per-VMA locks yet so fallback to mm lock */
+		if (flags & FAULT_FLAG_VMA_LOCK) {
+			vma_end_read(vma);
+			return VM_FAULT_RETRY;
+		}
+
+		ret = find_shared_vma(&vma, &address);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE)) {
@@ -5843,6 +5873,32 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (is_droppable)
 		ret &= ~VM_FAULT_OOM;
 
+	/*
+	 * Release the read lock on the shared mm of a shared VMA unless
+	 * unless the lock has already been released.
+	 * The mmap lock will already have been released if __handle_mm_fault
+	 * returns VM_FAULT_COMPLETED or if it returns VM_FAULT_RETRY and
+	 * the flags FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT are
+	 * _not_ both set.
+	 * If the lock was released earlier, release the lock on the task's
+	 * mm now to keep lock state consistent.
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if ((ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) == 0) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+				(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		if (release_mmlock)
+			mmap_read_unlock(mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mshare.c b/mm/mshare.c
index f3f6ed9c3761..8f47c8d6e6a4 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock_types.h>
 #include <uapi/linux/magic.h>
 #include <uapi/linux/msharefs.h>
+#include "internal.h"
 
 struct mshare_data {
 	struct mm_struct *mm;
@@ -33,6 +34,43 @@ struct msharefs_info {
 static const struct inode_operations msharefs_dir_inode_ops;
 static const struct inode_operations msharefs_file_inode_ops;
 
+/* Returns holding the host mm's lock for read.  Caller must release. */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
+{
+	struct vm_area_struct *vma, *guest = *vmap;
+	struct mshare_data *m_data = guest->vm_private_data;
+	struct mm_struct *host_mm = m_data->mm;
+	unsigned long host_addr;
+	pgd_t *pgd, *guest_pgd;
+
+	mmap_read_lock(host_mm);
+	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
+	pgd = pgd_offset(host_mm, host_addr);
+	guest_pgd = pgd_offset(guest->vm_mm, *addrp);
+	if (!pgd_same(*guest_pgd, *pgd)) {
+		set_pgd(guest_pgd, *pgd);
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
 /*
  * Disallow partial unmaps of an mshare region for now. Unmapping at
  * boundaries aligned to the level page tables are shared at could
-- 
2.43.5


