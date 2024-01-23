Return-Path: <linux-arch+bounces-1453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AA8392E5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6F1B20E6A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56C605A1;
	Tue, 23 Jan 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9hQwN2I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1360261
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024072; cv=none; b=mkzWEIYnV28PIDX3ZFGHs73TMdWCxmvd/uLflKQK7/e0qnQ7ZfbzQbZJx9Lh7MwD2CLdvDlth6J968QuwkQtVw6mfPiRL/R27O7wjtRgeRIyq1C8nELiBpySQKOIKN9jR1ILYuC/oZLz0bEsX9104oTb+j08cuo8BquI4l3AyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024072; c=relaxed/simple;
	bh=yG4gZxYa79HahCfvc6InRnmHlNSFjU/8GPPNK6B+dSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdSuUEL2E7jFv1ziytIOJS+MX5CwSvVSoyVS//3Zm+Rcx9OTWdUMBjdeE5xai4FwgtxBZToQpyoclDcYd3zpHow5aeRsR9w7g1nq7vO/YmyIQpNRp4R1CN+dhgljd28CSlWmYIF0UGua2vnJnO1iMmUUp16X3EYyLI6EJG3RpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9hQwN2I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso53076105e9.3
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024069; x=1706628869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OHi5EgWCeJpCVpQQS24DPa9E+cj9YStk/+6+6uJiCg=;
        b=k9hQwN2I2biGzbOtoHY5qnC5w1AVn9rzJ96gggXEarAggq1SF7rbNcPLQ+Px0ZxHQG
         IbMeFhLj+VDI1rZda7FJz/wrsIzuxZ1e8ljGSaw9b8BdD8ZKnxt6YZhxstYiMqupbnJ3
         CzziWBhjBYnGk91vYNkCpEUGfpohXjmkt8pZ2ylb14+SX2WsQ+RuZ1JRMafBa+j1UHUz
         wJ0pw3X/VScP01U7vqs2oA97ttnTHa9YEN2vNNrTzUCFf/ooEAoOfWX0QkFsDfiTUyvH
         tpeT0lazshYVXJuqzMmFBsXwyGK1gImmEMwvRlC2NmmfjNgzdVr3HG3vryXmIe9B1rXD
         a+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024069; x=1706628869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OHi5EgWCeJpCVpQQS24DPa9E+cj9YStk/+6+6uJiCg=;
        b=uB+7004zbaMLKrveYUbVaXdCCa1e6EZRpy0aAcKOsEi3wGv2e6zqx8c5ttGG763LJI
         YjlkVXQVB7mZo/ZIHLYQo9+hvYy9wCBuTGZl+3T2ROCgCtt0zWAJwwUw5tS36JLxMiHR
         0EIdAAy69czZCLXCa2rDm60FJbYZ0IE9okhmYFJOOfcpVloSyPUCxuSW6hL69IjxrE92
         pqmSWy+Dipblf5xglAwzHu0YsSmjjhxXzAEAFnBctpd3biCtuiTVVTymg3KV5tDrsUe3
         RmZYxl3y/f+tSo0o5oeZig9mxhIhphNFvTtCFjOLEuHBXhg/E6XFrbPEuYn8jhHeP8Cy
         g/Dg==
X-Gm-Message-State: AOJu0YyOexCCwa88/QFHWWPJ61d2xrqqQh3qdSgSjjAbfEkrf8VGfrvK
	LEkkRjav/PH2THaPQGVgxq9iUa7xZ+GQm+hZhXNjuyNgIbAuW5nv1KfRWlkWmfM=
X-Google-Smtp-Source: AGHT+IEW8wM8jKrmBHWu9oFzJXlcGywLUYOu5woE/V+wgfwbWwJGW6Xexs4KhMhkqwE1PVcIdJYUoQ==
X-Received: by 2002:a05:600c:2053:b0:40d:3afc:9263 with SMTP id p19-20020a05600c205300b0040d3afc9263mr175292wmg.104.1706024069457;
        Tue, 23 Jan 2024 07:34:29 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:28 -0800 (PST)
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
Subject: [PATCH 05/21] spi: s3c64xx: explicitly include <linux/bits.h>
Date: Tue, 23 Jan 2024 15:34:04 +0000
Message-ID: <20240123153421.715951-6-tudor.ambarus@linaro.org>
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

The driver uses GENMASK() but does not include <linux/bits.h>.
Include the missing header, we shall aim to have the drivers self
contained.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b350e70fd179..9ce56aa792ed 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-- 
2.43.0.429.g432eaa2c6b-goog


