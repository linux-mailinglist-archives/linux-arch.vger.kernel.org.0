Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0097D3AE8
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjJWPgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 11:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJWPgZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 11:36:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B28ADB;
        Mon, 23 Oct 2023 08:36:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440D7C433C8;
        Mon, 23 Oct 2023 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075382;
        bh=GjXvcSO/i6FF/OlNaJfRF+sQGbecxltiNDipUhA7AB4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=sgfRDy2e5QPF/UqBmV4/zbV2K5RPcCyGcHK4oaRv5OtJ1hyrcX/STTBuIIrs4wLPG
         2pFD7871CcQJXtWvBh/hyGF0Ut9Fys9tqaiO1X9MYnC5IDDW/ynbGIqc/7mOxm68ns
         McCpTf+5t0S1464Mj14zcecHl7VAn5No+ABYNI5nRiui94ClbGAe+UQ2bjnzXBFzgX
         1QI0D8VMV6FExZjhbe1Qhp87xnX90bN2v2Q5ROuhaTMTWNswVARfPwm40QcjXOkHwd
         mNxyJQlO4jtENF79RzQAJFgJzy2852R5ARDwBCAv4AL66ax+/9PqFfwSdYDmU1Ftc1
         thPMt39SBYdGA==
Date:   Mon, 23 Oct 2023 17:36:19 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 13/44] i2c: add HAS_IOPORT dependencies
Message-ID: <ZTaS8/Z4p8bLoHF1@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-i2c@vger.kernel.org
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-14-schnelle@linux.ibm.com>
 <ZRCju+Ctuu2Mf+1c@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IKJd4WrwHJvKoZ2A"
Content-Disposition: inline
In-Reply-To: <ZRCju+Ctuu2Mf+1c@shikoro>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--IKJd4WrwHJvKoZ2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 11:01:47PM +0200, Wolfram Sang wrote:
> On Mon, May 22, 2023 at 12:50:18PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> In RFC v1, you agreed to drop PARPORT [1]. Is there a reason you haven't
> done this so far?
>=20
> [1] https://patchwork.ozlabs.org/project/linux-i2c/patch/20211227164317.4=
146918-11-schnelle@linux.ibm.com/

Shall I apply this with or without PARPORT?


--IKJd4WrwHJvKoZ2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU2kvMACgkQFA3kzBSg
Kbatiw//U8VXBAC3aPMTbD6m0NSoMa1PF0OiVlizyXToMW0qVjXRKbhDGpWMV9rq
ML2nNXfCNCwnsI/NdYX5KD8NtBaKIu7ecIGZ1xaF8eqWaSPbVxCuK/zKwrBgFcjb
eakTvDuWnNWVzgXDd1J2/oaIfTvYUfXI4rbm7SBlPFysGNjzgixUf3XtJ+9Ou97z
ydKK886E0sKpzpwKl2c3CIqUMZYTDAFu+EVWimk8/u6fSRp+0peEBRDv6hgTbO4Y
5KHwdh6WddCZ8KODGx9f0ZW1vxO530SRGoqiK6p/8b4YIMQ7gfhD4rb2r/seSpGJ
0BhLY//IE2+Pj2QLXrELinaJGFyk5PXLsdlDCkstcLjyvB2l2xkvgJZTbDfM+gM5
OiXThEmz4RUxaL3npTBrC6U7z8hWqS+XfkKQ8OYXXY8IPiuwXwuJIUPDUCFqhKec
srmuu0bd4F9JYPOzJCERwbDVYI7mFq9lReuAJSE+GfSLeV16kpL3woGRZLKdzbav
lhGSOliYGqEINY2xATuYc85IGrAkN7PeRcK5643A8obdnH8mNKlzezm92dzCdqfb
WB2Rx2khFBqZiA1+fx9PLhS9EMF7yneQ83pqDUgvzeRm6zKiWzDViX1vy/tDj0vv
ob4loEiEXp70Wb8uif1uYYLdmc3IBdWBLNfYeBJEFAf97PyaopQ=
=U36p
-----END PGP SIGNATURE-----

--IKJd4WrwHJvKoZ2A--
