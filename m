Return-Path: <linux-arch+bounces-14846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA4C6647A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4B57360988
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09E3254B8;
	Mon, 17 Nov 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X54UrvVd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B582320CA8
	for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415292; cv=none; b=jlInWg5f0+tmnKf5buqM0RSM9+FkGLioKTiZogMajpZvSrS1D62ArXsVF7k2khDvLQxkFJAFW5fEJDjWMn2GzcZEoghSHyZgFqOZBp8/kaEVfiKHRFqAiGyFFH3fnn8lf+biP6ItLKu2DxcorQyoA+0i+WNFHIpCCBdBG6tE780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415292; c=relaxed/simple;
	bh=YMjy/LNnaaMh7hFt6dbv4LTW8Qtd/6fDcchdaGKVQcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI5iNNVGz8gQUvwhtYZVSM3lvH4duNk/eUxVsKs5HLSy3GHn3w/fipgBwWCz8dWMKbde/NjkVWrdkSCfq53p3STCUa0XkWlP4i+xsA+XtLeiT33BpTf3T+FoOTyKP4QN6uzEFxGKH1o9RjteBqVI8u6qoXF8Gdd1yG7f2dLemE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X54UrvVd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4edb8d6e98aso116361cf.0
        for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 13:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763415290; x=1764020090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8dLgGNlVdaAILft+FkrBT1VTzRi8vvFarbx0S6d5Hw=;
        b=X54UrvVdVbCoXmnxC5FfbnXFqg1yFkYYpVvXJ80X3+ifnpE8Lj77jGWRZsaDR18Kp/
         /qHCq6UXaILkDQbpKQbso9nVedNIje7B56jEKvmO6SfWuGLJLBxM5J/vKZptYpQgAjIL
         oqSv3ioOg81OcRylSLLNATupQqvb6HnwdvsYz3CW/fSIYTNYhsm5XHNfssrrXifg5loi
         bpCYr0g12DCwSWSakGxertkfHSNHkSN2GIhEMz/dMIDwvriy6ZKFWWt1FXsy3kOvpQyV
         XlkVbzPtzUyaATCjwchDtiM2hnbgQZvvf8fCgKGIgTO7rJPefbib+mcBVcdHymFW8Rib
         xM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763415290; x=1764020090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8dLgGNlVdaAILft+FkrBT1VTzRi8vvFarbx0S6d5Hw=;
        b=KwV+mYiz2XNbEayxP4TvDMt9XltXEBChnaJ16jxVuMX1CFlPrrMxv1Uwy6aXsphyy0
         o86iwL9vK1apFLOvH0CmTnnE7usfKa4gB6B3EAhSBZO+h1tFYzxHI3sE9arn/Om/nQPL
         Ddp0JQXLMkcdXVxx+rMj+yyAgxvLb+g9DUXSY/A1DRxi/IXm7zFBarYAtYacvgfzmDVV
         4kenKk1UVhm4Gmh+423F0VY4tAd0itLqLz4WTTSJEOnyA5CTEV3TeF0CmkGbWa8krhql
         qLAkdaUOXFAImIOc2JEjqCdTyS+1LcYDThsRgO+l27coIygtKU3I45+8p7FZSBhzAyCd
         rLmA==
X-Forwarded-Encrypted: i=1; AJvYcCVscafSFAWnms5OgF164atFrGgIusaNEBysfwq9jnRnz8KWbY+a/41w8GavWQ8/O03Xse9JYWtv8NqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05v/p/n8gpqSUuAymEtuQDKcHt1zYc2xVVwO2PPSEoQle6Zy3
	XJc3yO2NlF4JVWxsHQLyIStWDwlUQNRbwCLiQ66lGvcJr+zCU+ItPxLRfFsghiX9kLAT3qzDA+L
	phNJwAKga/6zCZY8PoJ1U/nm5hYZuUVvRK3O+RSc/
X-Gm-Gg: ASbGncvyTZCqZFhoVC9PEaXSTQD5Cp2RMF5hwHWchqCvGtlVEu/gtJNXvL1Rn2krFj0
	HNyNMSVOyEOmD2zdBTGS/MfYjqZSpV6xY9+5ILRSISZfYAV6rreKkgxMHDwNBzAO71zBKl1NVRf
	ZHDGpE6s9ky5Qzhc0EvaOV/Y7YeXgtaWqqOevfzz3Drg4FOtH7BgIqaQKeR7/2k2wczPDdHudmU
	W+0LN1Z/02TfN9oGHjhwzANi6luvkRP6D10P1F3yNbakvdhS1ffmYguO2AG2EbDKEBn5u0=
X-Google-Smtp-Source: AGHT+IFDTGy6j3oXuB0qDi3ryI2JJHRn57qRxE4nv/hZjBg3wkBN4JE2kcIGeFqkPEAK2S3qQMRWfPn6wXw3mCfgt/Q=
X-Received: by 2002:ac8:5fcb:0:b0:4ed:9612:3fab with SMTP id
 d75a77b69052e-4ee3149a03bmr1166741cf.12.1763415289536; Mon, 17 Nov 2025
 13:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-5-lrizzo@google.com>
 <87jyzo757y.ffs@tglx>
