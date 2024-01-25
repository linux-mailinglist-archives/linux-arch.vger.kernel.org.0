Return-Path: <linux-arch+bounces-1662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9A83CA1A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1161F22FE4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEEC130E52;
	Thu, 25 Jan 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go2dKEWQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B779C7;
	Thu, 25 Jan 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204008; cv=none; b=INONAFk/9Dx4sBtmZj3cBSxH4bQyCafyCq3Vz8BF1At+1+QpBfVLVIUpGXFQFNrMYkq2GdGivQdM0Bnw0OxirUDCuidcAoVYXm1majOt6rH3FYyzrdY9IKgo7SrSj+dezCYKSmoQFGLxTqaVuXpg3U7fSwzALHpawPrha63PEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204008; c=relaxed/simple;
	bh=PVZwAr4x9ILJrtMvklP443EpmlmJp4NX/vWU2AqygLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEYx9xxbHjBXN7wResllLHVyKRq71h1oygrs0bxRa5Fn0JNQYKo/+VZiPddwvSJ0m98XqGhAbJgfjkk6w4OC3fL/9DIPMGs3J3Bvg+Ebce0MX7mIfca8zkwT9GShUj3Mai158k0LcAeMkgclRB+IKdR5JMCi8Ic7GmXpAuHN8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go2dKEWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91746C433C7;
	Thu, 25 Jan 2024 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204008;
	bh=PVZwAr4x9ILJrtMvklP443EpmlmJp4NX/vWU2AqygLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Go2dKEWQs5mwFFcm1BOqA6K2e9K0sBlH9kwsN83edz9L010qC3ixe7Dca8PVG0DZi
	 1gCI0QlpFq5StdzgDGAnj2pVAoU9EzOQNwd6ja/+w+wiMW6V7bi1ABJwZ3VAig+9il
	 sheq4XFRAm6nJpPOsf21Y1RZXmCLJ53gEu0ldNAOyldiBtRhCjOA5Q5bkG8pnnL5W6
	 +ly37cPlYAJi4ct0iouKkixWXKVx0b5zl9jVDuThrbsdnhKaUNBry1FWJaTxVciFrs
	 tqunZU1jE4BPVZjRM7+Vl+OeYo0vJJUdufDEOCt6Qb0z7/n00AzTLsr+16vyc8AAa9
	 5qi9gUnqEir7w==
Date: Thu, 25 Jan 2024 17:33:21 +0000
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
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
Message-ID: <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b/vTOCJnB2w1PQdF"
Content-Disposition: inline
In-Reply-To: <20240125145007.748295-24-tudor.ambarus@linaro.org>
X-Cookie: Entropy isn't what it used to be.


--b/vTOCJnB2w1PQdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:

> Allow SoCs that have multiple instances of the SPI IP with different
> FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
> device tree property. With this we can break the dependency between the
> SPI alias, the fifo_lvl_mask and the FIFO size.

OK, so we do actually have SoCs with multiple instances of the IP with
different FIFO depths (and who knows what else other differences)?

--b/vTOCJnB2w1PQdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWym2AACgkQJNaLcl1U
h9C4jwf8DgPs3fIGNMrQv7ggtqmY0mUIm6dMIak+pCE454Ik0GV7lwoEO912QoMc
OezsS9qmJnObR7g5p6OefpAmI/+EzuWrGR+6Q+xji1Nre9/rTmGOILA24LfpLCM/
w5UePna2yEblcnTFQookxrZE2D6FSf3Hr2IzNct7NFjYyGwoXeJmEq6rxK9dKour
ieXlK0y42vAz0S419JlaYC4JuaOAP/gQZPOPMIYvv8t/aYZO95EQQhCc58SxUL8h
3TDEOnNSKt1wUkVGk6ac+/61YwUhRFCjqAARxPPYY0fVLO0YqHcbPM5V8FQ3DxGD
SvWk5NKRBb1Q31ei9bynMQdxc9HYqA==
=+ytp
-----END PGP SIGNATURE-----

--b/vTOCJnB2w1PQdF--

