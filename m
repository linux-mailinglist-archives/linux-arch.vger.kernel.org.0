Return-Path: <linux-arch+bounces-15678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C4CFC315
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 07:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E483013E89
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462024A044;
	Wed,  7 Jan 2026 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0pHuY/7"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E394225A38
	for <linux-arch@vger.kernel.org>; Wed,  7 Jan 2026 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767933; cv=none; b=WiHkUNzvGKSoYLUT8EuSAlTyC2mB8Oa/JRFV3MCH6ij1MCBAsPC+skpN/Uqv0HdtUutuRAUZUQujB/PJSB9mUEcB7f38q0xPvFJEdblIrkuxYk0FF1g2TFpYZ9Ubylz4oL1LUjlpe+jBblciZ7qdBFlZTEkhqeUcGqEq5KPrGNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767933; c=relaxed/simple;
	bh=OFVGZuwytmVdoFvHDiYsyrb9Gx1hlv6TmStbmYeYs98=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=izgUm36ny+JSc5/TzX3rdVbxCLgN3F5D65ancDLycp9n5bJKMgpWDcbUOvp8N+mDQf5CISlpvRu1wVtwkCfroxLTJORkjZ2XBgvRch3sLbZ8tebf66jyCGmZgqrH7zStuAGYm5BVrSk4DbXM9Fe42x2TEQxyEGereKrshbjAbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0pHuY/7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b1cb571-99df-44f8-8c0e-8e9bc3f6e8d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767767929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EA020s+TyrZf5BYAV9kvOI4txuXnqmEU9j3WXW+IK+Y=;
	b=K0pHuY/7s97Rx9tak8QLBoX638w7XDCKFSp9xuWVAvz5+Fh14t/8N2g/7oKJm3yTS/iO4u
	3tdKbvDoqtmNBiX3y2JFOoBqvZmphPPvOQhP0wYl0LnkYdOx5bCULp9XdkWk644cha+uIp
	7BijGoqiAZG6oaFlioTRdoq2i14/eRw=
Date: Wed, 7 Jan 2026 14:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush
 already synchronized
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: dave.hansen@intel.com, dave.hansen@linux.intel.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-2-lance.yang@linux.dev>
 <da1e8a00-99fe-46d9-b425-c307ea933036@kernel.org>
 <7472056a-3919-429a-845d-c2076496d537@linux.dev>
In-Reply-To: <7472056a-3919-429a-845d-c2076496d537@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David,

On 2026/1/7 00:10, Lance Yang wrote:
[..]
>> What could work is tracking "tlb_table_flush_sent_ipi" really when we 
>> are flushing the TLB for removed/unshared tables, and maybe resetting 
>> it ... I don't know when from the top of my head.
>

Seems like we could fix the issue that the flag lifetime was broken
if the MMU gather gets reused by splitting the flush and reset. This
ensures the flag stays valid between flush and sync.

Now tlb_flush_unshared_tables() does:
   1) __tlb_flush_mmu_tlbonly() - flush only, keeps flags alive
   2) tlb_gather_remove_table_sync_one() - can check the flag
   3) __tlb_reset_range() - reset everything after sync

Something like this:

---8<---
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3975f7d11553..a95b054dfcca 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -415,6 +415,7 @@ static inline void __tlb_reset_range(struct 
mmu_gather *tlb)
  	tlb->cleared_puds = 0;
  	tlb->cleared_p4ds = 0;
  	tlb->unshared_tables = 0;
+	tlb->tlb_flush_sent_ipi = 0;
  	/*
  	 * Do not reset mmu_gather::vma_* fields here, we do not
  	 * call into tlb_start_vma() again to set them if there is an
@@ -492,7 +493,7 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct 
vm_area_struct *vma)
  	tlb->vma_pfn |= !!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP));
  }

-static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+static inline void __tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
  {
  	/*
  	 * Anything calling __tlb_adjust_range() also sets at least one of
@@ -503,6 +504,11 @@ static inline void tlb_flush_mmu_tlbonly(struct 
mmu_gather *tlb)
  		return;

  	tlb_flush(tlb);
+}
+
+static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
+{
+	__tlb_flush_mmu_tlbonly(tlb);
  	__tlb_reset_range(tlb);
  }

@@ -824,7 +830,7 @@ static inline void tlb_flush_unshared_tables(struct 
mmu_gather *tlb)
  	 * flush the TLB for the unsharer now.
  	 */
  	if (tlb->unshared_tables)
-		tlb_flush_mmu_tlbonly(tlb);
+		__tlb_flush_mmu_tlbonly(tlb);

  	/*
  	 * Similarly, we must make sure that concurrent GUP-fast will not
@@ -834,14 +840,16 @@ static inline void 
tlb_flush_unshared_tables(struct mmu_gather *tlb)
  	 * We only perform this when we are the last sharer of a page table,
  	 * as the IPI will reach all CPUs: any GUP-fast.
  	 *
-	 * Note that on configs where tlb_remove_table_sync_one() is a NOP,
-	 * the expectation is that the tlb_flush_mmu_tlbonly() would have issued
-	 * required IPIs already for us.
+	 * Use tlb_gather_remove_table_sync_one() instead of
+	 * tlb_remove_table_sync_one() to skip the redundant IPI if the
+	 * TLB flush above already sent one.
  	 */
  	if (tlb->fully_unshared_tables) {
-		tlb_remove_table_sync_one();
+		tlb_gather_remove_table_sync_one(tlb);
  		tlb->fully_unshared_tables = false;
  	}
+
+	__tlb_reset_range(tlb);
  }
  #endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
---

For khugepaged, it should be fine - it uses a local mmu_gather that
doesn't get reused. The lifetime is simply:

   tlb_gather_mmu() → flush → sync → tlb_finish_mmu()

Let me know if this addresses your concern :)

[...]

