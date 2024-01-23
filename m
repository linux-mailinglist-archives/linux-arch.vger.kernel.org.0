Return-Path: <linux-arch+bounces-1485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96E839986
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625B31F2BCCE
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A6A82D68;
	Tue, 23 Jan 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XH87orin"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8582D63
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038122; cv=none; b=rzGG+1CKHpQs8Hsjywv92/yeeqdnqD2802/d1s1ulUITtzQJwI5Hjj2KlMyLGtpCeqwTLA+wK25ErfmG5xjIeOgQlUqrf0I84H35m1yyNnEKaYQPbwVuh8FGpDX9iSJZpsvxglT0SCotKsB5zUE2860qIjU7vgcfeC2CJ+B3ZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038122; c=relaxed/simple;
	bh=z635edAjEZRLK9uYsv6D75GltoeAuq2T8K98RgKsohU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWX9Cb6K0GD1OosinZygPWjnBow5tboiFp8x7aLr45Wwduehz3U59jKbKQuPA5WPdDkN4q422btDJRsMZTTwNsMulRjEOMlvdDw3OLhzf8duWcS/48UaGdeOv5HtEjEZY+M2VKUWKd3mubPSG6Yp4u4sj0o9O8GGCl5LvTJifO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XH87orin; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dd7debc476so615494b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 11:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706038120; x=1706642920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=XH87orin++yohiMfBwAoFVV9WdBMKy+twg/U6p/3DyC9KKTOU2Ux3eLbdMfNgfkODT
         ppj7MvP0UEPdg6jEE5yAgZJvT/XXOtMm2ElKwrRwEkVaArOZLozQ8ORNwNgs8bDa8asU
         /rn+q+Ke3bT8gefXTQ+LrLW55JQhv4q1x7wguM/Vwu9Whh0g7jpL5Zt7xDaOWe8L6bz5
         cNisxXxI0IQgX4RWq2IQgPrBOrWWzqV4tOTLOOfjyQv/6vsOetesi3H3EwmHWBlNyngt
         vtoakd+H+8kUbkC5yVFqV+TzKZ+SL2E7oviXIw6OHpzBZKwcyBDRRyJBRaSo9Qp9hGap
         A3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038120; x=1706642920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4fx2jRa6XWdzoBOQRFudfhQ7Cys5tOUHx4aJsazh8w=;
        b=R8vCthxGPrwVHJAq+qMAJvmesY21ftT2ft6w8J2922/KAxtNuXWkZe0VDorDxkpKrm
         W8VhBLmhvGCZHSfyyAtOB3NsJuglI8lixeN0TxMD01UCIHXmh07PViMLbwLtWV7rSE01
         IIFJKYOgq4+/Iekzq54ib95qWRWQVnaFdh01Uab12DIGU1jyXaYtCzPARC98hrZXyaYj
         fhl7cw0Nzrku2uw/Wl8/w5UGtQTecg1WphLiAzbhfBAxnWIFZ0VulS1FppNHxGry5bIr
         4hR7Yry6Pk+EhWC3GfUEyfPjq1gYukU/ETA8SJTdW/Llpv55F/wRxHqRKBcd4+8ZJS1p
         Nlpg==
X-Gm-Message-State: AOJu0YyLk1uXfLI9qfZHizoTauq5fj0Aqw2mJ8Oj8ermE+EwmQ2EeC1c
	DQJd/njaXLxJ+T8Hzl0LmQoNjXSW5rcL1C7ABbaF9s8bMapFedFBd1KxPmXz3cD0J3trCbVrjpa
	mAN8nKOEwRoNzVEFVcSAuo+ZTjv4WSjuevRClZg==
X-Google-Smtp-Source: AGHT+IE4pMdlHZBzRIybtPg+syPs+PySUc9Nk1uvLXRsfE7U/0t69O5o5wVcE/JsP6QewXSBCaO+EnVOVMCLRSuJrjI=
X-Received: by 2002:a05:6a00:460e:b0:6da:bceb:3990 with SMTP id
 ko14-20020a056a00460e00b006dabceb3990mr3781418pfb.53.1706038119921; Tue, 23
 Jan 2024 11:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:28:28 -0600
Message-ID: <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
Subject: Re: [PATCH 16/21] spi: s3c64xx: add missing blank line after declaration
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
> Add missing blank line after declaration. Move initialization in the
> body of the function.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f5474f3b3920..2abf5994080a 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1273,8 +1273,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  {
>         struct spi_controller *host =3D dev_get_drvdata(dev);
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
> +       int ret;
>
> -       int ret =3D spi_controller_suspend(host);
> +       ret =3D spi_controller_suspend(host);

Why not just moving the empty line below the declaration block,
keeping the initialization on the variable declaration line?

>         if (ret)
>                 return ret;
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

