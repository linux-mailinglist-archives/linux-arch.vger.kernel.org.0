Return-Path: <linux-arch+bounces-12358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C955ADD00C
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296103A7614
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09319CD07;
	Tue, 17 Jun 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b="vAlBf45Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from pmxout1.rz.tu-bs.de (pmxout1.rz.tu-bs.de [134.169.4.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CC13B59B;
	Tue, 17 Jun 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.169.4.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170668; cv=none; b=eMYMUTqFOUHsc95244a6qF6Cd94IqYHQCe5zVUF2BPea90O0QErfivWv7BJqJkVbzLV1RE9rBxFqj2I/+cjAKKfOOHpC9v2PZZ6/F5QT5MXDZtP/28bAfGYgNpcbe5ELPFxhVzDpmjxiAEpjyHN4aA83umtgwZAeXXFQ3vPrTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170668; c=relaxed/simple;
	bh=juqQSj/laUBX8o+BD7Z+D+hetaYyMMlkdg3OwrDPg/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B5GV1lmsLIjZjXXkHyCvcxMi+Bkzxv6ZBto4oRkLDmUcfoO2G+2cxsMkxv1gK1oSy/cwUYAP/siq5mj2DpWGDW+5zJGqnfvcWiF/WgMiK5cVua+CpDSa1nK3DWBWbBFmLRGzgJ2fdmaPJys9MLPl4B0xk3wpiQyQpHDQk6d/NR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de; spf=pass smtp.mailfrom=tu-braunschweig.de; dkim=pass (2048-bit key) header.d=tu-bs.de header.i=@tu-bs.de header.b=vAlBf45Q; arc=none smtp.client-ip=134.169.4.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-bs.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-braunschweig.de
Received: from Hermes02.ad.tu-bs.de (hermes02.rz.tu-bs.de [134.169.4.130])
	by pmxout1.rz.tu-bs.de (Postfix) with ESMTPS id 913744E045C;
	Tue, 17 Jun 2025 16:23:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-bs.de;
	s=exchange_neu; t=1750170191;
	bh=juqQSj/laUBX8o+BD7Z+D+hetaYyMMlkdg3OwrDPg/Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=vAlBf45QqpajDkfZR12GetzpNNBG4nKWZVr36RayL04UKqxYZ+oB45SitL6Q5CPgB
	 18U6SYmcvn8lzwo6tcq2DuQvprkDJw+Kq4+mygpRO+Djz8miax+70pj6wRPpLcaJxL
	 latX0ejwoxhjh2/N9d+W/2iTT3O5e8JzI9iTGWHd/O2CvQGmPP8Sqliu7o6xTxpyKP
	 yL5zOHRhUM8AxlwHWv2OxSWyaFveTT9FEkap8mkgEHkf/hW/nkWh3fp3AeYzs71jyM
	 ASwWVpj+yN1c4bprSXXqFE1v5bQy14h1AAjI+NZup3uOwk8W96eMkT2yJQMqh/CG+G
	 5Ehowj0hhgo+A==
Received: from [134.169.39.43] (134.169.9.110) by Hermes02.ad.tu-bs.de
 (134.169.4.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 17 Jun
 2025 16:23:11 +0200
Message-ID: <7a20b873-3c26-4a52-b118-c816ede7298d@tu-bs.de>
Date: Tue, 17 Jun 2025 16:23:11 +0200
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
Content-Language: en-US
From: Thomas Haas <t.haas@tu-bs.de>
In-Reply-To: <20250617141704.GB19021@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Hermes06.ad.tu-bs.de (134.169.4.134) To
 Hermes02.ad.tu-bs.de (134.169.4.130)



On 17.06.25 16:17, Will Deacon wrote:
> On Tue, Jun 17, 2025 at 10:42:04AM +0200, Hernan Ponce de Leon wrote:
>> On 6/17/2025 8:19 AM, Thomas Haas wrote:
>>> On 16.06.25 16:23, Will Deacon wrote:
>>>> I'm half inclined to think that the Arm memory model should be tightened
>>>> here; I can raise that with Arm and see what they say.
>>>>
>>>> Although the cited paper does give examples of store-forwarding from a
>>>> narrow store to a wider load, the case in qspinlock is further
>>>> constrained by having the store come from an atomic rmw and the load
>>>> having acquire semantics. Setting aside the MSA part, that specific case
>>>> _is_ ordered in the Arm memory model (and C++ release sequences rely on
>>>> it iirc), so it's fair to say that Arm CPUs don't permit forwarding from
>>>> an atomic rmw to an acquire load.
>>>>
>>>> Given that, I don't see how this is going to occur in practice.
>>>
>>> You are probably right. The ARM model's atomic-ordered-before relation
>>>
>>>        let aob = rmw | [range(rmw)]; lrs; [A | Q]
>>>
>>> clearly orders the rmw-store with subsequent acquire loads (lrs = local-
>>> read-successor, A = acquire).
>>> If we treat this relation (at least the second part) as a "global
>>> ordering" and extend it by "si" (same-instruction), then the problematic
>>> reordering under MSA should be gone.
>>> I quickly ran Dartagnan on the MSA litmus tests with this change to the
>>> ARM model and all the tests still pass.
>>
>> Even with this change I still get violations (both safety and termination)
>> for qspinlock with dartagnan.
> 
> Please can you be more specific about the problems you see?

I talked to Hernán personally and it turned out that he used the generic 
implementation of smp_cond_acquire (not sure if the name is correct) 
which uses a relaxed load followed by a barrier. In that case, replacing 
aob by aob;si does not change anything.
Indeed, even in the reported problem we used the generic implementation 
(I was unaware of this), though it is easy to check that changing the 
relaxed load to acquire does not give sufficient orderings.

> 
>> I think the problem is actually with the Internal visibility axiom, because
>> only making that one stronger seems to remove the violations.
> 
> That sounds surprising to me, as there's nothing particularly weird about
> Arm's coherence requirements when compared to other architectures, as far
> as I'm aware.
> 

I agree. The internal visibility axiom is not the issue I think.

-- 
=====================================

Thomas Haas

Technische Universität Braunschweig
Institut für Theoretische Informatik
Mühlenpfordtstr. 23, Raum IZ 343
38106 Braunschweig | Germany

t.haas@tu-braunschweig.de
https://www.tu-braunschweig.de/tcs/team/thomas-haas


