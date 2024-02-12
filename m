Return-Path: <linux-arch+bounces-2179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B185105C
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 11:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7E5B233B0
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94F17C68;
	Mon, 12 Feb 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn+lP0go"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8F17C62
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732714; cv=none; b=gvlbD6PKEYZ716KIvgHp9XvdvNH9Pg++Vr2R1cja+iMfwvgbhnTbU+7Dk6OskzLSGi66AbrT4l4lw008VcsOXTBkOKrlSSCt/TyVcYIoEkBMgDYWZfOfTc2LKf53deX+xlO91L8Fy1Xg0L6JdoarPGAfzl+odBrXvF3W7yu2zUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732714; c=relaxed/simple;
	bh=EsDLRCNgBBkHpMvWo3dkQLR5TLheexE1oSgsf7G0GBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpjwPbdbyf1ZCfNVn86z8S40WhiaEZinkPVws556lKB9lIN9bPFL60kgaMQ7pw47PzhygIgvyr/OBQ5pI0fEEDFI+2HiByDYKMYZk2swgZSQ7l2TcCNVacbfLUfTCd4jfd6SjrQxLJjaRelf9UMwiDXginEXUx/KSIbFvLqawLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn+lP0go; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707732710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+2pRSCdMqyAZN8/VuuYCHaUNoBN7lwTPUXnd9XEGQ+w=;
	b=cn+lP0goCPBVtsDhdpAR8yvB98CoHTvJlcValHa3p0dZl0mRvkUqZB7mbvsAOcvg9bW4r3
	9YHTN1CCBjoUnY9IRLi7cARWyKJy9pJtDbBuuPcV8HIuHmhIuRifFA0o6Q3CdxVuNLSJoV
	inKSjpx8JMC1kRTXf3cTa0ICgNkFMWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-swtNSh1OPRiLq4bRsfJoBw-1; Mon, 12 Feb 2024 05:11:48 -0500
X-MC-Unique: swtNSh1OPRiLq4bRsfJoBw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-410727c32bdso12709715e9.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 02:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732707; x=1708337507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2pRSCdMqyAZN8/VuuYCHaUNoBN7lwTPUXnd9XEGQ+w=;
        b=rDUUzukzWYu2oe7JF8hwr72cg5F53FNelVb10HKJ+xkz1k+9Qb1eDH+kUpVfr9Ae8y
         oGMC/qaE3n5OTGSxaZ3/LKPYmF1ZqMDn1VY65xlVP+5BPhds83Jcj7mR2GsQ7Q3UY7Gt
         l4x7t2wWqNYxnpX3QoJy15IPHAwkQIipJgu1ObTdxcNhIRCrMz+4O1HFZ2r21+/Bksn5
         uFbFQYAqZ/IuA+xhZ/KT553J3v/p2DVOxLOrYCNqRPufG4n31jnr9rCcP3G0IzdqRJKj
         Or74YRZvYXRcK4hICZdxk4Z34g7zavcogBkBspPd/DxpxWkhNlfZyunF5BTAYMbXM3Wv
         m7Ww==
X-Gm-Message-State: AOJu0YxeVQb38LdxNIOLdydVLipXPd/rH+5cmXWjBh+Gh++fHamnb/yW
	DV/zxzM6kFwbt5+OdZsqs1NgNkQt7ZYk0g4M2Nkn27nxIFO+G2UMPK6FFXMC2wne0+vEXNZ0Vgm
	rJaCkMJMTLamzWRMWwInErZLwbX+Gi4YUlC28+f+Et/RGSlhghMBM6Bj0i1I=
X-Received: by 2002:a05:600c:600e:b0:410:be25:12bf with SMTP id az14-20020a05600c600e00b00410be2512bfmr2510600wmb.38.1707732707081;
        Mon, 12 Feb 2024 02:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+hlQMe30T62KMwr+luZOaXUQu5EKvOVB62I9SuHj1bCg0U6QR5ufA6j/zcrcMvqTl++iPog==
X-Received: by 2002:a05:600c:600e:b0:410:be25:12bf with SMTP id az14-20020a05600c600e00b00410be2512bfmr2510563wmb.38.1707732706666;
        Mon, 12 Feb 2024 02:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwkAeAYQR7Gfoxupr5qBG9m0EFbv7DDI7aCfZtMNyIROIXA/SOrjkaJ59sr8xsqiaVCkCmlEIRjxy3J0wXfxX4p/V/LReolwctKJtaf6B3xBn7OrP0bc+txI9JVmFNAWwZNO6OMGWo3IXumCONO6uNSMmNTfbFmAY4pOA1lJgpDYGCD7L+3n273ujqqyssnrkBYDPGUmeZCNVHvSm6nOQmhOiwdAGGkbh9s4spMdJMjZUHweVEwDvqzZu+WY2iXCqg6PvKFOcrzgEd0inHm2VWhnlxmT+IxhcswK98pkwM1pdbqKpMZ8Ajk1JT4NE78LQt/mXy49lkqHahYzz6hjzT+dfzIx4V3DXSeAokKyb1gnl/iSmZRlqLUCcOgsmg3+wwBBOuVupln+MiH6egoWuOb0D3bdc75Mj8jQ3mkZXn+noa+I0RKgGk58qf9AmfYfgmoUeVxAHFDz6H2fGJSuPdxMMemhULInkfywbgcL4XDyX9Z53mEt7zOhan4AtbDYaknEn4fCZ/1MCYlw3aWeqpmwzPFZmOAeLuSio1iOcsGub9eXKx0M2nKuxJ4n1jPEP1oNBvLg89cxTfdtPQA43Yj+xKlc5QfNDyXl6bRRX286HkHyWSz/FRQYbEwdh7nAxD+scmPiWtw4qBIOUM0qZ0NG8OHtJi963eUHH1Om8YBT7l+DoZEuPwB1JBihSLrOPpnPqsDQCQDEYMqPRaoFdAtOdGG27xai7PTo0pl2W0EdZROwY=
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id bd27-20020a05600c1f1b00b00410d3b8c4c1sm2565365wmb.31.2024.02.12.02.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:11:46 -0800 (PST)
Message-ID: <6c66f7ca-4b14-4bbb-bf06-e81b3481b03f@redhat.com>
Date: Mon, 12 Feb 2024 11:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] mm/mmu_gather: improve cond_resched() handling
 with large folios and expensive page freeing
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Michal Hocko <mhocko@suse.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240209221509.585251-1-david@redhat.com>
 <20240209221509.585251-10-david@redhat.com>
 <f1578e92-4de0-4718-bf79-ec29e9a19fe0@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f1578e92-4de0-4718-bf79-ec29e9a19fe0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ryan,

