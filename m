Return-Path: <linux-arch+bounces-14990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E02C73DE2
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C468D2A705
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC532E756;
	Thu, 20 Nov 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siSYhA40"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464082D7DEB
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640255; cv=none; b=TTHfsoAQUcvpDUcUc7Ix5P+6oZJkLMcbwlgtC0sme3n/8WHHpjUYv7DxlTBKPZEYBM914Coe0ng/kmWxP/wxMIhn89xoN/BCAosSeyZxvrlX+Nb1JvKKte8fX6CK1I/KsqVb6p+MMVh9Brf2ALum4p5urgeMw79dRfs4Fxv/dZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640255; c=relaxed/simple;
	bh=TvKuNxF8KVzTcJOUyKqukheXPBn2wF0Qdt9k4a0yJ1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uswNhgn4WJs8USeYS2gpkSNMY0f/8RR+BBmdw3drFUde2H/zzaZjRCusebHNJX+/tNa5xXqHYIqiZaCiYvUcTs9Fd7sIoH4YdVHlmKslAyYQTnKWFwJHOHim6t7axuGnexsL2MsmRRXbcFXmbT3TTDXba7WUNOgrsnkgORRVzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siSYhA40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9047C4CEF1
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640254;
	bh=TvKuNxF8KVzTcJOUyKqukheXPBn2wF0Qdt9k4a0yJ1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=siSYhA40rck1hHoCJFk5pVKoqgSav4juLE+Z9j/P1i+X/4YiGyKVoCYGEXKGIzI53
	 FtyHydVKdYThNjZAJONrWkya+MjpvevbZ+1/QKsONeM/htumcjcF1Lm4UO9DegKlOC
	 z7pl8Czo87ACA/OUSjWuXWogswPa/jZJhYiBOJSkbXBTdQlfuDl8aMRQrUfy0dkjNp
	 DHa58EUIE+C5D71GPx5q6BjWf7UedfF1LeICbQRVstpg/wXoJgAhHdsfgDYCS9BZIf
	 lczsev0Y+6YNDnnZME4LV6YkHmVO7S0GVyf8x3xuiFcU0C38J64uQlTeV2QPXoHjI4
	 sZSfkVOBowoXQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736cd741c1so149939966b.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 04:04:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5eOK6OTZDtRPX4EMhz36+dlXQOaClbBnw/K/XVsuRXGjmxEQOFZSuLVQcJPx1BtbUDFowlii4UBmk@vger.kernel.org
X-Gm-Message-State: AOJu0YyESdFsA2VyA+251tYgWcs1Fya1B5KP+sLEbjgb4moElVSlmg1n
	3QN0zHZxL/8lLdrTlWJqY0lzDhDBoyLILeXvVG5XCfPbLPuQ3vklDbRatCDi4qaku06NsRO3xl1
	yB3PZrWfN0WubBodFHXRpJjWp5YHUt/M=
X-Google-Smtp-Source: AGHT+IHrwBCd3dKr6xvzcNJE2FOBI7NF7lucPKAfcahjjE/JI1kDrb5pYEtyohOxHciBo8tacJyC3pH8M4Bo7CRtiRg=
X-Received: by 2002:a17:906:c107:b0:b2b:3481:93c8 with SMTP id
 a640c23a62f3a-b76587b1c55mr227463066b.19.1763640253480; Thu, 20 Nov 2025
 04:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-12-chenhuacai@loongson.cn> <8dd8334b-388b-4681-a62e-11e10b6d6466@xen0n.name>
In-Reply-To: <8dd8334b-388b-4681-a62e-11e10b6d6466@xen0n.name>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 20 Nov 2025 20:04:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64h2AtMt-zZYLs7ZZAWadEpU=ZUpvPojC6ut-Z04YDdA@mail.gmail.com>
X-Gm-Features: AWmQ_bltrBYAeaOpjcL3S1Z_kJJMPufmCCydAP9wpFgnNCsjI429Hjufo6Kmv4I
Message-ID: <CAAhV-H64h2AtMt-zZYLs7ZZAWadEpU=ZUpvPojC6ut-Z04YDdA@mail.gmail.com>
Subject: Re: [PATCH V2 11/14] LoongArch: Adjust misc routines for 32BIT/64BIT
To: WANG Xuerui <kernel@xen0n.name>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:45=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 11/18/25 19:27, Huacai Chen wrote:
> > Adjust misc routines for both 32BIT and 64BIT, including: checksum,
> > jump label, unaligned access emulator, PCI init routines, sleep/wakeup
> > routines, etc.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/checksum.h   |  4 ++
> >   arch/loongarch/include/asm/jump_label.h | 12 ++++-
> >   arch/loongarch/include/asm/string.h     |  2 +
> >   arch/loongarch/kernel/unaligned.c       | 30 ++++++++---
> >   arch/loongarch/lib/unaligned.S          | 72 ++++++++++++------------=
-
> >   arch/loongarch/pci/pci.c                |  8 +--
> >   arch/loongarch/power/suspend_asm.S      | 72 ++++++++++++------------=
-
> >   7 files changed, 116 insertions(+), 84 deletions(-)
> >
> > [snip]
> > diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> > index 5bc9627a6cf9..d9fc5d520b37 100644
> > --- a/arch/loongarch/pci/pci.c
> > +++ b/arch/loongarch/pci/pci.c
> > @@ -50,11 +50,11 @@ static int __init pcibios_init(void)
> >        */
> >       lsize =3D cpu_last_level_cache_line_size();
> >
> > -     BUG_ON(!lsize);
> > +     if (lsize) {
> > +             pci_dfl_cache_line_size =3D lsize >> 2;
> >
> > -     pci_dfl_cache_line_size =3D lsize >> 2;
> > -
> > -     pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
> > +             pr_debug("PCI: pci_cache_line_size set to %d bytes\n", ls=
ize);
> > +     }
> >
> >       return 0;
> >   }
> Mind adding a few words about why this is no longer considered a BUG and
> why functionality isn't adversely affected by the change?
Yes, you are right, so I split this part into a separate patch.
https://lore.kernel.org/loongarch/20251120082039.2293136-1-chenhuacai@loong=
son.cn/T/#u

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>

