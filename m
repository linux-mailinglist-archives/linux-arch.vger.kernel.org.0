Return-Path: <linux-arch+bounces-1499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B521E839C34
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E794A1C25B78
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6994F898;
	Tue, 23 Jan 2024 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/N6EVbM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC4F5F1;
	Tue, 23 Jan 2024 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048916; cv=none; b=rHYYsym7dxYxbxnftq6vSPN7/Qfr2bhZtvaM80ow8y8Mx8oXXAYWACGTPJGMSNyoOfZtBSylXFUQ7P2k5VwrrA6QHqGCafGcT2xOt/Gf9KE94ddj4jnzlnQhyaENuFWrDR/anw9A8/YVdUVS/FMF3eXGeaJGdEbbpru7+CTAFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048916; c=relaxed/simple;
	bh=IPHv2YfYkfmYLot0yZztwzocDHzmq0+f6ykTs17fR2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3jsIgEw9wLdjL+3v82fTgYpFDtdS4GXxrifjQSjRZWAro57lEjsWcD9W8jDK/ZcAxxhQXQUSULoF+fptXx1O1y0T4BO0oi5J9hKZaPG0scGntg2CZ1zR7SnJjKqoMDzuOiAxOEbPUqeSrTZGUk7s6oxxfNoAuHsE12/fSbZVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/N6EVbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AC7C433C7;
	Tue, 23 Jan 2024 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706048916;
	bh=IPHv2YfYkfmYLot0yZztwzocDHzmq0+f6ykTs17fR2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/N6EVbMr0iHCLnt2PEzxPYOfIhOlsokVA8D5Dgo1RLlHiC2jWBt26LPbB9kmsyJs
	 OWVfdWVabecfUYsbVvppcSrbQMxMIY5JDQXnENCh5gn1H9TUaUk2EBkC0PIhiskQXh
	 otNl/CEm02DyAexYq4ANrlVLhH88BAxp4WKwkZryEhkdsQoAkTDFVCamtIKAV6cVgs
	 /W2N8d8GDtFyLimfbhf+HV8iNWr2fw+CDI7r2tUWxXwbPIt2rhyynyVcfFZ0uvPHr6
	 bsKdGgDoDdoS6y9tcEThF6d8vYYb/uOmx7k6l6MsYAlvafKgq9EKUb1DMz1vqQUY1w
	 kfhqms6lioLeg==
Date: Tue, 23 Jan 2024 23:28:31 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 05/21] spi: s3c64xx: explicitly include <linux/bits.h>
Message-ID: <kmijvv53j67l6lgndgrybj6iaup6pyrvzklkre6th4rcnrsrqo@ie5ji4nutbcd>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-6-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-6-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:04PM +0000, Tudor Ambarus wrote:
> The driver uses GENMASK() but does not include <linux/bits.h>.
> Include the missing header, we shall aim to have the drivers self
> contained.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b350e70fd179..9ce56aa792ed 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -3,6 +3,7 @@
>  // Copyright (c) 2009 Samsung Electronics Co., Ltd.
>  //      Jaswinder Singh <jassi.brar@samsung.com>
>  
> +#include <linux/bits.h>

I don't see why this should be included. Are there cases when
not having bits.h produces any compilation error?

Andi

>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

