Return-Path: <linux-arch+bounces-15610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D175CEABEB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 23:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7401030285FD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC12BD5A7;
	Tue, 30 Dec 2025 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWivimCr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B43283FCD;
	Tue, 30 Dec 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132064; cv=none; b=Wjpdh2GZpyiHk6nnEeYNfPA/heSPRTdqCWTpnQm0vW0HZP0Syp8zmcRUt3zmSTvuxPYwSrEfb1PvuPP6ZYClubMMNt3wTSZZonea+unSTHIVTP7avsMnWb6JO9d/C7mVVVDBwOnsc/YjWDLntG+BUFSkcvIbQCQJWKAMIj2flOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132064; c=relaxed/simple;
	bh=AwKXS5qfRcE5WBRvoQ+OLxVnWHCnRm9YUX47a62+58o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbQZaCu4fMtuV1PlizdJDZsSQp20eA6gxe+auGs8Mqq06cQzb0aFrYfOwhYUCbAVYqZytjWgFNvuby4v/ry1l4JlSDbNEAf1Azp3vA3dJVApkEqhV743VHgHx3szX4wzWrfqEob6KK6Hop9SwpJgwLXyNXBBhmBe/61jSDXPk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWivimCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6DC113D0;
	Tue, 30 Dec 2025 22:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767132063;
	bh=AwKXS5qfRcE5WBRvoQ+OLxVnWHCnRm9YUX47a62+58o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IWivimCrtOyINskmmLAhy6/igkHIx1E/ClX0ZQYGyHxk1UXhd5uoPMfkybAiHcQ9y
	 K/0B4XygH/WDV5uqQrKOIbdCB+qtJaKC+PKg5OwkNQEJWshw3myH8z4r+qJ23PjKom
	 NylPw51jkM3TZAXsborhx6SREG/OpbSb9x40L79Vd7ol9ySCPpR0cK8C9dCl9XZwGx
	 J5g/1E2ZX+bH0HFt0l4J9liDp+C+BZEOYpb0aDekIIyI2gfVEYS82vS9ofhpi2zLUk
	 Rgm3PiotFK8xfZrun03mCZClS+AVywjl0SBkxAtc2RRjy13TIxd3lEjS4CbBEBzDLv
	 fcDNuIJwvxAxQ==
Message-ID: <bb3e8b8f-4af4-4e12-83b2-fed6e20edd64@kernel.org>
Date: Tue, 30 Dec 2025 23:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 4/4] mm/hugetlb: fix excessive IPI broadcasts
 when unsharing PMD tables using mmu_gather
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
 Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
References: <20251223214037.580860-1-david@kernel.org>
 <20251223214037.580860-5-david@kernel.org> <aVHnxxOAGu26a5Cr@hyeyoo>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aVHnxxOAGu26a5Cr@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Fixes: 1013af4f585f ("mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race")
>> Reported-by: Uschakow, Stanislav" <suschako@amazon.de>
>> Closes: https://lore.kernel.org/all/4d3878531c76479d9f8ca9789dc6485d@amazon.de/
>> Tested-by: Laurence Oberman <loberman@redhat.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> ---
> 
> Looks correct and nothing jumped out at me during review, so:
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> 

Thanks Harry! And thanks again for making me look again at the hugetlb 
mmu_gather horrors :)

-- 
Cheers

David

