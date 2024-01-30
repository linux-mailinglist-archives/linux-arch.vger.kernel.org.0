Return-Path: <linux-arch+bounces-1818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF7841B1D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 05:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B9728458D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 04:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DA374D4;
	Tue, 30 Jan 2024 04:52:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C96376EA;
	Tue, 30 Jan 2024 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706590356; cv=none; b=oMz8nH17qrj+eNtclkPEaA/dmhBFvTvvcN3G4ArVWY4T46++tPgLhxjd0VGuP9wUaMO6O+SoB8xaVSAel43Y0m1DPb/ut0YuDQsA2hgEgpvWZy8JQawDzXjmhZ+opaf2SlMNHSxL346GSG8QHNucz656II5Z+PqeL78LjpKGfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706590356; c=relaxed/simple;
	bh=pSny46fbcm5afdgGkL8N9AZNYoV2BmDZXSWgbG1D29A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoGenMDxeebLrD+fGkOt6fdpPkhzv+dBI2J3alJpNIvwVikmN38GCWBxvTPAw8aw6FJYx4bjM4EdUQ3akB7hC5RMor6m12RhZoKn3JKOHDJ0BNeO3ya4vXmKlu2fuhSg2RBu8Jb/gZWBixetMFdDqh72Bk5NEZH2ETa3YMz8T14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB05DA7;
	Mon, 29 Jan 2024 20:53:11 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BD03F762;
	Mon, 29 Jan 2024 20:52:15 -0800 (PST)
Message-ID: <2cb8288c-5378-4968-a75b-8462b41998c6@arm.com>
Date: Tue, 30 Jan 2024 10:22:11 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/35] mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count
 the number of pages
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-7-alexandru.elisei@arm.com>
 <0a71c87a-ae2c-4a61-8adb-3a51d6369b99@arm.com> <ZbeRQpGNnfXnjayQ@raptor>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZbeRQpGNnfXnjayQ@raptor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 17:21, Alexandru Elisei wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 02:54:20PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 1/25/24 22:12, Alexandru Elisei wrote:
>>> The CMA_ALLOC_SUCCESS, respectively CMA_ALLOC_FAIL, are increased by one
>>> after each cma_alloc() function call. This is done even though cma_alloc()
>>> can allocate an arbitrary number of CMA pages. When looking at
>>> /proc/vmstat, the number of successful (or failed) cma_alloc() calls
>>> doesn't tell much with regards to how many CMA pages were allocated via
>>> cma_alloc() versus via the page allocator (regular allocation request or
>>> PCP lists refill).
>>>
>>> This can also be rather confusing to a user who isn't familiar with the
>>> code, since the unit of measurement for nr_free_cma is the number of pages,
>>> but cma_alloc_success and cma_alloc_fail count the number of cma_alloc()
>>> function calls.
>>>
>>> Let's make this consistent, and arguably more useful, by having
>>> CMA_ALLOC_SUCCESS count the number of successfully allocated CMA pages, and
>>> CMA_ALLOC_FAIL count the number of pages the cma_alloc() failed to
>>> allocate.
>>>
>>> For users that wish to track the number of cma_alloc() calls, there are
>>> tracepoints for that already implemented.
>>>
>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>> ---
>>>  mm/cma.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/cma.c b/mm/cma.c
>>> index f49c95f8ee37..dbf7fe8cb1bd 100644
>>> --- a/mm/cma.c
>>> +++ b/mm/cma.c
>>> @@ -517,10 +517,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>>>  	pr_debug("%s(): returned %p\n", __func__, page);
>>>  out:
>>>  	if (page) {
>>> -		count_vm_event(CMA_ALLOC_SUCCESS);
>>> +		count_vm_events(CMA_ALLOC_SUCCESS, count);
>>>  		cma_sysfs_account_success_pages(cma, count);
>>>  	} else {
>>> -		count_vm_event(CMA_ALLOC_FAIL);
>>> +		count_vm_events(CMA_ALLOC_FAIL, count);
>>>  		if (cma)
>>>  			cma_sysfs_account_fail_pages(cma, count);
>>>  	}
>>
>> Without getting into the merits of this patch - which is actually trying to do
>> semantics change to /proc/vmstat, wondering how is this even related to this
>> particular series ? If required this could be debated on it's on separately.
> 
> Having the number of CMA pages allocated and the number of CMA pages freed
> allows someone to infer how many tagged pages are in use at a given time:

That should not be done in CMA which is a generic multi purpose allocator.

> (allocated CMA pages - CMA pages allocated by drivers* - CMA pages
> released) * 32. That is valuable information for software and hardware
> designers.
> 
> Besides that, for every iteration of the series, this has proven invaluable
> for discovering bugs with freeing and/or reserving tag storage pages.

I am afraid that might not be enough justification for getting something
merged mainline.

> 
> *that would require userspace reading cma_alloc_success and
> cma_release_success before any tagged allocations are performed.

While assuming that no other non-memory-tagged CMA based allocation amd free
call happens in the meantime ? That would be on real thin ice.

I suppose arm64 tagged memory specific allocation or free related counters
need to be created on the caller side, including arch_free_pages_prepare().

