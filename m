Return-Path: <linux-arch+bounces-12397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDBAE085B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91531898B07
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A8270540;
	Thu, 19 Jun 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="utPMWO8Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750B12B71;
	Thu, 19 Jun 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342318; cv=none; b=QdyCkWiMLrarealogYFGHSSv9voo1fGHpOgE09v06H/lWDH96SOVcMSxzQGv+ZH/T0s3WcbdC2pfXAU4V8zK/euQJteNZF2kySVKI/NEYnJJwuWjswU4o9Wq2WGvZjt6IUcJr/A9+VsUOrEG5EI2oO8zncg3WNOA1r5WF7WZ38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342318; c=relaxed/simple;
	bh=zCma/gRPIMLt+XVB+7kRGb+XYSlg8VU0E2H6lP0O2XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ckUYXJIwIxUUP0Vgg8Q0KMQtZi23mJzL4r0AIfSkwheZBQU41JEZWTHauRRAh1gKkcOzuQfrGScYVjrqlEB3LbjufZpGcYydGjIIdEIUMGxtt6k2KryF3DaBLd1VGD2G1YiBnKWksW/0fmHEgQm5KbZSESYgMrKHiX/iNLXZZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=utPMWO8Q; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id 84CD54E03C0;
	Thu, 19 Jun 2025 16:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750342308;
	bh=zCma/gRPIMLt+XVB+7kRGb+XYSlg8VU0E2H6lP0O2XA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=utPMWO8QIb/5ke1hbQe86v68uu3w0Culmu9Vi+daQoq1vzmFasF6Ue4WkRuk30bkJ
	 ZAYJhSWHuEivRjNulvbgNHteaqsEM6WGxWopycthwVJ+cElpeXRtQbLJfqq3f32y/p
	 ESz1pTB2ysmFhACgFOsBILNqFueotsY95ecp3aaaQxTQnrW4ejkDtvKPlDe91NQ3/p
	 Y5vbLkDOLv/FUT0d4Ws1SI4ocoqNn/b7idFYyfWfGrl2u//o911hWJudQNBPHqliAS
	 Yf2IuGf7rpH1wISfWgLFannQ4bYgxd33MaJHGbRTF6KHfcUPdG87R9H3QwxmC8e9X5
	 yVGAS6ev1zH5w==
Received: from [192.168.178.23] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 16:11:47 +0200
Message-ID: <5e84e9fa-38a9-45fd-a67c-2db399860480@tu-bs.de>
Date: Thu, 19 Jun 2025 16:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Will Deacon <will@kernel.org>, Hernan Ponce de Leon
	<hernan.poncedeleon@huaweicloud.com>
