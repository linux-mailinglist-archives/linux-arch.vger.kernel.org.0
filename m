Return-Path: <linux-arch+bounces-1908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047A843E0A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10F328158A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624F6D1BA;
	Wed, 31 Jan 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLX8t9qM"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3169E07
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699592; cv=none; b=bm+bd1cOxfElMsgzeYvI7Uf0QpePL/gxkve/FtD9EB3d+IAWrk2F8HxaH7t2SL7u22RdDq+rMXHofWDmVSK14GCrFtpL3ri0irm+ihtZmeCxIiwcOUW+z280FEYc7PMfq+w8sYnoVGkfpmfLoFpE3i4T+GaoQqW8wbjjCJ5RcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699592; c=relaxed/simple;
	bh=Mce+eEpIDdFmJH+2I/iAep3MNohyZGT7W5JKBIXadvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a91HzgX/Bnc5f1IO1q4cPmlowNllHjfGyKpcSiOLt+H2cOlwAcU2di51XRHyxjMm74RuglYuCkXC0bceT+UXfZVuFKWZjDIeTpgKoRtfd7xZ6ZgdrQkQpwyglNxpWuPraPhAMLJlTpGoyH9PHPCVq1sBrqhGU5Ldmk3K6/V8qQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLX8t9qM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706699589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d4ma9zbE8mjb8i+FauSpNHy+FN/rZ5fB2oL3RLjV6rs=;
	b=bLX8t9qM4WUR8REWg+0XkfWUSQK09h+hi9UWdax3f5UNM9Qc1Tj8CrjzSs/VkA/AKyJYL2
	IDZOuaEl1tczJltgyUs5jAa+ciqy9UIb/YYCBCwPsN9nBIPPyjrljmhGGpKr6C4SOycd/D
	IrOS1PCi+JUkz41Y0r8mDvT9ynhc9pI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-dL23FudANJWsAqA_XKG_5A-1; Wed, 31 Jan 2024 06:13:08 -0500
X-MC-Unique: dL23FudANJWsAqA_XKG_5A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40ef75bea84so17197245e9.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 03:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699587; x=1707304387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4ma9zbE8mjb8i+FauSpNHy+FN/rZ5fB2oL3RLjV6rs=;
        b=RZhvX42ctaNoyPJnatxSx0D3ReqqTGgSTwsV6KlvFzrG/NPd4Lti9hpsGtKV8pKOSt
         g0myt0PKVQBvtEql6fNDqnF2OBUnnXtAvvyeXWlI82VeTFRq5VYEfaZLZ0r1JZP9rlkb
         tLbINL1bJGeFTjBiKms1LpX9x+79hvm2aVCr//H1Mp0CsXFfxtBXNSPAX76O520Z59Xi
         UdPpXzlNKC6qcgXuxhsnfgX6o+QuVHNcCWC0M1d2/xkHpzglFtHfC+rPMyizOJfTlcTI
         ZEN5ErU4ESLAxzqxuRn9kx90zAmcQP6I9+exMCxlOXaMlx2EFJmmuOJtTGmKwPvw30C8
         p3sg==
X-Gm-Message-State: AOJu0YzV1+584AR7CsH1JTx1f5iZ0hmYufnjd15LSJfaqBAJVvyEEXwQ
	hyWK1HoLIrGcHJirE+QNuMOydi7br6M+pVr3JQWV+gfE8ZPMak6/DHg4umuebiGS2MwiCmRvFPQ
	hRtIqJu3C85bJyHDul15i19sgkj+E27qbvUsNn6TZQdkRpt1QTZSboGZIsbE=
X-Received: by 2002:a05:600c:470d:b0:40e:f656:39f with SMTP id v13-20020a05600c470d00b0040ef656039fmr1018346wmo.6.1706699586981;
        Wed, 31 Jan 2024 03:13:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqBwS6p6bJR9z+v39DGZKJ94gGFj7YXuQe4rd8sPOmEQeUSMAmCXotFvLHcNalUBQDlimQJQ==
X-Received: by 2002:a05:600c:470d:b0:40e:f656:39f with SMTP id v13-20020a05600c470d00b0040ef656039fmr1018321wmo.6.1706699586591;
        Wed, 31 Jan 2024 03:13:06 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id cl3-20020a5d5f03000000b0033afd49cac7sm3390196wrb.43.2024.01.31.03.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 03:13:06 -0800 (PST)
Message-ID: <fbf08467-fbca-4b97-a1aa-046e0f17fdb8@redhat.com>
Date: Wed, 31 Jan 2024 12:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
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
 <bec84017-b1c9-48e7-a206-c4c8a651ee83@arm.com>
 <cf9adefc-8508-49a4-a7f0-784e345c5d80@redhat.com>
 <424115a2-a924-4c28-8027-32db6ab9278d@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <424115a2-a924-4c28-8027-32db6ab9278d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>> -        folio_remove_rmap_pte(folio, page, vma);
>>>> +        folio_remove_rmap_ptes(folio, page, nr, vma);
>>>> +
>>>> +        /* Only sanity-check the first page in a batch. */
>>>>            if (unlikely(page_mapcount(page) < 0))
>>>>                print_bad_pte(vma, addr, ptent, page);
>>>
>>> Is there a case for either removing this all together or moving it into
>>> folio_remove_rmap_ptes()? It seems odd to only check some pages.
>>>
>>
>> I really wanted to avoid another nasty loop here.
>>
>> In my thinking, for 4k folios, or when zapping subpages of large folios, we
>> still perform the exact same checks. Only when batching we don't. So if there is
>> some problem, there are ways to get it triggered. And these problems are barely
>> ever seen.
>>
>> folio_remove_rmap_ptes() feels like the better place -- especially because the
>> delayed-rmap handling is effectively unchecked. But in there, we cannot
>> "print_bad_pte()".
>>
>> [background: if we had a total mapcount -- iow cheap folio_mapcount(), I'd check
>> here that the total mapcount does not underflow, instead of checking per-subpage]
> 
> All good points... perhaps extend the comment to describe how this could be
> solved in future with cheap total_mapcount()? Or in the commit log if you prefer?

I'll add more meat to the cover letter, thanks!

-- 
Cheers,

David / dhildenb


