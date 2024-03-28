Return-Path: <linux-arch+bounces-3264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B888FF50
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD69294C10
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A521272A7;
	Thu, 28 Mar 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="r3mlxuV6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9C83A14;
	Thu, 28 Mar 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629649; cv=none; b=fJr3CBDTqEUqgnp/D+hCiPdSxw1iq3SfskuXe4Bcg1qtB3mbJZcEGdadidCDSbIMlIhEur4Oq36GTTu0lc4GzvMHabXQj98FrepVqOl4Q2g9tRzgkzy/dafBDDLvyHHDn66cjhMPKsLVg5LqcWeOFUnN8w4UM8zWEO1v2RiwlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629649; c=relaxed/simple;
	bh=x3TQGYCfxqNJk2v0Ut1AFO+Oo3+WufsKYamV7ax/lvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3jZTQAwRO+bZsdvPmrs6LF7xosZ6mNn4W4ebuan86Jbk0X8I282KudzOzpBmMsA9cmsVti3ZvXp0AD/CyUVNNWohb9hgbwYes6Pgqh88yT9A/m7av9GXFYbiujRckdKYZRX95DnzUXiHGcfDnlB2IzuZZWWskDxYHDlVd4JaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=r3mlxuV6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711629595; x=1712234395; i=deller@gmx.de;
	bh=OcaPQ/YLAkQ4Yfs0ARFNRC7QTLGsd2CnFzORCuSApDw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=r3mlxuV6fZG4GNUbwLTgqCELwOPup6gs6/aJ9BW15Z9DXrPFwbDCGn1uv7TV5D3a
	 vG8RgcSevNYbSTgPQF5GrZIWuFxCzTyyD/x5NolpnMTIjeM9S/wnbLoJ0OZfrqxf4
	 7f3D4JMj8DQaK25n4dRkKVqrepc+L+o+JgmTU6GT2tn3AloonGA50hRe5ZJuIhmi+
	 cN1QYMIjkZD5bEmTLBFuQcKwB6N4KRIfYIwU/LdYcU3qZFD3qmpORB9+Xk04bBBr3
	 0hlTidX7LQ009X/BVxug8463q2lBy/XoF9fdJugkpGaugBQ00En9zSFWYxC7PHUPC
	 8lxYE+fAD2UhNM1+IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1sC2tE1Kvz-00MpkI; Thu, 28
 Mar 2024 13:39:55 +0100
Message-ID: <70aefe08-b4c4-4738-a223-e4b04562cd56@gmx.de>
Date: Thu, 28 Mar 2024 13:39:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
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
 <20240327204450.14914-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240327204450.14914-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tdzWKBL0P5Wfrjj8yny8Q2lhw+7grSIiFh5Q0dWgyFJJyQtp97n
 7yW0OxyxmQ4RmQZcPMPcfWKLpDiA9fV7zmf5VhxMbyIqH/cEqbjd6qlgZE0mNtummvbAHsL
 drn/A1jBNNjPS387hymUaTCxPHw8T2VxgIQ2CKXP8w9BQIIhn7y8YrJnQlIsn6MorknokHj
 ntFVjgd6CuyklDh/qiPog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D2qBu+HavM4=;k8FmDd1t1U1FjeH6FKiF1DaXqYp
 ROvL0p1wFzp/tzOYRBoZWPN7tAQG+ZrP7pQ6ztPNN73BLJkKyVKE9Isru3oEjXw3MTOVA9Ezd
 gZppMzAiEgcBQhHIorV+2MLgsEuRrdVQU85oLX4dFfQ5iYlphg7nXi/5jmYERLvy7VPnteB+8
 9eDFe9KP6RKOwhVEZt+9G6O+LS7xvljRdO8CPRNnfvd5e4rthXGNzuMqSasE06QkJmCJgT3W6
 K/t2s5ODVZm/cVghaFaLuc79Xk9Iy/vGIAImToxZomxiqcuuxUi/aaldKJ9fir6sXYm0eGMdm
 QYYe8TcqkgPIElCEYL3tasSqJQRWhtYSmOELTetYLJsWKLX/enbTtrBMNBzXxQXu7yczo/J+H
 4ZO3x6peJ5Khv/0ksPyzMXMLXthWkC1qvr7ldnSmg3pk8+gYxOeiYlhRol/XT+DQ4hK1Re/jx
 KMzsF2tfPLir94oe3ogkGu/92gxxG5NXZoi/waZ8R/pL8K9AzblzBg8WrRWCHzWum0CXt8Nlw
 lNUQNfwXy60ZS7ApLwTsYjZd5LvmI6QcgO6IumiIHcKavIKm1VaLW/jDEq3TpOz8rLTARH+78
 zxH6iSHkEKPN0KpGbCUH09wGlt5VFajvDMbxhL0d+TRMT8Kgc7ZQg1rtn9DhvEWs8P0EkWlSl
 dKzwPwQzQ7farrNoJPW/ud0xqBoQDv+GAcYNOttNfn8dHtcNTdq0Rn++VaprFX7y55vpUCVw7
 Q6SqB0EwgzbwOr2cQRuc6WZXFwjxMucMerAxReY1nAa+62ehK0nK9Fx8SD8ObYiTwkKDKXhXN
 CJKPwBIsReEyp7tEUVxQfOtPNSP7pCBzF2pIeGHr60eiY=

