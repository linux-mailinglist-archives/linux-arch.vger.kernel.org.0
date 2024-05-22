Return-Path: <linux-arch+bounces-4484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563698CBDAA
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E541F230A4
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593D4770FB;
	Wed, 22 May 2024 09:21:18 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64A80604;
	Wed, 22 May 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369678; cv=none; b=CmNra+VkF+AYsaiJZItgPimp2MLqqbmcU7CKLy8SVsZRQCFoRCMhoI7MivaW0HJC2lAbvXb0dtfbZgij6mcf1/BLye7Wc4b28IcD1+Xx4ZfG3AEV6klRpXyFgbsNZxLyAAJWQOSmhFK0yMMaNcnLkLJnT+1hB6s/VpHbX1qmQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369678; c=relaxed/simple;
	bh=avY3j+hx+C3D9VSEKbqn2dyFRioXHZb36lV3ombKQd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwKCBVrCTelhBTP5csV6e8u3EzkMbTaNYjD6KUx4oSNgh7RJbjt31NHW5Z20zeEbKdtWlxRFmyYKDjA79oo2aQNbHb+RxuQ8wgTMOv+aqoz3cCg5/o/Shk3ycsXq18ofUVWMBWNtAd5vX1MNYgZt3iY1p42aRnCabNyo+vacK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VkljB5GCcz9v7Hk;
	Wed, 22 May 2024 17:03:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CBAA5140485;
	Wed, 22 May 2024 17:21:06 +0800 (CST)
Received: from [10.81.207.231] (unknown [10.81.207.231])
	by APP2 (Coremail) with SMTP id GxC2BwCn4SX0uE1mtQ+sCA--.15533S2;
	Wed, 22 May 2024 10:21:06 +0100 (CET)
Message-ID: <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
Date: Wed, 22 May 2024 11:20:47 +0200
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCn4SX0uE1mtQ+sCA--.15533S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4fJr4UXFyrJFyUuF4kJFb_yoW7Kw1fpF
	W3Ka4UKF1DJws29w1IvwsrXryYkr45JFWUXr93Jw4Iyas09r1xtF15tw45uF9rXrZ7A3Wj
	vr43ta47ua4DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 5/21/2024 um 5:36 PM schrieb Alan Stern:
> On Tue, May 21, 2024 at 11:57:29AM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
>>> On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
>>>> On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
>>>>>
>>>>>
>>>>> Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
>>>>>> Hernan and Jonas:
>>>>>>
>>>>>> Can you explain more fully the changes you want to make to herd7 and/or
>>>>>> the LKMM?  The goal is to make the memory barriers currently implicit in
>>>>>> RMW operations explicit, but I couldn't understand how you propose to do
>>>>>> this.
>>>>>>
>>>>>> Are you going to change herd7 somehow, and if so, how?  It seems like
>>>>>> you should want to provide sufficient information so that the .bell
>>>>>> and .cat files can implement the appropriate memory barriers associated
>>>>>> with each RMW operation.  What additional information is needed?  And
>>>>>> how (explained in English, not by quoting source code) will the .bell
>>>>>> and .cat files make use of this information?
>>>>>>
>>>>>> Alan
>>>>>
>>>>>
>>>>> I don't know whether herd7 needs to be changed. Probably, herd7 does the
>>>>> following:
>>>>> - if a tag called Mb appears on an rmw instruction (by instruction I
>>>>> mean things like xchg(), atomic_inc_return_relaxed()), replace it with
>>>>> one of those things:
>>>>>      * full mb ; once (the rmw) ; full mb, if a value returning
>>>>> (successful) rmw
>>>>>      * once (the rmw)   otherwise
>>>>> - everything else gets translated 1:1 into some internal representation
>>>>
>>>> This is my understanding from reading the source code of CSem.ml in herd7's
>>>> repo.
>>>>
>>>> Also, this is exactly what dartagnan is currently doing.
>>>>
>>>>>
>>>>> What I'm proposing is:
>>>>> 1. remove this transpilation step,
>>>>> 2. and instead allow the Mb tag to actually appear on RMW instructions
>>>>> 3. change the cat file to explicitly define the behavior of the Mb tag
>>>>> on RMW instructions
>>>>
>>>> These are the exact 3 things I changed in dartagnan for testing what Jonas
>>>> proposed.
>>>>
>>>> I am not sure if further changes are needed for herd7.
> 
> What about failed RMW instructions?  IIRC, herd7 generates just an R for
> these, not both R and W, but won't it still be annotated with an mb tag?
> And wasn't this matter of failed RMWs one of the issues that the two of
> you specifically wanted to make explicit in the memory model, rather
> than implicit in the operation of herd7?

