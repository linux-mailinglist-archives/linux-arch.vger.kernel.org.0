Return-Path: <linux-arch+bounces-4478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801788CAB56
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229541F214AE
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5342061664;
	Tue, 21 May 2024 09:58:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEB56763;
	Tue, 21 May 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285485; cv=none; b=t/1hrVTGc4M+wa+qOC7YCBtbvRSLF+fp6H5UGHhbDLjUfkCETsViAVU71sJv40Ns0+J1L9FTKzDi5TXaFRG5BNWcs6HbmbJeug+dQTqISosVerNpqNUoECEuTFEJxuv9yynkUaWAFePDPSdnR6NHTA9PamPROCrTvRjHqWRSYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285485; c=relaxed/simple;
	bh=FR1c2S746F6o3Xj8394Kf/wJ/lD8QmFz+4mC//y5RA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1RbglSDAWla/CMoqGTzhXOKd0cZrDGRlU7xqbJH9bkRHK279rNmIXwXbUKryJVbFHd5Nn2d80n2btCfHIoyEyNoHMEflxiqMlHONn6V3w8YW4ztaKQ19okM+b4JFP2d80C7SKjh6KWXZAhojVPO4QktUvy97U4MfE47GAa62xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vk8Z10HFxz9v7Hm;
	Tue, 21 May 2024 17:40:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 773E91404F7;
	Tue, 21 May 2024 17:57:43 +0800 (CST)
Received: from [10.81.202.68] (unknown [10.81.202.68])
	by APP2 (Coremail) with SMTP id GxC2BwC38SUMcExm4emUCA--.12318S2;
	Tue, 21 May 2024 10:57:42 +0100 (CET)
Message-ID: <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
Date: Tue, 21 May 2024 11:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LKMM: Making RMW barriers explicit
To: Alan Stern <stern@rowland.harvard.edu>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC38SUMcExm4emUCA--.12318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDJw1fWr4xKr15KryfWFg_yoW5CrWfpa
	13Ka4UKr4DJw4vk3Wq9FsIqFyF9a1rJrWUXr93twsakas0gr1IgF15t3yUuF9rXrZ7Z3Wj
	vr13tas7ua4DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
> On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
>> On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
>>>
>>>
>>> Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
>>>> Hernan and Jonas:
>>>>
>>>> Can you explain more fully the changes you want to make to herd7 and/or
>>>> the LKMM?  The goal is to make the memory barriers currently implicit in
>>>> RMW operations explicit, but I couldn't understand how you propose to do
>>>> this.
>>>>
>>>> Are you going to change herd7 somehow, and if so, how?  It seems like
>>>> you should want to provide sufficient information so that the .bell
>>>> and .cat files can implement the appropriate memory barriers associated
>>>> with each RMW operation.  What additional information is needed?  And
>>>> how (explained in English, not by quoting source code) will the .bell
>>>> and .cat files make use of this information?
>>>>
>>>> Alan
>>>
>>>
>>> I don't know whether herd7 needs to be changed. Probably, herd7 does the
>>> following:
>>> - if a tag called Mb appears on an rmw instruction (by instruction I
>>> mean things like xchg(), atomic_inc_return_relaxed()), replace it with
>>> one of those things:
>>>     * full mb ; once (the rmw) ; full mb, if a value returning
>>> (successful) rmw
>>>     * once (the rmw)   otherwise
>>> - everything else gets translated 1:1 into some internal representation
>>
>> This is my understanding from reading the source code of CSem.ml in herd7's
>> repo.
>>
>> Also, this is exactly what dartagnan is currently doing.
>>
>>>
>>> What I'm proposing is:
>>> 1. remove this transpilation step,
>>> 2. and instead allow the Mb tag to actually appear on RMW instructions
>>> 3. change the cat file to explicitly define the behavior of the Mb tag
>>> on RMW instructions
>>
>> These are the exact 3 things I changed in dartagnan for testing what Jonas
>> proposed.
>>
>> I am not sure if further changes are needed for herd7.
> 
> Okay, good.  This answers the first part of what I asked.  What about
> the second part?  That is, how will the changes to the .def, .bell, and
> .cat files achieve your goals?
> 
> Alan


Firstly, we'd allow 'mb as a barrier mode in events, e.g.

instructions RMW[{'once,'acquire,'release,'mb}]

then the Mb tags would appear in the graph. And then I'd define the 
ordering explicitly. One way is to say that an Mb tag orders all memory 
accesses before(or at) the tag with all memory accesses after(or at) the 
tag, except the accesses of the rmw with each other.
This is the same as the full fence before the read, which orders all 
memory accesses before the read with every access after(or at) the read,
plus the full fence after the write, which orders all memory accesses 
before(or at) the write with all accesses after the write.

That would be done by adding

      [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]

to ppo.


One could also split it into two rules to keep with the "two full 
fences" analogy. Maybe a good way would be like this:

      [M] ; po; [RMW_MB & R] ; po^? ; [M]

      [M] ; po^?; [RMW_MB & W] ; po ; [M]


Hope that makes sense,

jonas


