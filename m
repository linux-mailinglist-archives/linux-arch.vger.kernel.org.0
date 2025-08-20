Return-Path: <linux-arch+bounces-13205-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B15CB2D0F1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 03:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85E4A00867
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF741B0F19;
	Wed, 20 Aug 2025 01:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQOU23n/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43719C558;
	Wed, 20 Aug 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651952; cv=none; b=JRhnqmNfEs2S+MiuhZTrP/Nru/Wm2lQNtZn0hRw66ly07f2cSyDl3czmqDK+/raMer2buh1kfnNOfT4QlInsrR5a+FHkza+SEeSsWRqUudlTig2NrQjXPZekAFaNqqXu9veOmbNvYQ/uTz0nf/xGbt4Gb96WHpBCk5IzZmuGVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651952; c=relaxed/simple;
	bh=hxRffp3Ng6NjJf68DfwLew2B+T4koeIMJF7H56OM5JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG/N8Q7NvwDBXLZe3TRY97s56gVGiPZ7tX0kyq7te4SWTU40ouHr5q+URkw+XGxQQMXsxudlH1DwZhXFMgIjobP36Sg2EwaqR9RxDWStO8Mn97ArmaON7G0xRMFdBKnzw6zh0GzbOFSJhYuC+cEjrg8b5/2ZN3btq3CTAs1Yb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQOU23n/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLBrL3005739;
	Wed, 20 Aug 2025 01:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aTCOK
	Z54R6TXOK6l3PvLQlmdTpFS20mjQ2epoOBlYkw=; b=OQOU23n/RfYRKc5h5GRAy
	yIy6JJ62m9PD4vdEPNvz8l1uBz0Y/6ULoHuZL38fTG/icIZqnxv9Ln+UrHJhhM0E
	WQND59BPxaOIXfFJ0oR72Fb3HU9JxVhiEXs8KRbGO3BS95LSxVwWNaCu0eLkc36y
	wJY89Kcp5fQXWgjg6tTgxWg/nqCpViyPKVxBAQOnWOZXhGrB0XIru7+2TA+PvE7u
	CH+4Odzha0ejI2gVYDGQwac9RrW3XvTlpyfITZWlkxLq5sIHDYm1dpfztSEYgI2x
	fz/bpktBJ0s3TyAqhkOuD2Iw0NHtPuhl1jOKrl049bFem3b0W3+q47h4De9VDUn8
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsr84s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57K02PP9007367;
	Wed, 20 Aug 2025 01:04:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3q2a06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 01:04:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57K14NdS011685;
	Wed, 20 Aug 2025 01:04:55 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48my3q29gw-13;
	Wed, 20 Aug 2025 01:04:55 +0000
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
Subject: [PATCH v3 12/22] mm: introduce PUD page table shared count
Date: Tue, 19 Aug 2025 18:04:05 -0700
Message-ID: <20250820010415.699353-13-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: XkiUDz7QrV9JQbSS0E3iydrFNOELU_g0
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a51f3a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=wzGCPD0JsuPSr4ClS-4A:9
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: XkiUDz7QrV9JQbSS0E3iydrFNOELU_g0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXx8FqyQ7+B2ay
 bCJ7q/WZ++K45BiFIwOb/XZv2xR9mK6HAjlKdLED4YAI/qTI9Ep/xzvpUby2QFmqlCwg2Yrc1bp
 BUvAhvVnxG92Fem7MaInikH2sff8NGy4WUGgxQ0VHAw2QIA2ZyFdzLYJ7OOulgShQ53V9VJL/t1
 uMLaUU7CWk3PP6SnYn41CBbRMGKVQ1W2Fs3f0JuFktIRBWAywc3UG5d1xNRI/WhDLMxz0xBYvBA
 Wg+PFdmM/0qQ2YzRoYfYXXwmrwoeskpyp0Zc9xXU31k2s6MyI/cIYgRREwlabHwG9MMTFVEQJQf
 hworEMdy8ev8UiL4eTxOjFd9j4pcI6GIV/ebogIUMER5uhGHB+4cka2iwavhfZAOfT729ed7g6c
 dYqaS4HXlwwAt9q8kyQOCBOoIxFsmg==

