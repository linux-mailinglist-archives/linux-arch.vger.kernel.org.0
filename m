Return-Path: <linux-arch+bounces-15523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB66CD3DA2
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0CE300A1F4
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850527990A;
	Sun, 21 Dec 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb+bP8zK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00203226CF6;
	Sun, 21 Dec 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766309211; cv=none; b=gDCqS6aIRAIatMUbjTBzwTgTyR84mmjsHoKqEl9pbHZ0VxUk7S7arJaJrLEVrS1I/Ar4axhkE5WorpqyE+M0cTkmhG6u2XlSOc/fesir7r3ocrw/HrgNVWmW6YZ+7Dcr8Kbefp2j1POjDaNbTa6f9afIwQT35uWOe73hXbWMj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766309211; c=relaxed/simple;
	bh=r/HnyZxm1R6JN5eoXSIU5zr+Fo96rUTb1s7oPXl32Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVxKnhQ/qRM2iTVL9CbFf8tkeHkFMM1O06BS8WwEuxxrQIBM5wTuSxIz424S7r5O+prkK6XtlDHXcAgDzpKwFgK+EQ65oY706L92B1nNpZJZCvkxx2eEyAgMO+uJpQoS148ssV+dQQayweClexEzaiu+H6gjZ4QiX69k5YILM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb+bP8zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2618C4CEFB;
	Sun, 21 Dec 2025 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766309210;
	bh=r/HnyZxm1R6JN5eoXSIU5zr+Fo96rUTb1s7oPXl32Hg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nb+bP8zKsVe13MWjC6VhGiVGWuX60q75WG3ymxPHxQaQNoEZt9X07AZMW8bQYGoBo
	 832booaCYWwk80iWMWOGT8IZWy7QQo9K0ejIQ0DGqlYu2UNbDi1hcLCNklnidfZoYy
	 zj7y96b5+kig2ITg8FMHuXwFAxDC9QfAy3QjqOIuFQKFEugl4FMh0SkMzlCRvkFbPU
	 YsjizVCeShvDzjdpMJXhtIViD6WdPOL2tnDOyOa0fXAO3qKPo8QmR5wRj1CLn7ExRd
	 lgx7qQezmlLjeaZopnMLDrw2AGK8qUb2AHKBbIMGKzpcKWSZeZ5kcwekoiRAnADcZ4
	 eaJJnZ546eleA==
Message-ID: <b4898184-ee7b-4e37-860e-5790339059a3@kernel.org>
Date: Sun, 21 Dec 2025 10:26:42 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch@vger.kernel.org, "open list:MEMORY MANAGEMENT"
 <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
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
 Liu Shixin <liushixin2@huawei.com>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org> <aUTYE9fHf5Fq3eHa@hyeyoo>
 <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org> <aUU1DY4206FibsLf@hyeyoo>
 <2bbe1e49-95ba-42ea-b6af-5eeb61d68c4c@kernel.org>
 <3D7F0E85-2509-4925-BDD5-149E9E8D5C1F@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <3D7F0E85-2509-4925-BDD5-149E9E8D5C1F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>
>>>> Whoever is the last owner of a (previously) shared page table must unmap any
>>>> contained pages (adjust mapcount/ref, sync a/d bit, ...).
>>> Right.
>>>> So it's not just a matter of deferring the freeing, because these page tables
>>>> will still contain content.
>>> I was (and maybe still) bit confused while reading the old comment as
>>> it implied (or maybe I just misread) that by deferring freeing of page tables
>>> we don't have to flush TLB in __unmap_hugepage_range() and can flush later
>>> instead.
>>
>> Yeah, I am also confused by the old comment. I think the idea there was to drop the reference only later and thereby deferred-free the page.
> 
> My bad. I looked again, and the comment indeed doesn’t make much sense. Thanks for fixing it.

No worries, thanks for taking a look!

-- 
Cheers

David

