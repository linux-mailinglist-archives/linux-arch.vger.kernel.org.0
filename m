Return-Path: <linux-arch+bounces-1676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65683CBB0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D8829AF71
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B4134740;
	Thu, 25 Jan 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5IALI8I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE2130E52
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209108; cv=none; b=g9smQ1sC0tcE6jbyoJ9+iorlT3767Mq5kZAV8slwL6VDGo8E1T/I5w2gFEv8FghJumG4FN0sWn7dgTXDOYWQDe3IolYi9b8SoDBUq8Te949dlzhKfCJ5OjpTVR1JTpqkSQwFMQuTPP1pm9mgTCYwJ5AHAwXFns1Hcck1fjuBd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209108; c=relaxed/simple;
	bh=/yuX+ZwAqeiEBG+9snyPxfUHA4kLw20Lq3tkl7WzUfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITnekcG3MLFB+ituY3U/jj1Hl4CUw4HWHTh8mRt62CTp0GR9m+NTq3nkf1lK0Axiv1NkDJvnYzr8SHziA7PwpUe/DU9fHNgctNjWNGArMXa3FLRVtEa53hdyLxlIj8mgwpLVh5EWi8wwEdGHfRa8sSh3s3qdr02OXDA7ICyydS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5IALI8I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7881b1843so16165175ad.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 10:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706209106; x=1706813906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKodC4CUWzXNZRd0RvY8kflDnv2+qlK7ZzKTDP0BS34=;
        b=Z5IALI8IARtyOtpRCxsnd1W3OOtIIGd8wZHPboiTW3oRYv9oOv0oPbvIzTPYchOJky
         k2UxtyH051QIyOstuDzppF8Uo6ESHt6h7LswT7KHEvH8XymbOJE8FlL2eiKMQNHLMfO5
         zrDWXTrhlt1LdB7CVNLSZ5UJ5p4lSDS7Fnpo/BZYuNjBY3cTWIVqYlh/H6v1plUt0IRo
         2q63v+wsbkvXlPondLo+MQThOsduqhhiRwvP7lCSIhRNkGLzPI4z61AiOLuWQZmEtREt
         1JwGQIoYisbgGsWwuC68mx6FirZKy9J8t+3t8/XKu82mLFZ3ZC08uU0Rb/HsHc/1aZmd
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209106; x=1706813906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKodC4CUWzXNZRd0RvY8kflDnv2+qlK7ZzKTDP0BS34=;
        b=U/tpNrfAEiXbfnxfFTzEbjklR5slNyzpGYvUi1xXU9hECHhjCz8GC63ZkHdn2iLLLt
         DQc5ONeJfzkA0kFC2wQVu0RvZEWFZpmNuLESl+coTlL7k0ocD1AGOQWxERCUhcFoHuJc
         SR+hDdXbYzMqevlPtGg5iPnaRZ8LZDRrWkgawReedqIT8UU+JAMj7QPLwL2fJje3uYgd
         OuHOsaFwaqgYeWxbSMfDHZbz5uRGofPHNuDwm1yiN7fuPu5UDxibr4kkEwbEOsldd9v9
         CUXckG6qjgLnIq1affsPYtHpI4VQrZszrg5cHbVZEOY0CyGQlejVs/eak/B8Sk5pnHIE
         nFAA==
X-Gm-Message-State: AOJu0YzjhjqOEhTHDbmofFFohO6alnx+Ul7bWmgArPjMl9nVr3WUpDCT
	zQwj5mBM/Swr3XIgExzAtpxfo0E1wyjwBxRGqOnsa/CUYPWitvvr2EFaXksXlsfQN+sXgYC+PRv
	WjOEPa+kn+oq0Kwh6RY6Kfw7YMUGuJ+XF8C6gjQ==
X-Google-Smtp-Source: AGHT+IHGqu+F52i8g1m/kMXpX3DElw6QjaxmyN1VJK+gS/nX+WAvT8nHp1ClH077kwlifFuyQq5EZg0+FOpZfc3CsKM=
X-Received: by 2002:a17:90a:1986:b0:292:bcc9:450e with SMTP id
 6-20020a17090a198600b00292bcc9450emr70570pji.11.1706209106577; Thu, 25 Jan
 2024 10:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 12:58:15 -0600
Message-ID: <CAPLW+4=kEhMz5eUCTLO5e4RCK23g+EWqRqcGQ-V9FNnL6jaFtg@mail.gmail.com>
Subject: Re: [PATCH v2 01/28] spi: s3c64xx: explicitly include <linux/io.h>
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
> The driver uses readl() but does not include <linux/io.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")

Not sure the "Fixes" tag is needed here. AFAIU, this patch doesn't fix
any actual bugs, seems more like a style fix to me. In other words,
I'm not convinced it has to be necessarily backported to stable
kernels. The same goes for another similar patch from this series.

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7f7eb8f742e4..c1cbc4780a3b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

