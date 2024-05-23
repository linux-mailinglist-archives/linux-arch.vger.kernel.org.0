Return-Path: <linux-arch+bounces-4498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0078CD2DB
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 14:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E961C21233
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6AC14A09A;
	Thu, 23 May 2024 12:54:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EE13BAC7;
	Thu, 23 May 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468874; cv=none; b=Qf/rDaT6CtyNVEw8NmQYfRBaUoH0kDVCdplKyB4XYNzwSXS1Evq1mP3t75dhj+3A54Q6KJdwp5F+zpk5Fq08eSLmyCwEs/hDQJry7Fr+wrTxPkW+yZz0K7/iKmwYhtjHZqPh9PKYi+SAndHRoI2vyp8ESxGV2yu5fPODlO0RnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468874; c=relaxed/simple;
	bh=hcKgpedAN7QBD56EcaSsNr1Bo7f8IsskyTwgxE3DYco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMAkJw0laDkePryFLDQntt2BMD74Q5kYPsEII0OmCEZt0FYUnHNV1nflLKY0irqHWOfqPpefVOY8qb90M17qMdzhvtYCka5MBFYqLUKg3KqFGDimKFn4KHoVXK20iDxRkMKVKteVGfyvViI6rJ9qlujie3VP+Sk1ICkBpfgR9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VlSNp55w5z9v7Hk;
	Thu, 23 May 2024 20:37:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 81E8E140790;
	Thu, 23 May 2024 20:54:21 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSVxPE9mEwW_CA--.19410S2;
	Thu, 23 May 2024 13:54:20 +0100 (CET)
Message-ID: <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
Date: Thu, 23 May 2024 14:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoSVxPE9mEwW_CA--.19410S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aryktr1UtryDKw15Gr1DGFg_yoW3Cw4fpF
	W3Ka4UKr4DJrs2kr12vwsrXryFkr4UJFW5Xrn5Jw17A3Z09r1xtF4Utw45uF9rXrZ3G3Wj
	qrW7ta43Za4DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/22/2024 um 4:20 PM schrieb Alan Stern:
> On Wed, May 22, 2024 at 11:20:47AM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/21/2024 um 5:36 PM schrieb Alan Stern:
>>> On Tue, May 21, 2024 at 11:57:29AM +0200, Jonas Oberhauser wrote:
>>>>
>>>>
>>>> Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
>>>>> On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
>>>>>> On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
>>>>>>>
>>>>>>>
>>>>>>> Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
>>>>>>>> Hernan and Jonas:
>>>>>>>>
>>>>>>>> Can you explain more fully the changes you want to make to herd7 and/or
>>>>>>>> the LKMM?  The goal is to make the memory barriers currently implicit in
>>>>>>>> RMW operations explicit, but I couldn't understand how you propose to do
>>>>>>>> this.
>>>>>>>>
>>>>>>>> Are you going to change herd7 somehow, and if so, how?  It seems like
>>>>>>>> you should want to provide sufficient information so that the .bell
>>>>>>>> and .cat files can implement the appropriate memory barriers associated
>>>>>>>> with each RMW operation.  What additional information is needed?  And
>>>>>>>> how (explained in English, not by quoting source code) will the .bell
>>>>>>>> and .cat files make use of this information?
>>>>>>>>
>>>>>>>> Alan
>>>>>>>
>>>>>>>
>>>>>>> I don't know whether herd7 needs to be changed. Probably, herd7 does the
>>>>>>> following:
>>>>>>> - if a tag called Mb appears on an rmw instruction (by instruction I
>>>>>>> mean things like xchg(), atomic_inc_return_relaxed()), replace it with
>>>>>>> one of those things:
>>>>>>>       * full mb ; once (the rmw) ; full mb, if a value returning
>>>>>>> (successful) rmw
>>>>>>>       * once (the rmw)   otherwise
>>>>>>> - everything else gets translated 1:1 into some internal representation
>>>>>>
>>>>>> This is my understanding from reading the source code of CSem.ml in herd7's
>>>>>> repo.
>>>>>>
>>>>>> Also, this is exactly what dartagnan is currently doing.
>>>>>>
>>>>>>>
>>>>>>> What I'm proposing is:
>>>>>>> 1. remove this transpilation step,
>>>>>>> 2. and instead allow the Mb tag to actually appear on RMW instructions
>>>>>>> 3. change the cat file to explicitly define the behavior of the Mb tag
>>>>>>> on RMW instructions
>>>>>>
>>>>>> These are the exact 3 things I changed in dartagnan for testing what Jonas
>>>>>> proposed.
>>>>>>
>>>>>> I am not sure if further changes are needed for herd7.
>>>
>>> What about failed RMW instructions?  IIRC, herd7 generates just an R for
>>> these, not both R and W, but won't it still be annotated with an mb tag?
>>> And wasn't this matter of failed RMWs one of the issues that the two of
>>> you specifically wanted to make explicit in the memory model, rather
>>> than implicit in the operation of herd7?
>>
>> That's why we use the RMW_MB tag. I should have copied that definition too:
>>
>>
>> (* full barrier events that appear in non-failing RMW *)
>> let RMW_MB = Mb & (dom(rmw) | range(rmw))
>>
>>
>> This ensures that the only successful rmw instructions have an RMW_MB tag.
> 
> It would be better if there was a way to tell herd7 not to add the 'mb
> tag to failed instructions in the first place.  This approach is
> brittle; see below.

