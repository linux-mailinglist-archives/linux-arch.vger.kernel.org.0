Return-Path: <linux-arch+bounces-15056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F39C7D257
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 15:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C3F23405EF
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8425F7B9;
	Sat, 22 Nov 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp4v3oa3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEB223DD6
	for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763820822; cv=none; b=BYOaoYkw4HednXr8Bl9kr21cyy8hbk6q9jKdMaDXqH0QHpIPvzl7+2wVnUFklWZjBzijqmUI/VIpVB1aOXdyBuofgq/k/YOmcB9oAgOIft7hKVlluSS961SZEoE3yK/7moVbk5iFBnuFKETn/91gb7jrhyZ4F/A8dalEN7Sa6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763820822; c=relaxed/simple;
	bh=fi+qgkql+85tCdtgHV/9kS3XB1S11HBJH0nssK81tec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrCSS8rYUaEGQY3ykOwSUxNilyVAkyNueCZohVClyqwutW8S0vVEs9ISS5t8kBC0juJm84Ts8tabA9/aHsffT+6Va6qefdQOGVjoM4fFnRNpMQcG0Ryz0qQiwfjTi55niEJl9nas1Yt1fjg8rZ3C7XbBWwRM3hDXaMim4CMSLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp4v3oa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D1EC19421
	for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763820822;
	bh=fi+qgkql+85tCdtgHV/9kS3XB1S11HBJH0nssK81tec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qp4v3oa3mS9kXK/Cp2LoLOKio6AfAnAcXtDUVVa1Wtg8rUAFj440ywtY5j7jtWCtu
	 p1Ad1jtWyxQUOz5kaPhKQ1oAiZIy2vzKk5f2czbY5DyHRZXJvTg8A6x+Yp9heU8lts
	 tAoQ3fDilRrQGMpuB0aWTbl+bq9sjHJ6o/vw6brYpSUe6igYnt9pRxs4z9HLqrOzcy
	 mVj2XeDuVMx6KMgUB+DtuDDY5iKiirkn9vNbAUTqygButIV0+5UkPlvOvXQ31ieB3g
	 AR9VNU3EhcJ7H4zvs3ucIM6g4Nt71BAmix3sBG2EgQO+kAhgrqd4GUuGUBnFr4hj8n
	 91O7b37JjKeUQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so3810265a12.0
        for <linux-arch@vger.kernel.org>; Sat, 22 Nov 2025 06:13:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoNyikwgGoCLOv/XzxBVYQijK3TFBHg7ps17Ae2grz0kPYIK543tgQrDbGmWFN93ezlpx3yCA2+qtb@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbSs2ui0O1NNlpI9Qs/p9nk+XIEgpWjbMJQy3j4spB5YaeGv8
	4s2mMnLSAva94r/7c0FPaQOuLjRwUiDiS/W9PvSlczmiuGyAX83yZXUSufEhcmVAiXjTyTjNcun
	xQVx1hBuX+yYqsAyhozD4cHEAIvyo8zY=
X-Google-Smtp-Source: AGHT+IHNMnyVw2hQGvatkzLFGPVdNC0NHP7M4lZ4fkcxq/iQEPXZct9/yBhEFcw6jbf88Y+c8hzGSkn48Q8NRK6I/EM=
X-Received: by 2002:a17:906:b052:b0:b76:8cda:c936 with SMTP id
 a640c23a62f3a-b768cdad168mr104392066b.36.1763820820877; Sat, 22 Nov 2025
 06:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn> <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
 <3407d536-a9b5-48e8-a9cf-4bb590941d0a@app.fastmail.com>
In-Reply-To: <3407d536-a9b5-48e8-a9cf-4bb590941d0a@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 22 Nov 2025 22:13:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Df+c47ocBn2SN3iHDbFWGg9-i2+wY27TvtcpBa=pp7Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnpgUT7klbqgZLBCauIV7bcQe-KvCjFuT_f9yPZM2QSFNxQaNkoFLG_39k
Message-ID: <CAAhV-H4Df+c47ocBn2SN3iHDbFWGg9-i2+wY27TvtcpBa=pp7Q@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Sat, Nov 22, 2025 at 7:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sat, Nov 22, 2025, at 10:45, Thomas Wei=C3=9Fschuh wrote:
> > On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
> >> Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> >> loongson64_defconfig (for 64BIT).
> >>
> >> Also adjust graphics drivers, such as FB_EFI is replaced with EFIDRM.
> >>
> >> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> ---
> >>  arch/loongarch/Makefile                       |    7 +-
> >>  arch/loongarch/configs/loongson32_defconfig   | 1104 ++++++++++++++++=
+
> >>  ...ongson3_defconfig =3D> loongson64_defconfig} |    6 +-
> >>  3 files changed, 1113 insertions(+), 4 deletions(-)
> >>  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> >>  rename arch/loongarch/configs/{loongson3_defconfig =3D> loongson64_de=
fconfig} (99%)
> >>
> >> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >> index 96ca1a688984..cf9373786969 100644
> >> --- a/arch/loongarch/Makefile
> >> +++ b/arch/loongarch/Makefile
> >> @@ -5,7 +5,12 @@
> >>
> >>  boot        :=3D arch/loongarch/boot
> >>
> >> -KBUILD_DEFCONFIG :=3D loongson3_defconfig
> >> +ifdef CONFIG_32BIT
> >
> > Testing for CONFIG options here doesn't make sense, as the config is no=
t yet
> > created.
>
> Right
>
> > Either test for $(ARCH) or uname or just use one unconditionally.
>
> I don't really like the $(ARCH) hacks, nobody is going to build kernels
> natively on loongarch32, and for the rest it's fine to set the option.
OK, I will use 'uname -m' for checking. Though native builds on
loongarch32 will hardly happen, we can give a small chance to use
loongson32_defconfig, in all other cases, let's use
loongson64_defconfig.

>
> > Also as mentioned before, snippets can reduce the duplication.
> >
> >> +KBUILD_DEFCONFIG :=3D loongson32_defconfig
> >> +else
> >> +KBUILD_DEFCONFIG :=3D loongson64_defconfig
> >> +endif
> >> +
>
> This is also not the change I had suggested in my review. I think this
> should be a fragment along the lines of arch/mips/configs/generic/32r2.co=
nfig
> and arch/powerpc/configs/book3s_32.config.
Sorry for that. I know that the default config file is usually
generated by 'make savedefconfig', and the main purpose is
significantly reducing file size. I did that, but manually add some
lines such as CONFIG_LOONGARCH, CONFIG_32BIT/64BIT, CONFIG_ACPI,
CONFIG_EFI, etc. My original goal of doing this is to let users easily
know those fundamental options without reading Kconfig files (of
course we should not increase the defconfig too much).

Sorry again for not explaining about this in the previous version.


Huacai

>
> See arch/powerpc/Makefile for the integration into the build system.
>
>       Arnd

