Return-Path: <linux-arch+bounces-14564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B21C40482
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3913A40FC
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3812550CA;
	Fri,  7 Nov 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sN4IZ86W"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7892B9B9
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525092; cv=none; b=jPQljxS97dkr9OuaoSfWBK2CExi7s/9FT9/ZDsboXqgS3lnC1BIfpVHIY8TyM+OaQzOvEK+z9cT/rJjCSOXxj+Vax90YfgxNQc+o8Cam0gCwxxQ7ENrdLLFaM4ww2kn3qAHk/TVjgeuu6alO1OqIkngFg6i6lMQz/UeHILNyinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525092; c=relaxed/simple;
	bh=ypgxC54yhGj8AxBImWTTquYgjlI2a5opaMOYUrn4f9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAWTDikBWj+bCr8iezFdsOXKW+YaYZ/1LcbNCz/fip8HQJUz17pNJUTBQy6ER1XTmSowjkJvo6YHMP+KgCTbOPoYxGBV9e2vbBVNQmZ8FMvGNsl22y+SVOCegp9+4DD2xP9b1pNs9R5t9n2/72FVVS9J4Bpgzl1ve3Ubd7sEq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sN4IZ86W; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46a03f86-ab38-4a6c-b1fb-6f77122eff0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762525077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykW1NxfmAyfPid0Bv9EkP65yYrb8g2y4oaOywpFdm8I=;
	b=sN4IZ86WVAG4Olc7M1q+EZefrDrYOz9yC7iz6UK+cC19RzbPzIJK9onGxB+RMlrYmMwNDG
	4NAW5gu9nibVu2HvO3tsZtbu1IzQf/ELSYqchfavu1h6FnH7B3XS89Nt/3fLjNCmU3Ek6q
	k0+MPu+biM3cAI81N7L2OS+aok5bVIU=
Date: Fri, 7 Nov 2025 22:17:44 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jan Kara <jack@suse.cz>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, david@kernel.org, Lance Yang <ioworker0@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, vishal.moola@gmail.com
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <20251107114455.59111-1-ioworker0@gmail.com>
 <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/7 20:50, Arnd Bergmann wrote:
> On Fri, Nov 7, 2025, at 12:44, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>> On Fri,  7 Nov 2025 17:59:22 +0800, Huacai Chen wrote:
>>>
>>>    */
>>>   static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>>   {
>>> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
>>> -			~__GFP_HIGHMEM, 0);
>>> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
>>
>> I looked into the history and it seems you are right. This defensive pattern
>> was likely introduced by Vishal Moola in commit c787ae5[1].
> 
> Right, so not even so long ago, so we need to make sure we agree
> on a direction and don't send opposite patches in the name of
> cleanups.

Yes, better to get on the same page now than to have conflicting
cleanups down the line ;)

> 
>> After this cleanup, would it make sense to add a BUILD_BUG_ON() somewhere
>> to check that __GFP_HIGHMEM is not present in GFP_PGTABLE_KERNEL and
>> GFP_PGTABLE_USER? This would prevent any future regression ;)
>>
>> Just a thought ...
> 
> I think we can go either way here, but I'd tend towards not
> adding more checks but instead removing any mention of __GFP_HIGHMEM
> that we can show is either pointless or can be avoided, with

Makes sense to me :)

> the goal of having only a small number of actual highmem
> allocations remaining in places we do care about (normal
> page cache, zram, possibly huge pages).

Right! That's the ideal end state. Making the code cleaner and
the intention clearer ;p

Cheers,
Lance

