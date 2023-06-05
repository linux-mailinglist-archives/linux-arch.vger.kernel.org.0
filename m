Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C172251E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFEMCU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjFEMCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 08:02:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A7A7
        for <linux-arch@vger.kernel.org>; Mon,  5 Jun 2023 05:02:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68uP-0000Yl-Je; Mon, 05 Jun 2023 14:02:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68uN-005GF8-Fp; Mon, 05 Jun 2023 14:01:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q68uM-00BNcb-R6; Mon, 05 Jun 2023 14:01:58 +0200
Date:   Mon, 5 Jun 2023 14:01:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v4 11/41] i2c: add HAS_IOPORT dependencies
Message-ID: <20230605120151.qpoe5ordzdvxmqv7@pengutronix.de>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-12-schnelle@linux.ibm.com>
 <ZH21E3Obp+YPJHkl@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrjpp6upncpe45z2"
Content-Disposition: inline
In-Reply-To: <ZH21E3Obp+YPJHkl@shikoro>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arch@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--rrjpp6upncpe45z2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfram,

On Mon, Jun 05, 2023 at 12:12:35PM +0200, Wolfram Sang wrote:
> On Tue, May 16, 2023 at 01:00:07PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> What has changed since V3? I didn't get the coverletter...

lore has it:
https://lore.kernel.org/all/20230516110038.2413224-1-schnelle@linux.ibm.com/

(Found via: https://lore.kernel.org/all/ZH21E3Obp+YPJHkl@shikoro where
the last part of the URL is the Message-Id of your mail.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rrjpp6upncpe45z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR9zqkACgkQj4D7WH0S
/k6J+wf8DmGrLkbb+yVGL7PepId5isI8DouAOsHiBL2947XH+XFzSbVniR3Ydjfa
V+XHlHuatOVGSKP23q6pXNFWDhwxVbCZkMWlumoPKslLqIjU+Qgt+SCznZQDiDnZ
QqOgKD2M1CLufMBb0W/dNcm/pVxDO0T8FeyiJZO9mttJQ8yQ4nzCHCDDKXH5NDXl
Y2PMdDlLeba0kwleogS5j5JR/jxMLmnoDqCBWjb2v8ZJQMrIg3/6YmZRJ1/hXoHO
QAdzEIxNOl/2Tj9Cc84+9oyk7J19OsvBhXNpR8g+kB7bS39dCIrE9di96BTDzfaW
uxKsqfUGQ7aqF/xjpAM+0Bb6NkvhKQ==
=pscJ
-----END PGP SIGNATURE-----

--rrjpp6upncpe45z2--
