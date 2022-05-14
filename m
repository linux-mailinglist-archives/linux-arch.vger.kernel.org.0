Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654052718F
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiENOGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiENOGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 10:06:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7AC2BFF;
        Sat, 14 May 2022 07:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97008B802BD;
        Sat, 14 May 2022 14:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA9C340EE;
        Sat, 14 May 2022 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537205;
        bh=M9LnE+5XvGie9JPlIYthAhjFKriiOzSI0H7xEm5v8Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7abPAGJhDsOM7a9V+d2iwArG2F5E6+nAgWV14diZzo+Fggw+sF6aovBcVEgxkRBV
         nJDmScndAVZ3UnxOQtR+xaJULJf+qG4etnHqeKdZQCRwksjEpoc6G4mGiVyJJPWMd+
         h8AvmaG/hyQRAQjya84me/HQ4HPXb1GNvhIT4lBgUvtkdWyrFJG2krcizzoBJM2s2K
         vpk8Hy4x4aj7/0vts8TsZKWF4WDbKdvqGE0F1fjpAbQccLQ3AteCLuD3oKG/gFVBGw
         aTJBFuQTGjy7G8ceGDFbi65yRaN3tkZweT+mBoqxyVNGqd2o2UbD+gXUpZKHAieJv/
         D5C1YaE+6JklQ==
Date:   Sat, 14 May 2022 16:06:41 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>
Subject: Re: [RFC v2 12/39] i2c: add HAS_IOPORT dependencies
Message-ID: <Yn+3cZ02UDP19XGu@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-22-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ae8AEsrKJseqCtm"
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-22-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--1Ae8AEsrKJseqCtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 03:50:19PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

What has changed since RFC v1?

> @@ -1232,6 +1233,7 @@ config I2C_CP2615
>  config I2C_PARPORT
>  	tristate "Parallel port adapter"
>  	depends on PARPORT
> +	depends on HAS_IOPORT
>  	select I2C_ALGOBIT
>  	select I2C_SMBUS
>  	help

Didn't you want to drop this one?


--1Ae8AEsrKJseqCtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJ/t3AACgkQFA3kzBSg
KbbldxAAijJWDKJn8oOjI9OPknBQkZs2iRuzoaBa6ZCu999lpIIAc+qAGmcGU67D
X/Qqcolemb14Pz2vDFjR9Sh1XH3UxwZ6/EA9tzwLf/LxMGC+PI9bzEi+3Li78GBx
XX0ZXenzcJoxBOihybOGxRnMgBfgflXOhfL/jpaD1Wdh6D51nS0Ygc7abGnEnZ2t
LbCeVUOeMSfAAolitmruD3uboSY65agsXrCtO0M3q/fU2CCZS5B+B9kGAYteB6BC
3ySbZqA9IPbPFgRjsAhVfcUkIHMrm5IBAG64FhacqFG+DcoHin8W0UbCBV2OByTE
khy6rI1VhJ3PmwmvN3X6Nbsi6OH3gur+MgqwnwyrgwZ5ILjxMaN2Uy7Vbr5B7MMh
YGVA0H7hX38DH4MaAsVCYr8JZ/sp42iydw1rhEVgNFqkGK+6dRtmkxkNGQh4P6Rb
mtr7Caxf+haa8YnKXcEMkHjDmkjpYAeJAhK1mUC6D/slsUlGM75FsJ/NdDZ1Ccob
Iq9ZUe0eZHCTDaegfrSdI1DmIYSbT6ZupJN40Wbt/Rv41HvjB8GGPyUI0y0zGpSx
tGbDB0wsm6ZvEtzOhAg6tiSJW/rjh4I3zuuutPYKYGJgva/JxITYWXRRg5qnqfW4
Ja3oXwiYCpDPT2ZsIqdegh5FTayAdecztDIp8YeYp0eVqRDabO4=
=ojBv
-----END PGP SIGNATURE-----

--1Ae8AEsrKJseqCtm--
