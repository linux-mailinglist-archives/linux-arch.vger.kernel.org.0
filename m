Return-Path: <linux-arch+bounces-13184-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8873B29B39
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAC63AF521
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9FE27B4FB;
	Mon, 18 Aug 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs6aYqS2"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C803286434
	for <linux-arch@vger.kernel.org>; Mon, 18 Aug 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503343; cv=none; b=FsEqszPRqxZkSd5/Aw5bsg+aIC8RWOoNDBWhu0a94vKWu1Br1t1IvMc08VchLhr1Cuz6gQ9V8qnIKaI/x22EVHH5RDaLoszQwq/lNAVk9Ntaxn/fjh32L7CIgHiueGAf17KmZhT/oDaufSsBykDL8gJNdsWHUblC8Sxg5Ulc9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503343; c=relaxed/simple;
	bh=Z6rH2ecCR4iG8zmsPvbQHzW1R/t/pz4Wpq05s98+st8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH/YdY+2DMmrwKu3lkTiRYeor5Avv0z8DDU3SWNGNhXu/r4h+MSshgQIfVIkU/s4MXXVwIlNeaH+Icpd/nDb6Zy7scfNJJXl/cW3SmTIyLSyESF99kr/dH3JtQoMkkzLBcSd+2TP5Uz1Xs8gi6udUj3aNPa4zk0f8S38O/d6+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xs6aYqS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GjrpMMZYmeGBQjqK7bhL6RIFmCyMzvAgb+yhK+WhAXE=;
	b=Xs6aYqS2Ue5RADRUjQdMUNWYThMI7yKDrXN+5H/VVkUQ/wsBrABZvPG7TMCgD2/VA/b9em
	IvWePJpV6wO4nrmrntWNLCEpgyP1R9/vB0Xzq37ou5i/79lGwgW+eFAzmwGxInmaZoEEvl
	gdLa4c/yENPjhUX0xz28GyapG0hOIVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-NlCmubCoOaGi-6QZFRSdFQ-1; Mon, 18 Aug 2025 03:48:58 -0400
X-MC-Unique: NlCmubCoOaGi-6QZFRSdFQ-1
X-Mimecast-MFC-AGG-ID: NlCmubCoOaGi-6QZFRSdFQ_1755503338
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so1766968f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 18 Aug 2025 00:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503337; x=1756108137;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjrpMMZYmeGBQjqK7bhL6RIFmCyMzvAgb+yhK+WhAXE=;
        b=Sk3NLTQx4nkdfuzbBuSHaZ0QgPfHSQ9YllttnkVLfOZR2xvYP/tmN1W1xtMngdXXwc
         ZycfV59pzxdU2hj16uJ6DbDaDgQPHOFOmEoG5D9ShqJ9s5ra/zVRm/dw6QQ3V0VE77ph
         LrtsVgU1j+fSGIUMV91xHea8WpsVuAjmjfBGtROCzmO6UxzwuL2A9fHI5JvnBxhVnPJl
         dHR1NuSoRu74z2tM8vXyOK4A37iT32hs7UcDoi0/9so/PGttzlCohKSPiDB+iV2cKZRg
         O6el14jl1rR8GEusR81ERULuJ1FJhr/mR73H+bFQ8bV6ZKmf79OWWOk/OgrITvG+LdDL
         qiMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnd6sEUoATTqEQMG5qpqsdf2WGDqDKuIuTP/Wl+L4c+YmckKFY0+ohkt6YozsxtRWjRNIWbEJQ7xOP@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsoUWkm2IXOt2K/ZQzgjtba66ZCIJVzVE3AoGxgLQuH0xSzVc
	amKwEUlS2knc/HTzsFtLekaSisBeEJuXRnjYGnYAvIS2T907T5ztOx3xKZiaVo3xZ2Y77fVKwbl
	yoxY57bMoM70qRVkSmLMUXIVWDSgHKn9I3w/X98zUtkBnel4stoAyi4EM2ELJ1XY=
X-Gm-Gg: ASbGncvXEC2UErZnezEmtmWD1XnMEIPkwp1WEB6waeLE7QKT3gRLhEYTSxAHXBdxHDf
	kVXEv1n4It4gKg3ksKcc0GRHSnhDXG/f0wb45mK/xtCt4FbkAmwnb59McKT/NW/H2jHEqz/gczJ
	BFrKdrbYlAVFky9PBNPhL2Fdpu8OWhn5lqsWbBnJEqdHoLyALhi0Q2lY5AN0YKyg0AZ5Y8+WCwD
	Xr/T7sRDoe+CojEWkvHFadbIC3bxQJe2PVzctXL3KrwBlM1LGj9rEN6CrJRHUAS7OeyaydaIPMn
	uY5/C2+hRwClTAPSLyxJiYC0qH+ePrEKJVzH++bc3RdNG8ka0howd4SvNSo8fnQTI3oTRp9yeMR
	Z277oaZOVFLJUEK1sANCak/1OoR/B5TuK3NznrvLkSmfJX9/Bcij8H1zuHgexQXbC
X-Received: by 2002:a5d:64eb:0:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3bc6aa272a3mr5576779f8f.42.1755503337604;
        Mon, 18 Aug 2025 00:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ke0nc9qTEDo66odZ0EQpymOQ3CKNEvHMaJr1zCWdVAjts6OlZqdg3tu05ysjljyYRHtYlQ==
X-Received: by 2002:a5d:64eb:0:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3bc6aa272a3mr5576724f8f.42.1755503337011;
        Mon, 18 Aug 2025 00:48:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2231f7e8sm127205855e9.14.2025.08.18.00.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:48:56 -0700 (PDT)
Message-ID: <0e613cf3-7ff1-49d9-9fff-fcf824f2df72@redhat.com>
Date: Mon, 18 Aug 2025 09:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
To: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Juergen Gross
 <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Oscar Salvador <osalvador@suse.de>, Joao Martins
 <joao.m.martins@oracle.com>, Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20250818020206.4517-1-harry.yoo@oracle.com>
 <20250818020206.4517-3-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818020206.4517-3-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 04:02, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.
> These helpers ensure proper synchronization of page tables when
> updating the kernel portion of top-level page tables.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.
> For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> direct mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile for following reasons:
> 
>    1) It is easy to forget to perform the necessary page table
>       synchronization when introducing new changes.
>       For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>       savings for compound devmaps") overlooked the need to synchronize
>       page tables for the vmemmap area.
> 
>    2) It is also easy to overlook that the vmemmap and direct mapping areas
>       must not be accessed before explicit page table synchronization.
>       For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>       sub-pmd ranges")) caused crashes by accessing the vmemmap area
>       before calling sync_global_pgds().
> 
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables. These are introduced in a new
> header file, include/linux/pgalloc.h, so they can be called from common code.
> 
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by arch_sync_kernel_mappings().
> 
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced. Currently, these helpers are no-ops since no
> architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> 
> In theory, PUD and PMD level helpers can be added later if needed by
> other architectures. For now, 32-bit architectures (x86-32 and arm) only
> handle PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect
> them unless we introduce a PMD level helper.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


