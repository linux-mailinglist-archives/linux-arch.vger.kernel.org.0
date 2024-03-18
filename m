Return-Path: <linux-arch+bounces-3023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7187EAC5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AAB2821CB
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF414BA94;
	Mon, 18 Mar 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmJeA8AE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB82C877;
	Mon, 18 Mar 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771712; cv=none; b=CX5wRyeM5SoNNPH9g477YFfvx+9RvIgjvMFsQAfNIS55gDd3lqhtShadBdpjo6f+wMRetEjUFx+VMCYRDT0ysTZZnPH6ibqEhthCYAsEfgY+4KAXvJeUy5MwlS1cCCgNwf9pvhnXaTh53iVQESGeFuLU7LUmBLEOM9nqn1kwpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771712; c=relaxed/simple;
	bh=QUbSeiRZVfNGfqAcNd6KenE2viIRmcdDxVpkHP2kLGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvgnXniiWe86XXOQl4isaDhMSBAqce5UE28lrFlNdqIbGiRPB8pDsInVfv68Q02yP5JOxtaqZERtxE5sh3qRW421/eWeEq8b45lfM2J3L8voR/Xh5ncASsLuhcuIc+bHtxko37y+pBpR2oG75MRfDMvFu5sMAbzvr/USpQL5G60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmJeA8AE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46cc947929so92155066b.1;
        Mon, 18 Mar 2024 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710771708; x=1711376508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8pVWVzYyCf08T0G0EdrgewZbyCpSJ/9af1OTexXimM=;
        b=FmJeA8AEw4DRLt/3d+cxC5L+5LYFO5JoZD17Ald8pUlYrr5imYG7fhb66OKnXSKcHa
         RpctgCeLRuVqtkOdo6o0Q4BDcONpWg24otOgttK/aAB/AiD9+Iup0JF8I6R2kfUC5tGz
         vfhEM7h9Xf8vQNcMO9h29WEXSjVmIV0b/1EJPyWDEYjTKV9Ag2TiRba5M8A4cZpFr3DU
         +FXgnygx3lwqZydmKqJKRS+0mlyvQtjzKKm9KJPx+w0dM1YuymQj0fsQIQ299pcXJjd8
         F9AfFjYsIFDFrxCu6WWxGDddPHOiqbSEKW/+1d5dW+BR9a5omEno9ETQ7wCjMlJN5IMY
         E/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771708; x=1711376508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8pVWVzYyCf08T0G0EdrgewZbyCpSJ/9af1OTexXimM=;
        b=LwejlTN9ZfSpm86rZL0stmbooUk7YeP5aFNDNHaX77UJ8vYO+PIsP9h6C+DeuGpE3D
         e9rbhjhWywy02YyuVr8hPNGeA5wgq7z/6xU9W8D5j0PSfzlSknuhmOXFLqGyb6Z/4gg1
         51OUx1PCEj94FDFCJmdbCyIqZK2H36ukacmDx4/CE89HR28Z9QkcLvaCSNso9HrhE2gZ
         tQt4cyjUMJkkLSpYix3tR6F+LRWMK6WGNrN6M4i61ZZmRBz7OdaBV3RGAINyF9SRyVT4
         PPH6azPYAzGMl2KGMn+fG1H/KxGt20oPxZegErev04HXNzV0gqKS1VEA1+h4gCyw1ZCg
         UF1A==
X-Forwarded-Encrypted: i=1; AJvYcCVWhG+knlUA8asxmDCIZOEnjrGAzrS4BW+Pz8p5MUKF///pw4pQu5x25VjtwVXL+qr0grB7lX4kpxoOtdh4osw63kqNNuMX64OhLMmgsJ6rO3hBYapg0fIR2AFr2Er8bC4B2fW7pCpPHzWchyoaAimyY/b76QuWf/TVbN32lUvDetW/CZOiR0G4Ip0/smcofjV+A/K4aZAa3BkyS0m59VUhk5gbrrz9sYEnqd9eeiKRCE1O7ixc3g==
X-Gm-Message-State: AOJu0YzP3HlmYqR3iJZgD/VwH47j7vF32XaGFk2OZ/1ZGiEDzbDFIPXm
	g9ykkyCFPymIRyJ4qjKL8FyQdBEPnd3XApoUK2sQEbAnxjnmfZruUDW/sDYNjGCNIJALv+lO4Eo
	vCAJWdlKNzGrTWsVIuM34N5vpjx4=
