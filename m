Return-Path: <linux-arch+bounces-3696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0928A5676
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E19B21B9C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61B78C78;
	Mon, 15 Apr 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTSWbLr1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C346BB4A;
	Mon, 15 Apr 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195143; cv=none; b=mY2dlrR56mvy0i6kWHXSXjEq8/9EAlR7FYSKCCLu8j/lzX7n0B031x1wLTOwz+BNsrWFmpd1WJP2M/s2oBesLPsYD1lC+IPU8oebXwbV3HWhCPRlsdCkDTmeYLc0y/SOYcvMkmdxWaI/cHREU88naiwhfCveeoA7Wzm2uV3iOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195143; c=relaxed/simple;
	bh=p/ox70M6LKphRZZs4AqoipOwGZh27SBhtG4itjdO9FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp2CpOK4p+GhJGnBqNAtXF14cx38uYto3jhLRSeln017AyhFtSYk3SXymJQK50n7ThVpdXS60j5+Ol83jUbncGGPlvYkYnWpW2aIy1dpBCl85MDv10fFQifUdekDTCIZ130/99QRJ3OgGA3vmBGv4S80SKmi7DsaI3pyYwJcMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTSWbLr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED6BC2BD10;
	Mon, 15 Apr 2024 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713195143;
	bh=p/ox70M6LKphRZZs4AqoipOwGZh27SBhtG4itjdO9FQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTSWbLr1bCJhGaGO24fMjhlCdk51Ka/FBhZ+NI7yc631nFKc7WcYOTOdF5uqwqNvN
	 vAyrPe39IVydQvXFyJUL5giTv+IQ6WxCdZDsaYdS/Y7XEfj6sPNVdWi3rIHbsTQSLw
	 nUsW3lV8AZBrLjQRF4dDf/cyjgom+68gQTcksJ91X0k/Zng7w8mw/dTMPaiJTkJ7BS
	 Zg7pQefL3IZmZpKZQQIDfOQQk1+5m7QkAfaAW89HNRGw3NyPnf4B/ThXppJFD6f7o1
	 bSXa1bW5ofPzVwx8xsUW75GvaGfBnqSCXSX4AYULLj0VCnSTSpPpbfhySGgDyGNN1J
	 330mvGEbrqlSg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so40519071fa.3;
        Mon, 15 Apr 2024 08:32:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoqnIk9ghdQ+zTDVKj3Qem0LPbO+F2xT9VkB2t+mF3qkrZrCTIj9weNJkRvZuSJGYQ8SDt2WupPgoMGPJAJIq2kZbLSVJsHsafNNH1nqywSW0aSOvJ8mlfRnUPPQWHzBtX+mW7Gs+5246OW1i4qrJUr6Oc/AnDSCloAFCAB9tHyLCtFErRcktmuO6EucaKl4SYFfNpHYETAbMR4w==
X-Gm-Message-State: AOJu0Ywcou6dg62Oee4kfUncYT1lzO30YG9NgSckzfrTv89O+Zig/i7e
	PhnK14cfnj5X1NAwxbVOgErYMoTdrRWe2kD6tTJUmuRksk78OgrAehBsDtuYaAUJJAdq2GtfD8Q
	R6+euw7utLhr6HEIQwPhqiW2COMQ=
X-Google-Smtp-Source: AGHT+IGCtaC3TclrPZ0bu0nX3lwb+J3dkeFac2KQqVDOra3tYoW20ehJXk/HYM2Chp/+Gp0/8pJ0aQXHLyK7QQdQsbs=
X-Received: by 2002:a2e:8758:0:b0:2d8:3bef:129 with SMTP id
 q24-20020a2e8758000000b002d83bef0129mr7509002ljj.10.1713195140919; Mon, 15
 Apr 2024 08:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com> <20240415075837.2349766-8-ardb+git@google.com>
 <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com> <CAMj1kXFyRwfRFSK=acypXWAoFWwdcF9F+E9tsrHDycNyNdW0Og@mail.gmail.com>
