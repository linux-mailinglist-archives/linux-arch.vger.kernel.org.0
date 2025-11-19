Return-Path: <linux-arch+bounces-14909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E509C6E676
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 13:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F64C3444D3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBE1CEADB;
	Wed, 19 Nov 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AVtUPokb"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE48821
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554574; cv=none; b=mRDphBtlaSgmtgxwwdz0azhAuJuv+8l/o35OETyGLbE/Ap0wOqbg97WnCYu3S8+DrCrmtCz4k9e3cWzNeRJfq3s4+y5mVUzy9kk4tIh1cKVLcWvEllwqqKm4FAltLbypbd/3LHnchDMxR1ZNxe1L7ZVaMlxoQdpnHMFowqdipgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554574; c=relaxed/simple;
	bh=NOfOnn03Q1ZH3fp+giJQ+9zw24c2IS8H6URgJUfWT+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT23G4emmdIF13v7v2tkba2dZhv77EUchcB+BtGpjJqR+WHNo73IAkbPugDSh6mIFx1wqaSe9g25//mutFwH3QAvXH2u8mgTkoO1OW630mFvzdSOva5ZPesJW6GnLfiUH6vXp/aXkhAQ5lZhEstlvtiWP/HIQ6rEIlErUbxD/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AVtUPokb; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6e6d8390-1f9e-40cf-949d-168160fa9a15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763554567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8UxEgfEvYYIYjqonyzaX1YNHYFvCPlixYyfl5K/5Us=;
	b=AVtUPokbskA2fxW7sCPAzJUrWf8TDNbPt/WdsQfOCSbGOGvqVUig5Chd70lHJMkyln4ufj
	X6Bg1RKVDftg0vFjwYVYCXvoFKw63N958H75bSqPHgoSBbSpEmPqQpJlqP6Lz5U8HFdbCb
	XKACOfahN120NBnxDteAgU+KBrLLN4I=
Date: Wed, 19 Nov 2025 20:15:58 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] mm: enable PT_RECLAIM on all 64-bit architectures
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com,
 linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
 <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/19/25 7:38 PM, David Hildenbrand (Red Hat) wrote:
> On 19.11.25 08:31, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Now, the MMU_GATHER_RCU_TABLE_FREE is enabled on all 64-bit 
>> architectures,
>> so make PT_RECLAIM depend on 64BIT, thereby enabling PT_RECLAIM on all
>> 64-bit architectures.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 9 ++-------
>>   2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eac2e86056902..96bff81fd4787 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -330,7 +330,6 @@ config X86
>>       select FUNCTION_ALIGNMENT_4B
>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>       select SCHED_SMT            if SMP
>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index d548976d0e0ad..94eec5c0cad96 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1448,14 +1448,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>>         The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -    def_bool n
>> -
>>   config PT_RECLAIM
>> -    bool "reclaim empty user page table pages"
>> -    default y
>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -    select MMU_GATHER_RCU_TABLE_FREE
>> +    def_bool y
>> +    depends on 64BIT
> 
> As discussed in the other thread, likely
> 
> config PT_RECLAIM
>      def_bool y
>      depends on MMU_GATHER_RCU_TABLE_FREE && 64BIT
> 
> Could be nice, and if possible even dropping the 64BIT limitation as 
> well if there is no need to.

I think it's ok to drop the 64BIT limitation. There should be some
32-bit architectures that already enable MMU_GATHER_RCU_TABLE_FREE.

> 
> 


