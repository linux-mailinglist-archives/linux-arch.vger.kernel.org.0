Return-Path: <linux-arch+bounces-14850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC795C6688E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 00:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F050A354F23
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62B28C84D;
	Mon, 17 Nov 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFPpmYbu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nzrAQIOC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3ED29CE1;
	Mon, 17 Nov 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421384; cv=none; b=HeCYd1zQGAMDobGhUhN7vJTB24lf71JOYBmCEdYypctci3VPP5GQthRaKZFPqVqY8N8Un6TEs4hFcvz4XGE7eRqp5F5v3g8S9C8yXdm1/rN2xZ0eVdJECnovHlPBnEPLUO3OiYx0wNuQ1DxOBPz3bnlOYgEqN4ejyOM9ba88ZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421384; c=relaxed/simple;
	bh=5YllMUfh90gQ3618VUcsSqK3maUmPf48ewVR5GqmXAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPZtzHOYIXbc93uEzLt90LYSLBLBhiayb92El+9k0Mzq8sotzwDzU0JAf7/4mzIPRXn2MnHNrs4yHcJ16vZOCzMwnnwIBJP8Q9CF4GN6QNAhfy4p86PXxqrZuutvawaPDc6ZZaj9yDy4QKj93I+rWIxrhg5/DbdQdSu+2BRMhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFPpmYbu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nzrAQIOC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763421381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx22q8wfrEFdn2j6n17kK2i/b2INcm5TGjKrUAcfZA0=;
	b=cFPpmYbubw9FYzzoxhSn0OHKHXL0ZmeiKwzLK3/QTzjFimcXLjyI+kunjMUrGiVZK6ebNo
	vebp90aPhYLHoD1Mr108rQElsuJofPrUVMt+Cv7WCEUYhQQu2dO1Za1olVzQYCiHunDRTf
	Ib+Y4BeI9SGH/TstJjuwzXOKJNoDBNlE+9jcyQw0T+kfIc7obx32Aiwlu0UOXGGo+cu0nO
	dJmnVpjgwN0nT3hoSns8D1yY/jaE9/24p7VgybKqh+Ki8QMFAzc16BaVJZ5DdzUa6ul5YY
	Hqx/uavMVEyzZFPiGDcLMEntKBtOuzOB6kxEMRXJa9etcM9oSn2AIh4Bxxad2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763421381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx22q8wfrEFdn2j6n17kK2i/b2INcm5TGjKrUAcfZA0=;
	b=nzrAQIOCSMyiu0eQ840MMWQ2sq/wjjpGHTCZPRIokYD7aUtNynBBp8U/swpuUfe+AkPVzB
	02rvFbKYR9ptrqDA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <87seec78yf.ffs@tglx>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com> <87seec78yf.ffs@tglx>
Date: Tue, 18 Nov 2025 00:16:20 +0100
Message-ID: <87bjl06yij.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17 2025 at 20:30, Thomas Gleixner wrote:
> On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
>> +	ms->rounds_left--;
>> +
>> +	if (ms->rounds_left > 0) {
>> +		/* Timer still alive, just call the handlers. */
>> +		list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
>> +			ms->irq_count += irq_mod_info.count_timer_calls;

I missed this gem before. How is this supposed to calculate an interrupt
rate when count_timer_calls is disabled?

Yet another magic knob to tweak something which works by chance and not
by design.

TBH. This whole thing should be put into the 'ugly code museum' for
educational purposes and deterrence. It wants to be rewritten from
scratch with a proper design and a structured understandable approach.

This polish the Google PoC hackery to death will go nowhere. It's just a
ginormous waste of time. Not that I care about the time you waste with
that, but I pretty much care about mine.

That said, start over from scratch and take the feedback into account so
you can address the substantial problems I pointed out (CPU hotplug,
concurrency, life time management, state consistency, affinity changes)
in the design and not after the fact.

First of all please find some other wording than moderation. That's just
a randomly diced word without real meaning. Pick something which
describes what this infrastructure actually does: Adaptive polling, no?

There are a couple of other fundamental questions to answer upfront:

   1) Is this throttle everything on a CPU the proper approach?

      To me this does not make sense. The CPU hogging network adapter or
      disk drive has no business to delay low frequency interrupts,
      which might be important, just because.

      Making this a per interrupt line property allows to solve a few
      other issues trivially like the integration into that posted MSI
      muck.

      It also reduces the amount of descriptors to be polled in the
      timer interrupt.

   2) Shouldn't the interrupt source be masked at the device level once
      an interrupt is switched into polling mode?

      Masking it at the device level (without touching disabled state)
      is definitely a sensible thing to do. It keeps state consistent
      and again allows trivial integration of that posted MSI stuff
      without insane hacks all over the place.

   3) Does a pure interrupt rate based scheme make sense?

      Definitely not in the way it's implemented. Why?

      Simply because once you switched to polling mode there is no real
      information anymore as you fail to take the return value of the
      handler into account. So unless your magic knob is 0 every polled
      interrupt is accounted for whether it actually handles an
      interrupt or not.

      But if your magic knob is 0 then this purely relies on irqtime
      accounting, which includes the timer interrupt as an accumulative
      measure.

      IOW, "works" by some definition of works after adding enough magic
      knobs to make it "work" under certain circumstances. "Works for
      Google" is not a good argument.

      That's unmaintainable and unusable. No amount of magic command
      line examples will fix that because the state space of your knobs
      is way too big to be useful and comprehensible.

Add all the questions which pop up when you really sit down and do a
proper from scratch design of this.

Thanks,

        tglx



