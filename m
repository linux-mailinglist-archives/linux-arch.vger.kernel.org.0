Return-Path: <linux-arch+bounces-1450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4F8392D7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E1E1C23219
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABD60266;
	Tue, 23 Jan 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3EnXXao"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4B5FEF6
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024071; cv=none; b=dVUuSNleSmxyazkvayJYTzKF2cWC2W5v9kcz74DcMjDzo0jaYHggdjOqAW6GhyiNAtTszi44QLvmui1qnq/m+bsF+e7wxOGXtW/AdPUHq4Fnaf9kC+tF9TtugP8AZqsR/8+jfzsF1dHR7KDhDIdiJBoPhJy934fGyA2w2S6aWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024071; c=relaxed/simple;
	bh=ElWpxBc+uZ28K/jxG5M5DOmScKkdCa0Y4Qo25bOXlMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrG1BeJ3hL9mu/sb8xhNEYUtYpYzcJJJXqiYkBswFRD6/L3mRTW/eegxW1rYl0SLI0ZtZHxy/+iSQ8KE/nCqEKg1wamqCudhIo9WwyaXyfUEYWzAj8twOLx+sZ2QDQr5b7cN9D1V5m7odDUNqfC4wL2qa2yiGvkTEpCh/e99yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3EnXXao; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso53432275e9.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024067; x=1706628867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XigujyuTekxObecLRQT69LgHjYiW1lnxBRIg9BTFsN8=;
        b=Y3EnXXaormQRU1iecto8ieV9zhbSyWUGlEnfBMk4uZ8bI2ef0++7oA2crp5c32C/Zi
         Mt7kvW8QRxUfhLzxZLhGFOFY9VcXSYePbygA3czFdEa/6/s3sumxK8hAz8L5NKdj726Y
         A8urarvzq/GposQfe5625g7+w0jMI2dB9SMIqRGlS3/ODl/spixXLUgbxkmqVHc3Zpmw
         XGA7QnhInY36MkETvtW++s2MxgK3Uq9hhkbhKv0xkg06UahH9oIJlPCo9JNTFmj/5r4A
         Xr+X9hI8RTyiOxtDHRsxwuT7vTnrf1uxWw8nlLPM4aHNhumvLCHu12ot6S4gAnF+CgVL
         wUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024067; x=1706628867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XigujyuTekxObecLRQT69LgHjYiW1lnxBRIg9BTFsN8=;
        b=cK5QVMQ7I328n0VhPvmutljwYIzBUpn+KL0hLd4q/ZzB0sVwpB7Mtu2NVIZGwdYCJ7
         xAgTfIx167r9plppzumA2Lq72hrl/9zYdR+KTdPHqmFWDDHXXoIIbpSMglCPLmgRWsQ/
         cuWTKTY/KkPFnUPtWUSoteHyF9Ognq/7CnFiw3mX7y+svVUoxgR/N2MGBxkh0NBoG8rH
         7J/cZGWPkS1M2QO04cl2oOEe/PDNhdb9yi1bR3Gyn070+hEWRxIleetJTZk7ZSCkHbDU
         kGyb9M4MYAtnm0H15ncTZX4kNocWF8nLnE+XfFRCdN+KgConvjgpisUXAee+N8GEyJkl
         /p8w==
X-Gm-Message-State: AOJu0YwvVxZqgk4HqHgT4wes9MyX1+xm7zHrkCEOiPu/PwxOvxQSMqzB
	r1uxivEOOuyFGUHj6NgTmkbIfCM1mIKjVxemTd3npKAT7SFbEJV15o1zAiLjoa0=
X-Google-Smtp-Source: AGHT+IF1ROX3DbhMGiVBd3XC1sBuhtQqNpsdEmdhphsiT0Bhxh5GRHz0uW02UEB/+wKq7d65pkfsCQ==
X-Received: by 2002:a05:600c:3ba2:b0:40e:a328:25ff with SMTP id n34-20020a05600c3ba200b0040ea32825ffmr344127wms.93.1706024067183;
        Tue, 23 Jan 2024 07:34:27 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:26 -0800 (PST)
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
Subject: [PATCH 02/21] spi: s3c64xx: sort headers alphabetically
Date: Tue, 23 Jan 2024 15:34:01 +0000
Message-ID: <20240123153421.715951-3-tudor.ambarus@linaro.org>
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

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 432ec60d3568..187b617e3e14 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,19 +3,19 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/spi-s3c64xx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-#include <linux/of.h>
 
-#include <linux/platform_data/spi-s3c64xx.h>
 
 #define MAX_SPI_PORTS		12
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.429.g432eaa2c6b-goog


