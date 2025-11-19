Return-Path: <linux-arch+bounces-14916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D77AEC6F7B2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA0343A7E40
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2052773E6;
	Wed, 19 Nov 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCVzVBzQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqY7n8rR"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5526ED59;
	Wed, 19 Nov 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563415; cv=none; b=TVtNwUfSm37SBIrJy5Gz6EXuL0o+5vuzoHl8zXBHab8MIj99m4XaP41nEygrCNxtyH7Ik89FYlfv2rMHLZsWiJUMbTj2feeAvYHMyNROi/KTXmydysfmgSgx/I0lejv9rz+n0mydeysKDfdHAi5j1dTYa9XoNlEGR0UxHW7/EOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563415; c=relaxed/simple;
	bh=tVO9kV9AwzxvenDeQq8fqTEEg5ilbkzdL5cHN/SIOig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mns19zZ515l/M6fo29FS8IzbmxObS05M6Q27bZvDunzsai94okWnMgQu/cjdkBi38+IutIUHlq/62Fn1Rc7+K3uFx97snt/oLVseWk804FA8TbpbHXzr+DtyfZpenqAcYcZYvLltzrjc7onaSfkbzp77VhFP2oUMN6o5FiWuefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCVzVBzQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqY7n8rR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763563411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ja2pUTuXbJ63M63VaK3IkNS+HRzlmMnwqHhvzRy7/rA=;
	b=aCVzVBzQ3xIYKMfRzJBAQ2zJTq6B/1m6L2/NtZO/OSBmqrBPNEPNnKdMC1cD1SS8Zo0uWv
	0GaJKMQIHQB4qX+GZPPC5bIkg6eSPLvV1q+FZ03uEhCcVeZ2Z194E0Tkbhm5QMdCUtUXJH
	/jxJpIr7avdbNb6cziQzxIeNVglfYOBPm6CR8bA5YOB34ulUIxjE3jhr2dldu8TcO2Mi19
	H1tq/mGyT4qG/vgHbcR2NswkjqLxZgYeOB18DJlR/PCpfvISCdtKdq3WFB0yPGEPmlVg4f
	td3GxaJB89L8iKqtTFytxrGQhx42WPXOKKzewTvWUDUguSa38irqLpp4RsdImA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763563411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ja2pUTuXbJ63M63VaK3IkNS+HRzlmMnwqHhvzRy7/rA=;
	b=AqY7n8rRWOS5OdPI85rS62vJegAPsX9Lsdd8m/b7to0KIT+Ckv2qjFmdExEgkDcM9XABWq
	xRks92AYQkV7AkBw==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com> <87seec78yf.ffs@tglx>
 <87bjl06yij.ffs@tglx>
 <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx>
 <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx>
 <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
 <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com>
Date: Wed, 19 Nov 2025 15:43:29 +0100
Message-ID: <877bvmm6b2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19 2025 at 00:06, Luigi Rizzo wrote:
> On Tue, Nov 18, 2025 at 7:25=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> w=
rote:
>> > That's kinda true for the per interrupt accounting, but if you look at
>> > it from a per CPU accounting perspective then you still can handle them
>> > individually and mask them when they arrive within or trigger a delay
>> > window. That means:
>>
>> ok, so to sum up, what are the correct methods to do the masking
>> you suggest, should i use mask_irq()/unmask_irq() ?
>
> I tried the following instead of disable_irq()/enable_irq().
> This seems to work also for posted_msi with no arch-specific code, as
> you suggested.

:)

> The drain_desc_list() function below should be usable directly with
> hotplug remove callbacks.

Emphasis on *should*.

> I still need to figure out if there is anything special needed when
> an interrupt is removed, or the system goes into suspend,
> while irq_desc's are in the moderation list.

Yes quite some and you forgot to mention affinity changes, interrupt
disable/enable semantics, synchronization, state consistency ...

