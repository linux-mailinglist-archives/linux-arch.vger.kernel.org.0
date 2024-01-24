Return-Path: <linux-arch+bounces-1509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647683A6FF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 11:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51EA1F2C54B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054D10965;
	Wed, 24 Jan 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDXouRdA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7165107B6
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092830; cv=none; b=ebvIhe5e0hDPuR42/+/cFwS0J0OK3Pjbemc1jJ8qk2fRhv9Nf3RfIUggLWPKEmBXcrW6LhrPm/8xJIXJVVb7FHEkPXa1c5wIZgcNCvlIiKd/Is5HGB/FiWjT8cOPXvKHgcUNdNXOtmjcSZGlJHduF0bjAfllnY6agnnLr4CCOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092830; c=relaxed/simple;
	bh=/rcwWLjKNsQ4uNLjDxu0u6HhI08J5Hff713NR3+kdp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES5q22B2gpaRTu5AYngpy9wnu0WyZ/Fo/DgvvGBxuTxA8bTmYbM2p98rcjpmcwU7aLpcYtpbxbKpXPZe8FV/iGHgE7l3YDx/tQv8NGMA+6p/4eGBrZ/7gbtNjsYwG6Bw7tETChkjqRrqOo2QgV/h7B+GWsp824ownYhFNL+7xsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDXouRdA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e7065b692so57584475e9.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 02:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706092826; x=1706697626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSinsUdJBev2A8sF8xAgVSp8tT3w+79VUKvBD3C6qGI=;
        b=IDXouRdAG/fnp7YF1Knbjx2D9s4VZvjEFCQ2oLUZJXzE1Ow8oP4eZ6bL+yI4FfuoVz
         pusKvJ6lW7ZPwnj8hF/TFm22m3nCGr8I6fBlRu88xxEpa4Z14I44sbGTPTp56YyVAl4r
         gKdpnUPcpj9CBjj06PGaOwZFi3R47bgjsa38t8xZgedTZxmaMNhNwYh2mmB1SH6zh0dE
         XSZuZZG0to55ab99GmSxEwm6zZeIKmbcYzWqumw/t4qbACM4OWZ8g4CS+T7BONU/cmzo
         Y9ku0VsIpolNCkeRF8iL5UcYyyRXhlofii7RN7F8U5RrPqjH98TKkNJ88E8pfZyfB71M
         665w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706092826; x=1706697626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSinsUdJBev2A8sF8xAgVSp8tT3w+79VUKvBD3C6qGI=;
        b=BSravSzdwJFFd+A/x0Cl7Ahij3Pjx7XO6mOOWnluEJ9mEXRh/KFcP72UnZ73LRxPm2
         x7flxjGGa7apfehSCbPvH+qf9WjiwooDKOrGmVLqCxy/xzwGIAsGarNJl6jPRg75vByo
         +EJFWWmrp7h+5c0pj33/hkc6/J1oSMhSwd9p01eA6HIoArlXyJyZhDSqSka9aV9Iw69P
         oBXbLHEN57rxE3CY8/RSWdX8d+DeZVAMy4nqVnBL9ebLRglXNPgmTeA/tCqnC3wGurke
         oEN/bIP/4Bn1nqO78qs9pomY7ZOThVsa0q0ocos0mJlvhO3Dycxlimy/qZN4SC9SkdWI
         1RZQ==
X-Gm-Message-State: AOJu0Yza9B/0mHO8GTH6AZJNX2tDQNSKO+IqZj32/ioH5CrTRMJZW+nu
	ClRTbR0CG/ruyxSO9W6Cu3zqMGsG9P/nXtEMJ8LGWdplVOWa3qOWQPFomeWqUpY=
X-Google-Smtp-Source: AGHT+IGwSuI03XUOIGe3ABYN9RVpYB/MTKo6Ld8tEMS2I9ppFs6vnbEwtrd5Se1jBpncAPX3QjbZWA==
X-Received: by 2002:a05:600c:35c2:b0:40e:4ad9:dbb2 with SMTP id r2-20020a05600c35c200b0040e4ad9dbb2mr950905wmq.112.1706092825892;
        Wed, 24 Jan 2024 02:40:25 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id bw12-20020a0560001f8c00b00337cef427f8sm16105885wrb.70.2024.01.24.02.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 02:40:25 -0800 (PST)
