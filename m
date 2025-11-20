Return-Path: <linux-arch+bounces-14985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A9C72FA9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E91402FB5A
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6A30F93A;
	Thu, 20 Nov 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjFQsmQ/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099A30F7EB
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628869; cv=none; b=KOlTfwZJvM9wGRbD3dSaznNdpS8WoBtRAFkMn7TSE6MGmIQ3T6eOB3RboZb+KmeawL8ynEr2UJeFj8g/XY7+Zob6Tvuy7U2T+hEQc/6pGslzxa6EZB9Y4y35Nk5xfvpv5mQyeOnJ0rpayCB89VsWOUjdLh+VYggMRgXq74dIPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628869; c=relaxed/simple;
	bh=z7V5sTTWBNb0Ebb0bTuMbDCjryC/r12dVIbS0MW6VWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWl7Ulxod9p3c8hX31w8gTDBwRAme2SVgNNdmYz6Mnq3lzct34oShNibXWwCGjny0ZalT6C47DzxaYbTiO6Zzr/LtTb7eu/vrUFZppsv10BkMFbnjCcqIV1n9WRslu4ydAnnqR8/IoNq+ycJn4AaYGU5tq9MPRsfPNAcVW8cJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjFQsmQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A72C19422
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763628869;
	bh=z7V5sTTWBNb0Ebb0bTuMbDCjryC/r12dVIbS0MW6VWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cjFQsmQ/DJwhkZvZEKUy3vdweALWiKVVaBqCUrFO4j1czUJLPrBaZuCVYqISq4iEa
	 pG/qsL57+zE5c8paUjlQbsFTW72wHP8hu5Ou4YZzmsmLZ6UCdMZmimCSdXFijuPU3D
	 hIY+Iw1PMF/+PGQQyKYLMM++n80kJty9FBpO1Rw9Tpfs0RdKts/AO9owk8OKARI30X
	 D5zwgLHx7Lh5b+smXEXd1Hz3vDNEHCWCZChq7W1Wom9RkbzayvFWSiCtQdJwEk1b9A
	 45bTUdTEmpLPY0f2msEa8a/tl9oRh9+xdDpSQRiozl+kSnVClY+H3tDH+PPV/ep/ig
	 pyphLkVj72GUg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b735ce67d1dso100553166b.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 00:54:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1+na73BR/g5x8SPMYnudoYXGbBx2xkQKqHL84a0PHZrEwbWSl8D1yF0SLaAC1tEDRsG5UNcBbsCiP@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2SvCh9oPQJJeIFwx68/DagjrPigH0EZnSyYVKmxoFyOIxVKc
	5XQe+Hzep3FiWV3HpxHvNOzAy5lJEfEZCXlIea79sZ+XRkWkva9MQ7a9htDkZNypXwC58BQVRwy
	2FvDFsxOuNS9jhakBJOqhmgtUy0qh32s=
X-Google-Smtp-Source: AGHT+IG3wwDdA2GqOg1psvgsTcecno6t3WhxUofFrHkzrSXDM2KAocWFgOej85XpFM03aRRIGvcq4/eQnBNseuZgUGw=
X-Received: by 2002:a17:907:7fa8:b0:b72:d2df:641c with SMTP id
 a640c23a62f3a-b7654f11044mr227469166b.49.1763628867760; Thu, 20 Nov 2025
 00:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-14-chenhuacai@loongson.cn> <20251120090846-746f973f-e08a-46ab-a00d-87a5be759941@linutronix.de>
 <CAAhV-H52FAORNDM48nYjQUWjnDFxc7+RGUsOW+JNteJrpbF6ww@mail.gmail.com> <20251120091849-6ced7bf4-048f-405c-98ed-68df64816d25@linutronix.de>
In-Reply-To: <20251120091849-6ced7bf4-048f-405c-98ed-68df64816d25@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 20 Nov 2025 16:54:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+0Yeut3nST4BpfmFcP=mNKQ3r=7k8vPW33cpJHeLKjQ@mail.gmail.com>
X-Gm-Features: AWmQ_blJFk5sy2F60hPIJz-yBNjpQn3VOaY8xhLd8VyuC0sjedx_x6XOg5m6otw
Message-ID: <CAAhV-H5+0Yeut3nST4BpfmFcP=mNKQ3r=7k8vPW33cpJHeLKjQ@mail.gmail.com>
Subject: Re: [PATCH V2 13/14] LoongArch: Adjust default config files for 32BIT/64BIT
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 4:27=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Nov 20, 2025 at 04:16:25PM +0800, Huacai Chen wrote:
> > Hi, Thomas,
> >
> > On Thu, Nov 20, 2025 at 4:11=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > On Tue, Nov 18, 2025 at 07:27:27PM +0800, Huacai Chen wrote:
> > > > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig=
 to
> > > > loongson64_defconfig (for 64BIT).
> > > >
> > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  arch/loongarch/configs/loongson32_defconfig   | 1110 +++++++++++++=
++++
> > > >  ...ongson3_defconfig =3D> loongson64_defconfig} |    0
> > > >  2 files changed, 1110 insertions(+)
> > > >  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> > > >  rename arch/loongarch/configs/{loongson3_defconfig =3D> loongson64=
_defconfig} (100%)
> > >
> > > KBUILD_DEFCONFIG also needs to be adapted to this rename.
> > That is done in the last patch.
>
> That means the 64bit 'make defconfig' is broken within this series, poten=
tially
> breaking bisects.
You are right, that should be done in this patch.

>
> > > FYI the cover letter says the series is based on v6.16-rc6, but the s=
eries
> > > doesn't apply to it.
> > Not 6.16-rc6, but 6.18-rc6, and the next version will be on top of 6.18=
-rc7.
>
> That was a mistype. It doesn't apply to v6.18-rc6.
>
> Looking at the GitHub repo mentioned in the cover letter, there are addit=
ional
> patches on top of rc6. Which I guess is fine in general, but the changelo=
g
> could be a bit clearer.
OK, I know, thank you.

Huacai
>

