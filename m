Return-Path: <linux-arch+bounces-1457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AD8392FF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C811C2393E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2D60DDB;
	Tue, 23 Jan 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3/WodQi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA960877
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024078; cv=none; b=WPEKcpRvbaKP79yWqO1ZdfoaP+elLMt3+xJPF2a735Qb35ZGBR3XHrw8hAUK/dYG5AxzcntgUXJtmV07iqLMbeh23lLuW7XDW9R+Qmh3UADAbycjBOiTKUvAtnm/QgkhX1Cbyj7/caVPfaeHRquAIfBgJwFk611Xcq5+DVgiR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024078; c=relaxed/simple;
	bh=kmgOrT3krOJWvTwK+X1AtX3qiEqbI54+0/wZYGPMmHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siOJtgsQhdQijsVK46CUVDfDd0Q9kFjRIcRhtcJxC9CYmyqbCRxb8W8DIFzEFJgaJ5vvwNekw9Eea3R33Cy5NTewsbTP8+KtHbMqPYz+WEqioDiqEgp1/K5pZwpx1DdWwvaqQBVyYS4vd482yxswqa/8530nRCsCYhPkDH3ZW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3/WodQi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33924df7245so3264433f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 07:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024073; x=1706628873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vqPNM01RVbT6WZVcBqWSaQXCmIfHRqWLTf3/DbElPA=;
        b=C3/WodQiKOwIEnkGtMUqOHE+zCfL90xbuszWyynIr7zToqF9GqTO7P/ZHQjfSj6Sfv
         Z5RYmZEeAIDN5HEU0T/LgPBpP/SFHqFzp7DXknPbgqGiTN+xyq35lR+sCtDOci8osvV0
         bJR2Y977+wBxHdZ2jA5ch7+GgOZiAbj+RiUJKcLK/oZUUn7iDFQpwXjfYhXxD8aWslnH
         Dpri0YzHc0uhnwXfQhCcO+MmXBiRx/D1hmSZHKFqRgbUFkuqVzjcmmRjoSWlez+9IlIN
         +inklQNL0MkjicstKC0jqKB9iPaytlrRyi5EPRiAVnv8xjChrOgcuQ1cN015Ln+QxFkm
         3hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024073; x=1706628873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vqPNM01RVbT6WZVcBqWSaQXCmIfHRqWLTf3/DbElPA=;
        b=DhU9JfNEhxA8pYD2NhBW5rjIr5ycPGiIu0qgo79Q9L4YnOacuTP+0tHCSGjx2V56xj
         P25eVZSXZsPIh2mkYA9o5TviS5sAFzxFeb+zxejAw9xgeR6gv+9B7pDRgJLrowensHC+
         5paOubJqZEBgHPJRLu7zuCdx+oA7cKRXXXS6k2OBpoS//cfGv3NiNwXV6+rJKrm18lqJ
         EiDa3YksIM5BlZu2swFT+iX4OoulxZXJVaUb9VMDWyv3tMAhwXLgR9w7gN7bTypYZUYm
         qsI8R0+s2YXhZ9EVyAsIMRc8TDssb35WA5WThf2OuR7bp2AnbcHxnmM3SXmdZqRi0K/s
         aCnA==
X-Gm-Message-State: AOJu0Yxx7aCztk0cRcZOitYZ/jalrHSWrxWhXqIyrgoRuwdfUwjl4XEn
	ha49YIxbjT1rmsTtlaBMTUZCnFEEbZHLtv2n2XXkE5TTLVI9buegYNri8EPB8IA=
X-Google-Smtp-Source: AGHT+IEJSsm0JwEG/PJT9w/zaoV5lSJHX44wrK9tJed6SVlw4AsZr/9ynIHMW3t3RqWwTYCplqwvhg==
X-Received: by 2002:a05:600c:4f95:b0:40e:bf94:be7a with SMTP id n21-20020a05600c4f9500b0040ebf94be7amr248043wmq.92.1706024073235;
        Tue, 23 Jan 2024 07:34:33 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:32 -0800 (PST)
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
Subject: [PATCH 09/21] spi: s3c64xx: use full mask for {RX, TX}_FIFO_LVL
Date: Tue, 23 Jan 2024 15:34:08 +0000
Message-ID: <20240123153421.715951-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI_STATUSn.{RX, TX}_FIFO_LVL fields  show the data level in the RX and
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
index 128c3b8211ce..a06b83b952c6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -77,6 +77,8 @@
 #define S3C64XX_SPI_INT_RX_FIFORDY_EN		BIT(1)
 #define S3C64XX_SPI_INT_TX_FIFORDY_EN		BIT(0)
 
+#define S3C64XX_SPI_ST_RX_FIFO_LVL		GENMASK(23, 15)
+#define S3C64XX_SPI_ST_TX_FIFO_LVL		GENMASK(14, 6)
 #define S3C64XX_SPI_ST_RX_OVERRUN_ERR		BIT(5)
 #define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		BIT(4)
 #define S3C64XX_SPI_ST_TX_OVERRUN_ERR		BIT(3)
@@ -107,9 +109,6 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> 6) & FIFO_LVL_MASK(i))
-#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
-					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
 #define S3C64XX_SPI_POLLING_SIZE	32
@@ -218,7 +217,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sdd) && loops--);
+	} while (FIELD_GET(S3C64XX_SPI_ST_TX_FIFO_LVL, val) && loops--);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -227,7 +226,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-		if (RX_FIFO_LVL(val, sdd))
+		if (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, val))
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
@@ -498,10 +497,11 @@ static u32 s3c64xx_spi_wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
 
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
@@ -532,7 +532,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 	if (!xfer->rx_buf) {
 		val = msecs_to_loops(10);
 		status = readl(regs + S3C64XX_SPI_STATUS);
-		while ((TX_FIFO_LVL(status, sdd)
+		while ((FIELD_GET(S3C64XX_SPI_ST_TX_FIFO_LVL, status)
 			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
 		       && --val) {
 			cpu_relax();
@@ -562,7 +562,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 
 	/* sleep during signal transfer time */
 	status = readl(regs + S3C64XX_SPI_STATUS);
-	if (RX_FIFO_LVL(status, sdd) < xfer->len)
+	if (FIELD_GET(S3C64XX_SPI_ST_RX_FIFO_LVL, status) < xfer->len)
 		usleep_range(time_us / 2, time_us);
 
 	if (use_irq) {
@@ -574,7 +574,8 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
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


