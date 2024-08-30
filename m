Return-Path: <linux-arch+bounces-6855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3B966524
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E28A2844EA
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A211B1D4B;
	Fri, 30 Aug 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CneQS+/4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE71A4B6C;
	Fri, 30 Aug 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031148; cv=none; b=bMgVjhZRai1PWySpMjD9DWCDmz6yk5IP0x8WnJ4c3qQWIbTyxQ5/kvguJ0n5t4ryPhkJAGNYxltW+h6cOXf9FdJYr0QakFHKBJjQV/DIf7msnjHmXEYzSATjJhq+IkZ7Eigjj8gA1EEFWGWSU8W5WVsUH5yL/RuFql6ExPrmEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031148; c=relaxed/simple;
	bh=UxT0zvqEy8sU3/AbTHrjGMCPAwmSCWG5KRJHyiSxNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICNmYIB4vdbusrzLT2KwyojtjOw/KXgPcEbyOZ4eBkB9idddVMB4hcNE9P4Rz66sVtoyIa+NxV5lrsOG0FUT9TrYKEzamcvLsTP43dvnvcb/bz3+xMDL6VEas6n5PE0Cn1enarFTQ+Js9nZ3sTnXtcXFavjr0UAQg/MjgsQRvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CneQS+/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0298C4CEC2;
	Fri, 30 Aug 2024 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031147;
	bh=UxT0zvqEy8sU3/AbTHrjGMCPAwmSCWG5KRJHyiSxNTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CneQS+/47YZSiFmolQlOfv6vNSbuq5lZVLqJIDFsARxtQxuVAwblCl1XAl0My1rnk
	 P2G+kWT6kYsVrbP9HWrcIbREN9xJZ0dUNanx2EEipvQbH7QsWaxlfRBjIUPpq7+C11
	 ATREe9JbH795uuLmFjK8qp45c/K3y71sz0+dXuEwrSL+9Aggn5a2K7HmEZvbN9y7RU
	 TZ9P8JNcfZ7nTuW5Z63n0Wi21BdmKqG+SoEYPAyRNyQ+BlLFqfhFM2u/NjGXGRk/I+
	 fyH78sNKR/D7Y08mT3krNm+KUiFqRhr+UzJ3bqJnveJFAfQEECse64cWJOEjlsCLdJ
	 /UVlZZ9BBpVVw==
Date: Fri, 30 Aug 2024 16:19:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <9dd8fee0-008f-42f5-b1e1-d4de3270ccdd@sirena.org.uk>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EEUPVV0CH0Fg3oZJ"
Content-Disposition: inline
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
X-Cookie: VMS is like a nightmare about RXS-11M.


--EEUPVV0CH0Fg3oZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2024 at 08:17:14PM +0000, Adhemerval Zanella wrote:
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data.

This exposes some preexisting compiler warnings in the getrandom test
when built with clang:

vdso_test_getrandom.c:145:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  145 | static void *test_vdso_getrandom(void *)
      |                                        ^
vdso_test_getrandom.c:155:40: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  155 | static void *test_libc_getrandom(void *)
      |                                        ^
vdso_test_getrandom.c:165:43: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
  165 | static void *test_syscall_getrandom(void *)
      |                                           ^

which it'd be good to get fixed before merging.

--EEUPVV0CH0Fg3oZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbR4uQACgkQJNaLcl1U
h9CxrwgAhl7rM/yuoIqLoJv1Q/KWB9FRLr9ypByZbn34tfS34OkNFesGrcwcUhXJ
+hlzFh3ru3NHwfkx772CXSLtK0sJN+a/zBVj/sfighNXJmr62rVS60Z9hvm+tn2M
AXwwowGgw67Pb9hTIqGiOoLzxXA3IZEQjckLB7EDQuYTAxcvcKL/R/4iPV/QRWeJ
ELpgjfIT4YDtxUUs1fgM7HFhpnIW+0n7rWmMoFashs74ckgkJhhjDt7DrFMet8kb
doT1xjOY8z6daxqmahpjjbFVBxKvvsXIvJMsqgSsHSdNoz8k7znSZLVa/Tb8Smhd
HE/CCrVpWCJqfc43mWFsfqQvUfLEJQ==
=qnZn
-----END PGP SIGNATURE-----

--EEUPVV0CH0Fg3oZJ--