Message-ID: <ab53dbc6-dad5-4278-a1d2-9f963d08eedc@linaro.org>
Date: Wed, 24 Jan 2024 10:40:23 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] spi: s3c64xx: add support for google,gs101-spi
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
 <20240123153421.715951-20-tudor.ambarus@linaro.org>
 <CAPLW+4=5ra6rBRwYYckzutawJoGw_kJahLaYmDzct2Dyuw0qQg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4=5ra6rBRwYYckzutawJoGw_kJahLaYmDzct2Dyuw0qQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Sam! Thanks for the review!

On 1/23/24 19:25, Sam Protsenko wrote:
> On Tue, Jan 23, 2024 at 9:34 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Add support for GS101 SPI. All the SPI nodes on GS101 have 64 bytes
>> FIFOs, infer the FIFO size from the compatible. GS101 allows just 32bit
>> register accesses, otherwise a Serror Interrupt is raised. Do the write
>> reg accesses in 32 bits.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> 
> I counted 3 different features in this patch. Would be better to split
> it correspondingly into 3 patches, to make patches atomic:
> 
>   1. I/O width
>   2. FIFO size

I kept these 2 in the same patch as gs101 to exemplify their use by
gs101. But I'm also fine splitting the patch in 3, will do in v2.

>   3. Adding support for gs101
> 
> And I'm not really convinced about FIFO size change.

I'll explain why it's needed below.

> 
>>  drivers/spi/spi-s3c64xx.c | 50 +++++++++++++++++++++++++++++++++------
>>  1 file changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 62671b2d594a..c4ddd2859ba4 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -20,6 +20,7 @@
>>
>>  #define MAX_SPI_PORTS                          12
>>  #define S3C64XX_SPI_QUIRK_CS_AUTO              BIT(1)
>> +#define S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH   BIT(2)
>>  #define AUTOSUSPEND_TIMEOUT                    2000
>>
>>  /* Registers and bit-fields */
>> @@ -131,6 +132,7 @@ struct s3c64xx_spi_dma_data {
>>   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
>>   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
>>   * @clk_div: Internal clock divider
>> + * @fifosize: size of the FIFO
>>   * @quirks: Bitmask of known quirks
>>   * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
>>   * @clk_from_cmu: True, if the controller does not include a clock mux and
>> @@ -149,6 +151,7 @@ struct s3c64xx_spi_port_config {
>>         int     tx_st_done;
>>         int     quirks;
>>         int     clk_div;
>> +       unsigned int fifosize;
>>         bool    high_speed;
>>         bool    clk_from_cmu;
>>         bool    clk_ioclk;
>> @@ -175,6 +178,7 @@ struct s3c64xx_spi_port_config {
>>   * @tx_dma: Local transmit DMA data (e.g. chan and direction)
>>   * @port_conf: Local SPI port configuartion data
>>   * @port_id: Port identification number
>> + * @fifosize: size of the FIFO for this port
>>   */
>>  struct s3c64xx_spi_driver_data {
>>         void __iomem                    *regs;
>> @@ -194,6 +198,7 @@ struct s3c64xx_spi_driver_data {
>>         struct s3c64xx_spi_dma_data     tx_dma;
>>         const struct s3c64xx_spi_port_config    *port_conf;
>>         unsigned int                    port_id;
>> +       unsigned int                    fifosize;
>>  };
>>
>>  static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>> @@ -403,7 +408,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
>>         struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
>>
>>         if (sdd->rx_dma.ch && sdd->tx_dma.ch)
>> -               return xfer->len > FIFO_DEPTH(sdd);
>> +               return xfer->len > sdd->fifosize;
>>
>>         return false;
>>  }
>> @@ -447,12 +452,22 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>>                                         xfer->tx_buf, xfer->len / 4);
>>                                 break;
>>                         case 16:
>> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
>> -                                       xfer->tx_buf, xfer->len / 2);
>> +                               if (sdd->port_conf->quirks &
>> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH)
>> +                                       iowrite16_32_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                                        xfer->tx_buf, xfer->len / 2);
>> +                               else
>> +                                       iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                                     xfer->tx_buf, xfer->len / 2);
>>                                 break;
>>                         default:
>> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
>> -                                       xfer->tx_buf, xfer->len);
>> +                               if (sdd->port_conf->quirks &
>> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH)
>> +                                       iowrite8_32_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                                       xfer->tx_buf, xfer->len);
>> +                               else
>> +                                       iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
>> +                                                    xfer->tx_buf, xfer->len);
>>                                 break;
>>                         }
>>                 }
>> @@ -696,7 +711,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
>>                                     struct spi_transfer *xfer)
>>  {
>>         struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
>> -       const unsigned int fifo_len = FIFO_DEPTH(sdd);
>> +       const unsigned int fifo_len = sdd->fifosize;
>>         const void *tx_buf = NULL;
>>         void *rx_buf = NULL;
>>         int target_len = 0, origin_len = 0;
>> @@ -1145,6 +1160,11 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>                 sdd->port_id = pdev->id;
>>         }
>>
>> +       if (sdd->port_conf->fifosize)
>> +               sdd->fifosize = sdd->port_conf->fifosize;
>> +       else
>> +               sdd->fifosize = FIFO_DEPTH(sdd);
>> +
>>         sdd->cur_bpw = 8;
>>
>>         sdd->tx_dma.direction = DMA_MEM_TO_DEV;
>> @@ -1234,7 +1254,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>>         dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
>>                                         sdd->port_id, host->num_chipselect);
>>         dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
>> -                                       mem_res, FIFO_DEPTH(sdd));
>> +                                       mem_res, sdd->fifosize);
>>
>>         pm_runtime_mark_last_busy(&pdev->dev);
>>         pm_runtime_put_autosuspend(&pdev->dev);
>> @@ -1362,6 +1382,18 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
>>                            s3c64xx_spi_runtime_resume, NULL)
>>  };
>>
>> +static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
>> +       .fifosize       = 64,
> 
> I think if you rework the the .fifo_lvl_mask, replacing it with
> .fifosize, you should also do next things in this series:
>   1. Rework it for all supported (existing) chips in this driver
>   2. Provide fifosize property for each SPI node for all existing dts
> that use this driver
>   3. Get rid of .fifo_lvl_mask for good. But the compatibility with
> older kernels has to be taken into the account here as well.

