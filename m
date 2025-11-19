Return-Path: <linux-arch+bounces-14900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E5C6DF90
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8FB14E633B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460534B19A;
	Wed, 19 Nov 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKzsfyak"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D2340A46;
	Wed, 19 Nov 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547601; cv=none; b=cFdfhEARbRLI/JGC8ij4ysIrAusruUw6Xn8xwNpvA3Z1F/AazS+vHC7bKwVec5orN4DaYVkFQNUgjBt0LRw4XHTiHhwsAutJm0Tb9ecM+qEn+8Vxv1nF7PTI1rvCayZMH8+H2I9/8ZBokDg9KSZj8+nggGA6VhehVH5nd1vjWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547601; c=relaxed/simple;
	bh=8gID8BLUqz27ftdyuyVystLlDDq4KdFYCustoOe54RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceiCQuiWB0RirKvUDal/80bY6p4v/BFQxJkWtxd/oecTjv+zvJuC+XxwKhirCpP+whDDgK8zdlwYL+98A7vtcCG0d4w9PRf8e1NoiSIMAwnZ2PGhavZInb1tJIWJ8NprD2V1Q9qDTXycPyY8s2e7EV1XhqD/n3TURruPj4dhwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKzsfyak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED579C113D0;
	Wed, 19 Nov 2025 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547599;
	bh=8gID8BLUqz27ftdyuyVystLlDDq4KdFYCustoOe54RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XKzsfyaktYk1NfN18S9hccOsNg6wsjdvBDLtH0msz229ZMI3K2CpzJjlq9zogKst2
	 IpRt8Vacn6bPvhAXJdPHwvnVsyk6/LZ60Qv8L+fBjOvTfDozVL9UROfYk950jLCsWS
	 z34Iocb3hYkWz25pZf8wW4+AEb0QYUxLALyXcNTRJvEqAW1in4xBVuLd65R+AO4LmD
	 3mR3cklLqI+9GQ2KEyAt9BlaxeG6te4kJv7JSGHicczEifcPTgrsoQEfXUbh9/ck8O
	 H/mZ5W6d8h1ftYMiR98ZlqQUntxOjDHk0Ldf3QsAumi71SRiq5wve77UId9Sr0YPuj
	 rsuuFhSqOdrMg==
Message-ID: <9386032c-9840-49da-83f9-74b112f3e752@kernel.org>
Date: Wed, 19 Nov 2025 11:19:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
 <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
 <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.11.25 13:02, Qi Zheng wrote:
> 
> 
> On 11/18/25 12:57 AM, David Hildenbrand (Red Hat) wrote:
>> On 14.11.25 12:11, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Subject: s/&&/&/
> 
> will do.
> 
>>
>>>
>>> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM
>>> can
>>> be enabled by default on all architectures that support
>>> MMU_GATHER_RCU_TABLE_FREE.
>>>
>>> Considering that a large number of PTE page table pages (such as 100GB+)
>>> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
>>> 64BIT.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>    arch/x86/Kconfig | 1 -
>>>    mm/Kconfig       | 6 +-----
>>>    2 files changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index eac2e86056902..96bff81fd4787 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -330,7 +330,6 @@ config X86
>>>        select FUNCTION_ALIGNMENT_4B
>>>        imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>        select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>        select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>        select SCHED_SMT            if SMP
>>>        select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index a5a90b169435d..e795fbd69e50c 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>          The architecture has hardware support for userspace shadow call
>>>              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>> -config ARCH_SUPPORTS_PT_RECLAIM
>>> -    def_bool n
>>> -
>>>    config PT_RECLAIM
>>>        bool "reclaim empty user page table pages"
>>>        default y
>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>> -    select MMU_GATHER_RCU_TABLE_FREE
>>> +    depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
>>
>> Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop
>> the MMU part)
> 
> OK.
> 
>>
>> Why do we care about SMP in the first place? (can we frop SMP)
> 
> OK.
> 
>>
>> But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":
>>
>> Would it be harmful on 32bit (sure, we might not reclaim as much, but
>> still there is memory to be reclaimed?)?
> 
> This is also fine on 32bit, but the benefits are not significant, So I
> chose to enable it only on 64-bit.

Right. Address space is smaller, but also memory is smaller. Not that I 
think we strictly *must* to support 32bit, I merely wonder why we 
wouldn't just enable it here.

OTOH, if there is a good reason we cannot enable it, we can definitely 
just keep it 64bit only.

> 
> I actually tried enabling MMU_GATHER_RCU_TABLE_FREE on all
> architectures, and apart from sparc32 being a bit troublesome (because
> it uses mm->page_table_lock for synchronization within
> __pte_free_tlb()), the modifications were relatively simple.
> 
>>
>> If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously
>> state), why can't we only check for 64BIT?
> 
> OK, will do.

This was also more of a question for discussion:

Would it make sense to have

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE

(a) Would we want to make it configurable (why?)
(b) Do we really care about SMP (why?)
(c) Do we want to limit to 64bit (why?)
(d) Do we really need the MMU check in addition to
     MMU_GATHER_RCU_TABLE_FREE


-- 
Cheers

David

