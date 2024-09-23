Return-Path: <linux-arch+bounces-7377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDB97F03A
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494D0B21858
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4219F416;
	Mon, 23 Sep 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4/ZLxs9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AA8C1A;
	Mon, 23 Sep 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115230; cv=none; b=V6NZzzDzaI0kqBBdSnq6pPGfTnnt4hNoUUEy5f/fCjthnvuPVHSoacw3P35sLATCHBQ0z4aGcjWLVbb52I7QsM3jvBlYofby66Q59kPGjLLOvhR6IabB1+UUZjI8yIEsj5g5EmJK+RbaxqWyd0lYmQM0HR9YKnm8MtyeHkEidkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115230; c=relaxed/simple;
	bh=1WyhULVRVV/rtdeWwTQ2M9+nk7WPwcxLgUiEtp966xs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CyT7WovSano8luJSnKcMFl/ShOd7t2IRz0+H4xK2jI0SK4cnvwIIDj5r+lXitUty+QCoMc+dEWri4qJy8wDpNGpWtJpghI7EIUszQzlr3eeItMzSrKhzUUGNLxTWVXfH1Dh+RzNAdfUuEdo83exrKoF+iNpMS166TaI+gsqbYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4/ZLxs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028FBC4CEC4;
	Mon, 23 Sep 2024 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727115230;
	bh=1WyhULVRVV/rtdeWwTQ2M9+nk7WPwcxLgUiEtp966xs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G4/ZLxs9Q4D9kEnETKRLoXRmkGqSdWz+iEY0I8D29Y4fabg07BpYqGOhriher+Mng
	 U+fIDfjEsaZayJijn1WSK8tqgfLBt4AmkijpC7CBOoOxRd3b0KeDpSTafSii3pPPDZ
	 QuUDEXmpBiY7A+Admls8DVdsTim1Xhf0318L5l2f1bv+lPtBzrseo385Y5DguGwap/
	 dGUePuLxl8uU02UjtfmXxS51GXMAPXuNEHtATnFMc2CWvn+YFDhD3xr2VpopC8VV9B
	 csiSC1riXKdxRUJ2pAdITGNdUMp4KPSi4qBhVNOPw53swFV9itIbBINfHLcUgQ0XHE
	 ouCDS8uDHFRhA==
Message-ID: <146d3866ec57e963713cd07b9eaf5a71.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK7LNAQEx52BYMYfNu+xj8sNmdtH9XfPapdhJDrsbDo43aD3Dg@mail.gmail.com>
References: <cover.1724159867.git.andrea.porta@suse.com> <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com> <2113b8df52164733a0ee3860bb793d6e.sboyd@kernel.org> <ZtcBHvI9JxgH9iFT@apocalypse> <d87530b846d0dc9e78789234cfcb602a.sboyd@kernel.org> <CAK7LNAQEx52BYMYfNu+xj8sNmdtH9XfPapdhJDrsbDo43aD3Dg@mail.gmail.com>
Subject: Re: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being discarded after init
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley <conor+dt@kernel.org>, David S. Miller <davem@davemloft.net>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.o
 rg>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 23 Sep 2024 11:13:47 -0700
User-Agent: alot/0.10

Quoting Masahiro Yamada (2024-09-22 01:14:12)
>=20
> Rather, I'd modify my patch as follows:
>=20
> --- a/scripts/Makefile.dtbs
> +++ b/scripts/Makefile.dtbs
> @@ -34,12 +34,14 @@ $(obj)/dtbs-list: $(dtb-y) FORCE
>  # Assembly file to wrap dtb(o)
>  # ----------------------------------------------------------------------=
-----
>=20
> +builtin-dtb-section =3D $(if $(filter arch/%, $(obj)),.dtb.init.rodata,.=
rodata)

I think we want to free the empty root dtb that's always builtin. That
is in drivers/of/ right? And I worry that an overlay could be in arch/
and then this breaks again. That's why it feels more correct to treat
dtbo.o vs. dtb.o differently. Perhaps we can check $(obj) for dtbo vs
dtb?

Also, modpost code looks for .init* named sections and treats them as
initdata already. Can we rename .dtb.init.rodata to .init.dtb.rodata so
that modpost can find that?

