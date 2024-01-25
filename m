Return-Path: <linux-arch+bounces-1606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061683C5B6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F071F27127
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B712AAC4;
	Thu, 25 Jan 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSIWXzIi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088D7CF3C
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194235; cv=none; b=JOJOlktk5GY0qThS+geRJfrhT0x32hOpmvdNROEbCSiHMxj2TY/iwOBYMTqmvnOkVUdoy3mELhYlIsTZvXsJr52HCXG757o/yo3QYYDd2KyP4dTvZtbut4ys7+NgpIo5/OfA7qay0w/3bxL6/s7jK1SVJTn3ShlnPbYFRw8D2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194235; c=relaxed/simple;
	bh=qxc7sbniUDyQV364D2RhlbEnDsCBptc6ZkMAL9cwgPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF2185jHMs5zsp2QGs5sLQpjvyAkkSruIIgSFglOQBU+SKib9kQKZ6JaTp6oFsIbIjVv5pqfWUqi6dzILTfMp/tc/b2nPvdbhgdXKAkVXjzxJHuYQopkEK+rHfNrZSHDBvvEQ0A03baUSysd1ARMxYCuIBDeNPYDEm1haykSyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSIWXzIi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so50901215e9.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194230; x=1706799030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtNtOah4q0k+JGCPgSMuID7OmymIk1nPxql5oxULauE=;
        b=aSIWXzIi7O/UnNLSv4Rh5ATOd4wCcaWnjqDZBdTRxOlvWjxPvczxvBOLPFH5k0vxup
         pK2NE0/7bxvVBwiqSHG48/cFwVRwX4i4v375ZV1c+n9UYugs4WxalG9MRJJ4OEboZRRP
         XiumQUndHvjPv8UbnhbFBe5qO1ewhW5qfcZajqMKUiW5N4laYUkrEJ7xTdgeSOW2PLST
         q2p5nW++lIkfkvK9tQAh50b++1Q4q6hCHvf4MjQcxoYbLRjt8K0ShOL+behXHYbC7AVh
         8GSx1E1yOUT75VTtwu0DGJtrWJMqjOu7VAkkZ0O3+X830hGoDtRqzkxb5FYjGsKCGP+2
         RjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194230; x=1706799030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtNtOah4q0k+JGCPgSMuID7OmymIk1nPxql5oxULauE=;
        b=hUUgFJ4767EYRS40EwDZCbGhOR5iJ6BFYeBfVoukbJ2NlMmhKJcqZ2+jyvsxP2ti/R
         RA5IBG7D8AI6xzDGSYXCaxj0pjSORqLDk/3WWe6V6N6Pefj/jD8GMxWddNa+SpxY7S6t
         AFKo6f/dfCH9PJW1jsRIX4Jy8RLt6Z7wxXkLYIBILNtlrPUvxpXYjamvvgnEhPAfy+CD
         LkK7RIoF+m21koWKIjmM23Sb6chxXRt7Thlno9q3/1FlwlKOX+zTeESHoObRzMf4hkaN
         GFWah1gnWqz9PAODvoMTz2kJBc/fdhlzLnaHjqqjX03RQC5ugjMb7hCeBXkGTcVW+u7C
         mjRA==
X-Gm-Message-State: AOJu0YzMVcZBZSkOzalwiqN+LmB3qNwQD6rB+m+Nbz/eFMwmYIPjM/x7
	yg6EdvLNbYK3/JYArgVwVSp2oZb21T6M4GenypEPMqmTyEuFHe3s6K9BqLolxy8=
X-Google-Smtp-Source: AGHT+IHbggNgNKsbigSPf6qnK9OAL7RN+AXot/5cZEw4S6FkZlNDOIGl4jCVyK8EYQh9E6qMazSeuQ==
X-Received: by 2002:a05:600c:384e:b0:40e:c1a9:6829 with SMTP id s14-20020a05600c384e00b0040ec1a96829mr575554wmr.120.1706194230059;
        Thu, 25 Jan 2024 06:50:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:29 -0800 (PST)
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
Subject: [PATCH v2 22/28] spi: s3c64xx: drop dependency on of_alias where possible
Date: Thu, 25 Jan 2024 14:50:00 +0000
Message-ID: <20240125145007.748295-23-tudor.ambarus@linaro.org>
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

Remove the dependency on the OF alias for SoCs that use the same FIFO
size for all the instances of the SPI IP. The driver failed to probe if
an SPI alias was not provided, which is obviously wrong.

We now let the SPI core determine the SPI alias, either by getting the
alias ID, or by allocating a dynamic bus number when the alias is
absent.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b86eb0a77b60..7a99f6b02319 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -107,10 +107,9 @@
 
 #define S3C64XX_SPI_FBCLK_MASK			GENMASK(1, 0)
 
-#define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
+#define FIFO_DEPTH(x) (((x) >> 1) + 1)
 
 #define S3C64XX_SPI_POLLING_SIZE	32
 
@@ -197,7 +196,6 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	rx_dma;
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
-	unsigned int			port_id;
 	unsigned int			fifosize;
 };
 
@@ -1110,6 +1108,37 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
+static int s3c64xx_spi_get_fifosize(const struct platform_device *pdev,
+				    struct s3c64xx_spi_driver_data *sdd)
+{
+	const struct s3c64xx_spi_port_config *port = sdd->port_conf;
+	const int *fifo_lvl_mask = port->fifo_lvl_mask;
+	struct device_node *np = pdev->dev.of_node;
+	int id;
+
+	if (!np) {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
+		id = pdev->id;
+		sdd->fifosize = FIFO_DEPTH(fifo_lvl_mask[id]);
+		return 0;
+	}
+
+	if (port->fifosize) {
+		sdd->fifosize = port->fifosize;
+		return 0;
+	}
+
+	id = of_alias_get_id(np, "spi");
+	if (id < 0)
+		return dev_err_probe(&pdev->dev, id,
+				     "Failed to get alias id\n");
+	sdd->fifosize = FIFO_DEPTH(fifo_lvl_mask[id]);
+
+	return 0;
+}
+
 static int s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res;
@@ -1142,34 +1171,20 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	sdd = spi_controller_get_devdata(host);
 	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
+	ret = s3c64xx_spi_get_fifosize(pdev, sdd);
+	if (ret)
+		return ret;
+
 	sdd->host = host;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
-	if (pdev->dev.of_node) {
-		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Failed to get alias id\n");
-		sdd->port_id = ret;
-	} else {
-		if (pdev->id < 0)
-			return dev_err_probe(&pdev->dev, -EINVAL,
-					     "Negative platform ID is not allowed\n");
-		sdd->port_id = pdev->id;
-	}
-
-	if (sdd->port_conf->fifosize)
-		sdd->fifosize = sdd->port_conf->fifosize;
-	else
-		sdd->fifosize = FIFO_DEPTH(sdd);
-
 	sdd->cur_bpw = 8;
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
 	host->dev.of_node = pdev->dev.of_node;
-	host->bus_num = sdd->port_id;
+	host->bus_num = -1;
 	host->setup = s3c64xx_spi_setup;
 	host->cleanup = s3c64xx_spi_cleanup;
 	host->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
@@ -1250,7 +1265,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
-					sdd->port_id, host->num_chipselect);
+		host->bus_num, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
 		mem_res, sdd->fifosize);
 
-- 
2.43.0.429.g432eaa2c6b-goog


