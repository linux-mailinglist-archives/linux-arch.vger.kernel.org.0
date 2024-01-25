Return-Path: <linux-arch+bounces-1698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83A83CEDA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3F28DB40
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6513A272;
	Thu, 25 Jan 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBZqDCRb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E1135413;
	Thu, 25 Jan 2024 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219336; cv=none; b=RpwdciipZR6ES0yJ2+vJe6G42oxUaNYOgsk0EyMJI9jhB1dAJ3ot+H/bUfTdbhuFu9bmJLzftHyA2l2BKUxE9RnbtVZzvxi3pk0YBMICYCHfvRvv002rFZEIeglb8OUlgB5BuZ9zM+0cPd34JGD+18j19BO4sIb9k6X6VU+Asuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219336; c=relaxed/simple;
	bh=rWGTonIdjaAw97+VCMgdvv8+A740NjupUkUrNWkZhiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIyxkyuO64u1Y6eoIxZP3XE4WNxTrDty5SqRG8WoJOmuOs2NLaL6y2eUvPQqPSOtk3c5Muf6nbka/xPIFqvgb+WFxBzODwbaQG0UxcyQptLLpylLfO2GRzQJTXNqRqzmGi1F8Z1H1CxCywbIZfq3fA99Eb1OUu2+zNnF5FJT2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBZqDCRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD265C433C7;
	Thu, 25 Jan 2024 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706219335;
	bh=rWGTonIdjaAw97+VCMgdvv8+A740NjupUkUrNWkZhiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBZqDCRb8YD9sWKY5X5LSGXBZlsGS5XW90KA4XY5rwha8+ew31eOIpNFyMuattB4w
	 2sz8XKtIikx9HlT5vLckXPu1NtzXZqplpKMxpUQVIdM/jSBGwdp3dapwPJJkH5PWPU
	 3wnPCxc/O51mJ4W7Bl+DBqK0MIiZdH+I3x08hAbUmq3FFVnZ7/IFxC3MJ8UZ2Xclyr
	 rcwFlKGeOghipvEhMXHX7vXwe1da98i7EosC7ZRaf8GBBOmBj+m1ftDESID+YFE861
	 Z28nCaCuycEPvpwQ54qFY+y2LfyseerDBw8ftFaf7V2pPT0gF8y4Zs61QrL1M3KM/U
	 yCjsFsafBTZlw==
Date: Thu, 25 Jan 2024 21:48:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org,
	arnd@arndb.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, kernel-team@android.com,
	willmcvicker@google.com
Subject: Re: [PATCH v2 10/28] spi: s3c64xx: use full mask for {RX,
 TX}_FIFO_LVL
Message-ID: <e2c25c1b-7fe9-4174-95ed-e867eff14e37@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-11-tudor.ambarus@linaro.org>
 <CAPLW+4nOGjfniu+shzO5irmH5bC1E_yD0EZcuDwQJKdfMiDswA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8vvs0/b2DbNCmIR"
Content-Disposition: inline
In-Reply-To: <CAPLW+4nOGjfniu+shzO5irmH5bC1E_yD0EZcuDwQJKdfMiDswA@mail.gmail.com>
X-Cookie: Entropy isn't what it used to be.


--D8vvs0/b2DbNCmIR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 02:03:15PM -0600, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@lina=
ro.org> wrote:

> > +#define S3C64XX_SPI_ST_RX_FIFO_LVL             GENMASK(23, 15)

> What about s3c* architectures, where RX_LVL starts with bit #13, as
> can be seen from .rx_lvl_offset values in corresponding port_configs?
> Wouldn't this change break those?

I should point out that I have a s3c6410 board I care about.

--D8vvs0/b2DbNCmIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWy1z8ACgkQJNaLcl1U
h9A4kAf/Q+HBGYYkQyjJ5STSJRHGbWJxkifiVS4eI6m2f7lwAyvgTOjwWh00Ok4+
Cyya2gAMfFPhwVXlaJDdCJy/iUerkZi31WdJ1mWXIi8emYRn8hzqPEMupJMjiHGK
T05f9YtcTwyD1P2cHdhrrq0d8hpGqwvfH7zBsKDTwqXqS6BtARjR4MLX7mvReCYj
uHHO2UtwKzAOClsM6BeDnSciuXDx2z57MhaXZNX9RpeMTrYCW57UdkfPOS0ZuSty
6pAdSh7jgREL7cSTq2cU5K4BOXlwcWdmGPRk1d7V5x55zmPWVeuKZzGmfji1BQz9
XH9AJbaQWAdfFzGPvs730pb/JC1GRw==
=j0Ln
-----END PGP SIGNATURE-----

--D8vvs0/b2DbNCmIR--

