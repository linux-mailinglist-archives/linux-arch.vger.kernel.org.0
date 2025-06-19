Return-Path: <linux-arch+bounces-12409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B96AE0CE7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7D816A271
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1A241C89;
	Thu, 19 Jun 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="o/xAKfJ/"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout1.rz.tu-bs.de (pmxout1.rz.tu-bs.de [134.169.4.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957030E85E;
	Thu, 19 Jun 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357321; cv=none; b=kLW0fElX96Cykqy7Q5y1cr4whOBeFkjIOIo4XWT8/DRpvnvTWeItri8C/Rn+/OHkoPjcF1q8aSeYht6Cq0gxjAGpeqVY0AtXY62zYV75tZlqiLHJS/D0vt93tmrr168nC8ftwqtMwe2qtZ0o2mpJo6Ap/p5U5rx40zbG5hRgmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357321; c=relaxed/simple;
	bh=CkNoFT5ffgvUGTHoy9QzeulxFQ+RkKqe2v/CRKEUFy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uHikV9IDKu++jNEDsk60ER2XzwLJ/QW9b7bv6jKTjIjUJ/UxZ3UjC0MU0KOCshKp+jPBxm+8C1zUxVLPVPox7GN/0Zi0bd3tjvWS0HFJo3Zv3JCnX0t43Z2mW//ne5rSc1Q7SPy6MdGTFrKPY2EyR/bUg34KsmTyEP3Y3qLCffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=o/xAKfJ/; arc=none smtp.client-ip=134.169.4.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout1.rz.tu-bs.de (Postfix) with ESMTPS id 24C294E07C4;
	Thu, 19 Jun 2025 20:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750357317;
	bh=CkNoFT5ffgvUGTHoy9QzeulxFQ+RkKqe2v/CRKEUFy8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=o/xAKfJ//VE0Fr/dnumBKDrb5x/N7ISP9f0OUQksx3Fq4OE5mq6Bls0HhCJ3b2K+2
	 4soMApCbSt620DL+ovmwg2j0ugPwJ5ydQkVqWK5lXPr+LbHzAukjbFbnTV3jb34jXR
	 O8Z5+ZY20SGNHsQg9DIxyMULa92S4fC6SaPo12dnOZFTQgqtk41V/UiNzaFVm1WLoR
	 iQu5LRztBuJzkEf9c9u8mh1y2cbVJAI3Lzz/fgSElUB1YbMSw26oecT04HkJeguUx0
	 BYuf0hzz6oIlNadh289J72+G01VjXHmrjoXQp5wy1JAU/x48vgYm5A7yBKNMqJfKVj
	 TUlrQ72xQDoAw==
Received: from [192.168.178.23] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 20:21:56 +0200
Message-ID: <7097cd74-45b5-4092-b96e-b16769fa68f4@tu-bs.de>
Date: Thu, 19 Jun 2025 20:21:50 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Will Deacon <will@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells
	<dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget
	<luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira
 Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>,
	<hernan.poncedeleon@huaweicloud.com>, <jonas.oberhauser@huaweicloud.com>,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea> <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
 <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
 <aFF3NSJD6PBMAYGY@andrea> <595209ed-2074-46da-8f57-be276c2e383b@tu-bs.de>
 <6ac81900-873e-415e-b5b2-96e9f7689468@rowland.harvard.edu>
 <c97665c6-2d8b-49ae-acc5-be5be04f0093@tu-bs.de>
 <a0887a91-468c-43ff-872e-c4c4e23b26dd@rowland.harvard.edu>
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <a0887a91-468c-43ff-872e-c4c4e23b26dd@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Hermes11.ad.tu-bs.de (134.169.4.139) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 19.06.25 19:56, Alan Stern wrote:
> On Thu, Jun 19, 2025 at 04:59:38PM +0200, Thomas Haas wrote:
>>
>>
>> On 19.06.25 16:32, Alan Stern wrote:
>>> On Thu, Jun 19, 2025 at 04:27:56PM +0200, Thomas Haas wrote:
>>>> I support this endeavor, but from the Dartagnan side :).
>>>> We already support MSA in real C/Linux code and so extending our supported
>>>> Litmus fragment to MSA does not sound too hard to me.
>>>> We are just missing a LKMM cat model that supports MSA.
>>>
>>> To me, it doesn't feel all that easy.  I'm not even sure where to start
>>> changing the LKMM.\
>>>
>>> Probably the best way to keep things organized would be to begin with
>>> changes to the informal operational model and then figure out how to
>>> formalize them.  But what changes are needed to the operational model?
>>>
>>> Alan
>>
>> Of course, the difficult part is to get the model right. Maybe I shouldn't
>> have said that we are "just" missing the model :).
>> I'm only saying that we already have some tooling to validate changes to the
>> formal model.
>>
>> I think it makes sense to first play around with the tooling and changes to
>> the formal model to just get a feeling of what can go wrong and what needs
>> to go right. Then it might become more clear on how the informal operational
>> model needs to change.
>>
>> A good starting point might be to lift the existing ARM8 MSA litmus tests to
>> corresponding C/LKMM litmus tests and go from there.
>> If the informal operational model fails to explain them, then it needs to
>> change. This goes only one way though: if ARM permits a behavior then so
>> should LKMM. If ARM does not, then it is not so clear if LKMM should or not.
> 
> Okay, that seems reasonable.
> 
> BTW, I don't want to disagree with what you wrote ... but doesn't your
> last paragraph contradict the paragraph before it?  Is starting with the
> various MSA litmus tests and seeing how the operational model fails to
> explain them not the opposite of first playing around with the tooling
> and changes to the formal model?
> 
> Alan

I would rather see the approaches as complementary.
If you lift ARM tests to LKMM tests, you can use them to reason about 
both the informal operational model and the formal axiomatic model.
I mean, there are going to be litmus tests that show behavior that 
should reasonably be forbidden on all platforms, and trying to adapt the 
formal LKMM to also forbid them seems like a good exercise.
Even if it turns out that the changes are unsound, I think you will end 
up with better understanding, no?

Either way, I'm just suggesting possible ways to start but I myself 
don't have the time (right now) to get this project going.

Thomas

