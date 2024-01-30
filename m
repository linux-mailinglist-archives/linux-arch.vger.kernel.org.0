Return-Path: <linux-arch+bounces-1868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A2842FA0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA191C23B31
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AB7BAF2;
	Tue, 30 Jan 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO00VUs/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25E7BAE9;
	Tue, 30 Jan 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653539; cv=none; b=qMSIlZ27qWQ+WtMu/Hex9FeITmTShIJ4LpN3yIPZYK91OIwITd3ObwlHzT3i6wRqrQb+oonbd10JFv0ufMpp3X1/m3h2C5OCDZJFKotlNGAHMktS+FqP8squECtL6s796W8CsnJlPv9bdIU2VrCnYGO83iB0w/BJpkFlx8LPn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653539; c=relaxed/simple;
	bh=rti7mztnsIyooNfSUewv1B47KEAqojy4aPd6GMveyvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb1BM/xoYIqevLnkece06GMYHEEUFAFne5IyI2VUmrvhdGL+bnDjeBaABIWZK6XU3Tof0ueUaMMoTco6Npph1AXMXeZ7sqOKURlIi8jBhs89hJhLets3FqjUR2se2ruWU/rOTEPm2GyrfeDAUJspDL/4GTmQ6duQLmUcr0bRVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO00VUs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7FC433C7;
	Tue, 30 Jan 2024 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706653539;
	bh=rti7mztnsIyooNfSUewv1B47KEAqojy4aPd6GMveyvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fO00VUs/gI+wGkwjc7jhpJr7obyerwaweKgya4sJydDpMHVoKb7EhVRPXdC5Q1f6i
	 fECcU0vEJBELW/NhZlaWocrbjP2U+uEJ6kRlcGBDfN3ZMvHYVFhekB4wM+dJwNh0Xm
	 IaXlGii3VZFl0y0R7Wj3oybOq+r1VVjafJxEUSmY//0/z1JmrsMxAl+kiyRzAH3Jm3
	 yICd5+m5x5mjfZU2/x1SdI1nRrPz3GTTU6kJDSxD8m1/Xu/Cs8HrQqGaAKx35AFxEn
	 5LnX51uzCTqXHb0fC5XueWQiBwc5pBL4R8b43w8B5M0bh0vqHS6FTZ1dnRqqvwmDZI
	 lQ7knF2lwQMFA==
Date: Tue, 30 Jan 2024 16:25:36 -0600
From: Rob Herring <robh@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andi.shyti@kernel.org, arnd@arndb.de,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, semen.protsenko@linaro.org,
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH v2 05/28] spi: dt-bindings: samsung: add
 samsung,spi-fifosize property
Message-ID: <20240130222536.GA2523173-robh@kernel.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
 <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
 <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
 <55af5d4a-7bc9-4ae7-88c5-5acae4666450@sirena.org.uk>
 <f2ec664b-cd67-4cae-9c0d-5a435c72f121@linaro.org>
 <f44d5c58-234d-45ec-8027-47df079e2f16@sirena.org.uk>
 <96f9306f-3445-484b-bd3c-82e708681f1b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f9306f-3445-484b-bd3c-82e708681f1b@linaro.org>

On Thu, Jan 25, 2024 at 07:01:10PM +0000, Tudor Ambarus wrote:
> 
> 
> On 1/25/24 17:45, Mark Brown wrote:
> > On Thu, Jan 25, 2024 at 05:30:53PM +0000, Tudor Ambarus wrote:
> >> On 1/25/24 17:26, Mark Brown wrote:
> > 
> >>> OK, so just the compatible is enough information then?
> > 
> >> For gs101, yes. All the gs101 SPI instances are configured with 64 bytes
> >> FIFO depths. So instead of specifying the FIFO depth for each SPI node,
> >> we can infer the FIFO depth from the compatible.
> > 
> > But this is needed for other SoCs?  This change is scattered through a
> 
> There are SoCs that have multiple instances of the SPI IP, and they
> configure them with different FIFO depths. See
> "samsung,exynosautov9-spi" for example: SPI0, SPI1, and SPI6 are
> configured by the SoC to use 256 bytes FIFO depths, while all the other
> 8 SPI instances use 64 bytes FIFOs. I tried to explain the entire logic
> of the series in another reply, see it here:
> https://lore.kernel.org/linux-arm-kernel/40ba9481-4aea-4a72-87bd-c2db319be069@linaro.org/T/#u

We have some common properties for fifo size. In fact, there was just a 
discussion recently on Samsung UART (Is that the same block?) about 
this. So if you do use a property here, use a common one.

Rob

