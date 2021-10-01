Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23D241EBC2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 13:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353711AbhJALZr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 07:25:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51174 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353760AbhJALZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 07:25:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4B4681C0B80; Fri,  1 Oct 2021 13:23:54 +0200 (CEST)
Date:   Fri, 1 Oct 2021 13:23:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 1/3] riscv: optimized memcpy
Message-ID: <20211001112354.GA10720@duo.ucw.cz>
References: <20210929172234.31620-1-mcroce@linux.microsoft.com>
 <20210929172234.31620-2-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20210929172234.31620-2-mcroce@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Matteo Croce <mcroce@microsoft.com>
>=20
> Write a C version of memcpy() which uses the biggest data size allowed,
> without generating unaligned accesses.
>=20
> The procedure is made of three steps:
> First copy data one byte at time until the destination buffer is aligned
> to a long boundary.
> Then copy the data one long at time shifting the current and the next u8
> to compose a long at every cycle.
> Finally, copy the remainder one byte at time.
>=20
> On a BeagleV, the TCP RX throughput increased by 45%:
>=20
> before:
>=20
> $ iperf3 -c beaglev
> Connecting to host beaglev, port 5201
> [  5] local 192.168.85.6 port 44840 connected to 192.168.85.48 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  76.4 MBytes   641 Mbits/sec   27    624 KBytes
> [  5]   1.00-2.00   sec  72.5 MBytes   608 Mbits/sec    0    708 KBytes
>=20
> after:
>=20
> $ iperf3 -c beaglev
> Connecting to host beaglev, port 5201
> [  5] local 192.168.85.6 port 44864 connected to 192.168.85.48 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   109 MBytes   912 Mbits/sec   48    559 KBytes
> [  5]   1.00-2.00   sec   108 MBytes   902 Mbits/sec    0    690
> KBytes

That's really quite cool. Could you see if it is your "optimized
unaligned" copy doing the difference?>

+/* convenience union to avoid cast between different pointer types */
> +union types {
> +	u8 *as_u8;
> +	unsigned long *as_ulong;
> +	uintptr_t as_uptr;
> +};
> +
> +union const_types {
> +	const u8 *as_u8;
> +	unsigned long *as_ulong;
> +	uintptr_t as_uptr;
> +};

Missing consts here?

Plus... this is really "interesting" coding style. I'd just use casts
in kernel.

Regards,						Pavel

--=20
http://www.livejournal.com/~pavelmachek

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVbvygAKCRAw5/Bqldv6
8vL4AKCm6Y1l3PaTBC4mmrpz0UrY1DvWGQCfYF5/9wrjjsk9fb68mC20qc3UVpc=
=NRFP
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
