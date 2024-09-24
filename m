Return-Path: <linux-arch+bounces-7381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A775983B4C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 04:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004861F233DF
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 02:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425DDDDC;
	Tue, 24 Sep 2024 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXbc8IZr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0D1B85DA;
	Tue, 24 Sep 2024 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145997; cv=none; b=JWd7GHHyXM7HWInQJYVy02vFhAgitTQ/q9YcTus3ga77f/JO2v5Z9zVgUCFCkihi4fdAiJxU+GDxxcCJfS8rgjD+6SWfGrT/ltyr+yrApKM6/b9X326kdXlRshXB8HrFXxpX+vIrZTWg1NfSSPJ2ki9EPElOpERKYG2skW09PRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145997; c=relaxed/simple;
	bh=saapds3Tco5OXwRJK6gEwmbqTm5hd9R5EEGQWhxcueg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyOAfFgzCYU8EisbdYa8/H+uNkLE9RJ+tyILs9HjHHJityjhj5nH7XcCG5kQgzCGiiEDui9ckqzRUG+2WixUTpe2FYDI5vo3BjvVo6SAq6kLOTWihNK8eGFoX5mZieBsK9EBpsEPlTDYC30dMgC6uDJ9tLVsNLI/FsaDreMDfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXbc8IZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34100C4CEDA;
	Tue, 24 Sep 2024 02:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727145997;
	bh=saapds3Tco5OXwRJK6gEwmbqTm5hd9R5EEGQWhxcueg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CXbc8IZrs+le1x6K8gPklyx59P7UO2MaFH+aBs6qULAOOByQjWz2EwDcFxVQwMXR8
	 uDC4rvtiiFp1YHSpIIi29Vyf5Xk9vyunyVGL0G9cl9ifmzROQ7XhuRrCY9E2V8NhBk
	 NDzmD2DsOyPUjbix144H2Z24mARaXizk1TP49VwMXmKKfHfmAtmYD4+5Ro9/+walcc
	 8e/UpjKbHbslIF1BtWRTkehIxG8ySOToyaah2hOXVz/SmYL/DEtbJVH0X1Y9bKwZHm
	 s2J769cmRTcYSDwtMzoQbzlIuCXMMyW1wQ6anVZgK2E+vY6MsMycmVCSN0RP/pMgWi
	 nHBBJxy7ma/AQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53660856a21so4826564e87.2;
        Mon, 23 Sep 2024 19:46:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVJXZ8o2fiFRGN34OFI7v4marGFjwMO4b9/YdDkndTX1SJR9PrrDV/uupJfNVvInOYbBwlbnxISIRTKw==@vger.kernel.org, AJvYcCV4qnhlXmd/pNtynF6EoKBLlofyH2WNGeaWZdYcDMDWO1rP70Yx44MSZYDcQ3wPWrQp0HxUNUcLswtD@vger.kernel.org, AJvYcCV8sJpN9/p5r1bthDfvVl05PMAS5ortaswtv0Lv6ySiT324sU8rj4O7XAdtFU4qxR6/EvYetQtSXzsQy/HF@vger.kernel.org, AJvYcCVe0322POMCrVO5cX7/fFNKZseqmP/a2N+6gAG+uknz6i7yxpWtloHo+ctB+ZZBjp5nFJgb7tui/PVY@vger.kernel.org, AJvYcCWc3DP4gCs7l9SHGJDIMKfQ6kLqkhxjKjtfqhi1o7n7uZ7XiIX6gRcd8ZwaammH7u2h8NNCHU2T5TJzkQ==@vger.kernel.org, AJvYcCX7hS7NeoYQHliRuUPyPgSliNiX06FLRz4PI13Lw7xjMxnxKIGE3bafucD8zeR0X953ufD2xYCZsbBG9ODX@vger.kernel.org, AJvYcCXIX6+z9AYMUrgZA6PSF5cAdZFktVUAvNR6vrvu1/Je4+icsqo/glaHp87I9w17aG9e+vQ6QtyS@vger.kernel.org, AJvYcCXTMkWqeZ8UBi7wEXPSjzraiuobgkP94FtHaoXaRSU/x6cw4Wd9uIheSsi4IrIioFs57vDjv8RH7Edx@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjQmszHN58JgXnSDBpAbIiugia5Jx9c+tkCI5yRRHl9Fdr/JH
	Daai9wOchvMNlFc/5QCY8QBv4NMu0pG2xrrg0B/nv7QZ1OJKvPAE4D1NEgbSBjh8Bon5vtGZ1tl
	Tyv8yAHTYU6fZrCR2YvbbDmsFKng=
X-Google-Smtp-Source: AGHT+IGbFPw/bTRm+UErpcrDrhXiYrSHOwzSiG4p3e4jUUEDfOTfASqMN5Pcr7Ww2ei18DiP8qOt5I2z7sBy9E6rsKI=
X-Received: by 2002:a05:6512:158e:b0:533:d3e:16f5 with SMTP id
 2adb3069b0e04-536ac334255mr7477512e87.38.1727145995657; Mon, 23 Sep 2024
 19:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724159867.git.andrea.porta@suse.com> <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com>
 <2113b8df52164733a0ee3860bb793d6e.sboyd@kernel.org> <ZtcBHvI9JxgH9iFT@apocalypse>
 <d87530b846d0dc9e78789234cfcb602a.sboyd@kernel.org> <CAK7LNAQEx52BYMYfNu+xj8sNmdtH9XfPapdhJDrsbDo43aD3Dg@mail.gmail.com>
 <146d3866ec57e963713cd07b9eaf5a71.sboyd@kernel.org>
In-Reply-To: <146d3866ec57e963713cd07b9eaf5a71.sboyd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 24 Sep 2024 11:45:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1oUvuMcHs-idZcPxE-c4fJgMDt-cURATsrVkjjFPNWg@mail.gmail.com>
Message-ID: <CAK7LNAQ1oUvuMcHs-idZcPxE-c4fJgMDt-cURATsrVkjjFPNWg@mail.gmail.com>
Subject: Re: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being
 discarded after init
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:13=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Masahiro Yamada (2024-09-22 01:14:12)
> >
> > Rather, I'd modify my patch as follows:
> >
> > --- a/scripts/Makefile.dtbs
> > +++ b/scripts/Makefile.dtbs
> > @@ -34,12 +34,14 @@ $(obj)/dtbs-list: $(dtb-y) FORCE
> >  # Assembly file to wrap dtb(o)
> >  # --------------------------------------------------------------------=
-------
> >
> > +builtin-dtb-section =3D $(if $(filter arch/%, $(obj)),.dtb.init.rodata=
,.rodata)
>
> I think we want to free the empty root dtb that's always builtin. That
> is in drivers/of/ right?


drivers/of/empty_root.dts is really small.

That is not a big deal even if empty_root.dtb
remains in the .rodata section.



> And I worry that an overlay could be in arch/
> and then this breaks again. That's why it feels more correct to treat
> dtbo.o vs. dtb.o differently. Perhaps we can check $(obj) for dtbo vs
> dtb?


This is not a problem either.


Checking $(obj)/ is temporary.

See this later patch:

https://lore.kernel.org/linux-kbuild/20240904234803.698424-16-masahiroy@ker=
nel.org/T/#u

After my work is completed, DTB and DTBO will go
to the .rodata section unconditionally.



> Also, modpost code looks for .init* named sections and treats them as
> initdata already. Can we rename .dtb.init.rodata to .init.dtb.rodata so
> that modpost can find that?


My previous patch checked .dtb.init.rodata.

I do not mind renaming it to .init.dtb.rodata.







--=20
Best Regards
Masahiro Yamada

