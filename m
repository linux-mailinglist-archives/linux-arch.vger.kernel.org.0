Return-Path: <linux-arch+bounces-14899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C3C6DEED
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 335442E269
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197633F380;
	Wed, 19 Nov 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdGoDxJt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3E21D3F5;
	Wed, 19 Nov 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547226; cv=none; b=JLs3A9L/QkjTZRrHS8yhXr5hKjIIdU9TPtFR7veSP+4Se186eFcfUaOmVnrooTJgD03AZatdFDz1w+FyTKmyZKJTw80C//N6Lp3GrRaz1KXdnyyBbKyx9Z1jRPz6Hh3oBMY1XwWw8nm8D1z+Ykw+wuyOdLHiCFzL/dskix8tFno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547226; c=relaxed/simple;
	bh=8IYxu/C3qrGid3n3xMVLRSBITnzao99XRln0ciNWneY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZExnWfRpAZAS8dF07xC1U6sKrJ11GGQPFu6NkAJ+I8gwAjETJY/uWowkDWwd4Sdb4eBwyVywsGe7YI2Ug9ArB7/nufyaplQNxjA7lZ2/Q7txa9wNr6lF3aF5uiKQ3vauRJoq/smzOPeo85HP23HqBKqy2wklcMTtYp6rKJkUzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdGoDxJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB52CC16AAE;
	Wed, 19 Nov 2025 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547226;
	bh=8IYxu/C3qrGid3n3xMVLRSBITnzao99XRln0ciNWneY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LdGoDxJt9h1Tlf1FCndkLyh+OwHFWpLYja9EnuhCaStGYdTO/u/3+Fxjm8oCvXk2/
	 E35KNa8rkDsQ4bPiZhB7BvC+7G9u3vv2O95UQNcf+uUOrfyBdK3uT+eewjqJwxMg6f
	 O1rm2iLUscQJgkXdhNOc9AFc9kCFpZIhNjSzZINyqhCmWVFyFPOvsz8HJeqmQXW4+H
	 s7XMLF+PxrmhzX0byFy0OOO5Djr+zth+JdHGDpKJGZ+dUbNfoMyOEIkvtSt3VTig0u
	 DjN5MNM3mx4xWC+cutnpwm7m5sszHgWntNoXn6IOKKCqq/T/Yv6HJIdQv894sJyfel
	 bVNiG5QRYn7SA==
Message-ID: <afecde77-a4af-40f1-a905-9de8a1bdd783@kernel.org>
Date: Wed, 19 Nov 2025 11:13:37 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <arch0.zheng@gmail.com>, Qi Zheng <qi.zheng@linux.dev>,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
 <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.11.25 12:53, Qi Zheng wrote:
> 
> 
> On 11/18/25 12:53 AM, David Hildenbrand (Red Hat) wrote:
>> On 14.11.25 12:11, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Hi all,
>>>
>>> This series aims to enable PT_RECLAIM on all 64-bit architectures.
>>>
>>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
>>> empty PTE
>>> page table pages (such as 100GB+). To resolve this problem, we need to
>>> enable
>>> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
>>>
>>
>> Makes sense!
>>
>>> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all
>>> 64-bit
>>> architectures, and finally makes PT_RECLAIM depend on
>>> MMU_GATHER_RCU_TABLE_FREE
>>> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
>>> architectures.
>>
>> Could we then even go ahead and stop making PT_RECLAIM user-selectable?
> 
> OK, will change to:

Was more of a question: is there any scenario where we ran so far into 
issues with it?

-- 
Cheers

David

