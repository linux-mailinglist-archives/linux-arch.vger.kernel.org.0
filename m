Return-Path: <linux-arch+bounces-2176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A5850F3B
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5209D1C2089D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532DC101C1;
	Mon, 12 Feb 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wei/qESL"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B040FC03
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728618; cv=none; b=S0oA9cqEPY9PjnrYcVc5kC6yWzAR/Unj7yl3Z6pfp7rRiLbYovi6Ivw3VTxonnfZdRoMzvHCXo7fH8zEplcfYkSFnGZCzEXPYyXRqjc73iDyEdhd5b9CTJkPttl3tGs0SS4Tw5b9SOVwFqRnpxGmeANnJRm2cfk7w5CLbT3lVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728618; c=relaxed/simple;
	bh=Xv7j/OtkOcEyWzPc1H7evd1Gc5W0onOh2LVWisjIVIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+sKW82TUt6rJlYg7iBTzvGsMx+DCaiAHrric88p7Rt2HLRVJ0uW+bkJyngphrjtxGfNUPzm5xvEmR2bh8+FGBAye68WtCvJGcYM2xq5nFAu6cy3kitv1xqy6rCtypJ1f9EM5I2I64fPZdf24CFaRYEQW+ciK7B22T3Us+zs85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wei/qESL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707728615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pgRNnASn/gJ+ziqa0jLyGcoEbn59ril+3vlejHlKeXo=;
	b=Wei/qESL2sURQ4Vz5lwUK2OP4mCNsEJpAIlIESJXJaxcgi2ZsVysR/QhiwexuQIca87W9w
	n9QdrT8EcT22gYeFnLHakR/2oiOAevpYV8JauXEUYHo7wUK0KBY+yD0WkpRjfofYpFBdFA
	MrSs2qvzOraLjvchAKY2LLWb0L0QcSY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-g9tj94P9MXOq3T6SLFTjFw-1; Mon, 12 Feb 2024 04:03:33 -0500
X-MC-Unique: g9tj94P9MXOq3T6SLFTjFw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51156c3208cso2667758e87.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 01:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707728612; x=1708333412;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgRNnASn/gJ+ziqa0jLyGcoEbn59ril+3vlejHlKeXo=;
        b=PVHenRDEoS1gIdH/UcEz0TMVkDfLp1cdLgpIgkaXm9kANmh1IoPcFYb0U1XyILkuVX
         thcaDZSKbc2OVouAqa+G/HMYbi/f0qNdZ4uAmmjePj80c7hJjjzRyrk0bOl/FSYehLch
         oohA8hFWG+UYijV+488X6CqQgFn+mviaWTFCrkRKDCfwAQuwJSIZBU2KomJ3FpcxRMmO
         c+APVuEqOfKIC4K6aNIs5/OgpLhUyulU1NXPrJRP2vLicqtLVMPIPYZNReh9z5e0NEDC
         5OyGpMUjqiqHrX+8Z4FUW4zkaMuGNT4/aj+aPakwmCKTvnBxvpTrQzDqPYK0wdpskT5l
         hi3g==
X-Gm-Message-State: AOJu0YxOk2auaHvXzeL2zbaCW0f75baniuRctXQ+jUPcwc4tU1wUmkDC
	Mdy2SsG+L89/ah41raAqnK/h0lNRu6w8EbZwGSAZodIFY7NgnBgiARemc1k5kUugzRTFz2gtYRh
	49DjeqBKJ1/71l8cyWADRZics3NieZogRst4FbmQ9rBEpmhAhOd9W1gLQZEs=
X-Received: by 2002:ac2:5f79:0:b0:511:4a03:6b5d with SMTP id c25-20020ac25f79000000b005114a036b5dmr3399740lfc.24.1707728611780;
        Mon, 12 Feb 2024 01:03:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDXn2S4e0A/MOQ6v+DtyI8UFmhWaAGLptM49I2yuXLDilpamCrP8xgOyQFeJ9vxu0lMQaZaA==