>> -static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>> +static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
>>   {
>> -	struct mmu_gather_batch *batch;
>> -
>> -	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>> -		struct encoded_page **pages = batch->encoded_pages;
>> +	struct encoded_page **pages = batch->encoded_pages;
>> +	unsigned int nr, nr_pages;
>>   
>> +	/*
>> +	 * We might end up freeing a lot of pages. Reschedule on a regular
>> +	 * basis to avoid soft lockups in configurations without full
>> +	 * preemption enabled. The magic number of 512 folios seems to work.
>> +	 */
>> +	if (!page_poisoning_enabled_static() && !want_init_on_free()) {
> 
> Is the performance win really worth 2 separate implementations keyed off this?
> It seems a bit fragile, in case any other operations get added to free which are
> proportional to size in future. Why not just always do the conservative version?

I really don't want to iterate over all entries on the "sane" common 
case. We already do that two times:

a) free_pages_and_swap_cache()

b) release_pages()

Only the latter really is required, and I'm planning on removing the one 
in (a) to move it into (b) as well.

So I keep it separate to keep any unnecessary overhead to the setups 
that are already terribly slow.

No need to iterate a page full of entries if it can be easily avoided. 
Especially, no need to degrade the common order-0 case.

> 
>>   		while (batch->nr) {
>> -			/*
>> -			 * limit free batch count when PAGE_SIZE > 4K
>> -			 */
>> -			unsigned int nr = min(512U, batch->nr);
>> +			nr = min(512, batch->nr);
> 
> If any entries are for more than 1 page, nr_pages will also be encoded in the
> batch, so effectively this could be limiting to 256 actual folios (half of 512).

Right, in the patch description I state "256 folio fragments". It's up 
to 512 folios (order-0).

> Is it worth checking for ENCODED_PAGE_BIT_NR_PAGES_NEXT and limiting accordingly?

At least with 4k page size, we never have more than 510 (IIRC) entries 
per batch page. So any such optimization would only matter for large 
page sizes, which I don't think is worth it.

Which exact optimization do you have in mind and would it really make a 
difference?

> 
> nit: You're using 512 magic number in 2 places now; perhaps make a macro?

I played 3 times with macro names (including just using something 
"intuitive" like MAX_ORDER_NR_PAGES) but returned to just using 512.

That cond_resched() handling is just absolutely disgusting, one way or 
the other.

Do you have a good idea for a macro name?

> 
>>   
>>   			/*
>>   			 * Make sure we cover page + nr_pages, and don't leave
>> @@ -119,6 +120,37 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>   			cond_resched();
>>   		}
>>   	}
>> +
>> +	/*
>> +	 * With page poisoning and init_on_free, the time it takes to free
>> +	 * memory grows proportionally with the actual memory size. Therefore,
>> +	 * limit based on the actual memory size and not the number of involved
>> +	 * folios.
>> +	 */
>> +	while (batch->nr) {
>> +		for (nr = 0, nr_pages = 0;
>> +		     nr < batch->nr && nr_pages < 512; nr++) {
>> +			if (unlikely(encoded_page_flags(pages[nr]) &
>> +				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>> +				nr_pages += encoded_nr_pages(pages[++nr]);
>> +			else
>> +				nr_pages++;
>> +		}
> 
> I guess worst case here is freeing (511 + 8192) * 64K pages = ~544M. That's up
> from the old limit of 512 * 64K = 32M, and 511 pages bigger than your statement
> in the commit log. Are you comfortable with this? I guess the only alternative
> is to start splitting a batch which would be really messy. I agree your approach
> is preferable if 544M is acceptable.

Right, I have in the description:

"if we cannot even free a single MAX_ORDER page on a system without 
running into soft lockups, something else is already completely bogus.".

That would be 8192 pages on arm64. Anybody freeing a PMD-mapped THP 
would be in trouble already and should just reconsider life choices 
running such a machine.

We could have 511 more pages, yes. If 8192 don't trigger a soft-lockup, 
I am confident that 511 more pages won't make a difference.

But, if that ever is a problem, we can butcher this code as much as we 
want, because performance with poisoning/zeroing is already down the drain.

As you say, splitting even further is messy, so I rather avoid that 
unless really required.

-- 
Cheers,

David / dhildenb