Hernan told me that in fact that is actually currently the case in 
herd7. Failing RMW get assigned the Once tag implicitly.
Another thing that I'd suggest to change.

> 
> An alternative would be to have a way for the .cat file to remove the
> 'mb tag from a failed RMW instruction.  But I don't know if this is
> feasible.

For Mb it's feasible, as there is no Mb read or Mb store.

Mb = Mb & (~M | dom(rmw) | range(rmw))

However one would want to do the same for Acq and Rel.

For that one would need to distinguish e.g. between a read that comes 
from a failed rmw instruction, and where the tag would disappear, or a 
normal standalone read.

For example, by using two different acquire tags, 'acquire and 
'rmw-acquire, and defining

Acquire = Acquire | Rmw-acquire & (dom(rmw) | range(rmw))

Anyways we can do this change independently. So for now, we don't need 
RMW_MB.


> 
>>> And wasn't another one of these issues the difference between
>>> value-returning and non-value-returning RMWs?  As far as I can, nothing
>>> in the .def file specifically mentions this.  There's the noreturn tag
>>> in the .bell file, but nothing in the .def file says which instructions
>>> it applies to.  Or are we supposed to know that it automatically applies
>>> to all __atomic_op() instances?
>>
>> Ah, now you're already forestalling my next suggestion :))
>>
>> I would say let's fix one issue at a time (learned this from Andrea).
>>
>> For the other issue, do noreturn rmws always have the same ordering as once?
> 
> If they aren't annotated with _acquire or _release then yes...  And I
> don't know whether there _are_ any annotated no-return RMWs.  If
> somebody wanted such a thing, they probably would just use a
> value-returning RMW instead.
> 
>> I suspect we need to extend herd slightly more to support the second one, I
>> don't know if there's syntax for passing tags to __atomic_op.
> 
> This may not be be needed.  But still, it would nice to be explicit (in
> a comment in the .def file if nowhere else) that __atomic_op always adds
> a 'noreturn tag.
> 
>>>> instructions RMW[{'once,'acquire,'release,'mb}]
>>>>
>>>> then the Mb tags would appear in the graph. And then I'd define the ordering
>>>> explicitly. One way is to say that an Mb tag orders all memory accesses
>>>> before(or at) the tag with all memory accesses after(or at) the tag, except
>>>> the accesses of the rmw with each other.
>>>
>>> I don't think you need to add very much.  The .cat file already defines
>>> the mb relation as including the term:
>>>
>>> 	([M] ; fencerel(Mb) ; [M])
>>>
>>> All that's needed is to replace the fencerel(Mb) with something more
>>> general...
> 
> And this is why I said the RMW_MB mechanism is brittle.  With the 'mb
> tag still added to failed RMW events, the term above will cause the
> memory model to think there is ordering even though the event isn't in
> the RMW_MB class.
> 

Huh, I thought that fencerel(Mb) is something like po ; [F & Mb] ; po 
(where F includes standalone fences). But looking into the stdlib.cat, 
you're right.


>>> Also, is the "\ rmw" part really necessary?  I don't think it makes any
>>> difference; the memory model already knows that the read part of an RMW
>>> has to happen before the write part.
>>
>> It unfortunately does make a difference, because mb is a strong fence.
>> This means that an Mb in an rmw sequence would create additional pb edges.
>>
>>    prop;(rfe ; [Mb];rmw;[Mb])
>>
>> I believe this is might give wrong results on powerpc, but I'd need to
>> double check.
> 
> PowerPC uses a load-reserve/store-conditional approach for RMW, so it's
> tricky.  However, you're right that having a fictitious mb between the
> read and the write of an RMW would mean that the preceding (in coherence
> order) write would have to be visible to all CPUs before the RMW write
> could execute, and I don't believe we want to assert this.
> 
>>>> One could also split it into two rules to keep with the "two full fences"
>>>> analogy. Maybe a good way would be like this:
>>>>
>>>>        [M] ; po; [RMW_MB & R] ; po^? ; [M]
>>>>
>>>>        [M] ; po^?; [RMW_MB & W] ; po ; [M]
>>>
>>> My preference is for the first approach.
>>
>> That was also my early preference, but to be honest I expected that you'd
>> prefer the second approach.
>> Actually, I also started warming up to it.
> 
> If you do want to use this approach, it should be simplified.  All you
> need is:
> 
> 	[M] ; po ; [RMW_MB]
> 
> 	[RMW_MB] ; po ; [M]
> 
> This is because events tagged with RMW_MB always are memory accesses,
> and accesses that aren't part of the RMW are already covered by the
> fencerel(Mb) thing above.

This has exactly the issue mentioned above - it will cause the rmw to 
have an internal strong fence that on powerpc probably isn't there.

We could do (with the assumption that Mb applies only to successful rmw):

  	[M] ; po ; [Mb & R]
  	[Mb & W] ; po ; [M]


Kind regards, jonas


