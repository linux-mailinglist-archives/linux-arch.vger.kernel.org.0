Return-Path: <linux-arch+bounces-7431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8A9865D6
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 19:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7138281F58
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA276088F;
	Wed, 25 Sep 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSCNkXh6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6C13B287;
	Wed, 25 Sep 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286195; cv=none; b=Tf/2mauNsd/MV244xJL1sfYz1OYA4x3maSQNHoNkaM8pbGCdxgtL4xAPrFReqh6+QIDe9d4WueCfFLhV31UP01Z+RYiSrt21vngQNnBr61IGcAvu7+m6efwIFloJo5pT4nnkO/PzrObw/HntNZzxA2dbWaiRRKg+WQrPIDdNe2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286195; c=relaxed/simple;
	bh=F9RWq/rXxSYntRpuJCLCsbi4j1kIhMfwU6j+9oqCDbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncNRihlKL8WJ3bYrXGEn1b89jEGMdBcDJMaF4Seeyg4CpF2JyAQx7SsHreZpAFrjAbZcHFKsaAAsrXItMZ5FuIRAHPgTyW5nxI39GNougXjiyPVEwYjNCxF6J3orxv5BfWaFb0o157+GvyqA3bzcWNvG5DekLUPjXmTHGzWaxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSCNkXh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95DFC4CEC9;
	Wed, 25 Sep 2024 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727286194;
	bh=F9RWq/rXxSYntRpuJCLCsbi4j1kIhMfwU6j+9oqCDbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XSCNkXh6Nl50YIGnJnoFX/5doL7AaTWE4fzrWVW0hSaX6cA89l8hRUPk0oOxn0/0a
	 7wc981hmfdlzSpnQY9sbk8hjpbuMbi04gUV4NOBjSxdcCRv0l+9U93iqbaEjA7uRhU
	 mKtjlR2QJTTICDfJYJBjgq/4Of69bkzakvzTKnEkZPXKAUWDroeMGQqp7mYfMFud4z
	 uQ0NYsGBrrIejc9vp+uWBUcVTSKskJLtavBZiLaEDucMz7IKhONgqP809zorLVgWwD
	 pZlBp4L5B0EYbSgxxe/GU/Rb8Xjee15oLOBozXq0EZiQYQCQOu5KSgugF3iAd1kCu0
	 d9ygt3KDerlZg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so918571fa.2;
        Wed, 25 Sep 2024 10:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0NZguSYRaESNaMLCxRnrnJBujIGWqp5RSwdEDBVFl1iZ6uxtaZDi3oGZDsBXrkwU5CuUl8Ho9pDnMVj/t@vger.kernel.org, AJvYcCU4rkrjglJdW6N/3Tn4CviyNkRnvcgek2M9ZvK3wixQjwZgiWeZL6mMOi/iVe3ajP0TVYRCDZem4P4Afvgx@vger.kernel.org, AJvYcCUB4gs1GDhVtdjY3yokCK6y2Mgfy+PrxOEWttNewzfDgaameMoAAhb8MbZJau4jU22bNWg=@vger.kernel.org, AJvYcCUXqqGfM9kEoabAXq2UFW69UprDDHfZ9t6Xx1hWC+z4fHTxOk118xgYFV07Lk0yzAwUCm/4mRovB04245+rVso=@vger.kernel.org, AJvYcCUZWD5pNGaRoLvjvqs4+YguaYVh1mp5YtOhJAbfOmk1OVUMWKRFPG2kJwUgqlq3huNb0a/WyHY3sz7h@vger.kernel.org, AJvYcCV2JhnMQ1eMwtgl9w5nyULw9XiHzHBf+b5ynFnpEqItN2vODXdrAn7SZsGOmIjab6+770+RNBaLbv0=@vger.kernel.org, AJvYcCVPAf3T4PLp45gATMgqSOItD7FjcPMvRMkqFrkXjgFs0qZBRalArhgeYFNksP02KvxhVX6t2ObpfyFhag==@vger.kernel.org, AJvYcCVgvSe7X2bfsHYoKn4QERQRqami54TlaGT3X+HKpxzfiNzbdVKALpHoMr436/g2uGxlA+00wRPoCEqv@vger.kernel.org, AJvYcCWmfYSzVKmxZYYq7DzySb+Ar/wVAXL23NPMPIyRThI0KJwXh7txuEr7akcDCitfXLRgqM6490aoXpSAveult5Zp1g==@vger.kernel.org, AJvYcCWtTb3O21Ie4t0MKjEk3TQq
 4Ulnn7rzsckBX1+eLPIT/G9+I4zRUx6U7IFC5JwQuoVSr7NONcSMrEE9q60z@vger.kernel.org
