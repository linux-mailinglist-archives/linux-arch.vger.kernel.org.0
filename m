Return-Path: <linux-arch+bounces-9065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814B9C725E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82141F2129D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09938DE9;
	Wed, 13 Nov 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5/nLYXE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F56C147;
	Wed, 13 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506780; cv=none; b=KKHP1T0u11lPyNl649fq1j7L/gNIdnpCr/uRUde1bVZ+icn0cDZboVKf+qI6reAc82r1qrcijtJdTyHyCJgcKQkgVb82S/8H+RKKl10N2CdgXaRAY+ebOU5hamrP8gfU9WIz6O2qHQPsRCS0sJbdQtVKacxw5AlKVJkQyMqtJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506780; c=relaxed/simple;
	bh=ZKjs/sS6J+4Rn1KfgIsLXQ0nvZlO/kfOP0s+1aJUtHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxxsddv6h7nmV26B2NwoJ8K6HWZx+3o/1I4EkC+5A0FuUThuCzC1QeJG05AldaI6aU2sN2RMN5x5y2gif+syBKboTyBQA3xG/dp9LIuLMxXapkEyMU2dXJCQ7Xj+7k/J7LpxMGsz+R0MOn70apHU9w4qxSH8918HTNGTM4OV5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5/nLYXE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so83204251fa.0;
        Wed, 13 Nov 2024 06:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731506777; x=1732111577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FgbyqIYn4WEhSD+EDJWH53wmgZdzw5uXoaqskg60tQ=;
        b=X5/nLYXE9ZNseKIRZaWNAT2239BuVCGxXyJ8FDi1UDECGejFRafF7JFvnSCOf63gIE
         u1mzG/7ZM8fuuqB4ii56jm916XD5vHOPU74Xvfkn/TYcl7m3bcHy7QGQ9TabzT5VStVa
         0GqrY7iQPaMOBr86cEz6UljBSpQVWC9b6VAH96sAJNVmR7Cgr2DxqFM0tDxDZetWG3Tm
         vmgF6UR6QkNnZ/rrVVQ3BsZoZG5WASfuAJ6e53WH3pktMcJ2UIuCrA4NDJlc1kx3I6hR
         rwLv2yGv9ngFxols/LiFKWGPhmQqbM2+taKTvpQ1OzRqzcrDgoMH4df2NZfG2La29wWe
         ByoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506777; x=1732111577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FgbyqIYn4WEhSD+EDJWH53wmgZdzw5uXoaqskg60tQ=;
        b=AFs6BHs7SvidoZ9864Y27QbOjl76SBCg5FZ9P2OO00oCD2L7JKdHPsH/h0Tc4pOFvn
         eg/df22+pOjDnfnAaHV02Y8NiyJLU+InrN2aGLr4e6bTDDTSBu/1utvwPBW5ObOzlOe+
         nd0+bSd4szv/5kzX47udj+Q2qJAuiP9cJ5EgR4sH+pAtnjZeyd2Ndp7iN6eTu5/HM1rn
         Ms8TEjZQwBQcPF5ubMfYzDNnWwYjeiyVFcKo+pT1O3Tp/30Qe+pnzhW7r4g6+O/Sqb5g
         Gy/crJM82WUzKs/gPuUy7UEAmo09huUwq7dTF4/Qu436SX1vKBbOWRFfv0RDdl9p6Faz
         tKxA==
X-Forwarded-Encrypted: i=1; AJvYcCV92CMwSzu65cKzLFLvxCe44xIKDqYc1q1fmZ3jnc02Cc6vPtAPqt8JNSiUtaCRFzvQoCTUWXyxaCvNQ/zh@vger.kernel.org, AJvYcCVaR7p+X4IT3myKhJME018D2u+gByhX05Mb3FBA70Tr2VWXGnsqJgB+r3qjaMXwnBrKo3v1JpWD/odR@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrHd7GZ3zmSrcyVRfwXi/ZrvGLxE/J+K+ELMKA2+9NnanmQzi
	RPvzolCf5tbULpqIgWgLvxWM+bUQ5yRUYetEjOFQtdEHqX2tgpS1S5Kf1ta8eNBEQykmF0vIyHd
	SLtWkDnTWtw6vfBLbY5l8N6Ur1/I=
X-Google-Smtp-Source: AGHT+IGyssDKQ92Cobn0CtFhQzBMVyaZc7uN5SwYajk5gaNkrdUasJ14YzSQg3PYYMNDKJIMwIt4QZtkBVizFZbwx74=
X-Received: by 2002:a05:651c:554:b0:2fb:4f8e:efd with SMTP id
 38308e7fff4ca-2ff2028a97amr153898021fa.32.1731506776866; Wed, 13 Nov 2024
 06:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com>
In-Reply-To: <20241113132031.GF35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:06:05 +0100
Message-ID: <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 01:50:14PM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 13, 2024, at 13:03, Suravee Suthikulpanit wrote:
> > >
> > > +static void write_dte_upper128(struct dev_table_entry *ptr, struct
> > > dev_table_entry *new)
> > > +{
> > > +   struct dev_table_entry old =3D {};
> > > +
> > > +   old.data128[1] =3D __READ_ONCE(ptr->data128[1]);
> >
> > The __READ_ONCE() in place of READ_ONCE() does make this a
> > lot simpler. After seeing how it is used though, I wonder if
> > this should just be an open-coded volatile pointer access
> > to avoid complicating __unqual_scalar_typeof() further.
>
> I've been skeptical we even need the READ_ONCE. This is all under a
> lock, what is READ_ONCE even protecting against? It is safe to double
> read.

Even without atomicity guarantee, __READ_ONCE() still prevents the
compiler from performing unwanted optimizations (please see the first
comment in include/asm-generic/rwonce.h) and unwanted reordering of
reads and writes when this function is inlined. This macro does cast
the read to volatile, but IMO it is much more readable to use
__READ_ONCE() than volatile qualifier.

Uros.

