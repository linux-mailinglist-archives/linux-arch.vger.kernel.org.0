Return-Path: <linux-arch+bounces-5313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82187929EDD
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386ED1F22CFE
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45177F2C;
	Mon,  8 Jul 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfncwpyq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E67711F;
	Mon,  8 Jul 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430252; cv=none; b=SrfzvSeFEQwhQ/3epp0RiCIwJ/ScOToybvPmUycI3xb6iDyR2j0wsR9Zs8VUxqigOe7f5PWc4mm+oCL5r/ppmVT4RWWChsljRXRLSBgh6sKVZp+1326sct4u5d86+gDsq2Y08Kf0c6LZ6J/TwpL8Ws3FTs7ssTLqPj2v1LIXX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430252; c=relaxed/simple;
	bh=fRzukiwiGXpfJgT9MIn/+BOBLSM4o3zDVVIuAEKJfMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Du6xbXp4LrVh9/G+Rq2j3fasTYa9hT1VsddIl3tI7Z44zvIdu9ERvyqY1AogfCEPg6vEkBmGNCOwqv0fhjtVCOKMfGoovXCqDHyGOZpBsB4eDKCxpgXpGrx/T9YM7BAueThUNIMQBNzZspLZ6O1nezvnVqxRnqCNKNX2KVv/YgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfncwpyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E811EC116B1;
	Mon,  8 Jul 2024 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720430252;
	bh=fRzukiwiGXpfJgT9MIn/+BOBLSM4o3zDVVIuAEKJfMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SfncwpyqaAUcxk4HGvdMNaOlFxT3eL7rjEhJDUvNG62fa9KaXZR/Oz+v8yMCn3ta+
	 /tccNzu3bQ8q8BfZ5+buUyzDUGywn+y/MY4doi6tGvKR8YdH0AkUVy7qj/f3dh1U8t
	 3DmwyBV90mFNFHNrVkwT08fRI5lZYSocV/GxUbec27l1frJyIPaJ5MEo2xcS5A41wo
	 OQcUVsetb6J2S4ud3iH8oqwrz1HWlD9qkxxYl7ODAK2zWmLEWuWboI9Eg77g85aBm0
	 feGo25bpoB3Q4dHOJ/iwYN0eRuz5gReTmHsiTE3NUWs38X5woOobCbYbObh8AQ4sCW
	 h2dVIyDDpLCwg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3774336a12.3;
        Mon, 08 Jul 2024 02:17:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAEbS7gHtFHzMY1PCZmtc7rA7hAXvVPSKEQW/D6Jksf9efFKSsVjoof2e40m2Nz/WFP9bV1dNlOo+LVzGcN0JrBTLr2VL+K21prFpYTQpI9w3Xut8Ge4wvm1Uk65LwyHUuHxxogA1hCDrE02odigHOWNcveSuEyZWZ3Lm5TkV7jQLiOpplfGpfX6Kod/TcrC5qoSQZPlu0y/0bqm2uD1koo+mIM1WMF+2VD7HaMmjub9PpXmlfcuek27Z/Q6Web0SRoWQKdw==
X-Gm-Message-State: AOJu0YxSRPCHOaY1PuxDf2HNH1QCv9ciPRwYA44xVxXLPwTKIe7+85nZ
	0E/1kpvqgb7GMbzMCv552de4J92tNhnSZIB2jzswmWH8ypdVfhG27FmF1D+eW4K0oS1L8GMA7fm
	d0or1YRVAmTMEfWn182OUmYSZm2w=
X-Google-Smtp-Source: AGHT+IEItbzjZ1A8AjoY2UEBrBnwgSWQEm3t7mr2+tl/5g9pMSmICjy6tz2b5gKMEgXcn3oWVBAMV2zDOPQcnE6qDs4=
X-Received: by 2002:a05:6402:50c7:b0:57c:47c3:dc62 with SMTP id
 4fb4d7f45d1cf-58e590724ecmr7993184a12.5.1720430250552; Mon, 08 Jul 2024
 02:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-3-arnd@kernel.org>
In-Reply-To: <20240704143611.2979589-3-arnd@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 8 Jul 2024 17:17:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ4oDh2yEFpTBRpXauVa1zZAZBMsVvwbx3OUZnKaCLH0w@mail.gmail.com>
Message-ID: <CAJF2gTQ4oDh2yEFpTBRpXauVa1zZAZBMsVvwbx3OUZnKaCLH0w@mail.gmail.com>
Subject: Re: [PATCH 02/17] csky: drop asm/gpio.h wrapper
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
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

On Thu, Jul 4, 2024 at 10:36=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The asm/gpio.h header is gone now that all architectures just use
> gpiolib, and so the redirect is no longer valid.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 1117c28cb7e8..13ebc5e34360 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y +=3D asm-offsets.h
>  generic-y +=3D extable.h
> -generic-y +=3D gpio.h
>  generic-y +=3D kvm_para.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D qrwlock.h
> --
> 2.39.2
>
LGTM!
Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

