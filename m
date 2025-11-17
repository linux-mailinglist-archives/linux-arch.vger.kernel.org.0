Return-Path: <linux-arch+bounces-14849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E980EC6685B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2149D4E2343
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A472472BA;
	Mon, 17 Nov 2025 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DfRVQw63";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBKG0vem"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E32242D79;
	Mon, 17 Nov 2025 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420729; cv=none; b=m3BqInerAh0s/YHz9oC9ms4jlHfsC7pZUf2KV7RH/l4++h7djHtMEmS6wCAKHodjsMlE0urBbX/yvUWFB9AoVOnAk7NynyDa+JRHskcVCTVMKQonc9VkpDOJUY9KPwJ7n0h2rOTTPzoYuEElm5EzwIyECxVUqskVT/aYqYw3U1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420729; c=relaxed/simple;
	bh=d1pAByr2c7uA7UGeYzGbYMaFOQi0rlSkDn4gC7eXWPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nxOCKRLbbTSjcX7ZE0evAXb4SIyxrHqnjwRkZvBfy4Q/dTTk7rMY5oDiQ2RX+hHjrBerYIbAL0eMpCJxvRpT4KcZBerrB2R7snDVJLl42lrR909f6OUk9zF8QtjsARt/+qtJghqWvXwOBtAr+LkvJSiCLA/tfT6wcglx54HHzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DfRVQw63; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zBKG0vem; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763420725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBAHkNNxbel8Z5fpvZu2O/octSG7Z4z/nQbZXAzCA6w=;
	b=DfRVQw63UXGvFgxo90YuHoZWqaM+7iJbqdNyaGBkK7rMlLMHMwM6aMMBUxk6illG6iFSbr
	5lZFAtmiMNU+4ZsYnn1hA+nMFCfJSwiVb6WjQEU/3AqtGmHXQT2fcN+Ai4Mxnejq2MwODs
	pHqh308dFAkqPhDwl0b5z9XMQYdUDPcn/2ghHvdTtN84NS1HpQ2LcUo8n6Nt9JwX09MAld
	UfkyBcQioymN6wCnwgF6fk4i0WmQFvn4NkOP8lVDpOq4ta79welA4K0ryfVbYPAI50jJxd
	/mXWe6XqsUtLZU4yzIfAmPndf2F6W7MlSytlCQb/3rsm4mUeU5CQOutVePWFNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763420725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBAHkNNxbel8Z5fpvZu2O/octSG7Z4z/nQbZXAzCA6w=;
	b=zBKG0vemNJXHctduE7ky2GxFVcIEHHuoo8TDu/VnItGetcapHe4jk1GwKOm25SeVVZWUqu
	3GnLmkb2f9DLeFAg==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 4/8] genirq: soft_moderation: implement adaptive
 moderation
In-Reply-To: <CAMOZA0KKJ9S45-LnLtYKn-L8dL71tsfs29c6ZL3bkuTcNXorAw@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-5-lrizzo@google.com> <87jyzo757y.ffs@tglx>
 <CAMOZA0KKJ9S45-LnLtYKn-L8dL71tsfs29c6ZL3bkuTcNXorAw@mail.gmail.com>
Date: Tue, 18 Nov 2025 00:05:25 +0100
Message-ID: <87cy5g6z0q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17 2025 at 22:34, Luigi Rizzo wrote:
> On Mon, Nov 17, 2025 at 9:51=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
>> > Add two control parameters (target_irq_rate and hardirq_percent)
>> > to indicate the desired maximum values for these two metrics.
>> >
>> > Every update_ms the hook in handle_irq_event() recomputes the total and
>> > local interrupt rate and the amount of time spent in hardirq, compares
>> > the values with the targets, and adjusts the moderation delay up or do=
wn.
>> >
>> > The interrupt rate is computed in a scalable way by counting interrupts
>> > per-CPU, and aggregating the value in a global variable only every
>> > update_ms. Only CPUs that actively process interrupts are actually
>> > accessing the shared variable, so the system scales well even on very
>> > large servers.
>>
>> You still fail to explain why this is required and why a per CPU
>> moderation is not sufficient and what the benefits of the approach are.
>
> It was explained in the first patch of the series and in Documentation/.