X-Google-Smtp-Source: AGHT+IEmolW0IFTzdRdXfU6t34pFwBQaiVlrS0IC58RhqDvErCec6W0W/ryDp9izwdRL/cqTBgM/X8T7/t/jUiN1Vuk=
X-Received: by 2002:a17:906:c14e:b0:a46:a786:8c8c with SMTP id
 dp14-20020a170906c14e00b00a46a7868c8cmr3870315ejc.77.1710771708145; Mon, 18
 Mar 2024 07:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220714084136.570176-1-chenhuacai@loongson.cn>
 <20220714084136.570176-3-chenhuacai@loongson.cn> <3a5a4bee5c0739a3b988a328376a6eed3c385fda.camel@physik.fu-berlin.de>
In-Reply-To: <3a5a4bee5c0739a3b988a328376a6eed3c385fda.camel@physik.fu-berlin.de>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Mon, 18 Mar 2024 22:21:36 +0800
Message-ID: <CAAhV-H5bw3xcym2-GpyntQEad1h2eB8xDQGwVr_bRRKAOakzoQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] SH: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, SuperH maintainers,

On Wed, Feb 8, 2023 at 8:59=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On Thu, 2022-07-14 at 16:41 +0800, Huacai Chen wrote:
> > When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS is selected,
> > cpu_max_bits_warn() generates a runtime warning similar as below while
> > we show /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
> > instead of NR_CPUS to iterate CPUs.
> >
> > [    3.052463] ------------[ cut here ]------------
> > [    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 sh=
ow_cpuinfo+0x5e8/0x5f0
> > [    3.070072] Modules linked in: efivarfs autofs4
> > [    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
> > [    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf84=
6c 9000000100154000
> > [    3.109127]         9000000100157a50 0000000000000000 9000000100157a=
58 9000000000ef7430
> > [    3.118774]         90000001001578e8 0000000000000040 00000000000000=
20 ffffffffffffffff
> > [    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de=
80 900000000101c890
> > [    3.138056]         0000000000000000 0000000000000000 00000000000000=
00 0000000000aaaaaa
> > [    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab40=
00 0000000000000000
> > [    3.157364]         900000000101c998 0000000000000004 9000000000ef74=
30 0000000000000000
> > [    3.167012]         0000000000000009 000000000000006c 00000000000000=
00 0000000000000000
> > [    3.176641]         9000000000d3de08 9000000001639390 90000000002086=
d8 00007ffff0080286
> > [    3.186260]         00000000000000b0 0000000000000004 00000000000000=
00 0000000000071c1c
> > [    3.195868]         ...
> > [    3.199917] Call Trace:
> > [    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
> > [    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
> > [    3.217625] [<900000000023d268>] __warn+0xd0/0x100
> > [    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
> > [    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
> > [    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
> > [    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
> > [    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
> > [    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
> > [    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
> > [    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
> > [    3.281824] ---[ end trace 8b484262b4b8c24c ]---
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/sh/kernel/cpu/proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
> > index a306bcd6b341..5f6d0e827bae 100644
> > --- a/arch/sh/kernel/cpu/proc.c
> > +++ b/arch/sh/kernel/cpu/proc.c
> > @@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file *m, void *v=
)
> >
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > -     return *pos < NR_CPUS ? cpu_data + *pos : NULL;
> > +     return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
> >  }
> >  static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> >  {
>
> I build-tested the patch and also booted the patched kernel successfully
> on my SH-7785LCR board.
>
> Showing the contents of /proc/cpuinfo works fine, too:
>
> root@tirpitz:~> cat /proc/cpuinfo
> machine         : SH7785LCR
> processor       : 0
> cpu family      : sh4a
> cpu type        : SH7785
> cut             : 7.x
> cpu flags       : fpu perfctr llsc
> cache type      : split (harvard)
> icache size     : 32KiB (4-way)
> dcache size     : 32KiB (4-way)
> address sizes   : 32 bits physical
> bogomips        : 599.99
> root@tirpitz:~>
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>
> I am not sure yet whether the change is also correct as I don't know whet=
her
> it's possible to change the number of CPUs at runtime on SuperH.
Can this patch be merged? This is the only one still unmerged in the
whole series.

Huacai

>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

