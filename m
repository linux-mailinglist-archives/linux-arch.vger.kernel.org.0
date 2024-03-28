Return-Path: <linux-arch+bounces-3263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4450288FDB2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07C129606B
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B973528;
	Thu, 28 Mar 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="C4TYakAa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C0535A4;
	Thu, 28 Mar 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623933; cv=none; b=Q24Te9j1kCpdzR7sF1e71oe8T6U4LfyMu8Cq/rT9ez3ZBlK8F1Wuty2EMg2n8FbHHdaNjPatc2vBOsrbLcVeqQwgno1w8jVMejf9CduZ8HPIm7NaWQwogZwm8CPpXFx2QkPuJx4So75blHU0PA+G58Vvev1i1ceWjUbAlH9yb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623933; c=relaxed/simple;
	bh=RxwgDtb3KKDcytkXAi7wGQBpphqqgNo2Idn6VQ7P3jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+NWqeFWrnPNeBrjDS02c5tQcI6IDdX0D0gbVnHHd7TIjnEZywM4rmSOUK2lc17hIqvdr/d4tRVj1ldhN5U+ofRVvt5L/pxk1PybQ2/wCl7y3JNtDHzBXXI2vEHEIp6tJIJeenvjiVXA6H6oaKJz/0mn9L1kz86Eh33/yIIAQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=C4TYakAa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711623862; x=1712228662; i=deller@gmx.de;
	bh=9/16Qzrw3seVqIzw3vOPat5jqGCo0xh0NQwrsRCPyY4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C4TYakAaZ0uRrmB4kYbMMObcroodqai+f8r9F+1JkXTmB34rM6P4dApxX3VVfiJu
	 djO9PSqy8gALD4P1buiRcQwbplf3kvVIJBpsze9N9dHIys97x9j8e7xB9Fbo8YiP/
	 FnVL/uuTY2Z7Ar9YuAocpSn0q46F5dLPp08TMHaNi50wSPQJZPScHEcz42YGW+P0E
	 902g/MEPvKRc7k8IIaKGKFaCGXqMHEG6oi/EMgdDS+tosgXvLSPfhGHm7n9ok5XCV
	 D1sYs1erxG+lSoRLxADDe9jJ/P+3Osre6YItkylC10Pwv3B6ZyiGmwGnuZ8Qxohs0
	 c+a/oQjsSG3p/OBJ+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1rzRet11Th-00CVKE; Thu, 28
 Mar 2024 12:04:22 +0100
Message-ID: <b5a8bc60-ad16-407d-9e57-c224467c3f06@gmx.de>
Date: Thu, 28 Mar 2024 12:04:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arch: Remove struct fb_info from video helpers
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
 javierm@redhat.com, sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-3-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20240327204450.14914-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MkWerH/kos999V3d+lXJIMTQR7GQxw4lOR8ujKMTFrxBBP7ED+v
 nCbh+i8OdPfgMXpIGn8F/RzVnZUcX6qDw8V3E3UjKq7SahbOvuUOOuYxXCXnsnkfPvuPSPx
 NctfQzZG6pYQPeGTYdE4BZyLtBUkECsbnyx+wy41zWcvFfBUL0ZdEV+vBIMDG1cUK97B23Y
 bYcjwlnnFHbk9uuxDY1Pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dx/DFQx+Tp4=;1jQ9Mrb8iRQltfotF+w9pgqJHIU
 iECm7T+rje2zL8zTenHrlnXQeSQONr+FaCg++dwSppO9FrKmnOynFxtQ1jyXodrNmfRA4EM2C
 /kdonCGFZRVMEC4AcjMX7CNdfXgsm1PmDtM2PS0PsIbyNKOmJmCtNuuG9DOEoRGaKT/OmufGQ
 cPT3e2vNV5TO0H5v5dN3qXQpwQcMUyCRRykHrNNkHaaDaRr/ZzOBfPtwoGtzil4eqbx0TIkOo
 8I9XEksMi45hN+vQgsIabvbBnXPxG+Fuihr1d57qQ+/UR6jSOef4YNJR55CwHf1yV8LWeYcB9
 tMEXYafQh0yPfMWzJ/yu1u/wJ3NKEd2pT+8YrPOaGbbIZdkF8PejKNoHpYUdHS2t/xLztKwTh
 rhlz/heBK6RM48buMgfEBqNqUpsDlZKNwFNN7Z4o95iliHLA7+giKcS18HKNrDh3XshSVQ2rZ
 VjcTSxmIH+kh7TpiRLkEqeKTKJS0KelvWbmjfRs9p6Kzhvwo29FqEGgfH1hafrj9jW6PzlK/h
 A/QFPSlM7XYYaxDZleWtbvkBLV1BepzjXr5+iOVTsm4uM4c25HzPeMxhc8oDU4L6YKB+pLEO3
 Aw+jKKaQp4sVRDwv9GzTF3Q55ZVvXsp/UU7zdvWVV4TxP3x3RxjHolkwUKBZujW9XbU4hlCvT
 BLm2eTF4CFq1OGxuF4fB8uaJdeSD3OhcfM1hRXrkJhc63H2CmU8Ox39fu3XsON7uxF6uoGbKr
 oR/lcEwnqlmBE3cSgbdmfMEkH+kJSathXvIL/qcBBkiopu6f0im4JDJQZnzpo5SbJjDZAQ0uQ
 uiyyFR4ac2BxBvD3fYVQocyztn+eex+y0OBO5nR6HM7pM=

