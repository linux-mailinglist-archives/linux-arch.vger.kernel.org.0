Return-Path: <linux-arch+bounces-15667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F424CF83C1
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 13:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15E630389A6
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF21314A7A;
	Tue,  6 Jan 2026 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kdzRBVLv"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736C2989B7
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700998; cv=none; b=d74mHp65mpn3kMIn4Yc2oJBTAnaaT0Pu/FcuY2lh3WtlLUK8oMiUT9xkfM1Q8nrpmvXR+Xfl7O90GGMBiiNW/YJl8ShP0KS6K2QwNvN7o/wM+C/nyVSlxBO0gknEVFbJm7etOY28LUq1TR0Ar4ONlQICboT++9mh9KSfJOsvruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700998; c=relaxed/simple;
	bh=t7yxb8yntzXFp0tz+JEpK59nILEA49eXL04+zf7TwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5xh7q5J+nljlCtYHm85aV2fWOEJCVEEyqCzjYIF+beCj9cuWwyaN8fUOgBw0d7BDLS/gcDq7IS1DnzC30xKsGx9jBcFTS4Xjpc5CjhAvLLAqLbfY5VruK39SAT3BzGA5w/G4MErfuToxP02P7bJ5en3iEeVf9X2bwky4wMMzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kdzRBVLv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767700993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iklw0RInONOSh+e9xelR5uEAOvlruMIvuc7amxeOT2I=;
	b=kdzRBVLvNh8jbNQ59PhwNwBz4pfvxAXmnXMGo9B2oaSAsbzuAsrs+BYB75BRamLHGE8OCb
	hf1s5SBgskmqMmdkwiWDDkI1Apoa/QMuMicJOLZ/aSx32ijPVk6KHcwfjBgGnwT8S86Amz
	iUAvdmGMLmr0DxBDKwYjPDSG+VmR+Y8=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com
Subject: [PATCH RESEND v3 0/2] skip redundant TLB sync IPIs
Date: Tue,  6 Jan 2026 20:03:01 +0800
Message-ID: <20260106120303.38124-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

When unsharing hugetlb PMD page tables or collapsing pages in khugepaged,
we send two IPIs: one for TLB invalidation, and another to synchronize
with concurrent GUP-fast walkers. However, if the TLB flush already
reaches all CPUs, the second IPI is redundant. GUP-fast runs with IRQs
disabled, so when the TLB flush IPI completes, any concurrent GUP-fast
must have finished.

We now track whether IPIs were actually sent during TLB flush. We pass
the mmu_gather context through the flush path, and native_flush_tlb_multi()
sets a flag when sending IPIs. Works with PV and INVLPGB since only
native_flush_tlb_multi() sets the flag - no matter what replaces
pv_ops.mmu.flush_tlb_multi or whether INVLPGB is available.

David Hildenbrand did the initial implementation. I built on his work and
relied on off-list discussions to push it further - thanks a lot David!

v2 -> v3:
- Complete rewrite: use dynamic IPI tracking instead of static checks
  (per Dave Hansen, thanks!)
- Track IPIs via mmu_gather: native_flush_tlb_multi() sets flag when
  actually sending IPIs
- Motivation for skipping redundant IPIs explained by David:
  https://lore.kernel.org/linux-mm/1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org/
- https://lore.kernel.org/linux-mm/20251229145245.85452-1-lance.yang@linux.dev/

v1 -> v2:
- Fix cover letter encoding to resolve send-email issues. Apologies for
  any email flood caused by the failed send attempts :(

RFC -> v1:
- Use a callback function in pv_mmu_ops instead of comparing function
  pointers (per David)
- Embed the check directly in tlb_remove_table_sync_one() instead of
  requiring every caller to check explicitly (per David)
- Move tlb_table_flush_implies_ipi_broadcast() outside of
  CONFIG_MMU_GATHER_RCU_TABLE_FREE to fix build error on architectures
  that don't enable this config.
  https://lore.kernel.org/oe-kbuild-all/202512142156.cShiu6PU-lkp@intel.com/
- https://lore.kernel.org/linux-mm/20251213080038.10917-1-lance.yang@linux.dev/

Lance Yang (2):
  mm/tlb: skip redundant IPI when TLB flush already synchronized
  mm: introduce pmdp_collapse_flush_sync() to skip redundant IPI

 arch/x86/include/asm/tlb.h      |  3 ++-
 arch/x86/include/asm/tlbflush.h |  9 +++++----
 arch/x86/kernel/alternative.c   |  2 +-
 arch/x86/kernel/ldt.c           |  2 +-
 arch/x86/mm/tlb.c               | 22 +++++++++++++++------
 include/asm-generic/tlb.h       | 14 +++++++++-----
 include/linux/pgtable.h         | 13 +++++++++----
 mm/khugepaged.c                 |  9 +++------
 mm/mmu_gather.c                 | 26 ++++++++++++++++++-------
 mm/pgtable-generic.c            | 34 +++++++++++++++++++++++++++++++++
 10 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.49.0