Change logs of a patch have to be self contained whether you like it or
not. I'm not chasing random bits of information accross a series or
cover letter and once a patch is applied it becomes even harder to make
sense of it when the change log contains zero information.

> (First world problem, for sure: I have examples for AMD, Intel, Arm,
> all of them with 100+ CPUs per numa node, and 160-480 CPUs total)
> On some of the above platforms, MSIx interrupts cause heavy serialization
> of all other PCIe requests. As a result, when the total interrupt rate ex=
ceeds
> 1-2M intrs/s, I/O throughput degrades by up to 4x and more.
>=20
> To deal with this with per CPU moderation, without shared state, each CPU
> cannot allow more than some 5Kintrs/s, which means fixed moderation
> should be set at 200us, and adaptive moderation should jump to such
> delays as soon as the local rate reaches 5K intrs/s.
>
> In reality, it is very unlikely that all CPUs are actively handling such =
high
> rates, so if we know better, we can adjust or remove moderation individua=
lly,
> based on actual local and total interrupt rates and number of active CPUs.
>=20
> The purpose of this global mechanism is to figure out whether we are
> approaching a dangerous rate, and do individual tuning.

Makes sense, but I'm not convinced yet that this needs to be as complex
as it is.

>> > +     /* Compare with global and per-CPU targets. */
>> > +     global_rate_high =3D irq_rate > target_rate;
>> > +     my_rate_high =3D my_irq_rate * active_cpus * irq_mod_info.scale_=
cpus > target_rate * 100;
>> > [...]
>> > +     /* Moderate on this CPU only if both global and local rates are =
high. */
>>
>> Because it's desired that CPUs can be starved by interrupts when enough
>> other CPUs only have a very low rate? I'm failing to understand that
>> logic and the comprehensive rationale in the change log does not help ei=
ther.
>
> The comment could be worded better, s/moderate/bump delay up/
>
> The mechanism aims to make total_rate < target, by gently kicking
> individual delays up or down based on the condition
>  total_rate > target && local_rate > target / active_cpus ? bump_up()
> : bump_down()
>
> If the control is effective, the total rate will be within bound and
> nobody suffers,
> neither the CPUs handing <1K intr/s, nor the lonely CPU handling 100K+ in=
tr/s
>
> If suddenly the rates go up, the CPUs with higher rates will be moderated=
 more,
> hopefully converging to a new equilibrium.
> As any control system it has limits on what it can do.

I understand that, but without proper information in code and change log
anyone exposed to this code 6 months down the road will bump his head on
the wall when staring at it (including you).

>> > [...]
>> > +     if (target_rate > 0 && irqrate_high(ms, delta_time, target_rate,=
 steps))
>> > +             below_target =3D false;
>> > +
>> > +     if (hardirq_percent > 0 && hardirq_high(ms, delta_time, hardirq_=
percent))
>> > +             below_target =3D false;
>>
>> So that rate limits a per CPU overload, but only when IRQTIME accounting
>> is enabled. Oh well...
>
> I can add checks to disallow setting the per-CPU overload when IRQTIME
> accounting is not present.

That solves what? It disables the setting, but that does not make the
functionality any different. Also the compiler is smart enough to
eliminate all that code because the return value of hardirq_high() is
constant.

>> > +     } else {
>> > +             /* Exponential grow does not restart if value is too sma=
ll. */
>> > +             if (ms->mod_ns < 500)
>> > +                     ms->mod_ns =3D 500;
>> > +             ms->mod_ns +=3D ms->mod_ns * steps / (steps + irq_mod_in=
fo.grow_factor);
>> > +             if (ms->mod_ns > ms->delay_ns)
>> > +                     ms->mod_ns =3D ms->delay_ns;
>> > +     }
>>
>> Why does this need separate grow and decay factors? Just because more
>> knobs are better?
>
> Like in TCP, brake aggressively (grow factor is smaller) to respond
> quickly to overload,
> and accelerate prudently (decay factor is higher) to avoid reacting
> too optimistically.

Why do I have to ask for all this information piecewise?

Thanks,

        tglx

