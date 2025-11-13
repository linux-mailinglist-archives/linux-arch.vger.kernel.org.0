Return-Path: <linux-arch+bounces-14738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD23C5A525
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3CDE4E49A0
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16DE2D6E78;
	Thu, 13 Nov 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sp78x3SJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996B2DC355
	for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073208; cv=none; b=PfyVBStU7JxGM2YqzyFmO+mqOpwBeiMnRaFyEq6+NX9ks0MV4zFEV5xzJPQF5PjyfKHVJJEkL89K+X63oMLxebhUZHydEhq/HkSRuD6mdHXqsE4sZDXHDDHu8xL8CDFeoRCG8gt63pTiz1SkAaUB7TT5kNN5s1OFABnfM8AoKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073208; c=relaxed/simple;
	bh=oGOOGQ4FTUrInwCS8sCPJ2RWZs+eOsahMEG8XQ24wmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6p4dwhz4V9nAENZZyPFv4M+H3HLNPVOzXWijsGvd2KmzyIwQTgBUg/nPcGAY/oCpC1JxPDiQYgNiB5KL2Z1k77O1Utw5QeHnTxuFKCl9R/xFQDzqSOz4o4jHzpzALDFV07pahoN/Ctva3Fxu97lp/5L/fmp/jeUPIH7Eq/wgRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sp78x3SJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed67a143c5so97781cf.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763073205; x=1763678005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhGDcl+sV9DRdre8NBr4bxruYz2NcU1hrjrNodSjngw=;
        b=Sp78x3SJiMg/Hse58OE20iQmIpGGZJz5qk/5YLRbMQVl+kMt09qUkvlXtF1dQLvgA+
         gk8aRrLLE9xVAuy9Qc2N7NZDRbfw3PwGVrKe5aWiPGMbvhxz7uXo0eE2mpO4lzEuipUy
         xdeCOOmHaoGLmYD70P5uf7nbP0B+GFSdJLWIQyBy6wQr2Q/+q0GIjT92YejddbL6a9EW
         c5ykmuvGN4FySdybUsND9GgUbH3oMPXUYiWSRYi+jiqpM6Re7UoNMVsxmt/RRHJb6p2N
         MCR9ttcUjgQlhijSfn3XyT3kAWBrXut8f6PAXKxl0N5b8INEVFpU5eaEkSBke0XUnirm
         x8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073205; x=1763678005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhGDcl+sV9DRdre8NBr4bxruYz2NcU1hrjrNodSjngw=;
        b=YhIFQsNXMcBqcqJtKj5oN13SYk96iU9plfnrgnovmuEl7bAFWeC2tGqI98vnsyiNsl
         Fyl6iSch5d9ybmccGeTBVjDdRfI6yyaoWEemGF9gNn1w/FQALahBYuksoUoUy+nAZX0+
         OhqEKXCFDrM+QiUqj+bSxNie5QHa/tA5aCaKWMbtqkn/B0i+yuUzwhTPCJ56B1Ge7bJr
         AnZ8S6ck6icmilIU5M7AwZt3cVi/kokeht497hVSHbnwP6l7T6NAGLPE3HGOyqBUxeM3
         fhXQMhcDGJ+I1w5+pHOKo4SJqM1vJuu4F+UFZb9aNJ7d8+QE7qLsZNG1FOdOgD1Z/CS3
         8GLA==
X-Forwarded-Encrypted: i=1; AJvYcCXFHTvFPfzlFb0YL4W+7CCU0xdD8Iyly3ZzOURBHMIpzKM7WFjWaEBNgUQUFWJ0+KNH2LPBwTNY0AU9@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzMgtUzoMgIeBhTlQoOUifpokyoFYifyHfJ/4gERSRb/v/nuV
	jYFOphUzUBn2721PxTkTONoZZBoY5VmNrew85+MyYSjcDRKAEgtr4yx8HwmgdLaC/CB1L1KcFO2
	wbnzhpVMfLSUVD7+IQacj6qq/yc+gabM9dYeQ42rx
X-Gm-Gg: ASbGncs5T1mzvyF1zzV8Jn6cLjI6LV5lj8hojX014wJXrsuS8uuA2cqxi/3miYAG8ue
	APF8DvHPu9uuzEdGUOHxODCyW9jf/RQ+7hELNBHe3fStvuQoodQqQsvtoe5tOubx2Jok5b8UD7R
	7F20rl7J9Zx46cpnnyZal/WQgAlxlL3fNfjgm9pfJ1RnT9Go7R6vDvf3pMgNULuYQtWDzqHcnHs
	TVQAL83/ZhqZCEJlTaLSxs90LLen1Si/yMLkwdIgIRfVYVti1u62sfPqtzMjbwb5U+JxtZ4D3IB
	WuQu4Q==
X-Google-Smtp-Source: AGHT+IGplqVUtDlSwwyT2VzVl6pHfwCTTPhgx1rP3QIc7eI8I6vFpvVzOyuraqRaY8WB+XiiLzTj2a0ItMADPMplFzY=
X-Received: by 2002:a05:622a:1650:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4edf47f3b05mr624231cf.9.1763073205068; Thu, 13 Nov 2025
 14:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-3-lrizzo@google.com>
 <87346ie0vs.ffs@tglx>
In-Reply-To: <87346ie0vs.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 23:32:48 +0100
X-Gm-Features: AWmQ_bnese5aeu5W8HBAy0NXfXiGXcLIWWPk0mM1vGSKCp9dS6ylVvCbwF1F2Bk
Message-ID: <CAMOZA0+e8SqEeQTEa-6A7NPoCRMXOLF6xzt45+CRncJfhNDNEg@mail.gmail.com>
Subject: Re: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:29=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> >  [...]

most other comments will be addressed in the next version, but I wanted
to address a few of them here:

> > /sys/module/irq_moderation/parameters and read/write the procfs entries
> > /proc/irq/soft_moderation and /proc/irq/NN/soft_moderation.
> >
> > Examples:
> > cat /proc/irq/soft_moderation
> > echo "delay_us=3D345" > /proc/irq/soft_moderation
> > echo 1 | tee /proc/irq/*/nvme*/../soft_moderation
>
> That's impressive to be able to write into proc/...

That is already the case for /proc/irq/default_smp_affinity and
/proc/irq/NN/smp_affinity[_list] so I followed the same approach.

> > +
> > +/* After the handler, if desc is moderated, make sure the timer is act=
ive. */
> > +static inline void irq_moderation_epilogue(const struct irq_desc *desc=
)
> > +{
> > +     struct irq_mod_state *ms =3D this_cpu_ptr(&irq_mod_state);
>
> Lacks a check whether moderation is enabled or not.

That would be redundant, !list_empty(desc->ms_node) is only true
if moderation is enabled and many other conditions in the previous hook.

> > +             /* Timer still alive. Just call the handlers */
> > +             list_for_each_entry_safe(desc, next, &ms->descs, ms_node)=
 {
> > +                     ms->irq_count +=3D irq_mod_info.count_timer_calls=
;
> > +                     ms->timer_calls++;
> > +                     handle_irq_event_percpu(desc);
>
> That lacks setting the INPROGRESS flag.

I did it in an earlier test version, but was wondering if that is
actually needed.
While the irqdesc is in the timer list, irqd_irq_disabled() is true and tha=
t
makes irq_can_handle_actions() and irq_can_handle() return false.

> > +#pragma clang diagnostic error "-Wformat"
>
> What's that for?

print() formats with a lot of entries are error prone, and the above
catches a lot of trivial mistakes, so I felt it was useful to keep it.

cheers
luigi

