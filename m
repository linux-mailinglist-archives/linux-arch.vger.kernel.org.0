Return-Path: <linux-arch+bounces-1692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABE83CDB7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE357B21B4C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69B137C31;
	Thu, 25 Jan 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPrPCEg4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671F131E40
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215534; cv=none; b=Fywqge7vMezftF9yqi4L6VY9Jnz/I30XhdHdpxQ+ChqXbI/inMkRM96R2tCeTS2qTB7XxWCltRt9Zpk6jEL9MT5KDqn44VqSI/o/PY+eVRUtV1A/8d9H0R8yEjL39OG5bdePpJg16BWeQldMo1muiadIfGYoJ/V9q5dq4t+fQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215534; c=relaxed/simple;
	bh=u4m3rhslZrR5Hsot++6wdzU0ej58tjNpwhODKsqQKLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIoqaByq9tJe+lIi0N1FwOgQXneNwYE/Q/OBRDMrkeJ1MT7MzjO3lFcp03urRlL/Jel957h93mvJvFgM+AjSdiTvk2Z5ir/ZoHdYAK9Naal6W6o7HaiTDUutZTy1AmwFb4jNd3l/XKZwQQ6Cl2CIWRwUceh6HnGA6MjlBdpZjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPrPCEg4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290449c30d4so3321419a91.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706215532; x=1706820332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjdvfWOMZIbIKqDPk6c3LehvDX9fVj7yu1ffjzs1Y4w=;
        b=oPrPCEg49l26MN0w4JTS7mulcbHu3czWBt/DEPdZz4u7jJZTrUcTNgU/6cgGTaN3bw
         T8bymBfZqrLedtX42si++VVzS0pA2fIxQHz29gfHuqOXEhPmCnAPojItVhRrpWkscn/Y
         C/E/v5DRWFAODZXkEwUNAqnNqnSw3P8iBZHYqfIgPZ7t77FMSj3f3NxCelhiLJIjWtjn
         VDQS9+ZyNTsby7YkTFAG68yObCiBCR5nTNM4GMrvhO1vMCkQjb0Y3ewa0MqqO1kSrxr+
         IM6YQEfGjj5reuKQafnSkUkZc2E0dqAs/L4+Jj/zJ/MKquO3LsCQi7fPGs3gPMNcw7Am
         YUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215532; x=1706820332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjdvfWOMZIbIKqDPk6c3LehvDX9fVj7yu1ffjzs1Y4w=;
        b=U4vu5WNdpuPFwkGDNni5iU1idQUnJ13zNhhM5yh2XC8YX5/Er2rpcJ3mL7a6iYReYv
         pSNrPNy7dwm4o5z6nX/qhJ+U0Y5bF6DcsqzMRMh65+5AYdAxtoP3UTNXlHc8BnQH8PFK
         yQBGHpJFH4Do+GlYHfOWu6QxTT/hVKzM6AMGU090pWz9tfbnPb6a9Xsa0w0dgs2xsOx1
         sRSe9R7CurD8WNZAD7OtXFz2OLXW6vNJWHUtfYyW9kmZqmjeT21gGXlStDRWYOgkDqJ3
         a4Xz4cUdjyvsUaCijw1Ps4Gn6WfYuqFvBw/wXKoelRrY1hohAmNONJsY2WZe0A6EWmnW
         KpHw==
X-Gm-Message-State: AOJu0YzOicvRVApFFbwW3eecdqQLCnJCjIsjO9VlkbXhEqCLnJQ8ZZ4f
	Oavghi3rTdERsdc49A39OaFTtmTJX2t24/pGKluT5+HCjsP+mvUhyYu83+zlWripnX6BRtWA4sh
	YYr01xDJl/WQbmp53nCFH3K6NH6Hlz+C1ruSdpw==
X-Google-Smtp-Source: AGHT+IFofqibqxuDjtddSx6QluMZVRpw+2AXJrlPUc7U34sNPQ9cpNct34ReKCCPsxw5hwiOFV0+l3LKSUbE88X6ZwI=
X-Received: by 2002:a17:90a:1a08:b0:292:6b51:6bb with SMTP id
 8-20020a17090a1a0800b002926b5106bbmr262488pjk.0.1706215532174; Thu, 25 Jan
 2024 12:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-28-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-28-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:45:21 -0600
Message-ID: <CAPLW+4kTDxvRuCvg8TO8QFQiTUfrvzEavX=Cx2QVRZ=SnRLrOg@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] spi: s3c64xx: add support for google,gs101-spi
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
> Add support for GS101 SPI. All the SPI nodes on GS101 have 64 bytes
> FIFOs, infer the FIFO size from the compatible. GS101 allows just 32bit
> register accesses, otherwise a Serror Interrupt is raised. Do the write
> reg accesses in 32 bits.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 35a2d5554dfd..e887be6955a0 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1501,6 +1501,18 @@ static const struct s3c64xx_spi_port_config exynos=
autov9_spi_port_config =3D {
>         .quirks         =3D S3C64XX_SPI_QUIRK_CS_AUTO,
>  };
>
> +static const struct s3c64xx_spi_port_config gs101_spi_port_config =3D {
> +       .fifosize       =3D 64,
> +       .rx_lvl_offset  =3D 15,
> +       .tx_st_done     =3D 25,
> +       .clk_div        =3D 4,
> +       .high_speed     =3D true,
> +       .clk_from_cmu   =3D true,
> +       .has_loopback   =3D true,
> +       .use_32bit_io   =3D true,
> +       .quirks         =3D S3C64XX_SPI_QUIRK_CS_AUTO,
> +};
> +
>  static const struct s3c64xx_spi_port_config fsd_spi_port_config =3D {
>         .fifosize       =3D 64,
>         .rx_lvl_offset  =3D 15,
> @@ -1556,6 +1568,10 @@ static const struct of_device_id s3c64xx_spi_dt_ma=
tch[] =3D {
>                 .compatible =3D "samsung,exynosautov9-spi",
>                 .data =3D &exynosautov9_spi_port_config,
>         },
> +       {

As I mentioned before, this braces style looks too bloated to me.
Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +               .compatible =3D "google,gs101-spi",
> +               .data =3D &gs101_spi_port_config,
> +       },
>         {
>                 .compatible =3D "tesla,fsd-spi",
>                 .data =3D &fsd_spi_port_config,
> --
> 2.43.0.429.g432eaa2c6b-goog
>

