Return-Path: <linux-arch+bounces-15788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11079D1B6DA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 22:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A27513035CD2
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9D31DDA4;
	Tue, 13 Jan 2026 21:36:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747762C0269;
	Tue, 13 Jan 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340182; cv=none; b=hJOpBie/eTUWh5Q/ivNAgf6BZkye4pHzc+tc5YDpNbSfSJ5hLFZJb8kLmC4qtxPhLtIBTq/ZqCgTCKEQEL1wqkJ24tx66yqOrJVXvQySVU/3XdoeMFemc3bpQQJMrfbvKnoC3bkjlDm3mx7ft8tuyOLebu9XLQ718YPZkS38DYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340182; c=relaxed/simple;
	bh=9AT6ixj8wRM4v9kWU/Ei/l4TWcUEovDiGuGjsC03d8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OJGbfqttrG+nEClUFiv4UJXJc+gFrU4Wl+6WWHMDWASHMFFRNqMOdTTSg/QHyZubE9jtAiHSKk2J56G+3m0DSqgPzguEs/SObAFNaSlYbc9j3tPeiYi0FLYBbgKOmv0kVdNYvX7/KaKL2OV9uIpVmi2sVF5bLnplXhG7WMMX3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drMxZ62dPzJ468g;
	Wed, 14 Jan 2026 05:36:02 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 715CE40539;
	Wed, 14 Jan 2026 05:36:16 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Jan 2026 00:36:15 +0300
Message-ID: <d0c0ae41-e0c6-4c90-9dbe-3b10a20a992e@huawei.com>
Date: Wed, 14 Jan 2026 00:36:15 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/5] kernel: futex: use HQ-spinlock for
 hash-buckets
To: <peterz@infradead.org>, <boqun.feng@gmail.com>, <longman@redhat.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <arnd@arndb.de>, <dvhart@infradead.org>,
	<dave@stgolabs.net>, <andrealmeid@igalia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
	<weiyongjun1@huawei.com>, <yusongping@huawei.com>, <leijitang@huawei.com>,
	<artem.kuzin@huawei.com>, <fedorov.nikita@h-partners.com>,
	<kang.sun@huawei.com>
References: <aad84044-a9d3-4806-a966-4770a3634b03@redhat.com>
 <20251206062106.2109014-1-stepanov.anatoly@huawei.com>
 <20251206062106.2109014-6-stepanov.anatoly@huawei.com>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <20251206062106.2109014-6-stepanov.anatoly@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 12/6/2025 9:21 AM, Anatoly Stepanov wrote:
> This is example of HQ-spinlock enabled for futex hash-table bucket locks
> (used in memcached testing scenario)
> 
> Signed-off-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> 
> Co-authored-by: Stepanov Anatoly <stepanov.anatoly@huawei.com>
> Co-authored-by: Fedorov Nikita <fedorov.nikita@h-partners.com>
> ---
>  kernel/futex/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 125804fbb..05c6d1efc 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1521,7 +1521,7 @@ static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
>  #endif
>  	atomic_set(&fhb->waiters, 0);
>  	plist_head_init(&fhb->chain);
> -	spin_lock_init(&fhb->lock);
> +	spin_lock_init_hq(&fhb->lock);
>  }
>  
>  #define FH_CUSTOM	0x01


Hello,

gentle ping regarding the RFC

-- 
Anatoly Stepanov, Huawei