We can't get rid of the .fifo_lvl_mask entirely because we need to be
backward compatible with the device tree files that we have now.

> 
> Otherwise it looks like a half attempt and not finished, only creating
> a duplicated property/struct field for the same (already existing)
> thing. Because it's completely possible to do the same using just
> .fifo_lvl_mask without introducing new fields or properties. If it

Using fifo_lvl_mask works but is wrong on multiple levels.
As the code is now, the device tree spi alias is used as an index in the
fifo_lvl_mask to determine the FIFO depth. I find it unacceptable to
have a dependency on an alias in a driver. Not specifying an alias will
make the probe fail, which is even worse. Also, the fifo_lvl_mask value
does not reflect the FIFO level reg field. This is incorrect as we use
partial register fields and is misleading. Other problem is that the
fifo_lvl_mask value is used to determine the FIFO depth which is also
incorrect. The FIFO depth is dictated by the SoC implementing the IP,
not by the FIFO_LVL register field. Having in mind these reasons I
marked the fifo_lvl_mask and the port_id as deprecated in the next
patch, we shouldn't use fifo_lvl_mask or the alias anymore.

In what concerns your first 2 points, to rework all the compatibles and
to introduce a fifosize property, I agree it would be nice to do it, but
it's not mandatory, we can work in an incremental fashion. Emphasizing
what is wrong, marking things as deprecated and guiding contributors on
how things should be handled is good too, which I tried in the next
patch. Anyway, I'll check what the reworking would involve, and if I
think it wouldn't take me a terrible amount of time, I'll do it.

> seems to much -- maybe just use .fifo_lvl_mask for now, and do all
> that reworking properly later, in a separate patch series?
> 

But that means to add gs101 and then to come with patches updating what
I just proposed, and I'm not thrilled about it.

Cheers,
ta

