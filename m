Return-Path: <linux-arch+bounces-14873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D5AC69464
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0B7E361EC0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AA3559E3;
	Tue, 18 Nov 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9Rbcq7i"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE7354AE6;
	Tue, 18 Nov 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467431; cv=none; b=nssJt/u+jYZ4zVxJD337yziCAjV1diblUXb9S/DwwgznlIapHtmuMcIFRD7AZa9rE+6+BmAAFbxvnNavdxTQ+8fkvIGN7f3ROtvBcZ/++FCLve1SYZTpnq6Iw46JSf/gpBrIiGScUo0DqJJ/ejdbG2t8YDWzZmObrduHTb1EphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467431; c=relaxed/simple;
	bh=r19qXNtm3urYqAimszpeFMMBfwkKku5yTeyTyto+D7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQveE0JgU4AdHEhBGijzVOqQozBXPwtrnvOUqZi+QpMASahx8nzEiQCk834eIA5M71TF7cxS9gsuLg/YSLG0tIWvSEro6JmtKwLPJZqKokzRGHp9R7GViavY/1wV23t+EGW2IuTijJ3t1jbTurpjWb7WPK665v+GRosdIO/3YUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9Rbcq7i; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763467417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSfDkQJHByC5W64S3r1RZBfV7l+QzHRtZt5IkHkWjXM=;
	b=Z9Rbcq7i2Y1LGHCoUGuTi6ppSLunSulmRKUQ4pjayjy42viyJ+DcXrTYmImrfSRJw+UKR4
	UVTRGLFHLTlNdVaXnjT3ixLkagqhNZyq0Aqov/I7FCpMijq/fe4cVtkKv+q+YaHP5txxbN
	qqqQe//KpgfJbRYA+2BGf/imvJ4aYQ4=
Date: Tue, 18 Nov 2025 20:02:30 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
 <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/18/25 12:57 AM, David Hildenbrand (Red Hat) wrote:
> On 14.11.25 12:11, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Subject: s/&&/&/

will do.

> 
>>
>> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM 
>> can
>> be enabled by default on all architectures that support
>> MMU_GATHER_RCU_TABLE_FREE.
>>
>> Considering that a large number of PTE page table pages (such as 100GB+)
>> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
>> 64BIT.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 6 +-----
>>   2 files changed, 1 insertion(+), 6 deletions(-)
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
>> index a5a90b169435d..e795fbd69e50c 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>         The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -    def_bool n
>> -
>>   config PT_RECLAIM
>>       bool "reclaim empty user page table pages"
>>       default y
>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -    select MMU_GATHER_RCU_TABLE_FREE
>> +    depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
> 
> Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop 
> the MMU part)

OK.

> 
> Why do we care about SMP in the first place? (can we frop SMP)

OK.

> 
> But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":
> 
> Would it be harmful on 32bit (sure, we might not reclaim as much, but 
> still there is memory to be reclaimed?)?

This is also fine on 32bit, but the benefits are not significant, So I
chose to enable it only on 64-bit.

I actually tried enabling MMU_GATHER_RCU_TABLE_FREE on all
architectures, and apart from sparc32 being a bit troublesome (because
it uses mm->page_table_lock for synchronization within
__pte_free_tlb()), the modifications were relatively simple.

> 
> If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously 
> state), why can't we only check for 64BIT?

OK, will do.

Thanks,
Qi

> 


