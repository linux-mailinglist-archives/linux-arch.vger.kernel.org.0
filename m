Return-Path: <linux-arch+bounces-3842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D48ABBDC
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FB71C20997
	for <lists+linux-arch@lfdr.de>; Sat, 20 Apr 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40C20309;
	Sat, 20 Apr 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOkMss+F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1822301;
	Sat, 20 Apr 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621404; cv=none; b=T4+RuAbLIGS8ZvmTAJCNrJ3VY8plmgKXzd5PwWQvHtQbfYIdJcEW2OYOF0N2HbehhmshzjkjWNd8C4IcXhMqlYsEGoABA9rVJ4t3CVshAt+fUlWZy+VgR9igPwmktvYpQErkPIvyRCxgduo+5lUWMibsNZCgpdrFxUUPLVV8los=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621404; c=relaxed/simple;
	bh=yJEUmM3auckEvzKW+sYtN6Mym1j/zX7TxvNvIuGXMAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fB5IV90hfNHoBnbfbv2amnKf7M3eGIpqCaHzZ+3sFsaE6gsThq6z1pq7+aBOaiJ7kr9nYPmg/SoI30ff6yMdBimEwxd5tJxwJQXAWzkwEC/AltVIlZr/7gzkgBsTHMddo5SbpTKoHHrQFSoU/tBDr/SQiTgfdMSYxn+s3EJhux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOkMss+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFD0C072AA;
	Sat, 20 Apr 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713621404;
	bh=yJEUmM3auckEvzKW+sYtN6Mym1j/zX7TxvNvIuGXMAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tOkMss+Fv8ZpVFeyvQbhkoooHbMuqiyqzQToUAwfCLXEnnPcHI5G8cNHOXcElU9QI
	 I7uG461kvBHqtH2S2Y+2/DmvFZjO5Ttex+3O6iXxKUZtBvC2j/Jj1hdaHw3vKi1uUs
	 yzzJ51UvM9MimvPZiVvA08mIByljfQWdrgs1eJHI7KVmcoe4zcbYfIyXNT8M705m1l
	 nQ7LFPcjfVUAc+V7yQMF/37moQlvlI2ndkSj+C4db4GylOl/GIipIeQV7HOEvz1AmY
	 2F2oqtNwDZ4cunWL2X6mCMYDnHSCVlSAtyBq89lKHm5VDCRCTskX+Egi/pvuVGgn2E
	 RBm2ghB1WzcqQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so2273559e87.1;
        Sat, 20 Apr 2024 06:56:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV920XnEihnXDceBg/BT7UUW2Mm/uAoKqPoG3v0ppASVkCKGdcCOKmn6fMYX1ZxzvUzOb2Omj2pOCFFcoEsWu5r+hvcCJxvLyqvcZSF6tw7axp4WG7QHe67WlHwn0a6ZcWh/SG/TWZuWtUI2oozuonczexq85WfAxQRVu3Wr/WYby07bOcL0GcSrP9CrpCA7uoaBzvF0BcvNeya7w==
X-Gm-Message-State: AOJu0YyO1dqXjuDVMsO1jnsb2Dw7Wl7AvhCLTESDvqTBo0gC0GSawL99
	HpTYEm9iJ3C15yB1rvPs9Gde0rOgoRmdjqgnKCIxIilRfMoChVpOMybs65YTrOnzPZsc0iR8ljo
	U4/+OSbKy0qt12y2Jm2rfWbGjyZo=
