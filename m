Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8024B39F507
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFHLf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 07:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhFHLfZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 07:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77BAA6128A;
        Tue,  8 Jun 2021 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623152013;
        bh=QzbcLiB/1N7DzVrdDjK7OIq1u6I9+VzWWocOiQGnpk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gl9vC8a4foBMWq2vzc5Me8TxdKRjcfkiQzlTmLPHsJp459vNNrFZ5usv/qQn2R2/T
         RSypUzzCWPm0uMUsGAmGOXTdNCCxfELZKQo9z0Rx7Pwj/DZxtw5mC7S2spC20SxQHx
         Z0K8JY4xACpLYsHQ+gX4XsJB1/VnC5M7Z8iEFsZH+GoBTVAamFxEU3cu/XYK9hlZTD
         Q+CJXINa0mVtvY1hYZa5jqTKkiL3XxG5rvWOkRPFoDLjYSHdojyVOMaxaly57ysSN4
         LGstvsRTsIs06sJrxyWIOGl2XFItMOTd8NjqeD5/EtLFDAyaEJVUTBnvUaH0LWygiK
         0E+gTdavN+6vg==
Date:   Tue, 8 Jun 2021 12:33:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210608113318.GA4200@sirena.org.uk>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
 <20210603165134.GF4257@sirena.org.uk>
 <20210603180429.GI20338@arm.com>
 <20210607112536.GI4187@arm.com>
 <20210607181212.GD17957@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20210607181212.GD17957@arm.com>
X-Cookie: Auction:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 07, 2021 at 07:12:13PM +0100, Catalin Marinas wrote:

> I don't think we can document all the filters that can be added on top
> various syscalls, so I'd leave it undocumented (or part of the systemd
> documentation). It was a user space program (systemd) breaking another
> user space program (well, anything with a new enough glibc). The kernel
> ABI was still valid when /sbin/init started ;).

Indeed.  I think from a kernel point of view the main thing is to look
at why userspace feels the need to do things like this and see if
there's anything we can improve or do better with in future APIs, part
of the original discussion here was figuring out that there's not really
any other reasonable options for userspace to implement this check at
the minute.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC/VX0ACgkQJNaLcl1U
h9DQdwf/TJzRu5jKdbqqqnTM5IaKtyqziQkJFXblDjDZkzBny7xN1VI86c6IS5XZ
YJnZD8prye0EfXsoTHSdNIETekQK1x+O4DrjEp4e8qyLjhAbfimRgga2/diZ8zUt
DlsaHmN+vdbPaH/AoGj/Ni810TgpbtKgeqpbZt3MYDUf2EvlhjUBrBhNNAe1S3Gu
rOGCkI7R3RoaBIcyATK0H/78jrIFRNu0qEKKqWK2QwLGbfuC5ADmuRGikY+VeL2J
MvGIJoQUDw+BBL9mE1SKkZn5mz/z32EweV5rOZ8BvIYOjXgdZY4I3qA1qt9m8MiN
tJ22aBfXneqJgDNPxML7pJUW2iT2Gg==
=6iZf
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
