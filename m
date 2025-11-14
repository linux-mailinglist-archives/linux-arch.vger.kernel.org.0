Return-Path: <linux-arch+bounces-14740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B6C5BFA5
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FB634E37D7
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A82FB637;
	Fri, 14 Nov 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amR/yYSS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9926E6E6
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108899; cv=none; b=h1pt6tMt63F5I1f/LC4WPx3+gZcWFxv1ypiN2gznPzdwq8QW5cam4XXZ/dGNI5ZegfPPddC8QFbkcwoS9dfD2178UyHC+C6WepRGWZkYnRgrTKH9s58UXGFUIsjzB2/bbZ744GB+WvvD0JCCJtiENOwRh7lmOpkBKHy6u52G338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108899; c=relaxed/simple;
	bh=KCn4uFukjRiL/0XJqVgN9z6kv9AkhpQT0mpHldHUNck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvAQUHzjnHQFDh+sDTKFxen97MDBMgQxW1dURmcDpyIjqhzwL+laCeIiRsIQTEMPjEk17PLktut1yJlVsxpFNur0gJZoC+1R7jRMcGHmaM1Ucq5ovphN4eQtCHtN0LN2XLAIMXwXbKRfsSAluPLSwEehgjDXZrMk4dcvvJqcVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amR/yYSS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ede12521d4so197321cf.1
        for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 00:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763108897; x=1763713697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bmHT7xtPxAufeSjZNpEjMNtN/PIopHWc4OrXWKr35Y=;
        b=amR/yYSSwCfmLxYR1nSwL2u2pOGU1oir1MneQ7wZnUOumPIspf1U+knOeKyjABnEU0
         DJJXZHjhOkQTsbfxVpbe7QQoipatB2qIBjitLzKZVoqiJorcsXSENSmdHZku44ukEA1T
         d+NOAC7pruu3HQVMz/tSiytK0eN6cAUeOIN0HJgkdwy2zm2tb1Qn/c4viGfZUK7zhrkB
         FNfA60pEvL/g/OmTLftkxjNCYrVzqZ/C+t4OupwKJq+8/eQAnUJ0yrrvbChZXZtdG+kj
         sjX2mSekJGCoC39rf1MghDW0mJwNTprS3h83yWMjc6l4IQlN3sm3iwbzErXWoQB5iGl2
         Y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763108897; x=1763713697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bmHT7xtPxAufeSjZNpEjMNtN/PIopHWc4OrXWKr35Y=;
        b=woYiM/5raz0+/Q8kDvrG/2CiK77pnuAjepxLHXBPvqh7Rq40c0ZmPf3uw5KcfWoyde
         XW0UQNQhzsPc0X/ny9jP5ewZomgpSqAAiub+aL+JVc7DFVrPT07khbadG3ERc17Kjk+4
         7t6bV+8nCa/yFMYIH8+7OXEkNgh8/cwQF4Ek0Qu5MPjmFItJChLWuAzGSQ+CRHKVoQbf
         w6bAR+y4tVj2aFG0aJJ8BSSbIYJN4cjpGbK2S2nOgYbnYZsK7Spie18ujDpxYrzgmpuJ
         sM3urjkpLEWcSZG/1AboLhW/JFGDnRB32xgRPjSj9nVYiJqM0tIU1pYeMbhdqpINK9Iu
         W4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvYIFds6eup8D+Tv+xrrCQefTdlmuELed50B0p8/2JLybRWusL4zyjiDnZYTRm3Wj+6XPC7OvBHBQP@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbuaUmRGiNlraVz6Ts9hn1z5UO3qcig20kk+wc7gPDpO82mGA
	FZimkvs+Lf2zJGuJDTYbuEATg5BDnOExEqbBiTFO4zuMKN9/UaPAkijyVG+8WPo/Q94FapIUYyH
	kCJSpTl+fWU8f8HT+GVCsDL42g2fnaVPhh++mpW+L
X-Gm-Gg: ASbGncuiQ+ItR0EAxCV+OcymINVsZ+SQ3uPRDzQiIc0mQ0AOHvllPHzZfgkVRFcVePA
	3lXznt2NwX3cBda9kMRw44uRaKnIeQffTXQXr9+dPRmzd8rKGUYW0B5Lm1DjCm1cHQBhg2SUnUA
	tdNS1iUlxGn1Y9oWewxGVhItT74XpRlNH0rG5ypxIeIrawLubBYv6GsTCwtV5DM0tZN0IdfftGz
	ZVuvggZL5FdZ6+PnAjebn5bgeiwblBT4zjU5Xf++Xqt2DNmg2jFE3novxGWgNE8fHWzDbo=
X-Google-Smtp-Source: AGHT+IEWvuRghI75CmtMzlYsfsKx7vbKQDtoXD04cCHz9fsZZIzvB/1/cVSRXibV9067p9gACoWF3MaYvd4u4+vau/E=
X-Received: by 2002:a05:622a:40e:b0:4ed:5f45:447c with SMTP id
 d75a77b69052e-4edf32c0b11mr4688521cf.6.1763108896300; Fri, 14 Nov 2025
 00:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-4-lrizzo@google.com>
 <87tsyycllk.ffs@tglx>
In-Reply-To: <87tsyycllk.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 14 Nov 2025 09:27:39 +0100
X-Gm-Features: AWmQ_bkwIXA9gM5mIiIRBn3Nz6-20n_RQjhZ9rYMsWcH4gBFdE4LrvPT7qrMams
Message-ID: <CAMOZA0Kak5bqEQytGQieHY1r6Loo-pAZks8qkROjU5z+OD2=HA@mail.gmail.com>
Subject: Re: [PATCH 3/6] genirq: soft_moderation: activate hooks in handle_irq_event()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:45=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> >  [...]
> > @@ -254,9 +255,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc=
)
> >       irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> >       raw_spin_unlock(&desc->lock);
> >
> > +     irq_moderation_hook(desc); /* may disable irq so must run unlocke=
d */
>
> That's just wrong. That can trivially be implemented in a way which
> works with the lock held.

Do you mean I can move the call before the unlock and use __disable_irq()
given that  moderation is only enabled on interrupts that have
irq_bus_lock =3D=3D NULL, so disable_irq_nosync() which is
        scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
                __disable_irq(scoped_irqdesc);
                return 0;
        }
effectively collapses to raw_spin_lock()
This would save a lock/unlock dance and a few conditionals?

> > @@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, str=
uct irq_desc *desc, int node,
> >       desc->tot_count =3D 0;
> >       desc->name =3D NULL;
> >       desc->owner =3D owner;
> > +     irq_moderation_init_fields(desc);
>
> That's clearly part of activation in handle_irq_event() ....

I don't follow. As far as I understand desc_set_defaults() makes sure we
have a clean descriptor after release/before allocation. This includes
clearing the moderation enable flag from a previous user of this desc,
and the flag is only read in the hook in handle_irq_event().

cheers
luigi

