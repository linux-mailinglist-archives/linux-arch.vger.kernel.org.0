Return-Path: <linux-arch+bounces-1727-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD4583E26C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDCE1C2176C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6B224DF;
	Fri, 26 Jan 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDUE7lCj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BB224CC
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297017; cv=none; b=dgHQVP3OrSt49bdRfNiCiRL+hpddtlEkXV8RTK6Rcx1aZv7f8sAo5ElKxOpvNJujHbZUOiAjgR1x331lkzfJDIW2EK9ykZQ92vrsMFvoaHid/RYXsDAfwZwF3JofJ7quelIffZx8TcwITucZMvyfXLpO2c957uNf5/4qkaVY1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297017; c=relaxed/simple;
	bh=TtYMN3GShHRZCc1Drpo4X80E/CnRWO/M7L6zj37FsEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UobI2VILhH4DFIZLPSHpHxKqA+rgBH6I8aqTudd1EO3SE5f0V+wMBFWPPtkt7HOT7lUiUdIfmHjupPdQnp0JhIanWD4MzaXNYl2g0q6Ybq2OVekGtLdec1UY9PjluN/kPyEUQlTfFEYBrUHMi/BVSP3HYHaZgrfGOP8WPLnsCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDUE7lCj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso550608a91.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706297015; x=1706901815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pci4l1Zh4vLDqka8iPuTXs2/4isIF6x5bfsHnKL71CI=;
        b=zDUE7lCjImOXhTG4/rDFQGpnDXGjcRVnYsBekoisGzpNNit2dPB/9KRa0O6ecOBXQ8
         o3GCo/zm7MlY3gDBs35gV8FdxGL/ELKZl+o2H7I7tMQHDaB+gpQ8A8XRc9d/VIoFb67l
         gFYUj7St4fv6ZwgwBHNheVvc0+/XRrdY7scmXIvmRDwkY5VWWGCcjOsjjaBC13Go72oS
         JNvQp2zzs57LEpc6Va4FvIKXkNKPB3rjta7oJIMWevnyaWa81GW3TnFEpf4N/2MG9TCl
         uUHp4Qe2S3TdlDwuymM0VbJCACrHaVr20uJ5fqHY2Jmlzj2lHTp4xKfMyyqbl9Yu1c4a
         qUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297015; x=1706901815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pci4l1Zh4vLDqka8iPuTXs2/4isIF6x5bfsHnKL71CI=;
        b=cCgWQlof30qKWqP+2ZRnvWPUnfIAhPRTuJZbb14fHnQ/Y5/h83sb4zNm5TovqwjIOe
         cJRyRSeY+eXrDFyOZLMO/Exn+5xMdE9/qzq6DGZRQefnBeLHq2Qb6bXUYgnQ0kK9ao9l
         BBQEq2ayWyCOiEUAbpyKxhfchSwbAOC8lp2HCILy6QlHljmnm40itqJsZb7FpuhZRe6g
         weu15vDL2iZjqd2o6Flbjf6rXnTbK9U/MQwWoMmU97JufBJUEqi0rWNT+cCjO2UIhnCi
         nz2yZL+VnD5J74CaNTBEFT7qsg7HiBv6taobclCMbZR8u3LzDoWeGQqVnVZEgTSGP6mE
         611w==
X-Gm-Message-State: AOJu0YwKGtQUpi+5kQDsihRHduO484P71idQkLkdAnmUB7tMpSpdQovX
	JQrhFwu+pV9ZAoZWiYB6LmKEGDwXzn+7j75rpLfDwi5XqL554WKSjc3u8Rwc9qdOgkL3fhBKazP
	jOw67uHyIYxARlPLvGV3pgLTOPsGYNuEDzxwxjg==
X-Google-Smtp-Source: AGHT+IFyVG+TAGYzMvyT5Wl++btmO1JDRT8TGoWOEDu8WDjuLaYb7yHih34riUmaKg0bO8OqD8M0VDuhQbwcWOYhlCA=
X-Received: by 2002:a17:90a:b28d:b0:294:3cb1:a8c5 with SMTP id
 c13-20020a17090ab28d00b002943cb1a8c5mr351761pjr.28.1706297015515; Fri, 26 Jan
 2024 11:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org> <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
In-Reply-To: <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 13:23:24 -0600
Message-ID: <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:33=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:
>
> > Allow SoCs that have multiple instances of the SPI IP with different
> > FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
> > device tree property. With this we can break the dependency between the
> > SPI alias, the fifo_lvl_mask and the FIFO size.
>
> OK, so we do actually have SoCs with multiple instances of the IP with
> different FIFO depths (and who knows what else other differences)?

I think that's why we can see .fifo_lvl_mask[] with different values
for different IP instances. For example, ExynosAutoV9 has this (in
upstream driver, yes):

    .fifo_lvl_mask =3D { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff,
0x7f, 0x7f, 0x7f, 0x7f, 0x7f},

And I'm pretty sure the comment (in struct s3c64xx_spi_port_config)
for .fifo_lvl_mask field is not correct anymore:

     * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in
SPI_STATUS register.

Maybe it used to indicate the bit number in SPI_STATUS register for
{TX|RX}_FIFO_LVL fields, but not anymore. Nowadays it looks like
.fifo_lvl_mask just specifies FIFO depth for each IP instance.

