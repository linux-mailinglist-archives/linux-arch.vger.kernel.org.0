Return-Path: <linux-arch+bounces-14838-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58481C65194
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 851A92A020
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9A2C08CB;
	Mon, 17 Nov 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHla6hJf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27E2BEC3A
	for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396233; cv=none; b=LMge5kTKupibJrAJWLQeUkIF5wheR7UQyKoDB/zH4Yi2iPfd1GDPoMXjpReeyhUUGwtSsEJUMpv+6lU2GyiJ77366TuFFfhANMnWqiU3z2ma7RJxVJnoE3b8aZi8hbqZnlnIbVCQWFijLPSiIGmO8IqF2wWzITJONX+g4dIZNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396233; c=relaxed/simple;
	bh=UWQ+omaMZ9nSTBNx+60hKimnXA5mMClLQiCDQwNh7tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A23KuP3yxP5zA4fldFWZznyVaeMkj4zvYFIULh45dXLkFrPZfi7MAmw0eFb1NB/DHRhp1LnwKmGgaP6ewjX19PqiVsyBqR18vlNdvxFdnbUtUzWwDmyGFyXGlilx9yl3Lftf+FiP1L+z/zv7S5MYEsVSmDpd3U7atGAnxYczW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHla6hJf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee243b98caso273241cf.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763396231; x=1764001031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRueqkYVPlFWQeHHTLPL01TtGJ4sbdfecNuaUoxeiW8=;
        b=IHla6hJfO9TedasNb9kHFFfNDO3njcoavr8US9MBDnfHtArPnDKd/wrMwr1vhviIeD
         wu4eg3hMIn3F0YfYU3NQGsxclOOso2dZtSH7ezOouC57b1v5qPfz1zum0ihhC50mjT4Y
         lNo8cOUS7NK0Gv1EKXmVb4RlrY1gKLlCq02/LGkn1TSg7V9u7FxZUJAjT6/utVfouevm
         v9Q11dNo8d5uAhwNSvB+VXcN1qYea3Ky2ZiBTHzDYoV+tNWKqkUW3Nm+0lG8dK3zCk5D
         SVfhQLAlkr7WkcVwquFqvmCwve37HUWl4gVlZgckVLgt4kmGZYakXDpr6xypcdIYVHbl
         5y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763396231; x=1764001031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JRueqkYVPlFWQeHHTLPL01TtGJ4sbdfecNuaUoxeiW8=;
        b=CRi1/V4U0gsMgAENDKmbQQv3v6O0e48GjCrThaCO3iA7OEU7YMzxZd5KTHU766arY+
         1OJ4wBKIngh37p9lPZQhwXh0MV4VhrFF9wEntAx5u5buU0q1LBX/R6XYLSdu2BHW5u+6
         oiqwDrvIN1a7XEvQ/XIqqMF7oMo4GtOq7828pbWjnp5kMQx0lSrtBvTochJIbuYTGFbi
         3p2yMrRy+Rcs4rg8h/Kl3fnMSWvyRDL+Cic38iWbNkVqEx4f60AskHGQjcTOWcz1hMXy
         9+P6xHfg60f+JsCFQuGrS2sGFJO2dKgcXODc5apXCGIGOc2tGxl1LY88OBIYR54l8Fw0
         Xr4w==
X-Forwarded-Encrypted: i=1; AJvYcCURIPe11RH3kEDXx3end3foL1NNUYOwMsirya4W209yoevsnW8dzxFFaWbw27Rp/uYP83nnhQ5tcxdh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ok0welO7GfFycOUQ4YiHDCFHC2W1ohvvxkoqqvpyV1bQhIFW
	JlUXYM58glK5v3ay3ggKzIPWcG8j26UbW6RVNdSzvcsaYiq2SO2eD+bMzSlFzDjmBNEEroe58HO
	bWMCyPELFSdHA3yhcUQ4hy+AMZ6dTdTVMXMUn7Uuq
