Return-Path: <linux-arch+bounces-1703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFA83CF9F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 23:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595801C22DCB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFB111B5;
	Thu, 25 Jan 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUIlhYzO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DF67C45;
	Thu, 25 Jan 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223034; cv=none; b=dnI3Vk/FTCGReTia2v4y63bzXUr+dahB5U3aq9W//Nyp5yIoajSEpZeJbWMf2XvSUL4CAb6crqBiZ5fxbnNg0ySH5rfVR6UPm7/ICvvU/NVgVxLXE6EgVJIpEC4O8pCdwIYjDTdzvgpNXGcE9ayceebvtOTLyAmPPgrtX+AphLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223034; c=relaxed/simple;
	bh=HknESiBZP/3axcY3RqkHCvBDkhixmbUnM9EvB+nTOiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA/bk+c0NZ12gfmqNbuhPF+VUgQDu1I4bwrgAuD8x8VmJk3Vhqm32c3Mk/h3SKMGjv7jq1WUB8vqI4rkqV8RRRXBsEOR/7aZHWXctcQc3rIwXUSolYStV+suGQW9DW8LfS+qRKN6y82UY7f9pVLNdzk6ODjWOVADbA0sJZJ6LEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUIlhYzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B33C433C7;
	Thu, 25 Jan 2024 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706223034;
	bh=HknESiBZP/3axcY3RqkHCvBDkhixmbUnM9EvB+nTOiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUIlhYzO2hYjp0MgLM2dleVO+Zexpipxm/zy6F0Ssv6SQKHTR63fPuIvUpOuv4Kg5
	 1wODYS/7wZjSriL8kKkDa717tpBJ6IMMSTWSIFqjMBHp77+ZrRxHuiqxggS/kSdj+J
	 jU9DGMVCBx6e1ayVR5zER+mrG+JJz6hUnKVF0NaEjHHWZJbfmKkJmcPbi1Ohduv9rG
	 AHTNJ8PveLJyG72+YrrZiAWjnZdJ16u4d7xC5JQlTrRq3wpUjyPWyWb8pe+vA7WfgF
	 wYyJf4Ky0CoRd7Ax7/EbLIeZo8UA8/h0bbev9ADF29+bbgi7P85Gb97ucI6VmLf+vU
	 3R4A17ZQCo5iA==
Date: Thu, 25 Jan 2024 23:50:27 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 07/21] spi: s3c64xx: use bitfield access macros
Message-ID: <ri7gerw4ov4jnmmkhtumhhtgfgxtr6kpsopdxjlx6fylbqznna@3qgvejyhjirw>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-8-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-8-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:06PM +0000, Tudor Ambarus wrote:
> Use the bitfield access macros in order to clean and to make the driver
> easier to read.

most of the changes done here are allignment. I would mention it
in the log.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

...

> -#define S3C64XX_SPI_CLKSEL_SRCMSK	(3<<9)
> -#define S3C64XX_SPI_CLKSEL_SRCSHFT	9
> -#define S3C64XX_SPI_ENCLK_ENABLE	(1<<8)
> -#define S3C64XX_SPI_PSR_MASK		0xff
> -
> -#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		(0<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	(1<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_WORD		(2<<29)
> -#define S3C64XX_SPI_MODE_CH_TSZ_MASK		(3<<29)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE		(0<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
> -#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
> +#define S3C64XX_SPI_CH_CFG			0x00
> +#define S3C64XX_SPI_CLK_CFG			0x04
> +#define S3C64XX_SPI_MODE_CFG			0x08
> +#define S3C64XX_SPI_CS_REG			0x0C
> +#define S3C64XX_SPI_INT_EN			0x10
> +#define S3C64XX_SPI_STATUS			0x14
> +#define S3C64XX_SPI_TX_DATA			0x18
> +#define S3C64XX_SPI_RX_DATA			0x1C
> +#define S3C64XX_SPI_PACKET_CNT			0x20
> +#define S3C64XX_SPI_PENDING_CLR			0x24
> +#define S3C64XX_SPI_SWAP_CFG			0x28
> +#define S3C64XX_SPI_FB_CLK			0x2C
> +
> +#define S3C64XX_SPI_CH_HS_EN			BIT(6)	/* High Speed Enable */
> +#define S3C64XX_SPI_CH_SW_RST			BIT(5)
> +#define S3C64XX_SPI_CH_SLAVE			BIT(4)
> +#define S3C64XX_SPI_CPOL_L			BIT(3)
> +#define S3C64XX_SPI_CPHA_B			BIT(2)
> +#define S3C64XX_SPI_CH_RXCH_ON			BIT(1)
> +#define S3C64XX_SPI_CH_TXCH_ON			BIT(0)
> +
> +#define S3C64XX_SPI_CLKSEL_SRCMSK		GENMASK(10, 9)
> +#define S3C64XX_SPI_ENCLK_ENABLE		BIT(8)
> +#define S3C64XX_SPI_PSR_MASK			GENMASK(15, 0)

I find it easier as 0xff to be honest, but I'm not going to be
picky.

> +
> +#define S3C64XX_SPI_MODE_CH_TSZ_MASK		GENMASK(30, 29)
> +#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		0
> +#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	1
> +#define S3C64XX_SPI_MODE_CH_TSZ_WORD		2

I personally find this pattern harder to read. Perhaps you can
already define these as FIELD_PREP here.

> +#define S3C64XX_SPI_MAX_TRAILCNT_MASK		GENMASK(28, 19)
> +#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		GENMASK(18, 17)

...

> -#define S3C64XX_SPI_FBCLK_MSK			(3<<0)
> +#define S3C64XX_SPI_FBCLK_MASK			GENMASK(1, 0)

0x3 to me is more understandable than (3<<0) and GENMASK(1, 0).
Bit operation defines should be used when they really simplify
the reading. But when they make it more difficult, then, I don't
see the point.

Overall looks good, though.

Andi

