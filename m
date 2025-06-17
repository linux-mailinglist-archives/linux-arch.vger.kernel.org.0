Return-Path: <linux-arch+bounces-12354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14122ADC582
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F6F3A3D1E
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097528FFC6;
	Tue, 17 Jun 2025 08:59:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62176026;
	Tue, 17 Jun 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150775; cv=none; b=jDUbpn82mV/ZvyEvnbzuk/Qu8AdIu7OTFq/lms7N0x6iRTxVybsxKarukCqP1bkrNOm6KCaxMxh+8y/Rk3rxD8NVq7KX6tvmuWmGnJSYIAhn3+CHwjycVQJ0LRX9QsiiCqbsGkYxrGYlfUGVkLZhoFgJQ2FunTo3IM/bYcke/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150775; c=relaxed/simple;
	bh=Hm0JqR8yAVMLgjw8eiD3fPtltOfp/U5Geg0Bn6eH+GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxSdgcRyiU1dXSDrs14sbUj8jSb0tzOMqJ166CQNVMXrPlFUuWisL2h1Vh2UHjAvP7fYMrp12rRF6XAQE223xxnbb32WFY/AKTUsQrv0XrMlUCXPQWa80buHajARmNWjkBozeGTUoXxmGyd8S3uFuTZot5ke3+QkMmqAn6POqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bM0hM0GYwz1HBjp;
	Tue, 17 Jun 2025 16:41:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0F0811402ED;
	Tue, 17 Jun 2025 16:42:23 +0800 (CST)
Received: from [10.48.219.48] (unknown [10.48.219.48])
	by APP1 (Coremail) with SMTP id LxC2BwDXW0pgKlFoEWzoCQ--.57902S2;
	Tue, 17 Jun 2025 09:42:22 +0100 (CET)
Message-ID: <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
Date: Tue, 17 Jun 2025 10:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Thomas Haas <t.haas@tu-bs.de>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, jonas.oberhauser@huaweicloud.com,
 "r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <20250616142347.GA17781@willie-the-truck>
 <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXW0pgKlFoEWzoCQ--.57902S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUJw1UJw1rZr45AF47Arb_yoWruFW8pF
	WkKa1UKFZ5AF9Yyw1ktw1vgFyFy3yxJ3Z8Xrn5tFyxArnIyFy2vr4aqr1F9FyUurs7JF10
	vr18t3sxua4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 6/17/2025 8:19 AM, Thomas Haas wrote:
> 
> 
> On 16.06.25 16:23, Will Deacon wrote:
>> On Fri, Jun 13, 2025 at 09:55:01AM +0200, Peter Zijlstra wrote:
>>> On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:
>>>> We have been taking a look if mixed-size accesses (MSA) can affect the
>>>> correctness of qspinlock.
>>>> We are focusing on aarch64 which is the only memory model with MSA 
>>>> support
>>>> [1].
>>>> For this we extended the dartagnan [2] tool to support MSA and now it
>>>> reports liveness, synchronization, and mutex issues.
>>>> Notice that we did something similar in the past for LKMM, but we were
>>>> ignoring MSA [3].
>>>>
>>>> The culprit of all these issues is that atomicity of single load
>>>> instructions is not guaranteed in the presence of smaller-sized stores
>>>> (observed on real hardware according to [1] and Fig. 21/22)
>>>> Consider the following pseudo code:
>>>>
>>>>      int16 old = xchg16_rlx(&lock, 42);
>>>>      int32 l = load32_acq(&lock);
>>>>
>>>> Then the hardware can treat the code as (likely due to store- 
>>>> forwarding)
>>>>
>>>>      int16 old = xchg16_rlx(&lock, 42);
>>>>      int16 l1 = load16_acq(&lock);
>>>>      int16 l2 = load16_acq(&lock + 2); // Assuming byte-precise pointer
>>>> arithmetic
>>>>
>>>> and reorder it to
>>>>
>>>>      int16 l2 = load16_acq(&lock + 2);
>>>>      int16 old = xchg16_rlx(&lock, 42);
>>>>      int16 l1 = load16_acq(&lock);
>>>>
>>>> Now another thread can overwrite "lock" in between the first two 
>>>> accesses so
>>>> that the original l (l1 and l2) ends up containing
>>>> parts of a lock value that is older than what the xchg observed.
>>>
>>> Oops :-(
>>>
>>> (snip the excellent details)
>>>
>>>> ### Solutions
>>>>
>>>> The problematic executions rely on the fact that T2 can move half of 
>>>> its
>>>> load operation (1) to before the xchg_tail (3).
>>>> Preventing this reordering solves all issues. Possible solutions are:
>>>>      - make the xchg_tail full-sized (i.e, also touch lock/pending 
>>>> bits).
>>>>        Note that if the kernel is configured with >= 16k cpus, then 
>>>> the tail
>>>> becomes larger than 16 bits and needs to be encoded in parts of the 
>>>> pending
>>>> byte as well.
>>>>        In this case, the kernel makes a full-sized (32-bit) access 
>>>> for the
>>>> xchg. So the above bugs are only present in the < 16k cpus setting.
>>>
>>> Right, but that is the more expensive option for some.
>>>
>>>>      - make the xchg_tail an acquire operation.
>>>>      - make the xchg_tail a release operation (this is an odd 
>>>> solution by
>>>> itself but works for aarch64 because it preserves REL->ACQ 
>>>> ordering). In
>>>> this case, maybe the preceding "smp_wmb()" can be removed.
>>>
>>> I think I prefer this one, it move a barrier, not really adding
>>> additional overhead. Will?
>>
>> I'm half inclined to think that the Arm memory model should be tightened
>> here; I can raise that with Arm and see what they say.
>>
>> Although the cited paper does give examples of store-forwarding from a
>> narrow store to a wider load, the case in qspinlock is further
>> constrained by having the store come from an atomic rmw and the load
>> having acquire semantics. Setting aside the MSA part, that specific case
>> _is_ ordered in the Arm memory model (and C++ release sequences rely on
>> it iirc), so it's fair to say that Arm CPUs don't permit forwarding from
>> an atomic rmw to an acquire load.
>>
>> Given that, I don't see how this is going to occur in practice.
>>
>> Will
> 
> You are probably right. The ARM model's atomic-ordered-before relation
> 
>       let aob = rmw | [range(rmw)]; lrs; [A | Q]
> 
> clearly orders the rmw-store with subsequent acquire loads (lrs = local- 
> read-successor, A = acquire).
> If we treat this relation (at least the second part) as a "global 
> ordering" and extend it by "si" (same-instruction), then the problematic 
> reordering under MSA should be gone.
> I quickly ran Dartagnan on the MSA litmus tests with this change to the 
> ARM model and all the tests still pass.

Even with this change I still get violations (both safety and 
termination) for qspinlock with dartagnan.

I think the problem is actually with the Internal visibility axiom, 
because only making that one stronger seems to remove the violations.

Hernan

> 
> We should definitely ask ARM about this. I did sent an email to Jade 
> before writing about this issue here, but she was (and still is) busy 
> and told me to ask at memory-model@arm.com .
> I will ask them.
> 
> 


