Return-Path: <linux-arch+bounces-3265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF288FF82
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDEC1C28A4D
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B17F49D;
	Thu, 28 Mar 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="VeSmuAug"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00A1DDF6;
	Thu, 28 Mar 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630116; cv=none; b=beFzFIVZXAG/6rzOAbD6Xke2F76JmadwDRwBTBZQRWl4Ma/g/8cnqjGpYTN9rKB6yAt2xscWYT3BpmBDmLdBC9gZzkZjzWJoo6/AcJCnFPqavWQJBre8bEd0qF/Kzj4zXnbzMQ+AUfn6o33YD4QpiR82qlmtCY3HHm2ApPzVDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630116; c=relaxed/simple;
	bh=FNUIt0ocsLZ9qZk/DThX0Kb2rAFTF6AsFXwB5ZWl8Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0T+5lp8wD6rVNyR3YNBOJdQ+0Nou7xHdfFJyTnZlyhp+YASLHUCMb1T1RV9bVfExypHiarJGgsfXmoUSMjkjucLkC0cP4PnE0WPDUDOvhmzjAp115EzJLYbqg/X1Y4mBibXuuLW6KnlVnd3hhPcO7AVAZrCCHGFpLsDdarthUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=VeSmuAug; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711630023; x=1712234823; i=deller@gmx.de;
	bh=8na/zyjZD0u2TYNwE+0jjjNCkDyrkcSyNC+l8AEQE00=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VeSmuAug2lVIHZiHJBp/wJY/Gt6Lm3TVkv4VMBx7nZJADpDs9c3YMpIzm2IbXuzJ
	 YQdc7md5HsJfS245Qk1caRlGM/0GiA66JCgczW5KsYWHPjh8LpMIOzqDC+jwUskjE
	 Bu3LXN1kQInaYZ6DwYaHHPAswV2AjiYKc+6gLW4cQa7tiJ9QJ14ermp4hzQsgtKyH
	 UntEVcTI2DJaRzhZCmCAdikffdoGgDxagPRS/YFhyj4FBUjMbPeBNVBG6kTzOT/OA
	 y+mfb5gioIkFkAzgveigqvna+tvM36GLmX5/njDqdcj/63DyW+t16I8LqQWOOchNB
	 vMaMzESvgimezhD9+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzOm-1sCsKB1rR6-00PJG1; Thu, 28
 Mar 2024 13:47:03 +0100
Message-ID: <140d6bb3-5f44-49cb-846b-7141e551eedd@gmx.de>
Date: Thu, 28 Mar 2024 13:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arch: Rename fbdev header and source files
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
 javierm@redhat.com, sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-4-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240327204450.14914-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kdrc9D9r9USIun93zSr2JLw/vAv3sq5wTk8gHmFnb6XQektR/fq
 GhQ53k9BIjREOeObYqBZMJBnaes3m8FG8bDhlvbEEm0WmpyBonUlL01ycav3BG+aW3O6djF
 ayGVMh7NDmM1TpLfZUgnfVFZBL0FR085p8n9/9G7Wqpj/8BImxG9ktcad0TJoaNQpv8wF9j
 2MI/WK4goHZmaaQuNrorw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s4L/ZvV7O6s=;tMwz9sKO14GZISEQWMfN99vsgJV
 wvv88dMpra0N5mZGab3SepnKg2ieQXGU6UAM2lJ+AzowVMAXXZKCQuivWANVgIS9bnUuond6Y
 LsaWJf3aOkhYCZy7l8G2dVArjFKsxuSGOtyx1qIHSCvRkNFOywvSfeu9L4gUhCcsU8hsNVlVn
 A3D8QZHyg8Nhdwk1qkCnGu/RRQHKFynaUPUt9jolRq7oF9mH2J02q/E9WrKfLq2y0rtiUubws
 WC9IWrOyk6KYYFbgz/6LUHqfGIhGmg/5xo5/C0TXn0Hh7/jbyIu3JHkPFM0CPBiCZH/79Q7/q
 iHMpffUFHk3PgBd4fo7hzh0GqSZa9U9xVghblNuIiXQwPi1kDCVnqlQQ3vNVWZt1z7yjBV3Xm
 WdfUDqs24HfmCX+KUUOtLq7ScVtt8JmHAn/CjuWuTtrjd5PcV6h6wGrKubd7ywahFofkeGc7V
 LYSa5BI7mdTrATTjpfForoAInrbEV5YQWOWuj5x75ZrzviN3va/JNc6PP4waz5ZopAz09+uJw
 HKkHBlY8dfAu1qRB9blad1ikHnRlNUVN2sH9uq5+OuZXTdPqrwbb9fj3pjbiSu8OjVqgaFeEd
 wNE+zb42Zd03OREvBVdKxzo9VfyqEGO//HTVoqveFgZxaI8z0IUqnQmPCksgTlrvUPRbs00x1
 qCi2H6a0lOhIo4Y0bF5bEys76vFO0Y7kyaWvpDmKYmCFYicwo3tFzty8h93Fk5c8MIaDKmviM
 Yi6GlnDw+hlVSR0T6ji9o+QGt8XszgOEIphO8nzDArcHOgsL+KU8FnR89NEsvywDJn8Su3oqa
 8uJ4B3lrdDd+bv9CoS6RMB3af8KJDY9dGNfU/hJl6agvk=

