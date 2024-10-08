Return-Path: <linux-arch+bounces-7819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11CD9942D4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA512832D4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C771E1C13;
	Tue,  8 Oct 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="POSKCKOp"
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B461E1C0E;
	Tue,  8 Oct 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376397; cv=none; b=Uuz/0ooDn94DhqmDGhN3mzjaYjrpxBHF4FmHos2OjBlb2M5k06thQtVOA2FABjH1YBw8L337TPeV3Veqm8kqkuII3uUWG2/UUxIP3RseW6SsQgG6UZQ4V7eMkDpjSjkor+00g/S3JoD5pXhP0B54Y0uFb44x3rhuvorlZFc0uO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376397; c=relaxed/simple;
	bh=Wi/Ne+shDHOFqw+Lugm22uvGCgtt/bIev0jwFPOvR2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pB4iQjfLwnZchu1HSsUzTUDJeoAitMFfihNSJ8iMcr6kLuybhmT4ISUBdymi7GvOX/mYo4Hn7F6JEJyzOsFHvMlmJ9UjHVnUMnybWIq4UVFx4OWwBMZ9s59IGyuIM3AqeY7SM2NDhafT80vnC2xPLq1uXuqCWJ+IAG7/bM8+3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=POSKCKOp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EFBD1C000A;
	Tue,  8 Oct 2024 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728376392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmLP/WI1VtrRBkIucS2941CxDdB37ieasR6WFFSWafs=;
	b=POSKCKOpM0S5Rro9I7JX/yFDGVQEbxnQfOlbhvDuVflBTc9b0oQzIQp7fKtzf6mJwdOQ+0
	Ea9yaFhepRPa3MqaYNcDO/VEW6QLHJqANEHtweXO5D876vZq8tICxDlfjrmrbTDnklWsBz
	0pAYroBCDAgXQON2fmL69ED1dgdlzDy5jho/yQO5tqH0EdwHwUBc86MuNxTZZ0aBcTJr+T
	UHYVDWD5LAAELveRyE4v2cHZeoPtNyyU8w7VYOZiIGEcGGrpmUancBz/ZYPglMSFDCCVy6
	Izc1kwXhCGbPtsztfFaqEyh0UYZq966m3DrL4DrW+CqDmsEUQlcF0xSAXpcASQ==
Date: Tue, 8 Oct 2024 10:33:06 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-sound@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v8 13/14] mtd: Add HAS_IOMEM || INDIRECT_IOMEM
 dependency
Message-ID: <20241008103306.44123824@xps-13>
In-Reply-To: <20241008075023.3052370-14-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
	<20241008075023.3052370-14-jvetter@kalrayinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Julian,

jvetter@kalrayinc.com wrote on Tue,  8 Oct 2024 09:50:21 +0200:

> The UM arch doesn't have HAS_IOMEM=3Dy, so the build fails because the
> functions memcpy_fromio and memcpy_toio are not defined anymore. These
> functions are only build for targets which have HAS_IOMEM=3Dy or
> INDIRECT_IOMEM=3Dy. So, depend on either of the two.

There are many mtd drivers using memcpy_fromio and memcpy_toio, I'm not
sure I get why only this subset of drivers would be impacted?

Also, from a general standpoint, I don't see with a good eye the
proliferation of the use of || INDIRECT_IOMEM just for the um
architecture:

$ git grep HAS_IOMEM | wc -l
611
$ git grep INDIRECT_IOMEM | wc -l
15

I believe the Kconfig symbol should adapt to reflect the fact that IO
operations are fine, regardless of their type ("direct" or "indirect")
rather than move the load on the individual drivers.

> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v8:
> - New patch
> ---
>  drivers/mtd/chips/Kconfig | 4 ++++
>  drivers/mtd/lpddr/Kconfig | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
> index 19726ebd973d..78afe7ccf005 100644
> --- a/drivers/mtd/chips/Kconfig
> +++ b/drivers/mtd/chips/Kconfig
> @@ -4,6 +4,7 @@ menu "RAM/ROM/Flash chip drivers"
> =20
>  config MTD_CFI
>  	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_GEN_PROBE
>  	select MTD_CFI_UTIL
>  	help
> @@ -16,6 +17,7 @@ config MTD_CFI
> =20
>  config MTD_JEDECPROBE
>  	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_GEN_PROBE
>  	select MTD_CFI_UTIL
>  	help
> @@ -211,12 +213,14 @@ config MTD_CFI_UTIL
> =20
>  config MTD_RAM
>  	tristate "Support for RAM chips in bus mapping"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  This option enables basic support for RAM chips accessed through
>  	  a bus mapping driver.
> =20
>  config MTD_ROM
>  	tristate "Support for ROM chips in bus mapping"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  This option enables basic support for ROM chips accessed through
>  	  a bus mapping driver.
> diff --git a/drivers/mtd/lpddr/Kconfig b/drivers/mtd/lpddr/Kconfig
> index 0395aa6b68f1..f35dd8052abc 100644
> --- a/drivers/mtd/lpddr/Kconfig
> +++ b/drivers/mtd/lpddr/Kconfig
> @@ -4,6 +4,7 @@ menu "LPDDR & LPDDR2 PCM memory drivers"
> =20
>  config MTD_LPDDR
>  	tristate "Support for LPDDR flash chips"
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	select MTD_QINFO_PROBE
>  	help
>  	  This option enables support of LPDDR (Low power double data rate)


Thanks,
Miqu=C3=A8l

