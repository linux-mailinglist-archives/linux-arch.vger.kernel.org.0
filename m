Return-Path: <linux-arch+bounces-1665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165283CA43
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37F61C239E0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B82131E5E;
	Thu, 25 Jan 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWw+roBd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD06763407;
	Thu, 25 Jan 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204763; cv=none; b=bZz2YJ5cRkjUdnHy2QZJ34qTtf+5bLsopwQZH1Wky4e++k6Z1AwLnELPryOCdKdcWSGY4sNIV5rU9xplhCDRX1nOk/AYKXvHHGSkFLeZBhLIs8Ls+ShvaUcTtvLwlfaAROh/joV8cF12kswTcpCKn+fhcHhH8Y+6mqAOfTLavtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204763; c=relaxed/simple;
	bh=tIFbUb7rvCJU+XmIHpQfyisWg75JMCe5OtoA5r51LVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgNITTD6syVZt14eikPMEgiuGkTfTNBBP1nF3A956Ussd9Pm9LiNa6Glk0atkTnhrqc3VPEuYynXKFL1xTi2y0UHrd7lw0c92gci7RQE+QESsqU56BnqbP4XhznXE0dj7eQ/CKI0Q52z5e2+yrFkE3hcm/WyEz0Pl/ncGc24g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWw+roBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13E2C433F1;
	Thu, 25 Jan 2024 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204763;
	bh=tIFbUb7rvCJU+XmIHpQfyisWg75JMCe5OtoA5r51LVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWw+roBdU0finNlhvvQnyaImkPJwwEZkqiVd9reBwsFM9ViXSuZ5ALCrMfQwqT3St
	 Seq+6cKY6hw1LtbUniJFQ1iuERJtlPEqoD0votinHp5LoYivNdfEuruoYD4sADkAqk
	 m32XQ5cBWr10dMSGy8TsOY4itOuMVFyzAEHYCe/IA2/Q0Q2WgIb3VOlmwe1xqsc7Qt
	 7IskTrDaeD5DmDOELhgLNedaB28xC3/PFxXDQcAbHTYgISfChcgOGKT8XvFiaNzt7l
	 DIw5xCLyGvi2eIRq0r64omTAArm4KpXBPT6NwE7kfz3TR1jJDkrhhHgdbWwntDBazk
	 GFKK/96H8vsZQ==
Date: Thu, 25 Jan 2024 17:45:56 +0000
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
Message-ID: <f44d5c58-234d-45ec-8027-47df079e2f16@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
 <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
 <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
 <55af5d4a-7bc9-4ae7-88c5-5acae4666450@sirena.org.uk>
 <f2ec664b-cd67-4cae-9c0d-5a435c72f121@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JpqJhr1HaxPy2/jb"
Content-Disposition: inline
In-Reply-To: <f2ec664b-cd67-4cae-9c0d-5a435c72f121@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--JpqJhr1HaxPy2/jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 05:30:53PM +0000, Tudor Ambarus wrote:
> On 1/25/24 17:26, Mark Brown wrote:

> > OK, so just the compatible is enough information then?

> For gs101, yes. All the gs101 SPI instances are configured with 64 bytes
> FIFO depths. So instead of specifying the FIFO depth for each SPI node,
> we can infer the FIFO depth from the compatible.

But this is needed for other SoCs?  This change is scattered through a
very large series which does multiple things so it's a bit difficult to
follow what's going on here.

--JpqJhr1HaxPy2/jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWynlMACgkQJNaLcl1U
h9AWIgf/VcfD5zzA5FHst40J+FzkclKI9H7PqSMKnPOfL023kNx0ic5o8lhp6YlO
q5Nxe4Iq/nOoCxKo5qN0BP/CWFfOU4A4vbNjunU9tLwZiQYRHFW++SCGe+9XrJas
vfuD1FLLHxE3Dj7Nmgn3iCfTHI0bSI6VKwFo6ZTgAB3FFKBNaioYcXqzKv203oDj
ZtCHAZvr8W2VOZN05F4WwoFZNBPhI8Kyfu7UJxMGgaJnFj1GCH6C9tNCHPB38gxs
5rlXg38mhQaL+awPUyOoL3R4wRkdCBPGsvLUBP6cxqrzF0kn5fgY27SM7zYkju/8
jvw863iKejvXy0T+c+VwdoXIaRbyig==
=33yx
-----END PGP SIGNATURE-----

--JpqJhr1HaxPy2/jb--

