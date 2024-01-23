Return-Path: <linux-arch+bounces-1480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D1839941
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0606EB221D2
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469C1272DF;
	Tue, 23 Jan 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjXDEbto"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50D823C6
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036726; cv=none; b=h/X63/4xzU0edkgabxGJauCXQi4EbgYBlxmI56o97M5tYVaR3vleNbrCDBkfmp+j891iTrTVxAaSCSTFg8oKbhiCaHBfpvAwL3sLvLGh3s4D8QhJPL97eybml5GWMak+gm0m7suHYvqin062IJ2OSDMHmRAvcKFyPQUKzRSNEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036726; c=relaxed/simple;
	bh=OCbI+NLF1YGu498IgDblfbl3chaPTQws1Te3v7nNHtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnsVj2mGGKycfRbn1lRY4XYzj3M7VQDqqvsnAfO57bt4/8oYowF4/7vam76LUIGT27CHc/HcP35626dJ2Vy8/bezuyOPE+m6vXVwm2vaYs2z5H4jVd08eoavF7C2fVHLwQ0hFRdNcfFGrjhFWqgv8rjhoPBjx/+mTCBRnYVVo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjXDEbto; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3306174a12.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 11:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706036724; x=1706641524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVERgvysCWGTIRLyfCXZM2M+ukaLtX3i/mU0WUPzMyA=;
        b=DjXDEbtoQ6dLI9g5+CvSohqx73PLyl7pRSa/1T6ewLrPMGTjRKUwBmLRiBe8qYE9JT
         junPd/eidBbQYHrRpP0aKgtC+pJmxHmKJgwySFfIUKjtofr8Bt5SqPPYrwfx1g/kFPS/
         NK39wVMn5i8LKfTvVVoywUrNWXpTAA4LTEzV+UDOECFHsuIwqku6QJucKZJl+XzLXoQj
         gLe9zGNfPad4su04Y8dFSpm2NWr+2bhC2xK/nYNwsxFSxxl5oBHqcO7BAvRNUvNx1M3J
         twJruxlZDCilQYp2v7/yyriUbU6vJRpqvvLT21O+mf8rQSPfXPwCpkmiOWMZSFsgZkeG
         zBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036724; x=1706641524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVERgvysCWGTIRLyfCXZM2M+ukaLtX3i/mU0WUPzMyA=;
        b=ruUgSCRTpb7vPlG3lUK1Ynu/5kWAdp5dwkSJWKegxm5wIfJPpNhlh8ouVtCnG9T+ZV
         aM/bBmvqyOetJYztEOvET+uCV7DVcI7rfAh7ER5TahK6jz2yDTFY4IQi1cEM7cxUDYRy
         WEdGJ6OzWWu41bmqzYr8Gz3oXpb0ceUsb54d3elEQItGvxVCVo2F0XT1qGbdwqjXTmHl
         ZC7aOF50IGi/XDH92H5q7bc2MTJij3AZigbtkhuXJyM43bp0JhEEWXPAjhhsGbrp9NwG
         TbyuVE3AWSt3qWdRiP5eOt+GxCu82f5YBYIaiR8L4I2uxArmwD3O+SATmTYKUpm7v5GL
         lqBg==
X-Gm-Message-State: AOJu0YxJkzR6D7GtAr4lRM/+eQ73NE1/Wd0SD4KnIQO4nKNJWnzu3ZwJ
	pP5MHOnpQJ+hkNI12JWgXH4K9JFR3xBSl1dka5euIPktp3CS6vz/G0me3WTg9tj5QnsXgDNzEGE
	IKH98m9fdZsD537Sw9r3c/w2Jt5+peb+NjtdYpw==
X-Google-Smtp-Source: AGHT+IEmzTb6pGV6jReIafVXWwbj4cum+U8ODr9yAF3ZBzIkY6pczw4WK0Mea40kpolMuPv8pK9QI+1MXj9Fb/brwsM=
X-Received: by 2002:a17:90a:6f82:b0:290:6b5f:fcd5 with SMTP id
 e2-20020a17090a6f8200b002906b5ffcd5mr3070046pjk.0.1706036724112; Tue, 23 Jan
 2024 11:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:05:13 -0600
Message-ID: <CAPLW+4k3EmkzW9K638umFNav1HvofYHV=WnXPmDaRTXuFDN7Bw@mail.gmail.com>
Subject: Re: [PATCH 01/21] spi: dt-bindings: samsung: add google,gs101-spi compatible
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
> Add "google,gs101-spi" dedicated compatible for representing SPI of
> Google GS101 SoC.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Doc=
umentation/devicetree/bindings/spi/samsung,spi.yaml
> index 79da99ca0e53..386ea8b23993 100644
> --- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - google,gs101-spi
>            - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
>            - samsung,s3c6410-spi
>            - samsung,s5pv210-spi # for S5PV210 and S5PC110
> --
> 2.43.0.429.g432eaa2c6b-goog
>

