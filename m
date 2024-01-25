Return-Path: <linux-arch+bounces-1594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95283C579
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E6A1F2273B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E57E761;
	Thu, 25 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnsXTg0F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F074E2A
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194223; cv=none; b=IgHkHVaOG6P3KAIdBDorA4KlfH9L7+rkIky/Cj5Ef06tmkz3Z5ggJAj+Jtdn0D2mgsf0BYR10gegvu6XvaYIsJNgftiJV2TFcOSX5PjuwilAlsdJH2jXTwem+PNpbKnqJcyvsdue/1KRRLRh+oKG0HVr6extnftXMRo1J43cbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194223; c=relaxed/simple;
	bh=z0tIOvqT4CNXcveS/Z70/sud59rHMdrGEcjWJhIhygw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+1NxhHaYVb5PzYlV6Krv7VOIZDPBVcaNJJekY56ZOg4f1p2lovBqwebFTvCDw0hhTOh/5qSMU6X3iyWALJuSHWPoQZ908tr9TJnfdo325geRUYvz3qR4LY8wpMh+XxXk5Ic5CiK9AP/ViWjdEksGoYNijzmUQgqQEvPu7Ik8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZnsXTg0F; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ed252edd7so6242135e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194218; x=1706799018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZXJNN8RsKvqmzY53Rpr/ylvEMUsn8dtNExD4VM14us=;
        b=ZnsXTg0FcThCaokeRZ3WkWMsMTZ3q8dnXoqn/vQhedhwC5OYv+eY6oIBVVVgJbkT5v
         uDGHM9hf2+ulDFtecDe1ued9QX4aGhjADS1ZDRNryGIEF+a1Sv4Y7c4cBopLW/uJRIKr
         7o0aooilHhOc0nM14aYCkMKucTbNfaEhsZDBbWi25ATM0Ln8M+sL+/BSB1J9OhtnG/g9
         a6D34nVpNw3l9newHBfBIJdahnV7RwRvjo/qWP/mea2bDQ3sMz33l1gI/tXEIplYy84R
         3VKyexCIJckn0qiC1hY1Q9e0bvVT9DzTbEtYeMYEwr8/ozgc+KNb45mLJtWMZ50IqmYe
         6Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194218; x=1706799018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZXJNN8RsKvqmzY53Rpr/ylvEMUsn8dtNExD4VM14us=;
        b=JnjLhB+LqTHjwAkHczuCbkJo/YuRVAx306Mqeh6+aYDo55Wz+wHiw8NP5Y+17l1L1C
         TjP/99swhK3ZOt1Cq6l1+5SzeUM58/F+ZUJzZlch92+LnvcwqTx53J3tRYf5sV9V8z6B
         HSHz2zD/YxsS2HsYPXoOA/7riJxse9C1GNts8oCUxc+y0voT9ZX2k8bLFZLjzk1+KTbv
         +msJgsgocfd2OVk7jxg5+XWlsfhHuHM9p24BcmLCSanMqBw2YHj4bRBceGb9I73aYA3+
         Iv9qhDApKCdp7RP9buqJ5xPb0A8spFVIAZdIVunCGQxrjoYNWDMld9Ky4NbgQQdy/9Ff
         vDuQ==
X-Gm-Message-State: AOJu0Yz3tCiRgVPe0uksDEvX9eAtVbcQeF+/WuwEmrVu4Q0kADp7aHsH
	rN1mxtnHtzFH6BXal12QVmg3wk9qbcOuTUgqmrFK7ZtZWiNbn9fjOoUotsY6F+A=
X-Google-Smtp-Source: AGHT+IGE2p0rhmfKyGJh626c+fCS3Cqjbbl0jGZGEMf+qcbsHy/GxSTypKUSAtPDh1RphFOQ/vLjIw==
X-Received: by 2002:a05:600c:3c9b:b0:40e:4181:a549 with SMTP id bg27-20020a05600c3c9b00b0040e4181a549mr380407wmb.163.1706194218101;
        Thu, 25 Jan 2024 06:50:18 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:17 -0800 (PST)
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
Subject: [PATCH v2 09/28] spi: s3c64xx: use bitfield access macros
Date: Thu, 25 Jan 2024 14:49:47 +0000
Message-ID: <20240125145007.748295-10-tudor.ambarus@linaro.org>
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

