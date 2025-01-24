Return-Path: <linux-arch+bounces-9893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40489A1BF51
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 00:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E5163411
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22561EEA5D;
	Fri, 24 Jan 2025 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mm1LIh12"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F11EEA2C;
	Fri, 24 Jan 2025 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762980; cv=none; b=VjRNvnUDG9AD6y/Yp+1WcuY780rfohBHP4+3qY5Li0jbysL2ZtPdeLnLUbJUXGjeJgtM5fu7hZc0FqzFf2NFM7EK7tKKXtHJBroUQ+5KIoHgm4Rndna4UodeJ7lpFJDf+N91qKpTOl9GXxwSOx8Wbgz+aDx5IyN/8HVdcSMaYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762980; c=relaxed/simple;
	bh=lzvBO4yX3D/dD9KhQ92TR352Jq+289sMGHtFZgSsg8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiOrisofpYsoqJQ+0eLR7iB3vE3zVO+TcNTTibQb53Ir0r6Bkak9Ybekcec2X5FrzEXn9YrqbQFJ5YfCYyTkkWP6/G9Ut48b8SEt5HazbGLz/1E9ge1mFf1elI3eyo5kOga1r1cidoc0UakP4ThQ2eIKChU5Q+iTQimaob7mA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mm1LIh12; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIbuNm019103;
	Fri, 24 Jan 2025 23:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=brN5Y
	FFSbK9qb6sU8kyqnzGs0ZV4dIdkz0Y2OGeQQDI=; b=Mm1LIh125wbmWKLr3jwj4
	R7menthV7n7TpEZr/0aypVito0pT68YHzWA2WWLbgm9qulCEOARfgF22jhK4ghzu
	JuFx9Tq5FDeJqPnFnV+tQfW55CPAHFNEg5nuyZD0XTE2kdsyH4gNFjFfdHuOH9ze
	7sYTwIl4yAYK1WjO1snF2PKEEohEso8ZJ2pTjai5F6/SXKLeGDoRNdftR0fnjKV5
	iuzXnAnoHPloNzwNDPGr1PwAmV+vfmrRujHz5+hIW2/YF2IwYvAYEi2v6xh5aP3e
	NHyYjMFdt6qYoyOw47Z5bbiE65oHmOmMD1L48ApCP5PIAkliRqBYxIaESjoAgv/q
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qaw404-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OLoFNG036500;
	Fri, 24 Jan 2025 23:55:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917u4ag8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 23:55:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50ONsxQ6018051;
	Fri, 24 Jan 2025 23:55:45 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-130-174.vpn.oracle.com [10.65.130.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917u49ww-13;
	Fri, 24 Jan 2025 23:55:45 +0000
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
Subject: [PATCH 12/20] mm/mshare: prepare for page table sharing support
Date: Fri, 24 Jan 2025 15:54:46 -0800
Message-ID: <20250124235454.84587-13-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: np-h1M02s4XSflXejt2j3zPrBIjWPfJo
X-Proofpoint-ORIG-GUID: np-h1M02s4XSflXejt2j3zPrBIjWPfJo

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
 mm/memory.c        | 38 ++++++++++++++++++++++------
 mm/mshare.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1314af11596d..9889c4757f45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1110,11 +1110,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
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
index 20bafbb10ea7..9374bb184a5f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -263,7 +263,8 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 
 static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool shared_pud)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -275,7 +276,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
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
@@ -297,9 +301,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
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
@@ -355,10 +360,17 @@ void free_pgd_range(struct mmu_gather *tlb,
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
@@ -395,9 +407,12 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 
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
@@ -408,9 +423,11 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
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
@@ -6148,6 +6165,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
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
index 8dca4199dd01..9ada1544aeb1 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -42,6 +42,56 @@ static const struct mmu_notifier_ops mshare_mmu_ops = {
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
@@ -53,9 +103,21 @@ static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start
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


