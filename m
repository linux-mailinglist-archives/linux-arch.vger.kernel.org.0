Return-Path: <linux-arch+bounces-1608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FE83C5BE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E0A2994A2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2912BEAF;
	Thu, 25 Jan 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxgHLeg5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FC129A83
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194236; cv=none; b=RbY+JDcSuTtl1UbWQZZSpOhjWvkWNGZzq0Uno2aXNRbv1dhxrZWUk8g4QBpDOaSCI1l79suJCG6fRZqwJ9MeB6vyfLVAZWkZOPydUYrZ4OHDyq/L66htXjpvyAM2neT4Z5ibr8Rr9D2HaY5onTaqNEmoEev/Y6RAurXDNypMwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194236; c=relaxed/simple;
	bh=FwiKR/hTM3KwzQ+LcNwdGXXUdm43g3tAGpf1bERFSaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOEnjJf5upXyxhnnoK+0QAAcDMM6yF94Yz7J2AcNhgQRmvsQZIAB7iSPidVkePWZvZw+1Gpq+35PiutHgRFIv5OhHto7obRuYAD9d5vUEgkefJUqbEstgqOTLyMCpKxErNzKgV9Kxi0qKBip7q6VqiIsUgeFFT/sAwUC2cGPf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RxgHLeg5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e76626170so75554055e9.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194232; x=1706799032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApOZNfBccU6dqvedRX4iUyVPu1nTeSF4guAYCuO4Cl4=;
        b=RxgHLeg5iNoo1P2Ld9aBETNG84wqGenK1cU7fDpMRMmSR4Mb9srJLUdx69jr3uOzYb
         lTrnLsDUv20dsqXqm+bAKhnINaf3zgW2gXPVRrcrPrpJXO7uDrC+78VNDckWRQB7U4kq
         YxRt8a1JpoqKanV1ZY++ACN38T8RG440qoNRLBmX5D3NVwG0wyk1Tht3UosEuzENCusD
         eI6ZXR3t2NT8/CUY1qd2kyJW88IUDgzRXaURxdf5SeDO9slEYg2ZhcalBbgXOIXqJItJ
         vAbZaltfq2LlzcmXY4PXhZSs7d7RM3mHSCgZUQEoKSMB91SOqpriLsMVQfJgQdkPvFOE
         Z2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194232; x=1706799032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApOZNfBccU6dqvedRX4iUyVPu1nTeSF4guAYCuO4Cl4=;
        b=llT6PypAlXX4ptyz+qxal5f1JUtQWkCE+m2FvQ7MuRLy4Y1m9a5g3+8nkEx4x+cYed
         dyCN7LuZ3MJKEVvk2eG4iGouYxFPfxwVD45XtzUKiUY65cE4fyIpEfYF8YlAgi7rhqz+
         4zg7ced0wjt4ON2OjEFPi+E8+0WM1iShFc9i8hqI9z76kSeCB2jfwsOe+0LkbHmoAQzt
         Et9NErxOcx5Jy3UKTBwxq+SNRyFCnVsbbW3jLHu1ZJsFTOHFAWg8zB4sWV8cgY8zuPxT
         b4tX0obKAINHY1baUh1RA+X0vAxCJPn9PACafU3EMiL9XbN+nKHVoVglqp6i5IAP+YbP
         YNSw==
X-Gm-Message-State: AOJu0Yxb+j4lp8IQ99U0SlWzDJuptRMoZatbopoRxJnWalsrPHOYdMoS
	zaLL88okk+ytUDZtcrgBmNH5WpipWGcR1W+moM8tZiGZTl6tc5r8q1dR+eqIz1E=
X-Google-Smtp-Source: AGHT+IGyrJbT7ENzixl1qRIV4teC3M8kK7663WjQeVwHKN5MMuO5Gp4c8gAac9UV5b3ihgXW5+2V7w==
X-Received: by 2002:a05:600c:4515:b0:40e:ccf7:3618 with SMTP id t21-20020a05600c451500b0040eccf73618mr664568wmo.23.1706194232646;
        Thu, 25 Jan 2024 06:50:32 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:31 -0800 (PST)
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
Subject: [PATCH v2 24/28] spi: s3c64xx: mark fifo_lvl_mask as deprecated
Date: Thu, 25 Jan 2024 14:50:02 +0000
Message-ID: <20240125145007.748295-25-tudor.ambarus@linaro.org>
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

The SPI of_alias was used as an index into the fifo_lvl_mask to
determine the FIFO depth of the SPI node. Changing the alias ID into the
device tree would make the driver choose a wrong FIFO size
configuration, if not accessing past the fifo_lvl_mask array boundaries.
Not specifying an SPI alias would make the driver fail to probe, which
is also wrong.

We now have the infrastructure to correctly determine the FIFO size.
SoCs that use the same FIFO size across all the instances of the SPI IP
shall infer the FIFO size from the compatible, thus by setting
``s3c64xx_spi_port_config.fifosize``. SoCs that have instances of the
SPI IP with different FIFO sizes shall specify the FIFO size to each SPI
device tree node by using the ``samsung,spi-fifosize`` property.

Mark fifo_lvl_mask as deprecated.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3e7797d915c5..fa70c6aab7c2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -127,7 +127,8 @@ struct s3c64xx_spi_dma_data {
 
 /**
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
- * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
+ * @fifo_lvl_mask: [DEPRECATED] Bit-mask for {TX|RX}_FIFO_LVL bits in
+ *                 SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
@@ -1415,6 +1416,7 @@ static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1423,6 +1425,7 @@ static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1433,6 +1436,7 @@ static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1443,6 +1447,7 @@ static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
@@ -1465,6 +1470,7 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. */
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f},
 	.rx_lvl_offset	= 15,
-- 
2.43.0.429.g432eaa2c6b-goog


