Return-Path: <linux-arch+bounces-15305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7286CAB474
	for <lists+linux-arch@lfdr.de>; Sun, 07 Dec 2025 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E64330319AF
	for <lists+linux-arch@lfdr.de>; Sun,  7 Dec 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6A2C031B;
	Sun,  7 Dec 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0MPFla5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD619049B;
	Sun,  7 Dec 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111161; cv=none; b=gNvcBvtfHlvo+9gQVig9hsE41zl23zJWiYu7AllD2BDA2PAdX2YWCpyjO402oHQ3rQ92GtnLrK/XB3v48pPyR+JwdfhfJHTbCeixVsphsAFzvlp3Hz0hx2h815EVy7U278TAYYFn1wtjP3NcWOhbEqZ4MR0DF4P5gmsGmXE1S6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111161; c=relaxed/simple;
	bh=EDc/Ngb1HhThAXOD7k5e16o4L5UdHvj6G/GaIzURyHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnyXOrtnRVPEHGbVOpa+2pXfaoz3PJSrHDa5Z3kzfVHnePPuAlnjYwXm3VygFTcgdGz+FII2T293LQJwNcaXk1XLSWLQ+jzz1IA4CodxX7uu1zkuMrppTfI8QcZZnAF2bwmQTxmlk94+i+afuVmb+AXw5oXqpRqDEpoecA6FDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0MPFla5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E14C4CEFB;
	Sun,  7 Dec 2025 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765111160;
	bh=EDc/Ngb1HhThAXOD7k5e16o4L5UdHvj6G/GaIzURyHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j0MPFla55Igf6JYotD4zn3bR76m/U/xQjs3q3ZMqJopt9AYI0rPAlbxo+C0QqslCv
	 eKPyvW19I4GQDtiTkAhTrQD5nDqmh3RthlxWAf8lKyoagQbNXZFQ+xaJAuR/946JXI
	 4LhPNsW6osRoKI5nbkX68Lcndo7tXjSmvrR+hJONbEJtOoV4m0O8mr8cEx0vxOqxVM
	 F6IBzsyRzU0IlQNIcCB4WT9GU/1A913ajVoi1VzTGcPNcnviFPdZ5tpzSv2hMFkjOx
	 j3cGSrwa0orHQroytDD03PY2FkvYDWoPXLv7Whw72v1O1riVVO300gsqy1Ccvt8B6a
	 nw/aLSciIFdBw==
Message-ID: <3a408dd9-a38c-4202-b79f-91bff843ee82@kernel.org>
Date: Sun, 7 Dec 2025 13:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
To: Nadav Amit <nadav.amit@gmail.com>
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
 Harry Yoo <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, stable@vger.kernel.org
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
 <C9D5EFFF-05D9-435C-96C1-4B13134E2904@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <C9D5EFFF-05D9-435C-96C1-4B13134E2904@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/7/25 13:24, Nadav Amit wrote:
> 
> 
>> On 7 Dec 2025, at 14:15, Nadav Amit <nadav.amit@gmail.com> wrote:
>>
>>
>>> On 5 Dec 2025, at 23:35, David Hildenbrand (Red Hat) <david@kernel.org> wrote:
>>>
>>> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>>>
>>
>> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>> 	tlb->cleared_pmds = 0;
>> 	tlb->cleared_puds = 0;
>> 	tlb->cleared_p4ds = 0;
>> +	tlb->unshared_tables = 0;
>> 	/*
>> 	 * Do not reset mmu_gather::vma_* fields here, we do not
>> 	 * call into tlb_start_vma() again to set them if there is an
>>
>> I understand you don’t want to initialize fully_unshared_tables here, but
>> tlb_gather_mmu() needs to happen somewhere. So you probably want it to
>> take place in tlb_gather_mmu(), no?
> 
> To clarify my messed up response: the code needs to initialize fully_unshared_tables
> somewhere during tlb_gather_mmu() invocation.

Good point, __tlb_gather_mmu() needs to initialize it explicitly!

Thanks a lot for the review, appreciated!

-- 
Cheers

David

