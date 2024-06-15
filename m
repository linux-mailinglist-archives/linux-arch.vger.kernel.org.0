Return-Path: <linux-arch+bounces-4909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B990971B
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 10:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B01D1C21701
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jun 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8E17BC9;
	Sat, 15 Jun 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm7bGyvC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D01BDE6;
	Sat, 15 Jun 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441546; cv=none; b=FBCXOwN2CY9bbyB/8o4lYg/q3bM85UbItJvMT+tOp0LAbtGk8A/Tvpo1czkTfPiqnSet7lmLRNDx2fuEFuXUPGrabA0FFM4JM81oq0TwMjr3GesMhWONECV5c5CYjE2KfXPwSxwNxkhQFcUt4A2QFowJHGeXI8Mw6MmchCwqOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441546; c=relaxed/simple;
	bh=lYNgS4EOKxJx9qsKYp8TMD8ZnON5/nuFd2Lwtc4Bs38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU15e6KRHYL/ut1T0Jhk+Txy5xHQUVZmaFAG7MVGm6/6o6S/TUi+hS3AZvgk0zM9R5egi0qF5SZLUFJ1sym0d8f49+omqQAZsMPkTTx9nkjv6VqaS90cX3qsjGUH5mjCFg6IqECwm443A6MTU7uh53aifcmPRTbpVfLbmE/vOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm7bGyvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D9CC4AF1D;
	Sat, 15 Jun 2024 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718441545;
	bh=lYNgS4EOKxJx9qsKYp8TMD8ZnON5/nuFd2Lwtc4Bs38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rm7bGyvCSP4wYWPPHXCJ5jJKdH0VKN96qUprBjDz88UYC8PVqtfg3962oYgA02/1h
	 GMundvk1CDIq9j+WEsU9gKzSpuW9JO+HuRNnsZGOOAiBedcF+Oq0FZhfow5wmSzR6X
	 MOLOTy52fW+m7InDGT4CUHBi1xd2xCAfhy5hdb6/cJgN4FojqoVrH84Zj5KHPNVrg8
	 2q00b8yGw1TgMyEkeqlKgfg2bRd/GD0T1G8CrhXg6IFH0nFVSSOC0t0QCgj8YfdfZp
	 Utxo1pjGktK0MeuOq5Upym+0kJxwymDNePsqsnxT5Y55lFJREc4PjARJH5Sar6N7j1
	 sIgibC89Sjk4Q==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so3255844a12.2;
        Sat, 15 Jun 2024 01:52:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJkVjlHYvBhhg3HL43Stk23qv4CvOPtrX+ieyvJU/fVMQ1JuaBNcI4gL1/Q+0xtrBE1x6HUhpng46QG91Ez5V1Yp2RHDnxmqNBAYb64bN9fMzOKDsKLUE4TBTxhvakSezJiwHIKeeFDEEllxzIEFdqGNvqQIPrbmWXEg8CTVSfvw==
X-Gm-Message-State: AOJu0Yzolf2jMlpFim4KB07guJX/G2eQY3Xb3gseId6pudnRdVAqtxLU
	tVwZuM9yU+69K1loMR6xJiSUt+7jtmtNQScM1CI1/DrHdyCxBTMyQR5AAC8dkziuM/n3/c9wI/z
	5dtSkT8USboezwoNLkbZ2k7iZ7MU=
X-Google-Smtp-Source: AGHT+IFyPBQJTylosSuf5+MVqWLqEy0/yJ8gB4g4PxtoBOX/oelfetnVysEN8hXKg3y38a5M6OArZggzJ1FoS45HttI=
X-Received: by 2002:a17:906:756:b0:a6f:1df1:1ef2 with SMTP id
 a640c23a62f3a-a6f60dc517fmr376288066b.47.1718441544432; Sat, 15 Jun 2024
 01:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com> <CAAhV-H5kn2xPLqgop0iOyg-tc5kAYcuNo3cd+f3yCdkN=cJDug@mail.gmail.com>
 <fcdeb993-37d6-42e0-8737-3be41413f03d@app.fastmail.com> <CAAhV-H4s_utEOtFDwjPTqxnMWTVjWhmS7bEVRX+t8HK5QDA8Vg@mail.gmail.com>
 <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
In-Reply-To: <a21a0878-021e-4990-a59d-b10f204a018b@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 15 Jun 2024 16:52:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
Message-ID: <CAAhV-H7OR5tkbjj-BPLStneXFr=1DUaFvvh8+a5Bk_jhCAP25Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Sun, May 12, 2024 at 3:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sun, May 12, 2024, at 05:11, Huacai Chen wrote:
> > On Sat, May 11, 2024 at 11:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
> >> On Sat, May 11, 2024, at 16:28, Huacai Chen wrote:
> >> > On Sat, May 11, 2024 at 8:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de=
> wrote:
> >> CONFIG_COMPAT_32BIT_TIME is equally affected here. On riscv32
> >> this is the only allowed configuration, while on others (arm32
> >> or x86-32 userland) you can turn off COMPAT_32BIT_TIME on
> >> both 32-bit kernel and on 64-bit kernels with compat mode.
> > I don't know too much detail, but I think riscv32 can do something
> > similar to arm32 and x86-32, or we can wait for Xuerui to improve
> > seccomp. But there is no much time for loongarch because the Debian
> > loong64 port is coming soon.
>
> What I meant is that the other architectures only work by
> accident if COMPAT_32BIT_TIME is enabled and statx() gets
> blocked, but then they truncate the timestamps to the tim32
> range, which is not acceptable behavior. Actually mips64 is
> in the same situation because it also only supports 32-bit
> timestamps in newstatat(), despite being a 64-bit
> architecture with a 64-bit time_t in all other syscalls.
We can only wait for the seccomp side to be fixed now? Or we can get
this patch upstream for LoongArch64 at the moment, and wait for
seccomp to fix RISCV32 (and LoongArch32) in future?

Huacai

>
>       Arnd
>