X-Google-Smtp-Source: AGHT+IHzpUeBC31HWnJDRtQCkgD83ZoYOHSIOuYigk+OgmnZeo1+6GCOYXjNMKMogYWGdWC2TWSylnrhdYlD0tbOmms=
X-Received: by 2002:ac2:5381:0:b0:519:730:b399 with SMTP id
 g1-20020ac25381000000b005190730b399mr3541795lfh.9.1713621402645; Sat, 20 Apr
 2024 06:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162041.2491523-5-ardb+git@google.com> <171327842741.29461.3030265084386428643.git-patchwork-notify@kernel.org>
 <CAMj1kXGVRGcJGS1xuqHPeJfM797RB2UiJQfSHK+oj1JQG4YECg@mail.gmail.com>
 <CAK7LNAQ8fhKUwK_m8uGfvBUBrAdXdMYM3_AA5zo2cQzhW3jE1A@mail.gmail.com>
 <CAMj1kXGYdjQz5n0uuiLHu8uc-YNE8eqUQWtGjg5pANo+0speQA@mail.gmail.com> <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com>
In-Reply-To: <CAK7LNAT9Y5C+Shr1Pq=xrL2tcBK6rpBn05iovdZ2=kMHW5UCkw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 20 Apr 2024 15:56:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEbXfsNarFMbDC-Dzk6H9X9C4Ax2pWPSZhmt93mV4_Q2w@mail.gmail.com>
Message-ID: <CAMj1kXEbXfsNarFMbDC-Dzk6H9X9C4Ax2pWPSZhmt93mV4_Q2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, martin.lau@linux.dev, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 at 15:42, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Apr 20, 2024 at 9:35=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Sat, 20 Apr 2024 at 14:32, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Fri, Apr 19, 2024 at 4:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > > >
> > > > On Tue, 16 Apr 2024 at 16:40, <patchwork-bot+netdevbpf@kernel.org> =
wrote:
> > > > >
> > > > > Hello:
> > > > >
> > > > > This series was applied to bpf/bpf-next.git (master)
> > > > > by Daniel Borkmann <daniel@iogearbox.net>:
> > > > >
> > > > > On Mon, 15 Apr 2024 18:20:42 +0200 you wrote:
> > > > > > From: Ard Biesheuvel <ardb@kernel.org>
> > > > > >
> > > > > > Weak external linkage is intended for cases where a symbol refe=
rence
> > > > > > can remain unsatisfied in the final link. Taking the address of=
 such a
> > > > > > symbol should yield NULL if the reference was not satisfied.
> > > > > >
> > > > > > Given that ordinary RIP or PC relative references cannot produc=
e NULL,
> > > > > > some kind of indirection is always needed in such cases, and in=
 position
> > > > > > independent code, this results in a GOT entry. In ordinary code=
, it is
> > > > > > arch specific but amounts to the same thing.
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Here is the summary with links:
> > > > >   - [v4,1/3] kallsyms: Avoid weak references for kallsyms symbols
> > > > >     (no matching commit)
> > > > >   - [v4,2/3] vmlinux: Avoid weak reference to notes section
> > > > >     (no matching commit)
> > > > >   - [v4,3/3] btf: Avoid weak external references
> > > > >     https://git.kernel.org/bpf/bpf-next/c/fc5eb4a84e4c
> > > > >
> > > >
> > > >
> > > > Thanks.
> > > >
> > > > Masahiro, could you pick up patches #1 and #2 please?
> > > >
> > >
> > >
> > > I do not like PROVIDE() because it potentially shifts
> > > a build error (i.e. link error) into
> > > a run-time error, which is usually more difficult to debug
> > > than build error.
> > >
> > > If someone references the kallsyms_* symbols
> > > when CONFIG_KALLSYMS=3Dn, it is likely a mistake.
> > > In general, it should be reported as a link error.
> > >
> >
> > OK, so the PROVIDE() should be conditional on CONFIG_KALLSYM=3Dy. I can=
 fix that.
>
>
> You may need to take care of the dependency
> between CONFIG_KALLSYMS and CONFIG_VMCORE_INFO
> because kernel/vmcore_info.c has references
> to the kallsyms_* symbols.
>
> (I am still not a big fan of PROVIDE() though)
>


OK, how about we use weak definitions (as opposed to weak references)
in kernel/kallsyms.c, which will get superseded by the actual ones in
the second linker pass.

The only difference is that we will use some space in the binary for
the weak definitions that are never used in the final build.

