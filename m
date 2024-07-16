Return-Path: <linux-arch+bounces-5402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE7931E48
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 03:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA21F22922
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6433EA;
	Tue, 16 Jul 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuOdOMhM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7617C2;
	Tue, 16 Jul 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092187; cv=none; b=TqTdpc820WNx7WtatStO4tYbD/2m3ijxWD8Csfzd+XBSdqf6nXLmbk4dwES65hEbFc/ruSeqBPxRd0IXZATcnbVV5e5S2G0Hnz8cF1DLwiwmahtkROt+Asf3XJSmIYapy7O3aupbe9IZowL0z9EMS1DgUc39dQCxoMiyZBNvTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092187; c=relaxed/simple;
	bh=Q0kp7iabKKyIX54Klme9KRFmTX+5d+5P/TaWauXzIwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUOJiXuGCBEFXwwNgN39uRWgNDi3ldUT20EdzpntVGL5+DqDGz7p/9/trrthnv4AcTpFCxb1NZltVlocnfI2SkahEmoEhgyk2Q/OXZO55+pTbq+M1ZTGK3B4qn3pQU5wxN1duYjnCYi7kMkiAe3PwXh/7zD6Ge0RTZ3eR13yT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuOdOMhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF75AC4AF14;
	Tue, 16 Jul 2024 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721092186;
	bh=Q0kp7iabKKyIX54Klme9KRFmTX+5d+5P/TaWauXzIwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SuOdOMhMQrBKxsDhNOE2+dxfWNQn3d9vcNUQjYyXVgZOmD9eIHi4ZHka54A9BPnqU
	 wrPoFacpN+3Yfg+IqHwVVmeyw8su9TXlxdoVIaWsncph7s1jQMZNAAxS6iUyRXB6wF
	 f/5hbQSSh78DanJr9xSKo5wDHY3woLJD9c1DETeDxvGJ8CAUJ//76H6+DaniOBsy6C
	 CubIvP+gNFfEJupN9r6VkJt4KDPxU9Z9RBbv5kONoq6c4WWs1ui+VpvKH4qSdwtvIv
	 aP4ZmhyeYhnM2o4fYhJAIm+ALc9w520XYJmooV4JSa1+/kFJmtK2cR3yXxgOi1BF4c
	 kTLI2DQSWYRDg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea79e6979so5504582e87.2;
        Mon, 15 Jul 2024 18:09:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlj7mYgp2iI766vY864/v/XfLN52pbywQLXbL1doy+YBK8Qui44vDN/1UQg5sHEFd8/50+OMhWRcAT0KByx65fw1CGxhVy8wL+QFA/ojVYFCCbCzE5lCBVUz54OUhBJ557DG+mZXnqpFNPdZyS2PRDgZ+XeP5EwYy1qSaaW+EnVq466S7M4pKCP0/cglae+990Cs0OpJvhTWHIZtDOQvKw3SW79FGAkJFt2Zcm8BT73Yw4DOcNQMx/+zjGTyLKXBtC2OgtzjC7DyoAeJqO4LQ1ZZiOTXBWR+8lHS7nDm7PeYQ=
X-Gm-Message-State: AOJu0Yx+VoKQHjyEl1qbUzpsZxyr8rF0V/zovzBPzvMUxtMadU/egISC
	Lw7/cMPUtwBCkRDVYbCodpCWzi0HGAKkxj6Y1Bh4hnYj+TNB9MSDCSli3STepj1ZWubDcCegOxq
	Jgogz77xK6yO6YrNHpvScGnEP5BA=
X-Google-Smtp-Source: AGHT+IHWiEkBygbqwCGlDokgR7Nb1VQa68dIBoq67wVmj13obpWvn2q8U35d1Igma4IeakMMYKXavF2qtV7ei5Itrxo=
X-Received: by 2002:a05:6512:3b06:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-52edf0329c1mr316791e87.55.1721092185161; Mon, 15 Jul 2024
 18:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-3-arnd@kernel.org>
 <CAK7LNATLVY1xtSMVMro-KMQVPgVHoiRKGX33ajCg8ZU0-EZS2w@mail.gmail.com>
In-Reply-To: <CAK7LNATLVY1xtSMVMro-KMQVPgVHoiRKGX33ajCg8ZU0-EZS2w@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Jul 2024 09:09:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQuu3SBKR-Q7+njKqbXZsRgWHjfDBYgBGMbERpuqWKjew@mail.gmail.com>
Message-ID: <CAJF2gTQuu3SBKR-Q7+njKqbXZsRgWHjfDBYgBGMbERpuqWKjew@mail.gmail.com>
Subject: Re: [PATCH 02/17] csky: drop asm/gpio.h wrapper
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 11:49=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Thu, Jul 4, 2024 at 11:36=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The asm/gpio.h header is gone now that all architectures just use
> > gpiolib, and so the redirect is no longer valid.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Guo Ren <guoren@kernel.org>

> > ---
>
>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> >  arch/csky/include/asm/Kbuild | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuil=
d
> > index 1117c28cb7e8..13ebc5e34360 100644
> > --- a/arch/csky/include/asm/Kbuild
> > +++ b/arch/csky/include/asm/Kbuild
> > @@ -1,7 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  generic-y +=3D asm-offsets.h
> >  generic-y +=3D extable.h
> > -generic-y +=3D gpio.h
> >  generic-y +=3D kvm_para.h
> >  generic-y +=3D mcs_spinlock.h
> >  generic-y +=3D qrwlock.h
> > --
> > 2.39.2
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
 Guo Ren

