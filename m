Return-Path: <linux-arch+bounces-3103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16379886666
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 06:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C162841E3
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B578C11;
	Fri, 22 Mar 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bLmwJ52H"
X-Original-To: linux-arch@vger.kernel.org
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F8BA27;
	Fri, 22 Mar 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086497; cv=none; b=TOo5lr5+1vQiGaifuk0xcCw2nhn8XlGqZlkpCqAJzFcvrT+ki18WMUGkIX/DWVG5lYt+A8seQixLRZuoFsMoFvdbCpEgtMOkiIoPXpspCfAvAQWkUMrg2uP4PuRcRbJFd0psYjXpKHkjbURomnD4EfubHBLueYmuD/orhmYAjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086497; c=relaxed/simple;
	bh=a/iNEg1I/52x03KYA2MFESAsRAP+X8GgId4sZuWP/KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuuGbi5ZiaQSfWmOvGhzSF6pWza8DXDEM0gtOD3et5ruvdKofgmAaGZRj5+ICKOp3tWEfWBXlVKcscVFhkUglEIqZ5rMXRVGRUEYjYYwVgApiEZYYyj4F/aLiU3L6vxVGdxCUI6jh2bdTTbXZwLAwo4letnJT2qvxvHwPBgMU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bLmwJ52H; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42M4xB6s3266343
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 21 Mar 2024 21:59:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42M4xB6s3266343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1711083552;
	bh=fY4D2hQ2QLBqdcYPZo8wXFK6V0NwrraNImCOWbN9G1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLmwJ52HsZvjvwZI7xAbCQIwefstRlIDzfKRgERLFJENY/z/tyyTNNnTpqhuc/aiK
	 clxQ6EEbg1W6W4oZmlJ4AXH6Mpen27E8MndGauzBTm/imG795TlTnGphGvESnP2jR6
	 i6Kw9us1X678rgxJAaGd9aTDIbKXRADh2bnoSRl6srF1vOhuU/sbdyXOPETd1pgiBD
	 mHqxCTaJLA8lCvItq5BYoPViJ7D+6+noLPFrVtKtiyRoeasU9plXNDXDVqrOLBhLzK
	 0T/PxHOHJg8DbVTRC+i0y5h0uZQIeGYMTp7eeOoQWIa6EQ+tbDBFbFUIV+dPqpt8vo
	 OTyLQV4DLLnuA==
Message-ID: <e73850ef-f1f6-41a8-b64d-187325b868df@zytor.com>
Date: Thu, 21 Mar 2024 21:59:08 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86: Rename __{start,end}_init_task to
 __{start,end}_init_stack
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        arnd@arndb.de, Brian Gerst <brgerst@gmail.com>
References: <20240318071429.910454-1-xin@zytor.com>
 <ZfyQfQrluph6GxLS@gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ZfyQfQrluph6GxLS@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/2024 12:54 PM, Ingo Molnar wrote:
> 
> * Xin Li (Intel) <xin@zytor.com> wrote:
> 
>> The stack of a task has been separated from the memory of a task_struct
>> struture for a long time on x86, as a result __{start,end}_init_task no
>> longer mark the start and end of the init_task structure, but its stack
>> only.
>>
>> Rename __{start,end}_init_task to __{start,end}_init_stack.
>>
>> Note other architectures are not affected because __{start,end}_init_task
>> are used on x86 only.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>
>> Change since v1:
>> * Revert an accident insane change, init_task to init_stack (Jürgen Groß).
>> ---
>>   arch/x86/include/asm/processor.h  | 4 ++--
>>   arch/x86/kernel/head_64.S         | 2 +-
>>   arch/x86/xen/xen-head.S           | 2 +-
>>   include/asm-generic/vmlinux.lds.h | 6 +++---
>>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> Note that this is now in conflict with this cleanup by Brian Gerst:
> 
>     2cb16181a1d1 x86/boot: Simplify boot stack setup

I like this patch, which does something that I'm also doing, further 
x86_64 doesn't have the concept of TOP_OF_KERNEL_STACK_PADDING, and
I guess it was extended from x86_32 but defined to 0 just for code 
consistency.

Yes, FRED code uses TOP_OF_KERNEL_STACK_PADDING, but a FRED event frame 
could contain different amount of information for different event types,
e.g., #MCE could push extra bytes of information, or perhaps even for 
different instances of the same event type. Thus the size of an event 
frame pushed by a FRED CPU is not fixed and the address of the pt_regs 
structure that is used to save the user level context of current task is 
not at a fixed offset from the top of current task kernel stack.

> 
> .. which removed __end_init_task[] entirely.


Not really, but __end_init_task[] is only used to initialize 
__top_init_kernel_stack.

I will rebase and send v3.

Thanks!
     Xin







