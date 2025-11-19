Return-Path: <linux-arch+bounces-14912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F130C6F3F7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E20380AFA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54CA364034;
	Wed, 19 Nov 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJi5WLMw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001C3612C5
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561625; cv=none; b=iPVWap+KU5/eoz8hzC7qznXhWusHvlt5a2WaknMrmj4qhrhXjbLFQxj5iatha3S1cYkaEymJS8YlUUkkqNC/Hu3uV9Ii/eHBwAmWKdBfLuZT6/znMCojgO3TZb/88E0xZ7sEh0srwxh3rUSA1gA9Ekdz8tFymsyjs9jG3wbHSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561625; c=relaxed/simple;
	bh=O5ALMS+79AgxoUnmTnm/aNB9JdSjZmIssnCqcNai018=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cebYX3/r4UE1w1JP5ii1JvFDJpcwZluv+DD3q3vIXUyVFOVvlCTWyO/Ez6r3kTYlUw8aNJORM/m1qKT1sbCUxv2uSETHivKAMacFGVjSK9W2G31UNVZjJJlLObEo4ENBIoFb7YnWyvBpDRgsziZIYqIXlSu1Ku86zhc/geemNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJi5WLMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3741C4CEF5
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561624;
	bh=O5ALMS+79AgxoUnmTnm/aNB9JdSjZmIssnCqcNai018=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJi5WLMwkp7jt6BpzOHK23l1cnmCDbteNR/qWVHMqjdM8WM7vjkpuhrAoJcxt8JWg
	 V2jkh9cTaCrGtqIhIAGg9XC6/RgQJgwZ4+Nr9Agee5URtL3tIF5rfGjaTxTNNiU5OP
	 OqpRn03aIkYkidUzhVXIBKxeoQcY5LJL5RAtXNiLMUMNLlcoa/p1RSS4RUogT3thQq
	 uLp8xHjpEAGC7KsG3fDmGsdM+OdHcMCHB/F7OG2gNydraJZsBr2grOR1t0jTt/Dms2
	 anwjWSXk/Lz5lA1B7cKxRiq4CSuixVRffShiSGJn1MDJS4ts3YeUwO/qtMQ6x4+mGf
	 o4lsu5hzpJ0sg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324204so941382666b.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 06:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0g9tyt538S5X23mlrUxE5Rwr/ffIlBd0tcSmqzZWo/UYvQfpzpflp7ooiTPW+/qreGE8rT0XLLBna@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mvtyi7CBqiB1KYoh7Oslwep62pIj0SBLC3iXhydGGCArkyb/
	qpW5QyOVadUixK0CcsIVcm3bvmwjsSNDw/Cf5dAC/5927D8pkRjj65LE2Z/LaFrS5NBM7SDdIIh
	AQK1MmhoLrSyZbuNtjObYYvswhncHdDE=
X-Google-Smtp-Source: AGHT+IH+bjds08p8EIsdtrev3LqTK1AhZqRyYMUdtwinlfGrIemCkKBThdVJjU4oIMXrtUARdMzMx21jMZBm4Nx51CU=
X-Received: by 2002:a17:907:1c9d:b0:b73:3d1d:2249 with SMTP id
 a640c23a62f3a-b736786e8b6mr1981087066b.29.1763561622749; Wed, 19 Nov 2025
 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn> <debb8b35-8253-4422-a197-6d92e8d0c701@app.fastmail.com>
 <CAAhV-H7NU5z4bZDG3ZW+oHEp3jUE9_69g+zUXmT-+RcM07bOOw@mail.gmail.com> <a618d371-3489-4e7b-830b-bec843e117d5@app.fastmail.com>
In-Reply-To: <a618d371-3489-4e7b-830b-bec843e117d5@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Nov 2025 22:13:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZsZCUGhB5wSiHOH3KmUwYkSinLk3uUn2kTCj4+DoOyg@mail.gmail.com>
X-Gm-Features: AWmQ_bnAc-zoKcsXnq_LcNnlgzTiQlw6YW1car-PjdZB0ZH4LET9jPsTQYwmAdM
Message-ID: <CAAhV-H4ZsZCUGhB5wSiHOH3KmUwYkSinLk3uUn2kTCj4+DoOyg@mail.gmail.com>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>, 
	guoren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Nov 19, 2025, at 09:01, Huacai Chen wrote:
> > On Tue, Nov 18, 2025 at 9:46=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Tue, Nov 18, 2025, at 12:27, Huacai Chen wrote:
> >> > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig =
to
> >> > loongson64_defconfig (for 64BIT).
> >> >
> >> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >> > ---
> >> >  arch/loongarch/configs/loongson32_defconfig   | 1110 ++++++++++++++=
+++
> >> >  ...ongson3_defconfig =3D> loongson64_defconfig} |    0
> >>
> >> I would suggest using .config fragment here and only listing
> >> the differences in the defconfig files in there, rather than
> >> duplicating everything.
> >>
> >> > +CONFIG_DMI=3Dy
> >> > +CONFIG_EFI=3Dy
> >> > +CONFIG_SUSPEND=3Dy
> >> > +CONFIG_HIBERNATION=3Dy
> >> > +CONFIG_ACPI=3Dy
> >> > +CONFIG_ACPI_SPCR_TABLE=3Dy
> >> > +CONFIG_ACPI_TAD=3Dy
> >> > +CONFIG_ACPI_DOCK=3Dy
> >> > +CONFIG_ACPI_IPMI=3Dm
> >> > +CONFIG_ACPI_HOTPLUG_CPU=3Dy
> >> > +CONFIG_ACPI_PCI_SLOT=3Dy
> >> > +CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> >> > +CONFIG_ACPI_BGRT=3Dy
> >>
> >> You mention that loongarch32 uses ftb based boot,
> >> so ACPI should probably be disabled here.
> > I have tried my best, adding #ifdef CONFIG_ACPI all over the world but
> > still failed. :)
> >
> > LoongArch is deeply coupled with ACPI and can hardly disabled. On the
> > other hand, it is not forbidden to use ACPI for LoongArch32. So let's
> > keep it, and I will modify the description for LoongArch32 booting.
>
> Ok. You will probably want get back to it eventually, since the
> 32-bit port is likely intended for small-memory devices, and the
> ACPI code is fairly large.
>
> >> I would suggest turning off CONFIG_FB here (also on loongarch64).
> >> There is a replacement driver for FB_EFI in DRM now.
> > Do you mean simpledrm? It probably works but not always works. From
> > sysfb_init() we know it only mark EFIFB as a simpledrm device when
> > "compatible", so we still need FB_EFI as a fallback.
>
> I meant CONFIG_DRM_EFIDRM, which was added earlier this year.
> EFIDRM should work more reliably than SIMPLEDRM.
OK, I will disable FB_EFI and enable EFIDRM instead.

Huacai

>
>      Arnd
>

