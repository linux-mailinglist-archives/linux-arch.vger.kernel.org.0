Return-Path: <linux-arch+bounces-3698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F0A8A56CE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0606F1C20E45
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481817C085;
	Mon, 15 Apr 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHA06EKo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DB76033;
	Mon, 15 Apr 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196470; cv=none; b=maqOi8/w8ApRjdUBl7+N+HKnq0fY2pXEZcsiMtmezA5NVKO+bj1qpCi70z41TzePonLoe/LCIpTzvPzNAO/Lz5LYuvCCs1ETiakzrv/bANh4Ft2lUSGHWqSi7ggdP6yqgc89puXlREshQSSPHHjsNNmEVDNagD280GI87zUQw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196470; c=relaxed/simple;
	bh=8c+SYgrvRngaG/lFXqJ0rfeZ6kkSQCqNuwsCJEg3GmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC2nm0WOuAL10p+AZyA3biYsJ+Mj/sTnJYrqoFn7jbxdt8mwbXG9gmyGw27/+TINiNVZmrTsO8r/1Qlple01uz9IMz+Bxr6bcle/Q0jYRJ86vVm1wNeJLDA8bbm9HMo6qQMeZJ9639G5HZH+IXyMOBjbqM7Mk2r+soXB5aKiSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHA06EKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969D7C3277B;
	Mon, 15 Apr 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196469;
	bh=8c+SYgrvRngaG/lFXqJ0rfeZ6kkSQCqNuwsCJEg3GmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MHA06EKoO7MrUWj/nPmINQgS9zR3tBDS40OTFTx0FLk61K+OPsdCqMcEDRWwxpJCu
	 OA+irVxOr8jJlbXdqv92CzguA8ij3sqTfVd2CgDaYozOwRvceVaEOwU8CIt0J/PVKr
	 2eJYxmAJQPiEA9rcsEswDqvghXF2YTwmnmcmUI9IRAcvS8u3i5L3gc/tOxYIvlnD4i
	 aHiFaNHI7fTsDs5BRnPycFMV/MGMf/nYfudMPLRcFVwc0JoJCGugeCPdDKltjfTErL
	 43M2xaiNyCMlP4oGyigOnL6Paja4n4Sbky7twiPaNylKWIPIrJ7w2F50eI39/Fz73a
	 ZkwaiuyZFpsew==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2da01cb187cso61492511fa.0;
        Mon, 15 Apr 2024 08:54:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvC4lH5Hc/fWoOHyF6C7JUKRhZcLWMD7PUK8I8HVevLDpqLfEK2DvcH6qFultkp9I2zBYbg7PSX/po+UmF1Ysxt50ZgjZpHN3jKn7SyMBZ0bcThCrWsPEyWipY1CKL3/A0vqsnptO6aEVVgh72Jg/5edlyEZk0abtO3aninD4dlYTlQHrius8iKiDadhXmttmmxfiOar0oqIrOCA==
X-Gm-Message-State: AOJu0YzleusBl0mW3FmR/i0lfDGSmRKgLIpf/byqFJQX7YfjwafFpx+c
	+X9di7kXFgVT52vJ2ALav8F9iLoxbxcYulJI2w7+PAgN7V4hEYCd4iSOFcULEDV3cUGWsphshv1
	mwPcW0Gm74PHnpCBosHnPp1lJniI=
X-Google-Smtp-Source: AGHT+IE2/Qe4CeOwNpuDt2+IxOmt8vZKorCXxR4H+XPcjvOJPTKKrImNHxVaRmX9CI/7i55Z0gDFncEWreJVd3F7xv0=
X-Received: by 2002:a2e:97d4:0:b0:2d8:41c5:ad64 with SMTP id
 m20-20020a2e97d4000000b002d841c5ad64mr7041107ljj.13.1713196467919; Mon, 15
 Apr 2024 08:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415075837.2349766-5-ardb+git@google.com> <20240415075837.2349766-8-ardb+git@google.com>
 <CAK7LNARthBeTotjUzC97zO5uL=YF31Bu_pJafyb8spcUm9sAcQ@mail.gmail.com>
 <CAMj1kXFyRwfRFSK=acypXWAoFWwdcF9F+E9tsrHDycNyNdW0Og@mail.gmail.com> <CAK7LNARH45pmfdAYcJucsVPa_HJnQEh5=hcdO5u38yrhMX1wJw@mail.gmail.com>
