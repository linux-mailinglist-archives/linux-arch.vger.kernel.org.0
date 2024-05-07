Return-Path: <linux-arch+bounces-4235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD68BDDCB
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE072823E7
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498414D6E0;
	Tue,  7 May 2024 09:11:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BF6BFC0;
	Tue,  7 May 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073117; cv=none; b=oqzXnMjjHJXUi43kpNBrdfh1Z5aaolu2w08440qnU5h/KiYWNRMS1884RCL+Ll11vWmi4QxmXuB8ALdk/7XiR52UTy8jbRzNWOs/mm2STu0p1R5fMhePQ69wyVvM1FtCoNLpTM3SMQXi0+F4GDK5uwJqH2YVvT41XC2psShkeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073117; c=relaxed/simple;
	bh=YHXlC7kJ8K1unV8F/MZ9J57OGBK3Citlye2x7wU1iwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibGOO5FFEL1zWsv57/rwCUAAN5XE/A5qnX5TMry9KHnMOV4xRVAlxBfAntKdvwoWgJZtEAiG2uYQbmEWQI46YS3tz0bojT+GLmPaQ/opmUfI25qx79Q2ByweEUcksSPGZKSuEdlTFbeQWNcK/ufw58U3QGNGWutbhrZZH/GNb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYXCb0gGNz9v7fr;
	Tue,  7 May 2024 16:54:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A26CE14074A;
	Tue,  7 May 2024 17:11:40 +0800 (CST)
Received: from [10.45.158.162] (unknown [10.45.158.162])
	by APP2 (Coremail) with SMTP id GxC2BwB3Yyc+8DlmamutBw--.32210S2;
	Tue, 07 May 2024 10:11:40 +0100 (CET)
Message-ID: <a49c85e2-f5d1-4beb-86d9-43cbc2d59336@huaweicloud.com>
Date: Tue, 7 May 2024 11:11:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model 2/4] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
To: paulmck@kernel.org, luc.maranget@inria.fr
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
 parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, akiyks@gmail.com,
 Frederic Weisbecker <frederic@kernel.org>, Daniel Lustig
 <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <42a43181-a431-44bd-8aff-6b305f8111ba@paulmck-laptop>
 <20240501232132.1785861-2-paulmck@kernel.org>
 <c97f0529-5a8f-4a82-8e14-0078d4372bdc@huaweicloud.com>
 <16381d02-cb70-4ae5-b24e-aa73afad9aed@huaweicloud.com>
 <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2a695f63-6c9a-4837-ac03-f0a5c63daaaf@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3Yyc+8DlmamutBw--.32210S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXF4kKFy3WFWfZr45trb_yoWrGr1xpF
	WrKFWUKr1DJ3yUu340va1qqFy0v393JF4Yqw15tryjyan8GF1FvFyYqrWY9r9rtrs3Cw40
	vr1Y93srZr98AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUklb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5vQ6JUUUU
	U==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/6/2024 um 8:00 PM schrieb Paul E. McKenney:
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

At least the herd and Dat3M implementations seem to be doing that, at 
least according to this thread sent to me by Hernan.

https://github.com/herd/herdtools7/issues/384#issue-1243049709


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

:P


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

I suspect that it doesn't work out of the box because of some of the 
implicit magic herd is doing that could get in the way, so I'd need some 
help from Luc to actually turn this into a patch that can be tested.
(or at least confirmation that just by changing a few things in the .def 
& .bell files we can sidestep the implicit behaviors).

But at least in my proofs it seems to be equivalent.
(there may still be differences in opinion on what some herd things 
mean, so what I/Viktor have formalized as the semantics of the herd 
model may not be exactly the behavior of LKMM in herd. hence testing is 
necessary too as a sanity check)

best wishes,
   jonas


