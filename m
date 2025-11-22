Return-Path: <linux-arch+bounces-15055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D5C7D23C
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96C8E343782
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4471C5D59;
	Sat, 22 Nov 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Omtw0ZJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ERX+UbE"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49311D5CE0;
	Sat, 22 Nov 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820510; cv=none; b=Emk5S0Kwk2ArfVFgsLckFa1CFkRw1OlwMC1LxyLpZHVq7NptgSukjIXZbbxwbCFCrOTAMu5eu+E+HWTxmDp1pfAmMpu5D8FzuPTCYuDKCsH220dHuNYIBcWeiB5RjaRk9YCjYclyGxQIOcivzAbmzUpw4/NxQecdXjTj7tYtCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820510; c=relaxed/simple;
	bh=YXOdbgxWn4W++y1mu6gJ77yC67hF2PkUSmrdTuGBZbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4Io3NwEIbmRZH6Zt8nEiht50IA5qoM8zNP+2uVgqnSMwmTyIHvIFgp6pEoX7fe9CVHQYHIWEVzpmNdIiED3MtRYzXn9tJtAT4V0mDyCyomLmILmAavQejU9vIPHCWjr71dP/YTkq2+BrxNSC8z4eTU+LdBQf2p8MSEDWVc+TFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Omtw0ZJL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ERX+UbE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763820506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCwU4qB8Nfo2E9ixCztPGtI3ZsJ1y5E+oakvGmytyio=;
	b=Omtw0ZJLmHm1RwZfs2dud5a4mBHkmTq0gKVDLOO6jyR7dLvRglvKeeKRwWE8vTxIXz3Xvm
	6RTXyfuxAXXrwwD+CLKUq6E7a2CMHq8luK8hxC+rs7isshDbKr+6hBQwxkQvHtWh8bAWLl
	JYaOccXONC7kj1OJcptY2Y1Z2aSsq7drHx61Mn4zKdk/LVRoIioLIUA7pBVaAn/TZeLM5f
	h/+iG+H4pVsqotPLdeHV/eaqy0BHOux0AWk7fh7SO0i7+qsWZY31scf+m+qn38YLYF3zBL
	LanmmFiVdLnXliUx+6d1+v5sLWXJ4MdB6oTAKxjanR/1Zh32JarsIJatmQ8WFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763820506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCwU4qB8Nfo2E9ixCztPGtI3ZsJ1y5E+oakvGmytyio=;
	b=9ERX+UbEvVtGE9O+qsesdlfaQMQk0Ulnqk6NeJPYqITVKNEols5y0YW3dfI2P+abkFk94/
	cS3QeaogodN1tcDA==
To: Luigi Rizzo <lrizzo@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <CAMOZA0L3+ohfgNfDr50-rcNNnssK0q8Snde8FrWnfn8YcWH=Ew@mail.gmail.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com> <87seec78yf.ffs@tglx>
 <87bjl06yij.ffs@tglx>
 <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx>
 <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx>
 <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
 <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com>
 <877bvmm6b2.ffs@tglx>
 <CAMOZA0L3+ohfgNfDr50-rcNNnssK0q8Snde8FrWnfn8YcWH=Ew@mail.gmail.com>
Date: Sat, 22 Nov 2025 15:08:24 +0100
Message-ID: <875xb2jh2f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21 2025 at 11:58, Luigi Rizzo wrote:
> On Wed, Nov 19, 2025 at 3:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> Addressing your bullets above here is the design,
> if you have time let me know what you think,
>
> BASIC MECHANISM
> The basic control mechanism changes interrupt state as follows:
>
> - for moderated interrupts, call __disable_irq(desc) and put the desc
>   in a per-CPU list with IRQD_IRQ_INPROGRESS set.
>   Set the _IRQ_DISABLE_UNLAZY status flag so disable will also
>   mask the interrupt (it works even without that, but experiments
>   with greedy NVME devices show clear benefits).

What sets that flag? If you want to fiddle with it in this moderation
muck behind the scene, no.

With this new scheme where the moderation handling never invokes the
handler after the time is over, you can't actually mask upfront
unconditionally unless there is a clear indication from the underlying
interrupt chain that this works correctly with edge type interrupts.

It only works when it is guaranteed that the interrupt chip which
actually provides the masking functionality will latch an interrupt
raised in the device and then raise it down the chain when unmasked.

PCIe mandates that behaviour for MSI-X and maskable MSI, but it's not
guaranteed for other device types. And out of painful experience it's
not even true for some broken PCIe devices.

>   NOTE: we need to patch irq_can_handle_pm() so it will return false
>   on irqdesc that are in a moderation list, otherwise we have
>   a deadlock when an interrupt (generated before the mask) comes in.

I told you that you need state :)

