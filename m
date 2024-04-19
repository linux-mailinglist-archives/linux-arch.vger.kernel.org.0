Return-Path: <linux-arch+bounces-3826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD08AB27C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D4428668E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404B130481;
	Fri, 19 Apr 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fByrY0sH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32F4D110;
	Fri, 19 Apr 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542094; cv=none; b=GZogLUkbWZcpLeaYCu7dfl1IEws30okDqJwNaU1pp7V+DgVj4YBgsqv/RPhtwYtPw5bV2b/Nn4pLREx6cc3bN+fw4xG10uJ8tnh+oOjUolqTcfQRpBgObGixqBZT6AIEKttgLE51HihqyJ00shVlAOzhmjNufP60kXBctAXZGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542094; c=relaxed/simple;
	bh=PNzXHy/tRctT7iPO4Hxb0l/pQDROtMOUfttALn8mdWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxcRdP1wmiWhup38lOTDE3rtLqTkgnEcNdlkKrxU3XlK8e7aJv4HecJH0mc8Bxx5Af4JmSE1ubVAdaZy7kCyqAIMDUtojakWCSoJoDRGu5bnxAYCdtBzFfXq11r6W0izBzshyRYr1JSWDC/WvdPZZEuDToj32vSeKp5fiA8HsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fByrY0sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB14EC4AF0C;
	Fri, 19 Apr 2024 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713542093;
	bh=PNzXHy/tRctT7iPO4Hxb0l/pQDROtMOUfttALn8mdWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fByrY0sH7ehrB3/T0K5Y9m7KyxBgkDIAjJKJuL060ZMwVeA4sxNa1GRVnnFs7o9P/
	 SDdNCkMFupB33Yh4SqtQQRDg1TlSaSNl85qqrhlrbsWngFTomx7MtHK/VLSFjgeKVE
	 WNXe0s/Zd7ZSyO8H9gkYMP5F2v3IZpievZBQF2TWpbBzXIh05HyDtTK2ztWOy1AyUk
	 8uKc4i1XerG3TPen7GqtNdAuJI8XdGlZHRUBtPaskIQyoqsVYLmOl4HnlPuLJecHlE
	 WlI2arE63IBCyRuPBGezgCucj+RhNyvFxP1+bhxs9GMQJQgOXAjn2wix5rZL/xXKdE
	 HGfwsw/94YlBg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51abd580902so740582e87.1;
        Fri, 19 Apr 2024 08:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa3apZAcErtrAYm9kCGGH7b5EHxRQGYbrJdPt05jNB+QXG51rb9gkY1tsQrNt8RIsyv415Yc2kTkhWK6mvhIfP97KTLuf4OQhlJIfy9j3E6yYK6wMTqPbXrQcJnOZa8KHbuXuaHGgvOy5ettOjdr6e+C8ZgUL4AiwpNGcL5Zk9iaH61JAultjYsHw/QYjziVYXelXMlZcu3djtASeL6kKnKJR5LpIPOYNdE+QKoeI+H7VcR+Ygx1k/5gQKkkgQ7GRCovyM+s6COMyQfaucZ48T3H+01PZVowPAZ780i598z0os5XzdDz1+MZK2s2XrfWaTlE+sNa4aMiZYbusgEBxKB9U8gByesml/d8A2CvGFWajSsp7F0FWM4zzqmiSpzPn1xpQqSYWGOPBl/tpTCVrYNpASlRZVnL9I0ucaU0BHZmwJDWnmOslBrqI=
X-Gm-Message-State: AOJu0YwzwSIXOL1lwLx1RpSeVcmnS/tsXUdOv0hyQs698d7F4H3OCX/O
	ZSd4XS6q9+YHuUbcrvH55H1Uk1J9BYzXCfERuBEYxgLVjoCoHEKs3DU7SnnmHu3MgsXH4FvTMln
	XD27rqGH3DMHNgjDUSYdCoUz5GJE=
X-Google-Smtp-Source: AGHT+IGasMltj1XTiWxWNEYkPSMxwP63y2jyTt8tLpdHn26unpYTPPkYdRp/dT6gEwD6NrNiKXUtIlL7PF9cDNubUq4=
X-Received: by 2002:ac2:5f9b:0:b0:519:ab33:7459 with SMTP id
 r27-20020ac25f9b000000b00519ab337459mr752898lfe.30.1713542091952; Fri, 19 Apr
 2024 08:54:51 -0700 (PDT)
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
 <ZiFd567L4Zzm2okO@kernel.org> <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org>
In-Reply-To: <ZiIVVBgaDN4RsroT@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Apr 2024 08:54:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
Message-ID: <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 11:56=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Thu, Apr 18, 2024 at 02:01:22PM -0700, Song Liu wrote:
> > On Thu, Apr 18, 2024 at 10:54=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 09:13:27AM -0700, Song Liu wrote:
> > > > On Thu, Apr 18, 2024 at 8:37=E2=80=AFAM Mike Rapoport <rppt@kernel.=
org> wrote:
> > > > > > >
> > > > > > > I'm looking at execmem_types more as definition of the consum=
ers, maybe I
> > > > > > > should have named the enum execmem_consumer at the first plac=
e.
> > > > > >
> > > > > > I think looking at execmem_type from consumers' point of view a=
dds
> > > > > > unnecessary complexity. IIUC, for most (if not all) archs, ftra=
ce, kprobe,
> > > > > > and bpf (and maybe also module text) all have the same requirem=
ents.
> > > > > > Did I miss something?
> > > > >
> > > > > It's enough to have one architecture with different constrains fo=
r kprobes
> > > > > and bpf to warrant a type for each.
> > > >
> > > > AFAICT, some of these constraints can be changed without too much w=
ork.
> > >
> > > But why?
> > > I honestly don't understand what are you trying to optimize here. A f=
ew
> > > lines of initialization in execmem_info?
> >
> > IIUC, having separate EXECMEM_BPF and EXECMEM_KPROBE makes it
> > harder for bpf and kprobe to share the same ROX page. In many use cases=
,
> > a 2MiB page (assuming x86_64) is enough for all BPF, kprobe, ftrace, an=
d
> > module text. It is not efficient if we have to allocate separate pages =
for each
> > of these use cases. If this is not a problem, the current approach work=
s.
>
> The caching of large ROX pages does not need to be per type.
>
> In the POC I've posted for caching of large ROX pages on x86 [1], the cac=
he is
> global and to make kprobes and bpf use it it's enough to set a flag in
> execmem_info.
>
> [1] https://lore.kernel.org/all/20240411160526.2093408-1-rppt@kernel.org

For the ROX to work, we need different users (module text, kprobe, etc.) to=
 have
the same execmem_range. From [1]:

static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
{
...
       p =3D __execmem_cache_alloc(size);
       if (p)
               return p;
      err =3D execmem_cache_populate(range, size);
...
}

We are calling __execmem_cache_alloc() without range. For this to work,
we can only call execmem_cache_alloc() with one execmem_range.

Did I miss something?

Thanks,
Song