Use the bitfield access macros in order to clean and to make the driver
easier to read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 196 +++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 97 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1e44b24f6401..d046810da51f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -4,6 +4,7 @@
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -18,91 +19,91 @@
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
-#define MAX_SPI_PORTS		12
-#define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-#define AUTOSUSPEND_TIMEOUT	2000
+#define MAX_SPI_PORTS				12
+#define S3C64XX_SPI_QUIRK_CS_AUTO		BIT(1)
+#define AUTOSUSPEND_TIMEOUT			2000
 
 /* Registers and bit-fields */
 
-#define S3C64XX_SPI_CH_CFG		0x00
-#define S3C64XX_SPI_CLK_CFG		0x04
-#define S3C64XX_SPI_MODE_CFG		0x08
-#define S3C64XX_SPI_CS_REG		0x0C
-#define S3C64XX_SPI_INT_EN		0x10
-#define S3C64XX_SPI_STATUS		0x14
-#define S3C64XX_SPI_TX_DATA		0x18
-#define S3C64XX_SPI_RX_DATA		0x1C
-#define S3C64XX_SPI_PACKET_CNT		0x20
-#define S3C64XX_SPI_PENDING_CLR		0x24
-#define S3C64XX_SPI_SWAP_CFG		0x28
-#define S3C64XX_SPI_FB_CLK		0x2C
-
-#define S3C64XX_SPI_CH_HS_EN		(1<<6)	/* High Speed Enable */
-#define S3C64XX_SPI_CH_SW_RST		(1<<5)
-#define S3C64XX_SPI_CH_SLAVE		(1<<4)
-#define S3C64XX_SPI_CPOL_L		(1<<3)
-#define S3C64XX_SPI_CPHA_B		(1<<2)
-#define S3C64XX_SPI_CH_RXCH_ON		(1<<1)
-#define S3C64XX_SPI_CH_TXCH_ON		(1<<0)
-
-#define S3C64XX_SPI_CLKSEL_SRCMSK	(3<<9)
-#define S3C64XX_SPI_CLKSEL_SRCSHFT	9
-#define S3C64XX_SPI_ENCLK_ENABLE	(1<<8)
-#define S3C64XX_SPI_PSR_MASK		0xff
-
-#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		(0<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	(1<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_WORD		(2<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_MASK		(3<<29)
-#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE		(0<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
+#define S3C64XX_SPI_CH_CFG			0x00
+#define S3C64XX_SPI_CLK_CFG			0x04
+#define S3C64XX_SPI_MODE_CFG			0x08
+#define S3C64XX_SPI_CS_REG			0x0C
+#define S3C64XX_SPI_INT_EN			0x10
+#define S3C64XX_SPI_STATUS			0x14
+#define S3C64XX_SPI_TX_DATA			0x18
+#define S3C64XX_SPI_RX_DATA			0x1C
+#define S3C64XX_SPI_PACKET_CNT			0x20
+#define S3C64XX_SPI_PENDING_CLR			0x24
+#define S3C64XX_SPI_SWAP_CFG			0x28
+#define S3C64XX_SPI_FB_CLK			0x2C
+
+#define S3C64XX_SPI_CH_HS_EN			BIT(6)	/* High Speed Enable */
+#define S3C64XX_SPI_CH_SW_RST			BIT(5)
+#define S3C64XX_SPI_CH_SLAVE			BIT(4)
+#define S3C64XX_SPI_CPOL_L			BIT(3)
+#define S3C64XX_SPI_CPHA_B			BIT(2)
+#define S3C64XX_SPI_CH_RXCH_ON			BIT(1)
+#define S3C64XX_SPI_CH_TXCH_ON			BIT(0)
+
+#define S3C64XX_SPI_CLKSEL_SRCMSK		GENMASK(10, 9)
+#define S3C64XX_SPI_ENCLK_ENABLE		BIT(8)
+#define S3C64XX_SPI_PSR_MASK			GENMASK(15, 0)
+
+#define S3C64XX_SPI_MODE_CH_TSZ_MASK		GENMASK(30, 29)
+#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		0
+#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	1
+#define S3C64XX_SPI_MODE_CH_TSZ_WORD		2
+#define S3C64XX_SPI_MAX_TRAILCNT_MASK		GENMASK(28, 19)
+#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		GENMASK(18, 17)
+#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE		0
+#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	1
+#define S3C64XX_SPI_MODE_BUS_TSZ_WORD		2
 #define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
