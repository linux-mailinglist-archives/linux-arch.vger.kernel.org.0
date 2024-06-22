Return-Path: <linux-arch+bounces-5017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7391329A
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360842839FE
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56E14B95A;
	Sat, 22 Jun 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivjiMI/Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AFC4436;
	Sat, 22 Jun 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719042342; cv=none; b=PdlusTPsKGiBKMCBX8beEob1Q47R0LA0eBUke4RdbDScQNz0La+/EGRws4PBLxK3QvWB64OINJ4i2mM0ueZu+gioP1GiyjJx8OxpDksBIXb8cYQUiJRBmlCkW7R7xoYwx+xQi4IGMvFy+EuD8TlF0W0fyplsIGVYakYHuAC3IzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719042342; c=relaxed/simple;
	bh=IR0hYburUiw/cByL4+6sKzPdofCEFTWUZ/1nF9KctUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiG8eL7axXzat+tp/zN4SvJvOVkYJhs+EfITqTmLaYdlNYssxEnf2YK7whgUF90Uo2JTma5BiFM2pVd29hVqfmpJUME9Kfbsod1XREpWVhyt9mLBAtDd0KD0b5nMJ902JEMExEkKd9j7S0y1TQZyD8pFPR5PgwCG0XuM1P+odrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivjiMI/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F1C4AF09;
	Sat, 22 Jun 2024 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719042341;
	bh=IR0hYburUiw/cByL4+6sKzPdofCEFTWUZ/1nF9KctUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ivjiMI/YoMWwvSoIR9+MMEkr8qyyPdF+79qrasJuYvGaMcPVSA69xU9ycH6NTk4yV
	 tH9BhVpSO9gSuoUeBOfB2EWezgZBuxMNze9WItgL3GyI3qtxwXSyPdOP82TnSubn6N
	 RMq6CskKJ05XkNQUUm4ql/MQaM45LbMUB8AiFOheaiiY9o+jEaWWTpt0zXjjrEa2j3
	 hIy/bREeos5oN2ABh5Xfsa7qw3pTIMpDHO59WgiK/53DAwKm0S6/lLeVVUpYamuDdV
	 Ni+EmhN+dFQwvr9OIoA5Dn9h70INXzs43TxEEMGLl7Dauo9Bt6/h7aF/Ykfz8Gkk64
	 HF6evbJc3kgrQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so1364089a12.0;
        Sat, 22 Jun 2024 00:45:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLkjPhtGhhvbngfLbz8QV0+0ukJstRRt+CkzvX2sO4U/j43Te5BSaMZuCN6ingKEsQEngJK0LWx5j6IcmoHhyIr08rlNEI9K8DaUVKcrn9WBvxQsPpwb7ZFVeEn+jGLYvXz4pftSC9dJyjt1CVxlggh18bDCywhJ1GN9+IvmBMlQ==
X-Gm-Message-State: AOJu0YzWLSTriBRBGTfwCTAOHtQWYCqJUc9J6MW/FVdu78pfhSEdvWKB
	xJ0CiBDDqAKUO9cuYI725toqgoSRUAJGswJuKNJnSKSCaGmtH/PH2DrryGI2H2noym1w+IIhGaz
	PFsrXeEK+kMdxSzqSxtEq/Oku+5g=
X-Google-Smtp-Source: AGHT+IHM67hEoabZwNKJlQUmc8LsuA/PkXEjHzd5RrTVkS/4e5XvvFbb4B1o7Z+G2WUp6v6pQRrtpMxPa2IycXBdeyI=
X-Received: by 2002:a05:6402:1809:b0:57d:455:d395 with SMTP id
 4fb4d7f45d1cf-57d447e23f3mr461623a12.7.1719042340180; Sat, 22 Jun 2024
 00:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com> <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com> <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com> <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
 <cdef45d36d0e71da5f0534b3783b81c82405bda3.camel@xry111.site>
 <CAAhV-H4R_HJAB0baqUgA8ucbwWNVN4sc9EV91zAk9Ch302_7zg@mail.gmail.com>
 <56ace686-d4b4-4b4c-a8a6-af06ec0d48f2@app.fastmail.com> <08ff168afc09fd108ec489a3c9360d4e704fa7dc.camel@xry111.site>
 <a70e8b062fc422e351fe2369b9979a623fa05dfa.camel@xry111.site>
 <4fd0531d-e8f8-4a4c-9136-50fcc31ba5f2@app.fastmail.com> <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
In-Reply-To: <c2b1ca127504e519c04a36179ba6c486f2ec0a08.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 22 Jun 2024 15:45:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4HaAnKJFnDpfUY6qdEtoKPxLSgHgU8isMryrab=cq6pA@mail.gmail.com>
Message-ID: <CAAhV-H4HaAnKJFnDpfUY6qdEtoKPxLSgHgU8isMryrab=cq6pA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Xi Ruoyao <xry111@xry111.site>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Mon, Jun 17, 2024 at 2:45=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Mon, 2024-06-17 at 08:35 +0200, Arnd Bergmann wrote:
> > On Sat, Jun 15, 2024, at 15:12, Xi Ruoyao wrote:
> > > On Sat, 2024-06-15 at 20:12 +0800, Xi Ruoyao wrote:
> > > >
> > > > [Firefox]:
> > > > https://searchfox.org/mozilla-central/source/security/sandbox/linu
> > > > x/SandboxFilter.cpp#364
> > >
> > > Just spent some brain cycles to make a quick hack adding a new statx
> > > flag.  Patch attached.
> > >
> >
> > Thanks for the prototype. I agree that this is not a good API
>
> What is particular bad with it?  Maybe we can improve before annoying
> VFS guys :).
>
> > but that it would address the issue and I am fine with merging
> > something like this if you can convince the VFS maintainers.
>
> Before that I'd like someone to purpose a better name.  I really dislike
> "AT_FORCE_EMPTY_PATH" but I cannot come up with something better.
Any updates? Have you submitted this patch? I hope we can end up at 6.11. :=
)

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

