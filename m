Return-Path: <linux-arch+bounces-1822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB56841DA1
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38CC1F2B613
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59EB58112;
	Tue, 30 Jan 2024 08:20:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3558108;
	Tue, 30 Jan 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602809; cv=none; b=S1nuycl5Kh2GZApXw5K4cNNjuQ/Rl61WqtQwOoUyPqUkjXbLxIthpv+yqQvfCWJnegC3iKtr2AM9nMPju/yz+xM2fgUIV1/dGRm8+H8jix2GKgWG+Aw+SPjn90kOe4AQxuIrjQbjVm+0a8fYItk6GKOc6w8M2rG9QguMlnTuDNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602809; c=relaxed/simple;
	bh=IcYTzLqVJ/cBvInWxH/MTWxBYzvHYc5biqjWeOBhKGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4wyd050Wdtyv2NQqxfjCU2oEiqhvJUNp1LSkxJL5/1fzJZHPQ5gjyJUS4jDlYn3L5fv0HfLughcIggHmo25rnZugfGo1ev8/NWrvGd4H1hnJL61astiJIyd8/D/6+8sSUijmbr5gxhkrOVzO4Ux9SjaNtJzDjKICCpO+Ewq97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 923B3DA7;
	Tue, 30 Jan 2024 00:20:50 -0800 (PST)
Received: from [10.57.79.54] (unknown [10.57.79.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4FD33F738;
	Tue, 30 Jan 2024 00:20:03 -0800 (PST)
Message-ID: <7d25f28f-67fe-4bb8-b686-61f4f96471e5@arm.com>
Date: Tue, 30 Jan 2024 08:20:02 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] mm/memory: handle !page case in zap_present_pte()
 separately
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
 <20240129143221.263763-3-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240129143221.263763-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:32, David Hildenbrand wrote:
> We don't need uptodate accessed/dirty bits, so in theory we could
> replace ptep_get_and_clear_full() by an optimized ptep_clear_full()
> function. Let's rely on the provided pte.
> 
> Further, there is no scenario where we would have to insert uffd-wp
> markers when zapping something that is not a normal page (i.e., zeropage).
> Add a sanity check to make sure this remains true.
> 
> should_zap_folio() no longer has to handle NULL pointers. This change
> replaces 2/3 "!page/!folio" checks by a single "!page" one.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/memory.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 50a6c79c78fc..69502cdc0a7d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1497,10 +1497,6 @@ static inline bool should_zap_folio(struct zap_details *details,
>  	if (should_zap_cows(details))
>  		return true;
>  
> -	/* E.g. the caller passes NULL for the case of a zero folio */
> -	if (!folio)
> -		return true;
> -
>  	/* Otherwise we should only zap non-anon folios */
>  	return !folio_test_anon(folio);
>  }
> @@ -1543,19 +1539,23 @@ static inline void zap_present_pte(struct mmu_gather *tlb,
>  	struct page *page;
>  
>  	page = vm_normal_page(vma, addr, ptent);
> -	if (page)
> -		folio = page_folio(page);
> +	if (!page) {
> +		/* We don't need up-to-date accessed/dirty bits. */
> +		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		arch_check_zapped_pte(vma, ptent);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
> +		ksm_might_unmap_zero_page(mm, ptent);
> +		return;
> +	}
>  
> +	folio = page_folio(page);
>  	if (unlikely(!should_zap_folio(details, folio)))
>  		return;
>  	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>  	arch_check_zapped_pte(vma, ptent);
>  	tlb_remove_tlb_entry(tlb, pte, addr);
>  	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> -	if (unlikely(!page)) {
> -		ksm_might_unmap_zero_page(mm, ptent);
> -		return;
> -	}
>  
>  	if (!folio_test_anon(folio)) {
>  		if (pte_dirty(ptent)) {


