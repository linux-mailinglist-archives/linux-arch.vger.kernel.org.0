Return-Path: <linux-arch+bounces-12401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE2AE09BB
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3041C22CD7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FF219A8E;
	Thu, 19 Jun 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="JK/5IWMS"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719F3085DB;
	Thu, 19 Jun 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345183; cv=none; b=AjrRndjHyPxNh8FcmovwSco94/Wod+VP/zFxaAWwO7AlGTZ87N+XIY5ALJbkC4TJGu9/FYHXgfG9D7jwQdhk9A0FIT9dF4EzUfx7YaVGKyZObRJFIBsdU2r7IvwC7VlJVuL71LVTyZb7ZfPNL5aTe0IafF8fb0M2g8VXyg2r3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345183; c=relaxed/simple;
	bh=jDURoLRKv0+kFosAc+It0hfp7872+Y0cgSAwaCDQUYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hoUAbDoCBjqTAHSKtjF+6qXBJQNebcQR35Gk6Fh26EcamK/z+hivBodbDGxLUtS4r6sWM2ippm2vr61R7DMX/aXh+K/IN5J6XYPHGs2GBVGyvmwioTGMNLX1ZSIv0mkpMME53W77Rp+KxCiHnJ8x302bgu4wv2hKnpN0X65ejfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=JK/5IWMS; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id 0A4994E0975;
	Thu, 19 Jun 2025 16:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750345180;
	bh=jDURoLRKv0+kFosAc+It0hfp7872+Y0cgSAwaCDQUYE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=JK/5IWMSlDEADAFxylGN8xJvRyc9i7Fl8TpLa8aTFQ47/oPOPbRt5Sb3vxNc1OwXP
	 ZCmhdV4bwWFXM6gTR5kDAsh8IPf6oSP3iVbRWzH4IBV4SYGQ6eUP/sfkoMLZUmISz2
	 6ANNwuTVEMhjmRI+awXJu7Jao/9abL9p4MPGPE/Hq4RXQcue1Q6hXXMjkyICFu/71S
	 Q3oBvFkAWbvyNnGwG2PaRIDEx64E8F5UXGzP705/ajkz6yssaOzTHFjyei31jt0ZG/
	 ICR3LaN0EM4q+ow8wc6PdlCqf/Ds6AR1abUmAAnzCjoNQmlvFDYgkitEf64b5ZtlZL
	 O99ckHvMLnYQA==
Received: from [192.168.178.23] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 16:59:39 +0200
Message-ID: <c97665c6-2d8b-49ae-acc5-be5be04f0093@tu-bs.de>
Date: Thu, 19 Jun 2025 16:59:38 +0200
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
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <6ac81900-873e-415e-b5b2-96e9f7689468@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Hermes05.ad.tu-bs.de (134.169.4.133) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 19.06.25 16:32, Alan Stern wrote:
> On Thu, Jun 19, 2025 at 04:27:56PM +0200, Thomas Haas wrote:
>> I support this endeavor, but from the Dartagnan side :).
>> We already support MSA in real C/Linux code and so extending our supported
>> Litmus fragment to MSA does not sound too hard to me.
>> We are just missing a LKMM cat model that supports MSA.
> 
> To me, it doesn't feel all that easy.  I'm not even sure where to start
> changing the LKMM.\
> 
> Probably the best way to keep things organized would be to begin with
> changes to the informal operational model and then figure out how to
> formalize them.  But what changes are needed to the operational model?
> 
> Alan

Of course, the difficult part is to get the model right. Maybe I 
shouldn't have said that we are "just" missing the model :).
I'm only saying that we already have some tooling to validate changes to 
the formal model.

I think it makes sense to first play around with the tooling and changes 
to the formal model to just get a feeling of what can go wrong and what 
needs to go right. Then it might become more clear on how the informal 
operational model needs to change.

A good starting point might be to lift the existing ARM8 MSA litmus 
tests to corresponding C/LKMM litmus tests and go from there.
If the informal operational model fails to explain them, then it needs 
to change. This goes only one way though: if ARM permits a behavior then 
so should LKMM. If ARM does not, then it is not so clear if LKMM should 
or not.

Thomas


