Return-Path: <linux-arch+bounces-15492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EFCCBD90
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 922B3301E98D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690FB3346B2;
	Thu, 18 Dec 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvIZGS7s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4083346A8;
	Thu, 18 Dec 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062373; cv=none; b=mgq4UFmoUvyxbziFU0lSqeaKyj2BYUcHZrmh+YkZVkyK8NcJBadkq8YAJfAtj6CuMCpdeAs4772HQr68a8zfq9fSPmz7g+tcnhb2pyOAw+cQAmf8UiSeSJGn0QLRcHJKjM2QTMUR+wXGdjyDmU0HWFSplAy/vT2D58OF/nRuLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062373; c=relaxed/simple;
	bh=4PcjO3AAv5DkTbbnZnTkTeokRBEqI4f7EfDmqqxEmUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDDoKAtGGJaR8pkcbbSQVTtA4XqCUP3U+CbZ2+yS3q769WUY5VLspIXh040UHAclW3pWUD30iIe3Yg5Pq2LwLhgYyCvlL+zgw1saPGX3xuRu7+qfeeTCeSuMqWK4BaU/E8qTqs6hRfbFj8FOAWOJrMl0Y+/ulSsHQhJZhfLiASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvIZGS7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B5C4CEFB;
	Thu, 18 Dec 2025 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766062372;
	bh=4PcjO3AAv5DkTbbnZnTkTeokRBEqI4f7EfDmqqxEmUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jvIZGS7s+QzMFSaoNVysN2TYamdUXJ6Jl2Hq+DlBuaQ9w0DqxheKIKHVn+qEvL9CF
	 MXJDMfIJBmMDBzJJpSSiuu09BHn41tV9pd5zPSsNpTja8mk2kIpPLDz8e4l3M8N840
	 EPq6EDrm+IhG7D6GU/Vve8TalEjb0lT0M/XQ+LbSAJvC0SPXXs5cvIdoORRCayMpE7
	 acTa7HIVMGHHyDbSKEbYR/MmJXmAGB6eIjQ/cFcSuibOY2j2GTqsQn3IoGwubJuxFa
	 aKjPd+GnmBgBfCGQ3piUSHEfdmomASe8Y68QKAD6P74ib5NrZXSE7Bu0rw94XhWYRP
	 BUePV3JMHVoIQ==
Message-ID: <e10cf4de-6c00-4ed0-a1d4-d8e719f86a3e@kernel.org>
Date: Thu, 18 Dec 2025 13:52:45 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
 <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
 <07e8b94e-b4a1-4541-84ed-a5d57058d5a1@lucifer.local>
 <937a4525-910d-4596-a9c4-29e47ca53667@kernel.org>
 <4037214b-d1c6-4e0b-ad9d-6722aea7aba9@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <4037214b-d1c6-4e0b-ad9d-6722aea7aba9@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>
>>> Isn't really the correct comment here that ranges that previously mapped the
>>> shared pages might no longer, so we must clear the TLB? I may be missing
>>> something :)
>>
>> There are cases where we defer flushing the TLB until we dropped all (exclusive) locks.
>> In particular, MADV_DONTNEED does that in some cases, essentially deferring the flush
>> to the tlb_finish_mmu().
>>
>> free_pgtables() will also defer the flush, performing the TLB flush during tlb_finish_mmu(),
>> before
>>
>> The point is (as I tried to make clear in the comment), for unsharing we have no control
>> whenn the page table gets freed after we drop the lock.
>>
>> So we must flush the TLB now and cannot defer it like we do in the other cases.
> 
> Yeah I guess because of the above - that is - other users may unshare for their
> CPUs but not unshare for ours?
Yes :)

It's all very complicated, therefore I decided to rather add more 
comments describing what we depend on.

-- 
Cheers

David

