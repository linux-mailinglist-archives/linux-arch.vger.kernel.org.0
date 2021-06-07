Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9139D5E5
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhFGH0a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 03:26:30 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48285 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhFGH03 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 03:26:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6E9258079D;
        Mon,  7 Jun 2021 03:24:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Jun 2021 03:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=npy2EWSBZQkD+7QAo6OmKOU0JWy
        D1F5O8A85rULxr7U=; b=iOGGyA6K5vLhIVd9R7XZSsJ/52MYAKnKrX1ygQ2ozpX
        5ZifqVqhFux2c3lLOjSEa3rXLpRqYWQx3Nhkx1oQ1MxSjW7gIpWZzM0IdeQoUyV4
        73oPh/ABFbcyCa303FsFMnFDjfalau7YkevPHyga+0+F9ObnHAUTU4Kka56JO2d0
        AHR6paY3ZCBa4adVLAGe5FexL65/gL7swg4BPZlFaqy/ObqOP2pxcljkH6oI8qfM
        VJlJcP6bFkFBTdOpvQW5m6cGZAk43zX0nPnN3JdliEwcZ4AKsr3T7f/LjDOUqZie
        WicXZWJqgUBn63KCJVaWrbDf6IvkbFyeUoMGqnvrqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=npy2EW
        SBZQkD+7QAo6OmKOU0JWyD1F5O8A85rULxr7U=; b=OgSRVCswkQ5nLq8tXl8E7U
        O71YCnLyoyVQodFLxY2bQyVBuebED27X0dfe4vRpf462JyLIP9nP8HZlz247pNSL
        fUV3o7FqG5BvfiRMNceJgBpYLCIoPFkO7DMLDd7hmjBREUXPft3fwAggheUvFoCC
        Mf4RchFi9jzOZVtpCjQVlSk0mCvX2kR33HVBlNgmeA36LBifSis71sqzNomioJlY
        R9Hyn3uZZPrXNRCpe7YTy1giKGddq9x/YtJtLtqbNP7xtBJJDNyB1KVP2d47WC07
        FXkQZhHKWC+S9E0Lk6wTMXLVmCiZDLvs9XoJ2S+WLTbADkqOQ+IpObBpuXBpy7jw
        ==
X-ME-Sender: <xms:tMm9YA4kLfv-JLF2sBbl4fnug_K7P2UWkGsavopWtTV8GY3QZMRY9g>
    <xme:tMm9YB4KeynpGL2GqENTXtvXXR3cXsC8Rd5fNuleAOyyAp68yq446BLe7Vx2R6xwE
    cslc2f6TLv8t_5oGE8>
X-ME-Received: <xmr:tMm9YPeagoP_ZcUGdv6tZwDcu327e-dmuSRsjT_6fhCcf4uXUg4exwqc4pXrXe6zvLLT9ZMSNOcfIGe8yKusZEFAU05sNG9YCGia>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tMm9YFJRbaipaRJETHt57jUU0IfUD0rmi60Xm2v6OrTwvnFPn-LUNg>
    <xmx:tMm9YEIQdz26dGRAC0Ach-2KyKic8-WprH7osj5KznWMrYyJt6bcGg>
    <xmx:tMm9YGzUC97fXMd5tHrc0rMOMJHAqo2lxtOmMSjbo_PUKo0g75iJUQ>
    <xmx:tsm9YGg7r53owZ2q3Fdm15OO2D5SwfwNgSlGZYzVI_dnLS8aEeoeJg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 03:24:35 -0400 (EDT)
Date:   Mon, 7 Jun 2021 09:24:34 +0200
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
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
Message-ID: <20210607072434.3g3bqxdlpxjirg6k@gilmour>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsxrp47ju6oajdor"
Content-Disposition: inline
In-Reply-To: <1622970249-50770-13-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--fsxrp47ju6oajdor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patches

On Sun, Jun 06, 2021 at 09:04:07AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Add initial DTS for Allwinner D1 NeZha board having only essential
> devices (uart, dummy, clock, reset, clint, plic, etc).
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
>  arch/riscv/boot/dts/Makefile                       |  1 +
>  arch/riscv/boot/dts/allwinner/Makefile             |  2 +
>  .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  | 29 ++++++++
>  arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84 ++++++++++++++++=
++++++

Can you add the riscv folder to our MAINTAINERS entry as well?

>  4 files changed, 116 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.=
dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index fe996b8..3e7b264 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,5 +2,6 @@
>  subdir-y +=3D sifive
>  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) +=3D canaan
>  subdir-y +=3D microchip
> +subdir-y +=3D allwinner

I assume they should be ordered alphabetically?

>  obj-$(CONFIG_BUILTIN_DTB) :=3D $(addsuffix /, $(subdir-y))
> diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts=
/allwinner/Makefile
> new file mode 100644
> index 00000000..4adbf4b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_SUNXI) +=3D allwinner-d1-nezha-kit.dtb
> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b/a=
rch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> new file mode 100644
> index 00000000..cd9f7c9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "allwinner-d1.dtsi"
> +
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "Allwinner D1 NeZha Kit";
> +	compatible =3D "allwinner,d1-nezha-kit";
> +
> +	chosen {
> +		bootargs =3D "console=3DttyS0,115200";
> +		stdout-path =3D &serial0;
> +	};
> +
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x40000000 0x0 0x20000000>;
> +	};
> +
> +	soc {
> +	};
> +};
> +
> +&serial0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/riscv=
/boot/dts/allwinner/allwinner-d1.dtsi
> new file mode 100644
> index 00000000..11cd938
> --- /dev/null
> +++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "Allwinner D1 Soc";
> +	compatible =3D "allwinner,d1-nezha-kit";
> +
> +	chosen {
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <2400000>;
> +		cpu@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			status =3D "okay";
> +			compatible =3D "riscv";
> +			riscv,isa =3D "rv64imafdcv";
> +			mmu-type =3D "riscv,sv39";
> +			cpu0_intc: interrupt-controller {
> +				#interrupt-cells =3D <1>;
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		compatible =3D "simple-bus";
> +		ranges;
> +
> +		reset: reset-sample {
> +			compatible =3D "thead,reset-sample";
> +			plic-delegate =3D <0x0 0x101ffffc>;
> +		};

This compatible is not documented anywhere?

Maxime

--fsxrp47ju6oajdor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYL3JsgAKCRDj7w1vZxhR
xfeYAQCQjrUn1ueYXDlTtlHb4vbQ+cWzt+OSYY2p+uPeJZsJBQD+MAaXRiaGN/Xf
/u9es7GVOVAV6tXcL8oApZ4kgXfIvgY=
=RKXH
-----END PGP SIGNATURE-----

--fsxrp47ju6oajdor--