On 3/27/24 21:41, Thomas Zimmermann wrote:
> Various Kconfig options selected the per-architecture helpers for
> fbdev. But none of the contained code depends on fbdev. Standardize
> on CONFIG_VIDEO, which will allow to add more general helpers for
> video functionality.
>
> CONFIG_VIDEO protects each architecture's video/ directory.

Your patch in general looks good.
But is renaming the config option from CONFIG_FB_CORE to CONFIG_VIDEO
the best choice?
CONFIG_VIDEO might be mixed up with multimedia/video-streaming.

Why not e.g. CONFIG_GRAPHICS_CORE?
I'm fine with CONFIG_VIDEO as well, but if someone has a better idea
we maybe should go with that instead now?

Helge

> This
> allows for the use of more fine-grained control for each directory's
> files, such as the use of CONFIG_STI_CORE on parisc.
>
> v2:
> - sparc: rebased onto Makefile changes
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
>   arch/parisc/Makefile      | 2 +-
>   arch/sparc/Makefile       | 4 ++--
>   arch/sparc/video/Makefile | 2 +-
>   arch/x86/Makefile         | 2 +-
>   arch/x86/video/Makefile   | 3 ++-
>   5 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 316f84f1d15c8..21b8166a68839 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -119,7 +119,7 @@ export LIBGCC
>
>   libs-y	+=3D arch/parisc/lib/ $(LIBGCC)
>
> -drivers-y +=3D arch/parisc/video/
> +drivers-$(CONFIG_VIDEO) +=3D arch/parisc/video/
>
>   boot	:=3D arch/parisc/boot
>
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index 2a03daa68f285..757451c3ea1df 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -59,8 +59,8 @@ endif
>   libs-y                 +=3D arch/sparc/prom/
>   libs-y                 +=3D arch/sparc/lib/
>
> -drivers-$(CONFIG_PM) +=3D arch/sparc/power/
> -drivers-$(CONFIG_FB_CORE) +=3D arch/sparc/video/
> +drivers-$(CONFIG_PM)    +=3D arch/sparc/power/
> +drivers-$(CONFIG_VIDEO) +=3D arch/sparc/video/
>
>   boot :=3D arch/sparc/boot
>
> diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
> index d4d83f1702c61..9dd82880a027a 100644
> --- a/arch/sparc/video/Makefile
> +++ b/arch/sparc/video/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>
> -obj-$(CONFIG_FB_CORE) +=3D fbdev.o
> +obj-y	+=3D fbdev.o
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 15a5f4f2ff0aa..c0ea612c62ebe 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -265,7 +265,7 @@ drivers-$(CONFIG_PCI)            +=3D arch/x86/pci/
>   # suspend and hibernation support
>   drivers-$(CONFIG_PM) +=3D arch/x86/power/
>
> -drivers-$(CONFIG_FB_CORE) +=3D arch/x86/video/
> +drivers-$(CONFIG_VIDEO) +=3D arch/x86/video/
>
>   ####
>   # boot loader support. Several targets are kept for legacy purposes
> diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
> index 5ebe48752ffc4..9dd82880a027a 100644
> --- a/arch/x86/video/Makefile
> +++ b/arch/x86/video/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_FB_CORE)		+=3D fbdev.o
> +
> +obj-y	+=3D fbdev.o


