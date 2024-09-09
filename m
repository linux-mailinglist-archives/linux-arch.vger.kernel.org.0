Return-Path: <linux-arch+bounces-7147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AAB970E76
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0E71F22931
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8491AE048;
	Mon,  9 Sep 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9GJpeOw"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15981AD41E
	for <linux-arch@vger.kernel.org>; Mon,  9 Sep 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864562; cv=none; b=hG2J0eEq3TLEF6mrKVUtbRpphNpseET/o9DNsOyKtg4/d9yjKnBaMiAG6C0StMFatJcPUwfRMhiz2Om4EZI3EjnhNXgLusAOgFfCQNgOLBgVtLJFyYppDFlY37C5ao2Mn5JhzIacJowLDRdBPFUN1Cl5V7s8D4851DZLDWl5OCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864562; c=relaxed/simple;
	bh=SjHLYWDfXnr3p3p6wa8I8tEYpTX6vPv0T+2hBmHXtgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcnS/rcqaybH4bRJm+FeBwjhXTJbZTFtaNN8MvPTperlJuyQObMbrpIju8jBrAFO30jmYn2/i32hPdaLZ45JtdZ/hpOuR7lVj0IDKtFWG9Rl6diUH2V3TBx8ndq14I2N6LWuXkUvbee+zxvLN14AQWv1gP3YOu6ux+ULueoiQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9GJpeOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725864558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q0vZaaN8XN8yMPgUxaQulebtfVBBWF4xeIGzXw2tfzg=;
	b=i9GJpeOwZmaND8o0ohya0QL5hEVN6zmTXyQoC1/5WTWHM4wMpdJhCR0/AXPPtpBeIGl2Sq
	aLqiM2GH06a8DJjSnvOM91FwlJzOBtlWURSTrRZdgApL3TwAmm7oNkOc/Qtky9AIYNDUhz
	dOyc4BbwsSHzqCohqBIX80RDf2oCU0g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-3Zvu_exQNGKbGEOIkeq26A-1; Mon, 09 Sep 2024 02:49:16 -0400
X-MC-Unique: 3Zvu_exQNGKbGEOIkeq26A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c301db60so1705288f8f.2
        for <linux-arch@vger.kernel.org>; Sun, 08 Sep 2024 23:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864555; x=1726469355;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q0vZaaN8XN8yMPgUxaQulebtfVBBWF4xeIGzXw2tfzg=;
        b=P2eKpusppU4E586+sA/XLpKeF3PKRxnP0oFi5Hs2hMR7qlj7+mevcAvg39VI/WVdbi
         XcBhsT8dJxR1Urn3u7z7PuLcz0Fps6vQSEYHBxt2J7v9v05L/i+BF8uvmA5ooUDu8vnO
         2KF7S3XtO3yGJemblJtK+zQHafrXrIqReylF1QpJDwwSYRQhHPKZJ/rUWRAvSNOz4LPG
         R/2MZQgdsMB1zEntt37fLucOPteebfgP1+sGLt6/EaHgWCYqvwPPF+m3P8GbafCdaoBa
         9lxjbVzwREzCoIU6bLTzEV2eF7zn+rv3S6B9wtgGUjRXfxM6pBMqUbA008/u8gDAH7ya
         C2uw==
X-Forwarded-Encrypted: i=1; AJvYcCUYiOc+fDqSYKmfJ+I7uFgRcLRNGDoYEdZA3UzzAuTG11+tweje9584J5N1qaU8WZCC5zkFfsuxwy0I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqk8pfR6MqDbEnWpphbk9+Mpzew+NdszgZffh/xLHc0dW0Hn7E
	Q95lZOmsE48keEpXg18YWcUpYWjiHtpR+6nS/OIngVgEGGQhLbnbHnwkkzaAg7W9YdBc8VkN2BB
	aW1SsDt/SnrelRuJdZVNObh89/xz42jajXgPHyoFhrH4NLrwOAKy93xwCLwQ=
