Return-Path: <linux-arch+bounces-1689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972BF83CDA4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEBE291B8C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9E13A25F;
	Thu, 25 Jan 2024 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Br6/qOxU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88B13A256
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215170; cv=none; b=r21j1YEsVkwYnJOIINKeBzDLbtHvgKdvNS7c1xHTaKBjeKdd+fe2J35icqQT+ZRM3aa/jeOmBk09UajFIxu+QaYjvbFro+cumv7tVlbGlDwKVUbpdx91DiCc4RuePh5bwV6Sq8YheWf1iBes2DIvhn3uMJfCJs/zlTsFoo0do+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215170; c=relaxed/simple;
	bh=s+CNI3JNLu1nvooJuC97JZqUR+3i4Ph90d+KSlvbReM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5pPL4NpLIu1aBttoFrLfZP7pu5PodcgHObhrLBCLYRLA1fdQ6P14QqY/ca7kMgIh2YPfzjQian2BZNDtIgEQynunnknJPvFTDK5eMGlMamzCH/5r7lVwmU6lY3gH8IekaaUDtprsoLMA4JrEcew2qB6nnHZiDAULjg4t+jaur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Br6/qOxU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso3569127a12.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 12:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706215168; x=1706819968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pWX0tSnXNQU7YWMSUAdn8nRIoliP+SCtS9aBuv4yuU=;
        b=Br6/qOxUQF68MgLQc8X82Oaru4wWL98zhkLqH8Db5LCtWzjge2qJUyO/WTRcbeMbUs
         MhAjTmCiu0QCvWlYrbV4UjuVbzz4NcOQCncGYGiXg7ZEfCkhvX7Y1ikXItVHOwrSrSjX
         a279+fyyGjGbaplYviAxIgAC6E32nvlJ1JdNicVuwu5WQpPurC/jkfcUnpQTq/kMJcLZ
         1x4icKa5HgsHVcnglWHUGfIrX+4u+/G2tTHhTL8HN/csFGP3DnzrTJYXPXhLrbyCcONU
         HOerzGEHzfeOaiQ1YSSlWvJLdD9FhOInlQKzxHQ4g23zVNO4rhqzzbC5gbS0GA9pQXD/
         RI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215168; x=1706819968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pWX0tSnXNQU7YWMSUAdn8nRIoliP+SCtS9aBuv4yuU=;
        b=ZXXX7Fr4T8A0cH6scODDVJQgL7v9syoTpYKeQuXMGfpw7OeiqNmKKVucXICk8cKnzP
         pti/on1y+HtmhGFfM1817kCaZh1eAqaePPLisEtVMgZHd37nlfSpKd7yJd0OB7Np9iZJ
         qrwDf3Kl3zKaNp5y1FXkYK3L9lJ72slHzNywhAXshO9LFlo0RE8V22iYkcMiGmC8YLLX
         xZJXUPd1L4PezbGmnlKuzdV6iJRfK/SZ9JlFQ3ek//fWx62cY1crgrQ/KiShIqmZkbog
         GjdNIs6GnLiuAGuFwXHcUNCEnwrf3baHEKUfBjxFnfkkYwfdr0VIxjwic5SvdzA9yNpI
         i+0A==
X-Gm-Message-State: AOJu0YwK1hcxMuUzkQMwi35osRpHQP3jQ4rdbkpREAC5DB+GH/f9bseq
	Uif00u03/WSQ0XvuhCaOPYzMitgJOmlDrzFEA/5sw2tZRMpV7MZhVe8wavEA5hrD5IMG5EwckTo
	YfjgPwbS2f7ObBhcxbqhqQq7A39Jstp2iZgceYQ==
X-Google-Smtp-Source: AGHT+IFPK/mTXKZ4TYJQATnWWTb210gdrST8EgunUaaJK06mOLnEAcaZx6WF8FyEJa+mMK8KOk2avzvj3s1vIgtsrfc=
X-Received: by 2002:a17:902:b418:b0:1d7:91:4f9e with SMTP id
 x24-20020a170902b41800b001d700914f9emr316650plr.96.1706215168423; Thu, 25 Jan
 2024 12:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-19-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-19-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:39:17 -0600
Message-ID: <CAPLW+4kGTCt8cHqTzNqGZoUqw68PY3AUeZ7SzTJ6jj2im6DSGg@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] spi: s3c64xx: fix typo, s/configuartion/configuration
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
> Fix typo, s/configuartion/configuration.
>
> Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs '=
s3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index bb6d9bf390a8..692ccb7828f8 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -174,7 +174,7 @@ struct s3c64xx_spi_port_config {
>   * @cur_speed: Current clock speed
>   * @rx_dma: Local receive DMA data (e.g. chan and direction)
>   * @tx_dma: Local transmit DMA data (e.g. chan and direction)
> - * @port_conf: Local SPI port configuartion data
> + * @port_conf: Local SPI port configuration data
>   * @port_id: Port identification number
>   */
>  struct s3c64xx_spi_driver_data {
> --
> 2.43.0.429.g432eaa2c6b-goog
>