X-Received: by 2002:ac2:5f79:0:b0:511:4a03:6b5d with SMTP id c25-20020ac25f79000000b005114a036b5dmr3399721lfc.24.1707728611260;
        Mon, 12 Feb 2024 01:03:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPwIImCH9IWEVgYTzazBXpSmX98EZ8VCitObBEwOLjKTFkb+B3whWCPQDGs79lgmCzUPNZPtO0oF0fnoIwC5blfAtQ7+oWPu4lvav7DtdA3cEWMfEQh4DVDrIe7XEm7VzOlcWUeR0h//mvFCQONNdpXQlc4SroSbFtoeo/Dr/kJSj5fp2UD0SffUCngqUH9G0iE64KJOnipDHV8211aAGAQcYS6UAZOEwbQybUtoByAeeoZfSPEP3oPjWgfoOeX3aIH7vjGnZKupV3Mcj8TgRYNv+pZIwFoPiXFywoPtSHKONbPk/G39+XXRWHAZNH41w0C0vYHIBJkXfzgBL6RxUy1d0rM26VzjutqdMQr7WJ1oT2Zxner1NZh4z+/oS6XDJCSAiR3YgO+xJybh5Gv5g82/BATzFd8OPqwp2YvnZXcKm8RSRmfI3k02LcSL9V+nOf+DeEcbl30XjNNDzfNqTuablE9+WiMbUKq288bFuvKPciVoOqBSwTVOy/qyZPI1mDuSYHlMySFT9im2kEl7oFhCPxV8BumB/YCmO8+nhmcMhndxYImOBS5mpqZQS5R9cCh3ffTveTdwhXs2JNE+b0dfqafokFWRkDDgpXJn6e0mf1cVRdkZeTITzlQK0oyM8PfnbPBFW6zFNNvy3UixCjl6F84Hr8xrUYW8SbTicr5Arbc42H5fwIzDlIdj6nSsdX2lJQyGO9ltCD0VO/kCilYxv2ygPPlW1u/egV6nDo1/tGPmI=
Received: from ?IPV6:2003:cb:c730:2200:7229:83b1:524e:283a? (p200300cbc7302200722983b1524e283a.dip0.t-ipconnect.de. [2003:cb:c730:2200:7229:83b1:524e:283a])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b005115ea2c301sm799410lfo.49.2024.02.12.01.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 01:03:30 -0800 (PST)
Message-ID: <769807aa-a029-454d-9f79-2f36e278477d@redhat.com>
Date: Mon, 12 Feb 2024 10:03:27 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] mm/mmu_gather: add __tlb_remove_folio_pages()
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
 <20240209221509.585251-9-david@redhat.com>
 <438b22ec-c875-41b6-bfd4-a84966f84853@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <438b22ec-c875-41b6-bfd4-a84966f84853@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.24 09:51, Ryan Roberts wrote:
