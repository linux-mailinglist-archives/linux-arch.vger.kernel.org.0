Return-Path: <linux-arch+bounces-15009-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1DC78974
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D0744E438E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795334253B;
	Fri, 21 Nov 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/n7F89w"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD331DD8A
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722768; cv=none; b=QCqz5R9+Npoj8anfabHXnPzJwPbn2xnFYVvbNORaO0PIlN1G296RFP+a5UXkfkjm1hGpxZG96tQdXvkw48CB8qSBUElN/WGQt/TOxAZNBKnBoR1Ldlug3ExucvCjpuCOGfYp8OEkWVCMZE9LW+n6A7MunsmR+RL8TzNYvTi1t/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722768; c=relaxed/simple;
	bh=x7mxb9+ZtbZUyjZ/IS8MK20mY6I8mZIJ5wXVxz/viEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAozEZ9xAZ2EAxFgNjR1ClbdnYTtm2ZpNssQfOybfV5QVYJHYzwa1F47KlghU7pEfPx1hLGLpfX/iEqkmMwb1/IEgleGebpNWwxq1VOXG+PEE4TeVcXu+Tn4Rk3n/C/d1/ilUpK6VgNuiftDW5xEHcSolXIskF+4+7Hanj0hVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/n7F89w; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed67a143c5so276771cf.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 02:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763722765; x=1764327565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3as/zwL6Z/tKLwDg8ef9gV3qAR4w2mHg/QSKe+6aQPM=;
        b=A/n7F89wA8J26xCO9mqikzF49P1qMajD81m2ijH/+VTz4W+1JtjrBdjJlcxbjocNWS
         VBtsaNy3OCr2p6wLQwMILHnhoTT0BwwgRs0+hOvBtTN+CP71oDDMrdmvtpepv47+p2LP
         1lC685ME8KvjxkHQElhkzyLJbYgeYQbPPUS6JkxvdPF/f0kmN/y/FSd61P7q+oUNuJ30
         LHfm3MoEyc/21cSHHu5hNy9JmgiLuNtqVIFhPSWg+pQ3bevhtq6zFwZS1Y815jFWdm+n
         zx4Mi/ILsRvZOBdYENis9Iz8PpAtoy5qN19NQR0W+04NUPBBvloq6VSzgUZb+ajcu7yq
         M7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722765; x=1764327565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3as/zwL6Z/tKLwDg8ef9gV3qAR4w2mHg/QSKe+6aQPM=;
        b=riLMIM5un0sd4PFXlDw1JS3E469ZrBRUDltEjIYKBhopREUZyRIAztfucr0egiusNU
         G9qXUX7nDO2HP3MCYSmCEblq8pA0mumvFXr2EbM2cmORWfeDY0tHLxDIAOjnnLoNtxO4
         bdKyCycWc6KP4GgcI0q5CInaFyRMce64p71Ygc0kuXOIveHEFVU629UVCMYvn9cec73P
         Koz5scT/JGHYlm2ixzzUaiimgbZuLSfleg1ClVJQE9ncjNnbk0EnAfWhS3wx8byQbR2O
         +QGBILNRWfNQvGpu+VQgkQVLy7mFrWXbHR0PZV6cPXBGZh4THipG9Rl+WHObF2+afRV+
         I4kA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNe04MbPHCDjwqO6P1wGa3B+bYosv/p9oV+dGEFtjU/TAnnAP9lHgnEj67tc4FtkPxeFUuyCtUgBK@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBZh3B/8P9Hp1YJxLlWnWYAIk1YF5EHBc7aScOVBcDRwLcLnq
	sZsUXDkBYiBDWC6EiBUxPMeIwzPLEQmfDi0JZq1z9f+lYYUbBKm8RI38cA1dgsTNSCazy/sFz8f
	2gmTrY36iOexCb+ZCc/DG/FDHKtaopDqj5eYCj8pQ
X-Gm-Gg: ASbGncuTHeTQknqf603xgw7+aWAz88TRnHqTTPCC+X8vlqDseumzeg4Z3ieJOEW1DWf
	qtbPQVSEkRsI7lEw5D0kqw6jlTQcMZDNuIwXZqp+ABO8TuSrnMHw+DW6FbkOJ1ceWBtaV8AKG0O
	Akw6JOjEiiv00NPwRpwOeg36tOaw6fp6K6XS+LFFgFBRkc/n49c0wYtRj1NG3JD0Zg8Gwudc5Ka
	1TjIrxZt5H8JMeohMMy8xwOnrbHtL82ovWWsCQXxMCc4PNwPR/k23qzqqV9j4JBBKrMkCnh
X-Google-Smtp-Source: AGHT+IFqoz0PdegFx77o5Cbkb7zdB4EKmBVSIafDlI+XYBOkjjJ2/Vh8/jJp8UHl+laKuG8FludapTDQWp3scNARbI4=
X-Received: by 2002:a05:622a:1444:b0:4e5:7827:f4b9 with SMTP id
 d75a77b69052e-4ee586c69bfmr3215551cf.3.1763722765259; Fri, 21 Nov 2025
 02:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx> <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx> <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx> <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
 <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com> <877bvmm6b2.ffs@tglx>
