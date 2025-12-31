Return-Path: <linux-arch+bounces-15614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D4CEB278
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 04:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAEB43008550
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787225D1E6;
	Wed, 31 Dec 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnQ3nijP"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B91C23D7E0
	for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767150236; cv=none; b=a2BlsaHVAsljUEKHe0u5LIG4NUQkqo461Iyk0PDmT1FCUw+sLCtU7S80inwIAcxV31MNbV0jOiEwnhNQzsEqZV44GUTe9GCPdpvo31Gp/BlqnsRrsKKlCizmfyFVM7tJDfDlBUffXgPGMtPOCQsd9+F/iY9KWnsTVdCjtsC49x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767150236; c=relaxed/simple;
	bh=RJ39g3nQ/9p3fLkTnWC3KA9Fm+fzogIq3ixw9ivEg8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kI9NmWLBoeU4/A3ksTD6nBkEXbpOVmXCMSVHp33BbNIneRZ5nhvcvI+Cy557LCfaomlzJQ9BAEFhG/GMZVOdB0jMVs8f1giyxG5HMACJBtKEul5JleBsA9NbA3IL3jNGoj2vqKJJrmJ5Q08qmEb1VlcpuwTPXjHbTPf6m9H5h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnQ3nijP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dafd2f83-c242-4d60-8270-8e52e2e066e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767150231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWAvq8dov7INFoDSveKxp8LJoL97QfNYZbwnUjDG4hM=;
	b=UnQ3nijP6X0/b80mQR948EKNaJrCZarFp2fTfHeiSDk84uHzXtZJ2uV6Xetixo917rL93u
	1YCs1wkbcEpQskFZ9WFMzZ4LbTB6oBFIPc86SXcd4Q0/KM1eCVW7oZUekXGoOBs3RexWxs
	4qdflp3C1Jn82CTaW7XnSF1hlEd/+8E=
Date: Wed, 31 Dec 2025 11:03:40 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] mm: embed TLB flush IPI check in
 tlb_remove_table_sync_one()
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <20251229145245.85452-4-lance.yang@linux.dev>
 <f4d5548d-6045-47a3-b233-0a67702bb477@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f4d5548d-6045-47a3-b233-0a67702bb477@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/31 04:33, David Hildenbrand (Red Hat) wrote:
> On 12/29/25 15:52, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> Embed the tlb_table_flush_implies_ipi_broadcast() check directly inside
>> tlb_remove_table_sync_one() instead of requiring every caller to check
>> it explicitly. This relies on callers to do the right thing: flush with
>> freed_tables=true or unshared_tables=true beforehand.
>>
>> All existing callers satisfy this requirement:
>>
>> 1. mm/khugepaged.c:1188 (collapse_huge_page):
>>
>>     pmdp_collapse_flush(vma, address, pmd)
>>     -> flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE)
>>        -> flush_tlb_mm_range(mm, ..., freed_tables = true)
>>           -> flush_tlb_multi(mm_cpumask(mm), info)
>>
>>     So freed_tables=true before calling tlb_remove_table_sync_one().
>>
>> 2. include/asm-generic/tlb.h:861 (tlb_flush_unshared_tables):
>>
>>     tlb_flush_mmu_tlbonly(tlb)
>>     -> tlb_flush(tlb)
>>        -> flush_tlb_mm_range(mm, ..., unshared_tables = true)
>>           -> flush_tlb_multi(mm_cpumask(mm), info)
>>
>>     unshared_tables=true (equivalent to freed_tables for sending IPIs).
>>
>> 3. mm/mmu_gather.c:341 (__tlb_remove_table_one):
>>
>>     When we can't allocate a batch page in tlb_remove_table(), we do:
>>
>>     tlb_table_invalidate(tlb)
>>     -> tlb_flush_mmu_tlbonly(tlb)
>>        -> flush_tlb_mm_range(mm, ..., freed_tables = true)
>>           -> flush_tlb_multi(mm_cpumask(mm), info)
>>
>>     Then:
>>     tlb_remove_table_one(table)
>>     -> __tlb_remove_table_one(table) // if !CONFIG_PT_RECLAIM
>>        -> tlb_remove_table_sync_one()
>>
>>     freed_tables=true, and this should work too.
>>
>>     Why is tlb->freed_tables guaranteed? Because callers like
>>     pte_free_tlb() (via free_pte_range) set freed_tables=true before
>>     calling __pte_free_tlb(), which then calls tlb_remove_table().
>>     We cannot free page tables without freed_tables=true.
>>
>>     Note that tlb_remove_table_sync_one() was a NOP on bare metal x86
>>     (CONFIG_MMU_GATHER_RCU_TABLE_FREE=n) before commit a37259732a7d
>>     ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional").
>>
>> 4-5. mm/khugepaged.c:1683,1819 (pmdp_get_lockless_sync macro):
>>
>>     Same as #1. These also use pmdp_collapse_flush() beforehand.
>>
>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> LGTM. I think we should document that somewhere. Can we add some 

Thanks!

> kerneldoc for tlb_remove_table_sync_one() where we document that it 
> doesn't to any sync if a previous TLB flush when removing/unsharing page 
> tables would have already performed an IPI?

Fair point. Would something like this work?

---8<---
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7b588643cbae..9139f0a6b8bd 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -274,6 +274,20 @@ static void tlb_remove_table_smp_sync(void *arg)
  	/* Simply deliver the interrupt */
  }

+/**
+ * tlb_remove_table_sync_one - Send IPI to synchronize page table 
operations
+ *
+ * Sends an IPI to all CPUs to synchronize when freeing or unsharing page
+ * tables (e.g., to ensure concurrent GUP-fast walkers have completed).
+ *
+ * If a previous TLB flush (when removing/unsharing page tables) already
+ * broadcast IPIs to all CPUs, the redundant IPI is skipped. The 
optimization
+ * relies on architectures implementing 
tlb_table_flush_implies_ipi_broadcast()
+ * to indicate when their TLB flush provides sufficient synchronization.
+ *
+ * Note that callers must ensure that a TLB flush with freed_tables=true or
+ * unshared_tables=true has been performed before calling.
+ */
  void tlb_remove_table_sync_one(void)
  {
  	/* Skip the IPI if the TLB flush already synchronized with other CPUs. */
---

Cheers,
Lance

> 
>> ---
>>   mm/mmu_gather.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 7468ec388455..7b588643cbae 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -276,6 +276,10 @@ static void tlb_remove_table_smp_sync(void *arg)
>>   void tlb_remove_table_sync_one(void)
>>   {
>> +    /* Skip the IPI if the TLB flush already synchronized with other 
>> CPUs. */
>> +    if (tlb_table_flush_implies_ipi_broadcast())
>> +        return;
>> +
>>       /*
>>        * This isn't an RCU grace period and hence the page-tables 
>> cannot be
>>        * assumed to be actually RCU-freed.
> 
> 


