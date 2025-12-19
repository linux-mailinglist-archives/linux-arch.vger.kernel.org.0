Return-Path: <linux-arch+bounces-15521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17ECD2033
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 22:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41EC7300BA3E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23429265CAD;
	Fri, 19 Dec 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQB2hV//"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08733710F
	for <linux-arch@vger.kernel.org>; Fri, 19 Dec 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180290; cv=none; b=lLN/iTMzXQ6V6tyF9CdbbsX2F2u+iHnrWCcF4OfzWzK1ChOJWTz/t9IupjBc6NGh0+hom/qImWfi0bxbHbBGNc9qvSObvSHyApPVlz4UOg1SYkD00bk+2Q2wTHUJv5W8edHFHEC7GKVvNuz15iu/GYvXescbMAikai6hZaCJLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180290; c=relaxed/simple;
	bh=ZM7HFDiERUcQNinAOST8oE0V9vxab3YGWH4CoJcMNYA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pj8+QKUqtfs9csKfCFOVd9YcbfuhkOLKZ2ycgcYktoOVitHgwGvjMUATdGi/SE2mi68MhTeOAdYJ7vPH2jSCSG+ptEvL6Xod8Prs+JyXsJxTnnegJFfbn5t9lWPgENqrPjvoHem2k4QsG2Ftvb2zPU3aYRR5/BCvaQJY7FZrLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQB2hV//; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so1257803f8f.2
        for <linux-arch@vger.kernel.org>; Fri, 19 Dec 2025 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180285; x=1766785085; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qwBOZjXZNgWuokEpvkuCyDN4qULKX2eOsVZKGx+BRc=;
        b=hQB2hV//Q5VTBnLMvOiXLniSjt8KBaDoyxwEFPH51GgzFMhrNTZgdfOcsM/KyNTILt
         R6RLyu/TPdkQ67WMPAAMWxGR+E+pOcm5UFLK1B01G7ItwPSwew9/J9KVb8jQTFUwD24y
         LXc+YOIqizJlacP0XNGSKo5LUbrTYjDFDbJjJ1pVoQu3SNaXPTQBOyEkJzHxz7d/U0J0
         Ka6cMQ5RvA0OMJRwiVjLf8z1FZP3oGTzT6Pp+wQJa2X5DrBhBwOEL9ZPqZZ0g3C/GLCg
         fS+QxOZzelrVeKDYiNYVB94Q2MO0yV4kBBGTs37ixHORpiGw6W1uSOYaEsFeW23H18sH
         ucZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180285; x=1766785085;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qwBOZjXZNgWuokEpvkuCyDN4qULKX2eOsVZKGx+BRc=;
        b=o7XqRGur+mxaQSCaIiC9MXSsX0RH9iCAsIoVlcumMmO1pkRPdU3PoueYFNxXCyxgTy
         zTmDIBBYNC02sWQr0Vf5X4fLiE8AI7CUe/Y+DvvWhO2eo81fcoBZTAspoU7Aeja9WxXO
         GeddSP+rJtn9XEczoJ8wtIqQeNSdTx85i5TyyrneA/+ZzdeoNwoq/1ZwrrczRYiH4HAr
         B6KQVxS7mCmlWvflW1KwFDlF2CqQh3OlODFlcvwb5ET3zYPAg6Kp09iQRH/5nL8TSFOr
         9LQd2Se4gl9LXpex7xVCES+ToSHBTiEy/dluDJLL3sAFdwvv5EieHqGszwv+6r6TN/Gh
         xDLw==
X-Forwarded-Encrypted: i=1; AJvYcCVpb0xIk4pVojti727aOvRbHrBDh1PM93QvWJ0ibnwnxLsE0i/l2iGMqW99nYsxM7IJ2Pz5TSaju2Zu@vger.kernel.org
X-Gm-Message-State: AOJu0YxNO47LGubf369LLjzsf0afy3fn1TPGP6xi0PHi8sgRP+MNMcpS
	FPiJw/sZV4DAMiiBdSQNX0bdpa/fZMxDW+0KJ2TP8VkQJXZyWBF3el79
X-Gm-Gg: AY/fxX5UpDsDs7HvaLDpwj5GQLJO1ZFxWidoqZPC9GGDQlXfMBywtNgpfL+1mEDNBV3
	RiMNHxFHWhbRpq+HDhnKZ3Pize77wTEBs7xTlBcfhglOfbB4wETeScjX1MS5V2lp7m829w6gJVi
	HTouJIw3OzcbVCSgKjUstSHapcK3R2sEnVX4qn40bwmlVOxsyCS4I4I3Yk7aF6rIttc0JhFgm4N
	TvFQRFRuIJJOtGIDOZt2jfbtPkpj50yrqiRirSmjh/zA4UkSRsI2cN52QPOHfWwGTzJDEK++J+N
	UZt8wbJyJu7aUlU6bMdu01vKZXqwzulniRR3yue45ph/WPapD/X8D/CGjeYWlsbXK/IeK1osFqF
	Cz8bTMZfLFTn8HYwEC+yWvW2A7YBGRO8KObq/g91RLH6ch5TJBhWyWPu0v5LmcevCZNSVQUGCre
	t8zq4VQmzuvq26OhzUYRgyN7jCy4zoeLc=
