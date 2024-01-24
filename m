Return-Path: <linux-arch+bounces-1525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67F83B277
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 20:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A4E1F25583
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73099132C34;
	Wed, 24 Jan 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP8xbFd3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74565133408
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125458; cv=none; b=suZkPI97ZHyFolAGh12qyAYXvg7iHceFUrURKDXloeoJXxH9KSVeOoguag+WGqoeL+mNGu3beKLTot68gXhG3iBVG/NRotrGc6LMmllmiemLza+P2JGyFoLtTITlGNkiLe43M0bmV6ZAGveb8j2kURCBvlR18g+n3x9ogYP92rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125458; c=relaxed/simple;
	bh=Y0BInIUdk4yuoZppNHHuU1yH/Sj5lmRVubqlY2C/Ka8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swFBi3rFvJX3YN2uu2ihOjHoaE5LrbfwfCxjF+LNkAf54AUVjPhcfJlIphPRi4JsfoUDDx/UTUTndG/HNQPSVTHKwujTxI+2g1Zqo3a+dHsVcLD3Cfjsh09uTuwWMxPSZKsmvwL/RlnpHCks9W1HujZ3Oxq7++AUSSMF4W7cpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hP8xbFd3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da9c834646so5862882b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706125447; x=1706730247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbdqVnsqT1MfuMPV9yVF8MwJ35PguBwNIQWD7kRhJBg=;
        b=hP8xbFd3zHMkhMHNbiTh3xfgBl4rLOZTIC3DdOBIkEqr4TVO4DuV4wfjuq2dy0cSTc
         UJd0FK8wRU1zDR9SSdr5xGJrGpJxcsp50jc8cEgKKmWeraAJpnQZc41/h9V9P7NvMN7o
         5ELxnGrQc4tCVYVP8v34KEITMqEPVbyMtlBuN0ZbdYP+01JGxL/Xvrj63Vd1QrVXwudg
         dqALYvkIgSTlFfKWgEX9KjYYn5N1t8qkNtP7Lue78TP0NeHGKli85jk+GE+09uS4lU/D
         g/lJzwVw018N0MKlA4zOPnOJiW4pYFHk5l3KVweib6aeMhlrRQwqDE5/mBZhFIKI3NS0
         Kgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125447; x=1706730247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbdqVnsqT1MfuMPV9yVF8MwJ35PguBwNIQWD7kRhJBg=;
        b=koac8+VXrfGEOmK0rb6eeU8RHNKpGLRYJDlnKqRI2Q/SiUKIRd2y9pNEvsNkSQhl2T
         R6TmBDTmwDijUp96uiYNGnuoNJ3rgjrdIqilUSoOncjswmtCCMRSazgMf2Rf1kze905s
         bv/UvX0YC6NJQU+dZJ9QoEfvVpUqO9nkuOYaTJ8k5wNUa28vIyDvCV7gsxxCC6i7iKkw
         ex7+pg1JUhM3MBFx/g/gVD3963vCgMZdT6LaAgnfO5PUGiCoVVa5Bf3legk0kRfIKRwj
         uAGDq9obKnPdFDzoo14rJ/rYw8eLsoyXr6B7Qxxa8WDlgWRScySyaEwkURBCundPkw9L
         Ykfg==
X-Gm-Message-State: AOJu0YyLzugMCES078t0lZIAshPVPAyc2a2YzhSS+yW8eP1j+vmK09Np
	wxOneDA258YxLrKptCRZ9hhdcl8hIywoxkJ7NN+IEupi/wgGnNvj3A4Ck1ZjnVa46yGhGG+F9vU
	UzcSWhQBjVMYE7oui8/r7OIUpERF7jS7XoIVUyQWr4fyC02ZDuHM=
