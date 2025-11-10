Return-Path: <linux-arch+bounces-14599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B2C44F59
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 06:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F93A32A1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 05:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325EC849C;
	Mon, 10 Nov 2025 05:07:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD534D395;
	Mon, 10 Nov 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751273; cv=none; b=AAuoNC+adyesM9l/imJ/GhBhkKwCdIuRvqwfvEeMxsWbXcCdmSFw2v3dr3gMJfWbmS95gA3YCtugMKUamHo+yKBQLeeLmvgDAJ4Ad0y72zeWQTQQdwIbTIIRs7kCjkCNYGQiytTWCMaxAwYJGCaExZEi679l7495aAmuY8vFnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751273; c=relaxed/simple;
	bh=LBPPYrTpnwa1Ud1E+KD+4nxpqf6vugNQtz5ceOosjz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpF8uHgCRYX09uiWp0KZ+BZ2TFepvvFRYZIJy/9kL2sj2B2QMrAZwYJLNF/7jNeOD8zR4z9vCpPX82oi7uEh3Ol+r896TxhDn+UpsU8K62j2Tqc3DkLedVBhWVHbldSie7CPcO0WcZokiaQV/lps+afvx1PNuxZKEiUY2WtzSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1C78497;
	Sun,  9 Nov 2025 21:07:41 -0800 (PST)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808A33F63F;
	Sun,  9 Nov 2025 21:07:46 -0800 (PST)
Message-ID: <b64cd9ba-e80f-4ac5-810c-97af053e4700@arm.com>
Date: Mon, 10 Nov 2025 10:37:43 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm: Remove unnecessary __GFP_HIGHMEM in
 __p*d_alloc_one_*()
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vishal Moola <vishal.moola@gmail.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251109021817.346181-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251109021817.346181-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/25 7:48 AM, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Change the subject line as Vishal suggested.
> 
>  include/asm-generic/pgalloc.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..706e87b43b19 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -18,8 +18,7 @@
>   */
>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  {
> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
> -			~__GFP_HIGHMEM, 0);
> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
>  
>  	if (!ptdesc)
>  		return NULL;
> @@ -172,7 +171,6 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -226,7 +224,6 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, 0);
>  	if (!ptdesc)
> @@ -270,7 +267,6 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	gfp &= ~__GFP_HIGHMEM;
>  
>  	ptdesc = pagetable_alloc_noprof(gfp, order);
>  	if (!ptdesc)

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