On 3/27/24 21:41, Thomas Zimmermann wrote:
> The per-architecture video helpers do not depend on struct fb_info
> or anything else from fbdev. Remove it from the interface and replace
> fb_is_primary_device() with video_is_primary_device(). The new helper

Since you rename this function, wouldn't something similar to

device_is_primary_display()
	or
device_is_primary_console()
	or
is_primary_graphics_device()
	or
is_primary_display_device()

be a better name?

Helge

> is similar in functionality, but can operate on non-fbdev devices.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>   arch/parisc/include/asm/fb.h     |  8 +++++---
>   arch/parisc/video/fbdev.c        |  9 +++++----
>   arch/sparc/include/asm/fb.h      |  7 ++++---
>   arch/sparc/video/fbdev.c         | 17 ++++++++---------
>   arch/x86/include/asm/fb.h        |  8 +++++---
>   arch/x86/video/fbdev.c           | 18 +++++++-----------
>   drivers/video/fbdev/core/fbcon.c |  2 +-
>   include/asm-generic/fb.h         | 11 ++++++-----
>   8 files changed, 41 insertions(+), 39 deletions(-)
>
> diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/fb.h
> index 658a8a7dc5312..ed2a195a3e762 100644
> --- a/arch/parisc/include/asm/fb.h
> +++ b/arch/parisc/include/asm/fb.h
> @@ -2,11 +2,13 @@
>   #ifndef _ASM_FB_H_
>   #define _ASM_FB_H_
>
> -struct fb_info;
> +#include <linux/types.h>
> +
> +struct device;
>
>   #if defined(CONFIG_STI_CORE)
> -int fb_is_primary_device(struct fb_info *info);
> -#define fb_is_primary_device fb_is_primary_device
> +bool video_is_primary_device(struct device *dev);
> +#define video_is_primary_device video_is_primary_device
>   #endif
>
>   #include <asm-generic/fb.h>
> diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
> index e4f8ac99fc9e0..540fa0c919d59 100644
> --- a/arch/parisc/video/fbdev.c
> +++ b/arch/parisc/video/fbdev.c
> @@ -5,12 +5,13 @@
>    * Copyright (C) 2001-2002 Thomas Bogendoerfer <tsbogend@alpha.franken=
.de>
>    */
>
> -#include <linux/fb.h>
>   #include <linux/module.h>
>
>   #include <video/sticore.h>
>
> -int fb_is_primary_device(struct fb_info *info)
> +#include <asm/fb.h>
> +
> +bool video_is_primary_device(struct device *dev)
>   {
>   	struct sti_struct *sti;
>
> @@ -21,6 +22,6 @@ int fb_is_primary_device(struct fb_info *info)
>   		return true;
>
>   	/* return true if it's the default built-in framebuffer driver */
> -	return (sti->dev =3D=3D info->device);
> +	return (sti->dev =3D=3D dev);
>   }
> -EXPORT_SYMBOL(fb_is_primary_device);
> +EXPORT_SYMBOL(video_is_primary_device);
> diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
> index 24440c0fda490..07f0325d6921c 100644
> --- a/arch/sparc/include/asm/fb.h
> +++ b/arch/sparc/include/asm/fb.h
> @@ -3,10 +3,11 @@
>   #define _SPARC_FB_H_
>
>   #include <linux/io.h>
> +#include <linux/types.h>
>
>   #include <asm/page.h>
>
> -struct fb_info;
> +struct device;
>
>   #ifdef CONFIG_SPARC32
>   static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
> @@ -18,8 +19,8 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t pro=
t,
>   #define pgprot_framebuffer pgprot_framebuffer
>   #endif
>
> -int fb_is_primary_device(struct fb_info *info);
> -#define fb_is_primary_device fb_is_primary_device
> +bool video_is_primary_device(struct device *dev);
> +#define video_is_primary_device video_is_primary_device
>
>   static inline void fb_memcpy_fromio(void *to, const volatile void __io=
mem *from, size_t n)
>   {
> diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
> index bff66dd1909a4..e46f0499c2774 100644
> --- a/arch/sparc/video/fbdev.c
> +++ b/arch/sparc/video/fbdev.c
> @@ -1,26 +1,25 @@
>   // SPDX-License-Identifier: GPL-2.0
>
>   #include <linux/console.h>
> -#include <linux/fb.h>
> +#include <linux/device.h>
>   #include <linux/module.h>
>
> +#include <asm/fb.h>
>   #include <asm/prom.h>
>
> -int fb_is_primary_device(struct fb_info *info)
> +bool video_is_primary_device(struct device *dev)
>   {
> -	struct device *dev =3D info->device;
> -	struct device_node *node;
> +	struct device_node *node =3D dev->of_node;
>
>   	if (console_set_on_cmdline)
> -		return 0;
> +		return false;
>
> -	node =3D dev->of_node;
>   	if (node && node =3D=3D of_console_device)
> -		return 1;
> +		return true;
>
> -	return 0;
> +	return false;
>   }
> -EXPORT_SYMBOL(fb_is_primary_device);
> +EXPORT_SYMBOL(video_is_primary_device);
>
>   MODULE_DESCRIPTION("Sparc fbdev helpers");
>   MODULE_LICENSE("GPL");
> diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/fb.h
> index c3b9582de7efd..999db33792869 100644
> --- a/arch/x86/include/asm/fb.h
> +++ b/arch/x86/include/asm/fb.h
> @@ -2,17 +2,19 @@
>   #ifndef _ASM_X86_FB_H
>   #define _ASM_X86_FB_H
>
> +#include <linux/types.h>
> +
>   #include <asm/page.h>
>
> -struct fb_info;
> +struct device;
>
>   pgprot_t pgprot_framebuffer(pgprot_t prot,
>   			    unsigned long vm_start, unsigned long vm_end,
>   			    unsigned long offset);
>   #define pgprot_framebuffer pgprot_framebuffer
>
> -int fb_is_primary_device(struct fb_info *info);
> -#define fb_is_primary_device fb_is_primary_device
> +bool video_is_primary_device(struct device *dev);
> +#define video_is_primary_device video_is_primary_device
>
>   #include <asm-generic/fb.h>
>
> diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
> index 1dd6528cc947c..4d87ce8e257fe 100644
> --- a/arch/x86/video/fbdev.c
> +++ b/arch/x86/video/fbdev.c
> @@ -7,7 +7,6 @@
>    *
>    */
>
> -#include <linux/fb.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/vgaarb.h>
> @@ -25,20 +24,17 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
>   }
>   EXPORT_SYMBOL(pgprot_framebuffer);
>
> -int fb_is_primary_device(struct fb_info *info)
> +bool video_is_primary_device(struct device *dev)
>   {
> -	struct device *device =3D info->device;
> -	struct pci_dev *pci_dev;
> +	struct pci_dev *pdev;
>
> -	if (!device || !dev_is_pci(device))
> -		return 0;
> +	if (!dev_is_pci(dev))
> +		return false;
>
> -	pci_dev =3D to_pci_dev(device);
> +	pdev =3D to_pci_dev(dev);
>
> -	if (pci_dev =3D=3D vga_default_device())
> -		return 1;
> -	return 0;
> +	return (pdev =3D=3D vga_default_device());
>   }
> -EXPORT_SYMBOL(fb_is_primary_device);
> +EXPORT_SYMBOL(video_is_primary_device);
>
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index 46823c2e2ba12..85c5c8cbc680a 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2939,7 +2939,7 @@ void fbcon_remap_all(struct fb_info *info)
>   static void fbcon_select_primary(struct fb_info *info)
>   {
>   	if (!map_override && primary_device =3D=3D -1 &&
> -	    fb_is_primary_device(info)) {
> +	    video_is_primary_device(info->device)) {
>   		int i;
>
>   		printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
> diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
> index 6ccabb400aa66..4788c1e1c6bc0 100644
> --- a/include/asm-generic/fb.h
> +++ b/include/asm-generic/fb.h
> @@ -10,8 +10,9 @@
>   #include <linux/io.h>
>   #include <linux/mm_types.h>
>   #include <linux/pgtable.h>
> +#include <linux/types.h>
>
> -struct fb_info;
> +struct device;
>
>   #ifndef pgprot_framebuffer
>   #define pgprot_framebuffer pgprot_framebuffer
> @@ -23,11 +24,11 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t p=
rot,
>   }
>   #endif
>
> -#ifndef fb_is_primary_device
> -#define fb_is_primary_device fb_is_primary_device
> -static inline int fb_is_primary_device(struct fb_info *info)
> +#ifndef video_is_primary_device
> +#define video_is_primary_device video_is_primary_device
> +static inline bool video_is_primary_device(struct device *dev)
>   {
> -	return 0;
> +	return false;
>   }
>   #endif
>