X-Google-Smtp-Source: AGHT+IEeKzGMh3dWiDOUkgwjs2ILhPK9w1YiiPZeGdGStN9pC4F6sjJskNUaLWaC3ky6tgs08Zs76K5q2qe/6TErc08=
X-Received: by 2002:a62:5f85:0:b0:6db:ec12:5ba4 with SMTP id
 t127-20020a625f85000000b006dbec125ba4mr51632pfb.34.1706125446716; Wed, 24 Jan
 2024 11:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-20-tudor.ambarus@linaro.org> <CAPLW+4=5ra6rBRwYYckzutawJoGw_kJahLaYmDzct2Dyuw0qQg@mail.gmail.com>
 <ab53dbc6-dad5-4278-a1d2-9f963d08eedc@linaro.org>
In-Reply-To: <ab53dbc6-dad5-4278-a1d2-9f963d08eedc@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 24 Jan 2024 13:43:55 -0600
Message-ID: <CAPLW+4njDgYO6bxVAL6hc-b_bVxjKcJnYpNGcNGpFsFg1LMc-Q@mail.gmail.com>
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

On Wed, Jan 24, 2024 at 4:40=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Hi, Sam! Thanks for the review!
>
> On 1/23/24 19:25, Sam Protsenko wrote:
> > On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> Add support for GS101 SPI. All the SPI nodes on GS101 have 64 bytes
> >> FIFOs, infer the FIFO size from the compatible. GS101 allows just 32bi=
t
> >> register accesses, otherwise a Serror Interrupt is raised. Do the writ=
e
> >> reg accesses in 32 bits.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >
> > I counted 3 different features in this patch. Would be better to split
> > it correspondingly into 3 patches, to make patches atomic:
> >
> >   1. I/O width
> >   2. FIFO size
>
> I kept these 2 in the same patch as gs101 to exemplify their use by
> gs101. But I'm also fine splitting the patch in 3, will do in v2.
>
> >   3. Adding support for gs101
> >
> > And I'm not really convinced about FIFO size change.
>
> I'll explain why it's needed below.
>
> >
> >>  drivers/spi/spi-s3c64xx.c | 50 +++++++++++++++++++++++++++++++++-----=
-
> >>  1 file changed, 43 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 62671b2d594a..c4ddd2859ba4 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -20,6 +20,7 @@
> >>
> >>  #define MAX_SPI_PORTS                          12
> >>  #define S3C64XX_SPI_QUIRK_CS_AUTO              BIT(1)
> >> +#define S3C64XX_SPI_GS1O1_32BIT_REG_IO_WIDTH   BIT(2)
> >>  #define AUTOSUSPEND_TIMEOUT                    2000
> >>
> >>  /* Registers and bit-fields */
> >> @@ -131,6 +132,7 @@ struct s3c64xx_spi_dma_data {
> >>   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regit=
er.
> >>   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> >>   * @clk_div: Internal clock divider
> >> + * @fifosize: size of the FIFO
> >>   * @quirks: Bitmask of known quirks
> >>   * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
> >>   * @clk_from_cmu: True, if the controller does not include a clock mu=
x and
> >> @@ -149,6 +151,7 @@ struct s3c64xx_spi_port_config {
> >>         int     tx_st_done;
> >>         int     quirks;
> >>         int     clk_div;
> >> +       unsigned int fifosize;
> >>         bool    high_speed;
> >>         bool    clk_from_cmu;
> >>         bool    clk_ioclk;
> >> @@ -175,6 +178,7 @@ struct s3c64xx_spi_port_config {
> >>   * @tx_dma: Local transmit DMA data (e.g. chan and direction)
> >>   * @port_conf: Local SPI port configuartion data
> >>   * @port_id: Port identification number
> >> + * @fifosize: size of the FIFO for this port
> >>   */
> >>  struct s3c64xx_spi_driver_data {
> >>         void __iomem                    *regs;
> >> @@ -194,6 +198,7 @@ struct s3c64xx_spi_driver_data {
> >>         struct s3c64xx_spi_dma_data     tx_dma;
> >>         const struct s3c64xx_spi_port_config    *port_conf;
> >>         unsigned int                    port_id;
> >> +       unsigned int                    fifosize;
> >>  };
> >>
> >>  static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
> >> @@ -403,7 +408,7 @@ static bool s3c64xx_spi_can_dma(struct spi_control=
ler *host,
> >>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_dev=
data(host);
> >>
> >>         if (sdd->rx_dma.ch && sdd->tx_dma.ch)
> >> -               return xfer->len > FIFO_DEPTH(sdd);
> >> +               return xfer->len > sdd->fifosize;
> >>
> >>         return false;
> >>  }
> >> @@ -447,12 +452,22 @@ static int s3c64xx_enable_datapath(struct s3c64x=
x_spi_driver_data *sdd,
> >>                                         xfer->tx_buf, xfer->len / 4);
> >>                                 break;
> >>                         case 16:
> >> -                               iowrite16_rep(regs + S3C64XX_SPI_TX_DA=
TA,
> >> -                                       xfer->tx_buf, xfer->len / 2);
> >> +                               if (sdd->port_conf->quirks &
> >> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WID=
TH)
> >> +                                       iowrite16_32_rep(regs + S3C64X=
X_SPI_TX_DATA,
> >> +                                                        xfer->tx_buf,=
 xfer->len / 2);
> >> +                               else
> >> +                                       iowrite16_rep(regs + S3C64XX_S=
PI_TX_DATA,
> >> +                                                     xfer->tx_buf, xf=
er->len / 2);
> >>                                 break;
> >>                         default:
> >> -                               iowrite8_rep(regs + S3C64XX_SPI_TX_DAT=
A,
> >> -                                       xfer->tx_buf, xfer->len);
> >> +                               if (sdd->port_conf->quirks &
> >> +                                   S3C64XX_SPI_GS1O1_32BIT_REG_IO_WID=
TH)
> >> +                                       iowrite8_32_rep(regs + S3C64XX=
_SPI_TX_DATA,
> >> +                                                       xfer->tx_buf, =
xfer->len);
> >> +                               else
> >> +                                       iowrite8_rep(regs + S3C64XX_SP=
I_TX_DATA,
> >> +                                                    xfer->tx_buf, xfe=
r->len);
> >>                                 break;
> >>                         }
> >>                 }
> >> @@ -696,7 +711,7 @@ static int s3c64xx_spi_transfer_one(struct spi_con=
troller *host,
> >>                                     struct spi_transfer *xfer)
> >>  {
> >>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_dev=
data(host);
> >> -       const unsigned int fifo_len =3D FIFO_DEPTH(sdd);
> >> +       const unsigned int fifo_len =3D sdd->fifosize;
> >>         const void *tx_buf =3D NULL;
> >>         void *rx_buf =3D NULL;
> >>         int target_len =3D 0, origin_len =3D 0;
> >> @@ -1145,6 +1160,11 @@ static int s3c64xx_spi_probe(struct platform_de=
vice *pdev)
> >>                 sdd->port_id =3D pdev->id;
> >>         }
> >>
> >> +       if (sdd->port_conf->fifosize)
> >> +               sdd->fifosize =3D sdd->port_conf->fifosize;
> >> +       else
> >> +               sdd->fifosize =3D FIFO_DEPTH(sdd);
> >> +
> >>         sdd->cur_bpw =3D 8;
> >>
> >>         sdd->tx_dma.direction =3D DMA_MEM_TO_DEV;
> >> @@ -1234,7 +1254,7 @@ static int s3c64xx_spi_probe(struct platform_dev=
ice *pdev)
> >>         dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI=
-%d with %d Targets attached\n",
> >>                                         sdd->port_id, host->num_chipse=
lect);
> >>         dev_dbg(&pdev->dev, "\tIOmem=3D[%pR]\tFIFO %dbytes\n",
> >> -                                       mem_res, FIFO_DEPTH(sdd));
> >> +                                       mem_res, sdd->fifosize);
> >>
> >>         pm_runtime_mark_last_busy(&pdev->dev);
> >>         pm_runtime_put_autosuspend(&pdev->dev);
> >> @@ -1362,6 +1382,18 @@ static const struct dev_pm_ops s3c64xx_spi_pm =
=3D {
> >>                            s3c64xx_spi_runtime_resume, NULL)
> >>  };
> >>
> >> +static const struct s3c64xx_spi_port_config gs101_spi_port_config =3D=
 {
> >> +       .fifosize       =3D 64,
> >
> > I think if you rework the the .fifo_lvl_mask, replacing it with
> > .fifosize, you should also do next things in this series:
> >   1. Rework it for all supported (existing) chips in this driver
> >   2. Provide fifosize property for each SPI node for all existing dts
> > that use this driver
> >   3. Get rid of .fifo_lvl_mask for good. But the compatibility with
> > older kernels has to be taken into the account here as well.
>
> We can't get rid of the .fifo_lvl_mask entirely because we need to be
> backward compatible with the device tree files that we have now.
>
> >
> > Otherwise it looks like a half attempt and not finished, only creating
> > a duplicated property/struct field for the same (already existing)
> > thing. Because it's completely possible to do the same using just
> > .fifo_lvl_mask without introducing new fields or properties. If it
>
> Using fifo_lvl_mask works but is wrong on multiple levels.
> As the code is now, the device tree spi alias is used as an index in the
> fifo_lvl_mask to determine the FIFO depth. I find it unacceptable to
> have a dependency on an alias in a driver. Not specifying an alias will
> make the probe fail, which is even worse. Also, the fifo_lvl_mask value

Ok, I think that's a valid point. I probably missed the alias part
when reading the patch description. I also understand we can't just
remove .fifo_lvl_mask right now, as we have to keep the compatibility
with older/existing out-of-tree device trees, so that the user can
update the kernel image separately.

> does not reflect the FIFO level reg field. This is incorrect as we use
> partial register fields and is misleading. Other problem is that the
> fifo_lvl_mask value is used to determine the FIFO depth which is also
> incorrect. The FIFO depth is dictated by the SoC implementing the IP,
> not by the FIFO_LVL register field. Having in mind these reasons I
> marked the fifo_lvl_mask and the port_id as deprecated in the next
> patch, we shouldn't use fifo_lvl_mask or the alias anymore.
>
> In what concerns your first 2 points, to rework all the compatibles and
> to introduce a fifosize property, I agree it would be nice to do it, but
> it's not mandatory, we can work in an incremental fashion. Emphasizing
> what is wrong, marking things as deprecated and guiding contributors on
> how things should be handled is good too, which I tried in the next
> patch. Anyway, I'll check what the reworking would involve, and if I
> think it wouldn't take me a terrible amount of time, I'll do it.
>

From what I understand, that shouldn't be very hard to do, just a
matter of adding fifosize property to all dts's existing upstream.
That would also provide a good example to follow for anyone who wants
to add the support for new compatibles. But of course I can't ask you
to do the extra work. My point is, with that item done, the first
transition step would be finished right away. And the remaining step
would be to have a strategy for .fifo_lvl_mask removal. I wonder what
maintainers can suggest on that matter, and if it's doable at all.

Btw, just a thought: maybe also add "deprecated" comment to each line
of code where .fifo_lvl_mask is being assigned, just to make sure
noone follows that style in the future (as people often tend to
copy-paste existing implementation)? Because obviously we can't remove
those lines for now.

> > seems to much -- maybe just use .fifo_lvl_mask for now, and do all
> > that reworking properly later, in a separate patch series?
> >
>
> But that means to add gs101 and then to come with patches updating what
> I just proposed, and I'm not thrilled about it.
>

Got it. That's fine with me. I think we don't have to have everything
super-granular w.r.t. patch series split. But I'd still argue that
splitting this particular patch by 3 patches would make things more
atomic and thus better.

> Cheers,
> ta

