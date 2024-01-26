Return-Path: <linux-arch+bounces-1736-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B083E3C7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 22:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4481C22C5B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 21:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0C249F3;
	Fri, 26 Jan 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtO1CxMm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A68241E5;
	Fri, 26 Jan 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303956; cv=none; b=ME1UivnNzPAJvpZ5zi8ExsD+cOQrHTi50s0ka6DYX7SfKvsBHjp63Nm1cyl03B9Rj443R8W8rxbJwF5KtQszXsfPU4RRjr+jZpsjLAqbpSk0Yopm7NLrWoD1xu4VF7klTZNPWclJ7Pb0p9OlbPP1GhR+ZrNG8dvJTHnrWgia7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303956; c=relaxed/simple;
	bh=QAmhzRN9Gx5RRTwBMINr0tSQKWvpM2+7nYt4uq/mnFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbZ0gkNuAakTO5zFMEbqFd0gnpDVSUZTr4Yu7yfyz0nAuYWy8ob/7tce4v0mlcSPNFNBGc9HgkOyJDFgm9j+zukUBK2ak93yYwGPA/It/qsSvBwWTM+T+mrORIiJqtYR9+0RbhgYBbd1z6377WIVrURm5c4uGcroXaiAgTrpeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtO1CxMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D9C433F1;
	Fri, 26 Jan 2024 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706303955;
	bh=QAmhzRN9Gx5RRTwBMINr0tSQKWvpM2+7nYt4uq/mnFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtO1CxMm/dTj6BxsdRp2VlOcmN4qRo3PsXFYQywV8xlyPCpJzy+8A01s8s0vBpxHj
	 VWlMKMvjTuXziTD4IfTEm862VYZOfPfZ16kI9/qgf/IgnJjmL+FMxdM0r95Q5ZI7O3
	 Pbk99uRXUn3FUGjqjSnWa+jWeaGep7Ipk5uwYM3PIsd77PhhNy8fO1Oc2bIZt0vYuH
	 HX8P3PIIY2iNxwMfnjQVnk0sNqMSefKsYs5bEsT6L5GOMqWXO2TZg8qdvEulmBZMXX
	 isyelBBpWE6Sr1rz7gTFVLAPKkzB/OAzN0Tquc9TwA6fIezfEqr7sryZtj/qyG2S4X
	 MiYe/oVeKQTPQ==
Date: Fri, 26 Jan 2024 21:19:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>, kernel-team@android.com,
	William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
Message-ID: <0c4a90f0-b40e-41e8-8950-16863cbd4c07@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org>
 <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
 <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
 <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNVF8uZx8MQjuD9w"
Content-Disposition: inline
In-Reply-To: <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
X-Cookie: Excellent day to have a rotten day.


--PNVF8uZx8MQjuD9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2024 at 09:16:53PM +0100, Arnd Bergmann wrote:

> That sounds like the same bug as in the serial port driver,
> by assuming that the alias values in the devicetree have
> a particular meaning in identifying instances. This immediately
> breaks when there is a dtb file that does not use the same
> alias values, e.g. because it only needs some of the SPI
> ports.

It'll be the result of a conversion from board files where that was a
normal way of doing things.

--PNVF8uZx8MQjuD9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW0IcwACgkQJNaLcl1U
h9B/SAf/S9EZ2RMGzQoioDEZX27gnXJCqSurY1TDyT6aGYEKEfM95MwWi1cAiUI/
uBwUMJ3a3d2V+0vpL/xoXLpUYU/sr1CfbmvpE71M5U429GMemLZrzUqUFmWNfQYC
kJgUakh6v9/Yzd6jGBD4oIU6XYtcfiX46m/qSeIuIde1miqRUeR/vlZpZ8264YEB
q4xjWlNbErInSJa7bt/srm2e4OCrjlsM7UwRyeTUfRCZ6Mh20VsiCN9o7iwPAOjD
hqOVvIdRQad2iIG/UXxv1Yrswy0/BN5urIpxolQmx1pxDFzTLdw7LSareKjBqUvI
dgVm6/5De7gMVkQTciuwAtijMaT4bw==
=U2OJ
-----END PGP SIGNATURE-----

--PNVF8uZx8MQjuD9w--

