Return-Path: <linux-arch+bounces-15547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFDCDAB17
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5684E3013EB1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D043115B1;
	Tue, 23 Dec 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQZLwkdd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2230F7F8;
	Tue, 23 Dec 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526052; cv=none; b=VhDth5kngqkawC6caWaOnpPdZMCV3nnG+Dcx48BLhlXIbZ9plVybHdn0vdm7ttqud6NOMK3jHqmHuR3p+NT7csNuweOct8bAtXy3z8Y29ehgmZy8ZEV3QsqposMqmn+pdaqpJq2pPFNnoejRd1lTYB0l2TAynrK4+HjOfEUpA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526052; c=relaxed/simple;
	bh=Dw8ngcXvfO/801VaaTPwfZV46DR1ilbRLvNzIebB3mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyKsguf6wO1hEh2ZjhofEHf7xt9OWeqsKliBCDmCz5cLi6cuPlIR0PzA/OT022CPNtDuztD+LGZMI0N7O3beUHMcKki/t7U9GhMv/AGcRsrJS1QNZlsxTxHPWKc0SbmocCB3GcmHazuAhr10JeqDjDnR1f4DeE/SOYuHN+K+T50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQZLwkdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D290DC113D0;
	Tue, 23 Dec 2025 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526052;
	bh=Dw8ngcXvfO/801VaaTPwfZV46DR1ilbRLvNzIebB3mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQZLwkddwu0TOjpJpvCT0+kwHRe1R21Fr+XRRme80mPpGUGpf6rsiE3wvIfWbZ6TX
	 0rsdzKQezUzqVDnWgKOBvw7U3+SE6xtzwbbApJeG5zOHsx+DlLD9CaakccvKgBXJ0W
	 CMnSk9ClrJ2BXjzXkXNF7K7vIOzH48I72+GVSrmisNSsTgUVVPXWZgA29xWDmOiHYr
	 N1Z7W5LrcykEPz9XYsxfV3LHn8HPu41mdYzS2z80+7G8oSS+SRiqIliTPpXqxOl5Aq
	 TEeqAZVmbciioOkYUoms7NkENBK1kv6eu+4zpOgl8R5QU48034Lj965/z35jmejK9B
	 NiaFeAvfHdzaQ==
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
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org,
	Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH RESEND v3 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Date: Tue, 23 Dec 2025 22:40:34 +0100
Message-ID: <20251223214037.580860-2-david@kernel.org>
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

We switched from (wrongly) using the page count to an independent
shared count. Now, shared page tables have a refcount of 1 (excluding
speculative references) and instead use ptdesc->pt_share_count to
identify sharing.

We didn't convert hugetlb_pmd_shared(), so right now, we would never
detect a shared PMD table as such, because sharing/unsharing no longer
touches the refcount of a PMD table.

Page migration, like mbind() or migrate_pages() would allow for migrating
folios mapped into such shared PMD tables, even though the folios are
not exclusive. In smaps we would account them as "private" although they
are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
pagemap interface.

Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().

Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Cc: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/hugetlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 019a1c5281e4e..03c8725efa289 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
 static inline bool hugetlb_pmd_shared(pte_t *pte)
 {
-	return page_count(virt_to_page(pte)) > 1;
+	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
 }
 #else
 static inline bool hugetlb_pmd_shared(pte_t *pte)
-- 
2.52.0


