Return-Path: <linux-arch+bounces-15543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A58CDA9D7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C157308A6E2
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EF230DD17;
	Tue, 23 Dec 2025 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHms2tR4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018130AD13;
	Tue, 23 Dec 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523069; cv=none; b=OqWjsdpZznxjJ9ocCS+PvG3NKokFqundH9L1j5cpZso6Jt2nq6ZdIss1BizRhXwmfRe9JyWjF8wTuNyA7ouJlQF7JKu6PGWsFzjp2VmFijcfSiH6yuuNMCxR+NO6t6Kq/gf0fzzs3F467tl410QQPSdwGOBu9GlJsBAkEfDKzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523069; c=relaxed/simple;
	bh=W3HxSY2RwX3H9YY1vxQutvRujCU+HdANvwda7ib8N5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9ChEP2u7VDU3XGQs612q7OWYskSetEpofT5mFrI2U8Vg1q5OGBKRTtipq7VoylkBay8KZs2TSenLmK2ZFoI+fPpAJwtqtJJRR/WcMUJHjxFlyC1nrSH/zANZQAfkOjOriqYK7jkD9tupcQ89Zo8fAzDVkjaagVc34cILwn9SgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHms2tR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E063C113D0;
	Tue, 23 Dec 2025 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766523067;
	bh=W3HxSY2RwX3H9YY1vxQutvRujCU+HdANvwda7ib8N5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHms2tR4kDPOQ8xZeR6XvdVcMUnBCculb5GtvvlY/zAWQM+3Atwwih5LYb4B42zwE
	 2bS2W2q1rzjTIG8qokrDASJLYgJ72ukhd+c7iR0P3tJvvhFS1+GB/sJbmIjXaW++Kv
	 goeDu9eKewn+PFUqRqdJkCKgPqNxtRNPgs5SotEun5pgAwl8+iqL81RuRbOwcTdvAu
	 rSHMYjMHHiOBZbe0HSEUSWIbiRdWlHbt0vDlM2NwOyysPMGPrOblcD4HL28GxdDUbd
	 6LZkpBAH+sZHXLtiF+8tAVPIp9UwUl57PSHxYLgyecPp1ZPO9o5EN2MS3cWytQIm+V
	 kk7PXygJJYxqw==
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
Subject: [PATCH v3 2/3] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Tue, 23 Dec 2025 21:50:45 +0100
Message-ID: <20251223205046.565162-3-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223205046.565162-1-david@kernel.org>
References: <20251223205046.565162-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PMD page table unsharing no longer touches the refcount of a PMD page
table. Also, it is not about dropping the refcount of a "PMD page" but
the "PMD page table".

Let's just simplify by saying that the PMD page table was unmapped,
consequently also unmapping the folio that was mapped into this page.

This code should be deduplicated in the future.

Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Cc: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 mm/rmap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index f955f02d570ed..748f48727a162 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2016,14 +2016,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					flush_tlb_range(vma,
 						range.start, range.end);
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					goto walk_done;
 				}
@@ -2416,14 +2410,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 						range.start, range.end);
 
 					/*
-					 * The ref count of the PMD page was
-					 * dropped which is part of the way map
-					 * counting is done for shared PMDs.
-					 * Return 'true' here.  When there is
-					 * no other sharing, huge_pmd_unshare
-					 * returns false and we will unmap the
-					 * actual page and drop map count
-					 * to zero.
+					 * The PMD table was unmapped,
+					 * consequently unmapping the folio.
 					 */
 					page_vma_mapped_walk_done(&pvmw);
 					break;
-- 
2.52.0


