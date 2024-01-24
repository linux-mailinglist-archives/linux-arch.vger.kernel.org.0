Return-Path: <linux-arch+bounces-1506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E27983A549
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0421F22B18
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA218E2A;
	Wed, 24 Jan 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqGqtlSM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23401B597
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088109; cv=none; b=KmEbuQ7S22SWeJ0tpMwciHQCXlehrCKAVSywWSkf8GtjceYD6GdkePcsuoLVioKn5RCDTIYl1kCn6q/nnbr3i6d2qzk4ZmlUpOUimkLLtW1hiLALzytKKlO/Khdt4eGtOX5t2dOQuTScCA2SWmCOK095ufUwhDCxVvhQPWHi/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088109; c=relaxed/simple;
	bh=eF+zjiEZUQuKsPtg6bAJeNDrxHW3hVhj8Si24oj2+Z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiUDcVHfEQJrDrbJrIKsYKiRizzb9xNIPoLr6xPAYm+mfQhfOqlgg6HKgjoasN53tJTTsy0gb52b53Pe0U+O+VyKC2jTHC6XZ4sSy2+kKEasmEL4iVKcLgwzhrbLyxPUfyzAuGGlpjNoBaHm7t80YZr7Tt0y6fNyb5hwiCIGn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqGqtlSM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso5653972e87.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706088105; x=1706692905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IC++pEzL4ZnERNcYi29RUcf4swv7sgMAYOvkDj2rEI0=;
        b=uqGqtlSMa38hdsgpvsN2tMQiJ80+RdNx3Tmk/6FuI8BJw2K9hrFnim09ElK7tdplUz
         i8+klwrWgorbEuPAI2v0Hh1tyZ3EZ5U/JR6B70gu0hyM++U8I1TNiojF6oTWvS/MUX9o
         4KKSfRm+6mlgLmMnb8eXdKoJbsbinj5cevwI0DcfSIVgK+DELDto8FEOeUpu2rW4pEwG
         vSLcwuxy5LTqymLeKgMcDm1+VBx5kUUN81Fike9LdfypAeZG1y/Z57jcNVutDd4tt9Cn
         wfvapFDUjSLusXfQMxLKo6Kb/yYti/XBnn5mj4zS6C5lQwrLO56AjkDPq6ij/yXJSxRG
         gXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088105; x=1706692905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC++pEzL4ZnERNcYi29RUcf4swv7sgMAYOvkDj2rEI0=;
        b=TmUepzpAwNIxFECZTBFTZftDPVLq0QmJm+gG08NxAwJDv63ftNGjxLiEG6WfZmeiwq
         wR+GYUK+iruV58qlLJqIncublBQbDbk1oWrRWXM6aGjPa+m3/Mxw3ki+c8PjlXSnnPV/
         0u/H5Y4Ovo3r5w5eiCZRnMo2tM/+96aQ7qwFhe9SeuOBUjedDepjWEAUs/VlzaXWcWX4
         pPxQgboAKgYLxgtn7eeoSgubjlvDAEOMhWTYcYaJCPWN8L1+9z5A2BsU3cVjyr17Ju5v
         2E1AGvjUT1ERRd1DivDdnW8DE0UZNV2lISSf0b6Nw24dpRuVgL2na9QSZ0IGpJFd6HVi
         637Q==
X-Gm-Message-State: AOJu0YwaYY3ycQuDg0cLagJCadK5ToMD9SGUn282uYFvG7QahyhmwtRy
	LvOyfvDtI9zESh+lET5WYDGYXrDQZZFcH3vyCbFt30izhzETLndPj81WegJT2tI=
X-Google-Smtp-Source: AGHT+IEoYvX5ImUeYU+16v/15tdK/S4Fr5ldyMNN4WvuO6GvQxlrpO1w2+L1HPxfqJrOi6yJv0guLA==
X-Received: by 2002:a05:6512:6d3:b0:50e:e0af:4efb with SMTP id u19-20020a05651206d300b0050ee0af4efbmr3997062lff.104.1706088104912;
        Wed, 24 Jan 2024 01:21:44 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm48914383wmo.7.2024.01.24.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:21:44 -0800 (PST)
Message-ID: <4b8bc0bf2f1fd87183276816522e92f7b0c3b1fd.camel@linaro.org>
Subject: Re: [PATCH 08/21] spi: s3c64xx: move error check up to avoid
 rechecking
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, broonie@kernel.org, 
	andi.shyti@kernel.org, arnd@arndb.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org,  alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arch@vger.kernel.org, peter.griffin@linaro.org,
 semen.protsenko@linaro.org,  kernel-team@android.com,
 willmcvicker@google.com
Date: Wed, 24 Jan 2024 09:21:43 +0000
In-Reply-To: <20240123153421.715951-9-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
	 <20240123153421.715951-9-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Tue, 2024-01-23 at 15:34 +0000, Tudor Ambarus wrote:
> @@ -538,13 +538,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_d=
river_data *sdd,
> =C2=A0			cpu_relax();
> =C2=A0			status =3D readl(regs + S3C64XX_SPI_STATUS);
> =C2=A0		}
> -
> =C2=A0	}
> =C2=A0
> -	/* If timed out while checking rx/tx status return error */
> -	if (!val)
> -		return -EIO;
> -

This change behaviour of this function. The loop just above adjusts val and=
 it is used to
determine if there was a timeout or not:

	if (val && !xfer->rx_buf) {
		val =3D msecs_to_loops(10);
		status =3D readl(regs + S3C64XX_SPI_STATUS);
		while ((TX_FIFO_LVL(status, sdd)
			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
		       && --val) {
			cpu_relax();
			status =3D readl(regs + S3C64XX_SPI_STATUS);
		}


That doesn't work anymore now.

Cheers,
Andre'


