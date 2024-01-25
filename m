Return-Path: <linux-arch+bounces-1615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29C83C7B3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9DF1C20AF3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61364129A7D;
	Thu, 25 Jan 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icSN+bEO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A32129A65;
	Thu, 25 Jan 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199410; cv=none; b=utWWYuKdtj2fqCjCV4nDJycK2GdpYVwcA8vo3+FlD7r507atGJ2WzcfhmSvaWL8I21BltyNMgMFsW5IrjVdjyAP3ph0UsPRjePUUaGe3FJN22jf98gijFVjdjTjob9lzccgSyLySfRDbqRGQikSzUS8JWRYHx3DaqsKP1Z/Oah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199410; c=relaxed/simple;
	bh=VXi6S5TfC6wh6uV05EbFK3sFOn7r8NGK94QimtI8NRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJAaK6R1No8unjQm7F/7gHpoDmjjEQ4bhiq2KLFL0MxmeY/Xn778x9rR7YzXh9hqh8Rxhpn7h0LdylkLD8hfrNgzed2Je5SmTWMrMGdqP7VjVs/S9eqM8xIjZszGJTldG/TvWneFrpsOMmGpv0EnlZQmcVuD+JUHpuGNcO+mF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icSN+bEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA65C433C7;
	Thu, 25 Jan 2024 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706199409;
	bh=VXi6S5TfC6wh6uV05EbFK3sFOn7r8NGK94QimtI8NRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icSN+bEOi4GblIOKLMeD8FRzJxXuCn4vAFimGax5qgkG9R4sv+KcaU7UMAbNIFttq
	 xWPO4IvNatsrQw9heg5WXJUjBY0VByfYnvw3u4HH5h3k2JNe/LisUTIPg+2l6Zz48p
	 v3URdqmpQIgY855l4LIp99woseCV1/iDHd++dZ5iZxggLPO9h1GiGK0MBjqLFfM6dr
	 nLxRm4TNLVMnz2ByAPguJoA+DjG9zsxGqCHWb05cRmpnM3JQNPJMRDKWLu3ryI9ZaI
	 aifsH4+HEW5g/VT1lfzrI3mpI8Hjsl2IucAjmqV/fgDLpn9XP3cApZ7Qkt/RCfRLao
	 k8jFo6NFZUY6Q==
Date: Thu, 25 Jan 2024 16:16:42 +0000
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
Message-ID: <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2pNK1YGsrup62lp2"
Content-Disposition: inline
In-Reply-To: <20240125145007.748295-6-tudor.ambarus@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--2pNK1YGsrup62lp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 02:49:43PM +0000, Tudor Ambarus wrote:
> Up to now the SPI alias was used as an index into an array defined in
> the SPI driver to determine the SPI FIFO size. Drop the dependency on
> the SPI alias and allow the SPI nodes to specify their SPI FIFO size.

...

> +  samsung,spi-fifosize:
> +    description: The fifo size supported by the SPI instance.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [64, 256]

Do we have any cases where we'd ever want to vary this independently of
the SoC - this isn't a configurable IP shipped to random integrators?

--2pNK1YGsrup62lp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWyiWkACgkQJNaLcl1U
h9DSPQf/UyWVNYavre0R8UR+ayShYt5wuwJmhUZcqzxWasH/QJuEl/xghcGTIFHj
W8r2EJzRCVTTiIEb/nC9CxPf3Nq9BctGpWs7L0rUfD5LrKraPnH4NYE06509QyS8
ANl9N46cJWD3sQpf4uLhgQyJuijq838qfF47rgnLHPEva7OmHTI71Gbva2TDR+Fz
u0RMukSetUK7MMYySPlD+qceV5FMg/f1Inw3AnWv7NptcFs5htMdOwbmKoaGznqK
JrR3abJGqPgdjwliWJtIXcEw9HSJPeoQQIJ1i33igCJWk2wcM5fkE3XsC1xdifxq
TrXAH6cbnyIegCjUQ/JEtu7LbbVgUQ==
=63By
-----END PGP SIGNATURE-----

--2pNK1YGsrup62lp2--

