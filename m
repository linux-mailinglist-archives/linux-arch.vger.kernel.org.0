Return-Path: <linux-arch+bounces-10682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE72A5E145
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 16:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A03E3B7687
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642C2561CA;
	Wed, 12 Mar 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMGDPNzr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01832528E3;
	Wed, 12 Mar 2025 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795033; cv=none; b=gmQv+wg7w/+pD+QnTt9aWTLgdbN/yI8rVKp2KoL4m0o/VWUzd2LYYDy9v1sWo/whHEpBSj8EMmySxVzKZEc1M1WUgLYyOegEkrpWKNnOQrwHUOa0rmbjUsD4Z9XzFuvu99+cf8AE6QE7JVHoEQ/LzZqwqvso7cuUpD4ek46dzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795033; c=relaxed/simple;
	bh=dgU35NJAC9FuhPfl4fCxI5+qb1wmL7e+GyilvA+NxwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARSftntanz2evjhtx5t//HP66msHTY5tI6Nvrp4ez2gj4HcuxEKsgEmk9WOnr52x1yaNW5mtYic67JjOgb95DSEsIrcsfiiZhnz51tI0Yad85kdFt39wXKxPIBlWYHpfrW+sBVFH7Bhy2aS2nAmQ8Hjt4bc25btlRlpJz+TDZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMGDPNzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D316C4CEF8;
	Wed, 12 Mar 2025 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795033;
	bh=dgU35NJAC9FuhPfl4fCxI5+qb1wmL7e+GyilvA+NxwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMGDPNzrQPf5TkD0b7NrkaL9vBedP++HcJIYppS3OacGh+lmMlyllNbJ65T8EUwpe
	 X6mgQAvFxmpr+7NeL+U8J5eO9mUFyF9iC/Bpw3Fnv2dGtL6Hrt/Yx6uH52UPkON/Bd
	 bMd4vd1sat3O7CafhieqmZ6kqMEcz/ppjRlQKe5fcS7fyHE/3Y4vyt7IpKYAo5CVFc
	 NGaHqUjovj3IqQIA6D2VmMJyyRyouA92R+HwQ7lUhQMLRtbPXzmj+6/9l+YNIMzd2o
	 aGu6LYyHU+u7IYNYk6FT81OA0rsZ70e5lk7oXpt1fRBo8+yNkDj8UUhHY3Of+SO/GN
	 Rivwxuyc+GVag==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee1cb370so100551fa.1;
        Wed, 12 Mar 2025 08:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5EiWRchy0C8ExvDbyCrzvcfan5beOSlASBArrD8kLIY5MuVnTQ62kfz06YIp9Cokl7AGmDggwfqMAD3kZ@vger.kernel.org, AJvYcCUPX7ujB7MUH335t2n9C1e9G3bl+v8fPwPZZY2afcdCK1mJY8oGLIK6pkDJq65F+U1lVzeZ0K/59CV3IdTotA==@vger.kernel.org, AJvYcCUjB3WZd9hRHwyFqBP7P5BGxQKuK0ckfWpxqgBnrD/hAT6MrkA7g1Jv85k1N96AFODzCulXsT6B6cTqkg==@vger.kernel.org, AJvYcCVSVdYtUSWpwMvDgGLAg3Yz9UmxHwsJmMYpeNLcdjlLNmwRLGxtQWmXWno5yU7bfUyCohKEIdX+abR19CpF@vger.kernel.org, AJvYcCVq5MCSCmyN0LB16a01GT73+blDVwOk8Pq5e75Ym0RZ+iJ65TKwWEs9Pt+38cc8h7Z2DxkWLf2pmDESkw==@vger.kernel.org, AJvYcCWLdZ6COugNPwYe0QLEMfoGMqy3PKP7ol+rcDmzP/wpDDD3X0SAiPY13syzXpAKT1qOF2xWUTv6JOVvcw==@vger.kernel.org, AJvYcCWwVcF7twlExK7Wx4VOjDRERMzpNVeWNu633aHgNyJjTsaUDRcOozAuLm2r8cpYcNuIj0GLpFfLAYN+P5ebwuA=@vger.kernel.org, AJvYcCWzOZ5xu47N9xU4mxPvPN+vGQHR5umlaBE6fbbUA61vlYSDEk/Lbyy8A/7KQ1CuGpDpJhIn/t0btnMiFg==@vger.kernel.org, AJvYcCXAipH2Ly2+QkF65w7cwR3sraNK6+IBxPk36CEsV6uu4HVvjSXiTSomsBHGDNZ6G2Am7VcR6sxVPdONAQ==@vger.kernel.org, AJvYcCXR
 hJ5bYTULrDV+hAlGMYNLY2ia1rG87mbdO1dY8HYWO5rGBiSTU7qZvA41E+KREjz9orySvhlCBWI=@vger.kernel.org, AJvYcCXbLnr7WrvtHvdgYjx9+6ppTsEoi0F+xa+zHzfwCubU7tq1Sx8Yrltatv5AvxLJs55cdt4X26vJbqkRZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzao0QViSepIVmrBTgOjhXZqlEOyTaDSj2pxgvgN/ZO6qL0WDAr
	6LIYND5C5ypd/7ZkH+2UAdf/YsutZowxGvm4z5zyM2cBQK1mPw0CvHreKnHYlgh8byQtxgNjeWS
	dUNDdDsUKyZASWcWXdhGa9opD+nI=
