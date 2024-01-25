Return-Path: <linux-arch+bounces-1683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68F83CD2C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BFC29A8BE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B7136678;
	Thu, 25 Jan 2024 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJdMDinM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096F136642
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213392; cv=none; b=XeaI7EjFSdw3chRijEaa+lBRdeF2PgYnmWB7NUSKshpOUrUHGDgKU8qB0qmuyjAGK2Aas3FA3F6hymQTZ6QDWTy7FWW/hK45GllHNyVXI7sEIRgUuMYgD+ugFNTwrO16+5t+Y0jb/PHlE/lN1Cmxh66/XPkyfgKcRQnXoL8Arks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213392; c=relaxed/simple;
	bh=5cGXXrKqoeukbgGo952DirLmJH1RR6DCQpuh+hev/sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW01uuv2S/Q58AySIXMwjENOHC2GY232irR5swjWxHwas/bVoU0SmMjgaboOA0xZH/+GEZNiUlsR5Y5Et9sn2vaB/37iJndgConbzMo/dhJDIBnfNB4l/d96lrwOx9HWFxvqbU0HT8esxD1eCb1A4aHxKRJFzY0dWnGbVVRsHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJdMDinM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7232dcb3eso37258635ad.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706213389; x=1706818189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHqHxLkb1hywzmJ0hKTje+e39G/rmk5dGXSZnkMYEhE=;
        b=qJdMDinM3IuWioDPkNuITqxm8r9qzXzSG/k/6c0L4LuzpnHobxuaBqWeOvfbypu5bm
         OgIDmgcieYx84yW06eOymPr/dcIJ5QKEmqD1XBOpi9/KWMMUW44hkRR3AweMYX3/jtT9
         jpRKIuWaiKDdBTdg8aGgD00fAplrQIHEr52FRx7bmbe+2Xo6peOq3+GFL8SMUzmRD1po
         c8wDkzvp+rnsQtX//a1abgCiYmRRDKHg8JhsbFMx1pNeSMgYspRKrG5TcWF/2ZEzDNn6
         j5TXhD02JOOM0hXRyMOSOITrwQgyRI0N9AQYkGQi/bLCI9hDloR9LSDnoeFAYpRlTx7Y
         IYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213389; x=1706818189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHqHxLkb1hywzmJ0hKTje+e39G/rmk5dGXSZnkMYEhE=;
        b=ceVhm0aZpKkZ5i9zMis28vOemSizLK6PRcv6v5UeWU4LU9PcVGWc6SoW5IGmcL4Oi6
         mn/reo3cCd/B/orH4lyDvZsntWsqbc8iUnYauzl1wuuxwusIupjvp33tSslzsQy9sd3Q
         Xo4Mny/kP9pvlcqLB3SkdXL4wgTFzv1oILu829yguGd4uRAuG8zxfqf51BZrEYLfhZ+d
         OTJ7iLuOboBnOPl9vppMfRVBi0q2ZPdvoRd7OUjXmMHnoFB+0sOMvOv279Pyni9z2C7Z
         PdyiBSN2wQeTkheSUdWiUh32YS1opM5yFZMsNx085ntNyXVbsXI23n8J0LUB/uDh4OFv
         KY0w==
X-Gm-Message-State: AOJu0YwjWeIj73sLGldQzERoRwTUHX2OXpoN4BCKav7Rn4KrV1blXueC
	PUA0gP2RJeA0TAtiwrVmzYwvQ0hO5B9FqL+LHdjntsvtjsZLihAYJRD1DtdmMs9IsxaSGF/jNON
	FzvjmKKdpmjqv7S28G6hlWNF9M4l4gNBJVpG1+g==
X-Google-Smtp-Source: AGHT+IHVeildWvfGHdKxmcDztlboMhXAQHuVimKBzuEogXpGOXLpSYCQSwzr07F2VAol84VlLD5pI17OluDfry1agk8=
X-Received: by 2002:a17:903:2346:b0:1d7:3ad7:f24c with SMTP id
 c6-20020a170903234600b001d73ad7f24cmr239302plh.36.1706213388907; Thu, 25 Jan
 2024 12:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-12-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-12-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:09:37 -0600
Message-ID: <CAPLW+4=je3wEL_5YwvrRJmPcTDvo7=9maMWcs_WNaA2Bz6bTgg@mail.gmail.com>
Subject: Re: [PATCH v2 11/28] spi: s3c64xx: move common code outside if else
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
> Move common code outside if else to avoid code duplication.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b048e81e6207..107b4200ab00 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -286,20 +286,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data =
*dma,
>         if (dma->direction =3D=3D DMA_DEV_TO_MEM) {
>                 sdd =3D container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, rx_dma);
> -               config.direction =3D dma->direction;
>                 config.src_addr =3D sdd->sfr_start + S3C64XX_SPI_RX_DATA;
>                 config.src_addr_width =3D sdd->cur_bpw / 8;
>                 config.src_maxburst =3D 1;
> -               dmaengine_slave_config(dma->ch, &config);
>         } else {
>                 sdd =3D container_of((void *)dma,
>                         struct s3c64xx_spi_driver_data, tx_dma);
> -               config.direction =3D dma->direction;
>                 config.dst_addr =3D sdd->sfr_start + S3C64XX_SPI_TX_DATA;
>                 config.dst_addr_width =3D sdd->cur_bpw / 8;
>                 config.dst_maxburst =3D 1;
> -               dmaengine_slave_config(dma->ch, &config);
>         }
> +       config.direction =3D dma->direction;
> +       dmaengine_slave_config(dma->ch, &config);
>
>         desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>                                        dma->direction, DMA_PREP_INTERRUPT=
);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

