Return-Path: <linux-arch+bounces-1483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EB839995
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02334B2D802
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E992823DC;
	Tue, 23 Jan 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CasgT+PY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6EA50A71
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037967; cv=none; b=iU4osjtc7meHerOtuQVlMzE5V97v8At/WdqF4I6F8160om59TRN0IephZ7Rn9jan/k42pF24fllzwKy3RGTw8CKoQre/qqI8bwv8NATBafZzAlwIAzcJGWnOUBIdrHFcvDN9g94l6d0L12hD01W0ZU78XeMtbQtpJskn6Fab9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037967; c=relaxed/simple;
	bh=5FBFXSyj94x51VgxUD4rusLgZttfd6JjBhpIl2yLV40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXSlM4kVqYMkILoVet1B7AJDqOAK+athXw7g+YNJSr58f1SqSYZgl7IaVpRIxK32ytJck10T04AIgfPoi3CgWUFmO6/AfyJOzf6KOe2BgXbNE3uEg6CTwl8ubjRnuOsu6w7tpP99wtOkc0+l5Hew6Sglim+TWwNSpRfkUTRGhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CasgT+PY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d6ff29293dso30902985ad.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706037963; x=1706642763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuHlV1lpJmfb9OJ+O6FIwlNwW4G3p0JEzL0apMB/mzw=;
        b=CasgT+PYAPMcdH/JyoEsGpD5RmVMm3UkS1VuSisq6AQX4f9fU1f1+fWs6BN9vAj5tP
         b/qlhkzckrYeh63O+IEY4hor76YphAlR2l9TK4ZV8oN7e+ve5PkGXDSSfncmXVKhufpN
         R9KIm5V04N9S4izyhkJ0T9Q82md6bWAeE5DpPoIc7ko3iwRUER3W78lWYkt9v1XoHtgk
         1c9bJsxPbL0SYz0rs3W6EvldAh5S8LhVfW+EBlRI7VzkskPBU6Ix0Ve0i7B0K0NfAA+f
         URDS7hqZ4panIUU108o5H7LUBf06LCgqtA/kDGdeQae4i8lY4ng7MYTL0tKAm5VYO2GV
         ZJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037963; x=1706642763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuHlV1lpJmfb9OJ+O6FIwlNwW4G3p0JEzL0apMB/mzw=;
        b=Ws09gITFAwnZ2Xwpf5dgECb0ODZjoztdBr0USUoRonYGKkqSHn2Ew8mJ6+b0+7yzj7
         xbFlKuU/hIL7yZp5JDh+UA0lVO3UX/ibfpdNFrJAA4/fO9T73hcDdMh6ncJeSpOTKjm0
         +QBnqaR12VkbzpThb7rIB2LcVuWiywvW0W32n81rSh6nHoBAdQnm/pd+iDIwzeqTGyJk
         9K7A9W7mEovqxz7AU8RBfrJvzrAqBiZxHRmUaewTHdW5Za2kgLAJwRf7RhcYmMc31pnW
         0cwcyg/WeJ/OaxFy/1D/uYHe/+N9B9EW/tAlf59OKcJo3iHUy+Y35tDQZq/JeV8leAXk
         MRdA==
X-Gm-Message-State: AOJu0YyBT0w7C/qJwiuE8OJKaj6LzMAGCHCzckyZ7VVZB6V+Qb4U+1eR
	0q/QEG1p+QtWqskJ1TeAGffnpd5Qmr4CYwwFyd/GgT7LijeaBA1rar0Lzh5Y5oLiSW6Td/N66RS
	FGk/Nn8SxuULiXgwx8YtcbWArcgrkflBjxGSBrA==
X-Google-Smtp-Source: AGHT+IEHfXLoZyhqfDv3qI1ZFPPtY8soGvcCPAk/KuzY/2oAvjcwCUC2GWTSCgmoUJlPsdsFnca814M9v+7iD4fc0Bk=
X-Received: by 2002:a17:90a:49cb:b0:28c:f2f5:a966 with SMTP id
 l11-20020a17090a49cb00b0028cf2f5a966mr2997435pjm.10.1706037963650; Tue, 23
 Jan 2024 11:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-20-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-20-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:25:52 -0600
