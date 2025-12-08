Return-Path: <linux-arch+bounces-15308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C5CACF0F
	for <lists+linux-arch@lfdr.de>; Mon, 08 Dec 2025 12:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D4F301E598
	for <lists+linux-arch@lfdr.de>; Mon,  8 Dec 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA262EA156;
	Mon,  8 Dec 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghs95GrY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221E2E54D1;
	Mon,  8 Dec 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191720; cv=none; b=niU4F10EHeT1uADDD6J4HfuQfAdp6/AOBhsokyECvNH6+rHOZr4EgBfb3b8bn+1Wxog6uo/V56t6gWkxZTpqYbxy+yYPZYmUW4Z4AsZUtgpSFiVB1sjgpFKFL0wMBaHOplr4SGpH1Doj4A3sgr8zhkDDTjrPMPTZ9TJyCk3PfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191720; c=relaxed/simple;
	bh=R/IYT/sJW+5X1kFREBNtpFtBsBV21sa2yHFx+ZlhqgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY5KiYpY+nQd9awk1XXAZZS4BPBPFdPqhCekiJ7dlyvILStGyZnZ8fqqs/QHcaKHmUcve3oE1Tap21by1T7uGbQrdfm+RJt5J+mtUjXfP826+ieytUY152YEpkiQ6kC9J8q0Kdxw/DZIuN7sjPZvHByMEeofvXDrYmdVWVlcgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghs95GrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327EDC4CEF1;
	Mon,  8 Dec 2025 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765191718;
	bh=R/IYT/sJW+5X1kFREBNtpFtBsBV21sa2yHFx+ZlhqgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ghs95GrY5ScohXYjFvZ3Pct4IVKtbIQFTq16pcDwX0qW1JK1QBau1Eh4h8ro3QLRI
	 Vz6R82+4uv53h+UH3QRrhJB5mpkhVo60A2ypV5I1iR9JCpnv6XrgnmBVoaQtx6t0Ta
	 knH69Qdc29CMD4l9ax37fvZFgvqN/+wT4qDRiFSKNeoPyaem5QpFlDzNboEj81qbmH
	 WsF7g6QNw08rWLujeDvsJVWNi7TpHJIYm+kk55N9KQLCaYuD7mrkg9dZec9HuGXtyh
	 Yt4Hp1p5GtbhjiElQrv/r70VZeUDKIro4myDjeGBfi1ch2sh0BpSY80y8tSes4XpjX
	 ASvRwt7YDTwxA==
Message-ID: <246da543-58a9-4b61-8c88-5ceaca9dc12a@kernel.org>
Date: Mon, 8 Dec 2025 12:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
To: Lance Yang <ioworker0@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, harry.yoo@oracle.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, liushixin2@huawei.com, loberman@redhat.com,
 lorenzo.stoakes@oracle.com, muchun.song@linux.dev, nadav.amit@gmail.com,
 npiggin@gmail.com, osalvador@suse.de, peterz@infradead.org,
 pfalcato@suse.de, prakash.sangappa@oracle.com, riel@surriel.com,
 stable@vger.kernel.org, vbabka@suse.cz, will@kernel.org,
 Lance Yang <lance.yang@linux.dev>
References: <20251205213558.2980480-2-david@kernel.org>
 <20251208023231.1257-1-ioworker0@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251208023231.1257-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 03:32, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> 
> On Fri,  5 Dec 2025 22:35:55 +0100, David Hildenbrand (Red Hat) wrote:
>> We switched from (wrongly) using the page count to an independent
>> shared count. Now, shared page tables have a refcount of 1 (excluding
>> speculative references) and instead use ptdesc->pt_share_count to
>> identify sharing.
>>
>> We didn't convert hugetlb_pmd_shared(), so right now, we would never
>> detect a shared PMD table as such, because sharing/unsharing no longer
>> touches the refcount of a PMD table.
>>
>> Page migration, like mbind() or migrate_pages() would allow for migrating
>> folios mapped into such shared PMD tables, even though the folios are
>> not exclusive. In smaps we would account them as "private" although they
>> are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
>> pagemap interface.
>>
>> Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
>>
>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
>> Cc: <stable@vger.kernel.org>
>> Cc: Liu Shixin <liushixin2@huawei.com>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
> 
> Tested on x86 with two independent processes sharing a 1GiB hugetlbfs file
> (aligned a 1GiB boundary).
> 
> Before the fix, even though PMD sharing worked (pt_share_count=1),
> hugetlb_pmd_shared() returned false because page_count() was still 1,
> causing smaps to report it as "Private" and pagemap to set it
> PM_MMAP_EXCLUSIVE incorrectly :(
> 
> After the fix, hugetlb_pmd_shared() correctly detects the sharing, smaps
> reports it as "Shared", and PM_MMAP_EXCLUSIVE is cleared ;)
> 
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks a lot Lance for the testing and thanks to everybody for the review!

-- 
Cheers

David