On 3/27/24 21:41, Thomas Zimmermann wrote:
> The per-architecture fbdev code has no dependencies on fbdev and can
> be used for any video-related subsystem. Rename the files to 'video'.
> Use video-sti.c on parisc as the source file depends on CONFIG_STI_CORE.
>
> Further update all includes statements, includ guards, and Makefiles.
> Also update a few strings and comments to refer to video instead of
> fbdev.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>   arch/arc/include/asm/fb.h                    |  8 --------
>   arch/arc/include/asm/video.h                 |  8 ++++++++
>   arch/arm/include/asm/fb.h                    |  6 ------
>   arch/arm/include/asm/video.h                 |  6 ++++++
>   arch/arm64/include/asm/fb.h                  | 10 ----------
>   arch/arm64/include/asm/video.h               | 10 ++++++++++
>   arch/loongarch/include/asm/{fb.h =3D> video.h} |  8 ++++----
>   arch/m68k/include/asm/{fb.h =3D> video.h}      |  8 ++++----
>   arch/mips/include/asm/{fb.h =3D> video.h}      | 12 ++++++------
>   arch/parisc/include/asm/{fb.h =3D> video.h}    |  8 ++++----
>   arch/parisc/video/Makefile                   |  2 +-
>   arch/parisc/video/{fbdev.c =3D> video-sti.c}   |  2 +-
>   arch/powerpc/include/asm/{fb.h =3D> video.h}   |  8 ++++----
>   arch/powerpc/kernel/pci-common.c             |  2 +-
>   arch/sh/include/asm/fb.h                     |  7 -------
>   arch/sh/include/asm/video.h                  |  7 +++++++
>   arch/sparc/include/asm/{fb.h =3D> video.h}     |  8 ++++----
>   arch/sparc/video/Makefile                    |  2 +-
>   arch/sparc/video/{fbdev.c =3D> video.c}        |  4 ++--
>   arch/x86/include/asm/{fb.h =3D> video.h}       |  8 ++++----
>   arch/x86/video/Makefile                      |  2 +-
>   arch/x86/video/{fbdev.c =3D> video.c}          |  3 ++-
>   include/asm-generic/Kbuild                   |  2 +-
>   include/asm-generic/{fb.h =3D> video.h}        |  6 +++---
>   include/linux/fb.h                           |  2 +-
>   25 files changed, 75 insertions(+), 74 deletions(-)
>   delete mode 100644 arch/arc/include/asm/fb.h
>   create mode 100644 arch/arc/include/asm/video.h
>   delete mode 100644 arch/arm/include/asm/fb.h
>   create mode 100644 arch/arm/include/asm/video.h
>   delete mode 100644 arch/arm64/include/asm/fb.h
>   create mode 100644 arch/arm64/include/asm/video.h
>   rename arch/loongarch/include/asm/{fb.h =3D> video.h} (86%)
>   rename arch/m68k/include/asm/{fb.h =3D> video.h} (86%)
>   rename arch/mips/include/asm/{fb.h =3D> video.h} (76%)
>   rename arch/parisc/include/asm/{fb.h =3D> video.h} (68%)
>   rename arch/parisc/video/{fbdev.c =3D> video-sti.c} (96%)
>   rename arch/powerpc/include/asm/{fb.h =3D> video.h} (76%)
>   delete mode 100644 arch/sh/include/asm/fb.h
>   create mode 100644 arch/sh/include/asm/video.h
>   rename arch/sparc/include/asm/{fb.h =3D> video.h} (89%)
>   rename arch/sparc/video/{fbdev.c =3D> video.c} (86%)
>   rename arch/x86/include/asm/{fb.h =3D> video.h} (77%)
>   rename arch/x86/video/{fbdev.c =3D> video.c} (97%)
>   rename include/asm-generic/{fb.h =3D> video.h} (96%)
>
> diff --git a/arch/arc/include/asm/fb.h b/arch/arc/include/asm/fb.h
> deleted file mode 100644
> index 9c2383d29cbb9..0000000000000
> --- a/arch/arc/include/asm/fb.h
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> -
> -#include <asm-generic/fb.h>
> -
> -#endif /* _ASM_FB_H_ */
> diff --git a/arch/arc/include/asm/video.h b/arch/arc/include/asm/video.h
> new file mode 100644
> index 0000000000000..8ff7263727fe7
> --- /dev/null
> +++ b/arch/arc/include/asm/video.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
> +
> +#include <asm-generic/video.h>
> +
> +#endif /* _ASM_VIDEO_H_ */

