Return-Path: <linux-arch+bounces-1604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98083C5A9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D68C1C2414E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9E1292E8;
	Thu, 25 Jan 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdnKvbuK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37F1272A7
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194233; cv=none; b=TyVvQcs/ojYJCwIlPiPopqC/d0Dh7prYaORVtNTw6o3D4H27bLjK8aEq91BGKQV3C9+JQkN0u/VtmwXlKmp1Wx7kdOqV6Ktj77MPYkfh2ojaCArYvyf4BlKb7FhaTu04yHNAa6ejmjzBtzkZIqsHWhPTvuhPFw4tbNZaUJ/iReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194233; c=relaxed/simple;
	bh=U4kxxxoIs3/ayRfB8zDyK6XoFk+619l1Mat98X/4pcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT9IOP762VcziT5A1kxR/QcahOLun+Odj6iUn0GaOO/HL8pGdg/atXVzq6UItMAn4dkdXWyik3bzZ+ixl+ruiYLubEWGAN3MnXOPTJb/16VWqCtdotrXzQ2HSkcT1o92CsajXbXEdcL5Z1c7ni4U6vQzwnWOSxcIEu8Ns7SNWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdnKvbuK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ed218ed1eso6223825e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194228; x=1706799028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB6EsopWvtU420AL/iiMUAA67gMzrjWCXd94V6Ahudo=;
        b=vdnKvbuK3saMsbm5vqdQdGJBo2nfkm7ftV5HyDZ2ATcnL5EfvhHdqn7TUAiPdG1mzU
         srkkovV2f74WX3thfGJ+Vy1vy3bM+IGaRQo5Bnz3AIiM/UaFLz+GhqdoFcXMK3lILNVR
         SR4EDp+ZRjIRzc7yw8FnT+NzPnihaBP1/Bi1Z+4IywD/a4JnGsEzVnAdks2MNQwjbH8m
         J580kk2g87p57QISih5Euumlr5hmJi9ElrT6pHvzzUF0PSF/KPfUvTFeQ35UIxxI+Hiq
         R8leFv1M/UnsjwsZkKsE3EdrD9RuA8obz5wsGXEL4DHhGPeUCy7TlhuS7/3GQ8OA3Srs
         PFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194228; x=1706799028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB6EsopWvtU420AL/iiMUAA67gMzrjWCXd94V6Ahudo=;
        b=XwLiLfODxFCq4U6OpjdoFODjsArS16pj+i6sTWGRc6JwtGxIbHv/eHL2rhQsidTKbn
         CMM0znJxkvj9k3jdgFvdQgViUZaZk5YQiMFnA9ry/L+e5HjIN/cLiXXRvWah0WCB6cwO
         UkYgZ/Z9GoJSNTCvdfqd9BqWzwZQLikDsHnJklMv2yWI07tiMyH/aSV1/zJSex/mSgli
         +oYgFytTLp1rWyu5vvkmFgWwZi6w3onMMaMl2YY6gc8yw/Fno5/aHHXcF+FZnODWgeVN
         kSIM3JT74pScQIzmjBflS8+MIIpScAoScomGIaynJawDUCxDE1j9fgp7su4Xroc5d0w0
         Rx3A==
X-Gm-Message-State: AOJu0YzeWLSfycQepuJCMieWabLZR15TzN+ApVn6JqvUdgXiwWihLsz2
	oKyXWogQSOuy+N5cuiM/zCgaoLbWWvHA/HkxVQ25Je2QqFYmIcCHO7aBwNszZok=
X-Google-Smtp-Source: AGHT+IH50gAERtgiD46ap88LMn5K0NCn8Ty3RrpGCSOxNifjs/kTKouYIk3wNzU2y3BB26EWVSG7AQ==
X-Received: by 2002:a05:600c:9:b0:40e:59d2:354d with SMTP id g9-20020a05600c000900b0040e59d2354dmr592880wmc.151.1706194228286;
        Thu, 25 Jan 2024 06:50:28 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:27 -0800 (PST)
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
Subject: [PATCH v2 20/28] spi: s3c64xx: add support for inferring fifosize from the compatible
Date: Thu, 25 Jan 2024 14:49:58 +0000
Message-ID: <20240125145007.748295-21-tudor.ambarus@linaro.org>
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

The IP supports FIFO sizes from 8 to 256 bytes. The SoC that uses the IP
dictates the FIFO depth configuration. Add support for inferring the
FIFO size from the compatible for those SoCs that use the same FIFO
depth across all the instances of the SPI IP. Parsing of a device tree
property to determine the FIFO size for the SoCs that use different FIFO
sizes for different instances of the SPI IP will be added in a further
patch.

The scope of this patch is to break the dependency chain between the
device tree SPI alias, the fifo_lvl_mask value and the FIFO size from
the driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fc5fffc019e0..5a93ed4125b0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -132,6 +132,7 @@ struct s3c64xx_spi_dma_data {
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
+ * @fifosize: size of the FIFO
  * @quirks: Bitmask of known quirks
  * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
  * @clk_from_cmu: True, if the controller does not include a clock mux and
@@ -150,6 +151,7 @@ struct s3c64xx_spi_port_config {
 	int	tx_st_done;
 	int	quirks;
 	int	clk_div;
+	unsigned int fifosize;
 	bool	high_speed;
 	bool	clk_from_cmu;
 	bool	clk_ioclk;
@@ -176,6 +178,7 @@ struct s3c64xx_spi_port_config {
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
+ * @fifosize: size of the FIFO
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
@@ -195,6 +198,7 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
+	unsigned int			fifosize;
 };
 
 static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -404,7 +408,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
-		return xfer->len > FIFO_DEPTH(sdd);
+		return xfer->len > sdd->fifosize;
 
 	return false;
 }
@@ -702,7 +706,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
-	const unsigned int fifo_len = FIFO_DEPTH(sdd);
+	const unsigned int fifo_len = sdd->fifosize;
 	const void *tx_buf = NULL;
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
@@ -1154,6 +1158,11 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	if (sdd->port_conf->fifosize)
+		sdd->fifosize = sdd->port_conf->fifosize;
+	else
+		sdd->fifosize = FIFO_DEPTH(sdd);
+
 	sdd->cur_bpw = 8;
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
@@ -1243,7 +1252,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
 					sdd->port_id, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
-					mem_res, FIFO_DEPTH(sdd));
+		mem_res, sdd->fifosize);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.43.0.429.g432eaa2c6b-goog


