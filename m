Return-Path: <linux-arch+bounces-14843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27CC65FCB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 20:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C347435AA10
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213330DD32;
	Mon, 17 Nov 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y2qDvwVe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rd0+2gA2"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5456258EDE;
	Mon, 17 Nov 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408130; cv=none; b=KveWFsYY8392Sk2pIpka7DkW8ngs/bTwOaCAD9CyinTdqge+0OmawY2O9VIqyW3RJNNbbyjYyMR9KnpQiHGqEspiTo8xb1EZ4udKwhEhf93jER8j0r35/1Cqs7FSbIBEehIqGvUqToRHJ5ew6F/7onRQvRDDrOqOVhVHwDCcNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408130; c=relaxed/simple;
	bh=32GkMT16TG2LgPjs9jAOdk221xFR43gpJh8Y0+tD26U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqWMN42cfplW2ulPwhL01NMm1Rsh6+ms6JuiAy2AJBWXlm1urhnwz74VNWpPp3vHpxD1yX2rVbGOfSZ/y1VuW941oaXuD0yiMOD9Uwv9Tq+23MqFGLF9NAUVYfiHkFusPdJqMUqcX6aw6RQXmnra8T2M152F3PsjTGPDsoQVgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y2qDvwVe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rd0+2gA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763408126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD58NPcPE/lvvgdhfnkmNFfoQz/0oMK9NpgqhqALY5M=;
	b=Y2qDvwVe+M0ocOgL/AOCmjcon9HWOQqPXDXP1kNE22u8N8YfNFdeGFZ1HOPzZLcm5xZ2/w
	Jxbx4IuG71DEN5jAFI+G5slnLLxGO6y7IO+yFu7nIYa5t4mquvRBlFt8m+9W9xKwEWVzvb
	4wXTMTFb1hYgdFWt5ZU0BzvFWEB5Tik0AiqVVZm2bv4AU6jWOqbyniBg/hdpCJ8Q9bJrix
	Hc9TfoGQzzKCHo5UNs0pojhlnTgTHxYzlmriQtgJl89d0/cevfezfMUKYwg8lqfwoZ8Yzj
	oV9FtSiWp11jJRjSGceUxZHNRg51mn51mQ40Nsq4yhPFvHpXJjnaDRD8vRzdtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763408126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD58NPcPE/lvvgdhfnkmNFfoQz/0oMK9NpgqhqALY5M=;
	b=rd0+2gA2iYVbzy5yACOFVmMiULegXcqcFCmB8deRJTrF7Qydn6Mo3AyBV15RVUuh4hL3uc
	lLF+yGcA7gyD6nBQ==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Willem de
 Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
In-Reply-To: <CAMOZA0JwGT946kAZYq_s3W6LQxwKAAqOGgtCWOYzomEZu4uYcg@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-3-lrizzo@google.com> <87wm3o7imp.ffs@tglx>
 <CAMOZA0JwGT946kAZYq_s3W6LQxwKAAqOGgtCWOYzomEZu4uYcg@mail.gmail.com>
Date: Mon, 17 Nov 2025 20:35:26 +0100
Message-ID: <87pl9g78qp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17 2025 at 17:16, Luigi Rizzo wrote:
> On Mon, Nov 17, 2025 at 5:01=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > +static int __init init_irq_moderation(void)
>> > +{
>> > +     uint *cur;
>> > +
>> > +     on_each_cpu(irq_moderation_percpu_init, NULL, 1);
>>
>> That's pointless. Register the hotplug callback without 'nocalls' and
>> let the hotplug code handle it.
>
> Sounds good. I have a question on event ordering.
> Which event should I use to make sure the callback runs
> before interrupts are enabled on the new CPU ?

See include/linux/cpuhotplug.h

But see my other reply.

>> > ...
>> I asked you last time already to follow the TIP tree documentation, no?
>>
>> > +     uint target_irq_rate;
>> > +     uint hardirq_percent;
>> > +     uint timer_rounds;
>> > +     uint update_ms;
>> > +     uint scale_cpus;
>> > +     uint count_timer_calls;
>> > +     uint count_msi_calls;
>> > +     uint decay_factor;
>> > +     uint grow_factor;
>> > +     uint pad[];
>> > +};
>>
>> And again you decided to add these fat data structures all in once with
>> no usage. I told you last time that this is unreviewable and that stuff
>> should be introduced gradually with the usage.
>
> Ok, will do.
> FWIW my goal was to get the telemetry functions in the first patch, and r=
educe
> the clutter in subsequent patches, since each new field would create many
> chunks (docstring, struct field, init, print format and value).

TBH, I'm not convinced at all that you need all of this telemetry maze.

That looks pretty overengineered and that can be added on top of a
functional and reviewable base implementation.

Thanks,

        tglx