I wonder, since that file simply #includes the generic version,
wasn't there a possibility that kbuild could symlink
the generic version for us?
Does it need to be mandatory in include/asm-generic/Kbuild ?
Same applies to a few other files below.

Helge



> diff --git a/arch/arm/include/asm/fb.h b/arch/arm/include/asm/fb.h
> deleted file mode 100644
> index ce20a43c30339..0000000000000
> --- a/arch/arm/include/asm/fb.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> -
> -#include <asm-generic/fb.h>
> -
> -#endif /* _ASM_FB_H_ */
> diff --git a/arch/arm/include/asm/video.h b/arch/arm/include/asm/video.h
> new file mode 100644
> index 0000000000000..f570565366e67
> --- /dev/null
> +++ b/arch/arm/include/asm/video.h
> @@ -0,0 +1,6 @@
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
> +
> +#include <asm-generic/video.h>
> +
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/arm64/include/asm/fb.h b/arch/arm64/include/asm/fb.h
> deleted file mode 100644
> index 1a495d8fb2ce0..0000000000000
> --- a/arch/arm64/include/asm/fb.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - */
> -#ifndef __ASM_FB_H_
> -#define __ASM_FB_H_
> -
> -#include <asm-generic/fb.h>
> -
> -#endif /* __ASM_FB_H_ */
> diff --git a/arch/arm64/include/asm/video.h b/arch/arm64/include/asm/vid=
eo.h
> new file mode 100644
> index 0000000000000..fe0e74983f4d9
> --- /dev/null
> +++ b/arch/arm64/include/asm/video.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +#ifndef __ASM_VIDEO_H_
> +#define __ASM_VIDEO_H_
> +
> +#include <asm-generic/video.h>
> +
> +#endif /* __ASM_VIDEO_H_ */
> diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/as=
m/video.h
> similarity index 86%
> rename from arch/loongarch/include/asm/fb.h
> rename to arch/loongarch/include/asm/video.h
> index 0b218b10a9ec3..9f76845f2d4fd 100644
> --- a/arch/loongarch/include/asm/fb.h
> +++ b/arch/loongarch/include/asm/video.h
> @@ -2,8 +2,8 @@
>   /*
>    * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>    */
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
>
>   #include <linux/compiler.h>
>   #include <linux/string.h>
> @@ -26,6 +26,6 @@ static inline void fb_memset_io(volatile void __iomem =
*addr, int c, size_t n)
>   }
>   #define fb_memset fb_memset_io
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_FB_H_ */
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/m68k/include/asm/fb.h b/arch/m68k/include/asm/video.h
> similarity index 86%
> rename from arch/m68k/include/asm/fb.h
> rename to arch/m68k/include/asm/video.h
> index 9941b7434b696..6cf2194c413d8 100644
> --- a/arch/m68k/include/asm/fb.h
> +++ b/arch/m68k/include/asm/video.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
>
>   #include <asm/page.h>
>   #include <asm/setup.h>
> @@ -27,6 +27,6 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t pro=
t,
>   }
>   #define pgprot_framebuffer pgprot_framebuffer
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_FB_H_ */
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/mips/include/asm/fb.h b/arch/mips/include/asm/video.h
> similarity index 76%
> rename from arch/mips/include/asm/fb.h
> rename to arch/mips/include/asm/video.h
> index d98d6681d64ec..007c106d980fd 100644
> --- a/arch/mips/include/asm/fb.h
> +++ b/arch/mips/include/asm/video.h
> @@ -1,5 +1,5 @@
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
>
>   #include <asm/page.h>
>
> @@ -13,8 +13,8 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t pro=
t,
>
>   /*
>    * MIPS doesn't define __raw_ I/O macros, so the helpers
> - * in <asm-generic/fb.h> don't generate fb_readq() and
> - * fb_write(). We have to provide them here.
> + * in <asm-generic/video.h> don't generate fb_readq() and
> + * fb_writeq(). We have to provide them here.
>    *
>    * TODO: Convert MIPS to generic I/O. The helpers below can
>    *       then be removed.
> @@ -33,6 +33,6 @@ static inline void fb_writeq(u64 b, volatile void __io=
mem *addr)
>   #define fb_writeq fb_writeq
>   #endif
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_FB_H_ */
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/vide=
o.h
> similarity index 68%
> rename from arch/parisc/include/asm/fb.h
> rename to arch/parisc/include/asm/video.h
> index ed2a195a3e762..c5dff3223194a 100644
> --- a/arch/parisc/include/asm/fb.h
> +++ b/arch/parisc/include/asm/video.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
>
>   #include <linux/types.h>
>
> @@ -11,6 +11,6 @@ bool video_is_primary_device(struct device *dev);
>   #define video_is_primary_device video_is_primary_device
>   #endif
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_FB_H_ */
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/parisc/video/Makefile b/arch/parisc/video/Makefile
> index 16a73cce46612..b5db5b42880f8 100644
> --- a/arch/parisc/video/Makefile
> +++ b/arch/parisc/video/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>
> -obj-$(CONFIG_STI_CORE) +=3D fbdev.o
> +obj-$(CONFIG_STI_CORE) +=3D video-sti.o
> diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/video-sti.c
> similarity index 96%
> rename from arch/parisc/video/fbdev.c
> rename to arch/parisc/video/video-sti.c
> index 540fa0c919d59..564661e87093c 100644
> --- a/arch/parisc/video/fbdev.c
> +++ b/arch/parisc/video/video-sti.c
> @@ -9,7 +9,7 @@
>
>   #include <video/sticore.h>
>
> -#include <asm/fb.h>
> +#include <asm/video.h>
>
>   bool video_is_primary_device(struct device *dev)
>   {
> diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/vi=
deo.h
> similarity index 76%
> rename from arch/powerpc/include/asm/fb.h
> rename to arch/powerpc/include/asm/video.h
> index c0c5d1df7ad1e..e1770114ffc36 100644
> --- a/arch/powerpc/include/asm/fb.h
> +++ b/arch/powerpc/include/asm/video.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
>
>   #include <asm/page.h>
>
> @@ -12,6 +12,6 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t pro=
t,
>   }
>   #define pgprot_framebuffer pgprot_framebuffer
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_FB_H_ */
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c
> index d95a48eff412e..eac84d687b53f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -517,7 +517,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, str=
uct vm_area_struct *vma)
>   }
>
>   /*
> - * This one is used by /dev/mem and fbdev who have no clue about the
> + * This one is used by /dev/mem and video who have no clue about the
>    * PCI device, it tries to find the PCI device first and calls the
>    * above routine
>    */
> diff --git a/arch/sh/include/asm/fb.h b/arch/sh/include/asm/fb.h
> deleted file mode 100644
> index 19df13ee9ca73..0000000000000
> --- a/arch/sh/include/asm/fb.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_FB_H_
> -#define _ASM_FB_H_
> -
> -#include <asm-generic/fb.h>
> -
> -#endif /* _ASM_FB_H_ */
> diff --git a/arch/sh/include/asm/video.h b/arch/sh/include/asm/video.h
> new file mode 100644
> index 0000000000000..14f49934a247a
> --- /dev/null
> +++ b/arch/sh/include/asm/video.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_VIDEO_H_
> +#define _ASM_VIDEO_H_
> +
> +#include <asm-generic/video.h>
> +
> +#endif /* _ASM_VIDEO_H_ */
> diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/video.=
h
> similarity index 89%
> rename from arch/sparc/include/asm/fb.h
> rename to arch/sparc/include/asm/video.h
> index 07f0325d6921c..a6f48f52db584 100644
> --- a/arch/sparc/include/asm/fb.h
> +++ b/arch/sparc/include/asm/video.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _SPARC_FB_H_
> -#define _SPARC_FB_H_
> +#ifndef _SPARC_VIDEO_H_
> +#define _SPARC_VIDEO_H_
>
>   #include <linux/io.h>
>   #include <linux/types.h>
> @@ -40,6 +40,6 @@ static inline void fb_memset_io(volatile void __iomem =
*addr, int c, size_t n)
>   }
>   #define fb_memset fb_memset_io
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _SPARC_FB_H_ */
> +#endif /* _SPARC_VIDEO_H_ */
> diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
> index 9dd82880a027a..fdf83a408d750 100644
> --- a/arch/sparc/video/Makefile
> +++ b/arch/sparc/video/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>
> -obj-y	+=3D fbdev.o
> +obj-y	+=3D video.o
> diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/video.c
> similarity index 86%
> rename from arch/sparc/video/fbdev.c
> rename to arch/sparc/video/video.c
> index e46f0499c2774..2414380caadc9 100644
> --- a/arch/sparc/video/fbdev.c
> +++ b/arch/sparc/video/video.c
> @@ -4,8 +4,8 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>
> -#include <asm/fb.h>
>   #include <asm/prom.h>
> +#include <asm/video.h>
>
>   bool video_is_primary_device(struct device *dev)
>   {
> @@ -21,5 +21,5 @@ bool video_is_primary_device(struct device *dev)
>   }
>   EXPORT_SYMBOL(video_is_primary_device);
>
> -MODULE_DESCRIPTION("Sparc fbdev helpers");
> +MODULE_DESCRIPTION("Sparc video helpers");
>   MODULE_LICENSE("GPL");
> diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/video.h
> similarity index 77%
> rename from arch/x86/include/asm/fb.h
> rename to arch/x86/include/asm/video.h
> index 999db33792869..0950c9535fae9 100644
> --- a/arch/x86/include/asm/fb.h
> +++ b/arch/x86/include/asm/video.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_FB_H
> -#define _ASM_X86_FB_H
> +#ifndef _ASM_X86_VIDEO_H
> +#define _ASM_X86_VIDEO_H
>
>   #include <linux/types.h>
>
> @@ -16,6 +16,6 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
>   bool video_is_primary_device(struct device *dev);
>   #define video_is_primary_device video_is_primary_device
>
> -#include <asm-generic/fb.h>
> +#include <asm-generic/video.h>
>
> -#endif /* _ASM_X86_FB_H */
> +#endif /* _ASM_X86_VIDEO_H */
> diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
> index 9dd82880a027a..fdf83a408d750 100644
> --- a/arch/x86/video/Makefile
> +++ b/arch/x86/video/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>
> -obj-y	+=3D fbdev.o
> +obj-y	+=3D video.o
> diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/video.c
> similarity index 97%
> rename from arch/x86/video/fbdev.c
> rename to arch/x86/video/video.c
> index 4d87ce8e257fe..81fc97a2a837a 100644
> --- a/arch/x86/video/fbdev.c
> +++ b/arch/x86/video/video.c
> @@ -10,7 +10,8 @@
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/vgaarb.h>
> -#include <asm/fb.h>
> +
> +#include <asm/video.h>
>
>   pgprot_t pgprot_framebuffer(pgprot_t prot,
>   			    unsigned long vm_start, unsigned long vm_end,
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index d436bee4d129d..b20fa25a7e8d8 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -22,7 +22,6 @@ mandatory-y +=3D dma-mapping.h
>   mandatory-y +=3D dma.h
>   mandatory-y +=3D emergency-restart.h
>   mandatory-y +=3D exec.h
> -mandatory-y +=3D fb.h
>   mandatory-y +=3D ftrace.h
>   mandatory-y +=3D futex.h
>   mandatory-y +=3D hardirq.h
> @@ -62,5 +61,6 @@ mandatory-y +=3D uaccess.h
>   mandatory-y +=3D unaligned.h
>   mandatory-y +=3D vermagic.h
>   mandatory-y +=3D vga.h
> +mandatory-y +=3D video.h
>   mandatory-y +=3D word-at-a-time.h
>   mandatory-y +=3D xor.h
> diff --git a/include/asm-generic/fb.h b/include/asm-generic/video.h
> similarity index 96%
> rename from include/asm-generic/fb.h
> rename to include/asm-generic/video.h
> index 4788c1e1c6bc0..b1da2309d9434 100644
> --- a/include/asm-generic/fb.h
> +++ b/include/asm-generic/video.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>
> -#ifndef __ASM_GENERIC_FB_H_
> -#define __ASM_GENERIC_FB_H_
> +#ifndef __ASM_GENERIC_VIDEO_H_
> +#define __ASM_GENERIC_VIDEO_H_
>
>   /*
>    * Only include this header file from your architecture's <asm/fb.h>.
> @@ -133,4 +133,4 @@ static inline void fb_memset_io(volatile void __iome=
m *addr, int c, size_t n)
>   #define fb_memset fb_memset_io
>   #endif
>
> -#endif /* __ASM_GENERIC_FB_H_ */
> +#endif /* __ASM_GENERIC_VIDEO_H_ */
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 708e6a177b1be..1f23e0c505424 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -12,7 +12,7 @@
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>
> -#include <asm/fb.h>
> +#include <asm/video.h>
>
>   struct backlight_device;
>   struct device;


