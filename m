Return-Path: <linux-arch+bounces-3781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4B8A8F5B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EBB1C20D1B
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2F85945;
	Wed, 17 Apr 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9dcUgih"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE38004A;
	Wed, 17 Apr 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396784; cv=none; b=tStEU1qZ3kPrUPt4zO2FXdihlFei6FjD0B7bp6AF4aFqa8loJsyyEiDZ9bwaVQizWc+Gyn9cZudEgKIXgJFKeLBxr4gm9+zCi8JB/wmFRXpVNXDYKJ3Fa8RUol4F1DJw95aPiD4F4oGxI3DN0un9ZLK8sxda7khEFwYtjY9R0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396784; c=relaxed/simple;
	bh=UVEJ59zmDjoboUO24xHkWUbtsfOaV4nMW96i+du0QWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hD+sh86VP2lCUppSurKD/L+rUY8cfZvRrMZUmdGsKcHdRpy92xeEQMLXVngZYg1M372dbwOIOli+rjcX/qwOmPWC2CXT2pbmYmwkMbf/QVmu408XchGLSPtmJSX1h7DzIPdWLqPzu5msbdk/LP1Tims5JIGYosyhge3mjQMIvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9dcUgih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E66C2BD11;
	Wed, 17 Apr 2024 23:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713396782;
	bh=UVEJ59zmDjoboUO24xHkWUbtsfOaV4nMW96i+du0QWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g9dcUgihUruqLdH2UkphJBhOp4CI2upjvdLl3d3rVz9siUPLfDQYchyou7LXngIUI
	 cWzssC+Ais5exj0vlxdgkfD0UISDabYE9ps2nLAsnUvPuJqZuWrDEKlEQm/130dxlJ
	 TrDcK7sck1xghtXie5KS50aVdgaMGiZE0PmL7090xIdMdRRtto0B1IoLe8MFPUV77p
	 MjHgPTklEJZLkSAT7P4KNSPweSGMUIkieLAdyvPoe4eF1OoYaNQIWGFhr3Y6mGm6h+
	 jJ7M8h436v/tDSG5Z2WP2ZPQpJ7Xt9Fh8ZQRH+KDS3CTVxJrkYmgSzmsULNtE2/7ia
	 VcpAfL6YqmCUQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518931f8d23so181559e87.3;
        Wed, 17 Apr 2024 16:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU+Mf3njgqRifWxHNpROfCS/UruBBh8dyGnOStdbmcfQ1BA9TTxFeQZdcP/NktvCH9tRvk1GBXhEnQ2/Id0n1nOAs1N5KzdtGf38Ohka637wbiMGMiwxcUEx8ULsm3PjZvZ7PEP7eR5MfYnqTqQnCJxSJMNOZjKdGP7f21H7fJENmcgHGWiTS+nQor5G1Zoydv+JRjRyXK3Y+sniFHtakwH+szWz+/xo7xbh5c2S+4XHf/8ERz1U6Viutvs1sSGfogDyA5Ugcu0XyAcMAOZd63H5JW3JkcosODo9URBruOpi9rnIJON0yn5nwZtipqIcfT1wqJ5XRDtBfCsSi4FRjbvwoox2BI/7N5bh8SRp4o5AEvUvIewouxPYy0FxtwnBdtn9/ju33Cc+RjExNDt6BocTVAmFtotyjmzPDTICgvOabDu1BU1vVbUWk=
X-Gm-Message-State: AOJu0Yxp3ZJcwr3NGUg945EqKE2eQ6SFNdNTi+8iMeKrnZK6kQzGpujY
	QXpq+nG8gzn9qAhGZ/VNMh1jqtO+K9ut5wM42wMW9u9csx75aIvPH9fMyD7Oy7nwS3xLPFU3Qw6
	8AfGAYq/KVgTrYxBdx/hr/fFXt98=
X-Google-Smtp-Source: AGHT+IEHuhOgcI3i5xgKWDt/RXWKyZ/pV78ei3ikSzZKT8X4nbojHe59GGn0FqOU5qFFQVvC8y10X+N0SPB8sxHbE0Q=
X-Received: by 2002:a05:6512:3184:b0:519:b95:22b5 with SMTP id
 i4-20020a056512318400b005190b9522b5mr446945lfe.51.1713396780753; Wed, 17 Apr
 2024 16:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411160051.2093261-1-rppt@kernel.org> <20240411160051.2093261-6-rppt@kernel.org>
 <20240415075241.GF40213@noisy.programming.kicks-ass.net> <Zh1lnIdgFeM1o8S5@FVFF77S0Q05N.cambridge.arm.com>
 <Zh4nJp8rv1qRBs8m@kernel.org>