Once an mshare shared page table has been linked with one or more
process page tables it becomes necessary to ensure that the shared
page table is not completely freed when objects in it are unmapped
in order to avoid a potential UAF bug. To do this, introduce and
use a reference count for PUD pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h | 36 ++++++++++++++++++++++++++++++++++--
 mm/memory.c              | 21 +++++++++++++++++++--
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 96440082a633..c8dfa5c6e7d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3217,6 +3217,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 
 static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
 {
+	ptdesc_pud_pts_init(ptdesc);
 	__pagetable_ctor(ptdesc);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c8f4d2a2c60b..da5a7a31a81d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -537,7 +537,7 @@ FOLIO_MATCH(compound_head, _head_3);
  * @pt_index:         Used for s390 gmap.
  * @pt_mm:            Used for x86 pgds.
  * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
- * @pt_share_count:   Used for HugeTLB PMD page table share count.
+ * @pt_share_count:   Used for HugeTLB PMD or Mshare PUD page table share count.
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
@@ -564,7 +564,7 @@ struct ptdesc {
 		pgoff_t pt_index;
 		struct mm_struct *pt_mm;
 		atomic_t pt_frag_refcount;
-#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+#if defined(CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING) || defined(CONFIG_MSHARE)
 		atomic_t pt_share_count;
 #endif
 	};
@@ -638,6 +638,38 @@ static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
 }
 #endif
 
+#ifdef CONFIG_MSHARE
+static inline void ptdesc_pud_pts_init(struct ptdesc *ptdesc)
+{
+	atomic_set(&ptdesc->pt_share_count, 0);
+}
+
+static inline void ptdesc_pud_pts_inc(struct ptdesc *ptdesc)
+{
+	atomic_inc(&ptdesc->pt_share_count);
+}
+
+static inline void ptdesc_pud_pts_dec(struct ptdesc *ptdesc)
+{
+	atomic_dec(&ptdesc->pt_share_count);
+}
+
+static inline int ptdesc_pud_pts_count(struct ptdesc *ptdesc)
+{
+	return atomic_read(&ptdesc->pt_share_count);
+}
+#else
+static inline void ptdesc_pud_pts_init(struct ptdesc *ptdesc)
+{
+}
+
+static inline int ptdesc_pud_pts_count(struct ptdesc *ptdesc)
+{
+	return 0;
+}
+#endif
+
+
 /*
  * Used for sizing the vmemmap region on some architectures
  */
diff --git a/mm/memory.c b/mm/memory.c
index dbc299aa82c2..4e3bb49b95e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -228,9 +228,18 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	mm_dec_nr_pmds(tlb->mm);
 }
 
+static inline bool pud_range_is_shared(pud_t *pud)
+{
+	if (ptdesc_pud_pts_count(virt_to_ptdesc(pud)))
+		return true;
+
+	return false;
+}
+
 static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool *pud_is_shared)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -257,6 +266,10 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 		return;
 
 	pud = pud_offset(p4d, start);
+	if (unlikely(pud_range_is_shared(pud))) {
+		*pud_is_shared = true;
+		return;
+	}
 	p4d_clear(p4d);
 	pud_free_tlb(tlb, pud, start);
 	mm_dec_nr_puds(tlb->mm);
@@ -269,6 +282,7 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 	p4d_t *p4d;
 	unsigned long next;
 	unsigned long start;
+	bool pud_is_shared = false;
 
 	start = addr;
 	p4d = p4d_offset(pgd, addr);
@@ -276,7 +290,8 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		free_pud_range(tlb, p4d, addr, next, floor, ceiling);
+		free_pud_range(tlb, p4d, addr, next, floor, ceiling,
+				&pud_is_shared);
 	} while (p4d++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
@@ -290,6 +305,8 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 	if (end - 1 > ceiling - 1)
 		return;
 
+	if (unlikely(pud_is_shared))
+		return;
 	p4d = p4d_offset(pgd, start);
 	pgd_clear(pgd);
 	p4d_free_tlb(tlb, p4d, start);
-- 
2.47.1