X-Gm-Message-State: AOJu0YzU54WlhGCv2KZbv0ekJIVdl33DEHGM70dlZvYCaxwjNa0P5XbN
	n4cDTL8XpI0Q7MVlaXf5LPM7qW1kWersdyft8s7ViN+Pa9Jc5/mKzoBKgqzSxZ581vJOFpRfxqh
	0TrMWsb4TBnv1zxSWMzN9OtxcoV4=
X-Google-Smtp-Source: AGHT+IE+in2ujKNOqfeviyH74B95luqIkWPFYLgeNJlVInDDisJWQsgCamgzHX+iXC0QURdLGLDiXb1g2DagGfPNhfo=
X-Received: by 2002:a05:651c:1504:b0:2f6:5f7b:e5e0 with SMTP id
 38308e7fff4ca-2f915ff58a0mr23471981fa.21.1727286193113; Wed, 25 Sep 2024
 10:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-35-ardb+git@google.com> <CAP-5=fXw1rcgWgMeDSVqiDYh2XYApyaJpNvukvJ7vMs7ZPMr6g@mail.gmail.com>
In-Reply-To: <CAP-5=fXw1rcgWgMeDSVqiDYh2XYApyaJpNvukvJ7vMs7ZPMr6g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 19:43:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmssrOhu20aLW4v88YVdkCfbeRg6arkgUoDNHm-4vbMA@mail.gmail.com>
Message-ID: <CAMj1kXEmssrOhu20aLW4v88YVdkCfbeRg6arkgUoDNHm-4vbMA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
To: Ian Rogers <irogers@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Sept 2024 at 17:54, Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 25, 2024 at 8:02=E2=80=AFAM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Specify the guard symbol for the stack cookie explicitly, rather than
> > positioning it exactly 40 bytes into the per-CPU area. Doing so removes
> > the need for the per-CPU region to be absolute rather than relative to
> > the placement of the per-CPU template region in the kernel image, and
> > this allows the special handling for absolute per-CPU symbols to be
> > removed entirely.
> >
> > This is a worthwhile cleanup in itself, but it is also a prerequisite
> > for PIE codegen and PIE linking, which can replace our bespoke and
> > rather clunky runtime relocation handling.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/Makefile                     |  4 ++++
> >  arch/x86/include/asm/init.h           |  2 +-
> >  arch/x86/include/asm/processor.h      | 11 +++--------
> >  arch/x86/include/asm/stackprotector.h |  4 ----
> >  tools/perf/util/annotate.c            |  4 ++--
> >  5 files changed, 10 insertions(+), 15 deletions(-)
> >
...
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 37ce43c4eb8f..7ecfedf5edb9 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2485,10 +2485,10 @@ static bool is_stack_operation(struct arch *arc=
h, struct disasm_line *dl)
> >
> >  static bool is_stack_canary(struct arch *arch, struct annotated_op_loc=
 *loc)
> >  {
> > -       /* On x86_64, %gs:40 is used for stack canary */
> > +       /* On x86_64, %gs:0 is used for stack canary */
> >         if (arch__is(arch, "x86")) {
> >                 if (loc->segment =3D=3D INSN_SEG_X86_GS && loc->imm &&
> > -                   loc->offset =3D=3D 40)
> > +                   loc->offset =3D=3D 0)
>
> As a new perf tool  can run on old kernels we may need to have this be
> something like:
> (loc->offset =3D=3D 40 /* pre v6.xx kernels */ || loc->offset =3D=3D 0 /*
> v6.xx and later */ )
>
> We could make this dependent on the kernel by processing the os_release s=
tring:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/env.h#n55
> but that could well be more trouble than it is worth.
>

Yeah. I also wonder what the purpose of this feature is. At the end of
this series, the stack cookie will no longer be at a fixed offset of
%GS anyway, and so perf will not be able to identify it in the same
manner. So it is probably better to just leave this in place, as the
%gs:0 case will not exist in the field (assuming that the series lands
all at once).

Any idea why this deviates from other architectures? Is x86_64 the
only arch that needs to identify stack canary accesses in perf? We
could rename the symbol to something identifiable, and do it across
all architectures, if this really serves a need (and assuming that
perf has insight into the symbol table).

