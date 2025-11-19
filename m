Return-Path: <linux-arch+bounces-14910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF65CC6E6B1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 13:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36ED04EF31B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355E3538B7;
	Wed, 19 Nov 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zqy5lX1a"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79728351FDE
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554677; cv=none; b=amVS9vViWFOzDX3nw3L0DQ3cuIkFARy8E8jUh5rchFnA+2V+sC2lRO+pyRNpR8XlxQLWEVigvzamUSIexqLfxamBX2sp3JTuF+qzD24gmF9UkWBVfN6SrLYUJwp3+kH4sM9rzpi8P4M+J8VuqHi8C+CTDtQ8hhS5KL9TRaCU+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554677; c=relaxed/simple;
	bh=6oCdNp+wBFa66PevrgncvA774Vl9rIPYMlPSaxwP0As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwEByo2C5woPZsHiDbBvBNvj2b0na+RKhD1XTo4Os+jBm844RL/qR0bg9tBoguxsy+hg6y7/+pTMrVmRuO5TU6HbBI+SifFpJnjuNnz0ZJucb5QS75ZurhrdsRx9V2FApTZMxYJwbXLUaLEXU85yOazQijUsO2T2p3EEj6lsQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zqy5lX1a; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <939e3496-5012-4e7d-8a33-e9de4354d4fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763554662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eiK6+KP3sQeus9efFgfEbOH2adoGq+RjOojwb3xNjU=;
	b=Zqy5lX1a8NH32Urc6QLDGvEAqomF2lRwsHiYL0l9i1s/rF3dYjFpcG8gjDNr8eJS2XwRye
	ZVGhpKOTCj8lKt/dfRzfgKw3J1mAcg3B69SNBb0spvOTCzuF7kU0BWqQyFrC8oudnT+l5K
	mEXeAABjnQT0helIioSYA0k5eRwmsng=
Date: Wed, 19 Nov 2025 20:17:31 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/7] mm: change mm/pt_reclaim.c to use asm/tlb.h
 instead of asm-generic/tlb.h
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com,
 linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <e9d510106b5bf72a9b577b8c5ad161fd3c29c2b6.1763537007.git.zhengqi.arch@bytedance.com>
 <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <e539179f-668e-452d-a08e-6143392dae6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 7:41 PM, David Hildenbrand (Red Hat) wrote:
> On 19.11.25 08:31, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Generally, the asm/tlb.h will include asm-generic/tlb.h, so change
>> mm/pt_reclaim.c to use asm/tlb.h instead of asm-generic/tlb.h. This can
>> also fix compilation errors on some architecture when CONFIG_PT_RECLAIM
>> is enabled (such as alpha).
> 
> "This is a preparation for enabling CONFIG_PT_RECLAIM on other 
> architectures, such as alpha."

OK, will modify it in the next version.

> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/pt_reclaim.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>> index 0d9cfbf4fe5d8..46771cfff8239 100644
>> --- a/mm/pt_reclaim.c
>> +++ b/mm/pt_reclaim.c
>> @@ -2,7 +2,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/pgalloc.h>
>> -#include <asm-generic/tlb.h>
>> +#include <asm/tlb.h>
>>   #include "internal.h"
> 
> Right, we're using pte_free_tlb(), and the default lives in include/asm- 
> generic/tlb.h.
> 
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks!

> 


