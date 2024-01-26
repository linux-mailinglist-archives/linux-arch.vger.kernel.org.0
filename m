Return-Path: <linux-arch+bounces-1711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F083D57B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4581F26697
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B164A9B;
	Fri, 26 Jan 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDJ8guap"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632463502
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255819; cv=none; b=oq31VGAEeJOkO/OP6GP76ZPCZeeoQHgwKpGR7RLDRngJRK+aHHGIKIIKs1VeKt2nwS/2tVEGmPayj8eWH7MhmXgaICvyL+Tsb5osFJhVS9/gaOAXF+ByZQxBXeWMJHB/hkpyF/Eho0qKS6NvzrGNqQ+qY7Qg0N/cbG2gG4P5kJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255819; c=relaxed/simple;
	bh=GmcENEElrbmu4+qu30DqEDmtjJ2hYqL4X3elhdiKmmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+wOrI5qh0wpr0lQJyvZ34TNqG5UU/6SDvd28UpX9Z9GmMXv/PQz7b6HWK7KDe6XnRLBucOUZ4TYIzkblJibnwZXXhiimHAFnf2QGTYILP494Uy342ip/nBNQyGjNRLUJ2vNG4hHsk/tsnk3corcGD4vuxyjLaKTQXSWzIl7kgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aDJ8guap; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so106329f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706255815; x=1706860615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPleq8v+IkwCDBo36+ymb8DinsNdEMNv1kWJ7eUs/+E=;
        b=aDJ8guapjFvAha7QE36KWWEQAy/rVQz277PN6O/tF1W3/k9BIet3u/yv8Ze7+zSRm1
         5utQqVMS/KWo+neGiN9mekkBb++ojpLBqcVIJV2z7cPfkaRef/KWS6W4qp8ysa1bBxeW
         pMbnkVco1/oOmj0ibXgjJJNcPzYt3QHdrKlnT+Ohuklq28NMTipCzDtnsnAZPqZvOJOK
         zI6sNSXkQ7iW254K5M8IcsMxMVoyknMA3xS4TgYrcQhwFTwYoAo1QVrzJV2vHaJMj8Ug
         WdmTuiON+v0cHvcCxQbH3dJfCjNd4r2D7SghyEha2EHcD9JHmiVNtQToTnF/CUm74cjT
         Go1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706255815; x=1706860615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPleq8v+IkwCDBo36+ymb8DinsNdEMNv1kWJ7eUs/+E=;
        b=CBrjDQh8epxORYaNfyEX7FJmSActYFBuCRqhpy0i5MRFA1OuF5cN8Q1Ehz9x+C68+S
         BbWMarF304tW7i1WQ/+71nmsuEC5UiexCFI+YThAMHsk8BfYlC4H0WrI9B2bWWg0osps
         8ddehzQyFngF1DsgCrkLuYkEUUogL1PuHKJ5kk1M+L/u4fz7LMMwb+hD2O/MlyUNO0nA
         i4s6N8HSLkNW4gffbeom3BLWRnnwrTfIglmz89Vpt4EF9SoNzei7Cem1Yq9ZKIbw00cC
         Ep1m1ImLz3srgilOf9uA+KBlUgosz2s1QacVGKUUQcvNg3LUpgRVwzhDJttmNgAUhuHW
         5StA==
X-Gm-Message-State: AOJu0YzVlZwBzhkHTLAvdRfsyJObhLtWDknWu9TwKQuNkNB8mcy05EBn
	WgFj3rzNxZtl9gUpcNJ9nk/Hy11ojITM6a3yqztIhyAQyBAs//xf3X22BQBoK+A=
X-Google-Smtp-Source: AGHT+IF4ZRzpdk9B+kPkzSfTldHpKYPP1lO7tlsg8x+Bq/NbPYnjD64G1cVIyHa8s5kXAAjz+lbHLQ==
X-Received: by 2002:a5d:4006:0:b0:337:aa99:82aa with SMTP id n6-20020a5d4006000000b00337aa9982aamr593223wrp.91.1706255815070;
        Thu, 25 Jan 2024 23:56:55 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm682416wrb.45.2024.01.25.23.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 23:56:54 -0800 (PST)
Message-ID: <36a664b1-666d-4fc4-90d9-35b42e56973d@linaro.org>
Date: Fri, 26 Jan 2024 07:56:52 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/28] spi: s3c64xx: simplify s3c64xx_wait_for_pio()
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
 <20240125145007.748295-17-tudor.ambarus@linaro.org>
 <CAPLW+4mLWU-8H=qESe9csXm=e_ByvP=nc7MEJzknv+XAUjqUZg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mLWU-8H=qESe9csXm=e_ByvP=nc7MEJzknv+XAUjqUZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 20:43, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> s3c64xx_spi_transfer_one() makes sure that for PIO the xfer->len is
