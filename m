Return-Path: <linux-arch+bounces-3354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B716894C3A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD0B23191
	for <lists+linux-arch@lfdr.de>; Tue,  2 Apr 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721503839A;
	Tue,  2 Apr 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqp5pwk3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBB36AEF;
	Tue,  2 Apr 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041784; cv=none; b=SgLjKhwhqPqA+OdDb2z4NkXl71x+0YNNeeOp5xOKL4aXQFSOJXjiXzaHotQSP4rbHThVyjxdGVouNbaNGGE4sE2V0GctqTb/8590VLQ/o3CIZ4SeVG7TMofTfkmPkd9Gv4E8dMkpi6ic6CE21Vs1KfXttGT9e1fMMQ95wSDdfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041784; c=relaxed/simple;
	bh=VCUvCqRQ6NPxkleeuXpAuZ9rj+nemnrtawumWpPx3dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvbXn0l+qN82bkzdQxhnBrWUxmxJOZXTqT0SMP+kLn89ssXels7JO6o9T/TCVInStUpzLngqIVq0375mv4AxEOW5kWwMiaJ1HJSrs96nyEieayXa+mVBWM80VqdTFhlOOgJcMGnmpsZrM00AjP1J+ukxyAOXDfnDCI6AtPzef28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqp5pwk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C377FC433C7;
	Tue,  2 Apr 2024 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712041783;
	bh=VCUvCqRQ6NPxkleeuXpAuZ9rj+nemnrtawumWpPx3dQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qqp5pwk3FEsxLUFGnsCE3n/EcStsBfY+sZBuQym4gF1e38vx3Ng0JOcw2Kf9u/F+p
	 da0xYD4rV22JU9094FawtUcGlE1axz50QNHJ/SZkMcvGyQug2/1dGCQa+win6ApMuK
	 XXOHAk9KKhkOHzh68w9W1cMIpYy4olbYdE3hmuhBoJRfQioSa/Pw/CcbAFT9sYiibE
	 oUz9w710sYKEYHb3NCJykZi6MNf35WfnXKh+6Q/EMifgqLStCcSbIPWrYuZP7IW/Ob
	 Eg27h825+vpQtF7ILyUOELCtgHC355Rp9iF03TIRLTAMkqC87CWLFL7OXpEN0SQUXI
	 ch1LM16B8oC8A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so52463941fa.1;
        Tue, 02 Apr 2024 00:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH2o3XY678ZJEBGAqzWtReM5MUnwNUZpjls/CjcId5lFqJ2FvOpr5Frwg23mZxrVvFP9E+YFQfQRtYy3PVd0RUQWUVYSTCMWM09C/fC9Dx5+EsSCUu/TxJaJkw2MVpQ/7+4vl0tqgmTM/ua9gTcxqJGYsNbWwvyvJvmQMFbzWAXDkyNbEmihtIZuyVKENqcqa/7RJoD1nr2nZlmw==
X-Gm-Message-State: AOJu0YzHiETgJhJwPcRSkVHEaqSRvqjXqPejfnv1CWDWiV93PbM6iJcv
	8DYIFOzG587IS8yJ8tHMqHU/zYOLAsV96dF3emvfhjpTTdm645G+0SOWnR4KK1R2vi+ebgEmUWm
	6oroGeNzaIl6ycKMq08VMtoKgJgE=
X-Google-Smtp-Source: AGHT+IEJxdLFcHF2Vfoum8yX/aTPt8sXBMCbjPKCZxNFhiYr4O8ld0r65HW0+xfbNjd0hUcV3fTCQLfZXbZ4AtC8s04=
X-Received: by 2002:a2e:9044:0:b0:2d6:c02a:6c37 with SMTP id
 n4-20020a2e9044000000b002d6c02a6c37mr4719710ljg.7.1712041782180; Tue, 02 Apr
 2024 00:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com> <20240329093356.276289-8-ardb+git@google.com>
 <CAEf4BzYyTjb9MKAD8nP52+9Nx=eNyWxAwfWDBEO881+YuH_XTQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYyTjb9MKAD8nP52+9Nx=eNyWxAwfWDBEO881+YuH_XTQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Apr 2024 10:09:30 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEJ+zr51XNx9rzXiOQXjBewq_EPW4+536eFvq9B=+kvTA@mail.gmail.com>
Message-ID: <CAMj1kXEJ+zr51XNx9rzXiOQXjBewq_EPW4+536eFvq9B=+kvTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf: Avoid weak external references
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Mar 2024 at 20:24, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Fri, Mar 29, 2024 at 2:35=E2=80=AFAM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > If the BTF code is enabled in the build configuration, the start/stop
> > BTF markers are guaranteed to exist in the final link but not during th=
e
> > first linker pass.
> >
> > Avoid GOT based relocations to these markers in the final executable by
> > providing preliminary definitions that will be used by the first linker
> > pass, and superseded by the actual definitions in the subsequent ones.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 ++
> >  kernel/bpf/btf.c                  | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index e8449be62058..141bddb511ee 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -456,6 +456,8 @@
> >   * independent code.
> >   */
> >  #define PRELIMINARY_SYMBOL_DEFINITIONS                                =
 \
> > +       PROVIDE(__start_BTF =3D .);                                    =
   \
> > +       PROVIDE(__stop_BTF =3D .);                                     =
   \
>
> should this be guarded by CONFIG_DEBUG_INFO_BTF condition?
>

That shouldn't matter - the linker will not create the symbol unless
an unsatisfied reference to it exists anywhere in the input.

> >         PROVIDE(kallsyms_addresses =3D .);                             =
   \
> >         PROVIDE(kallsyms_offsets =3D .);                               =
   \
> >         PROVIDE(kallsyms_names =3D .);                                 =
   \
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 90c4a32d89ff..46a56bf067a8 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >         return ERR_PTR(err);
> >  }
> >
> > -extern char __weak __start_BTF[];
> > -extern char __weak __stop_BTF[];
> > +extern char __start_BTF[];
> > +extern char __stop_BTF[];
>
> kernel/bpf/sysfs_btf.c also defines __weak externs for these symbols,
> you probably need to adjust that as well?
>

Yes, thanks for pointing that out.

> Other than that looks good to me:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Thanks!

>
> >  extern struct btf *btf_vmlinux;
> >
> >  #define BPF_MAP_TYPE(_id, _ops)
> > --
> > 2.44.0.478.gd926399ef9-goog
> >
> >

