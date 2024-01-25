Return-Path: <linux-arch+bounces-1595-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FB83C580
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD229850F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7581ABB;
	Thu, 25 Jan 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2xL2+b1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9777628
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194225; cv=none; b=kLTjAsJa9URVZ2udnMCry1xu19zjeX3NtZhs5i+xYlApHbdjhTOwdUUClGCDN2Pk6KrgiSwTW90PjwVqR5QlYuUPwuJzNXI1zZ3tPdqVbB2FBHstKVE3scQsBG70SGrFLpWynVl5b7LPy8DEhTKnj0P+Co1vUxzPNt8DSI8InqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194225; c=relaxed/simple;
	bh=eEybk3Jo0wZ9G9bdwxi2zNuwMUfX4DvNccSPl13enOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAe4hcroswMeXBPYlrelTsanvl5r1BOChFn1f0T0gJaSHcZJSYnGEs5Oupo/LIaBywMi9Rx+fjS2l00Xy66/Q4OnwO5R9VttW5cdoX3YQwReUKDPbwQqKOMBeieQymr85ftJJbc1rD9AlnWPn00E17EwYkJiFPExd196LX2iXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2xL2+b1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso81230075e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194220; x=1706799020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyD58l2q8nhDuUGflXpNsuJj2JpRaUrHNBwM4NRI1zM=;
        b=j2xL2+b1fB2fM9Ulhs2CE7knLePucDBIZ3yWSXtG9WfPPttVGDHEL5CfCWYagHi7pr
         YcDsq7sZc4To2rLl89mqq250uPaCcsfpSENQKPdTqy31SwmBMk2lehwveSOliB8aemJd
         v3ASjSJOWKMJxqK9QnmgQDnsWkyT15+kA6/eGd2cCQbrVzl6fCLW2u74lSOlgJo47opS
         Nw+tKAdF+c76rvOGz7ilf+MV21zrgYmzWEV1tYZrupM96EQWUu3HNkj5Y6M1BUf/+Epp
         h+mhqjdmCLCxaG7SbB3H+kMtM7KA31PZ7JEAVjYkejn+7bspXw5xzKUIa8XAiwpH++Wo
         /7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194220; x=1706799020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyD58l2q8nhDuUGflXpNsuJj2JpRaUrHNBwM4NRI1zM=;
        b=Q+coGXWOI4CymgpN/wXgKfiJUdUX3StQBFCkkSFYP8o8WNMtB0jGokeaFAFXZubBSn
         C03yHbx5VVzaMJLMUi5pCLyPHJw6YnVMQBtFp+I2X2wx+TIPr/XCV++zjc7bof4174X7
         PqQ+7HlXK8Zm/OZMQuTnvJraoZSv2y5wVXuioOczA6OPfvzjrUjc/02x3CXlwX1JoPc8
         DDIAns2EyIGRoR15m1I6UJqNX4cFvg5k2vWuuEeUVd9VyFTPNdXo8z+Iy5wsEV4XkBrg
         c1ADjCc66qL2Njo4f+FRxxtrIhUMpHpuryPnUdPALu8EDouGObeZbOpBT4T94KWuhOjN
         CrNA==
X-Gm-Message-State: AOJu0YyXtSYDoCZcgs5xqnSd4M2c2hKMA3FznyOK+qrWxdj7nAnfqmz4
	rrxFYClI3omT3gT3s3dlmyT3+xFmi8t4hkI52b8DclxRjpQjGVcgUKbsL30nlzk=
X-Google-Smtp-Source: AGHT+IFZ3UUBgZszn/1wxPMDahDYbmeO132hJ61mryKHgvR3GcuAuY7RIRfAUkP4M4TdvC1n34cQtw==
X-Received: by 2002:a05:600c:2a4a:b0:40e:46d5:144f with SMTP id x10-20020a05600c2a4a00b0040e46d5144fmr290304wme.373.1706194220403;
        Thu, 25 Jan 2024 06:50:20 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:19 -0800 (PST)
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
Subject: [PATCH v2 11/28] spi: s3c64xx: move common code outside if else
Date: Thu, 25 Jan 2024 14:49:49 +0000
Message-ID: <20240125145007.748295-12-tudor.ambarus@linaro.org>
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

Move common code outside if else to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b048e81e6207..107b4200ab00 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -286,20 +286,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-		config.direction = dma->direction;
 		config.src_addr = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 		config.src_addr_width = sdd->cur_bpw / 8;
 		config.src_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
-		config.direction = dma->direction;
 		config.dst_addr = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
 		config.dst_addr_width = sdd->cur_bpw / 8;
 		config.dst_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	}
+	config.direction = dma->direction;
+	dmaengine_slave_config(dma->ch, &config);
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


