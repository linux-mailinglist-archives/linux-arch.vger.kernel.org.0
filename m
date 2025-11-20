Return-Path: <linux-arch+bounces-14991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F645C73DEE
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 13:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 019873547F1
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343E32FA0C;
	Thu, 20 Nov 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOMPzbuw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5922D7DEB
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640336; cv=none; b=Y9+jF95xt4hU4Bu22DFFGwtYrXNwhMoK3mQWy7ghXydnP4uKALdIUzsdkxT69PTt653iWy0pE2M5Eo3F8mlWxRykFAuzkOqF1SAAxgDStNh3/JwSFHA+4ImryALMSe4SfVZwsXbcbzoORu/yhREVdXixptGP9vcirwp9H+leitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640336; c=relaxed/simple;
	bh=qKmkXnKph4CbdQSGt6eicwkmhyoCWM/p3XqY8UOFiyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5ozDt+4cVmKw2kQhua/c0DYFoUHoGNxvd+0F1vVTVmqvueaKt2H5Qy0nAuE/lMDf2THv6Ze2Yc2CBghKvIlzcTdUFSfRPl5NNwAKrIKwaFMGVzIWAWn16gn4S0t1QxTD+RQLLy0OGK2IsfGJOaELKuIKyS6hyiEWTaIshz+Uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOMPzbuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D1C4AF0B
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640336;
	bh=qKmkXnKph4CbdQSGt6eicwkmhyoCWM/p3XqY8UOFiyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tOMPzbuwj8UvuS/0GSB31Ol1xbKkfqULDluWIa4NHNu9na2DS7djM1rYFvbiV881d
	 jDiuBSapQz+aoVlWy1CQTUJ60EV03JNE1+72NYNNOIRyrC2wYDrZrsVgbaKiHapNxu
	 ZpC2k7C4EI5rc+eIevuvhpjZzA8/mnLwnZFQAMzP34f/AkMyHjugGvBILZKG9oObv3
	 TumnCol5JthNIQSalOUe1a3xHhJQIY3O2j1sJeelYC4osU6OKC2Kqbit+6bBd0L3gq
	 55N2RMuVyMEXAWvLuljvE0yqlrJbsn0TxenjsWJgHgO2Ql96cZnAD/9P63sLRC/pI+
	 d6fHRhO08x1jw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b728a43e410so144276066b.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 04:05:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU65tPmw+QVeXfyVjwPKuA/xXwDtq3x38KcX7CL3ydfu8xr9yF1gTmlnBaBfXdtus3ohZ4B7aTrty36@vger.kernel.org
X-Gm-Message-State: AOJu0Yweghug3pTsBAiLKdC5kZkZsNUaMV74RG1S2QLceBnsfq3rq0EC
	MXaVFgPhvNWeMhZab2YOFBWWdsmznyum61qDtDjOXW/WPM0YU6ETFDoG9fxgnYCEEyk79UP9Ndw
	k12NgNMcNAZ0uNBnRY9YseSoHArh2lkI=
X-Google-Smtp-Source: AGHT+IGdOxQHn05ZaaIajL/4sDfJuw+pg9D2frqJgjeNKWOarJkzeaAsjW4/N0Mg+W73l6MarAmvPXJxrUOs1vfs7yc=
X-Received: by 2002:a17:907:2dab:b0:b73:7ac4:a5f with SMTP id
 a640c23a62f3a-b7654d5d11amr317873766b.21.1763640334653; Thu, 20 Nov 2025
 04:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-10-chenhuacai@loongson.cn> <a13a5f0b-49ca-4116-8654-5bc57c0ca6a0@xen0n.name>
In-Reply-To: <a13a5f0b-49ca-4116-8654-5bc57c0ca6a0@xen0n.name>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 20 Nov 2025 20:05:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4YzfWXKjWwmA8co4qFjLm=jZggbD5dqq+OxntVH6OZrQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkmbpeQkv2vYi0nogbpWugsAydiiMD2SigpieVGpX1I4Das_vmbAGLrmfA
Message-ID: <CAAhV-H4YzfWXKjWwmA8co4qFjLm=jZggbD5dqq+OxntVH6OZrQ@mail.gmail.com>
Subject: Re: [PATCH V2 09/14] LoongArch: Adjust system call for 32BIT/64BIT
To: WANG Xuerui <kernel@xen0n.name>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:40=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 11/18/25 19:27, Huacai Chen wrote:
> > Adjust system call for both 32BIT and 64BIT, including: add the uapi
> > unistd_{32,64}.h and syscall_table_{32,64}.h inclusion, add sys_mmap2()
> > definition, change the system call entry routines, etc.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/Kbuild        |  1 +
> >   arch/loongarch/include/uapi/asm/Kbuild   |  1 +
> >   arch/loongarch/include/uapi/asm/unistd.h |  6 ++++++
> >   arch/loongarch/kernel/Makefile.syscalls  |  1 +
> >   arch/loongarch/kernel/entry.S            | 22 +++++++++++-----------
> >   arch/loongarch/kernel/syscall.c          | 13 +++++++++++++
> >   6 files changed, 33 insertions(+), 11 deletions(-)
> >
> > [snip]
> > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/sy=
scall.c
> > index ab94eb5ce039..1249d82c1cd0 100644
> > --- a/arch/loongarch/kernel/syscall.c
> > +++ b/arch/loongarch/kernel/syscall.c
> > @@ -34,9 +34,22 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned =
long, len, unsigned long,
> >       return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE=
_SHIFT);
> >   }
> >
> > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsign=
ed long,
> > +              prot, unsigned long, flags, unsigned long, fd, unsigned =
long, offset)
> > +{
> > +     if (offset & (~PAGE_MASK >> 12))
> > +             return -EINVAL;
> > +
> > +     return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> (PAG=
E_SHIFT - 12));
> > +}
> > +
>
> Why not guard this with #ifdef CONFIG_32BIT?
Because it is not only used by CONFIG_32BIT, but also by CONFIG_COMPAT.

Huacai

>
> >   void *sys_call_table[__NR_syscalls] =3D {
> >       [0 ... __NR_syscalls - 1] =3D sys_ni_syscall,
> > +#ifdef CONFIG_32BIT
> > +#include <asm/syscall_table_32.h>
> > +#else
> >   #include <asm/syscall_table_64.h>
> > +#endif
> >   };
> >
> >   typedef long (*sys_call_fn)(unsigned long, unsigned long,
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