>> always smaller than the fifo size. Since we can't receive more that the
>> FIFO size, droop the loop handling, the code becomes less misleading.
> 
> Drop (spelling)?

oh yeah, thanks.

> 
> For the patch: how exactly it was tested to make sure there is no regression?

no regression testing for the entire patch set, I have just a gs101 on
my hands.

However, we shouldn't refrain ourselves on improving things when we
think they're straight forward and they worth it. In this particular
case, for PIO, s3c64xx_spi_transfer_one() does:
	xfer->len = fifo_len - 1;
then in s3c64xx_enable_datapath() we write xfer->len and then in
s3c64xx_wait_for_pio() we code did the following:
	loops = xfer->len / FIFO_DEPTH(sdd);
loops is always zero, this is bogus and we shall remove it.

>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 75 +++++++++------------------------------
>>  1 file changed, 17 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index d2dd28ff00c6..00a0878aeb80 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -485,26 +485,6 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>>         return 0;
>>  }
>>
>> -static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
>> -                                       int timeout_ms)
>> -{
>> -       void __iomem *regs = sdd->regs;
>> -       unsigned long val = 1;
>> -       u32 status;
>> -       u32 max_fifo = FIFO_DEPTH(sdd);
>> -
>> -       if (timeout_ms)
>> -               val = msecs_to_loops(timeout_ms);
>> -
>> -       do {
>> -               status = readl(regs + S3C64XX_SPI_STATUS);
>> -       } while (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < max_fifo &&
>> -                --val);
>> -
>> -       /* return the actual received data length */
>> -       return FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status);
>> -}
>> -
>>  static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
>>                                 struct spi_transfer *xfer)
>>  {
>> @@ -553,13 +533,11 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>                                 struct spi_transfer *xfer, bool use_irq)
>>  {
>>         void __iomem *regs = sdd->regs;
>> +       u8 *buf = xfer->rx_buf;
>> +       unsigned long time_us;
>>         unsigned long val;
>> -       u32 status;
>> -       int loops;
>> -       u32 cpy_len;
>> -       u8 *buf;
>> +       u32 status, len;
>>         int ms;
>> -       unsigned long time_us;
>>
>>         /* microsecs to xfer 'len' bytes @ 'cur_speed' */
>>         time_us = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
>> @@ -582,48 +560,29 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>>                 status = readl(regs + S3C64XX_SPI_STATUS);
>>         } while (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < xfer->len &&
>>                  --val);
>> -
>>         if (!val)
>>                 return -EIO;
>>
>>         /* If it was only Tx */
>> -       if (!xfer->rx_buf) {
>> +       if (!buf) {
>>                 sdd->state &= ~TXBUSY;
>>                 return 0;
>>         }
>>
>> -       /*
>> -        * If the receive length is bigger than the controller fifo
>> -        * size, calculate the loops and read the fifo as many times.
>> -        * loops = length / max fifo size (calculated by using the
>> -        * fifo mask).
>> -        * For any size less than the fifo size the below code is
>> -        * executed atleast once.
>> -        */
>> -       loops = xfer->len / FIFO_DEPTH(sdd);
>> -       buf = xfer->rx_buf;
>> -       do {
>> -               /* wait for data to be received in the fifo */
>> -               cpy_len = s3c64xx_spi_wait_for_timeout(sdd,
>> -                                                      (loops ? ms : 0));
>> -
>> -               switch (sdd->cur_bpw) {
>> -               case 32:
>> -                       ioread32_rep(regs + S3C64XX_SPI_RX_DATA,
>> -                                    buf, cpy_len / 4);
>> -                       break;
>> -               case 16:
>> -                       ioread16_rep(regs + S3C64XX_SPI_RX_DATA,
>> -                                    buf, cpy_len / 2);
>> -                       break;
>> -               default:
>> -                       ioread8_rep(regs + S3C64XX_SPI_RX_DATA,
>> -                                   buf, cpy_len);
>> -                       break;
>> -               }
>> +       len = FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status);
>> +
>> +       switch (sdd->cur_bpw) {
>> +       case 32:
>> +               ioread32_rep(regs + S3C64XX_SPI_RX_DATA, buf, len / 4);
>> +               break;
>> +       case 16:
>> +               ioread16_rep(regs + S3C64XX_SPI_RX_DATA, buf, len / 2);
>> +               break;
>> +       default:
>> +               ioread8_rep(regs + S3C64XX_SPI_RX_DATA, buf, len);
>> +               break;
>> +       }
>>
>> -               buf = buf + cpy_len;
>> -       } while (loops--);
>>         sdd->state &= ~RXBUSY;
>>
>>         return 0;
>> --
>> 2.43.0.429.g432eaa2c6b-goog
>>

