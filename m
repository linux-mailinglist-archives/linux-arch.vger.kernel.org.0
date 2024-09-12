Return-Path: <linux-arch+bounces-7222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D1975E12
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 02:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2181F22BFC
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B7257B;
	Thu, 12 Sep 2024 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB1NSZDL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CA4C85;
	Thu, 12 Sep 2024 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726101977; cv=none; b=ZEPIqnXh1B8fMuyRhjywsuNcA45uhYD+5EVuWqkDluR+E4EdrX04TPaq94A1VyjWd157OyEn7HQTEL2p1kIqGY1fVM/JMMJeL9bpjtlw6t0jwHNOtNIAFm65dvDPyQO6mVPQJjJLIoPmvzRVe1hpcW/iZaAWsX+9PEYRvB/aI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726101977; c=relaxed/simple;
	bh=rCTip0z8RW4T9O3sL3tYawuQAxSVn1R+UDt8fG0rfBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLKrYU6Np6wbimi0KCvgB6J77UqdYNFUoQZFV731eqo2T2rbWeDTj3laelTWJv9FgV6h01f67SoODBuHxVrpgPTyJ6syAc72EVAQX3T9EMHv+4HcFsdCKhuSqIeNb2H1nQDqv0AYK89KbD6znXTIUqFC+09BgTY0FJ5M5EHtE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB1NSZDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C5AC4CECD;
	Thu, 12 Sep 2024 00:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726101977;
	bh=rCTip0z8RW4T9O3sL3tYawuQAxSVn1R+UDt8fG0rfBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VB1NSZDLmJLYXgjMhVZp4X3/D8q938fh8TJ5msMRVPPG5e8YqL60zl/PejZumuLbu
	 RLc65k5MW8ZAy4W9nYGaYJQXW1OiU5S+d6OH474cQNXeeIPsTTIWyQrvovzhQi7VqP
	 4tPcCzhmnm9W7TR7kJNrScdYf+FAtI6dR9ZxfpPHkG1xX3izdOE4Q/defk2834m0n5
	 HgPCh5NjuhKo0f7ddA85wxt/Iu8LZi2xb5PV16fGYBbI9+4J2Onj3GlEUqh9/zh/Fm
	 DivkyvEI4BVw6mBGozAPvcDmN/+COz8kL766rw794WiXljC3BgDAjCzVZBORMe62w8
	 tp/RZEiZsq/rQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365928acd0so472637e87.2;
        Wed, 11 Sep 2024 17:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+mNaCdb6cQTnUamMrey1OmReXvmVvW+pwElE/AOAxorX6WH9TJ+QAje2lBHRAUKZiMUA=@vger.kernel.org, AJvYcCVzlLGGakm6wDcr+TX9uVBpA/3J46/L7Uv23azIehXwUDJXUewrcpXiLp70q+f6jlFosqGzqp8wEYKzBi/b@vger.kernel.org, AJvYcCWuyNAOJX/CxK31sUmP8gs1e65mr/I+SUVQTs0oMFwaX4VIM5Q8Hyov/4bZK9kvSAApMN4JgRfjJDVUhg==@vger.kernel.org, AJvYcCX6doiXNKabbKRDuPiHtXVWHehtkN+sn5bHfAsdr4DXMasrCjH0G0WyDYWhwSqnBGnOSe2DYnH7Tdsq3A2R@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDYzsX3oOxPE/ArifJJPNp7ipe/yNlZ3oVz8WUokhwyN8ccwA
	QCTHf65Jr0Yb5Z23Hnfsgna2YjDJFzvjhJIg6EMnC/immZqg5cinddajTDORcfsK37FWfwlRRP7
	JYcsgiiEABwqU95YznkaD7UDNN7s=
X-Google-Smtp-Source: AGHT+IFW/U6JzNS0Bm4hp70ip1Ry319HSUQjP/Bsw523ptagVoYpWZ/J3vEQMKjpxaZJeWMPwLKyr+a8IXL/eVQilwo=
X-Received: by 2002:a05:6512:3b0e:b0:533:4656:d4cd with SMTP id
 2adb3069b0e04-53678fc1816mr607644e87.33.1726101975865; Wed, 11 Sep 2024
 17:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911110401.598586-1-masahiroy@kernel.org> <20240911110401.598586-2-masahiroy@kernel.org>
 <56fbf243-8e50-4760-9ed0-8d1f0f7e5ed3@oracle.com>
In-Reply-To: <56fbf243-8e50-4760-9ed0-8d1f0f7e5ed3@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 12 Sep 2024 09:45:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS3XKeeQwKNMnnXDpMK+T2Df9UNoMVQtajuwr6cUR4EzQ@mail.gmail.com>
Message-ID: <CAK7LNAS3XKeeQwKNMnnXDpMK+T2Df9UNoMVQtajuwr6cUR4EzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 11/09/2024 12:03, Masahiro Yamada wrote:
> > When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
> > DEBUG_INFO_BTF.
> >
> > When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selecte=
d,
> > DEBUG_INFO_BTF can be enabled without pahole installed, but a build err=
or
> > will occur in scripts/link-vmlinux.sh:
> >
> >     LD      .tmp_vmlinux1
> >   BTF: .tmp_vmlinux1: pahole (pahole) is not available
> >   Failed to generate BTF for vmlinux
> >   Try to disable CONFIG_DEBUG_INFO_BTF
> >
> > We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
> > discussed [1].
> >
> > However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
> > added CONFIG_PAHOLE_VERSION at all. Now several CONFIG options, as
> > well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
> > guarded by PAHOLE_VERSION.
> >
> > The remaining compile-time check in scripts/link-vmlinux.sh now appears
> > to be an awkward inconsistency.
> >
> > This commit adopts Nathan's original work.
> >
> > [1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancello=
r@gmail.com/
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Nice cleanup! For the series
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> One small thing below..
>
> > ---
> >
> >  lib/Kconfig.debug       |  3 ++-
> >  scripts/link-vmlinux.sh | 12 ------------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 5e2f30921cb2..eff408a88dfd 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -379,12 +379,13 @@ config DEBUG_INFO_BTF
> >       depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
> >       depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
> >       depends on BPF_SYSCALL
> > +     depends on PAHOLE_VERSION >=3D 116
> >       depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >=3D 121
> >       # pahole uses elfutils, which does not have support for Hexagon r=
elocations
> >       depends on !HEXAGON
> >       help
> >         Generate deduplicated BTF type information from DWARF debug inf=
o.
> > -       Turning this on expects presence of pahole tool, which will con=
vert
> > +       Turning this on requires presence of pahole tool, which will co=
nvert
> >         DWARF type info into equivalent deduplicated BTF type info.
> >
>
> One thing we lose from the change below is an explicit message about the
> minimal pahole version required. While it is codified in the
> dependendencies, given that we used to loudly warn about this,
> would it make sense to note it in the help text here; just a sentence
> like "BTF generation requires pahole v1.16 or later."? Thanks!


How about this help message?



help
  Generate deduplicated BTF type information from DWARF debug info.
  Turning this on requires pahole v1.16 or later (v1.21 or later
  for DWARF 5), which will convert DWARF type info into equivalent
  deduplicated BTF type info.








--=20
Best Regards
Masahiro Yamada

