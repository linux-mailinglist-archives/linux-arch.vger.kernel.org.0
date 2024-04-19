Return-Path: <linux-arch+bounces-3829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9C8AB467
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2611F22157
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79313A86D;
	Fri, 19 Apr 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLeMJbhX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5024130E20;
	Fri, 19 Apr 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547973; cv=none; b=CE+2DkWXpbfGDao3u2gA2paG7uTS1sQcksfoIX6eNxKfTQam6U6SupQ0Q5if9vKTIKaIs90iLzl4OFy2qYeUe7XQSyIB4IYMrbCs713p8I7uBePp4+OLjIO1T5g31O1Lvfqr9ij1JfKXr/n0pST45jnVT2/ESC1YDfR8iP5jziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547973; c=relaxed/simple;
	bh=sVegppIF/niXLnTLCcBWzkxa2L1ow1Dt9dF+ATN6lsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVBM7NZ9h1xg0Zz7LdIsYP0XSr5eioYrSpAtIYT1A+gbQivejKix41i2I0QZQRuHX0yysA3jEuV5XWVoW7zQP6hkA/hpyIphhSq0U3S3jVI/JMm/SMcNiHNRB5U9yzr4HM+COQ5XV56ArWCvnnxvHV++lxmTNs0cMIJ1Bk0rgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLeMJbhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556FAC32782;
	Fri, 19 Apr 2024 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713547972;
	bh=sVegppIF/niXLnTLCcBWzkxa2L1ow1Dt9dF+ATN6lsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mLeMJbhXL1USdyI1VBlZR/GBg1BEz0cjgWcP3SXE7vHv+TaAQSyfRtJFvknWhZNwF
	 EWgJr5kC1w4O/75kkwCllehB+XaQxw0W39Vheh4H91moRz4zIACCdx+7jJEfpx6lZO
	 x8q/xw1DFD+2x4Fti4C0rP5hLs/xqJFqj4UHRxR8PvHiGzZtkZ6mLr1kr1XSdfdIiB
	 YE3donqw1Gm0GoL/3qzEWlzTvLIfaL/IRhRD7q9EWCzscK8abqIPsxDOM48gzlIU75
	 UnQWol+B94cwBhV5l/AV7J/1aE3nJoEBRBO1u2qhUn/t9zYuQvrWaz871VWxdPhsum
	 QvkU90GBu4LBA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so2984590e87.2;
        Fri, 19 Apr 2024 10:32:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8YgCfyt2ijOYD3jCucwuP0qHnEeZz0uMsZX5YKcmpJ7KA8e6ZYRe9mcr+51/60f0/uNyStDto5eSUR4vQqhogWeq5xOuWECH0+i5VuutxrxkGH0e65GTsOodX0s/9npXpwmMYHpGeGTvhHhVi4lr1qM9TaqUodlQJLEql8CY9NbuNzd23Nhlq6OeF2Z00aIUYclB1TLQuV+i5xSn7/pSD0rOSKm1NlFySerHfLMIXf76xPN4oi33ICOOCRVM75u0G1je5V3ygHtQuaO5cudhAi+HbA+PInUlg7DWEFiH2O54K6yIoaJ6i5LBXyEeFcEROi9VPLnzJQlpKnnpp2GdgKeKN/EFqSWzUO2ZtRzsyWvcNmF3iJrAKto+yKUzn3tWAy98Ubvx2KbCtzE9Aaic3C7eoQL8DakahD5fK9S0VchZjqebZ8fDd8h4=
X-Gm-Message-State: AOJu0Yy3YzKXSgWYvVlKluT8ebaVPxkFUs9f61nP6uSKxHfMuUcDNz2L
	i/EgqF9IgUoce6Nz/+w+IbFZ7qUMNNBYGmAeqgSYZuwaFbtfQCnaqEcx6e/vS6BcQA16+BaoYs0
	uSbRVEwMQlAYSmpnOhEjK4eZufKI=
X-Google-Smtp-Source: AGHT+IFQL0ZIY0ZfQ4j9vl7SSSW0Y7vt5IE5s4aAkthQ3+dt0vC//uVhsYgqRpBdUKo6ap4ecg5hjMNFhNToQ1hMBQU=
X-Received: by 2002:ac2:5a1e:0:b0:519:296e:2c80 with SMTP id
 q30-20020ac25a1e000000b00519296e2c80mr1475078lfn.15.1713547970497; Fri, 19
 Apr 2024 10:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415075241.GF40213@noisy.programming.kicks-ass.net>
 <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com> <Zh4nJp8rv1qRBs8m@kernel.org>
 <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org> <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org> <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org> <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
 <ZiKjmaDgz_56ovbv@kernel.org>
In-Reply-To: <ZiKjmaDgz_56ovbv@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Apr 2024 10:32:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
Message-ID: <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Topel <bjorn@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell King <linux@armlinux.org.uk>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:03=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
[...]
> > >
> > > [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.=
org
> >
> > For the ROX to work, we need different users (module text, kprobe, etc.=
) to have
> > the same execmem_range. From [1]:
> >
> > static void *execmem_cache_alloc(struct execmem_range *range, size_t si=
ze)
> > {
> > ...
> >        p =3D __execmem_cache_alloc(size);
> >        if (p)
> >                return p;
> >       err =3D execmem_cache_populate(range, size);
> > ...
> > }
> >
> > We are calling __execmem_cache_alloc() without range. For this to work,
> > we can only call execmem_cache_alloc() with one execmem_range.
>
> Actually, on x86 this will "just work" because everything shares the same
> address space :)
>
> The 2M pages in the cache will be in the modules space, so
> __execmem_cache_alloc() will always return memory from that address space=
.
>
> For other architectures this indeed needs to be fixed with passing the
> range to __execmem_cache_alloc() and limiting search in the cache for tha=
t
> range.

I think we at least need the "map to" concept (initially proposed by Thomas=
)
to get this work. For example, EXECMEM_BPF and EXECMEM_KPROBE
maps to EXECMEM_MODULE_TEXT, so that all these actually share
the same range.

Does this make sense?

Song