> - when the moderation timer fires, remove the irqdesc from the list,
>   clear IRQD_IRQ_INPROGRESS and call __enable_irq(desc).
>
> RATIONALE:
> - why disable/enable instead of mask/unmask:
>   disable/enable already supports call from different layers
>   (infrastructure and interrupt handlers), blocks stray interrupts,
>   and reissues pending events on enable. If I were to use mask/unmask
>   directly, I would have to replicate most of the disable logic and risk
>   introducing subtle bugs.

It's not that much to replicate, but fair enough as long as it happens
under the lock when entering the handler.=20

>   Setting _IRQ_DISABLE_UNLAZY makes the mask immediate, which based on
>   tests (greedy NVME devices) seems beneficial.

See above. What you really want is:

    1) An indicator in the irq chip which tells that the above
       requirement of raising a pending interrupt on unmask is
       "guaranteed" :)

    2) A dedicated variant of __disable_irq() which invokes
       __irq_disable() with the following twist

       disable_moderated_irq(desc)
          force =3D !irqd_irq_masked(..) && irq_moderate_unlazy(desc[chip]);
          if (!desc->disable++ || force)
          	irq_disable_moderated(desc, force)
                    force |=3D irq_settings_disable_unlazy(desc);
                    __irq_disable(desc, force);

That requires to have a new MODERATE_UNLAZY flag, which can be set by
infrastructure, e.g. the PCI/MSI core as that knows whether the
underlying device MSI implementation provides masking. That should be
probably a feature in the interrupt chip.

That needs a command line option to prevent MODERATE_UNLAZY from being
effective.

That preserves the lazy masking behaviour for non-moderated situations,
which is not only a correctness measure (see above) but preferred even
for correctly working hardware because it avoids going out to the
hardware (e.g. writing to PCI config space twice) in many cases.

Though all of this wants to be a separate step _after_ the initial
functionality has been worked out and stabilized. It's really an
optimization on top of the base functionality and we are not going to
optimize prematurely.

> - why IRQD_IRQ_INPROGRESS instead of using another flag:
>   IRQD_IRQ_INPROGRESS seems the way to implement synchronization with
>   infrastructure events (shutdown etc.). We can argue that when an
>   irqdesc is in the timer list it is not "inprogress" and could be
>   preempted (with huge pain, as it could be on a different CPU),
>   but for practical purposes most of the actions that block on INPROGRESS
>   should also wait for the irqdesc to come off the timer list.

As long as those functions are not polling the bit with interrupts
disabled that's a correct assumption.

> - what about spurious interrupts:
>   there is no way to block a device from sending them one after another,
>   so using the existing protection (don't call the handler if disabled)
>   seems the easiest way to deal with them.

Correct.

> HANDLING OF VARIOUS EVENTS:
>
> INTERRUPT TEARDOWN
>   free_irq() uses synchronize_irq() before proceeding, which waits until
>   IRQD_IRQ_INPROGRESS is clear. This guarantees that a moderated interrupt
>   will not be destroyed while it is on the timer list.

That requires a new variant for __enable_irq() because free_irq() shuts
the interrupt down and __enable_irq() would just start it up again...

> INTERRUPT MIGRATION
>   Migration changes the affinity mask, but it takes effect only when
>   trying to run the handler. That too is prevented by IRQD_IRQ_INPROGRESS
>   being set, so the new CPU will be used only after the interrupt exits
>   the timer list.

How is affinity setting related to trying to run the handler? It steers
the interrupt to a new target CPU so that the next interrupt raised in
the device ends up at the new target.

So if that happens (and the interrupt is not masked) then the handler on
the new target CPU will poll for $DELAY until the other side fires the
timer and clears the bit. That's insane and needs to be prevented by
checking moderated state.

> HOTPLUG
>   During shutdown the system moves timers and reassigns interrupt affinity
>   to a new CPU. The easiest way to guarantee that pending events are
>   handled correctly is to use a per-CPU "moderation_on" flag managed as
>   follows by hotplug callbacks on CPUHP_ONLINE (or nearby)

That can be anywhere in the state machine between ONLINE and ACTIVE.

>   - on setup, set the flag. Only now interrupts can be moderated.
>   - on shutdown, with interrupts disabled, clear the flag thus preventing
>     more interrupts to be moderated on that CPU; process the list of mode=
rated
>     interrupts (as if the timer had fired), and cancel the timer.

Ok.

> SUSPEND
>   The hotplug callbacks are also invoked during deep suspend so that
>   makes it safe.
>
> BOOT PROCESSOR
>   Hotplug callbacks are not invoked for the boot processor. However the
>   boot processor is the last one to go, and since there is no other place
>   to run the timer callbacks, they will be run where they are supposed to.

That's only true for hibernation, aka. suspend to disk, but not for
suspend to RAM/IDLE.

You want to treat all of these scenarios the same and just make sure
that the moderation muck is disabled and nothing hangs on a list
especially not with the INPROGRESS bit set.

Thanks,

        tglx