Message-ID: <CAPLW+4=5ra6rBRwYYckzutawJoGw_kJahLaYmDzct2Dyuw0qQg@mail.gmail.com>
Subject: Re: [PATCH 19/21] spi: s3c64xx: add support for google,gs101-spi
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
> Add support for GS101 SPI. All the SPI nodes on GS101 have 64 bytes
> FIFOs, infer the FIFO size from the compatible. GS101 allows just 32bit
> register accesses, otherwise a Serror Interrupt is raised. Do the write
> reg accesses in 32 bits.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

I counted 3 different features in this patch. Would be better to split
it correspondingly into 3 patches, to make patches atomic:

  1. I/O width
  2. FIFO size
  3. Adding support for gs101

And I'm not really convinced about FIFO size change.

>  drivers/spi/spi-s3c64xx.c | 50 +++++++++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 62671b2d594a..c4ddd2859ba4 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -20,6 +20,7 @@
>
>  #define MAX_SPI_PORTS                          12
>  #define S3C64XX_SPI_QUIRK_CS_AUTO              BIT(1)
> +#define S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH   BIT(2)
>  #define AUTOSUSPEND_TIMEOUT                    2000
>
>  /* Registers and bit-fields */
> @@ -131,6 +132,7 @@ struct s3c64xx_spi_dma_data {
>   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
>   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
>   * @clk_div: Internal clock divider
> + * @fifosize: size of the FIFO
>   * @quirks: Bitmask of known quirks
>   * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
>   * @clk_from_cmu: True, if the controller does not include a clock mux a=
nd
> @@ -149,6 +151,7 @@ struct s3c64xx_spi_port_config {
>         int     tx_st_done;
>         int     quirks;
>         int     clk_div;
> +       unsigned int fifosize;
>         bool    high_speed;
>         bool    clk_from_cmu;
>         bool    clk_ioclk;
> @@ -175,6 +178,7 @@ struct s3c64xx_spi_port_config {
>   * @tx_dma: Local transmit DMA data (e.g. chan and direction)
>   * @port_conf: Local SPI port configuartion data
>   * @port_id: Port identification number
> + * @fifosize: size of the FIFO for this port
>   */
>  struct s3c64xx_spi_driver_data {
>         void __iomem                    *regs;
> @@ -194,6 +198,7 @@ struct s3c64xx_spi_driver_data {
>         struct s3c64xx_spi_dma_data     tx_dma;
>         const struct s3c64xx_spi_port_config    *port_conf;
>         unsigned int                    port_id;
> +       unsigned int                    fifosize;
>  };
>
>  static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
> @@ -403,7 +408,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller=
 *host,
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
>
>         if (sdd->rx_dma.ch && sdd->tx_dma.ch)
> -               return xfer->len > FIFO_DEPTH(sdd);
> +               return xfer->len > sdd->fifosize;
>
>         return false;
>  }
> @@ -447,12 +452,22 @@ static int s3c64xx_enable_datapath(struct s3c64xx_s=
pi_driver_data *sdd,
>                                         xfer->tx_buf, xfer->len / 4);
>                                 break;
>                         case 16:
> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len / 2);
> +                               if (sdd->port_conf->quirks &
> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH)
> +                                       iowrite16_32_rep(regs + S3C64XX_S=
PI_TX_DATA,
> +                                                        xfer->tx_buf, xf=
er->len / 2);
> +                               else
> +                                       iowrite16_rep(regs + S3C64XX_SPI_=
TX_DATA,
> +                                                     xfer->tx_buf, xfer-=
>len / 2);
>                                 break;
>                         default:
> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DATA,
> -                                       xfer->tx_buf, xfer->len);
> +                               if (sdd->port_conf->quirks &
> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH)
> +                                       iowrite8_32_rep(regs + S3C64XX_SP=
I_TX_DATA,
> +                                                       xfer->tx_buf, xfe=
r->len);
> +                               else
> +                                       iowrite8_rep(regs + S3C64XX_SPI_T=
X_DATA,
> +                                                    xfer->tx_buf, xfer->=
len);
>                                 break;
>                         }
>                 }
> @@ -696,7 +711,7 @@ static int s3c64xx_spi_transfer_one(struct spi_contro=
ller *host,
>                                     struct spi_transfer *xfer)
>  {
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
> -       const unsigned int fifo_len =3D FIFO_DEPTH(sdd);
> +       const unsigned int fifo_len =3D sdd->fifosize;
>         const void *tx_buf =3D NULL;
>         void *rx_buf =3D NULL;
>         int target_len =3D 0, origin_len =3D 0;
> @@ -1145,6 +1160,11 @@ static int s3c64xx_spi_probe(struct platform_devic=
e *pdev)
>                 sdd->port_id =3D pdev->id;
>         }
>
> +       if (sdd->port_conf->fifosize)
> +               sdd->fifosize =3D sdd->port_conf->fifosize;
> +       else
> +               sdd->fifosize =3D FIFO_DEPTH(sdd);
> +
>         sdd->cur_bpw =3D 8;
>
>         sdd->tx_dma.direction =3D DMA_MEM_TO_DEV;
> @@ -1234,7 +1254,7 @@ static int s3c64xx_spi_probe(struct platform_device=
 *pdev)