-#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
-#define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
-#define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
-#define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
-#define S3C64XX_SPI_MODE_4BURST			(1<<0)
-
-#define S3C64XX_SPI_CS_NSC_CNT_2		(2<<4)
-#define S3C64XX_SPI_CS_AUTO			(1<<1)
-#define S3C64XX_SPI_CS_SIG_INACT		(1<<0)
-
-#define S3C64XX_SPI_INT_TRAILING_EN		(1<<6)
-#define S3C64XX_SPI_INT_RX_OVERRUN_EN		(1<<5)
-#define S3C64XX_SPI_INT_RX_UNDERRUN_EN		(1<<4)
-#define S3C64XX_SPI_INT_TX_OVERRUN_EN		(1<<3)
-#define S3C64XX_SPI_INT_TX_UNDERRUN_EN		(1<<2)
-#define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
-#define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
-
-#define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
-#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
-#define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
-#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		(1<<2)
-#define S3C64XX_SPI_ST_RX_FIFORDY		(1<<1)
-#define S3C64XX_SPI_ST_TX_FIFORDY		(1<<0)
-
-#define S3C64XX_SPI_PACKET_CNT_EN		(1<<16)
+#define S3C64XX_SPI_MODE_SELF_LOOPBACK		BIT(3)
+#define S3C64XX_SPI_MODE_RXDMA_ON		BIT(2)
+#define S3C64XX_SPI_MODE_TXDMA_ON		BIT(1)
+#define S3C64XX_SPI_MODE_4BURST			BIT(0)
+
+#define S3C64XX_SPI_CS_NSC_CNT_MASK		GENMASK(9, 4)
+#define S3C64XX_SPI_CS_NSC_CNT_2		2
+#define S3C64XX_SPI_CS_AUTO			BIT(1)
+#define S3C64XX_SPI_CS_SIG_INACT		BIT(0)
+
+#define S3C64XX_SPI_INT_TRAILING_EN		BIT(6)
+#define S3C64XX_SPI_INT_RX_OVERRUN_EN		BIT(5)
+#define S3C64XX_SPI_INT_RX_UNDERRUN_EN		BIT(4)
+#define S3C64XX_SPI_INT_TX_OVERRUN_EN		BIT(3)
+#define S3C64XX_SPI_INT_TX_UNDERRUN_EN		BIT(2)
+#define S3C64XX_SPI_INT_RX_FIFORDY_EN		BIT(1)
+#define S3C64XX_SPI_INT_TX_FIFORDY_EN		BIT(0)
+
+#define S3C64XX_SPI_ST_RX_OVERRUN_ERR		BIT(5)
+#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		BIT(4)
+#define S3C64XX_SPI_ST_TX_OVERRUN_ERR		BIT(3)
+#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		BIT(2)
+#define S3C64XX_SPI_ST_RX_FIFORDY		BIT(1)
+#define S3C64XX_SPI_ST_TX_FIFORDY		BIT(0)
+
+#define S3C64XX_SPI_PACKET_CNT_EN		BIT(16)
 #define S3C64XX_SPI_PACKET_CNT_MASK		GENMASK(15, 0)
 
-#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR		(1<<4)
-#define S3C64XX_SPI_PND_TX_OVERRUN_CLR		(1<<3)
-#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR		(1<<2)
-#define S3C64XX_SPI_PND_RX_OVERRUN_CLR		(1<<1)
-#define S3C64XX_SPI_PND_TRAILING_CLR		(1<<0)
+#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR		BIT(4)
+#define S3C64XX_SPI_PND_TX_OVERRUN_CLR		BIT(3)
+#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR		BIT(2)
+#define S3C64XX_SPI_PND_RX_OVERRUN_CLR		BIT(1)
+#define S3C64XX_SPI_PND_TRAILING_CLR		BIT(0)
 
