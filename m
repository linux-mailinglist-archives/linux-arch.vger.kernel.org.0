Return-Path: <linux-arch+bounces-15548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119ACDAB14
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 22:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 483223014421
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934530F95C;
	Tue, 23 Dec 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUIXYIeb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D030F7F8;
	Tue, 23 Dec 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526058; cv=none; b=lUsKEvp4Hc+SCSZaiGWf77AzNoTc4hfkMHtBsev8zfyNRc8Aht02prJkdgGIeqx+S4pg37CiZgK/oqFODho32bgnZu/bk7v5ZseuInI+sDPA8TwJ0q1KtA2psjYhQLuVz4mvaew/t/gvjPFezN6iCnCKu8YyRBbtneD0Zb+Na3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526058; c=relaxed/simple;
	bh=33B1NjB8q+KbqoS4RdUZuJYWp5unOxxMAqt5/OJnfDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aeyt76VONiCgTnFexnXazrPguGknRs23HMz0VEQDlBCrdy9wBoP++UBdXZP2xn3ZdFoBX1m9mX0upN8QpbZifQfOEdHf9njgusnZMQdTT4qDBtc7c1epnlzNkFZhNzG6sXvqjBN+3QRzK3LMG+d1Xm1O7rw8cAAimXeXpVSPKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUIXYIeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA7DC116B1;
	Tue, 23 Dec 2025 21:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526058;
	bh=33B1NjB8q+KbqoS4RdUZuJYWp5unOxxMAqt5/OJnfDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUIXYIebTCcU7qzG31s1vtUtkIL93DwXQQfDphjUnZS4//aO7cOtjf1CSTBYzWY2e
	 aKSsrhiHn4132dbDLvmKMK/+q573s05LDP1qpMId4FzEQq29sKmxtCT4a6fdthYdyv
	 MQIcH1vXOOeZAObt5YhA4u18sG+Zk2HWg7TXGC0lRAwSxX/SD6sbTZRkTqIvfmYc4l
	 wA1Cm2LAZMwiRebr1nxJgoUZjQqo6YRQFvcBCk6zq8jK619mTm12VjbNldztdHDZCp
	 vEDjLXcsy2RdgIKhknKNXfUOqV6ei8JFSaBvki6RWyPJVwZe6dsguVoJ3rVyceHnWn
	 Y7z6ehGEPH0MQ==
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
Subject: [PATCH RESEND v3 2/4] mm/hugetlb: fix two comments related to huge_pmd_unshare()
Date: Tue, 23 Dec 2025 22:40:35 +0100
Message-ID: <20251223214037.580860-3-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223214037.580860-1-david@kernel.org>
References: <20251223214037.580860-1-david@kernel.org>
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
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
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