>         dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d=
 with %d Targets attached\n",
>                                         sdd->port_id, host->num_chipselec=
t);
>         dev_dbg(&pdev->dev, "\tIOmem=3D[%pR]\tFIFO %dbytes\n",
> -                                       mem_res, FIFO_DEPTH(sdd));
> +                                       mem_res, sdd->fifosize);
>
>         pm_runtime_mark_last_busy(&pdev->dev);
>         pm_runtime_put_autosuspend(&pdev->dev);
> @@ -1362,6 +1382,18 @@ static const struct dev_pm_ops s3c64xx_spi_pm =3D =
{
>                            s3c64xx_spi_runtime_resume, NULL)
>  };
>
> +static const struct s3c64xx_spi_port_config gs101_spi_port_config =3D {
> +       .fifosize       =3D 64,

I think if you rework the the .fifo_lvl_mask, replacing it with
.fifosize, you should also do next things in this series:
  1. Rework it for all supported (existing) chips in this driver
  2. Provide fifosize property for each SPI node for all existing dts
that use this driver
  3. Get rid of .fifo_lvl_mask for good. But the compatibility with
older kernels has to be taken into the account here as well.

Otherwise it looks like a half attempt and not finished, only creating
a duplicated property/struct field for the same (already existing)
thing. Because it's completely possible to do the same using just
.fifo_lvl_mask without introducing new fields or properties. If it
seems to much -- maybe just use .fifo_lvl_mask for now, and do all
that reworking properly later, in a separate patch series?

> +       .rx_lvl_offset  =3D 15,
> +       .tx_st_done     =3D 25,
> +       .clk_div        =3D 4,
> +       .high_speed     =3D true,
> +       .clk_from_cmu   =3D true,
> +       .has_loopback   =3D true,
> +       .quirks         =3D S3C64XX_SPI_QUIRK_CS_AUTO |
> +                         S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH,
> +};
> +
>  static const struct s3c64xx_spi_port_config s3c2443_spi_port_config =3D =
{
>         .fifo_lvl_mask  =3D { 0x7f },
>         .rx_lvl_offset  =3D 13,
> @@ -1452,6 +1484,10 @@ static const struct platform_device_id s3c64xx_spi=
_driver_ids[] =3D {
>  };
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] =3D {
> +       {
> +               .compatible =3D "google,gs101-spi",
> +               .data =3D &gs101_spi_port_config,
> +       },
>         {
>                 .compatible =3D "samsung,s3c2443-spi",
>                 .data =3D &s3c2443_spi_port_config,
> --
> 2.43.0.429.g432eaa2c6b-goog
>

