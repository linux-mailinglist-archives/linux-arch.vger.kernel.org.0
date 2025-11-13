Return-Path: <linux-arch+bounces-14730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62623C57CDD
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 14:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095AF424314
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548E184524;
	Thu, 13 Nov 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXtHcuqY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF301DDC07
	for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040872; cv=none; b=JYaPrfqejEtzQ0y76FALufP58qd+bihZUx7mz+AuT2t/srC5/OX4bNU/JIlacBL1w1cSuyHXx8eRfdnuRTzbDbEvZgX/LYabFED+bXMYv2fcU0YE30UA/Hw6OyPC2/9ag8nbXbBiEjFI+au1Imj1VZaBrGk6Oq5CyF1y+Uc/vQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040872; c=relaxed/simple;
	bh=6l4ONkReUKy81A9GnmL3PU19yH8H6LhTLL06wGe1prM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuXgo6iKiqGKTD+sP9ryMU9wj8qmxct5wC+spqNw38F9BxYExJePxBci80pO3WvpMGI9L8LektDxDy4SzKOAZtDi026a5+l4UJbx+PzqneJYXNLZt1COlDrGu+0cSpI3HySqQ/TPJ4jfw+cfpFVzjvL2+ie+TF5Y7BeBk6m4jpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXtHcuqY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ede12521d4so272801cf.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2025 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763040869; x=1763645669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdsF6PopYo48gJZ8nB8MKqkVw6ro+5qg6LJt/rrshu0=;
        b=pXtHcuqYsSE1a3SMwH9pJ4ouVS6DW1pScVaUbjVZyxr9i6zzn6ywkB+57goEKZapGf
         qfnrvAMP4bPaKKAp+BptZOfSVU9KKNQsD2SwEIOKeKMRhSKWkfzO/w7RA6ijB1u03y/w
         vU1IJC3LuRbhnbZCkAOBebJt7CP7yEfsGlO5p41m3/FeJipbupYS2AcCXof927ujWYhV
         dGh07S/Ks157VGLYMt8FJIs4kHurbDVT1L97+QXtVOCL7Vi7hY3raMkY2AcLtK3mj2rA
         0MICcn3lCsCxEhc0RooBhv0DJV7krEbvbrCLQnRpgMomjj/vwBhl0GirBKVSCDbRDX4D
         tj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040869; x=1763645669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdsF6PopYo48gJZ8nB8MKqkVw6ro+5qg6LJt/rrshu0=;
        b=KraEkIpx1SlyEH3eZm5AkDWw77YIN4n2smxjMIAqITkD9gyo8VHRYOLd3HvAoXJuEx
         FZFtCWCRUNYwDmN9+efIbigUmOZDImgICO0yVYyzYkIhSVhIevd453tcioAVK6E24j2j
         rHNYritTZtJ3TuzHBgaNUSvgi/b3qYqGt+jFB1piWYRNJd+aC5B9kpkFuAX6XW4smq7s
         EGGLUE94GMzopmGN3pXS2pSDnuhcJRmeSlyWYtbAGm4nWNUNWzla3bFLJlej+BbEqyNN
         4bcGph5/ckoaAgqioBDviAym+B2YkFiSr1w+msVajPh0AP9l+V+7FAEGksV9usU6Rakg
         h24Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5dkwqxlQHY1rRFldr2J+M3Lo6GfTfWg3cR0mWIk0lWNGhGw2nhvW1ZI3Ysw1NDNo+SMGodPP5Obh2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HG+TgGcRbWG6LcPB97SCm8W9+S7F1oAseLb+Fhelfnc9E+wI
	73gAb5C0ucsW1e5ReXDRe9t/NkQqrvbsR1b4SGj3rs8t2BFuohdgFJf3SN0Z2MSsKf3615tewKP
	pJnZpUofjtulmVcsJHO8aYdwhKS6KIctBoxZ/NlfM
X-Gm-Gg: ASbGnctGiOnfqwrkx9jVNRGsRvX7zF7CoZu2WbJTN+OjaJDLSnw7Q3+9HOsYZrUoLAx
	+A7nxMCJJRYwmP+T37rDOMna9RpHk7VRi9dW1EpCvZXcHrv+MmeC078V0YWOVUSatwDC1gHGtCa
	xzy2h5baLMQrv9dY+lkRYhO3WAQ1NVwFn7B//cD7CpwTbFVXaxLEqLNudN3LQpbTgXyglzFAGlg
	VAcdJHbJ6DyyQFnXQzEvU49Frahw3GXl+5fF2qDYhfZDBdht97qihHLEy7yTWlgX/P+jYU=
X-Google-Smtp-Source: AGHT+IG0BPTdEw6iovy+vMYENh+zRzF3KveurRWgU3MJfeVoynxJgdYulT5V0eVvFNc9VgWBEGGG3NVW0j0zIrRowR4=
X-Received: by 2002:a05:622a:1984:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ede8b9700cmr5422711cf.5.1763040869200; Thu, 13 Nov 2025
 05:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-2-lrizzo@google.com>
 <86o6p6t67m.wl-maz@kernel.org>
In-Reply-To: <86o6p6t67m.wl-maz@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 14:33:51 +0100
X-Gm-Features: AWmQ_blUZhatEQIcApRPEX2RytnJi1en5rbG-leFu7W8EQyuxctXfqwlWs6i7OQ
Message-ID: <CAMOZA0K3hMSE32SnyVBW5NY4V=zuC3S7ueHfZN2sAWZNqRCwvQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:25=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 12 Nov 2025 19:24:03 +0000,
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> [...]
>
> > The system does not rely on any special hardware feature except from
> > MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X
>
> Is this stuff PCI specific? if so, Why? What is the actual dependency
> on PBA? It is it just that you are relying on the ability to mask
> interrupts without losing them, something that is pretty much a given
> on any architecture?

You are right, I was overly restrictive. I only need what you say,
will replace the text accordingly.

>
> [...]
> > +To understand the motivation for this feature, we start with some
> > +background on interrupt moderation.
>
> This reads like marketing blurb. This is an API documentation, and it
> shouldn't be a description of your motivations for building it the way
> you did. I'd suggest you stick to the API, and keep the motivations
> for the cover letter.

ok will remove it.
Sorry if it reads like marketing, that is very very far from my intentions.
I just wanted to give background information in a way that is easy
to access from the source tree.

>
> > +
> > +* **Interrupt** is a mechanism to **notify** the CPU of **events**
> > +  that should be handled by software, for example, **completions**
> > +  of I/O requests (network tx/rx, disk read/writes...).
>
> That's only half of the truth, as this description only applies to
> *edge* interrupts. Level interrupts report a change in *state*, not an
> event.
>
> How do you plan to deal with interrupt moderation for level
> interrupts?

I don't. This is restricted to edge interrupts.

cheers
luigi

