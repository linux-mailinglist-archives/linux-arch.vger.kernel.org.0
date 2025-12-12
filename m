Return-Path: <linux-arch+bounces-15377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73015CB813A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 08:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFE1301C88B
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344E244671;
	Fri, 12 Dec 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5LXJHbl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8A3C38;
	Fri, 12 Dec 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523439; cv=none; b=fPeWpNJd/CsJgAL68LxseW6sSmrTzaZO3plyrBXwYLISe8FBZOCmtCyrtoe7YQRA/dIF8MGgnXoFy59+dzmNzcYVPIOcn00o999fljzDCvCne5m6f8S1lVQyBT5xwvN6yhxi8uhuGK1a0rmxzHbUuYqh8iUOt1+DK5LXJEXtj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523439; c=relaxed/simple;
	bh=W3HxSY2RwX3H9YY1vxQutvRujCU+HdANvwda7ib8N5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1++E/WmF7qlAW92QXkHtQKk4wG3m6uPO2W92/qiYbdaKhIVXCkLB9L/aLgN6xgGcIvcgpEN5CHOJgYGCPYIG+EjVkcaaSKQjpIIubI7WsAEYFaZb89a8jcsI33wJaylp5x1A9bqXdtD7JcCeLd/9DuP2Xy1cjUkOUpdG67CW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5LXJHbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C923AC16AAE;
	Fri, 12 Dec 2025 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765523439;
	bh=W3HxSY2RwX3H9YY1vxQutvRujCU+HdANvwda7ib8N5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5LXJHbl4t/yZePoL+B5dBMynM55zoKdjs6ice5C3xI5rbw1w9yHevZvI2Z3SCTQC
	 epN47mXBxt2TgCEbXYLwoX4ReQ1KACjDgTW6eLNJLmRRe2IeIbtQkolqfsKWQLjgko
	 jOZXndjc2E927pjnwZ6kE31RuOUIGctXO1JScVN7e+llDB+mxePARPVqHdzWWqO6wR
	 ErDnwnI4ySKKsvOAGXTDE9AJ3ZjpiJPgUnfTOLPbnbHE4PmSeSUBzyk4SRg6q133S1
	 PrTkOshx7hKd6jqgwtfMwidp2PG52GKbGQ3dXjkC8y8/1tZmw2ZS3RGOam4VfhV+4b
	 4TDP4pqH1yCqQ==
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
Subject: [PATCH v2 3/4] mm/rmap: fix two comments related to huge_pmd_unshare()
Date: Fri, 12 Dec 2025 08:10:18 +0100
Message-ID: <20251212071019.471146-4-david@kernel.org>
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