X-Google-Smtp-Source: AGHT+IGyru8SGJqlxv8zJOxc9PglQsmvyTXqM/wZEemUdJ3eOipdnMijVxzSqXLtGy838wDBtvYe1A==
X-Received: by 2002:a05:6000:178c:b0:431:918:501d with SMTP id ffacd0b85a97d-4324e702853mr4655672f8f.60.1766180285071;
        Fri, 19 Dec 2025 13:38:05 -0800 (PST)
Received: from smtpclient.apple ([212.59.64.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm6922431f8f.3.2025.12.19.13.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:38:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <2bbe1e49-95ba-42ea-b6af-5eeb61d68c4c@kernel.org>
Date: Fri, 19 Dec 2025 23:37:50 +0200
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>,
 Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Liu Shixin <liushixin2@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D7F0E85-2509-4925-BDD5-149E9E8D5C1F@gmail.com>
References: <20251212071019.471146-1-david@kernel.org>
 <20251212071019.471146-3-david@kernel.org> <aUTYE9fHf5Fq3eHa@hyeyoo>
 <506fef86-5c3b-490e-94f9-2eb6c9c47834@kernel.org> <aUU1DY4206FibsLf@hyeyoo>
 <2bbe1e49-95ba-42ea-b6af-5eeb61d68c4c@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On 19 Dec 2025, at 16:13, David Hildenbrand (Red Hat) =
<david@kernel.org> wrote:
>=20
> On 12/19/25 12:20, Harry Yoo wrote:
>> On Fri, Dec 19, 2025 at 07:11:00AM +0100, David Hildenbrand (Red Hat) =
wrote:
>>> On 12/19/25 05:44, Harry Yoo wrote:
>>>> On Fri, Dec 12, 2025 at 08:10:17AM +0100, David Hildenbrand (Red =
Hat) wrote:
>>>>> Ever since we stopped using the page count to detect shared PMD
>>>>> page tables, these comments are outdated.
>>>>>=20
>>>>> The only reason we have to flush the TLB early is because once we =
drop
>>>>> the i_mmap_rwsem, the previously shared page table could get freed =
(to
>>>>> then get reallocated and used for other purpose). So we really =
have to
>>>>> flush the TLB before that could happen.
>>>>>=20
>>>>> So let's simplify the comments a bit.
>>>>>=20
>>>>> The "If we unshared PMDs, the TLB flush was not recorded in =
mmu_gather."
>>>>> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
>>>>> correctly after huge_pmd_unshare") was confusing: sure it is =
recorded
>>>>> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
>>>>> anything. So let's drop that comment while at it as well.
>>>>>=20
>>>>> We'll centralize these comments in a single helper as we rework =
the code
>>>>> next.
>>>>>=20
>>>>> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table =
shared count")
>>>>> Reviewed-by: Rik van Riel <riel@surriel.com>
>>>>> Tested-by: Laurence Oberman <loberman@redhat.com>
>>>>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> Acked-by: Oscar Salvador <osalvador@suse.de>
>>>>> Cc: Liu Shixin <liushixin2@huawei.com>
>>>>> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>>>> ---
>>>>=20
>>>> Looks good to me,
>>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>>=20
>>>> with a question below.
>>>=20
>>> Hi Harry,
>>>=20
>>> thanks for the review!
>> No problem!
>> I would love to review more, as long as my time & ability allows ;)
>>>>>   mm/hugetlb.c | 24 ++++++++----------------
>>>>>   1 file changed, 8 insertions(+), 16 deletions(-)
>>>>>=20
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 51273baec9e5d..3c77cdef12a32 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -5304,17 +5304,10 @@ void __unmap_hugepage_range(struct =
mmu_gather *tlb, struct vm_area_struct *vma,
>>>>>    tlb_end_vma(tlb, vma);
>>>>>    /*
>>>>> -  * If we unshared PMDs, the TLB flush was not recorded in =
mmu_gather. We
>>>>> -  * could defer the flush until now, since by holding =
i_mmap_rwsem we
>>>>> -  * guaranteed that the last reference would not be dropped. But =
we must
>>>>> -  * do the flushing before we return, as otherwise i_mmap_rwsem =
will be
>>>>> -  * dropped and the last reference to the shared PMDs page might =
be
>>>>> -  * dropped as well.
>>>>> -  *
>>>>> -  * In theory we could defer the freeing of the PMD pages as =
well, but
>>>>> -  * huge_pmd_unshare() relies on the exact page_count for the PMD =
page to
>>>>> -  * detect sharing, so we cannot defer the release of the page =
either.
>>>>> -  * Instead, do flush now.
>>>>=20
>>>> Does this mean we can now try defer-freeing of these page tables,
>>>> and if so, would it be worth it?
>>>=20
>>> There is one very tricky thing:
>>>=20
>>> Whoever is the last owner of a (previously) shared page table must =
unmap any
>>> contained pages (adjust mapcount/ref, sync a/d bit, ...).
>> Right.
>>> So it's not just a matter of deferring the freeing, because these =
page tables
>>> will still contain content.
>> I was (and maybe still) bit confused while reading the old comment as
>> it implied (or maybe I just misread) that by deferring freeing of =
page tables
>> we don't have to flush TLB in __unmap_hugepage_range() and can flush =
later
>> instead.
>=20
> Yeah, I am also confused by the old comment. I think the idea there =
was to drop the reference only later and thereby deferred-free the page.

My bad. I looked again, and the comment indeed doesn=E2=80=99t make much =
sense. Thanks for fixing it.




