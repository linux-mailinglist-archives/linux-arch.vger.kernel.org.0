Return-Path: <linux-arch+bounces-12398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC1AE08B9
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01E31763F5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9897821C188;
	Thu, 19 Jun 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="L7RWwqut"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout1.rz.tu-bs.de (pmxout1.rz.tu-bs.de [134.169.4.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E81B983F;
	Thu, 19 Jun 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343292; cv=none; b=Pjo+WnznqPjuqUWlyhEsS0fFgucTS113qfmvObmvpik3+9krvX7ULMKMItH79/reZCCCxQ2loR90+6QF715QIsWETLzAIhXF3EEeC2WAB5LUVRLstCcglsFaZ/1jaGR0TJLjLi6UhS5lP4j6douaG75PzyQPxWilBC4acHmEizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343292; c=relaxed/simple;
	bh=LeC7NFKNGz7OIMUFGvR48t8m5EhftSVQqoGOmYxkBuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b6Uy4qP8zBy7zirI8XnFquDiyZ0ZFJpawyIe7RBmXWeSR+/h1LHd2CKcjnjR6wz+YyB1n0KPU8Cp9cpDHIql7QVQzLtHPL30zNHpMJ/z3yXAhuYImgoHuiZznDQDMdjAOisjy3h26skiwtI4dk/lmbrU3sdu1PoNfeWV68Qd5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=L7RWwqut; arc=none smtp.client-ip=134.169.4.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout1.rz.tu-bs.de (Postfix) with ESMTPS id EAD024E0705;
	Thu, 19 Jun 2025 16:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750343282;
	bh=LeC7NFKNGz7OIMUFGvR48t8m5EhftSVQqoGOmYxkBuw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=L7RWwqutttlhkrKfQiRYWMj+PjEOaVUm2agttnHsi0Z8EtXeIV3pew7OYGfISXDcn
	 kct21MpH0WeWxtmjscxu4oX7W0VKxzErv9zL5T7WuJV5mPCqeS901kmvOLiW7exRz8
	 gDrZSai42iN3KSDjy+gm8K7tkMDRfW3zsHJhBEChS6qohhHibmt93ikbMY7fX5b8Vw
	 Hvwfb/Mk9YBYTJAVhSMkjhc6P1ysmGflZK7YioZYE6jkpeZI7R16pUm7drkZL91AGq
	 muoTZsY7gYr+elmJnLXymSKt/QPiJfYGl4mGVXwaRW9d65Q1e/lkfC3n5GM4IlJ5dT
	 wPFU6lEJAzJXA==
Received: from [192.168.178.23] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 16:28:02 +0200
Message-ID: <595209ed-2074-46da-8f57-be276c2e383b@tu-bs.de>
Date: Thu, 19 Jun 2025 16:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Andrea Parri <parri.andrea@gmail.com>, Alan Stern
	<stern@rowland.harvard.edu>
CC: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David
 Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc
 Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>,
	<hernan.poncedeleon@huaweicloud.com>, <jonas.oberhauser@huaweicloud.com>,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <aEwHufdehlQnBX7g@andrea> <9264df13-36db-4b25-b2c4-7a9701df2f4d@tu-bs.de>
 <aE-3_mJPjea62anv@andrea>
 <357b3147-22e0-4081-a9ac-524b65251d62@rowland.harvard.edu>
 <aFF3NSJD6PBMAYGY@andrea>
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <aFF3NSJD6PBMAYGY@andrea>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes03.ad.tu-bs.de (134.169.4.131) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 17.06.25 16:09, Andrea Parri wrote:
>> My question is: Do we have enough general knowledge at this point about
>> how the various types of hardware handle mixed-size accesses to come up
>> with a memory model everyone can agree one?
> 
> You know, I can imagine a conversation along the following line if I
> were to turn this question to certain "hardware people":
> 
>    [Me/LKMM] People, how do you order such and those MSAs?
>     [RTL/DV] What are Linux's uses and requirements?
> 
> that is to say that the work mentioned is probably more "interactive"
> and more dynamic than how your question may suggest.  ;)
> 
> Said this, I do like to think that we (LKMM supporters and followers)
> have enough knowledge to approach that effort.  It would require some
> changes to herd7 (and klitmus7), starting from teaching the tools the
> new MSAs syntax and how to generate rf, co and other basic relations
> (while monitoring potential non-MSA regressions).  Non-trivial maybe,
> but seems doable.  Suffice it to say that herd7 can't currently parse
> the following C test, but it can run its "lowerings"/assembly against
> a bunch of hardware models and implementations, including arm64, x86,
> powerpc and riscv!  Any volunteers with ocaml expertise interested in
> contributing to the LKMM?  ;)
> 
> C C-thomas-haas
> 
> {
> u32 x;
> u16 *x_lh = x; // herd7 dialect for "... = &x;"
> }
> 
> P0(u32 *x)
> {
> 	WRITE_ONCE(*x, 0x10001);
> }
> 
> P1(u16 **x_lh, u32 *x)
> {
> 	u16 r0;
> 	u32 r1;
> 
> 	r0 = xchg_relaxed(*x_lh, 0x2);
> 	r1 = smp_load_acquire(x);
> }
> 
> exists (1:r0=0x1 /\ 1:r1=0x2)

I support this endeavor, but from the Dartagnan side :).
We already support MSA in real C/Linux code and so extending our 
supported Litmus fragment to MSA does not sound too hard to me.
We are just missing a LKMM cat model that supports MSA.

We cannot automatically generate and run tests on real hardware though, 
so the support in herd7 and co. is definitely needed.


-- 
=====================================

Thomas Haas

Technische Universität Braunschweig
Institut für Theoretische Informatik
Mühlenpfordtstr. 23, Raum IZ 343
38106 Braunschweig | Germany

t.haas@tu-braunschweig.de
https://www.tu-braunschweig.de/tcs/team/thomas-haas


