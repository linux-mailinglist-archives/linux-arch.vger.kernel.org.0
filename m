Return-Path: <linux-arch+bounces-4411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B28C60FB
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E592819BE
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09613EA95;
	Wed, 15 May 2024 06:45:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243ACEA4;
	Wed, 15 May 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755509; cv=none; b=jPlJMzVVseD3xH5KvpVHIvQWxVM7y/0rq9YvtgdM/vFDLCfjx3RG+Vc6e8MnvDz02s2NYZZxVcRuRwWDtBnm4ehnPD0PjkWBS7nkVFwxiLQorP6zd2Y/CkHpR17grwMoEofI5l6RjOVexqBMkk6nYpEZGjVhrss3mHQKI0g6P/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755509; c=relaxed/simple;
	bh=rr/1kVdootVVGU7hj5fWVS2fCteWe7tsqWLCJvLLKkU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U0fARLmRDdCvyf3/a3yc8ZKP1U1orMmpCZXFrvi08wnGlD88Vu0f24ee2o9f7KuJvaSd3PiHcfYa0C/q63yd8udhvi6lmjVU+oEmHRcmxR/0Qy/eD69Be8b+kw8TSh354KmhShExDXlN9SR1iQdJHgGJnz7Lg1AyzZTLuV3Jwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VfNZN0Twxz9v7Hl;
	Wed, 15 May 2024 14:27:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id F0B4A1404D9;
	Wed, 15 May 2024 14:44:48 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCTQWURm3bwvCA--.4342S2;
	Wed, 15 May 2024 07:44:48 +0100 (CET)
Message-ID: <143273e9-1243-60bc-4fb0-eea6fb3de355@huaweicloud.com>
Date: Wed, 15 May 2024 08:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
To: paulmck@kernel.org, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
 parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
 Frederic Weisbecker <frederic@kernel.org>, Daniel Lustig
 <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
 <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoCTQWURm3bwvCA--.4342S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXF4kKFy3Wr1fAFW3Awb_yoW5uw4kpF
	yrKayUKrs7JrWUAw4Iva1jqF10vrZ3JFW5Xw15tryUAan8GF1FvFyYqrW5ury2yrsaka1j
	vr1Y9347Zry5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07boZ2-UUUUU=
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 5/6/2024 8:00 PM, Paul E. McKenney wrote:
> On Mon, May 06, 2024 at 06:30:45PM +0200, Jonas Oberhauser wrote:
>> Am 5/6/2024 um 12:05 PM schrieb Jonas Oberhauser:
>>> Am 5/2/2024 um 1:21 AM schrieb Paul E. McKenney:
>>>> This commit adds four litmus tests showing that a failing cmpxchg()
>>>> operation is unordered unless followed by an smp_mb__after_atomic()
>>>> operation.
>>>
>>> So far, my understanding was that all RMW operations without suffix
>>> (xchg(), cmpxchg(), ...) will be interpreted as F[Mb];...;F[Mb].
>>>
>>> I guess this shows again how important it is to model these full
>>> barriers explicitly inside the cat model, instead of relying on implicit
>>> conversions internal to herd.
>>>
>>> I'd like to propose a patch to this effect.
>>>
>>> What is the intended behavior of a failed cmpxchg()? Is it the same as a
>>> relaxed one?
> 
> Yes, and unless I am too confused, LKMM currently does implement this.
> Please let me know if I am missing something.
> 
>>> My suggestion would be in the direction of marking read and write events
>>> of these operations as Mb, and then defining
>>>
>>> (* full barrier events that appear in non-failing RMW *)
>>> let RMW_MB = Mb & (dom(rmw) | range(rmw))
>>>
>>>
>>> let mb =
>>>       [M] ; fencerel(Mb) ; [M]
>>>     | [M] ; (po \ rmw) ; [RMW_MB] ; po^? ; [M]
>>>     | [M] ; po^? ; [RMW_MB] ; (po \ rmw) ; [M]
>>>     | ...
>>>
>>> The po \ rmw is because ordering is not provided internally of the rmw
>>
>> (removed the unnecessary si since LKMM is still non-mixed-accesses)
> 
> Addition of mixed-access support would be quite welcome!
> 
>> This could also be written with a single rule:
>>
>>       | [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]
>>
>>> I suspect that after we added [rmw] sequences it could perhaps be
>>> simplified [...]
>>
>> No, my suspicion is wrong - this would incorrectly let full-barrier RMWs
>> act like strong fences when they appear in an rmw sequence.
>>
>>   if (z==1)  ||  x = 2;     ||  xchg(&y,2)  || if (y==2)
>>     x = 1;   ||  y =_rel 1; ||              ||    z=1;
>>
>>
>> right now, we allow x=2 overwriting x=1 (in case the last thread does not
>> propagate x=2 along with z=1) because on power, the xchg might be
>> implemented with a sync that doesn't get executed until the very end
>> of the program run.
>>
>>
>> Instead of its negative form (everything other than inside the rmw),
>> it could also be rewritten positively. Here's a somewhat short form:
>>
>> let mb =
>>       [M] ; fencerel(Mb) ; [M]
>>     (* everything across a full barrier RMW is ordered. This includes up to
>> one event inside the RMW. *)
>>     | [M] ; po ; [RMW_MB] ; po ; [M]
>>     (* full barrier RMW writes are ordered with everything behind the RMW *)
>>     | [W & RMW_MB] ; po ; [M]
>>     (* full barrier RMW reads are ordered with everything before the RMW *)
>>     | [M] ; po ; [R & RMW_MB]
>>     | ...
> 
> Does this produce the results expected by the litmus tests in the Linux
> kernel source tree and also those at https://github.com/paulmckrcu/litmus?
> 
> 							Thanx, Paul

I implemented in the dartagnan tool the changes proposed by Jonas (i.e. 
changing the mb definition in the cat model and removing the fences that 
were added programmatically).

I run this using the ~5K litmus test I have (it should include 
everything from the source tree + the non-LISA ones from your repo). I 
also checked with the version of qspinlock discussed in [1].

I do get the expected results.

Hernan

[1] https://lkml.org/lkml/2022/8/26/597


