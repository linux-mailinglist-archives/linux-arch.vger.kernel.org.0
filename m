Return-Path: <linux-arch+bounces-5376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741E92F709
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDDE3B2149C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jul 2024 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE113F43C;
	Fri, 12 Jul 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z00SDfgO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BC13DDC2;
	Fri, 12 Jul 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773485; cv=none; b=rwW85A+vvUSuajC3Lgt3uK5NKhJNskAtwSf37dHKCCkbMerr3fQeKPHQ/8rVa9ztS+qLYcLgFVAo3MyDWG0EofD1IJyx9AE+YPYtdF5NKg+KTRusBU+GOVBk8PQm8BjP491voWw0qxvO2B4uE4wxprx2n41tEONYvaL1D7kmH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773485; c=relaxed/simple;
	bh=X4sxkxfa0puHMD2lnMvIKYZ5jErEYw2uVCAwMxYRmSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g62WBzB/tIRrFwZeOlQaA3YfxRidMhiPporkD6gMh1f3oB5nw9osPoWQMGhqm/7HvUVoZ0LIwdFjCkmuEqRCrlvrJMw5gMWuxy7mtCYp3CKaDM1aJ87mL/5Wa4CDODCPD6jI0K4nqUHz3veoLNwX8Xm23M5c2u3ToBXm9wGo+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z00SDfgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1259CC4AF19;
	Fri, 12 Jul 2024 08:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720773485;
	bh=X4sxkxfa0puHMD2lnMvIKYZ5jErEYw2uVCAwMxYRmSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z00SDfgOaF/iQqYzh+oapqEALLE+nmuOZep5iSxydOBEkfHHQgSTe75kMA5aU8MF7
	 IYvJE9zmfABY3crLS3SgXhvL7zJBVg9BUYPzoOG3t5gtUt5rh/QW48SX3mywu49yzC
	 7nkTAvk61IANHwMRYnadNnNflufGcpqNt7gLgHESMd6Cp0cErNHCecHLfcYmILIk5x
	 k11nqFyEJtapNtJ3INjcX6fM11J2NMbCohzmOWmxMwfo2c+3vw+Xxzuoaqphb3jNzW
	 CPMWA65qdTbLAHjWXcPptnegF1HnAHNex+NFGj2wpx2cBo4M3asuCWplFDeHCsRDX2
	 tGoTAA4upFv+g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee98947f70so18708511fa.1;
        Fri, 12 Jul 2024 01:38:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULYYpz4yVqLT8JQCpS2C4/r0Aq5W3+2mQ9C1iAF3BL88ejyoNcLxyT+jR6ZyJnlzmO8maRq4k3HNnaAiOdbn1wN+JIYLrJ9uq33Bd/3s9M2LufWUvnEXaUeU3/ciHGbKBG45lGWuJDa3i1VML4B58CTHfH8DeYY3oq7eyEEiXMWVE0exB5KmrtRzzVJEM6Y5Y92EX5I6H+raQhRKQZsL0/ZUEBTU2l3EAYHJlGqZUU+N2nqiOGI5oJrmTFxEZ8kas6sE3V4g==
X-Gm-Message-State: AOJu0Ywgf+0+iyK59iAszeRbkE1AQAxl+mSGhfiu5nHpvukGWgRw+2Ze
	h+dJQz64cI4nmR3CNKB1gaBcgajpsrtsim2xk9kb6gEHvPONlyxteHo3HTu8BwMhvjUp1d+cpR4
	QHaEg5n7PKZLEAhOR95BRJZtH9ug=
X-Google-Smtp-Source: AGHT+IFfkbTH0GPwVyglXJ2Er1yvq7AU75kSwOPof9lxDJA6WZS/bfYrYyjHckbhe1dyXepshm4Uwstcj4sDcu5PIlo=
X-Received: by 2002:a2e:95c6:0:b0:2ee:97b4:8028 with SMTP id
 38308e7fff4ca-2eeb30fd369mr67338551fa.31.1720773483308; Fri, 12 Jul 2024
 01:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-4-arnd@kernel.org>
In-Reply-To: <20240704143611.2979589-4-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 12 Jul 2024 17:37:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=h6dML-06ox1dje_bxF2+R-Gq7Yw-s73Vi-FW39L9eg@mail.gmail.com>
Message-ID: <CAK7LNAS=h6dML-06ox1dje_bxF2+R-Gq7Yw-s73Vi-FW39L9eg@mail.gmail.com>
Subject: Re: [PATCH 03/17] um: don't generate asm/bpf_perf_event.h
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
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

On Thu, Jul 4, 2024 at 11:37=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> If we start validating the existence of the asm-generic side of
> generated headers, this one causes a warning:
>
> make[3]: *** No rule to make target 'arch/um/include/generated/asm/bpf_pe=
rf_event.h', needed by 'all'.  Stop.
>
> The problem is that the asm-generic header only exists for the uapi
> variant, but arch/um has no uapi headers and instead uses the x86
> userspace API.
>
> Add a custom file with an explicit redirect to avoid this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/um/include/asm/Kbuild           | 1 -
>  arch/um/include/asm/bpf_perf_event.h | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 arch/um/include/asm/bpf_perf_event.h
>
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index 6fe34779291a..6c583040537c 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -generic-y +=3D bpf_perf_event.h
>  generic-y +=3D bug.h
>  generic-y +=3D compat.h
>  generic-y +=3D current.h
> diff --git a/arch/um/include/asm/bpf_perf_event.h b/arch/um/include/asm/b=
pf_perf_event.h
> new file mode 100644
> index 000000000000..0a30420c83de
> --- /dev/null
> +++ b/arch/um/include/asm/bpf_perf_event.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm-generic/bpf_perf_event.h>
> --
> 2.39.2
>


I guess this is a step backward.

Technically, kernel-space asm/*.h files are allowed to
wrap UAPI <asm-generic/*.h>.
There is no reason why we ban generic-y for doing this,
whereas check-in source is allowed.




--
Best Regards
Masahiro Yamada

