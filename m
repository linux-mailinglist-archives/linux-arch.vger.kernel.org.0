Return-Path: <linux-arch+bounces-4578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD58D368B
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A60281F16
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A714181309;
	Wed, 29 May 2024 12:37:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E617DE23;
	Wed, 29 May 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986272; cv=none; b=ReHoIdLVvgj6nORVRF7H8g73dHsmHia7l/qTafErfdCs2FuTjVT9fkU8nr/juVb+0exENds1ciAd9vEMRjcfZgHbPh+S6FTSTrZUKTi3dMFowKnaF+A3/35y/pDDL1QG1d3VWfhE9fPl9QFWP7JylicfdEbUKMM9nuz/SCuP+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986272; c=relaxed/simple;
	bh=DzoCoeqsQOyFlxix6FVNyo9UNqkoEYBw+OJalTEMaw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aD3vc1DEg4+vNOIDFyDmikR589OXbakHNnDzU8PjnO9Xbpry7ZiW7pd8SFnMXjO44LET+EkKvcCnAw6vQ2/GnJ6+kZq4SWrPIj7vn0pnHuoJhJm6XntciTmSrziiVNr6/yHpCo+R/2MsV0iUPLr84lARPW9mprulxcG9RauXENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Vq7kg46Ddz9v7Hp;
	Wed, 29 May 2024 20:20:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0155F1404F7;
	Wed, 29 May 2024 20:37:47 +0800 (CST)
Received: from [10.206.134.102] (unknown [10.206.134.102])
	by APP1 (Coremail) with SMTP id LxC2BwDHvheOIVdmjaglCQ--.48650S2;
	Wed, 29 May 2024 13:37:46 +0100 (CET)
Message-ID: <7e2963a3-d471-4593-9170-7f59aa1ce038@huaweicloud.com>
Date: Wed, 29 May 2024 14:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
 Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
 stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
 <ZlYbXZSLPmjTKtaE@boqun-archlinux>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <ZlYbXZSLPmjTKtaE@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDHvheOIVdmjaglCQ--.48650S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryrXr4fJw4DKF4fAw48Xrb_yoW8Ar18pF
	WS9ayrKrn8Jr4xJ3y8Kr4Sq3Z0gryFvF1F9wn8Awsa9anI9r1xXFyxCF9093WjvwnIk3Zr
	Aa1qyas7Ga4Dt3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



Am 5/28/2024 um 7:58 PM schrieb Boqun Feng:
> On Mon, May 27, 2024 at 03:40:13PM +0200, Jonas Oberhauser wrote:
>>
>>
>> Am 5/27/2024 um 3:28 PM schrieb Andrea Parri:
>>>>> +    |                smp_store_mb | W[once] ->po F[mb]                        |
>>>>
>>>> I expect this one to be hard-coded in herd7 source code, but I cannot find
>>>> it. Can you give me a pointer?
>>>
>>> smp_store_mb() is currently mapped to { __store{once}(X,V); __fence{mb}; } in
>>> the .def file, so it's semantically equivalent to "WRITE_ONCE(); smp_mb();".
>>
>> By the way, I experimented a little with these kind of mappings to see if we
>> can just explicitly encode the mapping there. E.g., I had an idea to use
>>      { __fence{mb-successful-rmw}; __cmpxchg{once}...;
>> __fence{mb-successful-rmw}; }
>>
>> for defining (almost) the current mapping of cmpxchg explicitly.
>>
>> But none of the changes I made were accepted by herd7.
>>
>> Do you know how the syntax works?
>>
> 
> This may not be trivial. Note that cmpxchg() is an expression (it has a
> value), so in .def, we want to define it as an expression. However, the
> C-like multiple-statement expression is not supported by herd parser, in
> other words we want:
> 
> 	{
> 		__fence{mb-successful-rmw};
> 		int tmp = __cmpxchg{once}(...);
> 		__fence{mb-successful-rmw};
> 		tmp;
> 	}

Oh, you're right. Then probably the rule I was violating is that 
value-returning macros can not be defined with {} at all.

Given herd's other syntactic limitations, perhaps the best way would be 
to introduce these macros as

	x = cmpxchg(...) {
		__fence{mb-successful-rmw};
  		x = __cmpxchg{once}(...);
  		__fence{mb-successful-rmw};
	}

since I think x = M(...) is the only way we are allowed to use these 
macros anyways.


