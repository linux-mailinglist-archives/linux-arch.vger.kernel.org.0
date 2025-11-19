Return-Path: <linux-arch+bounces-14885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DC8C6CBE0
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 05:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CF41B2CD20
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47132FBDF3;
	Wed, 19 Nov 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoT5E2ns"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178A2F7AD5
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526518; cv=none; b=b1baPQ+4qgMMjkpwkn42fUNxmD2QSGAIAJq9OPZwv7rXFSPNmTy23hF8cyA6dtOKIEqnKrfr64ncXO9ZjcIUC5VNAYhxJXQRSrbNABgPPFPhjHLLO5M0KSq7PEC1QRai8UhxgejRmt0fuHZIC9K5WexeKpHxrIcg2C1nO5THHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526518; c=relaxed/simple;
	bh=20yE8xmrCxVj0HrYnRHPetvSNta/9P+r724P2CoUT8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gp/qMh6ZILU4tnEOFH71c/42T5k9A3FWBk0W0nHrAtdeCb+siNUVqRdInZjNOX97lIC+ISA3PjpQEoCxx+/IcPWHalO3XeVXohk/GjcnT94yeIWh5yTuFE1wHdnaqDIArH1pMFc5TsGzjeMBulpXvMG09gqQwLq71Qnh6CmBKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoT5E2ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C06C116D0
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 04:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763526517;
	bh=20yE8xmrCxVj0HrYnRHPetvSNta/9P+r724P2CoUT8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WoT5E2nsgswz/R4HXdq39gPnz91evi39ZR7Lb10+ZNh/kzQpGIYILQSsZpqIhTOTo
	 4DT5dfjlDZrOknA0l4ruNsfJprDfZsSy9EJuc45Cz2DYQ5TQdKyKdIAReVEWebo3Zc
	 bj2DFGhDGngPKiL9ha0yHyw8s0TxUcBlqz5Tm+e86rYw4hSp0MgPsf9AYyVgbqzlOd
	 xgUU46w2pLQr5T8PVVYiFgE7ebbrkcsBXyLvXIM/jkmblf7gMnM34+D4ybc33acLSi
	 RbjqKcdN91FeQqeI+j7AjlKyWMgAqCjaFPV2hI3Tk+FEK7OXaARSPWu1s9BIG6ZXTT
	 RWw2VpPpY92Ew==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324054so870651766b.0
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2025 20:28:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTQIXSHRFvy10hYXLB/Qqjx2CGokyp8EAYNZxVJuu9ZJj0VNtQVtiaNin1z3mH0N8En7R3i/doHb2o@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUH2rT5N3DnHGFIgxoAge9+kcgGIwgLaG3LP7mSHqwBdyhKdc
	NNhfGS/EKal4d32BrYsCwJv+A0E8AaTABoPKC+HL1KJdU8WEv5I5Er6hm7WY4L8Ar5RwkboaFap
	KtVS6OLY9wXO0A1XY2FG9FPfqFxLVQ/w=
X-Google-Smtp-Source: AGHT+IGbWywcXwPsVFpJurJ5GAZ0bygPjNfZNq8uY4NQtMfmy5NOh6gv+cE5A/pgHpI4GEGww35ib53dEJCVASGJLdQ=
X-Received: by 2002:a17:907:96a8:b0:b73:9280:2e7 with SMTP id
 a640c23a62f3a-b739280114dmr1154628566b.34.1763526514307; Tue, 18 Nov 2025
 20:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn> <aRyoLBjD_8Hz91DV@pie>
In-Reply-To: <aRyoLBjD_8Hz91DV@pie>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 12:28:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkAxEgaL09SmaycStpQZWVNv5BLUeJhpEXHn5nZFiBjratzLwjaG9XQB3s
Message-ID: <CAAhV-H5uoDjBRYpK_e7Z+vrcqLAbLXhEbEQP_aJ9f3aTdA+-eQ@mail.gmail.com>
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
To: Yao Zi <ziyao@disroot.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, f@disroot.org, 
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:09=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> On Tue, Nov 18, 2025 at 07:27:18PM +0800, Huacai Chen wrote:
> > Adjust boot & setup for both 32BIT and 64BIT, including: efi header
> > definition, MAX_IO_PICS definition, kernel entry and environment setup
> > routines, etc.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/addrspace.h |  2 +-
> >  arch/loongarch/include/asm/irq.h       |  5 ++++
> >  arch/loongarch/kernel/efi-header.S     |  4 +++
> >  arch/loongarch/kernel/efi.c            |  4 ++-
> >  arch/loongarch/kernel/env.c            |  9 ++++--
> >  arch/loongarch/kernel/head.S           | 39 +++++++++++---------------
> >  arch/loongarch/kernel/relocate.c       |  9 +++++-
> >  7 files changed, 45 insertions(+), 27 deletions(-)
> >
>
> ...
>
> > diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> > index 23bd5ae2212c..3e8a25eb901b 100644
> > --- a/arch/loongarch/kernel/env.c
> > +++ b/arch/loongarch/kernel/env.c
> > @@ -68,18 +68,23 @@ static int __init fdt_cpu_clk_init(void)
> >
> >       np =3D of_get_cpu_node(0, NULL);
> >       if (!np)
> > -             return -ENODEV;
> > +             goto fallback;
> >
> >       clk =3D of_clk_get(np, 0);
> >       of_node_put(np);
> >
> >       if (IS_ERR(clk))
> > -             return -ENODEV;
> > +             goto fallback;
> >
> >       cpu_clock_freq =3D clk_get_rate(clk);
> >       clk_put(clk);
> >
> >       return 0;
> > +
> > +fallback:
> > +     cpu_clock_freq =3D 200 * 1000 * 1000;
>
> Why pick 200MHz here? And shouldn't the clock being always provided in
> devicetree if it's necessary for kernel to function?
>
> Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
> property is also described as mandantory, thus I don't think such
> fallback makes sense.
Yes, "clocks" is mandatory in theory, but sometimes is missing in
practice, at least in QEMU. On the other hand, if "clocks" really
always exist, then the error checking in fdt_cpu_clk_init() can also
be removed. So the fallback makes sense.

Why pick 200MHz? That is because we assume the constant timer is
100MHz (which is true for all real machines), 200MHz is the minimal
multiple of 100MHz, it is more reasonable than 0MHz.

Huacai
>
> > +
> > +     return -ENODEV;
> >  }
> >  late_initcall(fdt_cpu_clk_init);
>
> Best regards,
> Yao Zi
>

