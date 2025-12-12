Return-Path: <linux-arch+bounces-15374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F387BCB814C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 08:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618E730783A6
	for <lists+linux-arch@lfdr.de>; Fri, 12 Dec 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65832F5A3B;
	Fri, 12 Dec 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3JaFo7U"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3E1F12F8;
	Fri, 12 Dec 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523424; cv=none; b=aLo9MlKLSW2e6P+6TbfutCFLeQ7mlfq3rOAJHTKulnhPPSwEu9RIZU1M1AfLFT8Nv0m/KLSV7HyXkE4Kazl+xDwD6zDMO+4Ux0bY8AiAgC/8MmWp0X67CuCyFLphEBLN2dGS7XD7hoPZjh15M2En9HiFii6p710AMezqM6mFQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523424; c=relaxed/simple;
	bh=dqVIubbkQVRJernqv5F3ELaqr4N3SUKjeivqxVsqbc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nv9JQsBvIeWyF3ug1k+nv9r+2f3CCHCf8GwUlKy8HOPMvq1m1O6BrfFuljNWsgcQH+7/173BxiI8CL/gpLy3ixXkel34dcQ8XE0p+JL5C9wBiBQP1NW7Yp5Jc6/g2rNAobgwDgvjhAAwvrPAug+hhY0pnCaRBsl/T9CuZNABlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3JaFo7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C211C4CEF1;
	Fri, 12 Dec 2025 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765523424;
	bh=dqVIubbkQVRJernqv5F3ELaqr4N3SUKjeivqxVsqbc4=;
	h=From:To:Cc:Subject:Date:From;
	b=f3JaFo7UNgQ1cS+tGpxQlQlH1Sdo1Fg6Esq7jGLZmQx4SnuABcKWUEiiAOvNYl99G
	 8GMkZzyMNFS8wxZ5qdAPs6tbEevDiwFqkhD3xQOieDms+iq8ESZqxQ8PuJH1M68h7r
	 R79RosnaRONJ+nN3JYvRUQ5V78dgIF1gEg2Ak5EY2iADIk8Q1qU9B6C2v2aVCimv0w
	 7+BRkpmK53dtEDF45oj//0VTQsqmtyYCegCUMUbV58F/xryXFrXxM8+iM+kio4pvy/
	 an5aeJB30efMoSJ1ijOs1Z1cR1IJGaRbl0+i1f6caBQXTcvfz9RPPPodCeOXEJltk2
	 hoYGctWHYUbIQ==
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
Subject: [PATCH v2 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Fri, 12 Dec 2025 08:10:15 +0100
Message-ID: <20251212071019.471146-1-david@kernel.org>
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

I'm still busy with more testing (making sure that my TLB flushing changes
are good), but sending this out already so people can test and review
while I am soon heading for LPC.

[1] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
[2] https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/

--

v1 -> v2:
* Picked RB's/ACK's, hopefully I didn't miss any
* Added the initialization of fully_unshared_tables in __tlb_gather_mmu()
  (Thanks Nadav!)
* Refined some comments based on Lorenzo's feedback.

Sending it out already as I have some spare minutes and we should start
queuing the fixed version. Maybe there will be some more comment changes
later based on the discussion with Lorenzo.

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

David Hildenbrand (Red Hat) (4):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/rmap: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

 include/asm-generic/tlb.h |  74 +++++++++++++++++++++-
 include/linux/hugetlb.h   |  21 ++++---
 mm/hugetlb.c              | 129 ++++++++++++++++++++------------------
 mm/mmu_gather.c           |   7 +++
 mm/mprotect.c             |   2 +-
 mm/rmap.c                 |  45 +++++++------
 6 files changed, 184 insertions(+), 94 deletions(-)

-- 
2.52.0


