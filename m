Return-Path: <linux-arch+bounces-1833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F301841EDB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D4E282676
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45735FBA2;
	Tue, 30 Jan 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3Nw3BYr"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD75813B
	for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605741; cv=none; b=t3VF/tatlxtKCGb6gHTFsEKI39quVullYx1sTsjKHHkvAWWU+iyw7A/B5GonCZhSQdKl2S9RpGijIz5g5bt0tW1suvLlvlnZ8tlpOhqqr9VrjblLYPCJM0c58RtW4/LjQUNdLpRwrQF0IEOQ+EquDle2BMV49hzLveXlqhR06bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605741; c=relaxed/simple;
	bh=6KZlDE207AggioPvnEGLSJEy+2xD/mFXmNx88fLyvqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9LaeZSaD++jd0PhOGu8IEi3+xmf9ta44ACJAFzw3qYMQO1ROv8hoOTTFnq18kaBrPSoyLsfh7YHf/PWO70dPhL3TQ0cxgMdzlN545DlpohU3e21j/CIupJFJ01zgsKrznK8VOcQLcW7AguZGi8gWeVrxPqnboMYKiDyCIoXqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3Nw3BYr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706605739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iMFtN9YM7NI14gClvQJVTv8Klat8uVExXnf558gk9Hk=;
	b=e3Nw3BYrPvr/Qqj5bP44qsCsQyI8RufPxLoQpOd6MkynTejInQPazK6VRVuq400SE254TF
	hwUX7bUDKjsQFtnS/kucVhckt/bwg9V01OLpkpnnKuBANd2ctyK4Tl/93jrAgF8kmLZcMa
	9IXh4GNwxCyb/AYfAkx0NucEZUgwUL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-TID5SKY7N22W0fkvrRJWDw-1; Tue, 30 Jan 2024 04:08:57 -0500
X-MC-Unique: TID5SKY7N22W0fkvrRJWDw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e74860cb0so29011245e9.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 01:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605736; x=1707210536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMFtN9YM7NI14gClvQJVTv8Klat8uVExXnf558gk9Hk=;
        b=A9iCsNzOE9RukU/584ar/IMVEHxUI+3XzBom+WhEr80N1ejtsIrx4qbRlF/F3Ep13c
         1bgBQZWpHGs+kt5IvHMEXw2qXxOzObD/JL360xTbhhRrQZWIaXAx+XRrK0g0/ySTBcjK
         yGobUkEmrR51CgpxzXYytDRfBZ3s/ByhDGpiJdmcEPMzuD+Bnyw293XfwTeLYwHj6lrd
         jw4CJbG5QiOyXscyQq4ejmq8hFAbOT/rGMssfEuWa1QWHYoMFxZIAHjQGkCkzd30I/E4
         cRxlZ8N+kYC/mIUJItH3QlguKPt75VkCwoEOdgbqQEPVDW7fwx/8peFdywXtEHfYppTS
         /RzA==
X-Gm-Message-State: AOJu0Yy8q1DJTtU0tsvR+FXXC+NqzqrnvIcH0A0MdcFFhZwJYHL8tQeR
	grNKiuWunARRjUGV0M8PFuts/d105LQiLXR697cy8AqWRkScSnOetV7gX3pPeWZ63esQ7e42I3j
	4bC+WjXfg0gE4MegBymbH9b5qT/Agq7O87l7/MXw0z/ovoRgy4Un0sVzaZO4=
X-Received: by 2002:a05:600c:2941:b0:40e:e912:8f74 with SMTP id n1-20020a05600c294100b0040ee9128f74mr6819508wmd.25.1706605736020;
        Tue, 30 Jan 2024 01:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Uit37MZF9xsn/6TflWQzU2N4yu2GzCcbdJtN3Xh+ex/+Pyt9LHa3hTGrN/MJecJrHUxA/g==
X-Received: by 2002:a05:600c:2941:b0:40e:e912:8f74 with SMTP id n1-20020a05600c294100b0040ee9128f74mr6819489wmd.25.1706605735651;
        Tue, 30 Jan 2024 01:08:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2700:bdf6:739b:9f9d:862f? (p200300cbc7082700bdf6739b9f9d862f.dip0.t-ipconnect.de. [2003:cb:c708:2700:bdf6:739b:9f9d:862f])
        by smtp.gmail.com with ESMTPSA id b7-20020adfee87000000b0033aebf727b2sm5441018wro.60.2024.01.30.01.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:08:55 -0800 (PST)
Message-ID: <af5d1332-bbcc-4110-a167-84f2bb592794@redhat.com>
Date: Tue, 30 Jan 2024 10:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: linux-kernel@vger.kernel.org
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
 linux-s390@vger.kernel.org
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-10-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240129143221.263763-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Re-reading the docs myself:

> +#ifndef get_and_clear_full_ptes
> +/**
> + * get_and_clear_full_ptes - Clear PTEs that map consecutive pages of the same
> + *			     folio, collecting dirty/accessed bits.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_get_and_clear_full(), merging dirty/accessed bits into
> + * returned PTE.

"into the"

> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	pte_t pte, tmp_pte;
> +
> +	pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +	while (--nr) {
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
> +		if (pte_dirty(tmp_pte))
> +			pte = pte_mkdirty(pte);
> +		if (pte_young(tmp_pte))
> +			pte = pte_mkyoung(pte);
> +	}
> +	return pte;
> +}
> +#endif
> +
> +#ifndef clear_full_ptes
> +/**
> + * clear_full_ptes - Clear PTEs that map consecutive pages of the same folio.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.

Something went missing:

May be overridden by the architecture; otherwise, implemented as a 
simple loop over ptep_get_and_clear_full().


-- 
Cheers,

David / dhildenb


