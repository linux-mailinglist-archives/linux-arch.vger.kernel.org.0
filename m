Return-Path: <linux-arch+bounces-13258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BFB33E5C
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625223AF016
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC82765D6;
	Mon, 25 Aug 2025 11:50:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF1E26158C;
	Mon, 25 Aug 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122637; cv=none; b=R1K6PmG5bK7w4cYGb00dIVz8F/yd3trhP3PJ1qM7nlXDL/xzN1p7ndzvOP5K/IP6v/HVKZqrSZBxVadfB0z1GzTM6N3+JXcL+oSbm6a9XaJfltHSZRg/d/A+g9pCKXu5te7FVNMUWV0iCK4qwknWZBboozG8kxt7YXMWMro6KdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122637; c=relaxed/simple;
	bh=ir4VuH5dv+X4I7iVulANhSMrjNaJU7FzFGyoNgZvuPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvnwLK26Xpttk10KUqHscran52/aruym+Htc2A9sj2vWvt9KtFiaQpWnTPbmVJHxKLYxJMeFt9ZnAstByWzUcldTiVAPnRGXxfij9A/w9x5/K1TABO1Uxwaau1IlGyIcVnt0YN7Ae2uBBJIa3qd9jLspETplnPGiLguZp/JCdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9T6K4ff8z9sSZ;
	Mon, 25 Aug 2025 13:27:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9OzpNMcgXWv; Mon, 25 Aug 2025 13:27:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9T6K3JwMz9sSY;
	Mon, 25 Aug 2025 13:27:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5974F8B764;
	Mon, 25 Aug 2025 13:27:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 45RSxQ1kXYeU; Mon, 25 Aug 2025 13:27:21 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E37DF8B763;
	Mon, 25 Aug 2025 13:27:20 +0200 (CEST)
Message-ID: <26796993-5a17-487e-a32e-d9f7577216c3@csgroup.eu>
Date: Mon, 25 Aug 2025 13:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
To: Harry Yoo <harry.yoo@oracle.com>, Dennis Zhou <dennis@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Christoph Lameter
 <cl@gentwo.org>, David Hildenbrand <david@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, "H. Peter Anvin"
 <hpa@zytor.com>, kasan-dev@googlegroups.com, Mike Rapoport
 <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 Alexander Potapenko <glider@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-mm@kvack.org, "Kirill A. Shutemov" <kas@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
 stable@vger.kernel.org
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250811053420.10721-3-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/08/2025 à 07:34, Harry Yoo a écrit :
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
> helpers are introduced. In theory, PUD and PMD level helpers can be added
> later if needed by other architectures.

AFAIK pmd_populate_kernel() already exist on all architectures, and I'm 
not sure it does what you expect. Or am I missing something ?

Christophe


