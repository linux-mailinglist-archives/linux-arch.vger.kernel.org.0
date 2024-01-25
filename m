Return-Path: <linux-arch+bounces-1598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95E83C58E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD512299102
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2E86128;
	Thu, 25 Jan 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHkHVRvV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181D7F7E8
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194227; cv=none; b=BsKBow6b4X+3h+Zm71le51CCQaEKh6Q/p6IUtReR8hdUlN+eS/DSxXUEkovgpgR2BVXOTnLjQidHVRQj/moTRASVbIPHq5uamtlBLwlI5vv2Q9Ic8ClWhAGF+jYOiUuaeppf6uYLIOJrd2QExWIGoIqXuPiYVV+NzAHRimgkAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194227; c=relaxed/simple;
	bh=hXVQ0xlIaveU3XkFuaJGe+I4uTpyEmgE+f4FfHSp1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQeESNWw1U0WmsuH5yzXrThH1rQ2UFsYL/5sIhz06dN0aYL49Xu9NQzo0yMwyA/6Y43ik6CDnc1mv+BFMzhF7wIuG/e1W4OSqM4aplI5W/iHuAo49HjmD6LHk00Ov2bbCsCvlbp1kpufRLTE60phNFuExDbn9f3cbpGFF60OJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHkHVRvV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so75534555e9.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194223; x=1706799023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwSZ9ii64mt7cJNVg0lI8ru0eSDBGUd0YlY2mDEiodU=;
        b=rHkHVRvVsq/fC5NwydsH3ES17+/nzhdUHaLe+oOTHj5w0PmXxcNR8wWQoJeh7MIDZ5
         hA/9qXxG78lTObSK3IaxMWsI2ExH6gXe9QagmA3o6znxab8Rw8onBngLEBEnykfLoivO
         vGvnDuKXH4xW3nQX+yhx1OVKPlCUe6Kwr8gWkDCaEyyHdeFwbBrkvvIBvbGgqWuS4cRi
         tM4h2JNKBVxPMJLSbfAHxAJNDolHMVg8t1DzOLfZT0SRb+Wyt2i/+FdpptNst5eP/emG
         +fC3KEHQ3mBYnYw0PJCmAmtN2HoUZCG3ayZzq5T7Z/yr4Zs0aE7sWA4rPRtJf83GqbcL
         8Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194223; x=1706799023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwSZ9ii64mt7cJNVg0lI8ru0eSDBGUd0YlY2mDEiodU=;
        b=JdwMcch1ZRhxEAeptLQb2vPP9ToRYQTyvupyeBZmW5UCUYSpNKnByNFjzoNbH2TMZC
         aA1muMgr6R3IQgDIefNPMa7dBPq4dkED+8ISwjeub8CRqSBa2AQsrLo73VV3K+i0Waad
         BA5WH7vo5OS9I1qPcn/CRFG+rmNVDWunVoG3Fb1Xi4lgbRjXMlA1XskP18mdt62H+gsL
         x4HaKDiOKIRfWkjtVSLMT65b0miJ7+ticRObhzURDMiSyX6di6sTaciWHzaOlBA2Op4U
         ztgV46MZsku1hH3HAVZSfEbPqSXrn4MiGWAHiR1kMUoh4As+ycAwXAKVDe233cFkVUur
         JRpQ==
X-Gm-Message-State: AOJu0YzVGZUXOoM4OYu7ekQUXyxG3Gb4L4txKC+q96otRD6o5p6Yhumv
	7cumvIjf5CPZ43B7sasLMRh08DgmuJ47GgLDI754FiYQlxs0b3pOQepBHJkDsRU=
X-Google-Smtp-Source: AGHT+IHU3uE9VctkwSLc7sy1ouZi/e0ls1mgPCFV1inwCVVGb/ieTXa3QkXnQoUQMDecFLIT7pf3+w==
X-Received: by 2002:a05:600c:458b:b0:40e:af93:54f1 with SMTP id r11-20020a05600c458b00b0040eaf9354f1mr697668wmo.5.1706194223137;
        Thu, 25 Jan 2024 06:50:23 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:22 -0800 (PST)
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
Subject: [PATCH v2 14/28] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
Date: Thu, 25 Jan 2024 14:49:52 +0000
Message-ID: <20240125145007.748295-15-tudor.ambarus@linaro.org>
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

Don't monopolize the name. Prepend the driver prefix to the function
name.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 25d642f99278..447320788697 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -273,8 +273,8 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
-			struct sg_table *sgt)
+static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
+			       struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
@@ -440,7 +440,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -472,7 +472,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


