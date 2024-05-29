Return-Path: <linux-arch+bounces-4603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFCB8D38F8
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7E6284333
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08E156C4D;
	Wed, 29 May 2024 14:18:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDA15699E;
	Wed, 29 May 2024 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992285; cv=none; b=eSwetI9nWjdbq2E8ewyPu3q0AZnQPSnA/r87HRy03eAuObTwiJ4xd7KS1aGOdXLFpwXdMfBYpl0AVwOQj1I3F76RXpzvptamMqhxISonRJsY7+3r1IlHnCIb+P60jPMe7viMYVSmh7hreZY2Z+XXQhJ+kXRuLxfttN0cByi7828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992285; c=relaxed/simple;
	bh=6PIksgA4xVdsgkQ1CqMr62oRdF0wI+oPtaGukJXpTgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdlHDbrv926tlY8+BU2BMN/Ja3Zic2Cd4p+MXytL5r+B1JH3R265do1qhtxMAwIoxcRHvbpXBlvLAj7DJQclugYAJUF9SETMsPJEuys7XPGd6NGmgvxeKH4lZfDA6w0Y+9rTTrJiAyUqdNQIQ8jdjRJECr3NQPvnehHARop4Eug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vq9rg1MHFz9v7Jk;
	Wed, 29 May 2024 21:55:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AE3AA140E31;
	Wed, 29 May 2024 22:17:52 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP2 (Coremail) with SMTP id GxC2BwAnYCQDOVdmC_AiCQ--.56213S2;
	Wed, 29 May 2024 15:17:52 +0100 (CET)
Message-ID: <8c6174c7-a26c-416e-b9b1-2aff2d43dea1@huaweicloud.com>
Date: Wed, 29 May 2024 16:17:36 +0200
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
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <b54575b9-ab29-4bcd-ae7a-6132d1e36195@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAnYCQDOVdmC_AiCQ--.56213S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyxuFykZryrKr4rGrW3ZFb_yoW8uw1fpF
	yS9ay8Krs8Jr40qrWfXryIq3W5ury3ZF1Fg3sayrsIgwnI9r1xJF97uFWqg3W2qrs5Ar15
	JFW2ywn7ta4UtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7
	UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/29/2024 um 4:07 PM schrieb Alan Stern:
> On Wed, May 29, 2024 at 02:37:30PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/28/2024 um 7:58 PM schrieb Boqun Feng:
>>> This may not be trivial. Note that cmpxchg() is an expression (it has a
>>> value), so in .def, we want to define it as an expression. However, the
>>> C-like multiple-statement expression is not supported by herd parser, in
>>> other words we want:
>>>
>>> 	{
>>> 		__fence{mb-successful-rmw};
>>> 		int tmp = __cmpxchg{once}(...);
>>> 		__fence{mb-successful-rmw};
>>> 		tmp;
>>> 	}
>>
>> Oh, you're right. Then probably the rule I was violating is that
>> value-returning macros can not be defined with {} at all.
>>
>> Given herd's other syntactic limitations, perhaps the best way would be to
>> introduce these macros as
>>
>> 	x = cmpxchg(...) {
>> 		__fence{mb-successful-rmw};
>>   		x = __cmpxchg{once}(...);
>>   		__fence{mb-successful-rmw};
>> 	}
>>
>> since I think x = M(...) is the only way we are allowed to use these macros
>> anyways.
> 
> If we did this, how would the .cat file know to ignore the fence events
> when the cmpxchg() fails?  It doesn't look like there's anything to
> connect the two of them.
> 
> Adding the MB tag to the cmpxchg itself seems like the only way forward.
> 
> Alan

Something along these lines:

   Mb = Mb | Mb-successful-rmw & (domain((po\(po;po));rmw) | 
range(rmw;(po\(po;po)))

i.e., using the fact that these mb-successful-rmw fences must appear 
directly next to a possibly failing rmw, and looking for successful rmw 
directly around them.

I suppose we have to distinguish between the before- and after- fences 
though to make it work for cases like

xchg_release();
cmpxchg(); // fails


                 __xchg_release(...); // is an rmw
  		__fence{mb-successful-rmw}; // wrong takes mb semantics
    		x = __cmpxchg{once}(...); // fails
    		__fence{mb-successful-rmw};


So that would leave us with

  	x = cmpxchg(...) {
  		__fence{mb-before-successful-rmw};
    		x = __cmpxchg{once}(...);
    		__fence{mb-after-successful-rmw};
  	}

and in .cat/.bell:

   Mb = Mb | Mb-before-successful-rmw & domain((po\(po;po));rmw) | 
Mb-after-successful-rmw & range(rmw;(po\(po;po)))



Best wishes,
   jonas


