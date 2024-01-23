Return-Path: <linux-arch+bounces-1501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68639839C71
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B5628D05F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E625380A;
	Tue, 23 Jan 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTIMOXnK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94509537EB;
	Tue, 23 Jan 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049749; cv=none; b=IW2bLHto8Nd+bREnDfLJvThcC2vYe9DE2yx6L9IrYwzXOXpiHtfLH1kUs39OFMMCv2k9tpHWYduNZl6FSaHgUamqSzJoNQLExts3lmcjA/YTOPKaPWah665m7JQ2GBjZr+Qc4EhN9EBmvtOpcSVdhXZLqRHq9/x2ZqQhuX2/0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049749; c=relaxed/simple;
	bh=biXAVYcjtB4l+Tb2LCVqxC+KBOGSGLcFg5kB6FJ3hpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwrUn4FKT7J57MbcJ3+6Gy8eszlTvkL53wbDdn/c8M+iXXulnZKZ2r4jRvEJpGoX3nAzK+j95n55AomCLAiO0fEcKmOW/vdYZBL77/hsGCWs3/6BJSXd1KxD2uauq9XP6k3W2RSyqUj1/r//gl9CW+YdUkHvAMTsYB1gpG50yHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTIMOXnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED3CC433C7;
	Tue, 23 Jan 2024 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049749;
	bh=biXAVYcjtB4l+Tb2LCVqxC+KBOGSGLcFg5kB6FJ3hpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTIMOXnKab9MmvXd5ioHSuHjwgZPb6WRB9x+IgUDGIaWvdYblLgVg6UWtoBM7R23l
	 Tvp3wb9ze24X/V/IRHw5Ttnk6H5b+pQIlE7kpAyZEXBMn/8BOjObIck24zJOtuVT9o
	 J5JSlY60Lqtuw+Yk9IFHfyjOn2GOepCE+i2etPRItDbHafX7u8gQVz2nyXkJJhc8Wg
	 4sK0vh886wSVgW8FMurAyegJ1gc22AGbaucrOF54pf1Hhs4DaxKIWeU+iZGRUtguv2
	 qxIr3LY3YhzfVO2dREEaOCFEhnFGJv8Sq+tbPj2nFJVZicX9POZMOzEEqaTdvLHeAV
	 c0Q2SvzblOqDg==
Date: Tue, 23 Jan 2024 22:42:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, arnd@arndb.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	semen.protsenko@linaro.org, kernel-team@android.com,
	willmcvicker@google.com
Subject: Re: [PATCH 05/21] spi: s3c64xx: explicitly include <linux/bits.h>
Message-ID: <6cfc5715-a4b8-41b4-ad82-95f9519301d0@sirena.org.uk>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-6-tudor.ambarus@linaro.org>
 <kmijvv53j67l6lgndgrybj6iaup6pyrvzklkre6th4rcnrsrqo@ie5ji4nutbcd>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CdYcJZPEcogqNf8N"
Content-Disposition: inline
In-Reply-To: <kmijvv53j67l6lgndgrybj6iaup6pyrvzklkre6th4rcnrsrqo@ie5ji4nutbcd>
X-Cookie: Stay together, drag each other down.


--CdYcJZPEcogqNf8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 11:28:31PM +0100, Andi Shyti wrote:
> On Tue, Jan 23, 2024 at 03:34:04PM +0000, Tudor Ambarus wrote:

> > +#include <linux/bits.h>

> I don't see why this should be included. Are there cases when
> not having bits.h produces any compilation error?

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

--CdYcJZPEcogqNf8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwQKkACgkQJNaLcl1U
h9CGdwf/WB+c1bNFLr9Mw/Bud7/dT7qG4Xs2wsTPTbTW9o1Ygf6DSRdeMNf22+i5
Bk3vgNREsSMYemyPugTQEP7T+dURYDU4LmwwL2YpEjoC/KfqoLxw+3SitZ8RLJS3
me3TNi5biT1j6qZlItY70x76X6REQ4jDs6odxfxvqLlApxp2mb4XXkNT96Oanfx4
uHbNrYgjnDsdNj8HQkdTF52OAtXAzQFhqmArmbXlJwNyS9e6rEsAa5leZY1cibPA
MNHfbJy1hH1PReX7xPuYEKBGBZTUskdW9wICJHcdz6m2Gp6+48lxibDLUdqk0Ex1
ERfpukg31HlmJpbbbD4p3jHSuglE+A==
=dKfr
-----END PGP SIGNATURE-----

--CdYcJZPEcogqNf8N--

