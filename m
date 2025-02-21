Return-Path: <linux-arch+bounces-10274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7122A3F1F1
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5A21895773
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD4204C23;
	Fri, 21 Feb 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n70omxeJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302F1EE7BC;
	Fri, 21 Feb 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133581; cv=none; b=NYtKOXNC2LZSYjEkPSpTcV/zV9FhT2pC7tVwu5zzzniVpPTq3XEqdrv06uk9RyCyIxxzdsveuXFxrLs+hTUklyCgZ+y1sREzjdMwC8ragQP3ua7dcDJcspdd+bJTVKAIr2P9evUdpSA0ycIClLxfVv+hnDe+VVR9DTnqyodd1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133581; c=relaxed/simple;
	bh=/8/8sr5tXAM5If0IVypRSEE4sz+/sFVU6d/4Ly9Ee8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+q4AQba7x6ffL1/UyvFQfNwcS/k+MWhsTDsSTX2CWWWh7+AozsDqq7JovGxXIvL7nzoq7hSba6DJZ7lcuWyRU1kAcEipYHcTfNAZhf90HFvLGC5O6QFiuioWTzVrc9Z+l5PihKUkTMVAyqDhgvqO5iNTT8KkB3m5CDoAtOEAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n70omxeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5907C4CEEB;
	Fri, 21 Feb 2025 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740133580;
	bh=/8/8sr5tXAM5If0IVypRSEE4sz+/sFVU6d/4Ly9Ee8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n70omxeJhI8GCp8OfWW3RO1kx3qMNRL8zuW4wrLcnOcdV1NRdzSKJ+YYJWVFePAXP
	 hADz+lCPObX7VXDowr9pvrMtHIR5lSzec00e4bN8DnELBOeKMnAdE6V/AzOOklPK+Y
	 ndxqN6VKDp2vw5H2t4k5tmqaetzZjacd7iZ+yjQMmtbj4tX/IXSgYBEAXMjPF1IzOl
	 NOtmrlbfgr6x9tXLHtpTD2Q+R7ap2Qmjl98Lv1l759WGzwkx5qUWMIaQMf1aprGs8t
	 R0quwt9wMqd6rbapKN4XvfA+y+cj87SyWiZy/ZerRjII2X3+J8e1JVciYWav+jDFHy
	 u+HdFxVBVp9Hg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeec07b705so306315266b.2;
        Fri, 21 Feb 2025 02:26:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNt69xekSYLQjAZ2yoMMQv/U1pUgcSNjHoc3pa1BraNj8IhEmdD62PLDH42+lgaWwjbhPdDcr3h5m/KG5o@vger.kernel.org, AJvYcCVGaz6gbYAGsRWjyv3rAyilfi0WDqREROd7TOzyAT5IJj9+D88vuZVNCuXZdY7EsTxzq6BEexbAvBZ5Yw==@vger.kernel.org, AJvYcCVMT7q08kFIGoky53i64otLLzzwOG3fZJtViS3JYw6mywF+O8KyQ0ZDnXmI7jZ8d75h1sI3tJYwYzlS@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQhe7dxD8Dzd2JFbk+KBE/tN00PJRllIySxJh4Xc7+MPsm+HM
	J357ZT3BQkhfsZ0FLT+Slp3Av4RZ8oOTUcaJyaLVT6cCJbrWsTDqed1PnuciBDyLfsPqV++5CLq
	Xh9NogsbHTxwxkYLYMwP1z1cqmBI=
X-Google-Smtp-Source: AGHT+IF+dx1y8jdurtmAxgFLSYpG20X3+0Wp7NOu9CNU4jC2DPzEUAFWpRZ/vYkn9p1RrniyY9Wnwf42URprP3GZyU0=
X-Received: by 2002:a17:906:318b:b0:abb:b322:2b37 with SMTP id
 a640c23a62f3a-abc0d9888eemr172218566b.7.1740133579401; Fri, 21 Feb 2025
 02:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221092523.85632-1-xry111@xry111.site> <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
 <f0c15994e7a79f6cd0c82930c0dfebb50458c941.camel@xry111.site>
In-Reply-To: <f0c15994e7a79f6cd0c82930c0dfebb50458c941.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 21 Feb 2025 18:26:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4rDXDnzJwUE6PXMyuNGTs1NwUzQDP5eAPMmaHpqftP-Q@mail.gmail.com>
X-Gm-Features: AWEUYZkKtsq-lGYG5QXtYRBdszSLZp8SfNp0lQCGpiQmL0851ruHkeCLcoUwyFg
Message-ID: <CAAhV-H4rDXDnzJwUE6PXMyuNGTs1NwUzQDP5eAPMmaHpqftP-Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Fangrui Song <i@maskray.me>, 
	WANG Xuerui <kernel@xen0n.name>, Masahiro Yamada <masahiroy@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, "Jason A. Donenfeld" <Jason@zx2c4.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:23=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Fri, 2025-02-21 at 17:47 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Fri, Feb 21, 2025 at 5:25=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > >
> > > glibc added support for .gnu.hash in 2006 and .hash has been obsolete=
d
> > > far before the first LoongArch CPU was taped.  Using
> > > --hash-style=3Dsysv might imply unaddressed issues and confuse reader=
s.
> > >
> > > In the past we really had an unaddressed issue: the vdso selftests di=
d
> > > not know how to process .gnu.hash.  But it has been addressed by comm=
it
> > > e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH") now.
> > >
> > > Just drop the option and rely on the linker default, which is likely
> > > "both" (AOSC) or "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch
> > > distros.
> > What about changing to "--hash-style=3Dboth" as most architectures do?
>
> IMO we are more close to ARM64 for the aspect that there are no libc
> (glibc or musl) releases lacking GNU hash support, so I prefer the ARM64
> way.
>
> Maybe this should be changed for some of other architectures (RISC-V and
> C-SKY?) as well because I guess the only reason they used "both" was
> "hey, without this the self tests don't work on Debian" but this is
> resolved now.  Adding a few recipients and Cc for discussion.
OK, maybe we can change it for RISC-V/C-SKY and see what they will.

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