> /* run this to mask and moderate an interrupt */
> void irq_mod_mask(struct irq_desc *desc)
> {
>         scoped_irqdesc_get_and_buslock(desc->irq_data.irq,
> IRQ_GET_DESC_CHECK_GLOBAL) {

Seriously? Why do you want to look up the descriptor again when you
already have the pointer? Copying random code together does not qualify
as programming.

>                 struct irq_mod_state *ms =3D this_cpu_ptr(&irq_mod_state);
>
>                 /* Add to list of moderated desc on this CPU */
>                 list_add(&desc->mod.ms_node, &ms->descs);
>                 mask_irq(scoped_irqdesc);
>                 ms->mask_irq++;
>                 if (!hrtimer_is_queued(&ms->timer))
>                         irq_moderation_start_timer(ms);
>         }

Assuming you still invoke this from handle_irq_event(), which I think is
the wrong place, then I really have to ask how that is supposed to work
correctly especially with handle_fasteoi_irq(), which is used on
ARM64. Why?

handle_fasteoi_irq()
        ....
        handle_irq_event() {
             ...
             moderation()
                mask();
        }
=20=20=20=20=20=20=20=20
        cond_unmask_eoi_irq()
             unmask();

You need state to prevent that. There is a similar, but more subtle
issue in handle_edge_irq(), which is used on x86.

You got away with this so far due to the disable_irq() abuse and with
your unmask PoC you didn't notice the rare issue on x86, but with
handle_fasteoi_irq() this clearly can't ever work.

> /* run this on the timer callback */
> static int drain_desc_list(struct irq_mod_state *ms)
> {
>         struct irq_desc *desc, *next;
>         uint srcs =3D 0;
>
>         /* Last round, remove from list and unmask_irq(). */
>         list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
>                 list_del_init(&desc->mod.ms_node);
>                 srcs++;
>                 ms->unmask_irq++;
>                 scoped_irqdesc_get_and_buslock(desc->irq_data.irq,
> IRQ_GET_DESC_CHECK_GLOBAL) {
>                         unmask_irq(scoped_irqdesc);

That's broken vs. state changes which occured while the descriptor was
queued. This cannot unconditionally unmask for bloody obvious reasons.

There is also the opposite: Interrupt is moderated, masked, queued and
some management code unmasks. Is that correct while it is still in the
list and marked moderated? It probably is, but only if done right and
clearly documented.

While talking about mask/unmask. You need to ensure that the interrupt
is actually maskable to be elegible for moderation. MSI does not
guarantee that, which is not an issue on ARM64 as that can mask at the
CPU level, but it is an issue on x86 which does not provide such a
mechanism.

You need to understand the intricacies of interrupt handling and
interrupt management first instead of jumping again to "works for me and
should be usable" conclusions.

Now that you know that the mask approach "works", you can stop this
"hack it into submission" frenzy and take a step back and really study
the overall problem space to come up with a proper design and
integration for this.

What you really want is to define the semantics and requirements of this
moderation mechanism versus (no particular order):

    1) The existing semantics of handle_edge_irq() and
       handle_fasteoi_irq(), which need to be guaranteed.

       That's one of the most crucial points because edge type
       interrupts have fire and forget semantics on the device side and
       there is no guarantee that the device will send another one in
       time. People including me wasted tons of time to decode such
       problems in the past.

    2) The existing semantics of disable/enable_irq(), irq_shutdown(),
       synchronize_irq(), which need to be preserved.

    3) Teardown of an interrupt, which also relates to shutdown and
       synchronizing.

    4) Interrupts coming in while in moderated state and "masked". That
       can be spurious interrupts or happen due to unmasking by
       management code, e.g. enable_irq().

    5) CPU hotunplug. Define the exact point where the list has to be
       cleaned out and the timer canceled and it's guaranteed that
       there can't be interrupts added back to the moderation list.

    6) Affinity changes. Are there any implications when the descriptor
       is enqueued on the old target and waiting for the timer to unmask
       it? That assumes that CPU hotunplug related affinity changes are
       not affected because those interrupts are guaranteed not to be
       moderated.

    7) Suspend/resume. That needs some deep analysis of the potential
       state space.

    8) Eligibility beyond edge, single target, etc. That might need
       actual opt-in support from the interrupt chip hierarchy as
       otherwise this is going to end up in a continous stream of
       undecodable bug reports, which others have to deal with :(
       See my remark vs. unmaskable MSI above.

Once you figured all of that out, it becomes pretty clear how the
implementation has to look like and you can start building it up piece
wise by doing the necessary refactoring and preparatory changes first so
that the actual functionality falls into place at the end.

If you start the other way round by glueing the functionality somewhere
into interrupt handling first and then trying to address the resulting
fallout, you'll get nowhere. Trust me that a lot of smart people have
failed that way.

That said, I'm happy to answer _informed_ questions about semantics,
rules and requirements if they are not obvious from the code.

Good luck!

Thanks,

        tglx