In-Reply-To: <877bvmm6b2.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 21 Nov 2025 11:58:49 +0100
X-Gm-Features: AWmQ_blC1WCpoDfGTonFYEeoFgQ2Ff1JVpgDStnQRBuJsy0QFzUoIFm-mwN1dr0
Message-ID: <CAMOZA0L3+ohfgNfDr50-rcNNnssK0q8Snde8FrWnfn8YcWH=Ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 3:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
...
>
> What you really want is to define the semantics and requirements of this
> moderation mechanism versus (no particular order):
>
>     1) The existing semantics of handle_edge_irq() and
>        handle_fasteoi_irq(), which need to be guaranteed.
>
>        That's one of the most crucial points because edge type
>        interrupts have fire and forget semantics on the device side and
>        there is no guarantee that the device will send another one in
>        time. People including me wasted tons of time to decode such
>        problems in the past.
>
>     2) The existing semantics of disable/enable_irq(), irq_shutdown(),
>        synchronize_irq(), which need to be preserved.
>
>     3) Teardown of an interrupt, which also relates to shutdown and
>        synchronizing.
>
>     4) Interrupts coming in while in moderated state and "masked". That
>        can be spurious interrupts or happen due to unmasking by
>        management code, e.g. enable_irq().
>
>     5) CPU hotunplug. Define the exact point where the list has to be
>        cleaned out and the timer canceled and it's guaranteed that
>        there can't be interrupts added back to the moderation list.
>
>     6) Affinity changes. Are there any implications when the descriptor
>        is enqueued on the old target and waiting for the timer to unmask
>        it? That assumes that CPU hotunplug related affinity changes are
>        not affected because those interrupts are guaranteed not to be
>        moderated.
>
>     7) Suspend/resume. That needs some deep analysis of the potential
>        state space.
>
>     8) Eligibility beyond edge, single target, etc. That might need
>        actual opt-in support from the interrupt chip hierarchy as
>        otherwise this is going to end up in a continous stream of
>        undecodable bug reports, which others have to deal with :(
>        See my remark vs. unmaskable MSI above.
>
> Once you figured all of that out, it becomes pretty clear how the
> implementation has to look like and you can start building it up piece
> wise by doing the necessary refactoring and preparatory changes first so
> that the actual functionality falls into place at the end.
>
> If you start the other way round by glueing the functionality somewhere
> into interrupt handling first and then trying to address the resulting
> fallout, you'll get nowhere. Trust me that a lot of smart people have
> failed that way.
>
> That said, I'm happy to answer _informed_ questions about semantics,
> rules and requirements if they are not obvious from the code.

Addressing your bullets above here is the design,
if you have time let me know what you think,

BASIC MECHANISM
The basic control mechanism changes interrupt state as follows:

- for moderated interrupts, call __disable_irq(desc) and put the desc
  in a per-CPU list with IRQD_IRQ_INPROGRESS set.
  Set the _IRQ_DISABLE_UNLAZY status flag so disable will also
  mask the interrupt (it works even without that, but experiments
  with greedy NVME devices show clear benefits).

  NOTE: we need to patch irq_can_handle_pm() so it will return false
  on irqdesc that are in a moderation list, otherwise we have
  a deadlock when an interrupt (generated before the mask) comes in.

- when the moderation timer fires, remove the irqdesc from the list,
  clear IRQD_IRQ_INPROGRESS and call __enable_irq(desc).

RATIONALE:
- why disable/enable instead of mask/unmask:
  disable/enable already supports call from different layers
  (infrastructure and interrupt handlers), blocks stray interrupts,
  and reissues pending events on enable. If I were to use mask/unmask
  directly, I would have to replicate most of the disable logic and risk
  introducing subtle bugs.

  Setting _IRQ_DISABLE_UNLAZY makes the mask immediate, which based on
  tests (greedy NVME devices) seems beneficial.

- why IRQD_IRQ_INPROGRESS instead of using another flag:
  IRQD_IRQ_INPROGRESS seems the way to implement synchronization with
  infrastructure events (shutdown etc.). We can argue that when an
  irqdesc is in the timer list it is not "inprogress" and could be
  preempted (with huge pain, as it could be on a different CPU),
  but for practical purposes most of the actions that block on INPROGRESS
  should also wait for the irqdesc to come off the timer list.

- what about spurious interrupts:
  there is no way to block a device from sending them one after another,
  so using the existing protection (don't call the handler if disabled)
  seems the easiest way to deal with them.

HANDLING OF VARIOUS EVENTS:

INTERRUPT TEARDOWN
  free_irq() uses synchronize_irq() before proceeding, which waits until
  IRQD_IRQ_INPROGRESS is clear. This guarantees that a moderated interrupt
  will not be destroyed while it is on the timer list.

INTERRUPT MIGRATION
  Migration changes the affinity mask, but it takes effect only when
  trying to run the handler. That too is prevented by IRQD_IRQ_INPROGRESS
  being set, so the new CPU will be used only after the interrupt exits
  the timer list.

HOTPLUG
  During shutdown the system moves timers and reassigns interrupt affinity
  to a new CPU. The easiest way to guarantee that pending events are
  handled correctly is to use a per-CPU "moderation_on" flag managed as
  follows by hotplug callbacks on CPUHP_ONLINE (or nearby)

  - on setup, set the flag. Only now interrupts can be moderated.
  - on shutdown, with interrupts disabled, clear the flag thus preventing
    more interrupts to be moderated on that CPU; process the list of modera=
ted
    interrupts (as if the timer had fired), and cancel the timer.

  This avoids depending on a specific state: no moderation before fully
  online, and cleanup before any teardown may interfere with moderation
  timers.


SUSPEND
  The hotplug callbacks are also invoked during deep suspend so that
makes it safe.

BOOT PROCESSOR
  Hotplug callbacks are not invoked for the boot processor. However the
  boot processor is the last one to go, and since there is no other place
  to run the timer callbacks, they will be run where they are supposed to.

---
cheers
luigi

