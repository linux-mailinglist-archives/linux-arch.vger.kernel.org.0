Return-Path: <linux-arch+bounces-15284-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD3CA9669
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 22:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FAA30056D8
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9523E342;
	Fri,  5 Dec 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6gXd2v5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101023D7E3;
	Fri,  5 Dec 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970569; cv=none; b=hLnQlY9P1GnsluuqngewXjWKUshF9+M++uB2F5M1D/y/xwOmhZOQJ2+LxsNXhResq6Lo+iwfnE8je8HXzttJ4Sy317H6QfccklBBwKjpqW6FamD4NBrWMezURfwnw84cCTbtYhElq+7HI+h9GSFYoTVuj57mRXtsQSS2F2KGI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970569; c=relaxed/simple;
	bh=SmK7Ck94rcMb/nZuAfr0WquYmOB6LidxVqvFllEvbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUnd6aLuwBDG4M5kDVlTH8cMOO+JNcn49mZ2dRw3ffyhlXuYmCFvoZp59+baPRckQflXLrgmCJFdmV4LiUUp41jX4yIHlqMoMynN0qxDV8/j0GIQMW0ozEfN3SfkPGiAKlMEPlaoMg+qvyoigUkwazzidYkOVoG6VwMyuGCXjZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6gXd2v5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A5C4CEF1;
	Fri,  5 Dec 2025 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764970566;
	bh=SmK7Ck94rcMb/nZuAfr0WquYmOB6LidxVqvFllEvbKw=;
	h=From:To:Cc:Subject:Date:From;
	b=J6gXd2v5B95kbT7ObYEcdKRqlGCikeYA9no1qt/38gWKs34tiE2Ulspg1f7qNmYFB
	 yqTVfyyn4J6w6IsS81ljM5Zy6H4Sm/VkQRLVa2gDIXq04ra5T16HH/eXCLZXuPt6cC
	 dSjF2zZqiyzDA2J39z1tZi/AD45qd/uYDw+cwfX0EvkCZwqRXbm8edHNCyHJ5yYFye
	 B4B24/JC/loo+lLWryssWPAWsREo0NvaVi2ODAy1bNUnQGF/YRf367FP6G0JQtJe1H
	 8yG/95N3q+jyS87oeAl7+uB7vsbos2bSB/LLS5lzN/zoY5QYZgxDBqn6k9iqQxkV6G
	 6FhB2KpLl55iw==
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
Subject: [PATCH v1 0/4] mm/hugetlb: fixes for PMD table sharing (incl. using mmu_gather)
Date: Fri,  5 Dec 2025 22:35:54 +0100
Message-ID: <20251205213558.2980480-1-david@kernel.org>
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

 include/asm-generic/tlb.h |  69 +++++++++++++++++++-
 include/linux/hugetlb.h   |  21 ++++---
 mm/hugetlb.c              | 129 ++++++++++++++++++++------------------
 mm/mmu_gather.c           |   6 ++
 mm/mprotect.c             |   2 +-
 mm/rmap.c                 |  45 +++++++------
 6 files changed, 178 insertions(+), 94 deletions(-)

-- 
2.52.0


