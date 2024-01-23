Return-Path: <linux-arch+bounces-1494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16E839BA4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C911C243CC
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE074E1CD;
	Tue, 23 Jan 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBtaPSbI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFB33CC6;
	Tue, 23 Jan 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047210; cv=none; b=k01eF5cFMw8pmYggI2dOU8TCvmLzC2lGaZqP40xEo7wPY+NPS3XC6Mz6g3nCdWbnyE3pKev2opwqqYfxEmVGlbETDDkv6+ZC1Om2sJqf7yScIJHKMdRfDkzANfIR3cC+90zqXQhNrEAI9Q+LqgcediIy6iyhluNGLoq83RXQdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047210; c=relaxed/simple;
	bh=g2mYLhCDrXzCdeaeoBJ2c7RtSg3dAXTbQLawvcW29iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLGaY9MqsKhezsMO/D8ZZMhYJdBEuflmnfUDzQBjNb6OCClJbKWnwKdehUrP4jNfSjVf33qc32qxux8ZiAX9WgmyE21+xUZnlhflgbF1cEqE1EMOuZCyOlaOmngjjLbYfMYr804juCeD8IgM460UHIdRFeyFZ7jD14eCD6QXhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBtaPSbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CAAC43390;
	Tue, 23 Jan 2024 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706047209;
	bh=g2mYLhCDrXzCdeaeoBJ2c7RtSg3dAXTbQLawvcW29iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBtaPSbIFKwjzvp3mBYifFfVsYLOkNMj0pCayo56rJ/qBbxxLf6kowWPkwyKA/eVw
	 lfmBEF5vpF6IhvAJYgLi74jGoRPGYml5YGQuzcZW2PxGqahb/oOrDL+5Nw+sLPDbSk
	 mjN9h8DxSOXK8RdDF6XvsLXkYug9IkLLyjyYCI1Wdg+oSm2zUhAshVTBypDnV8xd6w
	 QrIK60Ub2GACqOA/QimaYOzeGDlUZ5M0WxwUiT7yEPoPzpzmD+Dc8vExh3hDJ+YnIN
	 DYsuW/XZosg/ym/1KUMC1i/jtEz3AnPuqG8WQjMX0sxiIOHrO9R2j+hOkdGpWrFanl
	 EhbufKPbNWEMQ==
Date: Tue, 23 Jan 2024 23:00:03 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, semen.protsenko@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH 01/21] spi: dt-bindings: samsung: add google,gs101-spi
 compatible
Message-ID: <xk2gauu2putvc3fs2sap7t7kcmupfnsuxvrbcfve237w4sw2mg@tf4g3cbwhro5>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153421.715951-2-tudor.ambarus@linaro.org>

Hi Tudor,

On Tue, Jan 23, 2024 at 03:34:00PM +0000, Tudor Ambarus wrote:
> Add "google,gs101-spi" dedicated compatible for representing SPI of
> Google GS101 SoC.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

