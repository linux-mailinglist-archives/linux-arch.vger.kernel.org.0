Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C087ACBF2
	for <lists+linux-arch@lfdr.de>; Sun, 24 Sep 2023 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjIXVB5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Sep 2023 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXVB5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Sep 2023 17:01:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AECEE;
        Sun, 24 Sep 2023 14:01:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8142FC433C9;
        Sun, 24 Sep 2023 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695589311;
        bh=lQolm0foEYW5CldsqbvEkR0zZhJQsoqewB6efPhH+Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaapwYwo0MrmFnL0auGF+wvd1R6ra1WgSpS2KbhlkM3Ms778ZZXVCIocnswBzcxT6
         x6ic4IGzOA/y0750zxjMEwodnuA0xhUrjlTnDk4jjLPxmnz9u59fwrbd6IBl2PhlSM
         2kIj3v5uXQ9C81bxZhsSTnQ6FJ5njK561yqo5y5n5NvzzZHlwFROpRcPaaofMTOquU
         hqpZq2XPZe+PjE+cNnrXToccR/ZqBPJy2cF8wpDA/ZKA1rw56Ipx6BroWqdbJMPHiG
         taZpVwhQCchzkPlSWgxoLh9w8Ua+eEiBWUdJWzH7VGKSoOT4G7cH3w0elYmrmvvSXA
         OHpMuFxoSBttQ==
Date:   Sun, 24 Sep 2023 23:01:47 +0200
From:   Wolfram Sang <wsa@kernel.org>
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
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 13/44] i2c: add HAS_IOPORT dependencies
Message-ID: <ZRCju+Ctuu2Mf+1c@shikoro>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4lqQXSmnp+QVr70y"
Content-Disposition: inline
In-Reply-To: <20230522105049.1467313-14-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--4lqQXSmnp+QVr70y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 12:50:18PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

In RFC v1, you agreed to drop PARPORT [1]. Is there a reason you haven't
done this so far?

[1] https://patchwork.ozlabs.org/project/linux-i2c/patch/20211227164317.414=
6918-11-schnelle@linux.ibm.com/


--4lqQXSmnp+QVr70y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUQo7sACgkQFA3kzBSg
KbY6EA//dT9BVWIMC87KqS1yrlF+XkCv3Z30NXI03qrtB4wjFMu7dyQd8ZgIuDyQ
Ijnr3yMCsn30J6MW0jhgJkXAec3KghZLaWW/Ck1oIna6IV5z323AaGOgUYcMJc6f
a8SDSBrZRjPY/bJeTE/iR+CaC4tDLxGhk0NaSeClPQK5cAIZ248JCr6FlyW7NaT3
WOpLVfjw8SJjnr6FqPoF2pZrPKO5DrCEnS9EicwuCAzJu7u4dGFdma6y+/47BVq5
Pp28tvibeaFMlIrf0eZsdRkRjWLK0pwRXzwVukyBJdfr4pWa0GPQKRq2XHtX1MXL
ri5aZ2P4/9Llg7TqyjegCiAPz2bbVUGkJA6E5M98baT6BrqiFtvNKm260B1alqaU
AzECG0lX74SHnG9kfaU9IDRZjZ7y7G7zdeFP3gQ68SKr42UN41ESiJJnYXaPUQ8v
HU2IwtHuS/0ipQQzUp90arffMxw32mG9i3h+ooWR6xoIkfjCRU5VsXCzhHmoLPIF
Lxt9gCytVe2RsjhwnuAebHtvqZUHz67PdIlznuXchiJsRZGmdnEJOzLZDI95Wtgb
FrbM61aVSv560yBvKpp9TRNCXjGINK1tGhiAYQPrxn5WtbzWhriNhaGTDzoY+iXp
ci6YysL8Q2nQfRoh8ypZi02BTGexNrg8d+LnnM7qJrLR16Mxfn4=
=mJCC
-----END PGP SIGNATURE-----

--4lqQXSmnp+QVr70y--
