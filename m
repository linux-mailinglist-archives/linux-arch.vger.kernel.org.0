Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C4839D5CF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGHVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 03:21:14 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48873 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGHVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 03:21:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1C2B4580859;
        Mon,  7 Jun 2021 03:19:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Jun 2021 03:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=1MtV7DMaXaVx7kK0l4uODe/8kJj
        9XmsvH5dcusPCkGw=; b=mBnRj6qByI8qYZCklroL0lAGepN28NsxpSJjrBcB5sQ
        Fd9Psov/izy8WWxboZMQrjOwwJviIZQ1ylCuBAHUSkt8Ao6IPLlLSKhvj6mcVRD8
        LJ6/qMfFntNQNPLP2a62nXZUY8NH253jQVw1M4YUkv4uKkDGM1F7bo90+bh6G1x5
        bj0aDQbh0YyqRWRUOV5GKZ4I4w9KGgTIxrOj526n2CQdqJwMlVEjkuNXa48Gyq+K
        zyqEXFJtCh1G5QY3/g35qFlIJ8uGWKdvPASB+N6V+QlwVgonLN3gJwLlKpWGq6pb
        CeKKGy+wRrKhZ3pmMs9Kyrb32nbI/45NJ/orDN6+Urg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1MtV7D
        MaXaVx7kK0l4uODe/8kJj9XmsvH5dcusPCkGw=; b=bmYOOfFKE/epxmVpWVbopE
        VYpCQV6oGT+5CyTeUxLZFc4z0mgApPY9MACKgKEovvnmMc+RXiHaZ/Ted/Ej6fic
        QRTnY2S4D9qWJG7LjaAvxBHEdK6X+A9vue/5+elM7kS9X0He6rmROFZkyr4Il3dH
        HlQHhutW7aZ1sUq5xYiGY/hF7Hk9mj/PlPznoN4e764vMfHOqPagcnRw8dGbe2fa
        FC9ghv6wu9aI8YHgTy8H2MTiZOfaSJG+FLESreO4U76f1II53+1KwmVOxt0/s2mJ
        eqgikwj++/p8qCwqXnWrrGE3X6/W+kSvAEn8+wC/c+C3mScl/e5WMPlvs4WRWShQ
        ==
X-ME-Sender: <xms:dsi9YD8PzeOsxSVus-A228PvbTqQz6CohsW2u_XtbriccrxjEmgbww>
    <xme:dsi9YPszDDIsnC2zox9UotklYx-GoY969n7JJ1qczXkkkr7vzED9qVKCAOCWl9xO6
    wEIhIqSRpb647dNzqM>
X-ME-Received: <xmr:dsi9YBD8qdIiGpihbYwvC6ezQsNyInmjOqpu8_IymTLXXyvPeXra5sSKLUZmbD0iptG0M7uLMPEvIvKELzgeLqeHndg8PA-f1Q3e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:dsi9YPceeu7PfbaDUqebc_9UD46Pb53aYkodLS4bjEIz3IZ0ndlDhQ>
    <xmx:dsi9YIPdyDsxA-_m-yN06QL-5SE1TSIPJjVxMtUK-x8m8MC7QMGU-w>
    <xmx:dsi9YBmfNDuQjipMIp48FePBz4_59Siz-Qiythf4bwfzZyjRZ9vUIA>
    <xmx:esi9YPmxGZwoaS4mPItl7MJfZb2hP6WhKibqLCIgA54Lc7M8mE3dMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 03:19:18 -0400 (EDT)
Date:   Mon, 7 Jun 2021 09:19:16 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        wens@csie.org, drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 10/11] riscv: soc: Add Allwinner SoC kconfig option
Message-ID: <20210607071916.kwdbtafbqp3icgia@gilmour>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-14-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jllkrmwwe7syrz3c"
Content-Disposition: inline
In-Reply-To: <1622970249-50770-14-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--jllkrmwwe7syrz3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 06, 2021 at 09:04:08AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Add Allwinner kconfig option which selects SoC specific and common
> drivers that is required for this SoC.
>=20
> Allwinner D1 uses custom PTE attributes to solve non-coherency SOC
> interconnect issues for dma synchronization, so we set the default
> value when SOC_SUNXI selected.
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> ---
>  arch/riscv/Kconfig.socs      | 12 ++++++++++++
>  arch/riscv/configs/defconfig |  1 +
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index ed96376..055fb3e 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -69,4 +69,16 @@ config SOC_CANAAN_K210_DTB_SOURCE
> =20
>  endif
> =20
> +config SOC_SUNXI
> +	bool "Allwinner SoCs"
> +	depends on MMU
> +	select DWMAC_GENERIC
> +	select SERIAL_8250
> +	select SERIAL_8250_CONSOLE
> +	select SERIAL_8250_DW
> +	select SIFIVE_PLIC
> +	select STMMAC_ETH
> +	help
> +	  This enables support for Allwinner SoC platforms like the D1.
> +

We probably don't want to select DWMAC, STMMAC_ETH and the 8250 options,
looks good otherwise.

Maxime

--jllkrmwwe7syrz3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYL3IbwAKCRDj7w1vZxhR
xdpIAP4ujY0W+0Oepl3WVbuQMtnV7QIHCkJ4/R3cBa41tsTA6gD/c1XIXK7VsiTZ
YdTeyYZcEkyrsfdNoFrv3BUCBXRhlwU=
=hNxN
-----END PGP SIGNATURE-----

--jllkrmwwe7syrz3c--
