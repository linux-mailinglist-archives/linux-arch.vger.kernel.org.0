Return-Path: <linux-arch+bounces-6865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E97CA966A09
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAC1F22703
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5E1BC9E9;
	Fri, 30 Aug 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ42NSii"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38033CD1;
	Fri, 30 Aug 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047198; cv=none; b=HEjfHsM0xye/sLFbgXWZai7MovwEyoQw3itV2bcEWS+CFO2yFapzjLIbIwhpwZ0padiGlK22qV9lP/E7CxMZvay5JmgROYt0PEvdPvjpcmXeC24xVnsqTZN9HWIuyVEtUE6/ML/4ZY55bC+UY7PUTjoBM6VdB/7FuK7Syn3vTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047198; c=relaxed/simple;
	bh=srlQl2hfntMUZ3gDAS9tafJno7Ca9Nn0VC725vi9Hcs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=qLkSRbtNjE1+MOBZrrgCqPm7HYHmIlol4GU3heCkB2+0czajGoR/238aWbl62JpnGNC3itFer0XpYvvkhxnTMk337L2LwxSet8qr2BdZNJ2oKyfz27CgqipoghNBz+KLXh7G876xELF60EXIZNV/X0eNeiOvO1rY/dCHbU9xb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ42NSii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C5C4CEC2;
	Fri, 30 Aug 2024 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725047197;
	bh=srlQl2hfntMUZ3gDAS9tafJno7Ca9Nn0VC725vi9Hcs=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=oQ42NSiippJMnwZECJlJ14DPMsnKjzT551O0eUYTg3N52LLWe8b46CIz7qz1/b3Rc
	 dwkv+HxKU06gfCzrh8lVQlutAtkOGnE0Cr7NRWnmChvg7mTMCBZDbcKWIW6JOV+55/
	 aUMR6NI3F2JSsq3BaUEfqbinZukYIMj7ZGnUEkNvWahTsU4IBZIJSoakX6xwITwUew
	 ivchz6A3fihB5j6p+MU6PHG+G60KhgyXaxHy9fYvtes/FN+91WGuK6oKkeuaRjkl9m
	 1Hi5S44oHi/nYegKIS2j9wzKhfMFKjVN66771sWYaVLYz/yVjaeOnnqrbd2Z9U3q0n
	 4zatQMsP9dgXA==
Message-ID: <2113b8df52164733a0ee3860bb793d6e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com> <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com>
Subject: Re: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being discarded after init
From: Stephen Boyd <sboyd@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.o
 rg>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, netdev@vger.kernel.org
Date: Fri, 30 Aug 2024 12:46:35 -0700
User-Agent: alot/0.10

Quoting Andrea della Porta (2024-08-20 07:36:07)
> The special section .dtb.init.rodata contains dtb and dtbo compiled
> as objects inside the kernel and ends up in .init.data sectiion that
> will be discarded early after the init phase. This is a problem for
> builtin drivers that apply dtb overlay at runtime since this happens
> later (e.g. during bus enumeration) and also for modules that should
> be able to do it dynamically during runtime.
> Move the dtb section to .data.
>=20
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index ad6afc5c4918..3ae9097774b0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -365,6 +365,7 @@
>         TRACE_PRINTKS()                                                 \
>         BPF_RAW_TP()                                                    \
>         TRACEPOINT_STR()                                                \
> +       KERNEL_DTB()                                                    \

The KERNEL_DTB() macro shows the section name is dtb.init.rodata. Can
you remove the ".init." part if this isn't initdata anymore? And
shouldn't it be in the RO_DATA() macro?

It would be nice to keep the initdata properties when this isn't used
after init as well. Perhaps we need another macro and/or filename to
indicate that the DTB{O} can be thrown away after init/module init.