In-Reply-To: <87jyzo757y.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 17 Nov 2025 22:34:13 +0100
X-Gm-Features: AWmQ_bkWF4JAIdvkMhMYd5tM-xWu49NMclZrqB0tbRXhbSJ952ws1Zwji4sP0Zg
Message-ID: <CAMOZA0KKJ9S45-LnLtYKn-L8dL71tsfs29c6ZL3bkuTcNXorAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] genirq: soft_moderation: implement adaptive moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:51=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> > Add two control parameters (target_irq_rate and hardirq_percent)
> > to indicate the desired maximum values for these two metrics.
> >
> > Every update_ms the hook in handle_irq_event() recomputes the total and
> > local interrupt rate and the amount of time spent in hardirq, compares
> > the values with the targets, and adjusts the moderation delay up or dow=
n.
> >
> > The interrupt rate is computed in a scalable way by counting interrupts
> > per-CPU, and aggregating the value in a global variable only every
> > update_ms. Only CPUs that actively process interrupts are actually
> > accessing the shared variable, so the system scales well even on very
> > large servers.
>
> You still fail to explain why this is required and why a per CPU
> moderation is not sufficient and what the benefits of the approach are.

It was explained in the first patch of the series and in Documentation/.

(First world problem, for sure: I have examples for AMD, Intel, Arm,
all of them with 100+ CPUs per numa node, and 160-480 CPUs total)
On some of the above platforms, MSIx interrupts cause heavy serialization
of all other PCIe requests. As a result, when the total interrupt rate exce=
eds
1-2M intrs/s, I/O throughput degrades by up to 4x and more.

To deal with this with per CPU moderation, without shared state, each CPU
cannot allow more than some 5Kintrs/s, which means fixed moderation
should be set at 200us, and adaptive moderation should jump to such
delays as soon as the local rate reaches 5K intrs/s.

In reality, it is very unlikely that all CPUs are actively handling such hi=
gh
rates, so if we know better, we can adjust or remove moderation individuall=
y,
based on actual local and total interrupt rates and number of active CPUs.

The purpose of this global mechanism is to figure out whether we are
approaching a dangerous rate, and do individual tuning.

> > +     /* Compare with global and per-CPU targets. */
> > +     global_rate_high =3D irq_rate > target_rate;
> > +     my_rate_high =3D my_irq_rate * active_cpus * irq_mod_info.scale_c=
pus > target_rate * 100;
> > [...]
> > +     /* Moderate on this CPU only if both global and local rates are h=
igh. */
>
> Because it's desired that CPUs can be starved by interrupts when enough
> other CPUs only have a very low rate? I'm failing to understand that
> logic and the comprehensive rationale in the change log does not help eit=
her.

The comment could be worded better, s/moderate/bump delay up/

The mechanism aims to make total_rate < target, by gently kicking
individual delays up or down based on the condition
 total_rate > target && local_rate > target / active_cpus ? bump_up()
: bump_down()

If the control is effective, the total rate will be within bound and
nobody suffers,
neither the CPUs handing <1K intr/s, nor the lonely CPU handling 100K+ intr=
/s

If suddenly the rates go up, the CPUs with higher rates will be moderated m=
ore,
hopefully converging to a new equilibrium.
As any control system it has limits on what it can do.

> > [...]
> > +     if (target_rate > 0 && irqrate_high(ms, delta_time, target_rate, =
steps))
> > +             below_target =3D false;
> > +
> > +     if (hardirq_percent > 0 && hardirq_high(ms, delta_time, hardirq_p=
ercent))
> > +             below_target =3D false;
>
> So that rate limits a per CPU overload, but only when IRQTIME accounting
> is enabled. Oh well...

I can add checks to disallow setting the per-CPU overload when IRQTIME
accounting is not present.

>
> > +     /* Controller: adjust delay with exponential decay/grow. */
> > +     if (below_target) {
> > +             ms->mod_ns -=3D ms->mod_ns * steps / (steps + irq_mod_inf=
o.decay_factor);
> > +             if (ms->mod_ns < 100)
> > +                     ms->mod_ns =3D 0;
>
> These random numbers used to limit things are truly interresting and
> easy to understand - NOT.
>
> > +     } else {
> > +             /* Exponential grow does not restart if value is too smal=
l. */
> > +             if (ms->mod_ns < 500)
> > +                     ms->mod_ns =3D 500;
> > +             ms->mod_ns +=3D ms->mod_ns * steps / (steps + irq_mod_inf=
o.grow_factor);
> > +             if (ms->mod_ns > ms->delay_ns)
> > +                     ms->mod_ns =3D ms->delay_ns;
> > +     }
>
> Why does this need separate grow and decay factors? Just because more
> knobs are better?

Like in TCP, brake aggressively (grow factor is smaller) to respond
quickly to overload,
and accelerate prudently (decay factor is higher) to avoid reacting
too optimistically.

thanks again for the attention
luigi

