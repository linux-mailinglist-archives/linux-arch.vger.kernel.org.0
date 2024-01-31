Return-Path: <linux-arch+bounces-1904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23933843CB8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F711C280E4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F451C3D;
	Wed, 31 Jan 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnLVxjbi"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F741C60
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697064; cv=none; b=iZ6zpdxktVhdHC9+fSdpyMrtqE0Es9yfJEMMfacFRH5j1VBTo8AMYfWVvAaxG0rPyhPDm4s4cmhCLnhuznJYehWmWVLuw4Jf5xgtH/GWfVjHFnd7qogg5YCK9ipM1Zr07MW41QpcIYQujn6lU7rmXR9efyHfGLJxBCQHAgLBbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697064; c=relaxed/simple;
	bh=LiM8vZuNWtKz4nJmYukS0kDChvfMpyTSEEwt2xW8YjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mA+wga4uOAhfewZHF2EHQMAisok6v+1XJ6VwKCyoVFFjcX9ePvvcwsE58zgmCXzYu25SRFaX5RpRqPMCShXrlw2Dhd0WWjmTF4OAC0kjnVwBnkHsYupZjwCbTBecCfmZPjETMzlWh9Xx1ATjFHpDfC+u5kKNExikiJlMZT5liek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnLVxjbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706697061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UInstdZhQE+a453eK6S1P4wqWFcC/n6gY2SHSSGA34Q=;
	b=OnLVxjbiOHPSlYlrZxdEg9fApHvOyKbhMuII44Ocf4cDsudm9UjVpYjNy7EyhlqsivKIIx
	YY81AWw0cV/Y47VdbeHuKGDyLmFHcgfZiABRufbH7BU2JNe9xMUD6qj//fLjGHTo8hYYAW
	AMduA3A8XJLV4FR3+l4I9Xwu8j8EfiI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-7OsvzLwSN-idegeihbyPFg-1; Wed, 31 Jan 2024 05:30:59 -0500
X-MC-Unique: 7OsvzLwSN-idegeihbyPFg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33afcc8a48dso637046f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706697058; x=1707301858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UInstdZhQE+a453eK6S1P4wqWFcC/n6gY2SHSSGA34Q=;
        b=G22PPbkqq/uiC4Ql7KCkHc0Dx+ALYe8p54JkHld6fcsiRNO6/xtajp+yqBvocH4Kk4
         sOkL5bomrHv9Zhy0kzBzwULKop75Yv2PnvT+NjL+x8xVxwRddDxDO6UJtQ4aaOnYzUIj
         2Lj8yyHwtstCuDChO9MYTbtWJvHzVdgLeGIdjKex8FIvy+Bf5SxlkLWGB9MteJY3uvG9
         +FF2eT8hsqbOL82qwza+WQUUwY+nB3CWrWrS4HR65YMhajhiUylhMWsLB8eISITtagTH
         IwJUfW9t0QnUcofY/bgaogJ/5C/Rv2uPEv0E6gDXnts9k3RAQ3A7a8JwXrasEt3AeTrK
         O3xA==
X-Gm-Message-State: AOJu0YyDg/HL8PtuE3dqYg6nmzf0HxasmIRL1nCr6PJurKaeyMBG7/Zy
	yWTscavYz0r/jYwXFrZTDb0mtEg9wxa1tQ2a5VqBQeiyrJZunP+jqfJXAu2HBWtdT1exAdwp6Tu
	As9168rScguTQ6/WUYhSx6bv/jBEBsOOFITaOWUy17W+Zo2VbJWD9pCYO4cM=
X-Received: by 2002:adf:e9c6:0:b0:33a:f661:3d1a with SMTP id l6-20020adfe9c6000000b0033af6613d1amr953877wrn.10.1706697058498;
        Wed, 31 Jan 2024 02:30:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5Sb0Jb4w17/coUITDgCJia4b1YbKMps2LHMgZku1PFk/xbZYgm0NcMrCsZJBCSNcc93/LFw==
X-Received: by 2002:adf:e9c6:0:b0:33a:f661:3d1a with SMTP id l6-20020adfe9c6000000b0033af6613d1amr953850wrn.10.1706697058047;
        Wed, 31 Jan 2024 02:30:58 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe307000000b003392206c808sm12965676wrj.105.2024.01.31.02.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:30:57 -0800 (PST)
Message-ID: <d83309fa-4daa-430f-ae52-4e72162bca9a@redhat.com>
Date: Wed, 31 Jan 2024 11:30:56 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Content-Language: en-US
To: Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
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
 <2375481c-9d61-4f06-9f96-232f25b0e49b@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2375481c-9d61-4f06-9f96-232f25b0e49b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 03:30, Yin Fengwei wrote:
> 
> 
> On 1/29/24 22:32, David Hildenbrand wrote:
>> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
>> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>> +{
>> +	pte_t pte, tmp_pte;
>> +
>> +	pte = ptep_get_and_clear_full(mm, addr, ptep, full);
>> +	while (--nr) {
>> +		ptep++;
>> +		addr += PAGE_SIZE;
>> +		tmp_pte = ptep_get_and_clear_full(mm, addr, ptep, full);
>> +		if (pte_dirty(tmp_pte))
>> +			pte = pte_mkdirty(pte);
>> +		if (pte_young(tmp_pte))
>> +			pte = pte_mkyoung(pte);
> I am wondering whether it's worthy to move the pte_mkdirty() and pte_mkyoung()
> out of the loop and just do it one time if needed. The worst case is that they
> are called nr - 1 time. Or it's just too micro?

I also thought about just indicating "any_accessed" or "any_dirty" using 
flags to the caller, to avoid the PTE modifications completely. Felt a 
bit micro-optimized.

Regarding your proposal: I thought about that as well, but my assumption 
was that dirty+young are "cheap" to be set.

On x86, pte_mkyoung() is setting _PAGE_ACCESSED.
pte_mkdirty() is setting _PAGE_DIRTY | _PAGE_SOFT_DIRTY, but it also has 
to handle the saveddirty handling, using some bit trickery.

So at least for pte_mkyoung() there would be no real benefit as far as I 
can see (might be even worse). For pte_mkdirty() there might be a small 
benefit.

Is it going to be measurable? Likely not.

Am I missing something?

Thanks!

-- 
Cheers,

David / dhildenb


