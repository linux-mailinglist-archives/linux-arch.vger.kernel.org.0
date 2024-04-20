Return-Path: <linux-arch+bounces-3840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E18ABBCC
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3453B2815AA
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3CB79F5;
	Sat, 20 Apr 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktGpnd3q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653372770C;
	Sat, 20 Apr 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713620553; cv=none; b=Bbfz+TDXa6gJ6f/zQD9e0Bi5MlOEWFGgqVbWPdbA5FibOxTeRVpnR/MNSTwcngRyK5wfNTjZCjDlEnrT6R3/UG2tRi29CxILfakOBtdORpG6O7cSQpMLeAWDEi8pyMg8VtcxggxOhpP1GKllJgOi6/ZYi+PjZC3J26SBjdELTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713620553; c=relaxed/simple;
	bh=47mwsXX4VHJwXSjEWqXAlLw7nIvujHw8/McnUjcF3+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR8X5Lmlk6y/tSce4yTeumqd+19qC9R0fnY+Kscp5MtTYjp0wWveJ7Z8cB1t9/FC5IZyI4ckOnBoJ9eNE79unsr+njzF3sXh52FfkFmckvIZXcTUWJUFB4IAxOnsPrgReM7NVrz4NfS89b618ojs+ePm7LzouMv7rUaALMEC4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktGpnd3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5FCC32782;
	Sat, 20 Apr 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713620553;
	bh=47mwsXX4VHJwXSjEWqXAlLw7nIvujHw8/McnUjcF3+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ktGpnd3qlzQyRtO4dg+B/q2O18w99K7XorW5e0MMlf8MV7dTLVhOyNOiIFJ4KUQdp
	 18SUDM0Lsr/zM6yx770xg0HMhFbJzPINYumyiO9n17BV7MnAVO7hQfZ9sOFEqX34Z6
	 0dCzZwjHcJiJfeVGoPsnLq3zy8DJIIAQMR7wKynnfwjqM5emDNl+E+YAmRwMx/kFfa
	 zYiMGF9Bj17yNx38KaxljsfrtLLqkHWeFcBd0EwnLhz/yck+LYzh7YZPhQWrjNZGMb
	 xwPxNo3pkFVvqysDc3ltOrpGDCZT6LVXpMh5ws1jmCFkR6WGbk21EAfUCO7GIDqkI2
	 VIge3UkMJrj1g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5176f217b7bso4973742e87.0;
        Sat, 20 Apr 2024 06:42:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCLEIoWhigK1xccVSLriAE6nCHd/qYLrhvZLU74cAnj08acy3QrlK8wvNVoIugkwJjYJ+ij4C/UQH/bcfHlONuuS0lKBOn70hqNIjUaIleKJFwcPAOMDbCj7ra3ZRfEaWM25wEhd0FGAvhPncSl/PWodegbZUiCfJnt9R0hqKZwRTmxyaOXvuIYqZnx5LaVR4+5uLmcvIr22nRWw==
X-Gm-Message-State: AOJu0YzaI63A62Wr4LOGjFNKw+P54iWNca9mOfK6Z+XfceDy05YXZ1eY
	otBnd7wbcPDT0N5Bi6y9UFOQ/pZvZU5DAvBg17zBLdtsKrN7uOlywG0+lyHWwBD27+Sx83hgEH4
	Yh9VX856DNZx2F1DBdAN+ooofHjs=
X-Google-Smtp-Source: AGHT+IEDbdXhoE9nskl4dd/REKBu6i+rxqquORt8r9agggOYrOrx908OcpdLRI7RA+nY7U7RFKWMhXlwi+BEODaMKhA=
X-Received: by 2002:a05:6512:708:b0:51a:dcf4:5b2a with SMTP id
 b8-20020a056512070800b0051adcf45b2amr1596657lfs.56.1713620551545; Sat, 20 Apr
 2024 06:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
 <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com> <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
In-Reply-To: <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 22:41:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com>
Message-ID: <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Ard Biesheuvel <ardb@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 9:35=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Sat, 20 Apr 2024 at 14:32, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org> wr=
ote:
> > > >
> > > > Hello:
> > > >
> > > > This series was applied to bpf/bpf-next.git (master)
> > > > by Daniel Borkmann <daniel@iogearbox.net>:
> > > >
> > > > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > Weak external linkage is intended for cases where a symbol refere=
nce
> > > > > can remain unsatisfied in the final link. Taking the address of s=
uch a
> > > > > symbol should yield NULL if the reference was not satisfied.
> > > > >
> > > > > Given that ordinary RIP or PC relative references cannot produce =
NULL,
> > > > > some kind of indirection is always needed in such cases, and in p=
osition
> > > > > independent code, this results in a GOT entry. In ordinary code, =
it is
> > > > > arch specific but amounts to the same thing.
> > > > >
> > > > > [...]
> > > >
> > > > Here is the summary with links:
> > > >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
> > > >     (no matching commit)
> > > >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> > > >     (no matching commit)
> > > >   - [v4,3/3] btf: Avoid weak external references
> > > >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> > > >
> > >
> > >
> > > Thanks.
> > >
> > > Masahiro, could you pick up patches #1 and #2 please?
> > >
> >
> >
> > I do not like PROVIDE() because it potentially shifts
> > a build error (i.e. link error) into
> > a run-time error, which is usually more difficult to debug
> > than build error.
> >
> > If someone references the kallsyms_* symbols
> > when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
> > In general, it should be reported as a link error.
> >
>
> OK, so the PROVIDE() should be conditional on CONFIG_KALLSYM=3Dy. I can f=
ix that.


You may need to take care of the dependency
between CONFIG_KALLSYMS and CONFIG_VMCORE_INFO
because kernel/vmcore_info.c has references
to the kallsyms_* symbols.

(I am still not a big fan of PROVIDE() though)




>
> > With PROVIDE() added, we will never detect it
> > at a build time.
> >
> > Do you want me to pick up 1/3?
> >
>
> ???

I will apply 2/3.
It is trivial.



--=20
Best Regards
Masahiro Yamada