In-Reply-To: <Zh4nJp8rv1qRBs8m@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Apr 2024 16:32:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
Message-ID: <CAPhsuW6Pbg2k_Gu4dsBx+H8H5XCHvNdtEZJBPiG_eT0qqr9D1w@mail.gmail.com>
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

On Tue, Apr 16, 2024 at 12:23=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Mon, Apr 15, 2024 at 06:36:39PM +0100, Mark Rutland wrote:
> > On Mon, Apr 15, 2024 at 09:52:41AM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 11, 2024 at 07:00:41PM +0300, Mike Rapoport wrote:
> > > > +/**
> > > > + * enum execmem_type - types of executable memory ranges
> > > > + *
> > > > + * There are several subsystems that allocate executable memory.
> > > > + * Architectures define different restrictions on placement,
> > > > + * permissions, alignment and other parameters for memory that can=
 be used
> > > > + * by these subsystems.
> > > > + * Types in this enum identify subsystems that allocate executable=
 memory
> > > > + * and let architectures define parameters for ranges suitable for
> > > > + * allocations by each subsystem.
> > > > + *
> > > > + * @EXECMEM_DEFAULT: default parameters that would be used for typ=
es that
> > > > + * are not explcitly defined.
> > > > + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> > > > + * @EXECMEM_KPROBES: parameters for kprobes
> > > > + * @EXECMEM_FTRACE: parameters for ftrace
> > > > + * @EXECMEM_BPF: parameters for BPF
> > > > + * @EXECMEM_TYPE_MAX:
> > > > + */
> > > > +enum execmem_type {
> > > > + EXECMEM_DEFAULT,
> > > > + EXECMEM_MODULE_TEXT =3D EXECMEM_DEFAULT,
> > > > + EXECMEM_KPROBES,
> > > > + EXECMEM_FTRACE,
> > > > + EXECMEM_BPF,
> > > > + EXECMEM_TYPE_MAX,
> > > > +};
> > >
> > > Can we please get a break-down of how all these types are actually
> > > different from one another?
> > >
> > > I'm thinking some platforms have a tiny immediate space (arm64 comes =
to
> > > mind) and has less strict placement constraints for some of them?
> >
> > Yeah, and really I'd *much* rather deal with that in arch code, as I ha=
ve said
> > several times.
> >
> > For arm64 we have two bsaic restrictions:
> >
> > 1) Direct branches can go +/-128M
> >    We can expand this range by having direct branches go to PLTs, at a
> >    performance cost.
> >
> > 2) PREL32 relocations can go +/-2G
> >    We cannot expand this further.
> >
> > * We don't need to allocate memory for ftrace. We do not use trampoline=
s.
> >
> > * Kprobes XOL areas don't care about either of those; we don't place an=
y
> >   PC-relative instructions in those. Maybe we want to in future.
> >
> > * Modules care about both; we'd *prefer* to place them within +/-128M o=
f all
> >   other kernel/module code, but if there's no space we can use PLTs and=
 expand
> >   that to +/-2G. Since modules can refreence other modules, that ends u=
p
> >   actually being halved, and modules have to fit within some 2G window =
that
> >   also covers the kernel.

Is +/- 2G enough for all realistic use cases? If so, I guess we don't
really need
EXECMEM_ANYWHERE below?

> >
> > * I'm not sure about BPF's requirements; it seems happy doing the same =
as
> >   modules.
>
> BPF are happy with vmalloc().
>
> > So if we *must* use a common execmem allocator, what we'd reall want is=
 our own
> > types, e.g.
> >
> >       EXECMEM_ANYWHERE
> >       EXECMEM_NOPLT
> >       EXECMEM_PREL32
> >
> > ... and then we use those in arch code to implement module_alloc() and =
friends.
>
> I'm looking at execmem_types more as definition of the consumers, maybe I
> should have named the enum execmem_consumer at the first place.

I think looking at execmem_type from consumers' point of view adds
unnecessary complexity. IIUC, for most (if not all) archs, ftrace, kprobe,
and bpf (and maybe also module text) all have the same requirements.
Did I miss something?

IOW, we have

enum execmem_type {
        EXECMEM_DEFAULT,
        EXECMEM_TEXT,
        EXECMEM_KPROBES =3D EXECMEM_TEXT,
        EXECMEM_FTRACE =3D EXECMEM_TEXT,
        EXECMEM_BPF =3D EXECMEM_TEXT,      /* we may end up without
_KPROBE, _FTRACE, _BPF */
        EXECMEM_DATA,  /* rw */
        EXECMEM_RO_DATA,
        EXECMEM_RO_AFTER_INIT,
        EXECMEM_TYPE_MAX,
};

Does this make sense?

Thanks,
Song

