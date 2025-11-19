Return-Path: <linux-arch+bounces-14896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A4C6D577
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 09:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025A84F69BC
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CEA2EA158;
	Wed, 19 Nov 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrsTQqeS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFF2D7DDC
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539296; cv=none; b=Y8Fqk/qPihZglKP6EycArFcsrHbAEtOfgwP7FUMRiJ0lZxkQQijOUXbRojm3Su8xKbdAf0mlHb1fDbu7I2L12RebjnVEK+tMfkpU988v+vq1E/vg1bDlPWmvWm4+LgKsax5MmVCSsvKnZtlRQGsQEE7ONt58EqkCvznWs0lZliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539296; c=relaxed/simple;
	bh=Hy41d9L/dFT8qEOybthTPcUHnSVaU1IQVXci4lliuTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfoIMNlnrG7FgCkGpxEoMvAbF+RUK9M6KpihQsk3FEFImq6D7tTlxNPel4kg1TM0Al5uXup1JfgzPN23mQE4uKnhqwaurOdIoRQcc+s00+qloalAUCi8cL9RKUqOwU+fFpfhdgJXRCLmBUJWQYHB1s/imjUGKFSIKM+DOepgS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrsTQqeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C871EC2BC86
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763539295;
	bh=Hy41d9L/dFT8qEOybthTPcUHnSVaU1IQVXci4lliuTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lrsTQqeSGJr7o296NzLjNgRFQvbOdFBxVd6qjr0GYIWSkgWM5RVkMCSY6pbIo0sid
	 MGXEvQGtNUS6FAKxxReaLfZfiIJFHJ+P25KbOfDZEAA9R+GRD4K9vxr9ih8RwUl9fm
	 BunGMWOsCuAlPc/k3PF3BwtNF6CYI2LA6lzoIoTdr8XazSC5mkSxGTqUeCjXsJAnmk
	 yxd+/dIpBL6LqCX3D2KEVsYRLm83FsgkoIQhOwBGVn/g9ZXsAIZLaNElFbQe82EZam
	 Q3yTHIfRg9SgehsVn/LO5fgdNbxiAg9rwoHaNcWs8/BdksGJIzegiwBQt/QBPL54su
	 ZSRh+y35YOA3A==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72bf7e703fso1038859866b.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 00:01:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGnggfD/9GIz6LR4ux7GjgVeA0IUxTbhs1aKpUH0xXKh9BakAhlHwKqmWiTd4+aJG3Xj2FnC8sipil@vger.kernel.org
X-Gm-Message-State: AOJu0Yymqnanm1Ex1TZqWBmkNs9vce8kt1c99nNXaKNML7s/lpo+Ys87
	PjJO6oIvX1wiKAqMFxehCsCoQuD/RFkk0bgh8iloasWV/2Lqm4+rlHqJUsjU9Vr9uA+dxC/4WaV
	6+FYV/RdcGCmwXxYxeK4FB+NbFvGhP4k=
X-Google-Smtp-Source: AGHT+IH9Kdh+KL+AyfvImCQZGsljv/sPQQko5q9wwQDoEXwJ707oPWTbLzJMRg7L1OJ2znCC8NTv2vQOU2Er6n4wVyQ=
X-Received: by 2002:a17:906:9fd0:b0:b70:aa96:6023 with SMTP id
 a640c23a62f3a-b7367896f44mr2083428466b.24.1763539293954; Wed, 19 Nov 2025
 00:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn> <debb8b35-8253-4422-a197-6d92e8d0c701@app.fastmail.com>
In-Reply-To: <debb8b35-8253-4422-a197-6d92e8d0c701@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 16:01:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NU5z4bZDG3ZW+oHEp3jUE9_69g+zUXmT-+RcM07bOOw@mail.gmail.com>
X-Gm-Features: AWmQ_bmaJURP5W5b3_-T670sGi5ex57s2vDFGuwOYvgxj6iTR76CyCp6MWPavbc
Message-ID: <CAAhV-H7NU5z4bZDG3ZW+oHEp3jUE9_69g+zUXmT-+RcM07bOOw@mail.gmail.com>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Tue, Nov 18, 2025 at 9:46=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> > loongson64_defconfig (for 64BIT).
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++++++
> >  ...ongson3_defconfig =3D> loongson64_defconfig} |    0
>
> I would suggest using .config fragment here and only listing
> the differences in the defconfig files in there, rather than
> duplicating everything.
>
> > +CONFIG_DMI=3Dy
> > +CONFIG_EFI=3Dy
> > +CONFIG_SUSPEND=3Dy
> > +CONFIG_HIBERNATION=3Dy
> > +CONFIG_ACPI=3Dy
> > +CONFIG_ACPI_SPCR_TABLE=3Dy
> > +CONFIG_ACPI_TAD=3Dy
> > +CONFIG_ACPI_DOCK=3Dy
> > +CONFIG_ACPI_IPMI=3Dm
> > +CONFIG_ACPI_HOTPLUG_CPU=3Dy
> > +CONFIG_ACPI_PCI_SLOT=3Dy
> > +CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> > +CONFIG_ACPI_BGRT=3Dy
>
> You mention that loongarch32 uses ftb based boot,
> so ACPI should probably be disabled here.
I have tried my best, adding #ifdef CONFIG_ACPI all over the world but
still failed. :)

LoongArch is deeply coupled with ACPI and can hardly disabled. On the
other hand, it is not forbidden to use ACPI for LoongArch32. So let's
keep it, and I will modify the description for LoongArch32 booting.

>
> > +CONFIG_DRM=3Dy
> > +CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> > +CONFIG_DRM_RADEON=3Dm
> > +CONFIG_DRM_RADEON_USERPTR=3Dy
> > +CONFIG_DRM_AMDGPU=3Dm
> > +CONFIG_DRM_AMDGPU_SI=3Dy
> > +CONFIG_DRM_AMDGPU_CIK=3Dy
> > +CONFIG_DRM_AMDGPU_USERPTR=3Dy
> > +CONFIG_DRM_AST=3Dy
> > +CONFIG_DRM_QXL=3Dm
> > +CONFIG_DRM_VIRTIO_GPU=3Dm
> > +CONFIG_DRM_LOONGSON=3Dy
> > +CONFIG_DRM_SIMPLEDRM=3Dy
> > +CONFIG_FB=3Dy
> > +CONFIG_FB_EFI=3Dy
> > +CONFIG_FB_RADEON=3Dy
> > +CONFIG_FIRMWARE_EDID=3Dy
>
> Is AMDGPU actually working? This driver is rather tricky to get
> reliable on new architectures.
Never tried and probably not work. I will remove it.

>
> I would suggest turning off CONFIG_FB here (also on loongarch64).
> There is a replacement driver for FB_EFI in DRM now.
Do you mean simpledrm? It probably works but not always works. From
sysfb_init() we know it only mark EFIFB as a simpledrm device when
"compatible", so we still need FB_EFI as a fallback.

Huacai

>
>        Arnd
>

