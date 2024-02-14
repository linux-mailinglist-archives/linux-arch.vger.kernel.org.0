Return-Path: <linux-arch+bounces-2370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C243855423
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11AE1C2151A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C312882A;
	Wed, 14 Feb 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6zvG+gG"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30C128384
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943488; cv=none; b=D7NfoBNnHsqBsDYBg0hs9S6MrE7mbgA72yuj9e/M/9OQPsA+XmuR8sRYhrpm062CWHvnbMTmOEY7o9mComFMLYrIjtOgi8xuA1FBj5almsj76JQCjOZyXB6DmKLv0xL8hrZdewkNttg/NXj5Xxpglr/qlEurHP/ISNlxsebLK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943488; c=relaxed/simple;
	bh=BWiDBgwZgy2HPBX+L0L3QMYgtqOYwURfI2b0XfuCLno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2+1f3rqm3Of4/gxvTv85NvgxSxQ36iD65S044j0c2gNeCQR4FZdjIe4jkzuqJY1icue9qRY/E7bYhLjJNMOMbi/1vNeQKYtOkVwwZt29GsbeMO2XL1P0TEls1JW8gLSGy/cECTzhMjH1RbK1dYXUF3FwN4fXuSO7BrBdgcOGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6zvG+gG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707943485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFaV7z72bOpzL/S5oYBrXwzyy6tNcmGC5k13H1LQe0I=;
	b=h6zvG+gGbm9cuEyaVyBEgJntrKOF91fUOh9yZOKn6xriE0tTeGuEQakhDtLto/R5Fw3whT
	48thBOHbcw17fM1s66S8yanjGH5tbUgxZWqOGIMrT3A2Ep3mE6I9fkQPeY4kjANCFymsLB
	fgfFz60+ssKm/tUPUbu5abkj6YuWnQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-jV1r6PLAOiSgtGDxuUZb9A-1; Wed, 14 Feb 2024 15:44:42 -0500
X-MC-Unique: jV1r6PLAOiSgtGDxuUZb9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 211B085A589;
	Wed, 14 Feb 2024 20:44:41 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94C251C060B1;
	Wed, 14 Feb 2024 20:44:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 00/10] mm/memory: optimize unmap/zap with PTE-mapped THP
Date: Wed, 14 Feb 2024 21:44:25 +0100
Message-ID: <20240214204435.167852-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This series is based on [1]. Similar to what we did with fork(), let's
implement PTE batching during unmap/zap when processing PTE-mapped THPs.

We collect consecutive PTEs that map consecutive pages of the same large
folio, making sure that the other PTE bits are compatible, and (a) adjust
the refcount only once per batch, (b) call rmap handling functions only
once per batch, (c) perform batch PTE setting/updates and (d) perform TLB
entry removal once per batch.

Ryan was previously working on this in the context of cont-pte for
arm64, int latest iteration [2] with a focus on arm6 with cont-pte only.
This series implements the optimization for all architectures, independent
of such PTE bits, teaches MMU gather/TLB code to be fully aware of such
large-folio-pages batches as well, and amkes use of our new rmap batching
function when removing the rmap.

To achieve that, we have to enlighten MMU gather / page freeing code
(i.e., everything that consumes encoded_page) to process unmapping
of consecutive pages that all belong to the same large folio. I'm being
very careful to not degrade order-0 performance, and it looks like I
managed to achieve that.

While this series should -- similar to [1] -- be beneficial for adding
cont-pte support on arm64[2], it's one of the requirements for maintaining
a total mapcount[3] for large folios with minimal added overhead and
further changes[4] that build up on top of the total mapcount.

Independent of all that, this series results in a speedup during munmap()
and similar unmapping (process teardown, MADV_DONTNEED on larger ranges)
with PTE-mapped THP, which is the default with THPs that are smaller than
a PMD (for example, 16KiB to 1024KiB mTHPs for anonymous memory[5]).

On an Intel Xeon Silver 4210R CPU, munmap'ing a 1GiB VMA backed by
PTE-mapped folios of the same size (stddev < 1%) results in the following
runtimes for munmap() in seconds (shorter is better):

