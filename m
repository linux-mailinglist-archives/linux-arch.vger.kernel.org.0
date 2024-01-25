Return-Path: <linux-arch+bounces-1596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9683C583
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B041C24B3C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1F823AA;
	Thu, 25 Jan 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLFMDj0M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC267C091
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194225; cv=none; b=XspvUM6C8lHaeg16eadJB7UAxbfCQ4yrOCK7ZQQkbxokub0nhmMTbc5HQx5116faaNdHINS4bJPUcJGOrboprEJ6EbZwsEBoQYYM/ScSOzKlS+2pWDYo1847vcoHelV5PrwRhZ7pbAtk0U41MSN4Mz1APuHPPqGOMKVlM8rsXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194225; c=relaxed/simple;
	bh=smOZuVUAjnUrW8CLXiRwc/T6T2SJMV6zudqfogFsgUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8PPIJ1+xcYexzQGt+MO7OG3ADFkQlwjMwKEcnDlMa1YZBr64cmUoj2WE+HQQSJVr+H0dhv5ts+NDXRkkoG9Q4t6db3c4wXtFkqr0dbyS48pSZ84t2uKvEl5giO9LQE6H8FAFH16e8SAD8MFnlC9bGvOoXnGyPgEnEdt05b08rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLFMDj0M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so21431125e9.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194221; x=1706799021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMGH3dLP6JGckYmf845pnVvdK2xfKfvG+tA1Jxqwbjo=;
        b=CLFMDj0MBPELtm8GwtXRgcvKrU6exVDBFL9elWV21DXCdCwkGoVneZqjMKjitUL9dH
         ZeL3qkKa0RYNw6iudMOqMVcFEHj1FLdYRwELi5gAxHdiCj5H4UvqV90oSdjLynpBipGN
         bru5C6wTy72c3A5h59HUZWdNjj/AwoQZWz1cxmd6oRo4rKBPoNi7PN8ZMwad1yS17r15
         uP+Y091G4+aAUdRgzQOnLc75TdJ9iKMNNk0XGGEW2Hcg6moOSdjXZRDBr7A/vruG9vES
         dkzOEwRfvbVcD/GWJDb4l1zSWAvA0M5VUvm0KSJn8YwL7ytb7ghUHroRfUGeudppZljG
         4KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194221; x=1706799021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMGH3dLP6JGckYmf845pnVvdK2xfKfvG+tA1Jxqwbjo=;
        b=IstWIuODUQ5izo8URpCPqghUdw5HTqKZbfAZ75+AxX7bpBrz0s/VMWGUMUaNfT/194
         sbHm4KWAkOWKj7jdMmhLvaDwREWlNQysZ80z4rKWbxLZlxhz+s8CtQlFrkIq0XWGTU1V
         GA54ccuRgDlw2ynlsXoUlJYp09WvaCl0rYlcahCaNmMpn7ROsT1/y7SDq9XN7UVPILSy
         q/QX/Iup6GIemZhf4K05y0JhWYRjpvH7tYYNope5mTxFvX0knz8XQ3GoJ7NoA8NpFI/0
         QIfdciJLDA1a/ucb5AZKXviowS3T49d0KbyfLMPduerPhx78pOH+ODroLjs79Vxd22Cp
         In/A==
X-Gm-Message-State: AOJu0YwTDGAf6WlgEcvqCeGgvHQuErO2CSFRBhShcmjPysTwt/AN1pVC
	XFUXWQnJEON7rVmSEglqM1P4SWO7LGtQoioFZoZmMQlIVxyxMTU30oTXpW28eyE=
X-Google-Smtp-Source: AGHT+IGeP8EArDMSlTRrMTUaMcVjtEt1A1bBBuSDoS/dgt/tngq2Oix/mynKSP5H+4fbXQ/xcWQZog==
X-Received: by 2002:a05:600c:2b0d:b0:40e:8f3e:73dc with SMTP id y13-20020a05600c2b0d00b0040e8f3e73dcmr408271wme.105.1706194221342;
        Thu, 25 Jan 2024 06:50:21 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:20 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 12/28] spi: s3c64xx: check return code of dmaengine_slave_config()
Date: Thu, 25 Jan 2024 14:49:50 +0000
Message-ID: <20240125145007.748295-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return code of dmaengine_slave_config().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 107b4200ab00..48b87c5e2dd2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -297,7 +297,9 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		config.dst_maxburst = 1;
 	}
 	config.direction = dma->direction;
-	dmaengine_slave_config(dma->ch, &config);
+	ret = dmaengine_slave_config(dma->ch, &config);
+	if (ret)
+		return ret;
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


