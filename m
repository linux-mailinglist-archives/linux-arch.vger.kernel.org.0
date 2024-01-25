Return-Path: <linux-arch+bounces-1658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0783C9C5
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9053C1C24695
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F6134724;
	Thu, 25 Jan 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2HkKulG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D71339BD;
	Thu, 25 Jan 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203089; cv=none; b=n0VFn4TBY5a63Q0zfsSzCFqLZZnTRHpwkygdrs8uon2qU5UhxPO35stLlNNSg+fTWLGfyy8cCH3WAJvX9XzNkClsZfj6bpZSxlzBcYrU67CDPNLwk5riygQwM6iluPpSaa8zgyKDKXkAjbZ2x1ixKMbwORazKIUB9fIZOojWBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203089; c=relaxed/simple;
	bh=VmrqQGWyTbOGTNQ/vAkIp69HNVkARx3sDciLeid9ZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ypy2SR01OYXto7hxEStSowFDFkkbYbUJwlMLZckm0PnW2xb9ER0xLtQ4gsMJrMix4IijPbJEJOsbA0a/JeUF224+UAEeKXlHxbkRwpMN7HhPwOpPYyRcuF96KTorwdnxDEkRdgGiemLz2toO9YYrExAMM2DfsRalf0yCf+hUg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2HkKulG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE2FC433C7;
	Thu, 25 Jan 2024 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203088;
	bh=VmrqQGWyTbOGTNQ/vAkIp69HNVkARx3sDciLeid9ZvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2HkKulGZOJDLv1CxUoUEePIPPC22jyGmMG6KiuneZXq0/pd1BpJlwCzUgSmTWrV/
	 R/JO5+1/nhtk15gStc7jK5j/9Q1/XcQ6iFDjFueIIt/D6jmuYCmL6vLVX/2muZDFMY
	 xVOY6UAULY0vUoG6goSp6+BmSxcBAeKDNAvryLnS/Bq4E9BVcHW9xdeDSIieHGdR2w
	 Karj56jxx3FtkJNQRD6N3RkOQkt2vCvHkRNdwIR9yIDstmtGDj3vxAh+OJ27K7MQ58
	 iUkTNtQLK31/1UpBmv2VfbCBk43VbMc+qMI3BrM732hVdA0PpV6KleWQh3uTjWT4zp
	 kMvvZNesLB/fA==
Date: Thu, 25 Jan 2024 17:18:01 +0000
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
Subject: Re: [PATCH v2 21/28] spi: s3c64xx: infer fifosize from the compatible
Message-ID: <2086b88e-45fc-4224-b00f-0840d446d042@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-22-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HgRtS/XEVb/749Yx"
Content-Disposition: inline
In-Reply-To: <20240125145007.748295-22-tudor.ambarus@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--HgRtS/XEVb/749Yx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 02:49:59PM +0000, Tudor Ambarus wrote:

> Infer the FIFO size from the compatible, where all the instances of the
> SPI IP have the same FIFO size. This way we no longer depend on the SPI
> alias from the device tree to select the FIFO size, thus we remove the
> dependency of the driver on the SPI alias.

>  static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
> -	.fifo_lvl_mask	= { 0x7f },
> +	.fifosize	= 64,
>  	.rx_lvl_offset	= 13,
>  	.tx_st_done	= 21,
>  	.clk_div	= 2,

I'm having real trouble associating the changelog with the change here.
This appears to be changing from specifying the mask for the FIFO level
register to specifying the size of the FIFO and unrelated to anything to
do with looking things up from the compatible?

--HgRtS/XEVb/749Yx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWyl8gACgkQJNaLcl1U
h9DTfwf9EPYILffoosYlL9u/einpypgWGHhqhCvASqvmgmec/OFieX6W9rE9756V
qRQKkCsaD16mHJUSvJSqEf4qwoAXGf/57d03e5ShnK7nF8eUh+gsG2nz8b2mDmIr
2M6foetkCRim5eV4rNmsqxW8Ce+6EWrJX4y9BqxJNbxaACxa9fO9fIHAF+jnUOdU
/Bw/4aK99kPkW8PHMsg3vpuHxzbzak0aiYvMTHVZcp8Paan0hz3KYvI6xHLllNL0
ukoQMrnHrpOKy3ftVmNDXeefDuE0sOHQinzQsIEuIXqiRE2XKyJ+yXII+RaZ2o1b
v87fTDNtaYqs9bH0jweNhcv62vHu1A==
=qAfe
-----END PGP SIGNATURE-----

--HgRtS/XEVb/749Yx--