-#define S3C64XX_SPI_SWAP_RX_HALF_WORD		(1<<7)
-#define S3C64XX_SPI_SWAP_RX_BYTE		(1<<6)
-#define S3C64XX_SPI_SWAP_RX_BIT			(1<<5)
-#define S3C64XX_SPI_SWAP_RX_EN			(1<<4)
-#define S3C64XX_SPI_SWAP_TX_HALF_WORD		(1<<3)
-#define S3C64XX_SPI_SWAP_TX_BYTE		(1<<2)
-#define S3C64XX_SPI_SWAP_TX_BIT			(1<<1)
-#define S3C64XX_SPI_SWAP_TX_EN			(1<<0)
+#define S3C64XX_SPI_SWAP_RX_HALF_WORD		BIT(7)
+#define S3C64XX_SPI_SWAP_RX_BYTE		BIT(6)
+#define S3C64XX_SPI_SWAP_RX_BIT			BIT(5)
+#define S3C64XX_SPI_SWAP_RX_EN			BIT(4)
+#define S3C64XX_SPI_SWAP_TX_HALF_WORD		BIT(3)
+#define S3C64XX_SPI_SWAP_TX_BYTE		BIT(2)
+#define S3C64XX_SPI_SWAP_TX_BIT			BIT(1)
+#define S3C64XX_SPI_SWAP_TX_EN			BIT(0)
 
-#define S3C64XX_SPI_FBCLK_MSK			(3<<0)
+#define S3C64XX_SPI_FBCLK_MASK			GENMASK(1, 0)
 
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
@@ -112,18 +113,13 @@
 					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
-#define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
-#define S3C64XX_SPI_TRAILCNT_OFF	19
-
-#define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
-
 #define S3C64XX_SPI_POLLING_SIZE	32
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 #define is_polling(x)	(x->cntrlr_info->polling)
 
-#define RXBUSY    (1<<2)
-#define TXBUSY    (1<<3)
+#define RXBUSY    BIT(2)
+#define TXBUSY    BIT(3)
 
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
@@ -342,8 +338,9 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 		} else {
 			u32 ssel = readl(sdd->regs + S3C64XX_SPI_CS_REG);
 
-			ssel |= (S3C64XX_SPI_CS_AUTO |
-						S3C64XX_SPI_CS_NSC_CNT_2);
+			ssel |= S3C64XX_SPI_CS_AUTO |
+				FIELD_PREP(S3C64XX_SPI_CS_NSC_CNT_MASK,
+					   S3C64XX_SPI_CS_NSC_CNT_2);
 			writel(ssel, sdd->regs + S3C64XX_SPI_CS_REG);
 		}
 	} else {
@@ -666,16 +663,22 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	switch (sdd->cur_bpw) {
 	case 32:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_WORD;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_WORD;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_WORD) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_WORD);
 		break;
 	case 16:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
 		break;
 	default:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_BYTE) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_BYTE);
 		break;
 	}
 
@@ -801,7 +804,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 
 			val = readl(sdd->regs + S3C64XX_SPI_MODE_CFG);
 			val &= ~S3C64XX_SPI_MODE_RX_RDY_LVL;
-			val |= (rdy_lv << S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT);
+			val |= FIELD_PREP(S3C64XX_SPI_MODE_RX_RDY_LVL, rdy_lv);
 			writel(val, sdd->regs + S3C64XX_SPI_MODE_CFG);
 
 			/* Enable FIFO_RDY_EN IRQ */
@@ -1074,8 +1077,8 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	writel(0, regs + S3C64XX_SPI_INT_EN);
 
 	if (!sdd->port_conf->clk_from_cmu)
-		writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
-				regs + S3C64XX_SPI_CLK_CFG);
+		writel(FIELD_PREP(S3C64XX_SPI_CLKSEL_SRCMSK, sci->src_clk_nr),
+		       regs + S3C64XX_SPI_CLK_CFG);
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
 	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
 
@@ -1091,8 +1094,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
-	val &= ~(S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
-	val |= (S3C64XX_SPI_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
+	val |= S3C64XX_SPI_MAX_TRAILCNT_MASK;
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	s3c64xx_flush_fifo(sdd);
-- 
2.43.0.429.g432eaa2c6b-goog


