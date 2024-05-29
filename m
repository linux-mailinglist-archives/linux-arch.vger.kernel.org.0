Return-Path: <linux-arch+bounces-4605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D58D395A
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE47288278
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B015921B;
	Wed, 29 May 2024 14:33:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFA1E878;
	Wed, 29 May 2024 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993234; cv=none; b=gRCiSgMjD0FfQMKVS1wYA+dQ9vmY2keU5g/JwsMxvmhM7yvxoq+bgdZUOFZ9BBg+sEWp9ZkWkC3fW53AX8lxOtNO1EzXqnVuYhDl7PCHtljh4u7qtPfsi2+E0Jhe77bODixzkAi8arsw6s4ESg6/lrbk0rI4nXWF1VHIDa2M1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993234; c=relaxed/simple;
	bh=d7VeRVAQUDCQC8USLPoco6V7FBVHhARO3gOl1CFGDR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jl24PfegZ22oEVhi0NjZPG0Q5IQ/aX9pYRBLd2exdrQtGknKDcrhxMEfIVx1Wysv/drFRQtqlllfUqOFPMteG+pfsk/i1FmpdR+nbpXaHpcY4i6czBBIX+ONtJr42KDkdIqYjGqzkjuAkRwz5hNqLjq3Y5Xgc/XY/rnfFcI8Fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VqBJR2YSzz9v7Hn;
	Wed, 29 May 2024 22:16:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D1BB5140415;
	Wed, 29 May 2024 22:33:37 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rm0PFdmJv0mCQ--.51539S2;
	Wed, 29 May 2024 15:33:37 +0100 (CET)
Message-ID: <118eb48a-cc4a-4708-a826-455f888552b1@huaweicloud.com>
Date: Wed, 29 May 2024 16:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andrea Parri <parri.andrea@gmail.com>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>, will@kernel.org,
 peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
 akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
 <ZlYbXZSLPmjTKtaE@boqun-archlinux>
 <7e2963a3-d471-4593-9170-7f59aa1ce038@huaweicloud.com>
 <b54575b9-ab29-4bcd-ae7a-6132d1e36195@rowland.harvard.edu>
 <8c6174c7-a26c-416e-b9b1-2aff2d43dea1@huaweicloud.com>
 <2e34674c-2443-4345-8bc7-8c950a47f621@rowland.harvard.edu>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <2e34674c-2443-4345-8bc7-8c950a47f621@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwAn0Rm0PFdmJv0mCQ--.51539S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3ury8uFyfJw4DKw4xXrb_yoW8uFWDpr
	ySgayUKrs8Jr40qrWaqr10ga4a9ry7ZF1Fq3sYyrsIqwnI9ry8JrW7urZrW3ZrXrn7Ar15
	XF12y34xX34UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxh
	LUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/29/2024 um 4:24 PM schrieb Alan Stern:
> On Wed, May 29, 2024 at 04:17:36PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/29/2024 um 4:07 PM schrieb Alan Stern:
>>> On Wed, May 29, 2024 at 02:37:30PM +0200, Jonas Oberhauser wrote:
>>>> Given herd's other syntactic limitations, perhaps the best way would be to
>>>> introduce these macros as
>>>>
>>>> 	x = cmpxchg(...) {
>>>> 		__fence{mb-successful-rmw};
>>>>    		x = __cmpxchg{once}(...);
>>>>    		__fence{mb-successful-rmw};
>>>> 	}
>>>>
>>>> since I think x = M(...) is the only way we are allowed to use these macros
>>>> anyways.
>>>
>>> If we did this, how would the .cat file know to ignore the fence events
>>> when the cmpxchg() fails?  It doesn't look like there's anything to
>>> connect the two of them.
>>>
>>> Adding the MB tag to the cmpxchg itself seems like the only way forward.
>>>
>>> Alan
>>
>> Something along these lines:
>>
>>    Mb = Mb | Mb-successful-rmw & (domain((po\(po;po));rmw) |
>> range(rmw;(po\(po;po)))
>>
>> i.e., using the fact that these mb-successful-rmw fences must appear
>> directly next to a possibly failing rmw, and looking for successful rmw
>> directly around them.
>>
>> I suppose we have to distinguish between the before- and after- fences
>> though to make it work for cases like
>>
>> xchg_release();
>> cmpxchg(); // fails
>>
>>
>>                  __xchg_release(...); // is an rmw
>>   		__fence{mb-successful-rmw}; // wrong takes mb semantics
>>     		x = __cmpxchg{once}(...); // fails
>>     		__fence{mb-successful-rmw};
>>
>>
>> So that would leave us with
>>
>>   	x = cmpxchg(...) {
>>   		__fence{mb-before-successful-rmw};
>>     		x = __cmpxchg{once}(...);
>>     		__fence{mb-after-successful-rmw};
>>   	}
>>
>> and in .cat/.bell:
>>
>>    Mb = Mb | Mb-before-successful-rmw & domain((po\(po;po));rmw) |
>> Mb-after-successful-rmw & range(rmw;(po\(po;po)))
> 
> It's messy.  Associating the fences directly with the RMW event(s) by
> adding the MB tags is much cleaner, IMO.

I agree.

> Also, does the syntax you are proposing require changes to herd7?  I'm
> not aware that it is currently able to parse that kind of definition.

Indeed, herd7 can't deal with this syntax right now.

    jonas


