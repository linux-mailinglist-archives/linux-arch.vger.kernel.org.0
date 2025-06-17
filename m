Return-Path: <linux-arch+bounces-12353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE827ADC243
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 08:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3951716FF
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BBA212B31;
	Tue, 17 Jun 2025 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="VuWaXs7k"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout2.rz.tu-bs.de (pmxout2.rz.tu-bs.de [134.169.4.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39242AF1D;
	Tue, 17 Jun 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141171; cv=none; b=lj2re5yD8ffr0oY1mVw8sc3sbD4mjUDZZBmDyT9bnX9fOW6H3glA2x0DwkziDba3YoH7kRwEfFAfXII5Gu7J/by3cWemRMFS5VBzqtaPRZsT1SwRmfxgYYGcRDX/4PvxtQQBpPedeTyZekIbQWy02OqEbxHdbTZAgxf5+2JyAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141171; c=relaxed/simple;
	bh=VjFkRRhFdHHoBge3xQSHL8uoXr0Xi+waBNVuB3kRpE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KmHLk1aBGREDhX3yEUuawIMbGXGmzDFzf2HFdUmmpKEzUDsoAE792G9y7xb2l3xGtaqmpQkwxP9v2iUIggVftKjcRBNvSoplxqSOTpvdwYtmVqVzEEX1CNaeguGm/lSK92H5zBPKGw1a6vhOjWSHyYCy09y2RyOr2ksQwKqQVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=VuWaXs7k; arc=none smtp.client-ip=134.169.4.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout2.rz.tu-bs.de (Postfix) with ESMTPS id 7FE6A4E02D2;
	Tue, 17 Jun 2025 08:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750141161;
	bh=VjFkRRhFdHHoBge3xQSHL8uoXr0Xi+waBNVuB3kRpE0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=VuWaXs7knl9b9ks04VE2uCnO9fUdz7VrPybO2p77gj9HxFL9Fc4o0TDDdJnF/JXTo
	 xoU7+aNjgc7WhsFv0spPtowo+hp3NP/pidaP4S4ywdpueOZTE4Q+KPZbiQe4HZaGHl
	 iTbAECwWvFOjpwLAJVcFUOzG7jojCGReRxsmDr7hiNAywaMX5wav/Hi3iiLrCdy0Mc
	 VO6H/8nOHFTvJdZBbk2DH8Q1+dLtaQxS2I5Oe2bichPZEd0bD6I0Vmwt10b599nMXY
	 6bPg8gYwxHOgHCzBcvsR7dK6deEzPdcNqRjqvvQtGl3r0GkYXFxts/QVMYGPC52p75
	 X+bny3O4k0kDA==
Received: from [192.168.178.23] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 17 Jun
 2025 08:19:20 +0200
Message-ID: <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
Date: Tue, 17 Jun 2025 08:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri
	<parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin
	<npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave
	<j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E.
 McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel
 Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<lkmm@lists.linux.dev>, <hernan.poncedeleon@huaweicloud.com>,
	<jonas.oberhauser@huaweicloud.com>, "r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <20250616142347.GA17781@willie-the-truck>
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <20250616142347.GA17781@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes07.ad.tu-bs.de (134.169.4.135) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 16.06.25 16:23, Will Deacon wrote:
> On Fri, Jun 13, 2025 at 09:55:01AM +0200, Peter Zijlstra wrote:
>> On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:
>>> We have been taking a look if mixed-size accesses (MSA) can affect the
>>> correctness of qspinlock.
>>> We are focusing on aarch64 which is the only memory model with MSA support
>>> [1].
>>> For this we extended the dartagnan [2] tool to support MSA and now it
>>> reports liveness, synchronization, and mutex issues.
>>> Notice that we did something similar in the past for LKMM, but we were
>>> ignoring MSA [3].
>>>
>>> The culprit of all these issues is that atomicity of single load
>>> instructions is not guaranteed in the presence of smaller-sized stores
>>> (observed on real hardware according to [1] and Fig. 21/22)
>>> Consider the following pseudo code:
>>>
>>>      int16 old = xchg16_rlx(&lock, 42);
>>>      int32 l = load32_acq(&lock);
>>>
>>> Then the hardware can treat the code as (likely due to store-forwarding)
>>>
>>>      int16 old = xchg16_rlx(&lock, 42);
>>>      int16 l1 = load16_acq(&lock);
>>>      int16 l2 = load16_acq(&lock + 2); // Assuming byte-precise pointer
>>> arithmetic
>>>
>>> and reorder it to
>>>
>>>      int16 l2 = load16_acq(&lock + 2);
>>>      int16 old = xchg16_rlx(&lock, 42);
>>>      int16 l1 = load16_acq(&lock);
>>>
>>> Now another thread can overwrite "lock" in between the first two accesses so
>>> that the original l (l1 and l2) ends up containing
>>> parts of a lock value that is older than what the xchg observed.
>>
>> Oops :-(
>>
>> (snip the excellent details)
>>
>>> ### Solutions
>>>
>>> The problematic executions rely on the fact that T2 can move half of its
>>> load operation (1) to before the xchg_tail (3).
>>> Preventing this reordering solves all issues. Possible solutions are:
>>>      - make the xchg_tail full-sized (i.e, also touch lock/pending bits).
>>>        Note that if the kernel is configured with >= 16k cpus, then the tail
>>> becomes larger than 16 bits and needs to be encoded in parts of the pending
>>> byte as well.
>>>        In this case, the kernel makes a full-sized (32-bit) access for the
>>> xchg. So the above bugs are only present in the < 16k cpus setting.
>>
>> Right, but that is the more expensive option for some.
>>
>>>      - make the xchg_tail an acquire operation.
>>>      - make the xchg_tail a release operation (this is an odd solution by
>>> itself but works for aarch64 because it preserves REL->ACQ ordering). In
>>> this case, maybe the preceding "smp_wmb()" can be removed.
>>
>> I think I prefer this one, it move a barrier, not really adding
>> additional overhead. Will?
> 
> I'm half inclined to think that the Arm memory model should be tightened
> here; I can raise that with Arm and see what they say.
> 
> Although the cited paper does give examples of store-forwarding from a
> narrow store to a wider load, the case in qspinlock is further
> constrained by having the store come from an atomic rmw and the load
> having acquire semantics. Setting aside the MSA part, that specific case
> _is_ ordered in the Arm memory model (and C++ release sequences rely on
> it iirc), so it's fair to say that Arm CPUs don't permit forwarding from
> an atomic rmw to an acquire load.
> 
> Given that, I don't see how this is going to occur in practice.
> 
> Will

You are probably right. The ARM model's atomic-ordered-before relation

      let aob = rmw | [range(rmw)]; lrs; [A | Q]

clearly orders the rmw-store with subsequent acquire loads (lrs = 
local-read-successor, A = acquire).
If we treat this relation (at least the second part) as a "global 
ordering" and extend it by "si" (same-instruction), then the problematic 
reordering under MSA should be gone.
I quickly ran Dartagnan on the MSA litmus tests with this change to the 
ARM model and all the tests still pass.

We should definitely ask ARM about this. I did sent an email to Jade 
before writing about this issue here, but she was (and still is) busy 
and told me to ask at memory-model@arm.com .
I will ask them.


-- 
=====================================

Thomas Haas

Technische Universität Braunschweig
Institut für Theoretische Informatik
Mühlenpfordtstr. 23, Raum IZ 343
38106 Braunschweig | Germany

t.haas@tu-braunschweig.de
https://www.tu-braunschweig.de/tcs/team/thomas-haas