X-Gm-Gg: ASbGncvsolE5uY8hzSCG6vFV/5muTgJtIXqr4Eyvp3ZOsC5eI61Bhv2inV6c/8vbXlp
	EEvRyIfYKb+TI2gPIR/0Oa7v8zM9Bi2l4QyXxVg4DM/8xM4WUfde62tz34Y3luYt3pRDqaVG4Aw
	vKLOvXfOAsxusUhZwPJI6Pu2G4ooSlGFO+DZUD3Vw/DlcR0bmWC9UPoKr71Ziax62WSCAZ1z6RD
	ElMnIxH6O/Wxi1j2y96PBuWWczeOpKGuARWjk5A9oT1xOzcvgNnabMWOKf53g74HHdRJANLM4Jr
	c40vew==
X-Google-Smtp-Source: AGHT+IH4i1oZry3rlB9l4I6EFCgFE2BkJ+R7jQp/AXxivVep68MQEbr1j0Mf9IQ8Y7FVIqV7/uWcNTAQGciiFDS52jM=
X-Received: by 2002:a05:622a:3cc:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4ee2fd83e21mr226201cf.1.1763396230304; Mon, 17 Nov 2025
 08:17:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-3-lrizzo@google.com>
 <87wm3o7imp.ffs@tglx>
In-Reply-To: <87wm3o7imp.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 17 Nov 2025 17:16:32 +0100
X-Gm-Features: AWmQ_bkBIg6tck_1LHHqIwNNfqkqjo3Y61fPoAWRwxGCh6tPRLAcX4ZQqDEp4zo
Message-ID: <CAMOZA0JwGT946kAZYq_s3W6LQxwKAAqOGgtCWOYzomEZu4uYcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:01=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> > +/* Handlers for /proc/irq/NN/soft_moderation */
> > +static int mode_show(struct seq_file *p, void *v)
> > +{
> > +     struct irq_desc *desc =3D p->private;
> > +
> > +     if (!desc)
> > +             return -ENOENT;
> > +
> > +     seq_printf(p, "%s irq %u trigger 0x%x %s %smanaged %slazy handle_=
irq %pB\n",
> > +                desc->mod.enable ? "on" : "off", desc->irq_data.irq,
> > +                irqd_get_trigger_type(&desc->irq_data),
> > +                irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge"=
,
> > +                irqd_affinity_is_managed(&desc->irq_data) ? "" : "un",
> > +                irq_settings_disable_unlazy(desc) ? "un" : "", desc->h=
andle_irq
>
> Why are you exposing randomly picked information here? The only thing
> what's interesting is whether the interrupt is moderated or not. The
> interrupt number is redundant information. And all the other internal
> details are available in debugfs already.

ah, sorry, forgot to clean up this internal debugging code.
The previous version had only the enable.

>
> >
> > +static int __init init_irq_moderation(void)
> > +{
> > +     uint *cur;
> > +
> > +     on_each_cpu(irq_moderation_percpu_init, NULL, 1);
>
> That's pointless. Register the hotplug callback without 'nocalls' and
> let the hotplug code handle it.

Sounds good. I have a question on event ordering.
Which event should I use to make sure the callback runs
before interrupts are enabled on the new CPU ?

> > ...
> I asked you last time already to follow the TIP tree documentation, no?
>
> > +     uint target_irq_rate;
> > +     uint hardirq_percent;
> > +     uint timer_rounds;
> > +     uint update_ms;
> > +     uint scale_cpus;
> > +     uint count_timer_calls;
> > +     uint count_msi_calls;
> > +     uint decay_factor;
> > +     uint grow_factor;
> > +     uint pad[];
> > +};
>
> And again you decided to add these fat data structures all in once with
> no usage. I told you last time that this is unreviewable and that stuff
> should be introduced gradually with the usage.

Ok, will do.
FWIW my goal was to get the telemetry functions in the first patch, and red=
uce
the clutter in subsequent patches, since each new field would create many
chunks (docstring, struct field, init, print format and value).

cheers
luigi

