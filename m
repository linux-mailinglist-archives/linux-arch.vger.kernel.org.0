Return-Path: <linux-arch+bounces-15554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F2CDD9E8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021413009FA9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Dec 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDB248F64;
	Thu, 25 Dec 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdZVzdq/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9E27713;
	Thu, 25 Dec 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766656191; cv=none; b=qWROMsuWR/th7K4b4qns/wHchW00IMfQtPfEIb8Sgi1gNainEy+FsrpaLEGyrVRiNevEThNKXbaaF136JtEvqpghnrVx+tY3VPjtBnUR74hFuhY8kZJKXtUdyBkjhJsKDGQfrwwWnbWvp23pcsEmSmpn5svdZnXl+etdSPJIElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766656191; c=relaxed/simple;
	bh=3nIYuigXWekDPMa/zo4CI26ZDqoA5RIjVHToKBdAf9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUigoiCDSaLp8vktZ8JfmgeYfo3bFIxrZRKxEF0qM4AYmPfCKiDDt4I5X4GRsHq73cXcHL45UPiQScW9F3EXG8P16njZuStO+CBFWRk/LG7D336a56tN4Dz3p5ypnUgm1iha2HmcbIU+NnONQSuH+lt9OmHfB1FK1twcuMPaQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdZVzdq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D7CC4CEF1;
	Thu, 25 Dec 2025 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766656190;
	bh=3nIYuigXWekDPMa/zo4CI26ZDqoA5RIjVHToKBdAf9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sdZVzdq/stOlui6Ricvxhc/BJbaDZdptSo4jseuRj+KgI2kmb7KBfsajwuPAy4PSj
	 VKJxG9qvJ75m7svZj0wEjuv+5ZPptS9/op0WlFbDKCCS3okTvVtr0UQIMuQQxa7ig2
	 VK2eC1wVYbq8Ewn8DO8KzR3qJV6RtN/IxOu5gLOhfvYDla2ysPFW2kqKyjXhs1Ceqn
	 mTA7KNtJGCk76w/4WIxo7481Qkfes0IQnZD0GfPKTTCIZ+4QvpUIjn1SJ1nTA3swOU
	 qn0uwRcRs9Q5rB+02Od76vriLXOBGC6PWyhQWcZWOVQ/xRxxE5HHWjgrdBtKeR/Kwe
	 FoxpoX3sNRznA==
Message-ID: <520e6f26-4624-4145-b959-ccde466dfda2@kernel.org>
Date: Thu, 25 Dec 2025 10:49:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/4] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
To: Laurence Oberman <loberman@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20251223214037.580860-1-david@kernel.org>
 <11ab64528debf3b3515e863610fc8b679a39189c.camel@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <11ab64528debf3b3515e863610fc8b679a39189c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/24/25 00:23, Laurence Oberman wrote:
> On Tue, 2025-12-23 at 22:40 +0100, David Hildenbrand (Red Hat) wrote:
>> One functional fix, one performance regression fix, and two related
>> comment fixes.
>>
>> I cleaned up my prototype I recently shared [1] for the performance
>> fix,
>> deferring most of the cleanups I had in the prototype to a later
>> point.
>> While doing that I identified the other things.
>>
>> The goal of this patch set is to be backported to stable trees
>> "fairly"
>> easily. At least patch #1 and #4.
>>
>> Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
>> Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
>> Patch #4 is a fix for the reported performance regression due to
>> excessive
>> IPI broadcasts during fork()+exit().
>>
>> The last patch is all about TLB flushes, IPIs and mmu_gather.
>> Read: complicated
>>
>> I added as much comments + description that I possibly could, and I
>> am
>> hoping for review from Jann.
>>
>> There are plenty of cleanups in the future to be had + one reasonable
>> optimization on x86. But that's all out of scope for this series.
>>
>> Compile tested on plenty of architectures.
>>
>> Runtime tested, with a focus on fixing the performance regression
>> using
>> the original reproducer [2] on x86.
>>
>> [1]
>> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
>> [2]
>> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
>>
>> --
>>
>> v2 -> v3:
>> * Rebased to 6.19-rc2 and retested on x86
>> * Changes on last patch:
>>   * Introduce and use tlb_gather_mmu_vma() for properly setting up
>> mmu_gather
>>     for hugetlb -- thanks to Harry for pointing me once again at the
>> nasty
>>     hugetlb integration in mmu_gather
>>   * Move tlb_remove_huge_tlb_entry() after move_huge_pte()
>>   * For consistency, always call tlb_gather_mmu_vma() after
>>     flush_cache_range()
>>   * Don't pass mmu_gather to hugetlb_change_protection(), simply use
>>     a local one for now. (avoids messing with tlb_start_vma() /
>>     tlb_start_end())
>>   * Dropped Lorenzo's RB due to the changes
>>
>> v1 -> v2:
>> * Picked RB's/ACK's, hopefully I didn't miss any
>> * Added the initialization of fully_unshared_tables in
>> __tlb_gather_mmu()
>>    (Thanks Nadav!)
>> * Refined some comments based on Lorenzo's feedback.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Nick Piggin <npiggin@gmail.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Pedro Falcato <pfalcato@suse.de>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Harry Yoo <harry.yoo@oracle.com>
>> Cc: Uschakow, Stanislav" <suschako@amazon.de>
>> Cc: Laurence Oberman <loberman@redhat.com>
>> Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
>> Cc: Nadav Amit <nadav.amit@gmail.com>
>>
>> David Hildenbrand (Red Hat) (4):
>>    mm/hugetlb: fix hugetlb_pmd_shared()
>>    mm/hugetlb: fix two comments related to huge_pmd_unshare()
>>    mm/rmap: fix two comments related to huge_pmd_unshare()
>>    mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
>>      using mmu_gather
>>
>>   include/asm-generic/tlb.h |  77 +++++++++++++++++++++-
>>   include/linux/hugetlb.h   |  17 +++--
>>   include/linux/mm_types.h  |   1 +
>>   mm/hugetlb.c              | 131 +++++++++++++++++++++---------------
>> --
>>   mm/mmu_gather.c           |  33 ++++++++++
>>   mm/rmap.c                 |  45 ++++++-------
>>   6 files changed, 213 insertions(+), 91 deletions(-)
>>
>>
>> base-commit: b927546677c876e26eba308550207c2ddf812a43
> Hello David
> 
> For the V3 series, I re-ran the tests and the original reproducer and
> its clean. I see the same almost 6x improvement for the original
> reproducer
> 
> # uname -r
> 6.19.0-rc2-hugetlbv3+
> 
> Un-patched Result of reproducer Iteration completed in 3436 ms
> V3 Patched Result of reproducer Iteration completed in 639 ms
> 
> I also ran a test to map every hugepage I could access (460GB of them)
> then fill and validate and had no issues.
> 
> Tested-by: Laurence Oberman <loberman@redhat.com>

Thanks a lot for the quick retest Laurence! I'd love to get some generic 
hugetlb testing on arm64 and powerpc, that do hugetlb TLB flushing stuff 
a bit more special.

I'll try doing some arm64 testing early in the new year myself.

-- 
Cheers

David