X-Google-Smtp-Source: AGHT+IHd+FrUHToN8zCIkYvgOINETMZJki/NvRa0TX9T0SvIe4EkJVM+k58lts/E3WmtqFbt0GpXCZ7ftrMtmqZt6y8=
X-Received: by 2002:a05:6512:3e1a:b0:549:8e54:da9c with SMTP id
 2adb3069b0e04-54990e2becamr8141673e87.4.1741795031214; Wed, 12 Mar 2025
 08:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-8-rppt@kernel.org>
 <20250307152815.9880Gbd-hca@linux.ibm.com> <Z8_Qawg0dGtZdys7@kernel.org>
In-Reply-To: <Z8_Qawg0dGtZdys7@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Mar 2025 16:56:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrq0NRixaZgOe6Zrlj_W8SN3MQrS2p8OQe5yMSfjVPvuZ4c51CBlAcj7NU
Message-ID: <CAMj1kXHS1YbnYVqVgsyfFSpg9kJM599Yp9TO8AP6--Nbgk7dHQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] s390: make setup_zero_pages() use memblock
To: Mike Rapoport <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 06:56, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Fri, Mar 07, 2025 at 04:28:15PM +0100, Heiko Carstens wrote:
> > On Thu, Mar 06, 2025 at 08:51:17PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > Allocating the zero pages from memblock is simpler because the memory is
> > > already reserved.
> > >
> > > This will also help with pulling out memblock_free_all() to the generic
> > > code and reducing code duplication in arch::mem_init().
> > >
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  arch/s390/mm/init.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> >
> > > -   empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > +   empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> > >     if (!empty_zero_page)
> > >             panic("Out of memory in setup_zero_pages");
> >
> > This could have been converted to memblock_alloc_or_panic(), but I
> > guess this can also be done at a later point in time.
>
> Duh, I should have remembered about memblock_alloc_or_panic() :)
>
> @Andrew, can you please pick this as a fixup?
>
> From 344fec8519e5152c25809c9277b54a68f9cde0e9 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Tue, 11 Mar 2025 07:51:27 +0200
> Subject: [PATCH] s390: use memblock_alloc_or_panic() in setup_zero_page()
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/s390/mm/init.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ab8ece3c41f1..c6a97329d7e7 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -81,9 +81,7 @@ static void __init setup_zero_pages(void)
>         while (order > 2 && (total_pages >> 10) < (1UL << order))
>                 order--;
>
> -       empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> -       if (!empty_zero_page)
> -               panic("Out of memory in setup_zero_pages");
> +       empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, order);
>

memblock_alloc_or_panic() takes the alignment is in bytes, no? So
shouldn't the second argument be BIT(order)?