In-Reply-To: <CAMj1kXFyRwfRFSK=acypXWAoFWwdcF9F+E9tsrHDycNyNdW0Og@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Apr 2024 00:31:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH45pmfdAYcJucsVPa_HJnQEh5=hcdO5u38yrhMX1wJw@mail.gmail.com>
Message-ID: <CAK7LNARH45pmfdAYcJucsVPa_HJnQEh5=hcdO5u38yrhMX1wJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btf: Avoid weak external references
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:59=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Mon, 15 Apr 2024 at 16:55, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Mon, Apr 15, 2024 at 4:58=E2=80=AFPM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > If the BTF code is enabled in the build configuration, the start/stop
> > > BTF markers are guaranteed to exist in the final link but not during =
the
> > > first linker pass.
> > >
> > > Avoid GOT based relocations to these markers in the final executable =
by
> > > providing preliminary definitions that will be used by the first link=
er
> > > pass, and superseded by the actual definitions in the subsequent ones=
.
> > >
> > > Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF s=
o
> > > that inadvertent references to this section will trigger a link failu=
re
> > > if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
> > >
> > > Note that Clang will notice that taking the address of__start_BTF can=
not
> > > yield NULL any longer, so testing for that condition is no longer
> > > needed.
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 9 +++++++++
> > >  kernel/bpf/btf.c                  | 7 +++++--
> > >  kernel/bpf/sysfs_btf.c            | 6 +++---
> > >  3 files changed, 17 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/=
vmlinux.lds.h
> > > index e8449be62058..4cb3d88449e5 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -456,6 +456,7 @@
> > >   * independent code.
> > >   */
> > >  #define PRELIMINARY_SYMBOL_DEFINITIONS                              =
   \
> > > +       PRELIMINARY_BTF_DEFINITIONS                                  =
   \
> > >         PROVIDE(kallsyms_addresses =3D .);                           =
     \
> > >         PROVIDE(kallsyms_offsets =3D .);                             =
     \
> > >         PROVIDE(kallsyms_names =3D .);                               =
     \
> > > @@ -466,6 +467,14 @@
> > >         PROVIDE(kallsyms_markers =3D .);                             =
     \
> > >         PROVIDE(kallsyms_seqs_of_names =3D .);
> > >
> > > +#ifdef CONFIG_DEBUG_INFO_BTF
> > > +#define PRELIMINARY_BTF_DEFINITIONS                                 =
   \
> > > +       PROVIDE(__start_BTF =3D .);                                  =
     \
> > > +       PROVIDE(__stop_BTF =3D .);
> > > +#else
> > > +#define PRELIMINARY_BTF_DEFINITIONS
> > > +#endif
> > > +
> >
> >
> >
> > Is this necessary?
> >
>
> I think so.
>
> This actually resulted in Jiri's build failure with v2, and the
> realization that there was dead code in btf_parse_vmlinux() that
> happily tried to load the contents of the BTF section if
> CONFIG_DEBUG_INFO_BTF was not enabled to begin with.
>
> So this is another pitfall with weak references: the symbol may
> unexpectedly be missing altogether rather than only during the first
> linker pass.
>
> >
> >
> > The following code (BOUNDED_SECTION_BY)
> > produces __start_BTF and __stop_BTF symbols
> > under the same condition.
> >
>
> Indeed. So if CONFIG_DEBUG_INFO_BTF=3Dn, code can still link to
> __start_BTF and __stop_BTF even though BTF is not enabled.



I am talking about the case for CONFIG_DEBUG_INFO_BTF=3Dy.

PROVIDE() is meaningless because __start_BTF and __stop_BTF
are produced by the existing code.

(The code was a bit clearer before commit
9b351be25360c5cedfb98b88d6dfd89327849e52)



So, v4 of this patch will look like 2/3, right?


Just drop __weak attribute.

You still need

if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
             return ERR_PTR(-ENOENT);

But, you do not need to modify vmlinux.lds.h







--
Best Regards
Masahiro Yamada

