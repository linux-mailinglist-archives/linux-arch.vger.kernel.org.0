Return-Path: <linux-arch+bounces-4479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515D8CAD76
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83111C20A04
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A6774418;
	Tue, 21 May 2024 11:39:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CC6CDA9;
	Tue, 21 May 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291545; cv=none; b=VxptXXtaBdc5Kd3iiwJFaRtd43lu1O2tDaLJq/9KUpBTPFOk749nyxYZ8UAXtWaIIQEwDOoe8/q3Lsj8+4ThJWG/eQDijmsT3Yz9ZJE2nZ6U5ZJ16woiwF51yczyrw9b05EiRN2zZLSSVnwSFQ0VOY3a4mvzT2IJg5AtDWVmeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291545; c=relaxed/simple;
	bh=ft98+nRHPJzcB/GsG8Q8C5Dfngwk8PZyq+BnLUg8wBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEw2BSrGhAaTsbst5ryXDRUpRKAJqM8QFOF6Rl4gIXRnG9zGY2u4PE1eTg41KgNUGddZEnOclE3Dnhf7APEKqIwK2P3+FlqzIgv/oI78l5RdbRV0YYG2oPWGmtLrcMuM18JrxMPp6MC+C18rcewl0HaWfz/OWj5wFZ62jUq1FC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VkBpg2F7Pz9v7Hp;
	Tue, 21 May 2024 19:21:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 297AC14040F;
	Tue, 21 May 2024 19:38:54 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP2 (Coremail) with SMTP id GxC2BwAXTSHDh0xmSRWWCA--.10494S2;
	Tue, 21 May 2024 12:38:53 +0100 (CET)
Message-ID: <a536d330-a3e9-f747-99d0-0375d7ce9afb@huaweicloud.com>
Date: Tue, 21 May 2024 13:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LKMM: Making RMW barriers explicit
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
 boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 Joel Fernandes <joel@joelfernandes.org>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAXTSHDh0xmSRWWCA--.10494S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDJw1fWr4xKr15KryfWFg_yoWrJw18pr
	s8Ca45Kr4DJr4Duas29anxXFyYgan7trW8Wryktws3A3Z0gF10qrn8tayj9rZrXrs2g3Wj
	vr12qasxZ34kAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 5/18/2024 2:31 AM, Alan Stern wrote:
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

I implemented these changes in herd7 and they seem enough.
I opened a PRs for discussion
	https://github.com/herd/herdtools7/pull/865

> 
> Okay, good.  This answers the first part of what I asked.  What about
> the second part?  That is, how will the changes to the .def, .bell, and
> .cat files achieve your goals?

At least the cat model needs to be updated. If I remove the fences from 
herd7, but keep the current model, these 4 tests fail.

  --- Summary:
  !!! Result changed: 
./litmus/manual/locked/SUW+or-ow+l-ow-or.litmus.out.new
  !!! Result changed: 
./litmus/manual/atomic/C-PaulEMcKenney-SB+adat-o+adat-o.litmus.out.new
  !!! Result changed: ./litmus/manual/atomic/C-atomic-01.litmus.out.new
  !!! Result changed: ./litmus/manual/atomic/C-atomic-02.litmus.out.new

Using this patch I get the correct results

diff --git a/tools/memory-model/linux-kernel.cat 
b/tools/memory-model/linux-kernel.cat
index adf3c4f41229..7e4787cdbd66 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -34,6 +34,12 @@ let R4rmb = R \ Noreturn     (* Reads for which rmb 
works *)
  let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
  let wmb = [W] ; fencerel(Wmb) ; [W]
  let mb = ([M] ; fencerel(Mb) ; [M]) |
+       (* everything across a full barrier RMW is ordered. This 
includes up to one event inside the RMW. *)
+       ([M] ; po ; [RMW & Mb] ; po ; [M]) |
+       (* full barrier RMW writes are ordered with everything behind 
the RMW *)
+       ([W & RMW & Mb] ; po ; [M]) |
+       (* full barrier RMW reads are ordered with everything before the 
RMW *)
+       ([M] ; po ; [R & RMW & Mb]) |
         ([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
         ([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
         ([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |

Hernan

> 
> Alan


