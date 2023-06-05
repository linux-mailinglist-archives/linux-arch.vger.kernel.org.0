Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB25722312
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFEKMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFEKMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 06:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD11E9;
        Mon,  5 Jun 2023 03:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACC362209;
        Mon,  5 Jun 2023 10:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CC4C433EF;
        Mon,  5 Jun 2023 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685959959;
        bh=WHTZMibVd/jYavGziw9IAH3KvXsQuHo9quoMZmILjDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLcB4IgKZhO/0RLyFEf2w5Co9PbQLm5WJ8YixHzpu53FXyixWgNd16x/ZxNvM+EWH
         kYdYDUKi+FMUdBzZEEvD0dLOxXg2GyqPgnZ5fZ13gWVqD1pKLwQYPZIzZAZ8WjGUKb
         7y4e4MAeET0VDM9x3HcLhtAdGMZKS9A9/2i6TtpkMY7SZGChSFW9FriJUh7jqeAV3H
         YS0bFpzYVrA5ahzI62pQ4M43nF8gq5MGvfH1eb7TzWDEgv4uRmaT8zhmtp5UYVUsny
         aAcnP1Je/QOruZoUUr4T4z/JjTjNl/b8+08rSikGQEPxV/BfwSi848SQQc2EmuJ7gP
         5YVk406HgHUuQ==
Date:   Mon, 5 Jun 2023 12:12:35 +0200
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
Subject: Re: [PATCH v4 11/41] i2c: add HAS_IOPORT dependencies
Message-ID: <ZH21E3Obp+YPJHkl@shikoro>
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
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-12-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4tL/EgbFZOh0MjKH"
Content-Disposition: inline
In-Reply-To: <20230516110038.2413224-12-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--4tL/EgbFZOh0MjKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 01:00:07PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

What has changed since V3? I didn't get the coverletter...


--4tL/EgbFZOh0MjKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmR9tRMACgkQFA3kzBSg
Kbbc+xAAqP7HS91nIrnCAA96c5zQ1oe7pFt0DHJGUlaejNCUnxEydd6fFseJiAna
fmWKk7DsPTsB2bccl7khlpaiin8oLe8nQxY818fTPsS2mF9jlUSjf1BfZgu4fnVh
bX76Q4KPhHyNZHOTg+9kr/dfCaQVWp1SWum9+fGFT4BmjuvLNaq+gMBI4oDCybMw
7XvSKqjbxHkhTjNQKH1kcO++a3NHAwIO4raOY/TomHQewXBIwi6W0on+jYi5hHVo
UjOSwBxpC/cepK5ubzp6latXWnr5cdY1an+OAGM4YkvEBvmiPgTOwlbzoVy3Ox7F
WTqTuHfg99W1yHfosiowi1iHtWWK56TtzppJPQ3UaR7wF1PmX1ggCtGGOfJ2wfbh
TS6F4lqnwSxXfAsav5J756eGVkq48+zuPh3kMtuZ2lRtIbI71nZQdCzsmDfqmzAs
1T/rtRHWlKV2gMNehHp3BwIN2hI0BlCk0jZaCgMx/zERCdy6VaV8PWk4ZLKLZI/j
kcBqfRMcKzd+OGw1s7wY3zPqNCNfaeH4VTM4aN0AlQAsbx5Qg2CuPeuirgTSPgRD
2dZKzjuO1cQcPAGYoiAQ/MKrCuvU3MoSgX3/yVgXQePBWaTOOIiJdmKMluQpM7T1
A7LvVZiCQiOOYRUSC5WrS9v6LnB+Hkn41t3i+UdW5y64d4CtMYI=
=3QWP
-----END PGP SIGNATURE-----

--4tL/EgbFZOh0MjKH--
