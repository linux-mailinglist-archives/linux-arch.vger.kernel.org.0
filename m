Return-Path: <linux-arch+bounces-1900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA7843C09
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BE228619A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBD69973;
	Wed, 31 Jan 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXtCMcLL"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719C6996E
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696170; cv=none; b=lBjXQ3/6PElZsQx7n10UJpO3ZAip9EYHHTy3EqH/UqcAksGbIqIfAJPuqGLFxIRtUhfCLfT8EGadqzKVtnDL7VreDx3hu0R4OAyU9TbutLYtP/Eu43kaIhq3O9Drz0U/z1ATTmrXTccoGFtj2c3N60uX1tpX/H4EhUO1AR7aVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696170; c=relaxed/simple;
	bh=+fUuFbI+H/SuBr2rM99Lw5pc13uDCdDY1YWEmbLISaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH+54c6OeukVnWEbz/HRoYihuKTJHC+sZdCP6fvKeWfFiOxOQkfHStnGFyGsq/O0G1I5zqM8zzHUVQH8HQLAysMvW4IU48fWMHxSeUs8mXCo8AKNbgnSov4pZ5aSB/o5QuDnPFTVFOrb3U339/pN1gzLNcfpEvpp0V1dromK4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXtCMcLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706696166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=olrIksRwu/OB7Bur4QOxK7MpIEfH+wiCW8yB+1Kffm8=;
	b=VXtCMcLLumeJJEWpPzPK2zKyzbNBAB39Ahlsit9XtH2Q0xEmdEK9PecI+Iy473T7zzzBCQ
	kWyZFD2cCWc76SA+/KSJADbLEv2LjU2b8oTBwotyElvpNjCH6UrjowUnWBLOI0TNLKe6v0
	ilnsAvJ0u8eFL/UTEbGnlW2KuAy7psg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-0zb4Z6ONPcOueiT-VoefRQ-1; Wed, 31 Jan 2024 05:16:05 -0500
X-MC-Unique: 0zb4Z6ONPcOueiT-VoefRQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40efb04fa1fso14228285e9.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696163; x=1707300963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olrIksRwu/OB7Bur4QOxK7MpIEfH+wiCW8yB+1Kffm8=;
        b=RjNOZ1UL2vSPbptqwCTHPNfZueDF27ypVrA9gSEDoH1fZj34Y1D8XykJ1hVoLHCkF/
         psYphr4K+zacevf8Hi1Cw7QSp2yryQUPK3hyuhnEsBOjebDlVSy1m4eTF0sPNnpAi75T
         SaBAPljdVnx8IsSwmdjo29RI4FXpOGUywY+YsSrQ2mHeVfeddQMhsb5wGzvEgmYQln1w
         fiYWmExyKaKKvfxrlfCfi5+fpbQ6JZLRkAefDC1Qivhdoj+DtfIe9FcEeXXLYRYGl1P2
         gMhngG5eeKcmkgX+ayq5zeRawH+L1azievWltzIxsCqtG0oZj91+pU6cUcmMuViTugFS
         LEig==
X-Gm-Message-State: AOJu0YyCfe9CZLa7VSmddvxsFAVzm5QqCMzPdWytBtAJAnYT8ZWET0sX
	pNwMOIGBF6+BgqrAQtLyCG0i+Pb1b4VYYlrN6daUcMkj8ANT2rzH3lebedMRTyOJe9pGFI8CYfS
	KUjCDGQ8dSvp8wj/A2+tVhORCGnm+cRVXjWUAnqGIIgy6LvnbOQGv56eDDfM=
X-Received: by 2002:a05:600c:5487:b0:40e:6193:b1a5 with SMTP id iv7-20020a05600c548700b0040e6193b1a5mr854951wmb.39.1706696163442;
        Wed, 31 Jan 2024 02:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMAZswSvjgpfCfiIPLAZDAiPRc1TvD563CidrApjODUDhmgy6rYEXfqKL7+SBpHT/WE+OIlQ==
X-Received: by 2002:a05:600c:5487:b0:40e:6193:b1a5 with SMTP id iv7-20020a05600c548700b0040e6193b1a5mr854918wmb.39.1706696162974;
        Wed, 31 Jan 2024 02:16:02 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040efb20fa6csm1144646wmq.47.2024.01.31.02.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:16:02 -0800 (PST)
Message-ID: <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
Date: Wed, 31 Jan 2024 11:16:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
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
 linux-s390@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 03:20, Yin Fengwei wrote:
> On 1/29/24 22:32, David Hildenbrand wrote:
>> This series is based on [1] and must be applied on top of it.
>> Similar to what we did with fork(), let's implement PTE batching
>> during unmap/zap when processing PTE-mapped THPs.
>>
>> We collect consecutive PTEs that map consecutive pages of the same large
>> folio, making sure that the other PTE bits are compatible, and (a) adjust
>> the refcount only once per batch, (b) call rmap handling functions only
>> once per batch, (c) perform batch PTE setting/updates and (d) perform TLB
>> entry removal once per batch.
>>
>> Ryan was previously working on this in the context of cont-pte for
>> arm64, int latest iteration [2] with a focus on arm6 with cont-pte only.
>> This series implements the optimization for all architectures, independent
>> of such PTE bits, teaches MMU gather/TLB code to be fully aware of such
>> large-folio-pages batches as well, and amkes use of our new rmap batching
>> function when removing the rmap.
>>
>> To achieve that, we have to enlighten MMU gather / page freeing code
>> (i.e., everything that consumes encoded_page) to process unmapping
>> of consecutive pages that all belong to the same large folio. I'm being
>> very careful to not degrade order-0 performance, and it looks like I
>> managed to achieve that.
> 

Let's CC Linus and Michal to make sure I'm not daydreaming.

Relevant patch:
   https://lkml.kernel.org/r/20240129143221.263763-8-david@redhat.com

Context: I'm adjusting MMU gather code to support batching of 
consecutive pages that belong to the same large folio, when 
unmapping/zapping PTEs.

For small folios, there is no (relevant) change.

Imagine we have a PTE-mapped THP (2M folio -> 512 pages) and zap all 512 
PTEs: Instead of adding 512 individual encoded_page entries, we add a 
combined entry that expresses "page+nr_pages". That allows for "easily" 
adding various other per-folio batching (refcount, rmap, swap freeing).

The implication is, that we can now batch effective more pages with 
large folios, exceeding the old 10000 limit. The number of involved 
*folios* does not increase, though.

> One possible scenario:
> If all the folio is 2M size folio, then one full batch could hold 510M memory.
> Is it too much regarding one full batch before just can hold (2M - 4096 * 2)
> memory?

Excellent point, I think there are three parts to it:

(1) Batch pages / folio fragments per batch page

Before this change (and with 4k folios) we have exactly one page (4k) 
per encoded_page entry in the batch. Now, we can have (with 2M folios), 
512 pages for every two encoded_page entries (page+nr_pages) in a batch 
page. So an average ~256 pages per encoded_page entry.

So one batch page can now store in the worst case ~256 times the number 
of pages, but the number of folio fragments ("pages+nr_pages") would not 
increase.

The time it takes to perform the actual page freeing of a batch will not 
be 256 times higher -- the time is expected to be much closer to the old 
time (i.e., not freeing more folios).

(2) Delayed rmap handling

We limit batching early (see tlb_next_batch()) when we have delayed rmap 
pending. Reason being, that we don't want to check for many entries if 
they require delayed rmap handling, while still holding the page table 
lock (see tlb_flush_rmaps()), because we have to remove the rmap before 
dropping the PTL.

Note that we perform the check whether we need delayed rmap handling per 
page+nr_pages entry, not per page. So we won't perform more such checks.

Once we set tlb->delayed_rmap (because we add one entry that requires 
it), we already force a flush before dropping the PT lock. So once we 
get a single delayed rmap entry in there, we will not batch more than we 
could have in the same page table: so not more than 512 entries (x86-64) 
in the worst case. So it will still be bounded, and not significantly 
more than what we had before.

So regarding delayed rmap handling I think this should be fine.

(3) Total patched pages

MAX_GATHER_BATCH_COUNT effectively limits the number of pages we 
allocate (full batches), and thereby limits the number of pages we were 
able to batch.

The old limit was ~10000 pages, now we could batch ~5000 folio fragments 
(page+nr_pages), resulting int the "times 256" increase in the worst 
case on x86-64 as you point out.

This 10000 pages limit was introduced in 53a59fc67f97 ("mm: limit 
mmu_gather batching to fix soft lockups on !CONFIG_PREEMPT") where we 
wanted to handle soft-lockups.

As the number of effective folios we are freeing does not increase, I 
*think* this should be fine.


If any of that is a problem, we would have to keep track of the total 
number of pages in our batch, and stop as soon as we hit our 10000 limit 
-- independent of page vs. folio fragment. Something I would like to 
avoid of possible.

-- 
Cheers,

David / dhildenb


