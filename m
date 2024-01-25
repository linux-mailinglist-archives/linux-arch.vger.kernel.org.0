Return-Path: <linux-arch+bounces-1686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E1A83CD60
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F6E295C7F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC0137C31;
	Thu, 25 Jan 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nwwzl74i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F613667B
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214311; cv=none; b=mQSTJ/eW9k5kS1WVCM6WspxgkDw6zEpD+KvgRMJqZm/p6bluGVrLEfFx+dwCCkorOegs2PhXTOIUuY9ACAqEblQbUr3Kh24ZhOOuc40BZuVafIdIEogegCHmSOO03kFHRlb+1Az+0Bg0UEsJpV04inOBJ/44TlJE127q+Y48iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214311; c=relaxed/simple;
	bh=QMJU6URIKYk7AaGLODC/jjsXVBRijeTjUJ1oKlfR3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tdfis8/TP4hgcjNCeuxpTkx0lHzphN9quMm03Wtba74t4b1v9So5Hyt9amotRIkhQbz6ReclceiWMcsj9iWdNSYqHSXqqoZrk5jf9eVvR0KG+Gt9u3YGqZWYJ0dyeq76l1t1tdgjWo6noR2JUU54+gIPJsFIMVvGUYXkokyug8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nwwzl74i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29394f12d0dso177097a91.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 12:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706214309; x=1706819109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaxY27IhcgcbXrkepc9FHJUpKGy9Xey/yg5kDXIpb4c=;
        b=Nwwzl74iro5zwk39uZkmov2Yr/LqZAcpWwNekYaJQUGVdBooQGCVBmK+vWPC+4mFFt
         xI1x947Om8quaTCo9k/SCYiNv59wP3XYglvLvLpTp6SE7+M0l5Qz0H4wq5TbCzlLj0Lz
         jK9B1chfg++uVyA6OlCuQp+jS57s2MYhdMsRhLbm8lO1F0u2RTYpNIHvi10x7vE726tc
         a9VLuImINMgC4x/E6CDcX8mWD3Onfj5nkfwmGeQAtUkNo3XbFrGOgBwrHuzz6SvSOr1t
         hbPdKQIkMpbqqo8YpLR4/W8g5g5TX6RVuFPjlN5wvYeJmrYTsnTOOIfWg/kzYezBUteG
         nE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214309; x=1706819109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaxY27IhcgcbXrkepc9FHJUpKGy9Xey/yg5kDXIpb4c=;
        b=RxmzAacBmlpSQ6/HGs7ekHY2EsSn/IZ5YKEl/NYT7e8DOjzcbE9b+h8YRRJntbhKr/
         lZhIEuppX4mquV5UaQzIQDXPPZE0/mrlzvuaX9QxmIYssJIlEGoksb60+rmfS9uDPfB+
         an5CqSQ96O2VlX/njkXQZYIuJ1+zfcOE9byCMdoSjyrNgOYo/T4Py+YRYqat0qJE+fpV
         Zd/rX7TBkQDG+jC6Q+5QeP/5z3E3kBq3Sq83gEEzjw1hxhMt/wAapz4vSvwmuCNZkiOy
         Uy0gVOct6m03YtxFQxFwkfxU3RW0mjY+jPBdnaAhffnnNX3RN1Yy8K5TWkmZ0ywdA580
         ubHw==
X-Gm-Message-State: AOJu0Yy338rYt5QNZk0WKlgwphrrkj6eEqnIDQ7r6OwthuXqhqs/z6+S
	K09WGdx5lEOBUcegHV4cNUcT09yZQhoZ9I1YLqTgmHTwgKDDeyl+ItiF+tdPyx26eU3fWWgY16B
	pzT3HOLtUav8nVPMvOd6Iyf10wEvju18+lp5hhg==
X-Google-Smtp-Source: AGHT+IFb6esBMXgIN6eJVdeTHuH7VuUDww4b7lmtscjFNG2s6JBRpL/mLqpy1bnm9qR62+/gT5NooL9ZgsRZaHpDQbA=
X-Received: by 2002:a17:90a:c503:b0:28b:2f4f:75e7 with SMTP id
 k3-20020a17090ac50300b0028b2f4f75e7mr163034pjt.13.1706214309739; Thu, 25 Jan
 2024 12:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-15-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-15-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:24:58 -0600
Message-ID: <CAPLW+4k8FvdnMmN-7CbvFG2matiKwDBDT_LM++O5HpnmctHnSw@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Don't monopolize the name. Prepend the driver prefix to the function
> name.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 25d642f99278..447320788697 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -273,8 +273,8 @@ static void s3c64xx_spi_dmacb(void *data)
>         spin_unlock_irqrestore(&sdd->lock, flags);
>  }
>
> -static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
> -                       struct sg_table *sgt)
> +static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
> +                              struct sg_table *sgt)
>  {
>         struct s3c64xx_spi_driver_data *sdd;
>         struct dma_slave_config config;
> @@ -440,7 +440,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi=
_driver_data *sdd,
>                 chcfg |=3D S3C64XX_SPI_CH_TXCH_ON;
>                 if (dma_mode) {
>                         modecfg |=3D S3C64XX_SPI_MODE_TXDMA_ON;
> -                       ret =3D prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
> +                       ret =3D s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->=
tx_sg);
>                 } else {
>                         switch (sdd->cur_bpw) {
>                         case 32:
> @@ -472,7 +472,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi=
_driver_data *sdd,
>                         writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
>                                         | S3C64XX_SPI_PACKET_CNT_EN,
>                                         regs + S3C64XX_SPI_PACKET_CNT);
> -                       ret =3D prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
> +                       ret =3D s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->=
rx_sg);
>                 }
>         }
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

