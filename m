Return-Path: <linux-arch+bounces-1719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B283DC93
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2DE2882EF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A161CD07;
	Fri, 26 Jan 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aTS6R28i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEC1CA91
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280054; cv=none; b=aoU4XLy6othwKozRwf56/fhDYfE81sQ7Ojbyp9XdeatmEqTB+KdWEOEEjyB0gIiRLDz1dRUBsyIqL/rUNinO/kb3B6p+y+hExoEhnqMNHCeIcefgIkvNrzvEGbUVfPKibLnjCcn+qO/YkbTTeh0zgfoPwevp1pWwiLQ/Loeft78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280054; c=relaxed/simple;
	bh=ToHVwMkA2rG2Gf0KYv54/WgPDP0igZrev5cweEZsDRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQiZu04WRCbvD2ht/NbZQpC+AG1XKKaleIsPZMglKcRfYW4LqajmvVWTM/yWDLl8buOksS2JCWVM8huN2178jHi/rFTwx/TSdHHepoFyVukVjTgyh9m7W/4CyGi61CR7ENUVjcLXudb0XYfhaGuWyoYKZpsneuj43Pp5K2ikqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aTS6R28i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so7934465e9.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706280051; x=1706884851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I68Ldx2ZUNdKEgzY5p5+0BlL/e7BiQBE3Me8iSEys3Y=;
        b=aTS6R28iC5aD98AAHMU8Z3bdzm3/Mx1zv8KDHe20ZpqOW+pHkgiUvpBfX/+29f377+
         7fYACAkkMy+aAVO/TFf57VonxbdDbnL4K5c3y2KlJRGwTfTirfL08Dz5weLj81bqN2FD
         Nt7UWTLFcNrxVo8cm+2dIMFyzhlsyhaG2atNNqqzYyGwQjPw798d+UTlXbKvzXdnONom
         9D246YgWNWZOX4wcZdJpR0L1c1oWw2VtANFHtbbOq4NCvw7WvRWjVQhPm2v1SVoe8jna
         Btry7YXpuoZh89esrVERtHkzx4qbVU0fo2NbL+3HGxWGcV6/aVKHxacRbJ38NfLE7L+V
         xyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280051; x=1706884851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I68Ldx2ZUNdKEgzY5p5+0BlL/e7BiQBE3Me8iSEys3Y=;
        b=lMTlUmSdApAEzJeqYLmFWNOz4dw7K9UuONFkxQi2w8sGOoxRQzqAwBmLkERjbU+gCC
         IeGepsdxs1VW/XqU8T4GSKpOFF7we6k277zGAfEricvdqmamnfQQNBlQnNcBuEMSL+CY
         b23hMBH1q9H8NqlmqaW18OhgLjIx+xvMVMUzuzCj8NGbn0zFDQ+qEznxLR8Sgo+hzIEl
         F1E+tQzhOvNC7FfJKhHZoMRgvbu1qo8XssHUEV3DTQu37ibOJY3ZRY3p/KnYxaf2AIC1
         BRXfCcY/PZqgphiadbTOAPhVaXZOfsXH1qjK3v9ewOZ+DNwg3sgIDthTBbleDM5+aj89
         g2ug==
X-Gm-Message-State: AOJu0YxqlRbS6YBbAqoA4kVhOdR2DpWpEdGQhglJa0HyiukL8urnLs/o
	jMHTOA3u4AytatkxfYatliEl6DKNzmOdSYjS05m0sbcJXprfgxpQBfgc7X2dDHA=
X-Google-Smtp-Source: AGHT+IHXzEf5WgqfPoXBoHkDPWdpU3hY9J3uxc6EbtcTE1L6QxNs5WVrS+kXB19hcycpSon17cfgWg==
X-Received: by 2002:a05:600c:580f:b0:40e:d45d:ce41 with SMTP id jz15-20020a05600c580f00b0040ed45dce41mr922611wmb.186.1706280051105;
        Fri, 26 Jan 2024 06:40:51 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b0040e45799541sm5957740wmq.15.2024.01.26.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:40:50 -0800 (PST)
Message-ID: <68e63f98-366b-4558-8819-e37f58e1e3e9@linaro.org>
Date: Fri, 26 Jan 2024 14:40:48 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] spi: s3c64xx: explicitly include <linux/io.h>
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-2-tudor.ambarus@linaro.org>
 <CAPLW+4=kEhMz5eUCTLO5e4RCK23g+EWqRqcGQ-V9FNnL6jaFtg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=kEhMz5eUCTLO5e4RCK23g+EWqRqcGQ-V9FNnL6jaFtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 18:58, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> The driver uses readl() but does not include <linux/io.h>.
>>
>> It is good practice to directly include all headers used, it avoids
>> implicit dependencies and spurious breakage if someone rearranges
>> headers and causes the implicit include to vanish.
>>
>> Include the missing header.
>>
>> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> 
> Not sure the "Fixes" tag is needed here. AFAIU, this patch doesn't fix

fixes tag indicates which commit failed to include the necessary header

> any actual bugs, seems more like a style fix to me. In other words,

not yet, but we can't estimate what header get rearranged and whether it
will cause the implicit include to vanish.

> I'm not convinced it has to be necessarily backported to stable
> kernels. The same goes for another similar patch from this series.

It would be good to have this in the stable kernels for the reasons
described in the commit message.

> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 7f7eb8f742e4..c1cbc4780a3b 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>> +#include <linux/io.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/spi/spi.h>
>> --
>> 2.43.0.429.g432eaa2c6b-goog
>>

