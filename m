Return-Path: <linux-arch+bounces-15541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F26CDA9CB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD5A30421AA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CCE3090F7;
	Tue, 23 Dec 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yCeJNk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006F2F1FD5;
	Tue, 23 Dec 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523055; cv=none; b=fktWdPw3NhSAPUDg/hLC0wRvcwB+Fn12UE5xVjQz93/5ZRbyDgj63hBy/xc3qzYiu4k2QLLp54V4jBG9svWQENvXx81BQ9KxpU6ja/Z/YwKIPsTS+Dih1GVpoVGzsiBkWWgNawG3DiPqPmXTfFodOM1NeOKQwvXiukZxYk9irus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523055; c=relaxed/simple;
	bh=trDSBTaA6WTrHmc9KKJcMvZl6ePTGpic7B6VeAAp59I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFl7XNnowFgEsKRsBT/1eli6bn+bMDwp0qJQztVxUet2WMNxbiHNBHjAXWmxE3iGqkKITaKGum/p7VKtzfwTGreeS6ecd0H3NU/zREsYWlvCJ171FsumOrVOGIztfF7awhhkpLPYgFds3Q05iPbheZV8XJWhPdWHzi8lVe7Jnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yCeJNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F60DC113D0;
	Tue, 23 Dec 2025 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766523054;
	bh=trDSBTaA6WTrHmc9KKJcMvZl6ePTGpic7B6VeAAp59I=;
	h=From:To:Cc:Subject:Date:From;
	b=Q/yCeJNkMbsOr6ih8Ct52pGmKB3UNVAXspjyUHpkYkQYhmv/wN/vQqUO8B4aSVb43
	 lt4I+mitTdqcYGg20h5Pip1pBa04LihhstYsrW1UM4yUmJQJ9CnwEyADdkPOJ2/V3H
	 my76A0uDLn9HTkHIU/TX900oHCMUfofNYOF0E25WSqCOGrSR6CuTJgR9bhG8l1ETNU
	 hRJD1PIKka/M/a065jPYoCDNzUBcGVNPt7bji9JeljOrdPC8okMOZdVyARn9zRN4zV
	 xqv4o6EIaUaTqr2QODVqnH37YcRYFYC5YDMfa7OGzR41w/ax/vCctSIJD9XCIcjy7T
	 W/jfF7R/I59Ag==
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
	Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v3 0/3] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Tue, 23 Dec 2025 21:50:43 +0100
Message-ID: <20251223205046.565162-1-david@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One functional fix, one performance regression fix, and two related
comment fixes.

I cleaned up my prototype I recently shared [1] for the performance fix,
deferring most of the cleanups I had in the prototype to a later point.
While doing that I identified the other things.

The goal of this patch set is to be backported to stable trees "fairly"
easily. At least patch #1 and #4.

Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
Patch #4 is a fix for the reported performance regression due to excessive
IPI broadcasts during fork()+exit().

The last patch is all about TLB flushes, IPIs and mmu_gather.
Read: complicated

I added as much comments + description that I possibly could, and I am
hoping for review from Jann.

There are plenty of cleanups in the future to be had + one reasonable
optimization on x86. But that's all out of scope for this series.

Compile tested on plenty of architectures.

Runtime tested, with a focus on fixing the performance regression using
the original reproducer [2] on x86.

[1] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
[2] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/

--

v2 -> v3:
* Rebased to 6.19-rc2 and retested on x86
* Changes on last patch:
 * Introduce and use tlb_gather_mmu_vma() for properly setting up mmu_gather
   for hugetlb -- thanks to Harry for pointing me once again at the nasty
   hugetlb integration in mmu_gather
 * Move tlb_remove_huge_tlb_entry() after move_huge_pte()
 * For consistency, always call tlb_gather_mmu_vma() after
   flush_cache_range()
 * Don't pass mmu_gather to hugetlb_change_protection(), simply use
   a local one for now. (avoids messing with tlb_start_vma() /
   tlb_start_end())
 * Dropped Lorenzo's RB due to the changes

v1 -> v2:
* Picked RB's/ACK's, hopefully I didn't miss any
* Added the initialization of fully_unshared_tables in __tlb_gather_mmu()
  (Thanks Nadav!)
* Refined some comments based on Lorenzo's feedback.

Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Uschakow, Stanislav" <suschako@amazon.de>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Nadav Amit <nadav.amit@gmail.com>

David Hildenbrand (Red Hat) (3):
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/rmap: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

 include/asm-generic/tlb.h |  77 +++++++++++++++++++++-
 include/linux/hugetlb.h   |  15 +++--
 include/linux/mm_types.h  |   1 +
 mm/hugetlb.c              | 131 +++++++++++++++++++++-----------------
 mm/mmu_gather.c           |  33 ++++++++++
 mm/rmap.c                 |  45 ++++++-------
 6 files changed, 212 insertions(+), 90 deletions(-)

-- 
2.52.0


