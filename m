Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B1470583D
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjEPUDl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEPUDk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 16:03:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6D619B;
        Tue, 16 May 2023 13:03:34 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7511C6605902;
        Tue, 16 May 2023 21:03:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684267412;
        bh=neBnBIFI0CIVAk8FH71HI3up4NB8vfsI9KknH645BgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oG++9agVNx+YfmqZ/xi5WTDJ6ENKtWAUyL1dKl4dT+/eF5WRm94oh4tNc8WdcjB5x
         jIVuyFhwKKj9JGBMUXT+QhG8rGAzo81f2oCPcr7Wcf69X7TxhKoH0RgLKJA0ZPXevm
         ZFA/OE7j6ErLBYk7mj83e76PWftkj5R1PDDHPwfHzrXCtNuvwAhsBIeI/s9O8YbNdT
         WabTM8JZt3L+ZYDoIXmGaZc/XfOCZfvbI+QIbQsywJQeeUylcWoqx8t8Rq4wQ0TfQR
         M7hMOhCZ/WkujL6APddqvUT4bBVoVdmeq00+FKazdS567hyr0qsE3cupOcX8QIQ4KD
         2/p6vS5DD/9LQ==
Received: by mercury (Postfix, from userid 1000)
        id 8121C10623DF; Tue, 16 May 2023 22:03:29 +0200 (CEST)
Date:   Tue, 16 May 2023 22:03:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 27/41] power: add HAS_IOPORT dependencies
Message-ID: <20230516200329.oxxgvnm5ivj46mph@mercury.elektranox.org>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-28-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jp3qgbjcymzuog6w"
Content-Disposition: inline
In-Reply-To: <20230516110038.2413224-28-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--jp3qgbjcymzuog6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 16, 2023 at 01:00:23PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8c87eeda0fec..fff07b2bd77b 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -158,6 +158,7 @@ config POWER_RESET_OXNAS
>  config POWER_RESET_PIIX4_POWEROFF
>  	tristate "Intel PIIX4 power-off driver"
>  	depends on PCI
> +	depends on HAS_IOPORT
>  	depends on MIPS || COMPILE_TEST
>  	help
>  	  This driver supports powering off a system using the Intel PIIX4
> --=20
> 2.39.2
>=20

--jp3qgbjcymzuog6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRj4Y0ACgkQ2O7X88g7
+prvBQ//S5/2ZNXe0IRtGqYh6TrppJf6jIzcQKzwlDdsYrpaxPmNCo0K7y2IiVip
uLF/HNmX2TzwGzwhiCn0qyEqfCpflQIzoVmRYI+QINGKDKki/x3diinsRQyovHat
CtgvLc+n48bvV2a/4uiIaQKRFl5ALOWgf4d3xLy9xzSxHnJ2o/IHE9j+ggFqfaS0
mfq0h0/iEldRbcYxn5Nc5M7JwkXurWI5eeLM7sFfzMl6Lt8WJtTIiEjmOsoDksR1
rkqmYFZaj9N4w+0tfSXj58oPc4o0y2tBLP/6xYFKfHsix0s4yS69nGlPkJgvCdun
diZdzVGavGLjmyndKIYTJOtP3xnl8/N9JdAMDprfJ+0Tp/Vrp+wUZWA/RPQyUMGV
jddpFKhV3fs1FfVypVBQPJyi/NOl06hCmBrE6YwEgCWd9kA391qA9Zm38hDMHSqR
b52OhqF9+yV2KHFx3KikzxDFZOHbqMuJV4VPHepmABk+TTys1FPsqsnSJOmenSmv
dytYPdxhUOZBGv7zbjoA6/5zM70oNJqhqznYyUrAH+XC39Q5ss8VHeQ38BTEqI9M
VBSSezMw2Avjp2I6SXvbb5t61Se4/V+sEVcsYlcJ3SsPbsx7b6jCxIe7CXRal+OU
eemXHq+QLUY+a/y9XuVN9fn5nf1kKgou97yBWlxBp+GOj47L2So=
=TeOZ
-----END PGP SIGNATURE-----

--jp3qgbjcymzuog6w--