That's why we use the RMW_MB tag. I should have copied that definition too:


(* full barrier events that appear in non-failing RMW *)
let RMW_MB = Mb & (dom(rmw) | range(rmw))


This ensures that the only successful rmw instructions have an RMW_MB tag.


> 
> And wasn't another one of these issues the difference between
> value-returning and non-value-returning RMWs?  As far as I can, nothing
> in the .def file specifically mentions this.  There's the noreturn tag
> in the .bell file, but nothing in the .def file says which instructions
> it applies to.  Or are we supposed to know that it automatically applies
> to all __atomic_op() instances?

Ah, now you're already forestalling my next suggestion :))

I would say let's fix one issue at a time (learned this from Andrea).

For the other issue, do noreturn rmws always have the same ordering as once?

I suspect we need to extend herd slightly more to support the second 
one, I don't know if there's syntax for passing tags to __atomic_op.


> 
>>> Okay, good.  This answers the first part of what I asked.  What about
>>> the second part?  That is, how will the changes to the .def, .bell, and
>>> .cat files achieve your goals?
>>>
>>> Alan
>>
>>
>> Firstly, we'd allow 'mb as a barrier mode in events, e.g.
> 
> You mean as a mode in RMW events.  'mb already is a mode for F events.

Thanks, you're right.

> 
>> instructions RMW[{'once,'acquire,'release,'mb}]
>>
>> then the Mb tags would appear in the graph. And then I'd define the ordering
>> explicitly. One way is to say that an Mb tag orders all memory accesses
>> before(or at) the tag with all memory accesses after(or at) the tag, except
>> the accesses of the rmw with each other.
> 
> I don't think you need to add very much.  The .cat file already defines
> the mb relation as including the term:
> 
> 	([M] ; fencerel(Mb) ; [M])
> 
> All that's needed is to replace the fencerel(Mb) with something more
> general...
> 
>> This is the same as the full fence before the read, which orders all memory
>> accesses before the read with every access after(or at) the read,
>> plus the full fence after the write, which orders all memory accesses
>> before(or at) the write with all accesses after the write.
>>
>> That would be done by adding
>>
>>       [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]
> 
> .. like this.
> 
>> to ppo.
> 
> You need to update the definition of mb, not ppo.

Yes, I meant to update the definition of mb, but I momentarily thought 
the effect of that is just that

ppo_new = ppo_old |  [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]

I forgot that extending mb has another effect, in pb.


>  And the RMW_MB above
> looks wrong; shouldn't it be just Mb?

As discussed above, no, since the Mb will also be on the failed RMW.

> 
> Also, is the "\ rmw" part really necessary?  I don't think it makes any
> difference; the memory model already knows that the read part of an RMW
> has to happen before the write part.

It unfortunately does make a difference, because mb is a strong fence.
This means that an Mb in an rmw sequence would create additional pb edges.

   prop;(rfe ; [Mb];rmw;[Mb])

I believe this is might give wrong results on powerpc, but I'd need to 
double check.


> 
>> One could also split it into two rules to keep with the "two full fences"
>> analogy. Maybe a good way would be like this:
>>
>>       [M] ; po; [RMW_MB & R] ; po^? ; [M]
>>
>>       [M] ; po^?; [RMW_MB & W] ; po ; [M]
> 
> My preference is for the first approach.

That was also my early preference, but to be honest I expected that 
you'd prefer the second approach.
Actually, I also started warming up to it.


Have fun,
  jonas


