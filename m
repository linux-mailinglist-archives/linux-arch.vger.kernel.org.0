Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E56CF6A9
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 01:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjC2XBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 19:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2XBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 19:01:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38546AF;
        Wed, 29 Mar 2023 16:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFC87B8243B;
        Wed, 29 Mar 2023 23:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECFC433D2;
        Wed, 29 Mar 2023 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680130909;
        bh=aUhmYOlJNPE9UBSfWYsXAC0QUzpgCRA5cLcAhflMRgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQXMZGKhK3bZUJlUkAI6inUFGy20RLqEOiljUVVekUf6NXW/AdLaRByGMS+3DNJTF
         tsbwQNiLyqgm3eBNSAJ/XRqeLQNNMNMrjOeegrYcczNGFEhXl42vHKhBVDnywRbK0c
         HVl3zTHL9q3cS7Ut3ZfN/v3eH9aCNdYVcc1UsHk0QBlHlEh/oDRvjtIgRyimZHfDH5
         SFTrDiIq1HmyqH1IkTOjnmIZDa616Jhc1uVy1/fC28A2Wj/06cYQzIDhOJhtYxXPpV
         y17Z91txj/M2jdt8Ibwhp6Wyztz3JUBtvRWLk/QEdw1kxe61WJL7d9PRoE6iePY5sS
         NrDinURmVCwsQ==
Received: by mercury (Postfix, from userid 1000)
        id 2E2061062665; Thu, 30 Mar 2023 01:01:46 +0200 (CEST)
Date:   Thu, 30 Mar 2023 01:01:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
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
Subject: Re: [PATCH v3 27/38] power: add HAS_IOPORT dependencies
Message-ID: <20230329230146.pvkfnsoqr6tuuuxf@mercury.elektranox.org>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-28-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qigw7wbrpbhgomf7"
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-28-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--qigw7wbrpbhgomf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 14, 2023 at 01:12:05PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

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
> 2.37.2
>=20

--qigw7wbrpbhgomf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQkw1kACgkQ2O7X88g7
+pryjg/9EBDNrxN5toE3uocrn9nnnJfVvqmn4QAIN3XdHQwzlP/07e9nGZd2Vcht
KDFycurrvH6p/N/UhvI3PByHJbGjwHGr0Q/dj7nz8UsQMdEsmwlKpF9ocHG1E1tx
N0/ezM+YyX+E7lYpe5jgywKS9DMArCbvKa3nTNayJsde4Xb8gklIh6PDDvQZYC/g
LYm/qj/B3cRjYHjaVsx1tXd7U0MEwY6F1yET45dyxnaXVyUkUBLh4bcKCh1Ol8oO
MCWyDnwu+mLU7E++Gz5/V2d9KZmiCu2E4ra+LZX5m4y9n8TpLkK0pej9CcqkbHud
nUbdttl8ceEANfZjbvyCUGyQWcwgYZwlIpluwwj6dIyJx5GkdA89QHS1ArFDYE7y
bJZfheHnAyv6hscuMCSfjaJoiSBBZVVIUiMkFuwSEmWLEzjzl28s/MpFacGaN9ls
Ujzah53zrAB38Wnq0+ZmlVEPPZYDKh1vob3qAL5F5TuSzR6yFum9Pl/Q4jqeZJkx
NeXPUAHhA/SkwCjdJfe2YrR40Tf/QwjJKmwQVnFaiBzu94sMQtfddkfRtkrcdapO
bJ3hdNuSkaIHJcHdrrLLTVwua0EgnrY5ov5th2RWHSx8IfZnDmcSYBsV0o3Xd15q
1LovrtDYKTzJKo8UU3/j3DdarmC+HylKhKga+gd9XqauYQuh7dY=
=e4RC
-----END PGP SIGNATURE-----

--qigw7wbrpbhgomf7--
