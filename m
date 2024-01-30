Return-Path: <linux-arch+bounces-1836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A4841F92
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB431C25A77
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DAB59B4E;
	Tue, 30 Jan 2024 09:33:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52D5F86C;
	Tue, 30 Jan 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607207; cv=none; b=XAawHhJgyhovZWCkXnT75CGwuW7WXxIP0KrtnoJUTL3zJiWbJ7B43kvgtg3ldXzryVDqfplYJq60pxd9aZ+40it/dfL2A6QwLyyFqrsXK33WgRa5kNUvB+q8Mq/e2O5FO+6tflK3BWmiyRU8tKl4x5xCsKAE2s1EawMa5dH3Jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607207; c=relaxed/simple;
	bh=xKCvEoGMhWXnYG6BW3bU+yoCKjqIJgHeBIdgHiXzPjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1vi1Hn6rwlZ0Uiq5cyjdqqqvOBR2lhmau7j/7348FgFb+HGzIBZ7LMSKJ4Qh6asclNjkJTGxwHXA78AMqiD7kV+ma1Qf7ceRj0gwl/lC4IZYoaT3WGRumoR5Aq5UskNva4trb8NABEpkE3OTLb1Ld+zbkryUpBJfSY65cAC07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54663DA7;
	Tue, 30 Jan 2024 01:34:08 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8A173F738;
	Tue, 30 Jan 2024 01:33:21 -0800 (PST)
Message-ID: <b2a8b612-1e7a-4cd2-97c3-cf9a304e9a3d@arm.com>
Date: Tue, 30 Jan 2024 09:33:19 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] mm/mmu_gather: add tlb_remove_tlb_entries()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
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
 <20240129143221.263763-9-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> Let's add a helper that lets us batch-process multiple consecutive PTEs.
> 
> Note that the loop will get optimized out on all architectures except on
> powerpc. We have to add an early define of __tlb_remove_tlb_entry() on
> ppc to make the compiler happy (and avoid making tlb_remove_tlb_entries() a
> macro).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/powerpc/include/asm/tlb.h |  2 ++
>  include/asm-generic/tlb.h      | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index b3de6102a907..1ca7d4c4b90d 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -19,6 +19,8 @@
>  
>  #include <linux/pagemap.h>
>  
> +static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
> +					  unsigned long address);
>  #define __tlb_remove_tlb_entry	__tlb_remove_tlb_entry
>  
>  #define tlb_flush tlb_flush
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 428c3f93addc..bd00dd238b79 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -616,6 +616,26 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>  	} while (0)
>  
> +/**
> + * tlb_remove_tlb_entries - remember unmapping of multiple consecutive ptes for
> + *			    later tlb invalidation.
> + *
> + * Similar to tlb_remove_tlb_entry(), but remember unmapping of multiple
> + * consecutive ptes instead of only a single one.
> + */
> +static inline void tlb_remove_tlb_entries(struct mmu_gather *tlb,
> +		pte_t *ptep, unsigned int nr, unsigned long address)
> +{
> +	tlb_flush_pte_range(tlb, address, PAGE_SIZE * nr);
> +	for (;;) {
> +		__tlb_remove_tlb_entry(tlb, ptep, address);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		address += PAGE_SIZE;
> +	}
> +}
> +
>  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
>  	do {							\
>  		unsigned long _sz = huge_page_size(h);		\


