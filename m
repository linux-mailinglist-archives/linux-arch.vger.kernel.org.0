Return-Path: <linux-arch+bounces-12360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A0ADDBF3
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E806A7AC034
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9247B2EBB82;
	Tue, 17 Jun 2025 19:00:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3923C8B3;
	Tue, 17 Jun 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750186855; cv=none; b=o2XXWcpdAsJSlTbrOVwP4QPHYuacX7RbhehboVs4bt7iBcfXR+7JlaTO8AT753EDeOkUXyYNoXLz06yaxMhgxYvXIDt7nFlkZRzeT8ElM+K8AiniuZbp1D7u+SVnKzMCnyiTxz40R6G/w8IfSz2AVonxPYeLpcwv18cS7q96Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750186855; c=relaxed/simple;
	bh=WUqBtBN4algVDh0/7LhKoZcj1pnT1CAk4lKolOpeYck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsX+dK+zUOrnJ16bLktWSKLeJ9Spux9p5Bh4erKTnd9TNX9tQp9njxd9jVt8EB7n5c9oS6U0jvQzFhTLIXHcqrd7qOreM5QBc6n9AtKCdtJD4jFKsSlnPV58s55mDrJISWwW7N1pkQL6qjk8U0MJLYioTh3OfgcSiKlueCOtmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bMGPy2SYNzsS0S;
	Wed, 18 Jun 2025 02:59:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 52C451403D5;
	Wed, 18 Jun 2025 03:00:45 +0800 (CST)
Received: from [10.48.210.222] (unknown [10.48.210.222])
	by APP2 (Coremail) with SMTP id GxC2BwCnEONQu1FouD7hCQ--.7597S2;
	Tue, 17 Jun 2025 20:00:44 +0100 (CET)
Message-ID: <218abf15-b4ed-4d13-9541-aab975bd3835@huaweicloud.com>
Date: Tue, 17 Jun 2025 21:00:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Thomas Haas <t.haas@tu-bs.de>, Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Alan Stern <stern@rowland.harvard.edu>, Andrea Parri
 <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
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
 <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
 <20250617141704.GB19021@willie-the-truck>
 <7a20b873-3c26-4a52-b118-c816ede7298d@tu-bs.de>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <7a20b873-3c26-4a52-b118-c816ede7298d@tu-bs.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCnEONQu1FouD7hCQ--.7597S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw47KFy3Aw18ArWrZFWkWFg_yoW5Cr1DpF
	WrKan8KF4DJF1rGr17tw48XFy5tF1rtFs0qrn8Jr1xAwn09F1Ivr4avF4j9FyUZrs2g34j
	vryjqa43uFyqya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 6/17/2025 4:23 PM, Thomas Haas wrote:
> 
> 
> On 17.06.25 16:17, Will Deacon wrote:
>> On Tue, Jun 17, 2025 at 10:42:04AM +0200, Hernan Ponce de Leon wrote:
>>> On 6/17/2025 8:19 AM, Thomas Haas wrote:
>>>> On 16.06.25 16:23, Will Deacon wrote:
>>>>> I'm half inclined to think that the Arm memory model should be 
>>>>> tightened
>>>>> here; I can raise that with Arm and see what they say.
>>>>>
>>>>> Although the cited paper does give examples of store-forwarding from a
>>>>> narrow store to a wider load, the case in qspinlock is further
>>>>> constrained by having the store come from an atomic rmw and the load
>>>>> having acquire semantics. Setting aside the MSA part, that specific 
>>>>> case
>>>>> _is_ ordered in the Arm memory model (and C++ release sequences 
>>>>> rely on
>>>>> it iirc), so it's fair to say that Arm CPUs don't permit forwarding 
>>>>> from
>>>>> an atomic rmw to an acquire load.
>>>>>
>>>>> Given that, I don't see how this is going to occur in practice.
>>>>
>>>> You are probably right. The ARM model's atomic-ordered-before relation
>>>>
>>>>        let aob = rmw | [range(rmw)]; lrs; [A | Q]
>>>>
>>>> clearly orders the rmw-store with subsequent acquire loads (lrs = 
>>>> local-
>>>> read-successor, A = acquire).
>>>> If we treat this relation (at least the second part) as a "global
>>>> ordering" and extend it by "si" (same-instruction), then the 
>>>> problematic
>>>> reordering under MSA should be gone.
>>>> I quickly ran Dartagnan on the MSA litmus tests with this change to the
>>>> ARM model and all the tests still pass.
>>>
>>> Even with this change I still get violations (both safety and 
>>> termination)
>>> for qspinlock with dartagnan.
>>
>> Please can you be more specific about the problems you see?
> 
> I talked to Hernán personally and it turned out that he used the generic 
> implementation of smp_cond_acquire (not sure if the name is correct) 
> which uses a relaxed load followed by a barrier. In that case, replacing 
> aob by aob;si does not change anything.
> Indeed, even in the reported problem we used the generic implementation 
> (I was unaware of this), though it is easy to check that changing the 
> relaxed load to acquire does not give sufficient orderings.

Yes, my bad. I was using the generic header rather than the aarch64 
specific one and then the changes to the model were having not effect 
(as they should).

Now I am using the aarch64 specific ones and I can confirm dartagnan 
still reports the violations with the current model and making the 
change proposed by Thomas (adding ;si just to the second part seems to 
be enough) indeed removes all violations.

Hernan

> 
>>
>>> I think the problem is actually with the Internal visibility axiom, 
>>> because
>>> only making that one stronger seems to remove the violations.
>>
>> That sounds surprising to me, as there's nothing particularly weird about
>> Arm's coherence requirements when compared to other architectures, as far
>> as I'm aware.
>>
> 
> I agree. The internal visibility axiom is not the issue I think.
> 