CC: Peter Zijlstra <peterz@infradead.org>, Alan Stern
	<stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David
 Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc
 Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>,
	<jonas.oberhauser@huaweicloud.com>, "r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <20250616142347.GA17781@willie-the-truck>
 <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
 <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
 <20250617141704.GB19021@willie-the-truck>
 <7a20b873-3c26-4a52-b118-c816ede7298d@tu-bs.de>
 <218abf15-b4ed-4d13-9541-aab975bd3835@huaweicloud.com>
 <20250619123002.GC21372@willie-the-truck>
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <20250619123002.GC21372@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes04.ad.tu-bs.de (134.169.4.132) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 19.06.25 14:30, Will Deacon wrote:
> On Tue, Jun 17, 2025 at 09:00:30PM +0200, Hernan Ponce de Leon wrote:
>> On 6/17/2025 4:23 PM, Thomas Haas wrote:
>>>
>>>
>>> On 17.06.25 16:17, Will Deacon wrote:
>>>> On Tue, Jun 17, 2025 at 10:42:04AM +0200, Hernan Ponce de Leon wrote:
>>>>> On 6/17/2025 8:19 AM, Thomas Haas wrote:
>>>>>> On 16.06.25 16:23, Will Deacon wrote:
>>>>>>> I'm half inclined to think that the Arm memory model
>>>>>>> should be tightened
>>>>>>> here; I can raise that with Arm and see what they say.
>>>>>>>
>>>>>>> Although the cited paper does give examples of store-forwarding from a
>>>>>>> narrow store to a wider load, the case in qspinlock is further
>>>>>>> constrained by having the store come from an atomic rmw and the load
>>>>>>> having acquire semantics. Setting aside the MSA part,
>>>>>>> that specific case
>>>>>>> _is_ ordered in the Arm memory model (and C++ release
>>>>>>> sequences rely on
>>>>>>> it iirc), so it's fair to say that Arm CPUs don't permit
>>>>>>> forwarding from
>>>>>>> an atomic rmw to an acquire load.
>>>>>>>
>>>>>>> Given that, I don't see how this is going to occur in practice.
>>>>>>
>>>>>> You are probably right. The ARM model's atomic-ordered-before relation
>>>>>>
>>>>>>         let aob = rmw | [range(rmw)]; lrs; [A | Q]
>>>>>>
>>>>>> clearly orders the rmw-store with subsequent acquire loads
>>>>>> (lrs = local-
>>>>>> read-successor, A = acquire).
>>>>>> If we treat this relation (at least the second part) as a "global
>>>>>> ordering" and extend it by "si" (same-instruction), then the
>>>>>> problematic
>>>>>> reordering under MSA should be gone.
>>>>>> I quickly ran Dartagnan on the MSA litmus tests with this change to the
>>>>>> ARM model and all the tests still pass.
>>>>>
>>>>> Even with this change I still get violations (both safety and
>>>>> termination)
>>>>> for qspinlock with dartagnan.
>>>>
>>>> Please can you be more specific about the problems you see?
>>>
>>> I talked to Hernán personally and it turned out that he used the generic
>>> implementation of smp_cond_acquire (not sure if the name is correct)
>>> which uses a relaxed load followed by a barrier. In that case, replacing
>>> aob by aob;si does not change anything.
>>> Indeed, even in the reported problem we used the generic implementation
>>> (I was unaware of this), though it is easy to check that changing the
>>> relaxed load to acquire does not give sufficient orderings.
>>
>> Yes, my bad. I was using the generic header rather than the aarch64 specific
>> one and then the changes to the model were having not effect (as they
>> should).
>>
>> Now I am using the aarch64 specific ones and I can confirm dartagnan still
>> reports the violations with the current model and making the change proposed
>> by Thomas (adding ;si just to the second part seems to be enough) indeed
>> removes all violations.
> 
> That's great! Thanks for working together to get to the bottom of it. I
> was worried that this was the tip of the iceberg.
> 
> I'll try to follow-up with Arm to see if that ';si' addition is an
> acceptable to atomic-ordered before. If not, we'll absorb the smp_wmb()
> into xchg_release() with a fat comment about RCsc and mixed-size
> accesses.
> 
> Will

I have already contacted ARM, but I think it will take some time to get 
an answer.
Interestingly, the definition of aob has changed in a newer version of 
the ARM cat model:

      let aob = [Exp & M]; rmw; [Exp & M]
          | [Exp & M]; rmw; lrs; [A | Q]
          | [Imp & TTD & R]; rmw; [HU]

Ignoring all the extra Exp/Imp/TTD stuff, you can see that the second 
part of the definition only orders the load-part of the rmw with the 
following acquire load. This suggests that a form of store forwarding 
might indeed be expected, seeing that they deliberately removed the 
rmw_store-acq_load ordering they had previously.
Nevertheless, for qspinlock to work we just need the rmw_load-acq_load 
ordering that is still provided as long as we extend it with ";si".

-- 
=====================================

Thomas Haas

Technische Universität Braunschweig
Institut für Theoretische Informatik
Mühlenpfordtstr. 23, Raum IZ 343
38106 Braunschweig | Germany

t.haas@tu-braunschweig.de
https://www.tu-braunschweig.de/tcs/team/thomas-haas


