Return-Path: <linux-arch+bounces-1478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B35E839918
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058791F2A283
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E512A141;
	Tue, 23 Jan 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0OZLtn2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410C129A71;
	Tue, 23 Jan 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036447; cv=none; b=TShEXiuWz8LRP6BbOp1enwFL/6UxCeLSL3fH3lO5aV8fz3eZZud8FumnNo81699wubdd62lV1Jt6HN/zyqbPs6drQY6BsvQU2VyWaZEWb1jGCimIh15/LtgT7gRT4QfcoGvaVK63/NgkKmTIvA/pcOTH9yNcFcU3XOPi1n5CuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036447; c=relaxed/simple;
	bh=mAcYNzDoP9dhqdN5/WCgwNX1TFh0slvAugab5Iyw3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUhWncAvW8O1t5B1E5R+tkW1jM2G8ao4lnYTtF7G2KtYb4P6Eh9wx8hkCJRMr7AlU/xNIleZwipMFqFAENmqqnhjERWcfTs5hjYtSWInFv62grcQnzMsADtFG/x7pvuCfFDepu6/If/eVT+KH52ViSBi8BB3OwlpF+N2j5pSVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0OZLtn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1C4C433F1;
	Tue, 23 Jan 2024 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706036446;
	bh=mAcYNzDoP9dhqdN5/WCgwNX1TFh0slvAugab5Iyw3Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0OZLtn2Z/NdUeupW/M5s5pCK5P8odLNmtkcv+CKPZ4nf/oENpI/yNat+pGtFFq3X
	 OzgyS6peNQtfc+xxDL7vh9rKXfTlzdmY7DCOubGrrQxw9pYiBOZjzfxMgmkDhp73Gw
	 Nf6cXihcMPzsR73GINhOTYTg1j16jMYCNyJ5uRnZs7qiXHyq/0BMp2znDV5SJqkuPD
	 LgKqLzPq4ATdWlahOMJiQvxUMAYUhYdVALWbKekfQrS1jD+fPN65nGIe38XQop9Rgn
	 biGdPjiSlFlxrOQmtSLb/4yBvgdqOIpyBZ9oZ5ABicZykVJaGr6ovLn2RI345FShNO
	 fBqVA3c4naZsg==
Date: Tue, 23 Jan 2024 19:00:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, arnd@arndb.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, semen.protsenko@linaro.org,
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 00/21] spi: s3c64xx: winter cleanup and gs101 support
Message-ID: <e233f4ff-9ed9-42bd-8ffb-17b66bcf2b5b@sirena.org.uk>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZFvdDX3POLjhPB0W"
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
X-Cookie: Stay together, drag each other down.


--ZFvdDX3POLjhPB0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 03:33:59PM +0000, Tudor Ambarus wrote:

> The patch set cleans a bit the driver and adds support for gs101 SPI.
>=20
> Apart of the SPI patches, I added support for iowrite{8,16}_32 accessors
> in asm-generic/io.h. This will allow devices that require 32 bits
> register accesses to write data in chunks of 8 or 16 bits (a typical use
> case is SPI, where clients can request transfers in words of 8 bits for
> example). GS101 only allows 32bit register accesses otherwise it raisses
> a Serror Interrupt and hangs the system, thus the accessors are needed
> here. If the accessors are fine, I expect they'll be queued either to
> the SPI tree or to the ASM header files tree, but by providing an
> immutable tag, so that the other tree can merge them too.
>=20
> The SPI patches were tested with the spi-loopback-test on the gs101
> controller.

The reformatting in this series will conflict with the SPI changes in:

   https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@linaro.o=
rg

Can you please pull those into this series or otherwise coordinate?

--ZFvdDX3POLjhPB0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWwDNcACgkQJNaLcl1U
h9DZOwf+Ie3iPAFWZDhGjymlNYKyWlq4LFxg7+2Vp7ig+SrrcB/PL94lyjnBRN40
V2N6WCZ7+wHOQAjvi0p61ln9UkAdbN1AVeNPu4KNrne6NQpWCDzbV/yNatC5tHrD
AlOjNznAsCTv4RVfJRxOLJ4RqiB2O7RglT2e+eMWF8xzNFSjYPa6j3iZnTHBeBeE
6eZDgJj26a/NHMmdjia/TDOfUQQJVUcQfQt0QGSafk1zQL8LQRQS+adF64DP1fbj
mZv5aIj2LRKc2AS1Arl7u0OOeqvhrn1hdV5t7au9/Ck8hsdJSm84sh49DQODaW0r
q+GYaW+ejEf37M+7HFSdmTMocRZxcA==
=/oRc
-----END PGP SIGNATURE-----

--ZFvdDX3POLjhPB0W--

