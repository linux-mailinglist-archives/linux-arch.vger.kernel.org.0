Return-Path: <linux-arch+bounces-6854-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62F9664F4
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A9B212A0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BCE1B29CD;
	Fri, 30 Aug 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV13FeQY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C161FCE;
	Fri, 30 Aug 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030331; cv=none; b=p/X7I3frMQJRNH3vmhv8iigl7hkTVXwfKY7i5JoPItpqPbpYnFv5Aawcwnrhs4QXNqpAKAAHocBeCZM2Ctv1CETHvR0+GBSnLtzMRuy4xIFuYGn7i9HVJBWB7PqOHobgQK83mw6xkf5LgiBmVFfChMgdeqAUsMEw+tMAmjukRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030331; c=relaxed/simple;
	bh=uG3bEWNdwBYes9gIw5O/LaJAm5QrHlsCibzYkXHfO78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0DWqJD9kbKKlKZeIZqEfAakh+PM5MvY5VAPpR14I1vYwYhmPjCKgrQ2kd0gjN3joz/Ae87CL9zWymAoCxGBK3t3Mz6imaEG/AhLinM2/56aFbvllzlJYW0HY8joNyrYAqO1pgcknV26szsr82SZCv5mD/vEaNOJSbUF2ZiXTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV13FeQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB4C4CEC7;
	Fri, 30 Aug 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725030330;
	bh=uG3bEWNdwBYes9gIw5O/LaJAm5QrHlsCibzYkXHfO78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV13FeQYg/h++SDDm+EjNpaOU2HB9KsqpppdeLaUunA9e/k6Rty96aJeqoSs0uzIh
	 +m0jplwJN/8u26ETZdSWtCPz9LntggWnVM76kbdj8hhlBnWZ8djZEJ3wJRM4AQj6tl
	 HHkprGYQ6Is+feW9Ne7oibcf4UD0wSGQqLARDhOTMmdt/0D1Ky0zIOR3/MiY/wLTka
	 jWLSYigE1X1aCP0rxTls3fBymMBAdOzKGYV8pDkS+ncE6b6IlVSgfpBYEh/DjIQWQm
	 2Mtf7a8/W/Yh61fxQrB42tLQPckjiC8W0YP2YD1Hf5aFm+0ZWTTclOEZW/DDx5pwsf
	 7r1sgAUKda5PQ==
Date: Fri, 30 Aug 2024 16:05:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Will Deacon <will@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <d0642c77-34be-4082-be92-1c32c912b9ce@sirena.org.uk>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <ZtG1V9me28OvU0Qu@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3z+LVmFu7Fj3GG9k"
Content-Disposition: inline
In-Reply-To: <ZtG1V9me28OvU0Qu@zx2c4.com>
X-Cookie: VMS is like a nightmare about RXS-11M.


--3z+LVmFu7Fj3GG9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2024 at 02:04:39PM +0200, Jason A. Donenfeld wrote:
> > > +SYM_FUNC_START(__arch_chacha20_blocks_nostack)

> > Is there any way we can reuse the existing code in
> > crypto/chacha-neon-core.S for this? It looks to my untrained eye like
> > this is an arbitrarily different implementation to what we already have.

> Nope, it is indeed different, and not arbitrarily so. This patch is
> mirroring exactly what we did on x86.

It's probably worth some comments or something explaining what's going
on with that (the commit log for the x86 patch mentions that it's that
the vDSO needs a version that doesn't write to the stack).

--3z+LVmFu7Fj3GG9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR37MACgkQJNaLcl1U
h9Dqfwf+KbUULVPh36yGrixMdaEv3rTW8UGCRY02kKejrOexslmWfOeKks5uOjaK
+8tOBYrEBNr88ghsWNmLhpftBmI7T2M0VdK84ZP7nuddiZNPONOsLux/g7Q/X6OD
23uWI+2YwcCRkj/Y+wJeFKn/kCQeKlz+bxNGD09waay/2cfX6+pHbm0UityoMILN
yEWo/7xfZx1mU+gwks4tzjPI1goxnd6/EDqS7Ha+PEyowShlP2e6Gxbd6wY6dgZH
p1fbGoz/1GUHZM5PYcAvvmIbgYlEFQVFjORrkkQ12Vf0myHdQd5e0QHGngPKsidh
CTOfZOlYvow2lwhUUhwYj9TyxmO2hw==
=3l0l
-----END PGP SIGNATURE-----

--3z+LVmFu7Fj3GG9k--

