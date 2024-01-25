Return-Path: <linux-arch+bounces-1659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A983C9F1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC88B23B0F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B62130E4B;
	Thu, 25 Jan 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoR0CQNv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E312A17E;
	Thu, 25 Jan 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203599; cv=none; b=Us99l2ykSa6OxkYoSBjKozJZVq+EFgufI6i7gunl8WaEZfVbJ5iJxFYsx7gd19XIX/LyUZbMfhmUty/lHglkef716i+xiqwZem8Dvhcib4+bQ50f/fWJ5Cimpi5KGqHkLqhUkWsio5xC9Cv8da1gbSRg2OsjgdeSFZGz34sYTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203599; c=relaxed/simple;
	bh=vtqMTh5mi8bP14GEPhOfEXbU3mNDx+fxiMNCNbv7s5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9jjvMOT9RcxFglqqhmRCJSEkxXf53PGLIgYx66jpC4WnH9Itdtn22ZYYb29pSDuOyB5K31NQEXk+mRelE5L7v52S9OwEb9v1UjmUkejs6TPYyGWIJWfn+D5reWFEaAVV7OuM5L/YfE4A0SRrfXTwtVKpvKD3c3xih2d/I/7tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoR0CQNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF3AC433C7;
	Thu, 25 Jan 2024 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203599;
	bh=vtqMTh5mi8bP14GEPhOfEXbU3mNDx+fxiMNCNbv7s5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoR0CQNvCUv7/XGyqvVYhtgfdMX6oZgAlQ1OUuZEaItAdLScimNS8wghWsDQfIWCa
	 vbbHfmg84wIx7pi1kKuYA7YEG7HVSPjoAeP1kZivi1OJoGsXQYZCaVgw3FgKS7jIOM
	 8EM9juWj0aH+3Y3ji1VRBiR3j7F98czti9vioKhfcMuNhYcTGvJy/mf31UC1EUrmup
	 VzgQyUoWuwtxPmanne75ZdSrAk/FUs8d/whHtHcXdI7PYwwYo8VwMpIY/F3Gym56z1
	 1+TMlB+ZpNeOzRwgOs8V6uoJr37ZLV11bQ9ulCG3SBqx/9Zn3iuCQW45qfslCt86WN
	 YxcqWinIg+6Hg==
Date: Thu, 25 Jan 2024 17:26:32 +0000
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
Subject: Re: [PATCH v2 05/28] spi: dt-bindings: samsung: add
 samsung,spi-fifosize property
Message-ID: <55af5d4a-7bc9-4ae7-88c5-5acae4666450@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
 <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
 <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tedSwmyuyGBKoohg"
Content-Disposition: inline
In-Reply-To: <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--tedSwmyuyGBKoohg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 04:38:07PM +0000, Tudor Ambarus wrote:
> On 1/25/24 16:16, Mark Brown wrote:

> > Do we have any cases where we'd ever want to vary this independently of
> > the SoC - this isn't a configurable IP shipped to random integrators?

> The IP supports FIFO depths from 8 to 256 bytes (in powers of 2 I
> guess). The integrator is the one dictating the IP configuration. In
> gs101's case all USIxx_USI (which includes SPI, I2C, and UART) are
> configured with 64 bytes FIFO depths.

OK, so just the compatible is enough information then?

--tedSwmyuyGBKoohg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWymccACgkQJNaLcl1U
h9AF2QgAgEqzv1mSRQj/NbqTSOlGm1Rr9OD4KhCRYdJM/e4pWeYvOG6juW6CA6EB
iw7yqetnwW9Z1mwWDVCw/I9iUVAxKkHM1wkK+KxSvBLPT6WDr3bnkHTrYHtF4Ygc
OesDmANugMh39tScldkDtp64M4epPmEpf1oWBsPvRTmPwCTvJisDv5qd3r16KePa
z8CEHmECZqaWHJAwDp+yr5jfcAiWIYHB5X0qqWbrrrZKAdxwJ+6jHDICIq1DvDGO
lY3Kja7CDhCYFyiiIjaLJ4JdRaCK2b2iXC7aDR0kfDAHlla9ZLVRullWzdSq5oVe
ctxVRA/VC7kyau3LnXL/Ir5zQc9wRA==
=Yk/E
-----END PGP SIGNATURE-----

--tedSwmyuyGBKoohg--

