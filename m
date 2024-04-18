Return-Path: <linux-arch+bounces-3814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A48AA47D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 23:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886842851E9
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6D194C6E;
	Thu, 18 Apr 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os3i7OUl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B1181BB2;
	Thu, 18 Apr 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474096; cv=none; b=juJVu8Pax7GY/2jO7F3QFUV2bMvNmO3PYQKqR270aq9nhRsFMRT1pHXTh6vNegjsO76hGpnp27D/LZOsYB3prDpto9hAp5SelZsC8WUZFZ9/EkLMlASjIUFCAJYgnLxDIYe2HRMUR5+/drE8yZWwtdFFsLi4XqdUCCjKBs2OwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474096; c=relaxed/simple;
	bh=Q9xFEu3Y5LoeO0EqCkhUGHL0dsvPtZI4/AmKYvf5MnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+0txUzk5jK372QzTaz06e3UetBupnMUMh0c0sXUWXVGXQbNID8oChy+JzzSmHlvrbXEBhABFCYWr1jkplkUVNUld8ypXwzVqN/rfPwJ3r67GfYI2KH1PZxyEhljlZQoB3vXJHhS1sFr5xDKu3NQSoWCKV7cNkptrG0rWtw4EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os3i7OUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2941AC116B1;
	Thu, 18 Apr 2024 21:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713474096;
	bh=Q9xFEu3Y5LoeO0EqCkhUGHL0dsvPtZI4/AmKYvf5MnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=os3i7OUlnuFPwuywx5IIlmo6dtB59/Q7XJaGiZcHLePn7Eo9BufTvQVTR9mtW/eWI
	 r4VK8QYyOlINdoOVjMcOehKmc6Sz4RWc7AtrGTHCmGpbXOTolpO+C2kb76Yr0cYvCD
	 FMV4Iw8AtSf28SLOw4t9ku4hBlZ5jBKnjL2Jb3XS6QpCLdtSLjS9TIGuRVkBAtaceK
	 Ynk+zxcFm8+Rdi8k+nN2pCkddAj7x4BuIRqRa6CNsxBp/r1PxXoHz9fS6XaoKD1pY8
	 suIp6V5PCH1MCOf8eW5abdXsn+Qdv014GIVeNCWNab/ijMMs94IjvrIAImNdFlp9rg
	 H2pmiaunPJ3ng==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5193363d255so1680614e87.3;
        Thu, 18 Apr 2024 14:01:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdsvnbLDbcUzdTwvNlfEf/J2+sRkWH+nKCsviXNlfBx3cDYng6/7AWgS6PTAFPIlk3Z7Emj69Zu/ZGHHYs6zSXTa+Oy+ttoUBdIdBtHg0AB+4XjekacyTx1qh8Xh4+4JHTTQhdTQ+jGFirf0pTn4wZvIlU+Wg4vdnMjDWgzIaVaAd7rS03c8i+nPQWdUt3TjBWi1VarY3Px16fo2aGdrqPKH5CS/6T4MWguKsofonzcpAiBdB4iLBHmVm10oLwbvgCTsWQd3fJz6jm6LstPIDpaYS3CwJv7i1M4sTdgKKMHw3vdySSytDoWcsXfUPNvSW4GNQcgA3k4V+741spUVa0kElB0fwD4htNDnjEwsEkAZxtyKRztK773FFcbfUfBoJAj6GsNkKwJzXlhAmzpWfTwhRIFnPCpXf8aOD/IRjXSd/AhUAO1LLgLos=
X-Gm-Message-State: AOJu0YyVr8D8aTN3AsKi5MTkbI+ETPboRkITKyi31uZXtp7shRbDFjct
	TfiUcwVZ+Ay5YhV7bwS6+4UzYAL+m0x4/5LUtYwf4kuu7tAZbeG0JeItREuz8sqnDrsZA2qeiTN
	xRtZE+HXyocLjRYPOJs5fQESe6dY=
X-Google-Smtp-Source: AGHT+IHNxy9sJsnZs3KQVfU0+czeg8tBpsYhbjwNsSaDNt4tlgSyRo9Mz2ssjEN7kjA5vVRJEg5DihQkgyMA2Jl/jC4=
X-Received: by 2002:a05:6512:1251:b0:516:cec0:1fc0 with SMTP id
 fb17-20020a056512125100b00516cec01fc0mr104453lfb.63.1713474094462; Thu, 18
 Apr 2024 14:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411160051.2093261-1-rppt@kernel.org> <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net> <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org> <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
 <ZiE91CJcNw7gBj9g@kernel.org> <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org>
In-Reply-To: <ZiFd567L4Zzm2okO@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 18 Apr 2024 14:01:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
Message-ID: <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 10:54=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Thu, Apr 18, 2024 at 09:13:27AM -0700, Song Liu wrote:
> > On Thu, Apr 18, 2024 at 8:37=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > > > >
> > > > > I'm looking at execmem_types more as definition of the consumers,=
 maybe I
> > > > > should have named the enum execmem_consumer at the first place.
> > > >
> > > > I think looking at execmem_type from consumers' point of view adds
> > > > unnecessary complexity. IIUC, for most (if not all) archs, ftrace, =
kprobe,
> > > > and bpf (and maybe also module text) all have the same requirements=
.
> > > > Did I miss something?
> > >
> > > It's enough to have one architecture with different constrains for kp=
robes
> > > and bpf to warrant a type for each.
> >
> > AFAICT, some of these constraints can be changed without too much work.
>
> But why?
> I honestly don't understand what are you trying to optimize here. A few
> lines of initialization in execmem_info?

IIUC, having separate EXECMEM_BPF and EXECMEM_KPROBE makes it
harder for bpf and kprobe to share the same ROX page. In many use cases,
a 2MiB page (assuming x86_64) is enough for all BPF, kprobe, ftrace, and
module text. It is not efficient if we have to allocate separate pages for =
each
of these use cases. If this is not a problem, the current approach works.

Thanks,
Song

