Return-Path: <linux-arch+bounces-9067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A876D9C7320
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583111F21D22
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A351F4707;
	Wed, 13 Nov 2024 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeimwMFs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAE282ED;
	Wed, 13 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507264; cv=none; b=GJs4DVsMmeDheBpZUUgSJCIoEoa4j9+a8zzg6Sk/vRuRpeLgPWLLajYG1VCOSDC0aBh4a1hhy+GYnsZl2Fp6dHi3BvwM2WeORKH+WepKDNqKSFau9YVt6X39q4tOOB6rC2VBpeK/wutL1oSVjQNaPyZWkJzhPIBGosydEZ00qfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507264; c=relaxed/simple;
	bh=7g2Ed0PYp+K0iYwFBDYBR4GjiywhMaNDISFPqQ44g+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MifOu5J454tjwF+xlBFf1nzRx9Zb/bkZZE/kqgJGpTVHQ4ArvpKXGXs/bXiccTLHixU2tDhW2BO03ByI9VV+lYl+NfQx3R2ywci92VZL0Z97EEcIq5iGf+ZS7klVcW4iS7WNQST+XK8/Aw+vA/fm6d0Gj9aAy74QC0dj0WM80lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeimwMFs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so62988181fa.3;
        Wed, 13 Nov 2024 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731507261; x=1732112061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTw8XVVZqvuIy+eG9N2qUdD1lL/ZI+OWgwR1mXqgbFc=;
        b=DeimwMFsEcIWH3s6lVK7+LTk6DCEY3HScYiiNZBy3B8pd5jtzVD6QGOiEjv8t/lIoV
         GnutPXHST3H6EMb0xoZnWkasdm4wJhJG+c3wRfQbaIuTDtuIqx5gZWGNanjpXMJzr9bC
         suhO7eNEJDAGf52gY+yYoZzTxBxooFX+J/iVISyyXX+F3HjnKkZ8Ny1dk6PQLLBschZi
         c8Yn8aTNt1QW4ocTFbNZ8hJm6TaQ0Igd6Z/4exqjpfaP6ihw5NNTnJhEXqfzy2jark1i
         tyo5WED8mgjLvpTD49gbK+jYFduCAFrecS+KSCAq0jWFbCaOZsFGZfS8eF9NYEazDI5X
         lXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507261; x=1732112061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTw8XVVZqvuIy+eG9N2qUdD1lL/ZI+OWgwR1mXqgbFc=;
        b=CyTsMN4Jm3PoT3MM6VVWMblvT1CVQwtaoQGyezx0BTtRPWSJy0W1+LmzbFCSXY1ylq
         k9PT+TkM3sph4lnACF/xRNZCd1LXSOjcYkizWmQYtPJHRFBz1Y5kMF2SCm2IbaJXhNX9
         9x/3hS7FqTXYvpDAVN6DIFb0/cBQyFPi70KzgRF4B3L/csTR6RZpeAu8louK+Ypj8REk
         d4JoZ9ceq23VjgR0kH06/XFTiHmmkOUs1pzNztm6Hfqn+9hxUWiTq4ttY2XWH76JIBHb
         QWDNr4vj6aKkyB9c+voaQmUGW8MetdNm/vErWfrnW5lG6NHZPiSLbOoQQOMFmgzVVDAC
         zmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgLLQV9CAV4l3YdAVh5x4eLIEhvyziL5BN2on+LuTNP16Iev5i8P7waC7OCV3c6k8ZWVroCF/bO/lQz2G@vger.kernel.org, AJvYcCWp2DafM9Jgnyjk7kH/SH0ZgJysj8hxEYeJMMcQfaGyAO7Wu5Ks9jF0CJ0w4QGIYXF3bPIgV2PNlRnw@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKMV3hO3vOQPMLfgOrbQn41MYzDMJ37vCTC2ZOD7koQZQgbem
	fsnrA/0Wh0jGwhedVIPLDLc0FycT19jorhx1ENtQQvpK0ELClA1HSlDffEw+lskFXf5aBchm6Cc
	40P2EUIvMjIckB9lWBuv/GGy5Qwo=
X-Google-Smtp-Source: AGHT+IFDKxAOYm3EOXefvysmb5JnL355O1Aw5kCi8XExQERUSlxwkKMaf5nbPuUd7LqEnd4KJ0hhtkDjm62cdd+AbBY=
X-Received: by 2002:a05:651c:1989:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2ff20271906mr111102251fa.31.1731507261106; Wed, 13 Nov 2024
 06:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com> <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com>
In-Reply-To: <20241113140914.GI35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:14:09 +0100
Message-ID: <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 3:09=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 03:06:05PM +0100, Uros Bizjak wrote:
> > On Wed, Nov 13, 2024 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> > > > On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > > > >
> > > > > +static void write_dte_upper128(struct dev_table_entry *ptr, stru=
ct
> > > > > dev_table_entry *new)
> > > > > +{
> > > > > +   struct dev_table_entry old =3D {};
> > > > > +
> > > > > +   old.data128[1] =3D __READ_ONCE(ptr->data128[1]);
> > > >
> > > > The __READ_ONCE() in place of READ_ONCE() does make this a
> > > > lot simpler. After seeing how it is used though, I wonder if
> > > > this should just be an open-coded volatile pointer access
> > > > to avoid complicating __unqual_scalar_typeof() further.
> > >
> > > I've been skeptical we even need the READ_ONCE. This is all under a
> > > lock, what is READ_ONCE even protecting against? It is safe to double
> > > read.
> >
> > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > compiler from performing unwanted optimizations (please see the first
> > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > reads and writes when this function is inlined. This macro does cast
> > the read to volatile, but IMO it is much more readable to use
> > __READ_ONCE() than volatile qualifier.
>
> Yes it does, but please explain to me what "unwanted reordering" is
> allowed here?

It is a static function that will be inlined by the compiler
somewhere, so "unwanted reordering" depends on where it will be
inlined. *IF* it will be called from safe code, then this limitation
for the compiler can be lifted.

Uros.