Folio Size | mm-unstable |      New | Change
---------------------------------------------
      4KiB |    0.058110 | 0.057715 |   - 1%
     16KiB |    0.044198 | 0.035469 |   -20%
     32KiB |    0.034216 | 0.023522 |   -31%
     64KiB |    0.029207 | 0.018434 |   -37%
    128KiB |    0.026579 | 0.014026 |   -47%
    256KiB |    0.025130 | 0.011756 |   -53%
    512KiB |    0.024292 | 0.010703 |   -56%
   1024KiB |    0.023812 | 0.010294 |   -57%
   2048KiB |    0.023785 | 0.009910 |   -58%

CCing especially s390x folks, because they have a tlb freeing hooks that
needs adjustment. Only tested on x86-64 for now, will have to do some more
stress testing. Compile-tested on most other architectures. The PPC
change is negleglible and makes my cross-compiler happy.

[1] https://lkml.kernel.org/r/20240129124649.189745-1-david@redhat.com
[2] https://lkml.kernel.org/r/20231218105100.172635-1-ryan.roberts@arm.com
[3] https://lkml.kernel.org/r/20230809083256.699513-1-david@redhat.com
[4] https://lkml.kernel.org/r/20231124132626.235350-1-david@redhat.com
[5] https://lkml.kernel.org/r/20231207161211.2374093-1-ryan.roberts@arm.com

---

Sending this out earlier than I ususally would, so we can get this into
mm-unstable for Ryan to base his cont-pte work on this ASAP.

The performance numbers are from v1. I did a quick benchmark run of v3
and nothing significantly changed, relevant code paths remained unchanged.

v2 -> v3:
* "mm/mmu_gather: add __tlb_remove_folio_pages()"
 -> Slightly adjusted patch description
* "mm/mmu_gather: improve cond_resched() handling with large folios and
   expensive page freeing"
 -> Use new macro for magic value and avoid code duplication
 -> Extend patch description
* Pick up RB's

v1 -> v2:
* "mm/memory: factor out zapping of present pte into zap_present_pte()"
 -> Initialize "struct folio *folio" to NULL
* "mm/memory: handle !page case in zap_present_pte() separately"
 -> Extend description regarding arch_check_zapped_pte()
* "mm/mmu_gather: add __tlb_remove_folio_pages()"
 -> ENCODED_PAGE_BIT_NR_PAGES_NEXT
 -> Extend patch description regarding "batching more"
* "mm/mmu_gather: improve cond_resched() handling with large folios and
   expensive page freeing"
 -> Handle the (so far) theoretical case of possible soft lockups when
    we zero/poison memory when freeing pages. Try to keep old behavior in
    that corner case to be safe.
* "mm/memory: optimize unmap/zap with PTE-mapped THP"
 -> Clarify description of new ptep clearing functions regarding "present
    PTEs"
 -> Extend patch description regarding relaxed mapcount sanity checks
 -> Improve zap_present_ptes() description
* Pick up RB's

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org

David Hildenbrand (10):
  mm/memory: factor out zapping of present pte into zap_present_pte()
  mm/memory: handle !page case in zap_present_pte() separately
  mm/memory: further separate anon and pagecache folio handling in
    zap_present_pte()
  mm/memory: factor out zapping folio pte into zap_present_folio_pte()
  mm/mmu_gather: pass "delay_rmap" instead of encoded page to
    __tlb_remove_page_size()
  mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
  mm/mmu_gather: add tlb_remove_tlb_entries()
  mm/mmu_gather: add __tlb_remove_folio_pages()
  mm/mmu_gather: improve cond_resched() handling with large folios and
    expensive page freeing
  mm/memory: optimize unmap/zap with PTE-mapped THP

 arch/powerpc/include/asm/tlb.h |   2 +
 arch/s390/include/asm/tlb.h    |  30 ++++--
 include/asm-generic/tlb.h      |  40 ++++++--
 include/linux/mm_types.h       |  37 ++++++--
 include/linux/pgtable.h        |  70 ++++++++++++++
 mm/memory.c                    | 169 +++++++++++++++++++++++----------
 mm/mmu_gather.c                | 111 ++++++++++++++++++----
 mm/swap.c                      |  12 ++-
 mm/swap_state.c                |  15 ++-
 9 files changed, 393 insertions(+), 93 deletions(-)


base-commit: 7e56cf9a7f108e8129d75cea0dabc9488fb4defa
-- 
2.43.0


