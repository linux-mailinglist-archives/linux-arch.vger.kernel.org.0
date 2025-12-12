Return-Path: <linux-arch+bounces-15375-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451CCB812B
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 08:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F165301D30F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5C30F7F3;
	Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnkHi+gB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADD30F7E9;
	Fri, 12 Dec 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523429; cv=none; b=MTGF5HFjqr4C9RhP4RO1gP63bwCD6oh+lsH3hsgM+RzZMrrE4ClHQGxgtMKng8qzEqsCQapUJsGdxecqLP7ThxaWdj6Ncwms/KELo6IQRn7jjeb2LOaFhUlSbjX9mEVJdo340koEzAZldp3RTbx8ceLVQ+VlHaoq0gNsBjkjmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523429; c=relaxed/simple;
	bh=Dw8ngcXvfO/801VaaTPwfZV46DR1ilbRLvNzIebB3mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvtAdLohE8S0BCRwWy4RvUqaglIyPl9lsjo4LbyLgDJbjtdMswmg9ej/95G0nFFPdhnxA1jYHHw0dpAYmUBJT7msOt4/rPFCNyfV519At0yfOMyzgld6tF9V07XLqFrfeKonaMwA2gtbL3RLI7Vz8lG41Hvd/xvdJhKo2Sm47pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnkHi+gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3558C116B1;
	Fri, 12 Dec 2025 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765523428;
	bh=Dw8ngcXvfO/801VaaTPwfZV46DR1ilbRLvNzIebB3mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnkHi+gBWxOHQIxs0FI0ulwlC7AacMDuWR883V9LK0fZEBcmOM7Bef9Ntx0f0WCyQ
	 As2MkpysxWbOfrwtar89uCRwZ+ZSNA8cbh6/YJkP630pK6i73diHLetvg/QStw07mQ
	 cPQ/6z9hGfCsG+bQXSrtKAB32pkAFig2GGvZ0nBSbYa9ZFbh+AgZy34fPqWdA+ARwq
	 aS8rWfq0bkj7b9LIPjReOmFLwAVLuRzvSdsEUb0lbqX6scQTrtaIyNc74LnM+1XME/
	 NT6AK2S5O7KZZqddAVKONK3B0T5U+6EQ9gQB203eqagbqpfD5Gre3swwOplbYo2dp6
	 Wo2VvzuwGgJ7w==
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
Subject: [PATCH v2 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Date: Fri, 12 Dec 2025 08:10:16 +0100
Message-ID: <20251212071019.471146-2-david@kernel.org>
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


