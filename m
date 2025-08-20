Return-Path: <linux-arch+bounces-13218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFBB2D127
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A653526E68
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F6222582;
	Wed, 20 Aug 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozxUXBvo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6A21D59C;
	Wed, 20 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651965; cv=none; b=IOc8R94rWN7UrnjrNsbY1Hns1IJIVW5i/mZKKSyrE/T5sPmrttgQPnwAwBA8/y5BbgGhDuXRcPhzwD5sBYNIqVSbo+u23FLqPEPdEwvCxwTFtlLuRBhMtq4DvMCuyG/tNihEAkp40ueg2fNaLc2ou2NqCj5hWJ77qncRO6kx30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651965; c=relaxed/simple;
	bh=cMZcpkHmcHjFanFwDYa6TFvc40+sPi1388/+2JhmLT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG+MfJAc949Iq4YLtMG3U6n/cvuV4vq7EyNaDcXMViWz8ZCM+XHdkLHjdYqHrDM8r1rUqyxiUH06pSSF3xd5SPrr2e4X6Ip3Jeew1FCtHUvLzMhTfLn7ygoIhfrkC8T5WpOreuSoufbe7+XEKOHtfPXYH2dt8wYmejGEjLT2IUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozxUXBvo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBn4r002950;
	Wed, 20 Aug 2025 01:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=eSh7Z
	5LIKWQz5MJlTe0n+mPXy6c+OfFvOssfN/OYZ+U=; b=ozxUXBvoCo7n4QRzMHRtg
	UA1ZigpOutCYZOWM0/c6crdoHv7J/n0fMq7pTwoPWLSFgpKjs32ExntMFlSDSPCH
	FJGJkqpf0gykyDCAk9f1WI/EHg1pdQlF99pRjAQqd7+reRjWy+P48UVSixluV9YK
	dChXTluN+NvHeG9ihbKo3I2aRHc3vl7vIx/JPEn3+sDAb575drdnIWuKyIoz5RvG
	CQtBImFZmJ7kbhlvEQJ9mhkLwGsitk7CbLlTOSIddvapixy7cHrdANhFR3PWs2ip
	umepQlFnkNWhNMmFgYrlysUCSG0hu5U19bA2Ph3Cec+CjezFaQrN5jFrD7w3KquU
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr0866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:05:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JN39ek007104;
	Wed, 20 Aug 2025 01:04:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdU011685;
	Wed, 20 Aug 2025 01:04:58 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-14;
	Wed, 20 Aug 2025 01:04:57 +0000
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
Subject: [PATCH v3 13/22] mm/mshare: prepare for page table sharing support
Date: Tue, 19 Aug 2025 18:04:06 -0700
Message-ID: <20250820010415.699353-14-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: DdG8eFm3x5GuGQmLEDIxP2XBUph5-Pkq
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a51f3d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=8yVM5d_fee57hvELVi4A:9 a=1CNFftbPRP8L7MoqJWF3:22 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: DdG8eFm3x5GuGQmLEDIxP2XBUph5-Pkq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX7eSvXIMaq74g
 MSb6UQgPEncgspwK4IRk8qKGWMQzI4JGbGk4BatH1QQHsui22yLkpZPVPBPQfjqtQTiN0ep2k6W
 M6BQcIe2fbncW7jvgeClOtolBvWg36AkdzmHVCZYxHoIabcTkTuW5C00CavuIKXOupPDyPuylCr
 0kVj3XXcYjB6JzrYMH+I34DsiHKFx4AQk2Smv4j0zuzMYBCPByTBDYitjZMeGOCn01VjXUmt3E0
 xFS7/qzSGje+Ru7jKI4IycPp70kZ/cyneEKFc3X1S+M7iCY4UitPa9HOLiOFM1MvWl2jgKpMid+
 X79yW5wkWL+tSEg21KdHvEWTIEV8J7ysVSTqAkR4juZFr/8D/XZXASSoXq4vXEaeQq/PjzyMAyJ
 kybryL6bfrryWTcTA9aJsKRB/ZQeIw==

From: Khalid Aziz <khalid@kernel.org>

In preparation for enabling the handling of page faults in an mshare
region provide a way to link an mshare shared page table to a process
page table and otherwise find the actual vma in order to handle a page
fault. Implement an unmap_page_range vm_ops function for msharefs VMAs
to unlink shared page tables when a process exits or an mshare region
is explicitly unmapped.

Signed-off-by: Khalid Aziz <khalid@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h |   6 +++
 mm/memory.c        |   6 +++
 mm/mshare.c        | 107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c8dfa5c6e7d4..3a8dddb5925a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1009,11 +1009,17 @@ static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false;
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
index 4e3bb49b95e2..177eb53475cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6475,6 +6475,12 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (ret)
 		goto out;
 
+	if (unlikely(vma_is_mshare(vma))) {
+		WARN_ON_ONCE(1);
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE)) {
diff --git a/mm/mshare.c b/mm/mshare.c
index be7cae739225..f7b7904f0405 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -21,6 +21,8 @@
 #include <linux/falloc.h>
 #include <asm/tlbflush.h>
 
+#include <asm/tlb.h>
+
 const unsigned long mshare_align = P4D_SIZE;
 const unsigned long mshare_base = mshare_align;
 
@@ -50,6 +52,66 @@ static const struct mmu_notifier_ops mshare_mmu_ops = {
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
+		spinlock_t *guest_ptl = &guest->vm_mm->page_table_lock;
+
+		spin_lock(guest_ptl);
+		if (!p4d_same(*guest_p4d, *p4d)) {
+			pud_t *pud = p4d_pgtable(*p4d);
+
+			ptdesc_pud_pts_inc(virt_to_ptdesc(pud));
+			set_p4d(guest_p4d, *p4d);
+			spin_unlock(guest_ptl);
+			mmap_read_unlock(host_mm);
+			return VM_FAULT_NOPAGE;
+		}
+		spin_unlock(guest_ptl);
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
@@ -61,9 +123,54 @@ static int mshare_vm_op_mprotect(struct vm_area_struct *vma, unsigned long start
 	return -EINVAL;
 }
 
+/*
+ * Unlink any shared page tables in the range and ensure TLBs are flushed.
+ * Pages in the mshare region itself are not unmapped.
+ */
+static void mshare_vm_op_unshare_page_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
+				unsigned long addr, unsigned long end,
+				struct zap_details *details)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl = &mm->page_table_lock;
+	unsigned long sz = mshare_align;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	WARN_ON(!vma_is_mshare(vma));
+
+	tlb_start_vma(tlb, vma);
+
+	for (; addr < end ; addr += sz) {
+		spin_lock(ptl);
+
+		pgd = pgd_offset(mm, addr);
+		if (!pgd_present(*pgd)) {
+			spin_unlock(ptl);
+			continue;
+		}
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_present(*p4d)) {
+			spin_unlock(ptl);
+			continue;
+		}
+		pud = p4d_pgtable(*p4d);
+		ptdesc_pud_pts_dec(virt_to_ptdesc(pud));
+
+		p4d_clear(p4d);
+		spin_unlock(ptl);
+		tlb_flush_p4d_range(tlb, addr, sz);
+	}
+
+	tlb_end_vma(tlb, vma);
+}
+
 static const struct vm_operations_struct msharefs_vm_ops = {
 	.may_split = mshare_vm_op_split,
 	.mprotect = mshare_vm_op_mprotect,
+	.unmap_page_range = mshare_vm_op_unshare_page_range,
 };
 
 /*
-- 
2.47.1


