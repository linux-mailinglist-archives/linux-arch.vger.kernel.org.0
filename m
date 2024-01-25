Return-Path: <linux-arch+bounces-1678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1D83CBD8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15681C20B98
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19E31350E6;
	Thu, 25 Jan 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaJP7JCo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074D134732
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209474; cv=none; b=lUVPMiefBoBSXEVw09bpqjB0OFwpMdPEG/Zkqb2W59iWaCJf7Nsv4JdkI6exz4Y5NRh+VwLrZhrFyOx4DGdlhUS6m8G8nCI34RM+IYcNGPBbjjWNuPaNWjokXilXqln+7to5SHsS3+Zj2C9d4L+HAl4nvgpkcWXOdyn/q0PboCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209474; c=relaxed/simple;
	bh=kyz7VN/4ZcUerMlxwf3NWPLVw11KuWBrkD6c9Je0eew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhJ5fq2dugX/0baDWnUdka+h49PSdXJTvzGy5TLo5Z2MIJMQA4u/wpQ9+4651dOcZOWzTAkKXMAqhVC1VDVk96lqyL2vIi/hjg+uRrY0vnFtIkgfp0xr7T1uWCv23QsHWCpRrTk4yArfH1rnYAiRuNo768XWCzperf3A97RGLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaJP7JCo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290b219a60cso3037172a91.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706209472; x=1706814272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmh1WjBejQi02ZPJBsuRfWlQ6TdlM/kcPPZwBwZbKTI=;
        b=ZaJP7JCoksK9xmxs3TW8E55u1+gmSRRj+9KhpQJVKrhQ3P0NKojfHvg8lYd1mID3Gt
         g827fEqPOuGOBCrIsQHuceUPTryDjcKkKPe3CI/+9N4kPOdW707osLI3qqMwPZK5zHNj
         cXhVGUaG1rRpoS//cZDP4cOr0GPh7QVs26tO3/gBjkXZG6IGsYcmb3OUkb8M+lgCWmrm
         0AAUgVDFlkCXE0pepJpkrtwMcMQSnZ2CbSkBlxUKOdT99WHreWI88Oei+aO/B4cMZTJB
         PIFrfITALKtsEg9JaJbw8MTEOhLGj/hy+tlRcTQlKReL/tZcBFGdLClbD8RAixPHPE7a
         oAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209472; x=1706814272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmh1WjBejQi02ZPJBsuRfWlQ6TdlM/kcPPZwBwZbKTI=;
        b=BLaWkEwn8uB9QF/bhsJYjwa3jBd6fj3hz0Mb0o0wsWLIuy2sjXnX3TSwAD8Vz63uca
         0JI7c2xR/0DJW7RxAYPXu9ClKocbXP5H/gYdJisqKzOb70+iH8ZfHtxUGqqPG/4gyobt
         x01we+DRa27606QKfkAvAaeRkoN6WU4qIIV4X8q64TX7daoJYO4EySnmxBLISssCXuG4
         ueL+ulfrRW6p2f3rL4ecyll0IJAnFbNdJkGfKbopijISOw5r5cH4AgRRjVguZkgbELg6
         vYYWkd4EVpfVII3VkO1LjxGgxCGIDGAjlom33jJDosOcR4IZe1XiJfCHT8TrxBQGCOKM
         ThAw==
X-Gm-Message-State: AOJu0YyoRBKOcs8+qZLC5DgH6BDpamIpRsY8cSn5pK81WnnjXXlui43X
	YG8HIAU5QvxToqRK/am2AR5tm5uvvZFauxyc2KH3/VW6zXNStDaRGdO17RWg1Sckeyjy5NVTajh
	8mV0foQW9jQJS8VCxzLITBFOyKlNSRubzgkW0iw==
X-Google-Smtp-Source: AGHT+IG6YlwnSeWpwQZCjQC/4bwVfXO3ZLqyr7wz2ahkS1E5zXvVRkZg7RSC50vQwXZpquzQdqmKHy32ABLJfpuTPnM=
X-Received: by 2002:a17:90b:912:b0:286:8dd6:db65 with SMTP id
 bo18-20020a17090b091200b002868dd6db65mr57262pjb.91.1706209471761; Thu, 25 Jan
 2024 11:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-8-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-8-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 13:04:20 -0600
Message-ID: <CAPLW+4kGGtG2BxeN0wRXMD5M2TR+eMUHZpL2KDaEFubBCP7jdg@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
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
> of_device_id::data is an opaque pointer. No explicit cast is needed.
> Remove unneeded (void *) casts in of_match_table. While here align the
> compatible and data members.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 45 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 230fda2b3417..137faf9f2697 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1511,32 +1511,41 @@ static const struct platform_device_id s3c64xx_sp=
i_driver_ids[] =3D {
>  };
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
> -       { .compatible =3D "samsung,s3c2443-spi",
> -                       .data =3D (void *)&s3c2443_spi_port_config,

I support removing (void *) cast. But this new braces style:

      },
      {

seems to bloat the code a bit. For my taste, having something like },
{ on the same line would be more compact, and more canonical so to
speak. Or even preserving the existing style would be ok too, for that
matter.

Assuming the braces style is fixed, you can add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +       {
> +               .compatible =3D "samsung,s3c2443-spi",
> +               .data =3D &s3c2443_spi_port_config,
>         },
> -       { .compatible =3D "samsung,s3c6410-spi",
> -                       .data =3D (void *)&s3c6410_spi_port_config,
> +       {
> +               .compatible =3D "samsung,s3c6410-spi",
> +               .data =3D &s3c6410_spi_port_config,
>         },
> -       { .compatible =3D "samsung,s5pv210-spi",
> -                       .data =3D (void *)&s5pv210_spi_port_config,
> +       {
> +               .compatible =3D "samsung,s5pv210-spi",
> +               .data =3D &s5pv210_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos4210-spi",
> -                       .data =3D (void *)&exynos4_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos4210-spi",
> +               .data =3D &exynos4_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos7-spi",
> -                       .data =3D (void *)&exynos7_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos7-spi",
> +               .data =3D &exynos7_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos5433-spi",
> -                       .data =3D (void *)&exynos5433_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos5433-spi",
> +               .data =3D &exynos5433_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynos850-spi",
> -                       .data =3D (void *)&exynos850_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynos850-spi",
> +               .data =3D &exynos850_spi_port_config,
>         },
> -       { .compatible =3D "samsung,exynosautov9-spi",
> -                       .data =3D (void *)&exynosautov9_spi_port_config,
> +       {
> +               .compatible =3D "samsung,exynosautov9-spi",
> +               .data =3D &exynosautov9_spi_port_config,
>         },
> -       { .compatible =3D "tesla,fsd-spi",
> -                       .data =3D (void *)&fsd_spi_port_config,
> +       {
> +               .compatible =3D "tesla,fsd-spi",
> +               .data =3D &fsd_spi_port_config,
>         },
>         { },
>  };
> --
> 2.43.0.429.g432eaa2c6b-goog
>