In-Reply-To: <CAK7LNARH45pmfdAYcJucsVPa_HJnQEh5=hcdO5u38yrhMX1wJw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Apr 2024 17:54:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGEbaqzD2nCqOxdBgVZ+sjwCSZyqthdb=FQx2xhySbDEQ@mail.gmail.com>
Message-ID: <CAMj1kXGEbaqzD2nCqOxdBgVZ+sjwCSZyqthdb=FQx2xhySbDEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] btf: Avoid weak external references
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 at 17:32, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 11:59=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Mon, 15 Apr 2024 at 16:55, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Mon, Apr 15, 2024 at 4:58=E2=80=AFPM Ard Biesheuvel <ardb+git@goog=
le.com> wrote:
> > > >
> > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > If the BTF code is enabled in the build configuration, the start/st=
op
> > > > BTF markers are guaranteed to exist in the final link but not durin=
g the
> > > > first linker pass.
> > > >
> > > > Avoid GOT based relocations to these markers in the final executabl=
e by
> > > > providing preliminary definitions that will be used by the first li=
nker
> > > > pass, and superseded by the actual definitions in the subsequent on=
es.
> > > >
> > > > Make the preliminary definitions dependent on CONFIG_DEBUG_INFO_BTF=
 so
> > > > that inadvertent references to this section will trigger a link fai=
lure
> > > > if they occur in code that does not honour CONFIG_DEBUG_INFO_BTF.
> > > >
> > > > Note that Clang will notice that taking the address of__start_BTF c=
annot
> > > > yield NULL any longer, so testing for that condition is no longer
> > > > needed.
> > > >
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  include/asm-generic/vmlinux.lds.h | 9 +++++++++
> > > >  kernel/bpf/btf.c                  | 7 +++++--
> > > >  kernel/bpf/sysfs_btf.c            | 6 +++---
> > > >  3 files changed, 17 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generi=
c/vmlinux.lds.h
> > > > index e8449be62058..4cb3d88449e5 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -456,6 +456,7 @@
> > > >   * independent code.
> > > >   */
> > > >  #define PRELIMINARY_SYMBOL_DEFINITIONS                            =
     \
> > > > +       PRELIMINARY_BTF_DEFINITIONS                                =
     \
> > > >         PROVIDE(kallsyms_addresses =3D .);                         =
       \
> > > >         PROVIDE(kallsyms_offsets =3D .);                           =
       \
> > > >         PROVIDE(kallsyms_names =3D .);                             =
       \
> > > > @@ -466,6 +467,14 @@
> > > >         PROVIDE(kallsyms_markers =3D .);                           =
       \
> > > >         PROVIDE(kallsyms_seqs_of_names =3D .);
> > > >
> > > > +#ifdef CONFIG_DEBUG_INFO_BTF
> > > > +#define PRELIMINARY_BTF_DEFINITIONS                               =
     \
> > > > +       PROVIDE(__start_BTF =3D .);                                =
       \
> > > > +       PROVIDE(__stop_BTF =3D .);
> > > > +#else
> > > > +#define PRELIMINARY_BTF_DEFINITIONS
> > > > +#endif
> > > > +
> > >
> > >
> > >
> > > Is this necessary?
> > >
> >
> > I think so.
> >
> > This actually resulted in Jiri's build failure with v2, and the
> > realization that there was dead code in btf_parse_vmlinux() that
> > happily tried to load the contents of the BTF section if
> > CONFIG_DEBUG_INFO_BTF was not enabled to begin with.
> >
> > So this is another pitfall with weak references: the symbol may
> > unexpectedly be missing altogether rather than only during the first
> > linker pass.
> >
> > >
> > >
> > > The following code (BOUNDED_SECTION_BY)
> > > produces __start_BTF and __stop_BTF symbols
> > > under the same condition.
> > >
> >
> > Indeed. So if CONFIG_DEBUG_INFO_BTF=3Dn, code can still link to
> > __start_BTF and __stop_BTF even though BTF is not enabled.
>
>
>
> I am talking about the case for CONFIG_DEBUG_INFO_BTF=3Dy.
>
> PROVIDE() is meaningless because __start_BTF and __stop_BTF
> are produced by the existing code.
>
> (The code was a bit clearer before commit
> 9b351be25360c5cedfb98b88d6dfd89327849e52)
>
>
>
> So, v4 of this patch will look like 2/3, right?
>
>
> Just drop __weak attribute.
>
> You still need
>
> if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
>              return ERR_PTR(-ENOENT);
>
> But, you do not need to modify vmlinux.lds.h
>

OK, I see what you mean now.

The PROVIDE() is indeed unnecessary - I'll drop that bit in v4.