X-Received: by 2002:a05:6000:cd0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-3789268571emr4019483f8f.7.1725864555548;
        Sun, 08 Sep 2024 23:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHRo7i2wTwbkFO2KsGt9mdkl4lcfRtUMDM4VF6HWrmm2c9uz5xyhjWMGOCaprjgrOG9IgeSg==
X-Received: by 2002:a05:6000:cd0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-3789268571emr4019434f8f.7.1725864554312;
        Sun, 08 Sep 2024 23:49:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee? (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de. [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de152sm5120092f8f.103.2024.09.08.23.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 23:49:13 -0700 (PDT)
Message-ID: <f58950cd-dbe3-4629-ac92-30c76db7849a@redhat.com>
Date: Mon, 9 Sep 2024 08:49:12 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: Zhiguo Jiang <justinjiang@vivo.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
Cc: opensource.kernel@vivo.com
References: <20240805153639.1057-1-justinjiang@vivo.com>
 <20240805153639.1057-3-justinjiang@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805153639.1057-3-justinjiang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 17:36, Zhiguo Jiang wrote:
> One of the main reasons for the prolonged exit of the process with
> independent mm is the time-consuming release of its swap entries.
> The proportion of swap memory occupied by the process increases over
> time due to high memory pressure triggering to reclaim anonymous folio
> into swapspace, e.g., in Android devices, we found this proportion can
> reach 60% or more after a period of time. Additionally, the relatively
> lengthy path for releasing swap entries further contributes to the
> longer time required to release swap entries.
> 
> Testing Platform: 8GB RAM
> Testing procedure:
> After booting up, start 15 processes first, and then observe the
> physical memory size occupied by the last launched process at different
> time points.
> Example: The process launched last: com.qiyi.video
> |  memory type  |  0min  |  1min  |   5min  |   10min  |   15min  |
> -------------------------------------------------------------------
> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
> Note: min - minute.
> 
> When there are multiple processes with independent mm and the high
> memory pressure in system, if the large memory required process is
> launched at this time, system will is likely to trigger the instantaneous
> killing of many processes with independent mm. Due to multiple exiting
> processes occupying multiple CPU core resources for concurrent execution,
> leading to some issues such as the current non-exiting and important
> processes lagging.
> 
> To solve this problem, we have introduced the multiple exiting process
> asynchronous swap entries release mechanism, which isolates and caches
> swap entries occupied by multiple exiting processes, and hands them over
> to an asynchronous kworker to complete the release. This allows the
> exiting processes to complete quickly and release CPU resources. We have
> validated this modification on the Android products and achieved the
> expected benefits.
> 
> Testing Platform: 8GB RAM
> Testing procedure:
> After restarting the machine, start 15 app processes first, and then
> start the camera app processes, we monitor the cold start and preview
> time datas of the camera app processes.
> 
> Test datas of camera processes cold start time (unit: millisecond):
> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
> 
> Test datas of camera processes preview time (unit: millisecond):
> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
> 
> Base on the average of the six sets of test datas above, we can see that
> the benefit datas of the modified patch:
> 1. The cold start time of camera app processes has reduced by about 20%.
> 2. The preview time of camera app processes has reduced by about 42%.
> 
> It offers several benefits:
> 1. Alleviate the high system cpu loading caused by multiple exiting
>     processes running simultaneously.
> 2. Reduce lock competition in swap entry free path by an asynchronous
>     kworker instead of multiple exiting processes parallel execution.
> 3. Release pte_present memory occupied by exiting processes more
>     efficiently.
> 
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>   arch/s390/include/asm/tlb.h |   8 +
>   include/asm-generic/tlb.h   |  44 ++++++
>   include/linux/mm_types.h    |  58 +++++++
>   mm/memory.c                 |   3 +-
>   mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 408 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index e95b2c8081eb..3f681f63390f
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>   		struct page *page, bool delay_rmap, int page_size);
>   static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>   		struct page *page, unsigned int nr_pages, bool delay_rmap);
> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> +		swp_entry_t entry, int nr);


The problem I am having is that swap entries don't have any intersection 
with the TLB. It sounds like we're squeezing something into an existing 
concept (MMU gather) that just doesn't belong in there.

-- 
Cheers,

David / dhildenb


