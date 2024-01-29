Return-Path: <linux-arch+bounces-1762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B7884085E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C99828272A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BA152DF4;
	Mon, 29 Jan 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iqvpnmy6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4A151CDC
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538756; cv=none; b=CuptZqOAxgETIdRsOeWG6crMnLx6PpV3w4IDYa21ZqNwxZpLqP1WjBBCGCc/bjqqrwbFvKpUtBzxGBfdwtcmMTJKeXuT/Ga7T/+LMJwBOC2Vv296CW4OJu0NHpZiLVwQF0jYeYgxVnhimDJqstWtw9WrL2zI4JG9XAEzQORGA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538756; c=relaxed/simple;
	bh=4KscbxAYCjj2PD8V1wCvHcnFXsKmpE5jCNYRuVMCyW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZBttUGVbhHJSneNK0SUOMFPCWO5+n4GMf5NNcUdMDBjGSB2bx639ZpXkqW1h+oRIsvG3tfP1euMlwRtm4NvcBQmKnc7UeSWHnlIQv3CPpRtZPnBMgYDCw7kHuTLNNw0fNMStgbB6hc/P3S7HbCnfW3YajsBKOwDeWfyW3t18Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iqvpnmy6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UhBdOI+JB6L0dCFGLAOqO2pJABjn3Znd2yV65wClG/w=;
	b=Iqvpnmy6mMOPZYG3tx6bZyM1BBxCV+4385uaRT74evBaBlOh3R6HgGA6282djlwpn0ZbeE
	xpmrbEGCe8wFspedK7kQ1URAAT4MbKHIiT6zUZxjDHa8AWqylfV9qr3YdfR1y99pJlWW/N
	8v0S5RIQtE24HcSrrIXkIm0/j7+r6rE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Kz5-1HWrO6SlttN34_aWHQ-1; Mon,
 29 Jan 2024 09:32:29 -0500
X-MC-Unique: Kz5-1HWrO6SlttN34_aWHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 979933C13A90;
	Mon, 29 Jan 2024 14:32:27 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75D74C3F;
	Mon, 29 Jan 2024 14:32:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Date: Mon, 29 Jan 2024 15:32:12 +0100
Message-ID: <20240129143221.263763-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

This series is based on [1] and must be applied on top of it.
Similar to what we did with fork(), let's implement PTE batching
during unmap/zap when processing PTE-mapped THPs.

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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
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

David Hildenbrand (9):
  mm/memory: factor out zapping of present pte into zap_present_pte()
  mm/memory: handle !page case in zap_present_pte() separately
  mm/memory: further separate anon and pagecache folio handling in
    zap_present_pte()
  mm/memory: factor out zapping folio pte into zap_present_folio_pte()
  mm/mmu_gather: pass "delay_rmap" instead of encoded page to
    __tlb_remove_page_size()
  mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
  mm/mmu_gather: add __tlb_remove_folio_pages()
  mm/mmu_gather: add tlb_remove_tlb_entries()
  mm/memory: optimize unmap/zap with PTE-mapped THP

 arch/powerpc/include/asm/tlb.h |   2 +
 arch/s390/include/asm/tlb.h    |  30 ++++--
 include/asm-generic/tlb.h      |  40 ++++++--
 include/linux/mm_types.h       |  37 ++++++--
 include/linux/pgtable.h        |  66 +++++++++++++
 mm/memory.c                    | 167 +++++++++++++++++++++++----------
 mm/mmu_gather.c                |  63 +++++++++++--
 mm/swap.c                      |  12 ++-
 mm/swap_state.c                |  12 ++-
 9 files changed, 347 insertions(+), 82 deletions(-)

-- 
2.43.0


