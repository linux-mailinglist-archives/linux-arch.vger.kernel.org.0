Return-Path: <linux-arch+bounces-15376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9474ECB8164
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 08:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88F830AC64F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECEE30F54C;
	Fri, 12 Dec 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se6W7wJX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90912F5A3B;
	Fri, 12 Dec 2025 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523434; cv=none; b=jpNkWhu87T0WW9kbZ1uW85dkmGo6MQzeSZxQFQAtc6U+35kdnhGQU7Vq9zG0CxOPAE2SJXj+vT/Mf6dQmPbYV4Q8W2GJ/LM409hUyJ8h/5vQ6mWGIxlslmlpfGtB8s+lFznJ+adhoRs+zdILqtdPiEz7lCJ1Oor+VdqkqM87H8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523434; c=relaxed/simple;
	bh=0RZwH8fvxgrQifnKyq2TorkfWiaSbHYH9Z5fLbKuKTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvfxdhfUJ0cgKclcfK54Zpx9XAzegZDbJ0BODEwv/+PTk1mLodUECU8clEc/S1ZYuK0/vo4wi9NZXM494v+v01yWKBGuPIDsIzTQAXT7QEySNBaoBI7WFo3siAVPFhnvs4ty5+KX/sUmAotPhrXYsSvndSPfHlUHHGfcZs9g9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se6W7wJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A91C4CEF1;
	Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765523434;
	bh=0RZwH8fvxgrQifnKyq2TorkfWiaSbHYH9Z5fLbKuKTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se6W7wJXAJn000CvW1Idyi+iVZ21IWzMA00M/0FwGvJNR+0B4xpu/0uLD82YIKc/6
	 2oLF+AWZHXRxaKht06GtmcT/ZqXx6GXGVIUIrNxDLRRO7dPpHNYYSFCyVYXebWX7zu
	 Hs/zwXMCnXdX6380gB6s9LR4sb0q+gLv1qrM29qgosDeLfrtcm0quCXRrLyVXdz7jT
	 2HrEESmd2VgETIrI5XyxrdiHctqZaEOg/1W7Tk0Mnb9fUiVCyy72oNq6wXOzdEHC6f
	 9vjPe2ANh8uZSCFvTrSHTRFnILOC3Aa1LGEtmXtWJGfnUsd0k4wGq4FzmzmwoZKJ00
	 1iDRh4pGqB2eg==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Laurence Oberman <loberman@redhat.com>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/4] mm/hugetlb: fix two comments related to huge_pmd_unshare()
Date: Fri, 12 Dec 2025 08:10:17 +0100
Message-ID: <20251212071019.471146-3-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212071019.471146-1-david@kernel.org>
References: <20251212071019.471146-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since we stopped using the page count to detect shared PMD
page tables, these comments are outdated.

The only reason we have to flush the TLB early is because once we drop
the i_mmap_rwsem, the previously shared page table could get freed (to
then get reallocated and used for other purpose). So we really have to
flush the TLB before that could happen.

So let's simplify the comments a bit.

The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
correctly after huge_pmd_unshare") was confusing: sure it is recorded
in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
anything. So let's drop that comment while at it as well.

We'll centralize these comments in a single helper as we rework the code
next.

Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/hugetlb.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51273baec9e5d..3c77cdef12a32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	tlb_end_vma(tlb, vma);
 
 	/*
-	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
-	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last reference would not be dropped. But we must
-	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
-	 * dropped and the last reference to the shared PMDs page might be
-	 * dropped as well.
-	 *
-	 * In theory we could defer the freeing of the PMD pages as well, but
-	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
-	 * detect sharing, so we cannot defer the release of the page either.
-	 * Instead, do flush now.
+	 * There is nothing protecting a previously-shared page table that we
+	 * unshared through huge_pmd_unshare() from getting freed after we
+	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
+	 * succeeded, flush the range corresponding to the pud.
 	 */
 	if (force_flush)
 		tlb_flush_mmu_tlbonly(tlb);
@@ -6536,11 +6529,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		cond_resched();
 	}
 	/*
-	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
-	 * may have cleared our pud entry and done put_page on the page table:
-	 * once we release i_mmap_rwsem, another task can do the final put_page
-	 * and that page table be reused and filled with junk.  If we actually
-	 * did unshare a page of pmds, flush the range corresponding to the pud.
+	 * There is nothing protecting a previously-shared page table that we
+	 * unshared through huge_pmd_unshare() from getting freed after we
+	 * release i_mmap_rwsem, so flush the TLB now. If huge_pmd_unshare()
+	 * succeeded, flush the range corresponding to the pud.
 	 */
 	if (shared_pmd)
 		flush_hugetlb_tlb_range(vma, range.start, range.end);
-- 
2.52.0