> On 09/02/2024 22:15, David Hildenbrand wrote:
>> Add __tlb_remove_folio_pages(), which will remove multiple consecutive
>> pages that belong to the same large folio, instead of only a single
>> page. We'll be using this function when optimizing unmapping/zapping of
>> large folios that are mapped by PTEs.
>>
>> We're using the remaining spare bit in an encoded_page to indicate that
>> the next enoced page in an array contains actually shifted "nr_pages".
>> Teach swap/freeing code about putting multiple folio references, and
>> delayed rmap handling to remove page ranges of a folio.
>>
>> This extension allows for still gathering almost as many small folios
>> as we used to (-1, because we have to prepare for a possibly bigger next
>> entry), but still allows for gathering consecutive pages that belong to the
>> same large folio.
>>
>> Note that we don't pass the folio pointer, because it is not required for
>> now. Further, we don't support page_size != PAGE_SIZE, it won't be
>> required for simple PTE batching.
>>
>> We have to provide a separate s390 implementation, but it's fairly
>> straight forward.
>>
>> Another, more invasive and likely more expensive, approach would be to
>> use folio+range or a PFN range instead of page+nr_pages. But, we should
>> do that consistently for the whole mmu_gather. For now, let's keep it
>> simple and add "nr_pages" only.
>>
>> Note that it is now possible to gather significantly more pages: In the
>> past, we were able to gather ~10000 pages, now we can gather
>> also gather ~5000 folio fragments that span multiple pages. A folio
>> fragement on x86-64 can be up to 512 pages (2 MiB THP) and on arm64 with
>> 64k in theory 8192 pages (512 MiB THP). Gathering more memory is not
>> considered something we should worry about, especially because these are
>> already corner cases.
>>
>> While we can gather more total memory, we won't free more folio
>> fragments. As long as page freeing time primarily only depends on the
>> number of involved folios, there is no effective change for !preempt
>> configurations. However, we'll adjust tlb_batch_pages_flush() separately to
>> handle corner cases where page freeing time grows proportionally with the
>> actual memory size.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/include/asm/tlb.h | 17 +++++++++++
>>   include/asm-generic/tlb.h   |  8 +++++
>>   include/linux/mm_types.h    | 20 ++++++++++++
>>   mm/mmu_gather.c             | 61 +++++++++++++++++++++++++++++++------
>>   mm/swap.c                   | 12 ++++++--
>>   mm/swap_state.c             | 15 +++++++--
>>   6 files changed, 119 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>> index 48df896d5b79..e95b2c8081eb 100644
>> --- a/arch/s390/include/asm/tlb.h
>> +++ b/arch/s390/include/asm/tlb.h
>> @@ -26,6 +26,8 @@ void __tlb_remove_table(void *_table);
>>   static inline void tlb_flush(struct mmu_gather *tlb);
>>   static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>   		struct page *page, bool delay_rmap, int page_size);
>> +static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>> +		struct page *page, unsigned int nr_pages, bool delay_rmap);
>>   
>>   #define tlb_flush tlb_flush
>>   #define pte_free_tlb pte_free_tlb
>> @@ -52,6 +54,21 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>>   	return false;
>>   }
>>   
>> +static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>> +		struct page *page, unsigned int nr_pages, bool delay_rmap)
>> +{
>> +	struct encoded_page *encoded_pages[] = {
>> +		encode_page(page, ENCODED_PAGE_BIT_NR_PAGES_NEXT),
>> +		encode_nr_pages(nr_pages),
>> +	};
>> +
>> +	VM_WARN_ON_ONCE(delay_rmap);
>> +	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
>> +
>> +	free_pages_and_swap_cache(encoded_pages, ARRAY_SIZE(encoded_pages));
>> +	return false;
>> +}
>> +
>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>   {
>>   	__tlb_flush_mm_lazy(tlb->mm);
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 95d60a4f468a..bd00dd238b79 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -69,6 +69,7 @@
>>    *
>>    *  - tlb_remove_page() / __tlb_remove_page()
>>    *  - tlb_remove_page_size() / __tlb_remove_page_size()
>> + *  - __tlb_remove_folio_pages()
>>    *
>>    *    __tlb_remove_page_size() is the basic primitive that queues a page for
>>    *    freeing. __tlb_remove_page() assumes PAGE_SIZE. Both will return a
>> @@ -78,6 +79,11 @@
>>    *    tlb_remove_page() and tlb_remove_page_size() imply the call to
>>    *    tlb_flush_mmu() when required and has no return value.
>>    *
>> + *    __tlb_remove_folio_pages() is similar to __tlb_remove_page(), however,
>> + *    instead of removing a single page, remove the given number of consecutive
>> + *    pages that are all part of the same (large) folio: just like calling
>> + *    __tlb_remove_page() on each page individually.
>> + *
>>    *  - tlb_change_page_size()
>>    *
>>    *    call before __tlb_remove_page*() to set the current page-size; implies a
>> @@ -262,6 +268,8 @@ struct mmu_gather_batch {
>>   
>>   extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>>   		bool delay_rmap, int page_size);
>> +bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
>> +		unsigned int nr_pages, bool delay_rmap);
>>   
>>   #ifdef CONFIG_SMP
>>   /*
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 1b89eec0d6df..a7223ba3ea1e 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -226,6 +226,15 @@ struct encoded_page;
>>   /* Perform rmap removal after we have flushed the TLB. */
>>   #define ENCODED_PAGE_BIT_DELAY_RMAP		1ul
>>   
>> +/*
>> + * The next item in an encoded_page array is the "nr_pages" argument, specifying
>> + * the number of consecutive pages starting from this page, that all belong to
>> + * the same folio. For example, "nr_pages" corresponds to the number of folio
>> + * references that must be dropped. If this bit is not set, "nr_pages" is
>> + * implicitly 1.
>> + */
>> +#define ENCODED_PAGE_BIT_NR_PAGES_NEXT		2ul
>> +
>>   static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
>>   {
>>   	BUILD_BUG_ON(flags > ENCODED_PAGE_BITS);
>> @@ -242,6 +251,17 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>>   	return (struct page *)(~ENCODED_PAGE_BITS & (unsigned long)page);
>>   }
>>   
>> +static __always_inline struct encoded_page *encode_nr_pages(unsigned long nr)
>> +{
>> +	VM_WARN_ON_ONCE((nr << 2) >> 2 != nr);
>> +	return (struct encoded_page *)(nr << 2);
>> +}
>> +
>> +static __always_inline unsigned long encoded_nr_pages(struct encoded_page *page)
>> +{
>> +	return ((unsigned long)page) >> 2;
>> +}
>> +
>>   /*
>>    * A swap entry has to fit into a "unsigned long", as the entry is hidden
>>    * in the "index" field of the swapper address space.
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 6540c99c6758..d175c0f1e2c8 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -50,12 +50,21 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>   #ifdef CONFIG_SMP
>>   static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
>>   {
>> +	struct encoded_page **pages = batch->encoded_pages;
>> +
>>   	for (int i = 0; i < batch->nr; i++) {
>> -		struct encoded_page *enc = batch->encoded_pages[i];
>> +		struct encoded_page *enc = pages[i];
>>   
>>   		if (encoded_page_flags(enc) & ENCODED_PAGE_BIT_DELAY_RMAP) {
>>   			struct page *page = encoded_page_ptr(enc);
>> -			folio_remove_rmap_pte(page_folio(page), page, vma);
>> +			unsigned int nr_pages = 1;
>> +
>> +			if (unlikely(encoded_page_flags(enc) &
>> +				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>> +				nr_pages = encoded_nr_pages(pages[++i]);
>> +
>> +			folio_remove_rmap_ptes(page_folio(page), page, nr_pages,
>> +					       vma);
>>   		}
>>   	}
>>   }
>> @@ -89,18 +98,26 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>>   	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>>   		struct encoded_page **pages = batch->encoded_pages;
>>   
>> -		do {
>> +		while (batch->nr) {
>>   			/*
>>   			 * limit free batch count when PAGE_SIZE > 4K
>>   			 */
>>   			unsigned int nr = min(512U, batch->nr);
>>   
>> +			/*
>> +			 * Make sure we cover page + nr_pages, and don't leave
>> +			 * nr_pages behind when capping the number of entries.
>> +			 */
>> +			if (unlikely(encoded_page_flags(pages[nr - 1]) &
>> +				     ENCODED_PAGE_BIT_NR_PAGES_NEXT))
>> +				nr++;
>> +
>>   			free_pages_and_swap_cache(pages, nr);
>>   			pages += nr;
>>   			batch->nr -= nr;
>>   
>>   			cond_resched();
>> -		} while (batch->nr);
>> +		}
>>   	}
>>   	tlb->active = &tlb->local;
>>   }
>> @@ -116,8 +133,9 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>>   	tlb->local.next = NULL;
>>   }
>>   
>> -bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>> -		bool delay_rmap, int page_size)
>> +static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
>> +		struct page *page, unsigned int nr_pages, bool delay_rmap,
>> +		int page_size)
>>   {
>>   	int flags = delay_rmap ? ENCODED_PAGE_BIT_DELAY_RMAP : 0;
>>   	struct mmu_gather_batch *batch;
>> @@ -126,6 +144,8 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>>   
>>   #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
>>   	VM_WARN_ON(tlb->page_size != page_size);
>> +	VM_WARN_ON_ONCE(nr_pages != 1 && page_size != PAGE_SIZE);
>> +	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
> 
> I've forgotten the rules for when it is ok to assume contiguous PFNs' struct
> pages are contiguous in virtual memory? I think its fine as long as the pages
> belong to the same folio and the folio order <= MAX_ORDER? So `page + nr_pages -
> 1` is safe?
> 

Essentially, for anything that comes from the buddy it is safe (which we 
end up punching into RMAP functions where we now have similar checks).

Note that we'll never end up her with "nr_pages !=1" for hugetlb where 
the check would not be true for some gigantic pages.

> Assuming this is the case:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks!

-- 
Cheers,

David / dhildenb


