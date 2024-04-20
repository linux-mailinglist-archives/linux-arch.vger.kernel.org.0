Return-Path: <linux-arch+bounces-3843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9228ABBE3
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 16:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9036BB20E36
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135120309;
	Sat, 20 Apr 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMDrGq/6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25188C10;
	Sat, 20 Apr 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621606; cv=none; b=tuy/3YtWG1SjtaUryijC5mlv3APYbX87Am+t0m84vWHY4vLEV6/nV+geDEmFch5EKDUNonw9Tcpws+px0bFBKAT/Fgm5VxbWLsrslXb02VIwCBeVJ2lswZBaLNs5Wi+mT3WuaZxI+FCb0hBolosoEjeHb9/WMa5BsfSe42pdhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621606; c=relaxed/simple;
	bh=I1uFRtCpAdP89GlBp0SKPyxnIE1dUetKGusI1yawPIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf0RRRYA9V2NI4+vqOy6pZPgJMQz/QxYvmEYLlUmw38N/OowhrRf4BpcqRIwmY8VYTnkVXbXx83McYRFuC2TkFqxJnO1CqUkpne7IiIIerYeEU5DtjM0XiaMlFAIROy+MjrWsTFNyNUAuQs5iYmalrxTqEMK008Q/wPxd6Xgg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMDrGq/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AE4C32781;
	Sat, 20 Apr 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621606;
	bh=I1uFRtCpAdP89GlBp0SKPyxnIE1dUetKGusI1yawPIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nMDrGq/6M51rjOCiEpj55E7i+RveJcNNtD+Y8iFhDr6Bq9l5dlhgqRR8SCF6YB+1+
	 +Kbnx8rwCqSGVNGOHL4ab2esmgc9mYo/Ru0/yyTWYB4Rix40ZEuU33qIpc7CIYzfYl
	 kK8dJfKc+GzfwMoH2I8UzrYRpM43hvXgCc05XDmHiC0tCQgQ57SWPtVlRYk++x5peD
	 PP6LytfyPsafj7kNPMJPq4WWO6OE82aO/wlMbTHe9/iywRYqnSTgpel+sLH3Lq27JQ
	 f/B3QEDyqduJk7GPEnMoyhCZ020vaEbO0Ef4culet+oYyCgbzTMTNBveUi69uS/sMf
	 g2RVc9zEGpzWw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51acc258075so1657852e87.2;
        Sat, 20 Apr 2024 07:00:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmCC5zYqgX1THqslzCf01vTV+VdxzEFDdGDsaIzhSkxVDV1mzI+jmWP2jGD/iiHmEtrxE84DkEocmWRfLEglzF0oamTi7AZ8bZFEXVdp7s4vxI/2ePRNiYNqU1+AAev5oiRCLZjwsQ/9V5sFqobAQynsLYxlDrT+kQKnwTfwqFyP2rcAv/v4f93B0MTtJ2jXOnBmbea2dmu4T+QQ==
X-Gm-Message-State: AOJu0YxauiYuAqkytjPFwQwXa9hsd1zKldHZJyDq2nseI3NiHIUDfTwg
	lbsQCfNdICDigN33THNHr61mBOSnnv8DiDBKdhnFiPRZxCFkjcyjYymbmWcZAk8g6UtpR0mWS9a
	Hd93uxjjTxAjpt1VaQW62omjdT8k=
X-Google-Smtp-Source: AGHT+IHABa0yu9HMV2LPG/NmawBH4QcSzR0YT6ue4aOLVj4XNerloJ0JT21G10X7KyN2R4QP570VqrYZrfO71HUVbqg=
X-Received: by 2002:ac2:528b:0:b0:519:33a5:973e with SMTP id
 q11-20020ac2528b000000b0051933a5973emr3155934lfm.6.1713621604620; Sat, 20 Apr
 2024 07:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
 <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
 <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
 <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com> <CAMj1kXEbXfsNarFMbDC-Dzk6H9X9C4Ax2pWPSZhmt93mV4_Q2w@mail.gmail.com>
In-Reply-To: <CAMj1kXEbXfsNarFMbDC-Dzk6H9X9C4Ax2pWPSZhmt93mV4_Q2w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 20 Apr 2024 15:59:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFt5kbZ8yFgO-jU5ZP3-WZi5ZZJKKTCpEYRdUYFRj9CYQ@mail.gmail.com>
Message-ID: <CAMj1kXFt5kbZ8yFgO-jU5ZP3-WZi5ZZJKKTCpEYRdUYFRj9CYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 at 15:56, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 20 Apr 2024 at 15:42, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Sat, Apr 20, 2024 at 9:35=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Sat, 20 Apr 2024 at 14:32, Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> > > >
> > > > On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > > >
> > > > > On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org=
> wrote:
> > > > > >
> > > > > > Hello:
> > > > > >
> > > > > > This series was applied to bpf/bpf-next.git (master)
> > > > > > by Daniel Borkmann <daniel@iogearbox.net>:
> > > > > >
> > > > > > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > > >
> > > > > > > Weak external linkage is intended for cases where a symbol re=
ference
> > > > > > > can remain unsatisfied in the final link. Taking the address =
of such a
> > > > > > > symbol should yield NULL if the reference was not satisfied.
> > > > > > >
> > > > > > > Given that ordinary RIP or PC relative references cannot prod=
uce NULL,
> > > > > > > some kind of indirection is always needed in such cases, and =
in position
> > > > > > > independent code, this results in a GOT entry. In ordinary co=
de, it is
> > > > > > > arch specific but amounts to the same thing.
> > > > > > >
> > > > > > > [...]
> > > > > >
> > > > > > Here is the summary with links:
> > > > > >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbo=
ls
> > > > > >     (no matching commit)
> > > > > >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> > > > > >     (no matching commit)
> > > > > >   - [v4,3/3] btf: Avoid weak external references
> > > > > >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> > > > > >
> > > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > Masahiro, could you pick up patches #1 and #2 please?
> > > > >
> > > >
> > > >
> > > > I do not like PROVIDE() because it potentially shifts
> > > > a build error (i.e. link error) into
> > > > a run-time error, which is usually more difficult to debug
> > > > than build error.
> > > >
> > > > If someone references the kallsyms_* symbols
> > > > when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
> > > > In general, it should be reported as a link error.
> > > >
> > >
> > > OK, so the PROVIDE() should be conditional on CONFIG_KALLSYM=3Dy. I c=
an fix that.
> >
> >
> > You may need to take care of the dependency
> > between CONFIG_KALLSYMS and CONFIG_VMCORE_INFO
> > because kernel/vmcore_info.c has references
> > to the kallsyms_* symbols.
> >
> > (I am still not a big fan of PROVIDE() though)
> >
>
>
> OK, how about we use weak definitions (as opposed to weak references)
> in kernel/kallsyms.c, which will get superseded by the actual ones in
> the second linker pass.
>
> The only difference is that we will use some space in the binary for
> the weak definitions that are never used in the final build.

Btw those references in kernel/vmcore_info.c are guarded by #ifdef
CONFIG_KALLSYMS=3Dy too.

