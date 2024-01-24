Return-Path: <linux-arch+bounces-1508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E3A83A607
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 10:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6BA285264
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7B182D8;
	Wed, 24 Jan 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhx8cX/z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A18046
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090093; cv=none; b=qwTPTZNFxJllppXMx/7hPpBOPlnLvrG/5foDOQZ56hVxn4hOASABomTVzCtRWJj0Cr5BqDbC4aj035kP2+ikqoGJeOBEbrTxAABNoVfAIuDfIIoij1rwNES2toRfazzjVsTDX9AdEap8Z5tgJ0Q2AzIbkEknnJeT0gYK4OXP8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090093; c=relaxed/simple;
	bh=bYZ6BcoUiLvgt9L9SyWiOViDz1Wa3JdvKJ85QZM5CKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUCtjJchTMt1g/ms3ldC3KF7aD0tHbxgPAl/pMJqGTM1DYzeRlJQk5w2W4GKQpG9jiAbFxH+SVp2fU+RBcMZqHHdz0s+HxVxUGcc3JjVOzrvODWRwDY2xioNS+0/xzNz3g/cqcwSnZoFmXFvBy8qxvgRZGI2siTHK6qxfL7J5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhx8cX/z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so66017325e9.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706090088; x=1706694888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3GSiQnBTV0mEFAoqjBQs54WUmtsc4sMdeFUUjaDKbM=;
        b=lhx8cX/z3q3zc2ZQiyz9PV5A+gLMu+b2Uv1E31jVljXYBFL08akwYpo4gh8umehtP4
         nxKyODfcnmJx2xuiXAkWDdF8knXk4IWFLXLuLZSsyDnjdWscuxwhxsTrivgDn1FHpGEf
         upTVO4Mf6RA7/LwhMeWIbOAIzX2oVWHNdfimJ6lImWpJAYtBiGSz+SROxwIeoUNn8SEk
         hb/sM9hjo/XL7Pg7s9F3WqVuyRlOAcubbq9/w9fgspPD898N5vxYIOWRRIMmITlZ/Jee
         zy8YHdST0XEu30c+LKO5PVG7j6bEgw2434AxPk1CVCPuJD1HafNmbs3h4uwpJbhrCvB1
         FHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090088; x=1706694888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3GSiQnBTV0mEFAoqjBQs54WUmtsc4sMdeFUUjaDKbM=;
        b=CsbluU4SooJCJHVNud1nPQVE1iuWg6DMr1KfnfKyv6vMPmiQn0soAfdyIp2cOvyvmP
         9AZvM7rjPTETQgNGfji633Tpjm6NaTxm/w95j777IHfktTJ4Rs0dt/yWdIN+Zc2usnvS
         w2JYgUCDrabeUcNvniBBZZM4K7iHpXA78O+zqNTDZRKN6Wjce02PHz+LmpVccueA6Oep
         BNoFfgVPT6jGqqTD/N6i2x8z+DF0t0qkuJViIOBm3xujdQqsfjhHuQ1kgl4q1D78YZQh
         f5lRuuYU7Aek0l5yDkggfjAbicvWlakv6ZJYtClQS6yr/sMj6n5heM7neP1/b+8Pdexn
         unSw==
X-Gm-Message-State: AOJu0YwCHf5mGdppsVc68T/1y940CCUnDmSU/in7OcJGPSXD9WqIvu7X
	xYRNENx1zqG/oz1a1fpsMYaQjwmTzDLLOsE/td4iHy9oatOMv8vG+OvEESbsAs0=
X-Google-Smtp-Source: AGHT+IFpeuF4hWuOGs+LehseKTmKoFf3z77/xE/nT0VhW+XrLS6lAPOETImXeRgTYDlFkrcyXCZZMg==
X-Received: by 2002:a05:600c:4195:b0:40e:8a7c:cc1e with SMTP id p21-20020a05600c419500b0040e8a7ccc1emr1091371wmh.147.1706090088469;
        Wed, 24 Jan 2024 01:54:48 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm45237569wmf.43.2024.01.24.01.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:54:48 -0800 (PST)
Message-ID: <cfa6e878-01bd-45aa-8fbf-030288a0e65b@linaro.org>
Date: Wed, 24 Jan 2024 09:54:46 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] spi: s3c64xx: add missing blank line after
 declaration
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-17-tudor.ambarus@linaro.org>
 <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4k-5vdkBNdewTgG72iAr0oLv1zXncnmx-qy6diJqQMNDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/24 19:28, Sam Protsenko wrote:
> On Tue, Jan 23, 2024 at 9:34 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Add missing blank line after declaration. Move initialization in the
>> body of the function.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index f5474f3b3920..2abf5994080a 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -1273,8 +1273,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
>>  {
>>         struct spi_controller *host = dev_get_drvdata(dev);
>>         struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
>> +       int ret;
>>
>> -       int ret = spi_controller_suspend(host);
>> +       ret = spi_controller_suspend(host);
> 
> Why not just moving the empty line below the declaration block,
> keeping the initialization on the variable declaration line?
> 

just a matter of personal preference. I find it ugly to do an
initialization at variable declaration and then to immediately check the
return value in the body of the function. But I'll do as you say, just
cosmetics anyway.

