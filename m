Return-Path: <linux-arch+bounces-1482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AA83994C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97182922AF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD081AC1;
	Tue, 23 Jan 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz0yCv1W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AE8003E
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037163; cv=none; b=F5vV2qq+tU0EBHcag1CcjNH8zSxmUVkSL0J+BtSKkiKNCXT7Il9nhnC+XrQS90ASSEqyBvbLMWImwFfZihALPovouNWWfj7IeuCpW1OCneieHdE/BHULlGmDPKOYfhvTzEVH7xC1duZUw43AZ+OrVRblDcK/zq9rufiNQjH/+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037163; c=relaxed/simple;
	bh=WCVA+pw6+iSTOLRgl4ne/CK558PaHhdGFi3Vw7EsWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxQDg7SHSHVT9psMU3Dr/nxKQ+q5eAwAFHUdoywVzSYOnZ03C8ubWhZXl3lKHvLFjF0OoGlb15v0gQdmG+3QBiTdxwitnFviFFJHV1Uikj/zzqHVEE38xIY+8okGZnWjZtspMg9yTAtuVqSm4q+wgX04XOv3Ih8XRTYqUiKndZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz0yCv1W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so1402436b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706037161; x=1706641961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2MABtBJt1eXd29le+TwN8zaGu6n3A3BwV6SbBkk6qw=;
        b=Dz0yCv1Wb5j2tjMpJ8RNMgaOMsukFpHHfj8sl0z94creHFxYFp/i8DHixA1b2w1IDF
         0mrB1kqP6cKQWvDGP4QJKfjC3+TgCPFg6e1Xsg0uMvn8+KLqZgtFZpdAgnHGM5OaTUJ8
         eVgRjYt7sL/5YJGdxTmYccDSvlWwBZal0+Lf03vO3a/urfEyZt9WVNLjZVTLzBvNv9oD
         5v629bLhJ9fh+2t4bW/j0MA3E2ZwTvaFJI0BBrErBEZFvw+ueNSOKna7MsJHiEdZYoQC
         MBAXtfW1eQWOOL/4wmgnyjEGtVIbjLZXpdVkl5WbHVKiloZpdji1FEwlFglKVzb4zLc+
         fASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037161; x=1706641961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2MABtBJt1eXd29le+TwN8zaGu6n3A3BwV6SbBkk6qw=;
        b=h/+cQ1oLkd+gux4RteOISHA4xI8aso3nWQm69s8uto//oOybfELfP4tnEPtIqzRQvL
         QUo9coezNFifRmUiaTNpS1p5Gesv4sg5ZSAZfK2avE3VhPYRzeV0p8QdZ5ypQB284uMj
         ofkD0ZG1vWk5oVZl8D4UgiMD3MDiafQ+u3hkXyJpgQuPaA72naWOtW+O67JhoSO9MbzM
         KbNGteYHrjbEV7kp8MAVfq6P1oDraO2BAx9PCkz2styCynonlfyySEsCxXJ/N9qK9J28
         kvy7nz0D6E37zPrv4CoI1wox9n+IPogKfp+wJm1Ux3zx8AoiD9LxdTpriFKWrD+zFLBU
         xZzA==
X-Gm-Message-State: AOJu0YxSMeHeq2jJZkPYrTgEao5TdCPlnIcIhiKaA8z6aRaSxNYRCHrI
	Tihc38xSQYnMc29f5BSMvyqcn9sCvuBRaRQs2o7XkxNxpInfCHekzq2ko14v3385xcoOLkTgv2X
	5qhL+XzAjurZgEh07sE3tjtNn4hJa20O9x5YOTw==
X-Google-Smtp-Source: AGHT+IEzLIMx9KeDTQS/RcAgL4Xbbq/ry/ea+tOIU85SHc2O3G0CyeBj+EbdDdjeqw61KFQX1x1wVDePvwu4sqxtXrM=
X-Received: by 2002:a05:6a00:1901:b0:6db:d589:1d62 with SMTP id
 y1-20020a056a00190100b006dbd5891d62mr3904501pfi.7.1706037161193; Tue, 23 Jan
 2024 11:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:12:30 -0600
Message-ID: <CAPLW+4=36DeyQ+v83j6ZqHM4wubet3gnVDvZVptn6oS-pdEhYA@mail.gmail.com>
Subject: Re: [PATCH 06/21] spi: s3c64xx: remove else after return
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

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Else case is not needed after a return, remove it.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 9ce56aa792ed..db1e1d6ee732 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -406,12 +406,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controll=
er *host,
>  {
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
>
> -       if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
> +       if (sdd->rx_dma.ch && sdd->tx_dma.ch)
>                 return xfer->len > FIFO_DEPTH(sdd);
> -       } else {
> -               return false;
> -       }
>
> +       return false;
>  }
>
>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
> --
> 2.43.0.429.g432eaa2c6b-goog
>

