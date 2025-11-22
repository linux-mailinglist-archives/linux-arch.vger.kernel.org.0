Return-Path: <linux-arch+bounces-15051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9893C7CC12
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9C353D7F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E802DF6F8;
	Sat, 22 Nov 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="AMUxtdRR"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469802C3248;
	Sat, 22 Nov 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763805276; cv=none; b=iuddO8h9VjXYhfYXkbllm1pr03lmYZuZgMsTulnheDkw/CavyXi34yKiVtDdfiMjCDS+gLnnGSkG2+dEJiPI7+QUe/zlHshChfrZpGJfvTGj8FbJKpcVxb450TLh/yO/FmpXHeW4khvNqabufsrc2NU0clcLh9oE3sYnLBv+Ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763805276; c=relaxed/simple;
	bh=4Y2Ut7bb15pm2pGX4raLtavlvcmRI5m2gZCvICKDGKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4mONnt9356pcT0Nzi+qdBIiqOquyWyIAG4AXen91og58/v5iIhMqr41E4d4PXPEFUfSkNau8xLaccw1nycodm0uOO0FRThZecSxerWAew/VVIRk1NbomizVsfDPVPZa0TWVM7YhdJQYsQQR1sg5TmWyk3SuoCFRHwv4KKwUAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=AMUxtdRR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1763804707; bh=4Y2Ut7bb15pm2pGX4raLtavlvcmRI5m2gZCvICKDGKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMUxtdRR1iHmXuTVWMr3qwrDWhD6NyV5lTEFNu5r6kPak/iyUJcgDyFenaZz2L+VY
	 KiG3aMqlu/6MoP9QWWC0NAIpuqX7aNa8XIeXphJW0nplrJW5x/IbdTkur/3PO5duVa
	 nSED/RoUm+0uuvITOkdB32RiaaMgTZAAT/s55KPE=
Date: Sat, 22 Nov 2025 10:45:07 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for
 32BIT/64BIT
Message-ID: <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122043634.3447854-14-chenhuacai@loongson.cn>

On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
> Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> loongson64_defconfig (for 64BIT).
> 
> Also adjust graphics drivers, such as FB_EFI is replaced with EFIDRM.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Makefile                       |    7 +-
>  arch/loongarch/configs/loongson32_defconfig   | 1104 +++++++++++++++++
>  ...ongson3_defconfig => loongson64_defconfig} |    6 +-
>  3 files changed, 1113 insertions(+), 4 deletions(-)
>  create mode 100644 arch/loongarch/configs/loongson32_defconfig
>  rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (99%)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 96ca1a688984..cf9373786969 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -5,7 +5,12 @@
>  
>  boot	:= arch/loongarch/boot
>  
> -KBUILD_DEFCONFIG := loongson3_defconfig
> +ifdef CONFIG_32BIT

Testing for CONFIG options here doesn't make sense, as the config is not yet
created. Either test for $(ARCH) or uname or just use one unconditionally.
Also as mentioned before, snippets can reduce the duplication.

> +KBUILD_DEFCONFIG := loongson32_defconfig
> +else
> +KBUILD_DEFCONFIG := loongson64_defconfig
> +endif
> +
>  KBUILD_DTBS      := dtbs
>  
>  image-name-y			:= vmlinux

(...)

