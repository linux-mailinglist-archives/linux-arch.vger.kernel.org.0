Return-Path: <linux-arch+bounces-1593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5A83C577
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306991F23281
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1C6EB40;
	Thu, 25 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQ7H6Z/H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA5768F3
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194223; cv=none; b=uMRS+DlZ28kAa6QtlzOeWdaa8WPNkH73oQLhhM1272rmaoPP8C5pOc6QZiyF5jAqSCTHTdigU1uXF+LrWBFW1cNqeyiAVDtV90USBnocU8F7vHF0hP6+vNsKPq4/FS8K4E7Q1Cin8O+opXexAbWtfYaTNxHKdGomgLtKC2Hjgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194223; c=relaxed/simple;
	bh=w4wbpDA2gBhvtRw9Xybiyt31iPuBrNlezxXZBJcmNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoGhgEXAIV/RK3XV4u5wYONDmbAX7Zqmf21i6FwkXi8R6aEHpgu5nRrE9ByyI85TGdhGzxVMXW2JIXPVfUL7FGhJLgMDaskimUh2Av5QLDIkIkJwyiZg7rgc3Wg8Ct0j1FhtzmbY4uENkE7q3ahYj02lRYxSkMc3sABjxmiTBKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQ7H6Z/H; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33937dd1b43so3269154f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194219; x=1706799019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YK4QrRGKXAEq9cj4wcWVcTQyistBUqZRkAhUjBW1qI=;
        b=cQ7H6Z/H8CbgU1J8XA8rNClguzV19C8TBWWVAAqBfbNY6juDvaryNH3Av6MX1k+c9D
         6MScW4AQjWanLMr/tSuqO9n3NlDAaljnNNb3BYgD/xMWLaYOp4RJCHpZYLOe5gM/BaUE
         tdPmheFD1cpSaGWVA2RP+al9s51+wlfFYYvh7qjYhcgVlj0OGR2zSr2jjoAp4BqlC+z3
         stQ6Pi9fd/YvYz/DFZj1tUhiqq6EBMrtqKWaa1W2ZjQgVMR+JqdBRAbtnDcoJVtN5o1s
         6UeHBw02KZpLb1iVEya0UAvs2SLlguLsF/1Ohncef28rbZSHmKgH+aqsZdikRtJuZYYh
         WbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194219; x=1706799019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YK4QrRGKXAEq9cj4wcWVcTQyistBUqZRkAhUjBW1qI=;
        b=ceAOf5OcjCu+nlxfUsvlX0QpeW0ty0V0IsTG0vL2NrpvX+DLy7+5vO0fkh6Qm+EMlY
         ocnffkkm9yoY8r1R885qAzs70oOvW+wGdnl1FOU8WVLY9PncHA8L6LJufLCh6w7D/td+
         eC5ZabvU4V6lju/2hB02VdVPt96IgmWsDCpcUP8YaFT+iVQowavnRq3FboPCwjMlDPcx
         Yp5hZAwIoyvtdTx6Jpv06OpVy8tt5Y7ftITDe88t6QyeGrDNB9WypO0DGXH/Qv5fsBGh
         7eoo8ujCGEwHVXUeud11tplJ1p9lxIlvd1v+aSje5URqWJKM/3jZCpnJ1LQE0uEl0/GV
         lahg==
X-Gm-Message-State: AOJu0YxXMJh8xffxGBvw87N0D4jSb537JzZ3/89GAs/ZQ7APxNYRrfiS
	0Gg/30MalOVsOoiFsawYl5XZHGKV75r1tu05p69KiVnnYawE70h4rRWfVOi7Mb1CHUuMXuedZFs
	32iE=
X-Google-Smtp-Source: AGHT+IHBMCy9GK8hqa3QrrWY639ZY25SNTX03FHAyLMwegK28Rkz0B8Db77Il1eM2GZxRB78phDFnA==
X-Received: by 2002:a5d:4f90:0:b0:337:d932:4980 with SMTP id d16-20020a5d4f90000000b00337d9324980mr863025wru.143.1706194219101;
        Thu, 25 Jan 2024 06:50:19 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:18 -0800 (PST)
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
Subject: [PATCH v2 10/28] spi: s3c64xx: use full mask for {RX, TX}_FIFO_LVL
Date: Thu, 25 Jan 2024 14:49:48 +0000
Message-ID: <20240125145007.748295-11-tudor.ambarus@linaro.org>
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

SPI_STATUSn.{RX, TX}_FIFO_LVL fields show the data level in the RX and
TX FIFOs. The IP supports FIFOs from 8 to 256 bytes, but apart from the
MODE_CFG.{RX, TX}_RDY_LVL fields that configure the {RX, TX} FIFO
trigger level in the interrupt mode, there's nothing in the registers
that configure the FIFOs depth. Is the responsibility of the SoC that
integrates the IP to dictate the FIFO depth and of the SPI driver to
make sure it doesn't bypass the FIFO length.

{RX, TX}_FIFO_LVL was used to pass the FIFO length information based on
the IP configuration in the SoC. Its value was defined so that it
includes the entire FIFO length. For example, if one wanted to specify a
64 FIFO length (0x40), it wold configure the FIFO level to 127 (0x7f).
This is not only wrong, because it doesn't respect the IP's register
fields, it's also misleading. Use the full mask for the
SPI_STATUSn.{RX, TX}_FIFO_LVL fields. No change in functionality is
expected.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d046810da51f..b048e81e6207 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -78,6 +78,8 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		BIT(1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		BIT(0)
 
+#define S3C64XX_SPI_ST_RX_FIFO_LVL		GENMASK(23, 15)
+#define S3C64XX_SPI_ST_TX_FIFO_LVL		GENMASK(14, 6)
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		BIT(5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		BIT(4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		BIT(3)
@@ -108,9 +110,6 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
-#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
-					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
 #define S3C64XX_SPI_POLLING_SIZE	32
@@ -219,7 +218,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sdd) && loops--);
+	} while (FIELD_GET(S3C64XX_SPI_ST_TX_FIFO_LVL, val) && loops--);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -228,7 +227,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-		if (RX_FIFO_LVL(val, sdd))
+		if (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, val))
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
@@ -499,10 +498,11 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 
 	do {
 		status = readl(regs + S3C64XX_SPI_STATUS);
-	} while (RX_FIFO_LVL(status, sdd) < max_fifo && --val);
+	} while (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < max_fifo &&
+		 --val);
 
 	/* return the actual received data length */
-	return RX_FIFO_LVL(status, sdd);
+	return FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status);
 }
 
 static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
@@ -533,7 +533,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 	if (val && !xfer->rx_buf) {
 		val = msecs_to_loops(10);
 		status = readl(regs + S3C64XX_SPI_STATUS);
-		while ((TX_FIFO_LVL(status, sdd)
+		while ((FIELD_GET(S3C64XX_SPI_ST_TX_FIFO_LVL, status)
 			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
 		       && --val) {
 			cpu_relax();
@@ -568,7 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 
 	/* sleep during signal transfer time */
 	status = readl(regs + S3C64XX_SPI_STATUS);
-	if (RX_FIFO_LVL(status, sdd) < xfer->len)
+	if (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < xfer->len)
 		usleep_range(time_us / 2, time_us);
 
 	if (use_irq) {
@@ -580,7 +580,8 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	val = msecs_to_loops(ms);
 	do {
 		status = readl(regs + S3C64XX_SPI_STATUS);
-	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
+	} while (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < xfer->len &&
+		 --val);
 
 	if (!val)
 		return -EIO;
-- 
2.43.0.429.g432eaa2c6b-goog


