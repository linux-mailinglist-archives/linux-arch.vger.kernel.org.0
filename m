Return-Path: <linux-arch+bounces-1663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DA83CA37
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01D1B21FEF
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8252B131754;
	Thu, 25 Jan 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzvdQ7ws"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20F12A16D;
	Thu, 25 Jan 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204478; cv=none; b=YBPDbVOMdpaqOJ+KUKBbcC6YyKF+XzcZhwtzHcFMydLyGHHTLeGZnr+ImfIWzx9a7SymN5zSqq6n/LQtjL2njpZil9zhK9ERbPHKYSWxmaRPEKMb116DSBnC1FFSxsrA3Vz/cWmji/8iWDS3Uq+tEtOPczoYZEjHS0PzJhBSTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204478; c=relaxed/simple;
	bh=mTJDxP56QMjMOrw6+JasB8kvTV/+hsTnHbBVEDz9xIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCUrcJjFWIly7YVfmLPhr/0+H9C++9lYgV4QDE+srobHKAqALWx2vdXn87Ycgq6TJBHIsmQahYSMDndpswZzsHNMTklStmSjnsjvznlvC26ZSh/8OY4UEwLrOIy/HBb5oj+RT1nq66K7MuzjCeWI5FnTJkFQmQ2VY2xHtWk9VJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzvdQ7ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08BC433F1;
	Thu, 25 Jan 2024 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204477;
	bh=mTJDxP56QMjMOrw6+JasB8kvTV/+hsTnHbBVEDz9xIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzvdQ7wsAX373OU6vf3qt5lfOA2sbYSk9q2eHUTk0sO2UTQdUOBOpXd9lMTUX7x5k
	 LOBYkmSk4aw6H3WD3ucI+1WWVP/wKbLhjaUnV3JqCebuPERGg9xcSn5KqTC2M+daco
	 RQ9ZmytnxWMbIvHQz1OKEaDj5G+wJMclK0hA8mnHyg9l+35nYBmTcJ1LWQUj9q8E3+
	 Et7VVhFBotAHm9h6eSdmCba1R35O9VbJ4ujIjFUwkZ+Ltz7eqaANRw6GQkJ6HdWuSl
	 bnKlPnHCG39audCcmCOUTBxnisGWqzr8QJSXVTxftGCstGJcxjpj8764C4bwk9BKNg
	 1tPNucUuO4LPg==
Date: Thu, 25 Jan 2024 17:41:11 +0000
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
Subject: Re: [PATCH v2 25/28] asm-generic/io.h: add iowrite{8,16}_32 accessors
Message-ID: <102355d8-02ca-48aa-9e8e-c9c70b2583bb@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-26-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ngveyGh/NxPgrCdI"
Content-Disposition: inline
In-Reply-To: <20240125145007.748295-26-tudor.ambarus@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--ngveyGh/NxPgrCdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 02:50:03PM +0000, Tudor Ambarus wrote:
> This will allow devices that require 32 bits register accesses to write
> data in chunks of 8 or 16 bits.
>=20
> One SoC that requires 32 bit register accesses is the google gs101. A
> typical use case is SPI, where the clients can request transfers in words
> of 8 bits.

Might be good to CC this one to linux-arch if reposting.

--ngveyGh/NxPgrCdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWynTYACgkQJNaLcl1U
h9D8bwf+PB60iwNcYjP7ugMjxfkSNikSRBMamGUku/HzAYVB9vU42zmsYJl5YBP3
hju+dTZlIrzw160uBBcEpqP/y8d1R0Y7F1s4L/eoolctzWhUyAbdBgaZDCC9kK5d
kH0bhkH0Ezj7kHLgSd2MHnsMyVS0+poeZbTpUCWbpFdSxlHUfHKM0QEHRjq+F2GS
MCFStZRJI8IJAr2/H19xyV+MrkziW31enxAIkY0zxfRmoaDWDdx663Hs8nW2iptN
WWsvCTNM0IfD69aS3mOglFasTTaOAC7l489D3Qoq9jZdojxducNJqXmhmG2oIrr5
A3y1G5Chakvf9Zf3oJprmuv7hhEBYA==
=lfHJ
-----END PGP SIGNATURE-----

--ngveyGh/NxPgrCdI--

