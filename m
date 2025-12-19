Return-Path: <linux-arch+bounces-15511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E32CCE9D7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 07:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A7FA30185C1
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAF2749C5;
	Fri, 19 Dec 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9uW/ErX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCA1FCFEF;
	Fri, 19 Dec 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766124671; cv=none; b=mpa2lvbf/2pnJ02BPdInzwHz0hSuiC0Fq0eqm1eydyzf9RmS4fuFh5P19ooYRoTQjEkQEZSXdbjDKvlB2r2e35zjhgxEMgAi0TJBoC7TJtfNQvcDsi1HR96FWOwaV7ruehG4t8ajXXoYbVq8LkjvDwVkzNg7WwHf0C6KYR4h+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766124671; c=relaxed/simple;
	bh=lMx0tZHit8feygPc0c3IX00fMWdf+rQft4YAallTkBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVHuXltBhG/pfCc0g5nIUxfLHEjg6RyPeXSO2jFd7Mg0aD9lAbW8BgzT1WM6J5SFRk7Ktrv2AqTA5wEy/dMDzIzT8Vi+UKDKpm1gyMouHoqatrBj2tWshsf3PTsPeOOmy+WrxKBMwilTzPwNvSSLn5nDDHJUcCTjDaFQcMOClHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9uW/ErX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09355C4CEF1;
	Fri, 19 Dec 2025 06:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766124671;
	bh=lMx0tZHit8feygPc0c3IX00fMWdf+rQft4YAallTkBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9uW/ErXy0F6ct3rFLCv4PBWLBoEIWy8uzSJ+hIW3grHckseSAUus0VQIUpGYPXvQ
	 2lwtlCx5UzczEeLqQXDQa100Wfvwd/q14qVhh1L0b1GalXww8TT63dMNyXmHWqxMv6
	 q+41ZmwWmwwyre3RaKoRXzlg1gn9l5W/DrGhw0BuM8oW4J6BsCZZGlzf+dsMobg+OR
	 KCTzt0O6Fcir7Lu+xJk+7vga32wWsNZ4Dy81d+sZ5WnMnn5ryv/XU1cAO1K6ypJn1t
	 Py1EyuZuY/GLPZkGsGx125qn1YBx/QUWYWKN++Bl/7NupY58pqjQN23Sr8M4zFmFjN
	 uHZKCXzvE24Lg==
Message-ID: <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org>
Date: Fri, 19 Dec 2025 07:11:00 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>, Liu Shixin <liushixin2@huawei.com>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org> <aUTYE9fHf5Fq3eHa@hyeyoo>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUTYE9fHf5Fq3eHa@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 05:44, Harry Yoo wrote:
> On Fri, Dec 12, 2025 at 08:10:17AM +0100, David Hildenbrand (Red Hat) wrote:
>> Ever since we stopped using the page count to detect shared PMD
>> page tables, these comments are outdated.
>>
>> The only reason we have to flush the TLB early is because once we drop
>> the i_mmap_rwsem, the previously shared page table could get freed (to
>> then get reallocated and used for other purpose). So we really have to
>> flush the TLB before that could happen.
>>
>> So let's simplify the comments a bit.
>>
>> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
>> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
>> correctly after huge_pmd_unshare") was confusing: sure it is recorded
>> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
>> anything. So let's drop that comment while at it as well.
>>
>> We'll centralize these comments in a single helper as we rework the code
>> next.
>>
>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
>> Reviewed-by: Rik van Riel <riel@surriel.com>
>> Tested-by: Laurence Oberman <loberman@redhat.com>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> Cc: Liu Shixin <liushixin2@huawei.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> with a question below.

Hi Harry,

thanks for the review!

> 
>>   mm/hugetlb.c | 24 ++++++++----------------
>>   1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 51273baec9e5d..3c77cdef12a32 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   	tlb_end_vma(tlb, vma);
>>   
>>   	/*
>> -	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
>> -	 * could defer the flush until now, since by holding i_mmap_rwsem we
>> -	 * guaranteed that the last reference would not be dropped. But we must
>> -	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
>> -	 * dropped and the last reference to the shared PMDs page might be
>> -	 * dropped as well.
>> -	 *
>> -	 * In theory we could defer the freeing of the PMD pages as well, but
>> -	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
>> -	 * detect sharing, so we cannot defer the release of the page either.
>> -	 * Instead, do flush now.
> 
> Does this mean we can now try defer-freeing of these page tables,
> and if so, would it be worth it?

There is one very tricky thing:

Whoever is the last owner of a (previously) shared page table must unmap 
any contained pages (adjust mapcount/ref, sync a/d bit, ...). So it's 
not just a matter of deferring the freeing, because these page tables 
will still contain content.

I first tried to never allow for reuse of shared page tables, but 
precisely that resulted in most headakes.

So I don't see an easy way to achieve that (and I'm also not sure if we 
want to add any further complexity to this).

-- 
Cheers

David

