Return-Path: <linux-arch+bounces-1714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E983D61E
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B11F28B45
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934271D555;
	Fri, 26 Jan 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjOvfehB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFF12CDBE
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258968; cv=none; b=QaIPX555GUNQyirpJ7sHwPfkHtphBB5VEcpK/TXmvsZlq96uTDfZ4I3rSLVcJe+YKc0Ky4v9tUh1vPi9hkxYh3/MlYDBnamqtbWw1XjA+aewk+y6DzuedIkh1ErYuni0xEc0SDCGik8Ky1s1huEAQckZU1D55Jj9YZfs1ipJYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258968; c=relaxed/simple;
	bh=t/ysEWbT7DsgI1OKWJZlsnVlTSlU/XcsSNTRoDVp2uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZepTHATWQ6unJelJNFNW+uIRRFLUUAdDxGbabtxl6zefQBtcEYuH4io2yqvcahUHTtjTjgKbR8HzCNqgDbTbhYqUwV51nof7vmIKhjiMOh/zISb2c9Hl8rT8xYqxqDKUnxVkTufggPKJ7n7KnKcxLknwAzm1sm73mak2Pnmx8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QjOvfehB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso1949945e9.2
        for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 00:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706258965; x=1706863765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxXvp45WIZMJk6naBF28BXtWC3N8nQIyBhkXmU92Lmo=;
        b=QjOvfehBwf3WuBI044r7UjrgnPxxU39vStixilzothah09+vwDEy9YXFQ6+edgLDiG
         ZOv2bsgCReYBPgbk/DHLkAGUZuTuOOvTofof8IiVAMd3etlGcY2twJzUv26qONkUp6C0
         AhzhyygS5v/2LCdC7mqhry3z4rmHopRr8NzPxx5DgPxpiML2uu6ASugxyU9aEm6U5DzY
         jtbzmEt791PMCbWPEvsS3lovtIejCjNjtiV0Y87F37jul6VkAW+/+9Qw8c3wJIxIAwhh
         kySUgW40NjmUsEiUvw/wyzUVOqpBuf+5krxiL9du/KcZ6mcvS43YXWzRcvPs0FWK03EN
         7hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258965; x=1706863765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxXvp45WIZMJk6naBF28BXtWC3N8nQIyBhkXmU92Lmo=;
        b=HmS5TMLRZITxs+MNkj5Ot4Wr0RFwn94zbm2BYdoiejBvfNcpcnhjDjhlfwfEzx0qx6
         s/xODfM6Rf0qxYIGt+ViYeL6zTeGkGKgSXOW1MgrXjKkVwJcxOq+3EaSN9jq8LHk/qOv
         fJiJEv8kfvTQlxCY1EcdCveBVdCcbfcjEQnoBIXeyc4oIl9d/NFzkBsU/HMyfN0vX4VN
         WS2fbcK4veHLcZN6DKQLfa4c9QuFU0Btr7/wlUdu5/CnDUttAw0EiegzPpl/NLIEffT7
         flnly2Me/NSOBSIkAhR2H3a0X0B36puxRy5HFSpUa9Hx4iRsaUo0jUpSQ/LC1iA362tU
         KNwA==
X-Gm-Message-State: AOJu0YxhZDub2DO3CcBw2h1PtZXOWHzfTjCbpiMVgHuVT/oTnw66GFus
	1I69cbaktxPzcNQkIk9BdzV84uon+hD+Ws1JZPoRMkTlk7/PK2LTEa9flkKieRs=
X-Google-Smtp-Source: AGHT+IGrlYodbtoFOzQTpnpmPPg9xGCmxcz+GDpPReJccTb8HS+VxG5L6fwYLtI5QMAZCz4OUzPawQ==
X-Received: by 2002:a05:600c:19c8:b0:40e:b95b:e482 with SMTP id u8-20020a05600c19c800b0040eb95be482mr598802wmq.115.1706258964791;
        Fri, 26 Jan 2024 00:49:24 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040ecd258f29sm5158250wmq.0.2024.01.26.00.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:49:24 -0800 (PST)
Message-ID: <ee4107c3-1141-45ab-874c-03474d8ec18d@linaro.org>
Date: Fri, 26 Jan 2024 08:49:22 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/28] spi: s3c64xx: use bitfield access macros
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Mark Brown <broonie@kernel.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-10-tudor.ambarus@linaro.org>
 <CAPLW+4mDM2aJdPwPRKt9yLtwx5zEHwBr6OSyYbGgZU7w9OiYkg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mDM2aJdPwPRKt9yLtwx5zEHwBr6OSyYbGgZU7w9OiYkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 19:50, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Use the bitfield access macros in order to clean and to make the driver
>> easier to read.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 196 +++++++++++++++++++-------------------
>>  1 file changed, 99 insertions(+), 97 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 1e44b24f6401..d046810da51f 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -4,6 +4,7 @@

cut

>> +#define S3C64XX_SPI_PSR_MASK                   GENMASK(15, 0)
> 
> But it was 0xff (7:0) originally, and here you extend it up to 15:0.

this is a bug from my side, I'll fix it, thanks!

cut

>>         default:
>> -               val |= S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
>> -               val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE;
>> +               val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
>> +                                 S3C64XX_SPI_MODE_BUS_TSZ_BYTE) |
>> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
>> +                                 S3C64XX_SPI_MODE_CH_TSZ_BYTE);
> 
> I don't know. Maybe it's me, but using this FIELD_PREP() macro seems
> to only making the code harder to read. At least in cases like this. I
> would vote against its usage, to keep the code compact and easy to
> read.

I saw Andi complained about this too, maybe Mark can chime in.

To me this is not a matter of taste, it's how it should be done. In this
particular case you have more lines when using FIELD_PREP because the
mask starts from bit 0. If the mask ever changes for new IPs then you'd
have to hack the code, whereas if using FIELD_PREP you just have to
update the mask field, something like:

	FIELD_PREP(drv_prv_data->whatever_reg.field_mask,
		   S3C64XX_SPI_MODE_CH_TSZ_BYTE);

Thus it makes the code generic and more friendly for new IP additions.
And I have to admit I like it better too. I know from the start that
we're dealing with register fields and not some internal driver mask.

