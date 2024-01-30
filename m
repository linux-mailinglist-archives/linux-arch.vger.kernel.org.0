Return-Path: <linux-arch+bounces-1828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCC0841E40
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12DC28A5DD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C052F62;
	Tue, 30 Jan 2024 08:47:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35C38DEC;
	Tue, 30 Jan 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604422; cv=none; b=a634CN6/Bv9OkU3sdC7O2aNqYm6G/8TMz6UyhLHx4+RH3nJIkMke3FIC4M0QwwctA9ItXzTTvyxSRhuQgE/1xvZgJDecT+o2eF1xMNTqZ2AtngPYXshrmBsWlMDg4SDsROigRMSpKGSaK5u7tdHNwkWj/anTHl9emT3J1ozbhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604422; c=relaxed/simple;
	bh=84ecXwbsd/BvqAcgY841C0nLUGHtRtatekrbUkT7Jng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAuV7yCcSgLjeYvFxX3BL8OTp/9nL1u4R5zR/PcE+EEtWVQqAVtK+X/hOxjhNK35JOMKl+RT1tdYxfzbxAslPvU65CucgbWtRpnJjnkZV1UGg3rkjSbh/g9nDKr58cYzzO8Bhru4p1UH3CSEpCwds5J0igCmfch+JTA2XDWFJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C161DA7;
	Tue, 30 Jan 2024 00:47:42 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D169F3F738;
	Tue, 30 Jan 2024 00:46:55 -0800 (PST)
Message-ID: <cae11a08-2f5c-43ca-92fc-a78e9acf4dd8@arm.com>
Date: Tue, 30 Jan 2024 08:46:55 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] mm/memory: factor out zapping of present pte into
 zap_present_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-2-david@redhat.com>
 <40e87333-4da9-4497-a117-9885986e376a@arm.com>
 <8d19d635-2f55-4c0d-958b-0640f99ff0ce@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8d19d635-2f55-4c0d-958b-0640f99ff0ce@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 08:41, David Hildenbrand wrote:
> On 30.01.24 09:13, Ryan Roberts wrote:
>> On 29/01/2024 14:32, David Hildenbrand wrote:
>>> Let's prepare for further changes by factoring out processing of present
>>> PTEs.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/memory.c | 92 ++++++++++++++++++++++++++++++-----------------------
>>>   1 file changed, 52 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index b05fd28dbce1..50a6c79c78fc 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1532,13 +1532,61 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct
>>> *vma,
>>>       pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>>   }
>>>   +static inline void zap_present_pte(struct mmu_gather *tlb,
>>> +        struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
>>> +        unsigned long addr, struct zap_details *details,
>>> +        int *rss, bool *force_flush, bool *force_break)
>>> +{
>>> +    struct mm_struct *mm = tlb->mm;
>>> +    bool delay_rmap = false;
>>> +    struct folio *folio;
>>
>> You need to init this to NULL otherwise its a random value when calling
>> should_zap_folio() if vm_normal_page() returns NULL.
> 
> Right, and we can stop setting it to NULL in the original function. Patch #2
> changes these checks, which is why it's only a problem in this patch.

Yeah I only noticed that after sending out this reply and moving to the next
patch. Still worth fixing this intermediate state I think.

> 
> Will fix, thanks!
> 


