Return-Path: <linux-arch+bounces-15546-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A04CDAB0E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 22:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8622300E456
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 21:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7952D6E4B;
	Tue, 23 Dec 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDkGPeqQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A39288517;
	Tue, 23 Dec 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526045; cv=none; b=YxfLBPcbQjgENqloVKv8T+D/235aZ3gG3YhImzaLvFRKsuPf3TzsHLakytIttlsQqen4/X1wt/YW7InQgamDg8jCLdXB0EWebSd9MFssmtq3p3Iq9o/bDGXaIcnO/3JNVjt3KNZwyGgV7DVagforq1sdu0ULFkuAlZGdWePcDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526045; c=relaxed/simple;
	bh=OSmgCow6kpvrFchY2IvhiYI8wg7ZEpAnIjGaVk8vaSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFOhVlBsSt8lInPNLKKUdV6xhKHEfyHysWgbClSw8PZwDF5eQBX8FZWUe0cDyxp0kO9Tk/xyAoXYXH8jkJ4hTPLbLkohyAXX1uVFgQ+eerbx6t5RdFOmzqAQekWyeqTImiXNSAJTfRiq6eHU+J5D+ynggb9iRJml3jHoFaDCVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDkGPeqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E280EC113D0;
	Tue, 23 Dec 2025 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526045;
	bh=OSmgCow6kpvrFchY2IvhiYI8wg7ZEpAnIjGaVk8vaSA=;
	h=From:To:Cc:Subject:Date:From;
	b=YDkGPeqQ/HlBu48bnfJVAqJWIOhh1xtYRDvtMD3ckc9CXs/YHVJDi8doMYiA4At0L
	 WvZui8n5NHT24lLTdnzpkmgmcf1vnVI4s21PG+s9Hg6GRdqYV6dz+c/eVplyrCPpat
	 AYklgbnX7QcU3BlzwR2VoXp+uh1twbYfTQpJ3Jvh94rM1xMe3SUVknHqLQTiDcK+XB
	 VbnLRuLHKL+Sa8mERhjgSI/RMe5PZOzIT+A+FkmUQ2vXysse0jE6NIFGmn9Zc3ETTN
	 O8oNMtMvByO5P84Z/6JFXWilEWJW5fDni+3on97DCSd89b08+tLMrXZexIVKZ4Fx/d
	 /XPGn6gukFpiw==
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
Subject: [PATCH RESEND v3 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Tue, 23 Dec 2025 22:40:33 +0100
Message-ID: <20251223214037.580860-1-david@kernel.org>
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

David Hildenbrand (Red Hat) (4):
  mm/hugetlb: fix hugetlb_pmd_shared()
  mm/hugetlb: fix two comments related to huge_pmd_unshare()
  mm/rmap: fix two comments related to huge_pmd_unshare()
  mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
    using mmu_gather

 include/asm-generic/tlb.h |  77 +++++++++++++++++++++-
 include/linux/hugetlb.h   |  17 +++--
 include/linux/mm_types.h  |   1 +
 mm/hugetlb.c              | 131 +++++++++++++++++++++-----------------
 mm/mmu_gather.c           |  33 ++++++++++
 mm/rmap.c                 |  45 ++++++-------
 6 files changed, 213 insertions(+), 91 deletions(-)


base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.52.0


